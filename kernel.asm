
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 2e 10 80       	mov    $0x80102e80,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 80 72 10 80       	push   $0x80107280
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 e5 43 00 00       	call   80104440 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 72 10 80       	push   $0x80107287
80100097:	50                   	push   %eax
80100098:	e8 93 42 00 00       	call   80104330 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 57 44 00 00       	call   80104540 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 f9 44 00 00       	call   80104660 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 41 00 00       	call   80104370 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 8d 1f 00 00       	call   80102110 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 8e 72 10 80       	push   $0x8010728e
80100198:	e8 e3 01 00 00       	call   80100380 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 5d 42 00 00       	call   80104410 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 47 1f 00 00       	jmp    80102110 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 72 10 80       	push   $0x8010729f
801001d1:	e8 aa 01 00 00       	call   80100380 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 1c 42 00 00       	call   80104410 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 41 00 00       	call   801043d0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 30 43 00 00       	call   80104540 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 ff 43 00 00       	jmp    80104660 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 72 10 80       	push   $0x801072a6
80100269:	e8 12 01 00 00       	call   80100380 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 db 14 00 00       	call   80101760 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 af 42 00 00       	call   80104540 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a2 00 00 00    	jle    80100343 <consoleread+0xd3>
    while(input.r == input.w){
801002a1:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002a6:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 60                	jmp    80100310 <consoleread+0xa0>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 a0 ff 10 80       	push   $0x8010ffa0
801002bd:	e8 de 3c 00 00       	call   80103fa0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d0:	75 3e                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002d2:	e8 d9 34 00 00       	call   801037b0 <myproc>
801002d7:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
801002dd:	85 c0                	test   %eax,%eax
801002df:	74 cf                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002e1:	83 ec 0c             	sub    $0xc,%esp
801002e4:	68 20 a5 10 80       	push   $0x8010a520
801002e9:	e8 72 43 00 00       	call   80104660 <release>
        ilock(ip);
801002ee:	89 3c 24             	mov    %edi,(%esp)
801002f1:	e8 8a 13 00 00       	call   80101680 <ilock>
        return -1;
801002f6:	83 c4 10             	add    $0x10,%esp
801002f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100301:	5b                   	pop    %ebx
80100302:	5e                   	pop    %esi
80100303:	5f                   	pop    %edi
80100304:	5d                   	pop    %ebp
80100305:	c3                   	ret    
80100306:	8d 76 00             	lea    0x0(%esi),%esi
80100309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 50 01             	lea    0x1(%eax),%edx
80100313:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100319:	89 c2                	mov    %eax,%edx
8010031b:	83 e2 7f             	and    $0x7f,%edx
8010031e:	0f be 92 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%edx
    if(c == C('D')){  // EOF
80100325:	83 fa 04             	cmp    $0x4,%edx
80100328:	74 39                	je     80100363 <consoleread+0xf3>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032a:	83 c6 01             	add    $0x1,%esi
    --n;
8010032d:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100330:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100333:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
80100336:	74 35                	je     8010036d <consoleread+0xfd>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100338:	85 db                	test   %ebx,%ebx
8010033a:	0f 85 61 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100340:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
80100343:	83 ec 0c             	sub    $0xc,%esp
80100346:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100349:	68 20 a5 10 80       	push   $0x8010a520
8010034e:	e8 0d 43 00 00       	call   80104660 <release>
  ilock(ip);
80100353:	89 3c 24             	mov    %edi,(%esp)
80100356:	e8 25 13 00 00       	call   80101680 <ilock>

  return target - n;
8010035b:	83 c4 10             	add    $0x10,%esp
8010035e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100361:	eb 9b                	jmp    801002fe <consoleread+0x8e>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
80100363:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80100366:	76 05                	jbe    8010036d <consoleread+0xfd>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100368:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
8010036d:	8b 45 10             	mov    0x10(%ebp),%eax
80100370:	29 d8                	sub    %ebx,%eax
80100372:	eb cf                	jmp    80100343 <consoleread+0xd3>
80100374:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010037a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100380 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100389:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100390:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 72 23 00 00       	call   80102710 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 ad 72 10 80       	push   $0x801072ad
801003a7:	e8 c4 02 00 00       	call   80100670 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	pushl  0x8(%ebp)
801003b0:	e8 bb 02 00 00       	call   80100670 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 03 7c 10 80 	movl   $0x80107c03,(%esp)
801003bc:	e8 af 02 00 00       	call   80100670 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	5a                   	pop    %edx
801003c2:	8d 45 08             	lea    0x8(%ebp),%eax
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 93 40 00 00       	call   80104460 <getcallerpcs>
801003cd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	pushl  (%ebx)
801003d5:	83 c3 04             	add    $0x4,%ebx
801003d8:	68 c1 72 10 80       	push   $0x801072c1
801003dd:	e8 8e 02 00 00       	call   80100670 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003f0:	00 00 00 
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100400 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
80100400:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100406:	85 d2                	test   %edx,%edx
80100408:	74 06                	je     80100410 <consputc+0x10>
8010040a:	fa                   	cli    
8010040b:	eb fe                	jmp    8010040b <consputc+0xb>
8010040d:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 b8 00 00 00    	je     801004de <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 11 5a 00 00       	call   80105e40 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100444:	89 f2                	mov    %esi,%edx
80100446:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100447:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c1                	mov    %eax,%ecx
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100457:	89 f2                	mov    %esi,%edx
80100459:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010045f:	83 fb 0a             	cmp    $0xa,%ebx
80100462:	0f 84 0b 01 00 00    	je     80100573 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100468:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046e:	0f 84 e6 00 00 00    	je     8010055a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100474:	0f b6 d3             	movzbl %bl,%edx
80100477:	8d 78 01             	lea    0x1(%eax),%edi
8010047a:	80 ce 07             	or     $0x7,%dh
8010047d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100484:	80 

  if(pos < 0 || pos > 25*80)
80100485:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010048b:	0f 8f bc 00 00 00    	jg     8010054d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100491:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100497:	7f 6f                	jg     80100508 <consputc+0x108>
80100499:	89 f8                	mov    %edi,%eax
8010049b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
801004a2:	89 fb                	mov    %edi,%ebx
801004a4:	c1 e8 08             	shr    $0x8,%eax
801004a7:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004a9:	bf d4 03 00 00       	mov    $0x3d4,%edi
801004ae:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 f0                	mov    %esi,%eax
801004bd:	ee                   	out    %al,(%dx)
801004be:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c3:	89 fa                	mov    %edi,%edx
801004c5:	ee                   	out    %al,(%dx)
801004c6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004cb:	89 d8                	mov    %ebx,%eax
801004cd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004ce:	b8 20 07 00 00       	mov    $0x720,%eax
801004d3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d9:	5b                   	pop    %ebx
801004da:	5e                   	pop    %esi
801004db:	5f                   	pop    %edi
801004dc:	5d                   	pop    %ebp
801004dd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004de:	83 ec 0c             	sub    $0xc,%esp
801004e1:	6a 08                	push   $0x8
801004e3:	e8 58 59 00 00       	call   80105e40 <uartputc>
801004e8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004ef:	e8 4c 59 00 00       	call   80105e40 <uartputc>
801004f4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004fb:	e8 40 59 00 00       	call   80105e40 <uartputc>
80100500:	83 c4 10             	add    $0x10,%esp
80100503:	e9 2a ff ff ff       	jmp    80100432 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100508:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
8010050b:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010050e:	68 60 0e 00 00       	push   $0xe60
80100513:	68 a0 80 0b 80       	push   $0x800b80a0
80100518:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010051d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100524:	e8 37 42 00 00       	call   80104760 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	6a 00                	push   $0x0
80100538:	56                   	push   %esi
80100539:	e8 72 41 00 00       	call   801046b0 <memset>
8010053e:	89 f1                	mov    %esi,%ecx
80100540:	83 c4 10             	add    $0x10,%esp
80100543:	be 07 00 00 00       	mov    $0x7,%esi
80100548:	e9 5c ff ff ff       	jmp    801004a9 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010054d:	83 ec 0c             	sub    $0xc,%esp
80100550:	68 c5 72 10 80       	push   $0x801072c5
80100555:	e8 26 fe ff ff       	call   80100380 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010055a:	85 c0                	test   %eax,%eax
8010055c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010055f:	0f 85 20 ff ff ff    	jne    80100485 <consputc+0x85>
80100565:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010056a:	31 db                	xor    %ebx,%ebx
8010056c:	31 f6                	xor    %esi,%esi
8010056e:	e9 36 ff ff ff       	jmp    801004a9 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100573:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100578:	f7 ea                	imul   %edx
8010057a:	89 d0                	mov    %edx,%eax
8010057c:	c1 e8 05             	shr    $0x5,%eax
8010057f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100582:	c1 e0 04             	shl    $0x4,%eax
80100585:	8d 78 50             	lea    0x50(%eax),%edi
80100588:	e9 f8 fe ff ff       	jmp    80100485 <consputc+0x85>
8010058d:	8d 76 00             	lea    0x0(%esi),%esi

80100590 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	89 d6                	mov    %edx,%esi
80100598:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010059b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010059d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005a0:	74 0c                	je     801005ae <printint+0x1e>
801005a2:	89 c7                	mov    %eax,%edi
801005a4:	c1 ef 1f             	shr    $0x1f,%edi
801005a7:	85 c0                	test   %eax,%eax
801005a9:	89 7d d4             	mov    %edi,-0x2c(%ebp)
801005ac:	78 51                	js     801005ff <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
801005ae:	31 ff                	xor    %edi,%edi
801005b0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005b3:	eb 05                	jmp    801005ba <printint+0x2a>
801005b5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005b8:	89 cf                	mov    %ecx,%edi
801005ba:	31 d2                	xor    %edx,%edx
801005bc:	8d 4f 01             	lea    0x1(%edi),%ecx
801005bf:	f7 f6                	div    %esi
801005c1:	0f b6 92 f0 72 10 80 	movzbl -0x7fef8d10(%edx),%edx
  }while((x /= base) != 0);
801005c8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ca:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005cd:	75 e9                	jne    801005b8 <printint+0x28>

  if(sign)
801005cf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005d2:	85 c0                	test   %eax,%eax
801005d4:	74 08                	je     801005de <printint+0x4e>
    buf[i++] = '-';
801005d6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005db:	8d 4f 02             	lea    0x2(%edi),%ecx
801005de:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005e8:	0f be 06             	movsbl (%esi),%eax
801005eb:	83 ee 01             	sub    $0x1,%esi
801005ee:	e8 0d fe ff ff       	call   80100400 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005f3:	39 de                	cmp    %ebx,%esi
801005f5:	75 f1                	jne    801005e8 <printint+0x58>
    consputc(buf[i]);
}
801005f7:	83 c4 2c             	add    $0x2c,%esp
801005fa:	5b                   	pop    %ebx
801005fb:	5e                   	pop    %esi
801005fc:	5f                   	pop    %edi
801005fd:	5d                   	pop    %ebp
801005fe:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ff:	f7 d8                	neg    %eax
80100601:	eb ab                	jmp    801005ae <printint+0x1e>
80100603:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100610 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100610:	55                   	push   %ebp
80100611:	89 e5                	mov    %esp,%ebp
80100613:	57                   	push   %edi
80100614:	56                   	push   %esi
80100615:	53                   	push   %ebx
80100616:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100619:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010061c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010061f:	e8 3c 11 00 00       	call   80101760 <iunlock>
  acquire(&cons.lock);
80100624:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010062b:	e8 10 3f 00 00       	call   80104540 <acquire>
80100630:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100633:	83 c4 10             	add    $0x10,%esp
80100636:	85 f6                	test   %esi,%esi
80100638:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010063b:	7e 12                	jle    8010064f <consolewrite+0x3f>
8010063d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100640:	0f b6 07             	movzbl (%edi),%eax
80100643:	83 c7 01             	add    $0x1,%edi
80100646:	e8 b5 fd ff ff       	call   80100400 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010064b:	39 df                	cmp    %ebx,%edi
8010064d:	75 f1                	jne    80100640 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010064f:	83 ec 0c             	sub    $0xc,%esp
80100652:	68 20 a5 10 80       	push   $0x8010a520
80100657:	e8 04 40 00 00       	call   80104660 <release>
  ilock(ip);
8010065c:	58                   	pop    %eax
8010065d:	ff 75 08             	pushl  0x8(%ebp)
80100660:	e8 1b 10 00 00       	call   80101680 <ilock>

  return n;
}
80100665:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100668:	89 f0                	mov    %esi,%eax
8010066a:	5b                   	pop    %ebx
8010066b:	5e                   	pop    %esi
8010066c:	5f                   	pop    %edi
8010066d:	5d                   	pop    %ebp
8010066e:	c3                   	ret    
8010066f:	90                   	nop

80100670 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100670:	55                   	push   %ebp
80100671:	89 e5                	mov    %esp,%ebp
80100673:	57                   	push   %edi
80100674:	56                   	push   %esi
80100675:	53                   	push   %ebx
80100676:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100679:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010067e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100680:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100683:	0f 85 47 01 00 00    	jne    801007d0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100689:	8b 45 08             	mov    0x8(%ebp),%eax
8010068c:	85 c0                	test   %eax,%eax
8010068e:	89 c1                	mov    %eax,%ecx
80100690:	0f 84 4f 01 00 00    	je     801007e5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100696:	0f b6 00             	movzbl (%eax),%eax
80100699:	31 db                	xor    %ebx,%ebx
8010069b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010069e:	89 cf                	mov    %ecx,%edi
801006a0:	85 c0                	test   %eax,%eax
801006a2:	75 55                	jne    801006f9 <cprintf+0x89>
801006a4:	eb 68                	jmp    8010070e <cprintf+0x9e>
801006a6:	8d 76 00             	lea    0x0(%esi),%esi
801006a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006b0:	83 c3 01             	add    $0x1,%ebx
801006b3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006b7:	85 d2                	test   %edx,%edx
801006b9:	74 53                	je     8010070e <cprintf+0x9e>
      break;
    switch(c){
801006bb:	83 fa 70             	cmp    $0x70,%edx
801006be:	74 7a                	je     8010073a <cprintf+0xca>
801006c0:	7f 6e                	jg     80100730 <cprintf+0xc0>
801006c2:	83 fa 25             	cmp    $0x25,%edx
801006c5:	0f 84 ad 00 00 00    	je     80100778 <cprintf+0x108>
801006cb:	83 fa 64             	cmp    $0x64,%edx
801006ce:	0f 85 84 00 00 00    	jne    80100758 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006d4:	8d 46 04             	lea    0x4(%esi),%eax
801006d7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006dc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006e4:	8b 06                	mov    (%esi),%eax
801006e6:	e8 a5 fe ff ff       	call   80100590 <printint>
801006eb:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ee:	83 c3 01             	add    $0x1,%ebx
801006f1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006f5:	85 c0                	test   %eax,%eax
801006f7:	74 15                	je     8010070e <cprintf+0x9e>
    if(c != '%'){
801006f9:	83 f8 25             	cmp    $0x25,%eax
801006fc:	74 b2                	je     801006b0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006fe:	e8 fd fc ff ff       	call   80100400 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100703:	83 c3 01             	add    $0x1,%ebx
80100706:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
8010070a:	85 c0                	test   %eax,%eax
8010070c:	75 eb                	jne    801006f9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
8010070e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100711:	85 c0                	test   %eax,%eax
80100713:	74 10                	je     80100725 <cprintf+0xb5>
    release(&cons.lock);
80100715:	83 ec 0c             	sub    $0xc,%esp
80100718:	68 20 a5 10 80       	push   $0x8010a520
8010071d:	e8 3e 3f 00 00       	call   80104660 <release>
80100722:	83 c4 10             	add    $0x10,%esp
}
80100725:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100728:	5b                   	pop    %ebx
80100729:	5e                   	pop    %esi
8010072a:	5f                   	pop    %edi
8010072b:	5d                   	pop    %ebp
8010072c:	c3                   	ret    
8010072d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 5b                	je     80100790 <cprintf+0x120>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010073a:	8d 46 04             	lea    0x4(%esi),%eax
8010073d:	31 c9                	xor    %ecx,%ecx
8010073f:	ba 10 00 00 00       	mov    $0x10,%edx
80100744:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100747:	8b 06                	mov    (%esi),%eax
80100749:	e8 42 fe ff ff       	call   80100590 <printint>
8010074e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100751:	eb 9b                	jmp    801006ee <cprintf+0x7e>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100760:	e8 9b fc ff ff       	call   80100400 <consputc>
      consputc(c);
80100765:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 91 fc ff ff       	call   80100400 <consputc>
      break;
8010076f:	e9 7a ff ff ff       	jmp    801006ee <cprintf+0x7e>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100778:	b8 25 00 00 00       	mov    $0x25,%eax
8010077d:	e8 7e fc ff ff       	call   80100400 <consputc>
80100782:	e9 7c ff ff ff       	jmp    80100703 <cprintf+0x93>
80100787:	89 f6                	mov    %esi,%esi
80100789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100790:	8d 46 04             	lea    0x4(%esi),%eax
80100793:	8b 36                	mov    (%esi),%esi
80100795:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100798:	b8 d8 72 10 80       	mov    $0x801072d8,%eax
8010079d:	85 f6                	test   %esi,%esi
8010079f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
801007a2:	0f be 06             	movsbl (%esi),%eax
801007a5:	84 c0                	test   %al,%al
801007a7:	74 16                	je     801007bf <cprintf+0x14f>
801007a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007b0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007b3:	e8 48 fc ff ff       	call   80100400 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007b8:	0f be 06             	movsbl (%esi),%eax
801007bb:	84 c0                	test   %al,%al
801007bd:	75 f1                	jne    801007b0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007bf:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007c2:	e9 27 ff ff ff       	jmp    801006ee <cprintf+0x7e>
801007c7:	89 f6                	mov    %esi,%esi
801007c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007d0:	83 ec 0c             	sub    $0xc,%esp
801007d3:	68 20 a5 10 80       	push   $0x8010a520
801007d8:	e8 63 3d 00 00       	call   80104540 <acquire>
801007dd:	83 c4 10             	add    $0x10,%esp
801007e0:	e9 a4 fe ff ff       	jmp    80100689 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007e5:	83 ec 0c             	sub    $0xc,%esp
801007e8:	68 df 72 10 80       	push   $0x801072df
801007ed:	e8 8e fb ff ff       	call   80100380 <panic>
801007f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100800 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100800:	55                   	push   %ebp
80100801:	89 e5                	mov    %esp,%ebp
80100803:	57                   	push   %edi
80100804:	56                   	push   %esi
80100805:	53                   	push   %ebx
  int c, doprocdump = 0;
80100806:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100808:	83 ec 18             	sub    $0x18,%esp
8010080b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
8010080e:	68 20 a5 10 80       	push   $0x8010a520
80100813:	e8 28 3d 00 00       	call   80104540 <acquire>
  while((c = getc()) >= 0){
80100818:	83 c4 10             	add    $0x10,%esp
8010081b:	90                   	nop
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100820:	ff d3                	call   *%ebx
80100822:	85 c0                	test   %eax,%eax
80100824:	89 c7                	mov    %eax,%edi
80100826:	78 48                	js     80100870 <consoleintr+0x70>
    switch(c){
80100828:	83 ff 10             	cmp    $0x10,%edi
8010082b:	0f 84 3f 01 00 00    	je     80100970 <consoleintr+0x170>
80100831:	7e 5d                	jle    80100890 <consoleintr+0x90>
80100833:	83 ff 15             	cmp    $0x15,%edi
80100836:	0f 84 dc 00 00 00    	je     80100918 <consoleintr+0x118>
8010083c:	83 ff 7f             	cmp    $0x7f,%edi
8010083f:	75 54                	jne    80100895 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100841:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100846:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010084c:	74 d2                	je     80100820 <consoleintr+0x20>
        input.e--;
8010084e:	83 e8 01             	sub    $0x1,%eax
80100851:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100856:	b8 00 01 00 00       	mov    $0x100,%eax
8010085b:	e8 a0 fb ff ff       	call   80100400 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100860:	ff d3                	call   *%ebx
80100862:	85 c0                	test   %eax,%eax
80100864:	89 c7                	mov    %eax,%edi
80100866:	79 c0                	jns    80100828 <consoleintr+0x28>
80100868:	90                   	nop
80100869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 20 a5 10 80       	push   $0x8010a520
80100878:	e8 e3 3d 00 00       	call   80104660 <release>
  if(doprocdump) {
8010087d:	83 c4 10             	add    $0x10,%esp
80100880:	85 f6                	test   %esi,%esi
80100882:	0f 85 f8 00 00 00    	jne    80100980 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100888:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010088b:	5b                   	pop    %ebx
8010088c:	5e                   	pop    %esi
8010088d:	5f                   	pop    %edi
8010088e:	5d                   	pop    %ebp
8010088f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100890:	83 ff 08             	cmp    $0x8,%edi
80100893:	74 ac                	je     80100841 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100895:	85 ff                	test   %edi,%edi
80100897:	74 87                	je     80100820 <consoleintr+0x20>
80100899:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010089e:	89 c2                	mov    %eax,%edx
801008a0:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008a6:	83 fa 7f             	cmp    $0x7f,%edx
801008a9:	0f 87 71 ff ff ff    	ja     80100820 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801008af:	8d 50 01             	lea    0x1(%eax),%edx
801008b2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008b5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008b8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008be:	0f 84 c8 00 00 00    	je     8010098c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008c4:	89 f9                	mov    %edi,%ecx
801008c6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008cc:	89 f8                	mov    %edi,%eax
801008ce:	e8 2d fb ff ff       	call   80100400 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008d3:	83 ff 0a             	cmp    $0xa,%edi
801008d6:	0f 84 c1 00 00 00    	je     8010099d <consoleintr+0x19d>
801008dc:	83 ff 04             	cmp    $0x4,%edi
801008df:	0f 84 b8 00 00 00    	je     8010099d <consoleintr+0x19d>
801008e5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008ea:	83 e8 80             	sub    $0xffffff80,%eax
801008ed:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801008f3:	0f 85 27 ff ff ff    	jne    80100820 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008f9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008fc:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100901:	68 a0 ff 10 80       	push   $0x8010ffa0
80100906:	e8 75 38 00 00       	call   80104180 <wakeup>
8010090b:	83 c4 10             	add    $0x10,%esp
8010090e:	e9 0d ff ff ff       	jmp    80100820 <consoleintr+0x20>
80100913:	90                   	nop
80100914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100918:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010091d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100923:	75 2b                	jne    80100950 <consoleintr+0x150>
80100925:	e9 f6 fe ff ff       	jmp    80100820 <consoleintr+0x20>
8010092a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100930:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100935:	b8 00 01 00 00       	mov    $0x100,%eax
8010093a:	e8 c1 fa ff ff       	call   80100400 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010093f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100944:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010094a:	0f 84 d0 fe ff ff    	je     80100820 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100950:	83 e8 01             	sub    $0x1,%eax
80100953:	89 c2                	mov    %eax,%edx
80100955:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100958:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010095f:	75 cf                	jne    80100930 <consoleintr+0x130>
80100961:	e9 ba fe ff ff       	jmp    80100820 <consoleintr+0x20>
80100966:	8d 76 00             	lea    0x0(%esi),%esi
80100969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100970:	be 01 00 00 00       	mov    $0x1,%esi
80100975:	e9 a6 fe ff ff       	jmp    80100820 <consoleintr+0x20>
8010097a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100980:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100983:	5b                   	pop    %ebx
80100984:	5e                   	pop    %esi
80100985:	5f                   	pop    %edi
80100986:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100987:	e9 e4 38 00 00       	jmp    80104270 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010098c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100993:	b8 0a 00 00 00       	mov    $0xa,%eax
80100998:	e8 63 fa ff ff       	call   80100400 <consputc>
8010099d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009a2:	e9 52 ff ff ff       	jmp    801008f9 <consoleintr+0xf9>
801009a7:	89 f6                	mov    %esi,%esi
801009a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009b0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009b0:	55                   	push   %ebp
801009b1:	89 e5                	mov    %esp,%ebp
801009b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009b6:	68 e8 72 10 80       	push   $0x801072e8
801009bb:	68 20 a5 10 80       	push   $0x8010a520
801009c0:	e8 7b 3a 00 00       	call   80104440 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009c5:	58                   	pop    %eax
801009c6:	5a                   	pop    %edx
801009c7:	6a 00                	push   $0x0
801009c9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009cb:	c7 05 6c 09 11 80 10 	movl   $0x80100610,0x8011096c
801009d2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009d5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009dc:	02 10 80 
  cons.locking = 1;
801009df:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009e6:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009e9:	e8 d2 18 00 00       	call   801022c0 <ioapicenable>
}
801009ee:	83 c4 10             	add    $0x10,%esp
801009f1:	c9                   	leave  
801009f2:	c3                   	ret    
801009f3:	66 90                	xchg   %ax,%ax
801009f5:	66 90                	xchg   %ax,%ax
801009f7:	66 90                	xchg   %ax,%ax
801009f9:	66 90                	xchg   %ax,%ax
801009fb:	66 90                	xchg   %ax,%ax
801009fd:	66 90                	xchg   %ax,%ax
801009ff:	90                   	nop

80100a00 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a00:	55                   	push   %ebp
80100a01:	89 e5                	mov    %esp,%ebp
80100a03:	57                   	push   %edi
80100a04:	56                   	push   %esi
80100a05:	53                   	push   %ebx
80100a06:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a0c:	e8 9f 2d 00 00       	call   801037b0 <myproc>
80100a11:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a17:	e8 54 21 00 00       	call   80102b70 <begin_op>

  if((ip = namei(path)) == 0){
80100a1c:	83 ec 0c             	sub    $0xc,%esp
80100a1f:	ff 75 08             	pushl  0x8(%ebp)
80100a22:	e8 b9 14 00 00       	call   80101ee0 <namei>
80100a27:	83 c4 10             	add    $0x10,%esp
80100a2a:	85 c0                	test   %eax,%eax
80100a2c:	0f 84 9c 01 00 00    	je     80100bce <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a32:	83 ec 0c             	sub    $0xc,%esp
80100a35:	89 c3                	mov    %eax,%ebx
80100a37:	50                   	push   %eax
80100a38:	e8 43 0c 00 00       	call   80101680 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a3d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a43:	6a 34                	push   $0x34
80100a45:	6a 00                	push   $0x0
80100a47:	50                   	push   %eax
80100a48:	53                   	push   %ebx
80100a49:	e8 12 0f 00 00       	call   80101960 <readi>
80100a4e:	83 c4 20             	add    $0x20,%esp
80100a51:	83 f8 34             	cmp    $0x34,%eax
80100a54:	74 22                	je     80100a78 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a56:	83 ec 0c             	sub    $0xc,%esp
80100a59:	53                   	push   %ebx
80100a5a:	e8 b1 0e 00 00       	call   80101910 <iunlockput>
    end_op();
80100a5f:	e8 7c 21 00 00       	call   80102be0 <end_op>
80100a64:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a6f:	5b                   	pop    %ebx
80100a70:	5e                   	pop    %esi
80100a71:	5f                   	pop    %edi
80100a72:	5d                   	pop    %ebp
80100a73:	c3                   	ret    
80100a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a78:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a7f:	45 4c 46 
80100a82:	75 d2                	jne    80100a56 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a84:	e8 47 65 00 00       	call   80106fd0 <setupkvm>
80100a89:	85 c0                	test   %eax,%eax
80100a8b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a91:	74 c3                	je     80100a56 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a93:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a9a:	00 
80100a9b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100aa1:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100aa8:	00 00 00 
80100aab:	0f 84 c5 00 00 00    	je     80100b76 <exec+0x176>
80100ab1:	31 ff                	xor    %edi,%edi
80100ab3:	eb 18                	jmp    80100acd <exec+0xcd>
80100ab5:	8d 76 00             	lea    0x0(%esi),%esi
80100ab8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100abf:	83 c7 01             	add    $0x1,%edi
80100ac2:	83 c6 20             	add    $0x20,%esi
80100ac5:	39 f8                	cmp    %edi,%eax
80100ac7:	0f 8e a9 00 00 00    	jle    80100b76 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100acd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ad3:	6a 20                	push   $0x20
80100ad5:	56                   	push   %esi
80100ad6:	50                   	push   %eax
80100ad7:	53                   	push   %ebx
80100ad8:	e8 83 0e 00 00       	call   80101960 <readi>
80100add:	83 c4 10             	add    $0x10,%esp
80100ae0:	83 f8 20             	cmp    $0x20,%eax
80100ae3:	75 7b                	jne    80100b60 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ae5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100aec:	75 ca                	jne    80100ab8 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100aee:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100af4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100afa:	72 64                	jb     80100b60 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100afc:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b02:	72 5c                	jb     80100b60 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b04:	83 ec 04             	sub    $0x4,%esp
80100b07:	50                   	push   %eax
80100b08:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100b0e:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b14:	e8 07 63 00 00       	call   80106e20 <allocuvm>
80100b19:	83 c4 10             	add    $0x10,%esp
80100b1c:	85 c0                	test   %eax,%eax
80100b1e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b24:	74 3a                	je     80100b60 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b26:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b2c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b31:	75 2d                	jne    80100b60 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b33:	83 ec 0c             	sub    $0xc,%esp
80100b36:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b3c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b42:	53                   	push   %ebx
80100b43:	50                   	push   %eax
80100b44:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b4a:	e8 11 62 00 00       	call   80106d60 <loaduvm>
80100b4f:	83 c4 20             	add    $0x20,%esp
80100b52:	85 c0                	test   %eax,%eax
80100b54:	0f 89 5e ff ff ff    	jns    80100ab8 <exec+0xb8>
80100b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b60:	83 ec 0c             	sub    $0xc,%esp
80100b63:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b69:	e8 e2 63 00 00       	call   80106f50 <freevm>
80100b6e:	83 c4 10             	add    $0x10,%esp
80100b71:	e9 e0 fe ff ff       	jmp    80100a56 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b76:	83 ec 0c             	sub    $0xc,%esp
80100b79:	53                   	push   %ebx
80100b7a:	e8 91 0d 00 00       	call   80101910 <iunlockput>
  end_op();
80100b7f:	e8 5c 20 00 00       	call   80102be0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b84:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b8a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b8d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b92:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b97:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b9d:	52                   	push   %edx
80100b9e:	50                   	push   %eax
80100b9f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100ba5:	e8 76 62 00 00       	call   80106e20 <allocuvm>
80100baa:	83 c4 10             	add    $0x10,%esp
80100bad:	85 c0                	test   %eax,%eax
80100baf:	89 c6                	mov    %eax,%esi
80100bb1:	75 3a                	jne    80100bed <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100bb3:	83 ec 0c             	sub    $0xc,%esp
80100bb6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bbc:	e8 8f 63 00 00       	call   80106f50 <freevm>
80100bc1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bc4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc9:	e9 9e fe ff ff       	jmp    80100a6c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bce:	e8 0d 20 00 00       	call   80102be0 <end_op>
    cprintf("exec: fail\n");
80100bd3:	83 ec 0c             	sub    $0xc,%esp
80100bd6:	68 01 73 10 80       	push   $0x80107301
80100bdb:	e8 90 fa ff ff       	call   80100670 <cprintf>
    return -1;
80100be0:	83 c4 10             	add    $0x10,%esp
80100be3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100be8:	e9 7f fe ff ff       	jmp    80100a6c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bed:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bf6:	31 ff                	xor    %edi,%edi
80100bf8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bfa:	50                   	push   %eax
80100bfb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c01:	e8 6a 64 00 00       	call   80107070 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c06:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c09:	83 c4 10             	add    $0x10,%esp
80100c0c:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c12:	8b 00                	mov    (%eax),%eax
80100c14:	85 c0                	test   %eax,%eax
80100c16:	74 79                	je     80100c91 <exec+0x291>
80100c18:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c1e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c24:	eb 13                	jmp    80100c39 <exec+0x239>
80100c26:	8d 76 00             	lea    0x0(%esi),%esi
80100c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	0f 84 7a ff ff ff    	je     80100bb3 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c39:	83 ec 0c             	sub    $0xc,%esp
80100c3c:	50                   	push   %eax
80100c3d:	e8 ae 3c 00 00       	call   801048f0 <strlen>
80100c42:	f7 d0                	not    %eax
80100c44:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c46:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c49:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c4a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c4d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c50:	e8 9b 3c 00 00       	call   801048f0 <strlen>
80100c55:	83 c0 01             	add    $0x1,%eax
80100c58:	50                   	push   %eax
80100c59:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c5c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5f:	53                   	push   %ebx
80100c60:	56                   	push   %esi
80100c61:	e8 6a 65 00 00       	call   801071d0 <copyout>
80100c66:	83 c4 20             	add    $0x20,%esp
80100c69:	85 c0                	test   %eax,%eax
80100c6b:	0f 88 42 ff ff ff    	js     80100bb3 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c71:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c74:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c7b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c7e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c84:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c87:	85 c0                	test   %eax,%eax
80100c89:	75 a5                	jne    80100c30 <exec+0x230>
80100c8b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c91:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c98:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c9a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100ca1:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100ca5:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100cac:	ff ff ff 
  ustack[1] = argc;
80100caf:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb5:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100cb7:	83 c0 0c             	add    $0xc,%eax
80100cba:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cbc:	50                   	push   %eax
80100cbd:	52                   	push   %edx
80100cbe:	53                   	push   %ebx
80100cbf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ccb:	e8 00 65 00 00       	call   801071d0 <copyout>
80100cd0:	83 c4 10             	add    $0x10,%esp
80100cd3:	85 c0                	test   %eax,%eax
80100cd5:	0f 88 d8 fe ff ff    	js     80100bb3 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cdb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cde:	0f b6 10             	movzbl (%eax),%edx
80100ce1:	84 d2                	test   %dl,%dl
80100ce3:	74 19                	je     80100cfe <exec+0x2fe>
80100ce5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100ce8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100ceb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cee:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100cf1:	0f 44 c8             	cmove  %eax,%ecx
80100cf4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cf7:	84 d2                	test   %dl,%dl
80100cf9:	75 f0                	jne    80100ceb <exec+0x2eb>
80100cfb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cfe:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100d04:	50                   	push   %eax
80100d05:	6a 10                	push   $0x10
80100d07:	ff 75 08             	pushl  0x8(%ebp)
80100d0a:	89 f8                	mov    %edi,%eax
80100d0c:	05 d0 00 00 00       	add    $0xd0,%eax
80100d11:	50                   	push   %eax
80100d12:	e8 99 3b 00 00       	call   801048b0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d17:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d1d:	89 f8                	mov    %edi,%eax
  curproc->pgdir = pgdir;
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d1f:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d25:	8b 7f 60             	mov    0x60(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d28:	89 70 5c             	mov    %esi,0x5c(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d2b:	89 48 60             	mov    %ecx,0x60(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d2e:	89 c1                	mov    %eax,%ecx
80100d30:	8b 40 7c             	mov    0x7c(%eax),%eax
80100d33:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d36:	8b 41 7c             	mov    0x7c(%ecx),%eax
80100d39:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d3c:	89 0c 24             	mov    %ecx,(%esp)
80100d3f:	e8 8c 5e 00 00       	call   80106bd0 <switchuvm>
  freevm(oldpgdir);
80100d44:	89 3c 24             	mov    %edi,(%esp)
80100d47:	e8 04 62 00 00       	call   80106f50 <freevm>
  return 0;
80100d4c:	83 c4 10             	add    $0x10,%esp
80100d4f:	31 c0                	xor    %eax,%eax
80100d51:	e9 16 fd ff ff       	jmp    80100a6c <exec+0x6c>
80100d56:	66 90                	xchg   %ax,%ax
80100d58:	66 90                	xchg   %ax,%ax
80100d5a:	66 90                	xchg   %ax,%ax
80100d5c:	66 90                	xchg   %ax,%ax
80100d5e:	66 90                	xchg   %ax,%ax

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 0d 73 10 80       	push   $0x8010730d
80100d6b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d70:	e8 cb 36 00 00       	call   80104440 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d8c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d91:	e8 aa 37 00 00       	call   80104540 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100da9:	74 25                	je     80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc1:	e8 9a 38 00 00       	call   80104660 <release>
      return f;
80100dc6:	89 d8                	mov    %ebx,%eax
80100dc8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
80100dd3:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dd8:	e8 83 38 00 00       	call   80104660 <release>
  return 0;
80100ddd:	83 c4 10             	add    $0x10,%esp
80100de0:	31 c0                	xor    %eax,%eax
}
80100de2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de5:	c9                   	leave  
80100de6:	c3                   	ret    
80100de7:	89 f6                	mov    %esi,%esi
80100de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dff:	e8 3c 37 00 00       	call   80104540 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e1c:	e8 3f 38 00 00       	call   80104660 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 14 73 10 80       	push   $0x80107314
80100e30:	e8 4b f5 ff ff       	call   80100380 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e51:	e8 ea 36 00 00       	call   80104540 <acquire>
  if(f->ref < 1)
80100e56:	8b 47 04             	mov    0x4(%edi),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 47 04             	mov    %eax,0x4(%edi)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e7c:	e9 df 37 00 00       	jmp    80104660 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e88:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e8c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e91:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e94:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ea0:	68 c0 ff 10 80       	push   $0x8010ffc0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ea8:	e8 b3 37 00 00       	call   80104660 <release>

  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 fb 01             	cmp    $0x1,%ebx
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100eb5:	83 fb 02             	cmp    $0x2,%ebx
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 3a 24 00 00       	call   80103310 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ee0:	e8 8b 1c 00 00       	call   80102b70 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 c0 08 00 00       	call   801017b0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100efa:	e9 e1 1c 00 00       	jmp    80102be0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 1c 73 10 80       	push   $0x8010731c
80100f07:	e8 74 f4 ff ff       	call   80100380 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 56 07 00 00       	call   80101680 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 f9 09 00 00       	call   80101930 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 20 08 00 00       	call   80101760 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f58:	c9                   	leave  
80100f59:	c3                   	ret    
80100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 f1 06 00 00       	call   80101680 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 c4 09 00 00       	call   80101960 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 ad 07 00 00       	call   80101760 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fb6:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fcd:	e9 de 24 00 00       	jmp    801034b0 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fdd:	eb d9                	jmp    80100fb8 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 26 73 10 80       	push   $0x80107326
80100fe7:	e8 94 f3 ff ff       	call   80100380 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c2 00 00 00    	je     801010df <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d8 00 00 00    	jne    801010fe <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101029:	31 ff                	xor    %edi,%edi
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 17 07 00 00       	call   80101760 <iunlock>
      end_op();
80101049:	e8 92 1b 00 00       	call   80102be0 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 d8                	cmp    %ebx,%eax
80101056:	0f 85 95 00 00 00    	jne    801010f1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010105c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101076:	e8 f5 1a 00 00       	call   80102b70 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 fa 05 00 00       	call   80101680 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 c8 09 00 00       	call   80101a60 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 b3 06 00 00       	call   80101760 <iunlock>
      end_op();
801010ad:	e8 2e 1b 00 00       	call   80102be0 <end_op>

      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801010c4:	5b                   	pop    %ebx
801010c5:	5e                   	pop    %esi
801010c6:	5f                   	pop    %edi
801010c7:	5d                   	pop    %ebp
801010c8:	c3                   	ret    
801010c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010d0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
  }
  panic("filewrite");
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010df:	8b 46 0c             	mov    0xc(%esi),%eax
801010e2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e8:	5b                   	pop    %ebx
801010e9:	5e                   	pop    %esi
801010ea:	5f                   	pop    %edi
801010eb:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010ec:	e9 bf 22 00 00       	jmp    801033b0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010f1:	83 ec 0c             	sub    $0xc,%esp
801010f4:	68 2f 73 10 80       	push   $0x8010732f
801010f9:	e8 82 f2 ff ff       	call   80100380 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010fe:	83 ec 0c             	sub    $0xc,%esp
80101101:	68 35 73 10 80       	push   $0x80107335
80101106:	e8 75 f2 ff ff       	call   80100380 <panic>
8010110b:	66 90                	xchg   %ax,%ax
8010110d:	66 90                	xchg   %ax,%ax
8010110f:	90                   	nop

80101110 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101119:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010111f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101122:	85 c9                	test   %ecx,%ecx
80101124:	0f 84 85 00 00 00    	je     801011af <balloc+0x9f>
8010112a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101131:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101134:	83 ec 08             	sub    $0x8,%esp
80101137:	89 f0                	mov    %esi,%eax
80101139:	c1 f8 0c             	sar    $0xc,%eax
8010113c:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80101142:	50                   	push   %eax
80101143:	ff 75 d8             	pushl  -0x28(%ebp)
80101146:	e8 85 ef ff ff       	call   801000d0 <bread>
8010114b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010114e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101153:	83 c4 10             	add    $0x10,%esp
80101156:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101159:	31 c0                	xor    %eax,%eax
8010115b:	eb 2d                	jmp    8010118a <balloc+0x7a>
8010115d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101160:	89 c1                	mov    %eax,%ecx
80101162:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101167:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010116a:	83 e1 07             	and    $0x7,%ecx
8010116d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010116f:	89 c1                	mov    %eax,%ecx
80101171:	c1 f9 03             	sar    $0x3,%ecx
80101174:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101179:	85 d7                	test   %edx,%edi
8010117b:	74 43                	je     801011c0 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010117d:	83 c0 01             	add    $0x1,%eax
80101180:	83 c6 01             	add    $0x1,%esi
80101183:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101188:	74 05                	je     8010118f <balloc+0x7f>
8010118a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010118d:	72 d1                	jb     80101160 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010118f:	83 ec 0c             	sub    $0xc,%esp
80101192:	ff 75 e4             	pushl  -0x1c(%ebp)
80101195:	e8 46 f0 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010119a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011a1:	83 c4 10             	add    $0x10,%esp
801011a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011a7:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
801011ad:	77 82                	ja     80101131 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801011af:	83 ec 0c             	sub    $0xc,%esp
801011b2:	68 3f 73 10 80       	push   $0x8010733f
801011b7:	e8 c4 f1 ff ff       	call   80100380 <panic>
801011bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011c0:	09 fa                	or     %edi,%edx
801011c2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011c5:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011cc:	57                   	push   %edi
801011cd:	e8 7e 1b 00 00       	call   80102d50 <log_write>
        brelse(bp);
801011d2:	89 3c 24             	mov    %edi,(%esp)
801011d5:	e8 06 f0 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011da:	58                   	pop    %eax
801011db:	5a                   	pop    %edx
801011dc:	56                   	push   %esi
801011dd:	ff 75 d8             	pushl  -0x28(%ebp)
801011e0:	e8 eb ee ff ff       	call   801000d0 <bread>
801011e5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ea:	83 c4 0c             	add    $0xc,%esp
801011ed:	68 00 02 00 00       	push   $0x200
801011f2:	6a 00                	push   $0x0
801011f4:	50                   	push   %eax
801011f5:	e8 b6 34 00 00       	call   801046b0 <memset>
  log_write(bp);
801011fa:	89 1c 24             	mov    %ebx,(%esp)
801011fd:	e8 4e 1b 00 00       	call   80102d50 <log_write>
  brelse(bp);
80101202:	89 1c 24             	mov    %ebx,(%esp)
80101205:	e8 d6 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
8010120a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010120d:	89 f0                	mov    %esi,%eax
8010120f:	5b                   	pop    %ebx
80101210:	5e                   	pop    %esi
80101211:	5f                   	pop    %edi
80101212:	5d                   	pop    %ebp
80101213:	c3                   	ret    
80101214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010121a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101220 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	57                   	push   %edi
80101224:	56                   	push   %esi
80101225:	53                   	push   %ebx
80101226:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101228:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010122a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010122f:	83 ec 28             	sub    $0x28,%esp
80101232:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101235:	68 e0 09 11 80       	push   $0x801109e0
8010123a:	e8 01 33 00 00       	call   80104540 <acquire>
8010123f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101245:	eb 1b                	jmp    80101262 <iget+0x42>
80101247:	89 f6                	mov    %esi,%esi
80101249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101250:	85 f6                	test   %esi,%esi
80101252:	74 44                	je     80101298 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101254:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010125a:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101260:	74 4e                	je     801012b0 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101262:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101265:	85 c9                	test   %ecx,%ecx
80101267:	7e e7                	jle    80101250 <iget+0x30>
80101269:	39 3b                	cmp    %edi,(%ebx)
8010126b:	75 e3                	jne    80101250 <iget+0x30>
8010126d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101270:	75 de                	jne    80101250 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101272:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101275:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101278:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010127a:	68 e0 09 11 80       	push   $0x801109e0

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010127f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101282:	e8 d9 33 00 00       	call   80104660 <release>
      return ip;
80101287:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010128a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010128d:	89 f0                	mov    %esi,%eax
8010128f:	5b                   	pop    %ebx
80101290:	5e                   	pop    %esi
80101291:	5f                   	pop    %edi
80101292:	5d                   	pop    %ebp
80101293:	c3                   	ret    
80101294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101298:	85 c9                	test   %ecx,%ecx
8010129a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010129d:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012a3:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012a9:	75 b7                	jne    80101262 <iget+0x42>
801012ab:	90                   	nop
801012ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012b0:	85 f6                	test   %esi,%esi
801012b2:	74 2d                	je     801012e1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012b4:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801012b7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012b9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012bc:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012c3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012ca:	68 e0 09 11 80       	push   $0x801109e0
801012cf:	e8 8c 33 00 00       	call   80104660 <release>

  return ip;
801012d4:	83 c4 10             	add    $0x10,%esp
}
801012d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012da:	89 f0                	mov    %esi,%eax
801012dc:	5b                   	pop    %ebx
801012dd:	5e                   	pop    %esi
801012de:	5f                   	pop    %edi
801012df:	5d                   	pop    %ebp
801012e0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012e1:	83 ec 0c             	sub    $0xc,%esp
801012e4:	68 55 73 10 80       	push   $0x80107355
801012e9:	e8 92 f0 ff ff       	call   80100380 <panic>
801012ee:	66 90                	xchg   %ax,%ax

801012f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
801012f4:	56                   	push   %esi
801012f5:	53                   	push   %ebx
801012f6:	89 c6                	mov    %eax,%esi
801012f8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012fb:	83 fa 0b             	cmp    $0xb,%edx
801012fe:	77 18                	ja     80101318 <bmap+0x28>
80101300:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
80101303:	8b 43 5c             	mov    0x5c(%ebx),%eax
80101306:	85 c0                	test   %eax,%eax
80101308:	74 76                	je     80101380 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010130a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010130d:	5b                   	pop    %ebx
8010130e:	5e                   	pop    %esi
8010130f:	5f                   	pop    %edi
80101310:	5d                   	pop    %ebp
80101311:	c3                   	ret    
80101312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101318:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010131b:	83 fb 7f             	cmp    $0x7f,%ebx
8010131e:	0f 87 83 00 00 00    	ja     801013a7 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101324:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010132a:	85 c0                	test   %eax,%eax
8010132c:	74 6a                	je     80101398 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010132e:	83 ec 08             	sub    $0x8,%esp
80101331:	50                   	push   %eax
80101332:	ff 36                	pushl  (%esi)
80101334:	e8 97 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101339:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010133d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101340:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101342:	8b 1a                	mov    (%edx),%ebx
80101344:	85 db                	test   %ebx,%ebx
80101346:	75 1d                	jne    80101365 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101348:	8b 06                	mov    (%esi),%eax
8010134a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010134d:	e8 be fd ff ff       	call   80101110 <balloc>
80101352:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101355:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101358:	89 c3                	mov    %eax,%ebx
8010135a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010135c:	57                   	push   %edi
8010135d:	e8 ee 19 00 00       	call   80102d50 <log_write>
80101362:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101365:	83 ec 0c             	sub    $0xc,%esp
80101368:	57                   	push   %edi
80101369:	e8 72 ee ff ff       	call   801001e0 <brelse>
8010136e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101371:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101374:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101376:	5b                   	pop    %ebx
80101377:	5e                   	pop    %esi
80101378:	5f                   	pop    %edi
80101379:	5d                   	pop    %ebp
8010137a:	c3                   	ret    
8010137b:	90                   	nop
8010137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101380:	8b 06                	mov    (%esi),%eax
80101382:	e8 89 fd ff ff       	call   80101110 <balloc>
80101387:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010138a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010138d:	5b                   	pop    %ebx
8010138e:	5e                   	pop    %esi
8010138f:	5f                   	pop    %edi
80101390:	5d                   	pop    %ebp
80101391:	c3                   	ret    
80101392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101398:	8b 06                	mov    (%esi),%eax
8010139a:	e8 71 fd ff ff       	call   80101110 <balloc>
8010139f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013a5:	eb 87                	jmp    8010132e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
801013a7:	83 ec 0c             	sub    $0xc,%esp
801013aa:	68 65 73 10 80       	push   $0x80107365
801013af:	e8 cc ef ff ff       	call   80100380 <panic>
801013b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013c0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	56                   	push   %esi
801013c4:	53                   	push   %ebx
801013c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801013c8:	83 ec 08             	sub    $0x8,%esp
801013cb:	6a 01                	push   $0x1
801013cd:	ff 75 08             	pushl  0x8(%ebp)
801013d0:	e8 fb ec ff ff       	call   801000d0 <bread>
801013d5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013da:	83 c4 0c             	add    $0xc,%esp
801013dd:	6a 1c                	push   $0x1c
801013df:	50                   	push   %eax
801013e0:	56                   	push   %esi
801013e1:	e8 7a 33 00 00       	call   80104760 <memmove>
  brelse(bp);
801013e6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013e9:	83 c4 10             	add    $0x10,%esp
}
801013ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013ef:	5b                   	pop    %ebx
801013f0:	5e                   	pop    %esi
801013f1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013f2:	e9 e9 ed ff ff       	jmp    801001e0 <brelse>
801013f7:	89 f6                	mov    %esi,%esi
801013f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101400 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101400:	55                   	push   %ebp
80101401:	89 e5                	mov    %esp,%ebp
80101403:	56                   	push   %esi
80101404:	53                   	push   %ebx
80101405:	89 d3                	mov    %edx,%ebx
80101407:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101409:	83 ec 08             	sub    $0x8,%esp
8010140c:	68 c0 09 11 80       	push   $0x801109c0
80101411:	50                   	push   %eax
80101412:	e8 a9 ff ff ff       	call   801013c0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101417:	58                   	pop    %eax
80101418:	5a                   	pop    %edx
80101419:	89 da                	mov    %ebx,%edx
8010141b:	c1 ea 0c             	shr    $0xc,%edx
8010141e:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101424:	52                   	push   %edx
80101425:	56                   	push   %esi
80101426:	e8 a5 ec ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010142b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010142d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101433:	ba 01 00 00 00       	mov    $0x1,%edx
80101438:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010143b:	c1 fb 03             	sar    $0x3,%ebx
8010143e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101441:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101443:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101448:	85 d1                	test   %edx,%ecx
8010144a:	74 27                	je     80101473 <bfree+0x73>
8010144c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010144e:	f7 d2                	not    %edx
80101450:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101452:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101455:	21 d0                	and    %edx,%eax
80101457:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010145b:	56                   	push   %esi
8010145c:	e8 ef 18 00 00       	call   80102d50 <log_write>
  brelse(bp);
80101461:	89 34 24             	mov    %esi,(%esp)
80101464:	e8 77 ed ff ff       	call   801001e0 <brelse>
}
80101469:	83 c4 10             	add    $0x10,%esp
8010146c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010146f:	5b                   	pop    %ebx
80101470:	5e                   	pop    %esi
80101471:	5d                   	pop    %ebp
80101472:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101473:	83 ec 0c             	sub    $0xc,%esp
80101476:	68 78 73 10 80       	push   $0x80107378
8010147b:	e8 00 ef ff ff       	call   80100380 <panic>

80101480 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	53                   	push   %ebx
80101484:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101489:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010148c:	68 8b 73 10 80       	push   $0x8010738b
80101491:	68 e0 09 11 80       	push   $0x801109e0
80101496:	e8 a5 2f 00 00       	call   80104440 <initlock>
8010149b:	83 c4 10             	add    $0x10,%esp
8010149e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
801014a0:	83 ec 08             	sub    $0x8,%esp
801014a3:	68 92 73 10 80       	push   $0x80107392
801014a8:	53                   	push   %ebx
801014a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014af:	e8 7c 2e 00 00       	call   80104330 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801014b4:	83 c4 10             	add    $0x10,%esp
801014b7:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014bd:	75 e1                	jne    801014a0 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801014bf:	83 ec 08             	sub    $0x8,%esp
801014c2:	68 c0 09 11 80       	push   $0x801109c0
801014c7:	ff 75 08             	pushl  0x8(%ebp)
801014ca:	e8 f1 fe ff ff       	call   801013c0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014cf:	ff 35 d8 09 11 80    	pushl  0x801109d8
801014d5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801014db:	ff 35 d0 09 11 80    	pushl  0x801109d0
801014e1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801014e7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801014ed:	ff 35 c4 09 11 80    	pushl  0x801109c4
801014f3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801014f9:	68 f8 73 10 80       	push   $0x801073f8
801014fe:	e8 6d f1 ff ff       	call   80100670 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101503:	83 c4 30             	add    $0x30,%esp
80101506:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101509:	c9                   	leave  
8010150a:	c3                   	ret    
8010150b:	90                   	nop
8010150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101510 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	57                   	push   %edi
80101514:	56                   	push   %esi
80101515:	53                   	push   %ebx
80101516:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101520:	8b 45 0c             	mov    0xc(%ebp),%eax
80101523:	8b 75 08             	mov    0x8(%ebp),%esi
80101526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	0f 86 91 00 00 00    	jbe    801015c0 <ialloc+0xb0>
8010152f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101534:	eb 21                	jmp    80101557 <ialloc+0x47>
80101536:	8d 76 00             	lea    0x0(%esi),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101540:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101543:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101546:	57                   	push   %edi
80101547:	e8 94 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010154c:	83 c4 10             	add    $0x10,%esp
8010154f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101555:	76 69                	jbe    801015c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101557:	89 d8                	mov    %ebx,%eax
80101559:	83 ec 08             	sub    $0x8,%esp
8010155c:	c1 e8 03             	shr    $0x3,%eax
8010155f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101565:	50                   	push   %eax
80101566:	56                   	push   %esi
80101567:	e8 64 eb ff ff       	call   801000d0 <bread>
8010156c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010156e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101570:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101573:	83 e0 07             	and    $0x7,%eax
80101576:	c1 e0 06             	shl    $0x6,%eax
80101579:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010157d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101581:	75 bd                	jne    80101540 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101583:	83 ec 04             	sub    $0x4,%esp
80101586:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101589:	6a 40                	push   $0x40
8010158b:	6a 00                	push   $0x0
8010158d:	51                   	push   %ecx
8010158e:	e8 1d 31 00 00       	call   801046b0 <memset>
      dip->type = type;
80101593:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101597:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010159a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010159d:	89 3c 24             	mov    %edi,(%esp)
801015a0:	e8 ab 17 00 00       	call   80102d50 <log_write>
      brelse(bp);
801015a5:	89 3c 24             	mov    %edi,(%esp)
801015a8:	e8 33 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015ad:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015b3:	89 da                	mov    %ebx,%edx
801015b5:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015b7:	5b                   	pop    %ebx
801015b8:	5e                   	pop    %esi
801015b9:	5f                   	pop    %edi
801015ba:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015bb:	e9 60 fc ff ff       	jmp    80101220 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015c0:	83 ec 0c             	sub    $0xc,%esp
801015c3:	68 98 73 10 80       	push   $0x80107398
801015c8:	e8 b3 ed ff ff       	call   80100380 <panic>
801015cd:	8d 76 00             	lea    0x0(%esi),%esi

801015d0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d8:	83 ec 08             	sub    $0x8,%esp
801015db:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015de:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e1:	c1 e8 03             	shr    $0x3,%eax
801015e4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801015ea:	50                   	push   %eax
801015eb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ee:	e8 dd ea ff ff       	call   801000d0 <bread>
801015f3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015f5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015f8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fc:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ff:	83 e0 07             	and    $0x7,%eax
80101602:	c1 e0 06             	shl    $0x6,%eax
80101605:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101609:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010160c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101610:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101613:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101617:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010161b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010161f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101623:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101627:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010162a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162d:	6a 34                	push   $0x34
8010162f:	53                   	push   %ebx
80101630:	50                   	push   %eax
80101631:	e8 2a 31 00 00       	call   80104760 <memmove>
  log_write(bp);
80101636:	89 34 24             	mov    %esi,(%esp)
80101639:	e8 12 17 00 00       	call   80102d50 <log_write>
  brelse(bp);
8010163e:	89 75 08             	mov    %esi,0x8(%ebp)
80101641:	83 c4 10             	add    $0x10,%esp
}
80101644:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101647:	5b                   	pop    %ebx
80101648:	5e                   	pop    %esi
80101649:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010164a:	e9 91 eb ff ff       	jmp    801001e0 <brelse>
8010164f:	90                   	nop

80101650 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	53                   	push   %ebx
80101654:	83 ec 10             	sub    $0x10,%esp
80101657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010165a:	68 e0 09 11 80       	push   $0x801109e0
8010165f:	e8 dc 2e 00 00       	call   80104540 <acquire>
  ip->ref++;
80101664:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101668:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010166f:	e8 ec 2f 00 00       	call   80104660 <release>
  return ip;
}
80101674:	89 d8                	mov    %ebx,%eax
80101676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101679:	c9                   	leave  
8010167a:	c3                   	ret    
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	56                   	push   %esi
80101684:	53                   	push   %ebx
80101685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101688:	85 db                	test   %ebx,%ebx
8010168a:	0f 84 b7 00 00 00    	je     80101747 <ilock+0xc7>
80101690:	8b 53 08             	mov    0x8(%ebx),%edx
80101693:	85 d2                	test   %edx,%edx
80101695:	0f 8e ac 00 00 00    	jle    80101747 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010169b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010169e:	83 ec 0c             	sub    $0xc,%esp
801016a1:	50                   	push   %eax
801016a2:	e8 c9 2c 00 00       	call   80104370 <acquiresleep>

  if(ip->valid == 0){
801016a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016aa:	83 c4 10             	add    $0x10,%esp
801016ad:	85 c0                	test   %eax,%eax
801016af:	74 0f                	je     801016c0 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801016b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016b4:	5b                   	pop    %ebx
801016b5:	5e                   	pop    %esi
801016b6:	5d                   	pop    %ebp
801016b7:	c3                   	ret    
801016b8:	90                   	nop
801016b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016c0:	8b 43 04             	mov    0x4(%ebx),%eax
801016c3:	83 ec 08             	sub    $0x8,%esp
801016c6:	c1 e8 03             	shr    $0x3,%eax
801016c9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016cf:	50                   	push   %eax
801016d0:	ff 33                	pushl  (%ebx)
801016d2:	e8 f9 e9 ff ff       	call   801000d0 <bread>
801016d7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016d9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016dc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016df:	83 e0 07             	and    $0x7,%eax
801016e2:	c1 e0 06             	shl    $0x6,%eax
801016e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016e9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801016ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101703:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101707:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010170b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010170e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101711:	6a 34                	push   $0x34
80101713:	50                   	push   %eax
80101714:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101717:	50                   	push   %eax
80101718:	e8 43 30 00 00       	call   80104760 <memmove>
    brelse(bp);
8010171d:	89 34 24             	mov    %esi,(%esp)
80101720:	e8 bb ea ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101725:	83 c4 10             	add    $0x10,%esp
80101728:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010172d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101734:	0f 85 77 ff ff ff    	jne    801016b1 <ilock+0x31>
      panic("ilock: no type");
8010173a:	83 ec 0c             	sub    $0xc,%esp
8010173d:	68 b0 73 10 80       	push   $0x801073b0
80101742:	e8 39 ec ff ff       	call   80100380 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101747:	83 ec 0c             	sub    $0xc,%esp
8010174a:	68 aa 73 10 80       	push   $0x801073aa
8010174f:	e8 2c ec ff ff       	call   80100380 <panic>
80101754:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010175a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101760 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101768:	85 db                	test   %ebx,%ebx
8010176a:	74 28                	je     80101794 <iunlock+0x34>
8010176c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010176f:	83 ec 0c             	sub    $0xc,%esp
80101772:	56                   	push   %esi
80101773:	e8 98 2c 00 00       	call   80104410 <holdingsleep>
80101778:	83 c4 10             	add    $0x10,%esp
8010177b:	85 c0                	test   %eax,%eax
8010177d:	74 15                	je     80101794 <iunlock+0x34>
8010177f:	8b 43 08             	mov    0x8(%ebx),%eax
80101782:	85 c0                	test   %eax,%eax
80101784:	7e 0e                	jle    80101794 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101786:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101789:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010178c:	5b                   	pop    %ebx
8010178d:	5e                   	pop    %esi
8010178e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010178f:	e9 3c 2c 00 00       	jmp    801043d0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101794:	83 ec 0c             	sub    $0xc,%esp
80101797:	68 bf 73 10 80       	push   $0x801073bf
8010179c:	e8 df eb ff ff       	call   80100380 <panic>
801017a1:	eb 0d                	jmp    801017b0 <iput>
801017a3:	90                   	nop
801017a4:	90                   	nop
801017a5:	90                   	nop
801017a6:	90                   	nop
801017a7:	90                   	nop
801017a8:	90                   	nop
801017a9:	90                   	nop
801017aa:	90                   	nop
801017ab:	90                   	nop
801017ac:	90                   	nop
801017ad:	90                   	nop
801017ae:	90                   	nop
801017af:	90                   	nop

801017b0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	83 ec 28             	sub    $0x28,%esp
801017b9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801017bc:	8d 7e 0c             	lea    0xc(%esi),%edi
801017bf:	57                   	push   %edi
801017c0:	e8 ab 2b 00 00       	call   80104370 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017c5:	8b 56 4c             	mov    0x4c(%esi),%edx
801017c8:	83 c4 10             	add    $0x10,%esp
801017cb:	85 d2                	test   %edx,%edx
801017cd:	74 07                	je     801017d6 <iput+0x26>
801017cf:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017d4:	74 32                	je     80101808 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801017d6:	83 ec 0c             	sub    $0xc,%esp
801017d9:	57                   	push   %edi
801017da:	e8 f1 2b 00 00       	call   801043d0 <releasesleep>

  acquire(&icache.lock);
801017df:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801017e6:	e8 55 2d 00 00       	call   80104540 <acquire>
  ip->ref--;
801017eb:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801017ef:	83 c4 10             	add    $0x10,%esp
801017f2:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801017f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017fc:	5b                   	pop    %ebx
801017fd:	5e                   	pop    %esi
801017fe:	5f                   	pop    %edi
801017ff:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
80101800:	e9 5b 2e 00 00       	jmp    80104660 <release>
80101805:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101808:	83 ec 0c             	sub    $0xc,%esp
8010180b:	68 e0 09 11 80       	push   $0x801109e0
80101810:	e8 2b 2d 00 00       	call   80104540 <acquire>
    int r = ip->ref;
80101815:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
80101818:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010181f:	e8 3c 2e 00 00       	call   80104660 <release>
    if(r == 1){
80101824:	83 c4 10             	add    $0x10,%esp
80101827:	83 fb 01             	cmp    $0x1,%ebx
8010182a:	75 aa                	jne    801017d6 <iput+0x26>
8010182c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101832:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101835:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101838:	89 cf                	mov    %ecx,%edi
8010183a:	eb 0b                	jmp    80101847 <iput+0x97>
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101840:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101843:	39 fb                	cmp    %edi,%ebx
80101845:	74 19                	je     80101860 <iput+0xb0>
    if(ip->addrs[i]){
80101847:	8b 13                	mov    (%ebx),%edx
80101849:	85 d2                	test   %edx,%edx
8010184b:	74 f3                	je     80101840 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010184d:	8b 06                	mov    (%esi),%eax
8010184f:	e8 ac fb ff ff       	call   80101400 <bfree>
      ip->addrs[i] = 0;
80101854:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010185a:	eb e4                	jmp    80101840 <iput+0x90>
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101860:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101866:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101869:	85 c0                	test   %eax,%eax
8010186b:	75 33                	jne    801018a0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010186d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101870:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101877:	56                   	push   %esi
80101878:	e8 53 fd ff ff       	call   801015d0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
8010187d:	31 c0                	xor    %eax,%eax
8010187f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101883:	89 34 24             	mov    %esi,(%esp)
80101886:	e8 45 fd ff ff       	call   801015d0 <iupdate>
      ip->valid = 0;
8010188b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101892:	83 c4 10             	add    $0x10,%esp
80101895:	e9 3c ff ff ff       	jmp    801017d6 <iput+0x26>
8010189a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018a0:	83 ec 08             	sub    $0x8,%esp
801018a3:	50                   	push   %eax
801018a4:	ff 36                	pushl  (%esi)
801018a6:	e8 25 e8 ff ff       	call   801000d0 <bread>
801018ab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018b1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018b7:	8d 58 5c             	lea    0x5c(%eax),%ebx
801018ba:	83 c4 10             	add    $0x10,%esp
801018bd:	89 cf                	mov    %ecx,%edi
801018bf:	eb 0e                	jmp    801018cf <iput+0x11f>
801018c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018c8:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
801018cb:	39 fb                	cmp    %edi,%ebx
801018cd:	74 0f                	je     801018de <iput+0x12e>
      if(a[j])
801018cf:	8b 13                	mov    (%ebx),%edx
801018d1:	85 d2                	test   %edx,%edx
801018d3:	74 f3                	je     801018c8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018d5:	8b 06                	mov    (%esi),%eax
801018d7:	e8 24 fb ff ff       	call   80101400 <bfree>
801018dc:	eb ea                	jmp    801018c8 <iput+0x118>
    }
    brelse(bp);
801018de:	83 ec 0c             	sub    $0xc,%esp
801018e1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018e4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018e7:	e8 f4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018ec:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018f2:	8b 06                	mov    (%esi),%eax
801018f4:	e8 07 fb ff ff       	call   80101400 <bfree>
    ip->addrs[NDIRECT] = 0;
801018f9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101900:	00 00 00 
80101903:	83 c4 10             	add    $0x10,%esp
80101906:	e9 62 ff ff ff       	jmp    8010186d <iput+0xbd>
8010190b:	90                   	nop
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101910 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	53                   	push   %ebx
80101914:	83 ec 10             	sub    $0x10,%esp
80101917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010191a:	53                   	push   %ebx
8010191b:	e8 40 fe ff ff       	call   80101760 <iunlock>
  iput(ip);
80101920:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101923:	83 c4 10             	add    $0x10,%esp
}
80101926:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101929:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010192a:	e9 81 fe ff ff       	jmp    801017b0 <iput>
8010192f:	90                   	nop

80101930 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	8b 55 08             	mov    0x8(%ebp),%edx
80101936:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101939:	8b 0a                	mov    (%edx),%ecx
8010193b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010193e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101941:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101944:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101948:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010194b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010194f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101953:	8b 52 58             	mov    0x58(%edx),%edx
80101956:	89 50 10             	mov    %edx,0x10(%eax)
}
80101959:	5d                   	pop    %ebp
8010195a:	c3                   	ret    
8010195b:	90                   	nop
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101960 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	57                   	push   %edi
80101964:	56                   	push   %esi
80101965:	53                   	push   %ebx
80101966:	83 ec 1c             	sub    $0x1c,%esp
80101969:	8b 45 08             	mov    0x8(%ebp),%eax
8010196c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010196f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101972:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101977:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010197a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010197d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101980:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101983:	0f 84 a7 00 00 00    	je     80101a30 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101989:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010198c:	8b 40 58             	mov    0x58(%eax),%eax
8010198f:	39 f0                	cmp    %esi,%eax
80101991:	0f 82 c1 00 00 00    	jb     80101a58 <readi+0xf8>
80101997:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010199a:	89 fa                	mov    %edi,%edx
8010199c:	01 f2                	add    %esi,%edx
8010199e:	0f 82 b4 00 00 00    	jb     80101a58 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019a4:	89 c1                	mov    %eax,%ecx
801019a6:	29 f1                	sub    %esi,%ecx
801019a8:	39 d0                	cmp    %edx,%eax
801019aa:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ad:	31 ff                	xor    %edi,%edi
801019af:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019b1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019b4:	74 6d                	je     80101a23 <readi+0xc3>
801019b6:	8d 76 00             	lea    0x0(%esi),%esi
801019b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019c0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019c3:	89 f2                	mov    %esi,%edx
801019c5:	c1 ea 09             	shr    $0x9,%edx
801019c8:	89 d8                	mov    %ebx,%eax
801019ca:	e8 21 f9 ff ff       	call   801012f0 <bmap>
801019cf:	83 ec 08             	sub    $0x8,%esp
801019d2:	50                   	push   %eax
801019d3:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
801019d5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019da:	e8 f1 e6 ff ff       	call   801000d0 <bread>
801019df:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019e4:	89 f1                	mov    %esi,%ecx
801019e6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801019ec:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
801019ef:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801019f2:	29 cb                	sub    %ecx,%ebx
801019f4:	29 f8                	sub    %edi,%eax
801019f6:	39 c3                	cmp    %eax,%ebx
801019f8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019fb:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801019ff:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a00:	01 df                	add    %ebx,%edi
80101a02:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101a04:	50                   	push   %eax
80101a05:	ff 75 e0             	pushl  -0x20(%ebp)
80101a08:	e8 53 2d 00 00       	call   80104760 <memmove>
    brelse(bp);
80101a0d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a10:	89 14 24             	mov    %edx,(%esp)
80101a13:	e8 c8 e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a18:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a1b:	83 c4 10             	add    $0x10,%esp
80101a1e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a21:	77 9d                	ja     801019c0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101a23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a26:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a29:	5b                   	pop    %ebx
80101a2a:	5e                   	pop    %esi
80101a2b:	5f                   	pop    %edi
80101a2c:	5d                   	pop    %ebp
80101a2d:	c3                   	ret    
80101a2e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a34:	66 83 f8 09          	cmp    $0x9,%ax
80101a38:	77 1e                	ja     80101a58 <readi+0xf8>
80101a3a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a41:	85 c0                	test   %eax,%eax
80101a43:	74 13                	je     80101a58 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a45:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a4b:	5b                   	pop    %ebx
80101a4c:	5e                   	pop    %esi
80101a4d:	5f                   	pop    %edi
80101a4e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a4f:	ff e0                	jmp    *%eax
80101a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a5d:	eb c7                	jmp    80101a26 <readi+0xc6>
80101a5f:	90                   	nop

80101a60 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	57                   	push   %edi
80101a64:	56                   	push   %esi
80101a65:	53                   	push   %ebx
80101a66:	83 ec 1c             	sub    $0x1c,%esp
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a6f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a72:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a77:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a7a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a7d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a80:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a83:	0f 84 b7 00 00 00    	je     80101b40 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a8c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a8f:	0f 82 eb 00 00 00    	jb     80101b80 <writei+0x120>
80101a95:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a98:	89 f8                	mov    %edi,%eax
80101a9a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a9c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101aa1:	0f 87 d9 00 00 00    	ja     80101b80 <writei+0x120>
80101aa7:	39 c6                	cmp    %eax,%esi
80101aa9:	0f 87 d1 00 00 00    	ja     80101b80 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101aaf:	85 ff                	test   %edi,%edi
80101ab1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ab8:	74 78                	je     80101b32 <writei+0xd2>
80101aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ac3:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101ac5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aca:	c1 ea 09             	shr    $0x9,%edx
80101acd:	89 f8                	mov    %edi,%eax
80101acf:	e8 1c f8 ff ff       	call   801012f0 <bmap>
80101ad4:	83 ec 08             	sub    $0x8,%esp
80101ad7:	50                   	push   %eax
80101ad8:	ff 37                	pushl  (%edi)
80101ada:	e8 f1 e5 ff ff       	call   801000d0 <bread>
80101adf:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ae4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101ae7:	89 f1                	mov    %esi,%ecx
80101ae9:	83 c4 0c             	add    $0xc,%esp
80101aec:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101af2:	29 cb                	sub    %ecx,%ebx
80101af4:	39 c3                	cmp    %eax,%ebx
80101af6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101af9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101afd:	53                   	push   %ebx
80101afe:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b01:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101b03:	50                   	push   %eax
80101b04:	e8 57 2c 00 00       	call   80104760 <memmove>
    log_write(bp);
80101b09:	89 3c 24             	mov    %edi,(%esp)
80101b0c:	e8 3f 12 00 00       	call   80102d50 <log_write>
    brelse(bp);
80101b11:	89 3c 24             	mov    %edi,(%esp)
80101b14:	e8 c7 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b19:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b1c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b1f:	83 c4 10             	add    $0x10,%esp
80101b22:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b25:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b28:	77 96                	ja     80101ac0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101b2a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2d:	3b 70 58             	cmp    0x58(%eax),%esi
80101b30:	77 36                	ja     80101b68 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b32:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b38:	5b                   	pop    %ebx
80101b39:	5e                   	pop    %esi
80101b3a:	5f                   	pop    %edi
80101b3b:	5d                   	pop    %ebp
80101b3c:	c3                   	ret    
80101b3d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 36                	ja     80101b80 <writei+0x120>
80101b4a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 2b                	je     80101b80 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b55:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b5f:	ff e0                	jmp    *%eax
80101b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b68:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b6b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b6e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b71:	50                   	push   %eax
80101b72:	e8 59 fa ff ff       	call   801015d0 <iupdate>
80101b77:	83 c4 10             	add    $0x10,%esp
80101b7a:	eb b6                	jmp    80101b32 <writei+0xd2>
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b85:	eb ae                	jmp    80101b35 <writei+0xd5>
80101b87:	89 f6                	mov    %esi,%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b96:	6a 0e                	push   $0xe
80101b98:	ff 75 0c             	pushl  0xc(%ebp)
80101b9b:	ff 75 08             	pushl  0x8(%ebp)
80101b9e:	e8 3d 2c 00 00       	call   801047e0 <strncmp>
}
80101ba3:	c9                   	leave  
80101ba4:	c3                   	ret    
80101ba5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	57                   	push   %edi
80101bb4:	56                   	push   %esi
80101bb5:	53                   	push   %ebx
80101bb6:	83 ec 1c             	sub    $0x1c,%esp
80101bb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bbc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bc1:	0f 85 80 00 00 00    	jne    80101c47 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bc7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bca:	31 ff                	xor    %edi,%edi
80101bcc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bcf:	85 d2                	test   %edx,%edx
80101bd1:	75 0d                	jne    80101be0 <dirlookup+0x30>
80101bd3:	eb 5b                	jmp    80101c30 <dirlookup+0x80>
80101bd5:	8d 76 00             	lea    0x0(%esi),%esi
80101bd8:	83 c7 10             	add    $0x10,%edi
80101bdb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bde:	76 50                	jbe    80101c30 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101be0:	6a 10                	push   $0x10
80101be2:	57                   	push   %edi
80101be3:	56                   	push   %esi
80101be4:	53                   	push   %ebx
80101be5:	e8 76 fd ff ff       	call   80101960 <readi>
80101bea:	83 c4 10             	add    $0x10,%esp
80101bed:	83 f8 10             	cmp    $0x10,%eax
80101bf0:	75 48                	jne    80101c3a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101bf2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bf7:	74 df                	je     80101bd8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101bf9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bfc:	83 ec 04             	sub    $0x4,%esp
80101bff:	6a 0e                	push   $0xe
80101c01:	50                   	push   %eax
80101c02:	ff 75 0c             	pushl  0xc(%ebp)
80101c05:	e8 d6 2b 00 00       	call   801047e0 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101c0a:	83 c4 10             	add    $0x10,%esp
80101c0d:	85 c0                	test   %eax,%eax
80101c0f:	75 c7                	jne    80101bd8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c11:	8b 45 10             	mov    0x10(%ebp),%eax
80101c14:	85 c0                	test   %eax,%eax
80101c16:	74 05                	je     80101c1d <dirlookup+0x6d>
        *poff = off;
80101c18:	8b 45 10             	mov    0x10(%ebp),%eax
80101c1b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101c1d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101c21:	8b 03                	mov    (%ebx),%eax
80101c23:	e8 f8 f5 ff ff       	call   80101220 <iget>
    }
  }

  return 0;
}
80101c28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c2b:	5b                   	pop    %ebx
80101c2c:	5e                   	pop    %esi
80101c2d:	5f                   	pop    %edi
80101c2e:	5d                   	pop    %ebp
80101c2f:	c3                   	ret    
80101c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c33:	31 c0                	xor    %eax,%eax
}
80101c35:	5b                   	pop    %ebx
80101c36:	5e                   	pop    %esi
80101c37:	5f                   	pop    %edi
80101c38:	5d                   	pop    %ebp
80101c39:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101c3a:	83 ec 0c             	sub    $0xc,%esp
80101c3d:	68 d9 73 10 80       	push   $0x801073d9
80101c42:	e8 39 e7 ff ff       	call   80100380 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c47:	83 ec 0c             	sub    $0xc,%esp
80101c4a:	68 c7 73 10 80       	push   $0x801073c7
80101c4f:	e8 2c e7 ff ff       	call   80100380 <panic>
80101c54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c60 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	57                   	push   %edi
80101c64:	56                   	push   %esi
80101c65:	53                   	push   %ebx
80101c66:	89 cf                	mov    %ecx,%edi
80101c68:	89 c3                	mov    %eax,%ebx
80101c6a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c6d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c70:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101c73:	0f 84 63 01 00 00    	je     80101ddc <namex+0x17c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c79:	e8 32 1b 00 00       	call   801037b0 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c7e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c81:	8b b0 cc 00 00 00    	mov    0xcc(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c87:	68 e0 09 11 80       	push   $0x801109e0
80101c8c:	e8 af 28 00 00       	call   80104540 <acquire>
  ip->ref++;
80101c91:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c95:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101c9c:	e8 bf 29 00 00       	call   80104660 <release>
80101ca1:	83 c4 10             	add    $0x10,%esp
80101ca4:	eb 0d                	jmp    80101cb3 <namex+0x53>
80101ca6:	8d 76 00             	lea    0x0(%esi),%esi
80101ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101cb0:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101cb3:	0f b6 03             	movzbl (%ebx),%eax
80101cb6:	3c 2f                	cmp    $0x2f,%al
80101cb8:	74 f6                	je     80101cb0 <namex+0x50>
    path++;
  if(*path == 0)
80101cba:	84 c0                	test   %al,%al
80101cbc:	0f 84 eb 00 00 00    	je     80101dad <namex+0x14d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cc2:	0f b6 03             	movzbl (%ebx),%eax
80101cc5:	89 da                	mov    %ebx,%edx
80101cc7:	84 c0                	test   %al,%al
80101cc9:	0f 84 b4 00 00 00    	je     80101d83 <namex+0x123>
80101ccf:	3c 2f                	cmp    $0x2f,%al
80101cd1:	75 11                	jne    80101ce4 <namex+0x84>
80101cd3:	e9 ab 00 00 00       	jmp    80101d83 <namex+0x123>
80101cd8:	90                   	nop
80101cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ce0:	84 c0                	test   %al,%al
80101ce2:	74 0a                	je     80101cee <namex+0x8e>
    path++;
80101ce4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101ce7:	0f b6 02             	movzbl (%edx),%eax
80101cea:	3c 2f                	cmp    $0x2f,%al
80101cec:	75 f2                	jne    80101ce0 <namex+0x80>
80101cee:	89 d1                	mov    %edx,%ecx
80101cf0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101cf2:	83 f9 0d             	cmp    $0xd,%ecx
80101cf5:	0f 8e 8d 00 00 00    	jle    80101d88 <namex+0x128>
    memmove(name, s, DIRSIZ);
80101cfb:	83 ec 04             	sub    $0x4,%esp
80101cfe:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d01:	6a 0e                	push   $0xe
80101d03:	53                   	push   %ebx
80101d04:	57                   	push   %edi
80101d05:	e8 56 2a 00 00       	call   80104760 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d0a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101d0d:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d10:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d12:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d15:	75 11                	jne    80101d28 <namex+0xc8>
80101d17:	89 f6                	mov    %esi,%esi
80101d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d20:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d23:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d26:	74 f8                	je     80101d20 <namex+0xc0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d28:	83 ec 0c             	sub    $0xc,%esp
80101d2b:	56                   	push   %esi
80101d2c:	e8 4f f9 ff ff       	call   80101680 <ilock>
    if(ip->type != T_DIR){
80101d31:	83 c4 10             	add    $0x10,%esp
80101d34:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d39:	0f 85 7f 00 00 00    	jne    80101dbe <namex+0x15e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d3f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d42:	85 d2                	test   %edx,%edx
80101d44:	74 09                	je     80101d4f <namex+0xef>
80101d46:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d49:	0f 84 a3 00 00 00    	je     80101df2 <namex+0x192>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d4f:	83 ec 04             	sub    $0x4,%esp
80101d52:	6a 00                	push   $0x0
80101d54:	57                   	push   %edi
80101d55:	56                   	push   %esi
80101d56:	e8 55 fe ff ff       	call   80101bb0 <dirlookup>
80101d5b:	83 c4 10             	add    $0x10,%esp
80101d5e:	85 c0                	test   %eax,%eax
80101d60:	74 5c                	je     80101dbe <namex+0x15e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d62:	83 ec 0c             	sub    $0xc,%esp
80101d65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d68:	56                   	push   %esi
80101d69:	e8 f2 f9 ff ff       	call   80101760 <iunlock>
  iput(ip);
80101d6e:	89 34 24             	mov    %esi,(%esp)
80101d71:	e8 3a fa ff ff       	call   801017b0 <iput>
80101d76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d79:	83 c4 10             	add    $0x10,%esp
80101d7c:	89 c6                	mov    %eax,%esi
80101d7e:	e9 30 ff ff ff       	jmp    80101cb3 <namex+0x53>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d83:	31 c9                	xor    %ecx,%ecx
80101d85:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101d88:	83 ec 04             	sub    $0x4,%esp
80101d8b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d8e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d91:	51                   	push   %ecx
80101d92:	53                   	push   %ebx
80101d93:	57                   	push   %edi
80101d94:	e8 c7 29 00 00       	call   80104760 <memmove>
    name[len] = 0;
80101d99:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d9c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d9f:	83 c4 10             	add    $0x10,%esp
80101da2:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101da6:	89 d3                	mov    %edx,%ebx
80101da8:	e9 65 ff ff ff       	jmp    80101d12 <namex+0xb2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101dad:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101db0:	85 c0                	test   %eax,%eax
80101db2:	75 54                	jne    80101e08 <namex+0x1a8>
80101db4:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101db6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db9:	5b                   	pop    %ebx
80101dba:	5e                   	pop    %esi
80101dbb:	5f                   	pop    %edi
80101dbc:	5d                   	pop    %ebp
80101dbd:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101dbe:	83 ec 0c             	sub    $0xc,%esp
80101dc1:	56                   	push   %esi
80101dc2:	e8 99 f9 ff ff       	call   80101760 <iunlock>
  iput(ip);
80101dc7:	89 34 24             	mov    %esi,(%esp)
80101dca:	e8 e1 f9 ff ff       	call   801017b0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101dcf:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101dd5:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dd7:	5b                   	pop    %ebx
80101dd8:	5e                   	pop    %esi
80101dd9:	5f                   	pop    %edi
80101dda:	5d                   	pop    %ebp
80101ddb:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101ddc:	ba 01 00 00 00       	mov    $0x1,%edx
80101de1:	b8 01 00 00 00       	mov    $0x1,%eax
80101de6:	e8 35 f4 ff ff       	call   80101220 <iget>
80101deb:	89 c6                	mov    %eax,%esi
80101ded:	e9 c1 fe ff ff       	jmp    80101cb3 <namex+0x53>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101df2:	83 ec 0c             	sub    $0xc,%esp
80101df5:	56                   	push   %esi
80101df6:	e8 65 f9 ff ff       	call   80101760 <iunlock>
      return ip;
80101dfb:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dfe:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101e01:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e03:	5b                   	pop    %ebx
80101e04:	5e                   	pop    %esi
80101e05:	5f                   	pop    %edi
80101e06:	5d                   	pop    %ebp
80101e07:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101e08:	83 ec 0c             	sub    $0xc,%esp
80101e0b:	56                   	push   %esi
80101e0c:	e8 9f f9 ff ff       	call   801017b0 <iput>
    return 0;
80101e11:	83 c4 10             	add    $0x10,%esp
80101e14:	31 c0                	xor    %eax,%eax
80101e16:	eb 9e                	jmp    80101db6 <namex+0x156>
80101e18:	90                   	nop
80101e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e20 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 20             	sub    $0x20,%esp
80101e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e2c:	6a 00                	push   $0x0
80101e2e:	ff 75 0c             	pushl  0xc(%ebp)
80101e31:	53                   	push   %ebx
80101e32:	e8 79 fd ff ff       	call   80101bb0 <dirlookup>
80101e37:	83 c4 10             	add    $0x10,%esp
80101e3a:	85 c0                	test   %eax,%eax
80101e3c:	75 67                	jne    80101ea5 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e3e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e41:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e44:	85 ff                	test   %edi,%edi
80101e46:	74 29                	je     80101e71 <dirlink+0x51>
80101e48:	31 ff                	xor    %edi,%edi
80101e4a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e4d:	eb 09                	jmp    80101e58 <dirlink+0x38>
80101e4f:	90                   	nop
80101e50:	83 c7 10             	add    $0x10,%edi
80101e53:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e56:	76 19                	jbe    80101e71 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e58:	6a 10                	push   $0x10
80101e5a:	57                   	push   %edi
80101e5b:	56                   	push   %esi
80101e5c:	53                   	push   %ebx
80101e5d:	e8 fe fa ff ff       	call   80101960 <readi>
80101e62:	83 c4 10             	add    $0x10,%esp
80101e65:	83 f8 10             	cmp    $0x10,%eax
80101e68:	75 4e                	jne    80101eb8 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e6a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e6f:	75 df                	jne    80101e50 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101e71:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e74:	83 ec 04             	sub    $0x4,%esp
80101e77:	6a 0e                	push   $0xe
80101e79:	ff 75 0c             	pushl  0xc(%ebp)
80101e7c:	50                   	push   %eax
80101e7d:	e8 ce 29 00 00       	call   80104850 <strncpy>
  de.inum = inum;
80101e82:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e85:	6a 10                	push   $0x10
80101e87:	57                   	push   %edi
80101e88:	56                   	push   %esi
80101e89:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101e8a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e8e:	e8 cd fb ff ff       	call   80101a60 <writei>
80101e93:	83 c4 20             	add    $0x20,%esp
80101e96:	83 f8 10             	cmp    $0x10,%eax
80101e99:	75 2a                	jne    80101ec5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101e9b:	31 c0                	xor    %eax,%eax
}
80101e9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea0:	5b                   	pop    %ebx
80101ea1:	5e                   	pop    %esi
80101ea2:	5f                   	pop    %edi
80101ea3:	5d                   	pop    %ebp
80101ea4:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	50                   	push   %eax
80101ea9:	e8 02 f9 ff ff       	call   801017b0 <iput>
    return -1;
80101eae:	83 c4 10             	add    $0x10,%esp
80101eb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb6:	eb e5                	jmp    80101e9d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101eb8:	83 ec 0c             	sub    $0xc,%esp
80101ebb:	68 e8 73 10 80       	push   $0x801073e8
80101ec0:	e8 bb e4 ff ff       	call   80100380 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	68 ea 79 10 80       	push   $0x801079ea
80101ecd:	e8 ae e4 ff ff       	call   80100380 <panic>
80101ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101ee0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ee1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101ee3:	89 e5                	mov    %esp,%ebp
80101ee5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ee8:	8b 45 08             	mov    0x8(%ebp),%eax
80101eeb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101eee:	e8 6d fd ff ff       	call   80101c60 <namex>
}
80101ef3:	c9                   	leave  
80101ef4:	c3                   	ret    
80101ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f00:	55                   	push   %ebp
  return namex(path, 1, name);
80101f01:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101f06:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f08:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f0e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101f0f:	e9 4c fd ff ff       	jmp    80101c60 <namex>
80101f14:	66 90                	xchg   %ax,%ax
80101f16:	66 90                	xchg   %ax,%ax
80101f18:	66 90                	xchg   %ax,%ax
80101f1a:	66 90                	xchg   %ax,%ax
80101f1c:	66 90                	xchg   %ax,%ax
80101f1e:	66 90                	xchg   %ax,%ax

80101f20 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f20:	55                   	push   %ebp
  if(b == 0)
80101f21:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f23:	89 e5                	mov    %esp,%ebp
80101f25:	56                   	push   %esi
80101f26:	53                   	push   %ebx
  if(b == 0)
80101f27:	0f 84 ad 00 00 00    	je     80101fda <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f2d:	8b 58 08             	mov    0x8(%eax),%ebx
80101f30:	89 c1                	mov    %eax,%ecx
80101f32:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f38:	0f 87 8f 00 00 00    	ja     80101fcd <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f3e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f43:	90                   	nop
80101f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f48:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f49:	83 e0 c0             	and    $0xffffffc0,%eax
80101f4c:	3c 40                	cmp    $0x40,%al
80101f4e:	75 f8                	jne    80101f48 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f50:	31 f6                	xor    %esi,%esi
80101f52:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f57:	89 f0                	mov    %esi,%eax
80101f59:	ee                   	out    %al,(%dx)
80101f5a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f5f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f64:	ee                   	out    %al,(%dx)
80101f65:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f6a:	89 d8                	mov    %ebx,%eax
80101f6c:	ee                   	out    %al,(%dx)
80101f6d:	89 d8                	mov    %ebx,%eax
80101f6f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f74:	c1 f8 08             	sar    $0x8,%eax
80101f77:	ee                   	out    %al,(%dx)
80101f78:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f7d:	89 f0                	mov    %esi,%eax
80101f7f:	ee                   	out    %al,(%dx)
80101f80:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f84:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f89:	83 e0 01             	and    $0x1,%eax
80101f8c:	c1 e0 04             	shl    $0x4,%eax
80101f8f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f92:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101f93:	f6 01 04             	testb  $0x4,(%ecx)
80101f96:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f9b:	75 13                	jne    80101fb0 <idestart+0x90>
80101f9d:	b8 20 00 00 00       	mov    $0x20,%eax
80101fa2:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fa3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fa6:	5b                   	pop    %ebx
80101fa7:	5e                   	pop    %esi
80101fa8:	5d                   	pop    %ebp
80101fa9:	c3                   	ret    
80101faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fb0:	b8 30 00 00 00       	mov    $0x30,%eax
80101fb5:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101fb6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101fbb:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101fbe:	b9 80 00 00 00       	mov    $0x80,%ecx
80101fc3:	fc                   	cld    
80101fc4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fc6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fc9:	5b                   	pop    %ebx
80101fca:	5e                   	pop    %esi
80101fcb:	5d                   	pop    %ebp
80101fcc:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101fcd:	83 ec 0c             	sub    $0xc,%esp
80101fd0:	68 54 74 10 80       	push   $0x80107454
80101fd5:	e8 a6 e3 ff ff       	call   80100380 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101fda:	83 ec 0c             	sub    $0xc,%esp
80101fdd:	68 4b 74 10 80       	push   $0x8010744b
80101fe2:	e8 99 e3 ff ff       	call   80100380 <panic>
80101fe7:	89 f6                	mov    %esi,%esi
80101fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ff0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101ff6:	68 66 74 10 80       	push   $0x80107466
80101ffb:	68 80 a5 10 80       	push   $0x8010a580
80102000:	e8 3b 24 00 00       	call   80104440 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102005:	58                   	pop    %eax
80102006:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010200b:	5a                   	pop    %edx
8010200c:	83 e8 01             	sub    $0x1,%eax
8010200f:	50                   	push   %eax
80102010:	6a 0e                	push   $0xe
80102012:	e8 a9 02 00 00       	call   801022c0 <ioapicenable>
80102017:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010201a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010201f:	90                   	nop
80102020:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102021:	83 e0 c0             	and    $0xffffffc0,%eax
80102024:	3c 40                	cmp    $0x40,%al
80102026:	75 f8                	jne    80102020 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102028:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010202d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102032:	ee                   	out    %al,(%dx)
80102033:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102038:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010203d:	eb 06                	jmp    80102045 <ideinit+0x55>
8010203f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102040:	83 e9 01             	sub    $0x1,%ecx
80102043:	74 0f                	je     80102054 <ideinit+0x64>
80102045:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102046:	84 c0                	test   %al,%al
80102048:	74 f6                	je     80102040 <ideinit+0x50>
      havedisk1 = 1;
8010204a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102051:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102054:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102059:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010205e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010205f:	c9                   	leave  
80102060:	c3                   	ret    
80102061:	eb 0d                	jmp    80102070 <ideintr>
80102063:	90                   	nop
80102064:	90                   	nop
80102065:	90                   	nop
80102066:	90                   	nop
80102067:	90                   	nop
80102068:	90                   	nop
80102069:	90                   	nop
8010206a:	90                   	nop
8010206b:	90                   	nop
8010206c:	90                   	nop
8010206d:	90                   	nop
8010206e:	90                   	nop
8010206f:	90                   	nop

80102070 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102070:	55                   	push   %ebp
80102071:	89 e5                	mov    %esp,%ebp
80102073:	57                   	push   %edi
80102074:	56                   	push   %esi
80102075:	53                   	push   %ebx
80102076:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102079:	68 80 a5 10 80       	push   $0x8010a580
8010207e:	e8 bd 24 00 00       	call   80104540 <acquire>

  if((b = idequeue) == 0){
80102083:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102089:	83 c4 10             	add    $0x10,%esp
8010208c:	85 db                	test   %ebx,%ebx
8010208e:	74 34                	je     801020c4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102090:	8b 43 58             	mov    0x58(%ebx),%eax
80102093:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102098:	8b 33                	mov    (%ebx),%esi
8010209a:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020a0:	74 3e                	je     801020e0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020a2:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801020a5:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020a8:	83 ce 02             	or     $0x2,%esi
801020ab:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020ad:	53                   	push   %ebx
801020ae:	e8 cd 20 00 00       	call   80104180 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020b3:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020b8:	83 c4 10             	add    $0x10,%esp
801020bb:	85 c0                	test   %eax,%eax
801020bd:	74 05                	je     801020c4 <ideintr+0x54>
    idestart(idequeue);
801020bf:	e8 5c fe ff ff       	call   80101f20 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
801020c4:	83 ec 0c             	sub    $0xc,%esp
801020c7:	68 80 a5 10 80       	push   $0x8010a580
801020cc:	e8 8f 25 00 00       	call   80104660 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801020d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020d4:	5b                   	pop    %ebx
801020d5:	5e                   	pop    %esi
801020d6:	5f                   	pop    %edi
801020d7:	5d                   	pop    %ebp
801020d8:	c3                   	ret    
801020d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020e0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020e5:	8d 76 00             	lea    0x0(%esi),%esi
801020e8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020e9:	89 c1                	mov    %eax,%ecx
801020eb:	83 e1 c0             	and    $0xffffffc0,%ecx
801020ee:	80 f9 40             	cmp    $0x40,%cl
801020f1:	75 f5                	jne    801020e8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020f3:	a8 21                	test   $0x21,%al
801020f5:	75 ab                	jne    801020a2 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801020f7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801020fa:	b9 80 00 00 00       	mov    $0x80,%ecx
801020ff:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102104:	fc                   	cld    
80102105:	f3 6d                	rep insl (%dx),%es:(%edi)
80102107:	8b 33                	mov    (%ebx),%esi
80102109:	eb 97                	jmp    801020a2 <ideintr+0x32>
8010210b:	90                   	nop
8010210c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102110 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102110:	55                   	push   %ebp
80102111:	89 e5                	mov    %esp,%ebp
80102113:	53                   	push   %ebx
80102114:	83 ec 10             	sub    $0x10,%esp
80102117:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010211a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010211d:	50                   	push   %eax
8010211e:	e8 ed 22 00 00       	call   80104410 <holdingsleep>
80102123:	83 c4 10             	add    $0x10,%esp
80102126:	85 c0                	test   %eax,%eax
80102128:	0f 84 ad 00 00 00    	je     801021db <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010212e:	8b 03                	mov    (%ebx),%eax
80102130:	83 e0 06             	and    $0x6,%eax
80102133:	83 f8 02             	cmp    $0x2,%eax
80102136:	0f 84 b9 00 00 00    	je     801021f5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010213c:	8b 53 04             	mov    0x4(%ebx),%edx
8010213f:	85 d2                	test   %edx,%edx
80102141:	74 0d                	je     80102150 <iderw+0x40>
80102143:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102148:	85 c0                	test   %eax,%eax
8010214a:	0f 84 98 00 00 00    	je     801021e8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102150:	83 ec 0c             	sub    $0xc,%esp
80102153:	68 80 a5 10 80       	push   $0x8010a580
80102158:	e8 e3 23 00 00       	call   80104540 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010215d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102163:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102166:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010216d:	85 d2                	test   %edx,%edx
8010216f:	75 09                	jne    8010217a <iderw+0x6a>
80102171:	eb 58                	jmp    801021cb <iderw+0xbb>
80102173:	90                   	nop
80102174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102178:	89 c2                	mov    %eax,%edx
8010217a:	8b 42 58             	mov    0x58(%edx),%eax
8010217d:	85 c0                	test   %eax,%eax
8010217f:	75 f7                	jne    80102178 <iderw+0x68>
80102181:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102184:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102186:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010218c:	74 44                	je     801021d2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010218e:	8b 03                	mov    (%ebx),%eax
80102190:	83 e0 06             	and    $0x6,%eax
80102193:	83 f8 02             	cmp    $0x2,%eax
80102196:	74 23                	je     801021bb <iderw+0xab>
80102198:	90                   	nop
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021a0:	83 ec 08             	sub    $0x8,%esp
801021a3:	68 80 a5 10 80       	push   $0x8010a580
801021a8:	53                   	push   %ebx
801021a9:	e8 f2 1d 00 00       	call   80103fa0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ae:	8b 03                	mov    (%ebx),%eax
801021b0:	83 c4 10             	add    $0x10,%esp
801021b3:	83 e0 06             	and    $0x6,%eax
801021b6:	83 f8 02             	cmp    $0x2,%eax
801021b9:	75 e5                	jne    801021a0 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
801021bb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021c5:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801021c6:	e9 95 24 00 00       	jmp    80104660 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021cb:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021d0:	eb b2                	jmp    80102184 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801021d2:	89 d8                	mov    %ebx,%eax
801021d4:	e8 47 fd ff ff       	call   80101f20 <idestart>
801021d9:	eb b3                	jmp    8010218e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801021db:	83 ec 0c             	sub    $0xc,%esp
801021de:	68 6a 74 10 80       	push   $0x8010746a
801021e3:	e8 98 e1 ff ff       	call   80100380 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801021e8:	83 ec 0c             	sub    $0xc,%esp
801021eb:	68 95 74 10 80       	push   $0x80107495
801021f0:	e8 8b e1 ff ff       	call   80100380 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801021f5:	83 ec 0c             	sub    $0xc,%esp
801021f8:	68 80 74 10 80       	push   $0x80107480
801021fd:	e8 7e e1 ff ff       	call   80100380 <panic>
80102202:	66 90                	xchg   %ax,%ax
80102204:	66 90                	xchg   %ax,%ax
80102206:	66 90                	xchg   %ax,%ax
80102208:	66 90                	xchg   %ax,%ax
8010220a:	66 90                	xchg   %ax,%ax
8010220c:	66 90                	xchg   %ax,%ax
8010220e:	66 90                	xchg   %ax,%ax

80102210 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102210:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102211:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102218:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010221b:	89 e5                	mov    %esp,%ebp
8010221d:	56                   	push   %esi
8010221e:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010221f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102226:	00 00 00 
  return ioapic->data;
80102229:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010222f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102232:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102238:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010223e:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102245:	89 f0                	mov    %esi,%eax
80102247:	c1 e8 10             	shr    $0x10,%eax
8010224a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010224d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102250:	c1 e8 18             	shr    $0x18,%eax
80102253:	39 d0                	cmp    %edx,%eax
80102255:	74 16                	je     8010226d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102257:	83 ec 0c             	sub    $0xc,%esp
8010225a:	68 b4 74 10 80       	push   $0x801074b4
8010225f:	e8 0c e4 ff ff       	call   80100670 <cprintf>
80102264:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010226a:	83 c4 10             	add    $0x10,%esp
8010226d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102270:	ba 10 00 00 00       	mov    $0x10,%edx
80102275:	b8 20 00 00 00       	mov    $0x20,%eax
8010227a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102280:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102282:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102288:	89 c3                	mov    %eax,%ebx
8010228a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102290:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102293:	89 59 10             	mov    %ebx,0x10(%ecx)
80102296:	8d 5a 01             	lea    0x1(%edx),%ebx
80102299:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010229c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010229e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801022a0:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022a6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022ad:	75 d1                	jne    80102280 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022b2:	5b                   	pop    %ebx
801022b3:	5e                   	pop    %esi
801022b4:	5d                   	pop    %ebp
801022b5:	c3                   	ret    
801022b6:	8d 76 00             	lea    0x0(%esi),%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022c0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022c0:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022c1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801022c7:	89 e5                	mov    %esp,%ebp
801022c9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022cc:	8d 50 20             	lea    0x20(%eax),%edx
801022cf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022d3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022d5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022db:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022de:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022e1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022e4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022e6:	a1 34 26 11 80       	mov    0x80112634,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022eb:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022ee:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801022f1:	5d                   	pop    %ebp
801022f2:	c3                   	ret    
801022f3:	66 90                	xchg   %ax,%ax
801022f5:	66 90                	xchg   %ax,%ax
801022f7:	66 90                	xchg   %ax,%ax
801022f9:	66 90                	xchg   %ax,%ax
801022fb:	66 90                	xchg   %ax,%ax
801022fd:	66 90                	xchg   %ax,%ax
801022ff:	90                   	nop

80102300 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	53                   	push   %ebx
80102304:	83 ec 04             	sub    $0x4,%esp
80102307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010230a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102310:	75 70                	jne    80102382 <kfree+0x82>
80102312:	81 fb a8 6d 11 80    	cmp    $0x80116da8,%ebx
80102318:	72 68                	jb     80102382 <kfree+0x82>
8010231a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102320:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102325:	77 5b                	ja     80102382 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102327:	83 ec 04             	sub    $0x4,%esp
8010232a:	68 00 10 00 00       	push   $0x1000
8010232f:	6a 01                	push   $0x1
80102331:	53                   	push   %ebx
80102332:	e8 79 23 00 00       	call   801046b0 <memset>

  if(kmem.use_lock)
80102337:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010233d:	83 c4 10             	add    $0x10,%esp
80102340:	85 d2                	test   %edx,%edx
80102342:	75 2c                	jne    80102370 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102344:	a1 78 26 11 80       	mov    0x80112678,%eax
80102349:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010234b:	a1 74 26 11 80       	mov    0x80112674,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102350:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102356:	85 c0                	test   %eax,%eax
80102358:	75 06                	jne    80102360 <kfree+0x60>
    release(&kmem.lock);
}
8010235a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010235d:	c9                   	leave  
8010235e:	c3                   	ret    
8010235f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102360:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102367:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010236a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010236b:	e9 f0 22 00 00       	jmp    80104660 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102370:	83 ec 0c             	sub    $0xc,%esp
80102373:	68 40 26 11 80       	push   $0x80112640
80102378:	e8 c3 21 00 00       	call   80104540 <acquire>
8010237d:	83 c4 10             	add    $0x10,%esp
80102380:	eb c2                	jmp    80102344 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102382:	83 ec 0c             	sub    $0xc,%esp
80102385:	68 e6 74 10 80       	push   $0x801074e6
8010238a:	e8 f1 df ff ff       	call   80100380 <panic>
8010238f:	90                   	nop

80102390 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	56                   	push   %esi
80102394:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102395:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102398:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010239b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ad:	39 de                	cmp    %ebx,%esi
801023af:	72 23                	jb     801023d4 <freerange+0x44>
801023b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023b8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023be:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023c7:	50                   	push   %eax
801023c8:	e8 33 ff ff ff       	call   80102300 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023cd:	83 c4 10             	add    $0x10,%esp
801023d0:	39 f3                	cmp    %esi,%ebx
801023d2:	76 e4                	jbe    801023b8 <freerange+0x28>
    kfree(p);
}
801023d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023d7:	5b                   	pop    %ebx
801023d8:	5e                   	pop    %esi
801023d9:	5d                   	pop    %ebp
801023da:	c3                   	ret    
801023db:	90                   	nop
801023dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023e0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	56                   	push   %esi
801023e4:	53                   	push   %ebx
801023e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023e8:	83 ec 08             	sub    $0x8,%esp
801023eb:	68 ec 74 10 80       	push   $0x801074ec
801023f0:	68 40 26 11 80       	push   $0x80112640
801023f5:	e8 46 20 00 00       	call   80104440 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023fa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023fd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102400:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102407:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010240a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102410:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102416:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010241c:	39 de                	cmp    %ebx,%esi
8010241e:	72 1c                	jb     8010243c <kinit1+0x5c>
    kfree(p);
80102420:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102426:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102429:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010242f:	50                   	push   %eax
80102430:	e8 cb fe ff ff       	call   80102300 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102435:	83 c4 10             	add    $0x10,%esp
80102438:	39 de                	cmp    %ebx,%esi
8010243a:	73 e4                	jae    80102420 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010243c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010243f:	5b                   	pop    %ebx
80102440:	5e                   	pop    %esi
80102441:	5d                   	pop    %ebp
80102442:	c3                   	ret    
80102443:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102450 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	56                   	push   %esi
80102454:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102455:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102458:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010245b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102461:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102467:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010246d:	39 de                	cmp    %ebx,%esi
8010246f:	72 23                	jb     80102494 <kinit2+0x44>
80102471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102478:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010247e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102481:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102487:	50                   	push   %eax
80102488:	e8 73 fe ff ff       	call   80102300 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010248d:	83 c4 10             	add    $0x10,%esp
80102490:	39 de                	cmp    %ebx,%esi
80102492:	73 e4                	jae    80102478 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102494:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010249b:	00 00 00 
}
8010249e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024a1:	5b                   	pop    %ebx
801024a2:	5e                   	pop    %esi
801024a3:	5d                   	pop    %ebp
801024a4:	c3                   	ret    
801024a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024b0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	53                   	push   %ebx
801024b4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801024b7:	a1 74 26 11 80       	mov    0x80112674,%eax
801024bc:	85 c0                	test   %eax,%eax
801024be:	75 30                	jne    801024f0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024c0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801024c6:	85 db                	test   %ebx,%ebx
801024c8:	74 1c                	je     801024e6 <kalloc+0x36>
    kmem.freelist = r->next;
801024ca:	8b 13                	mov    (%ebx),%edx
801024cc:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801024d2:	85 c0                	test   %eax,%eax
801024d4:	74 10                	je     801024e6 <kalloc+0x36>
    release(&kmem.lock);
801024d6:	83 ec 0c             	sub    $0xc,%esp
801024d9:	68 40 26 11 80       	push   $0x80112640
801024de:	e8 7d 21 00 00       	call   80104660 <release>
801024e3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801024e6:	89 d8                	mov    %ebx,%eax
801024e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024eb:	c9                   	leave  
801024ec:	c3                   	ret    
801024ed:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024f0:	83 ec 0c             	sub    $0xc,%esp
801024f3:	68 40 26 11 80       	push   $0x80112640
801024f8:	e8 43 20 00 00       	call   80104540 <acquire>
  r = kmem.freelist;
801024fd:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
80102503:	83 c4 10             	add    $0x10,%esp
80102506:	a1 74 26 11 80       	mov    0x80112674,%eax
8010250b:	85 db                	test   %ebx,%ebx
8010250d:	75 bb                	jne    801024ca <kalloc+0x1a>
8010250f:	eb c1                	jmp    801024d2 <kalloc+0x22>
80102511:	66 90                	xchg   %ax,%ax
80102513:	66 90                	xchg   %ax,%ax
80102515:	66 90                	xchg   %ax,%ax
80102517:	66 90                	xchg   %ax,%ax
80102519:	66 90                	xchg   %ax,%ax
8010251b:	66 90                	xchg   %ax,%ax
8010251d:	66 90                	xchg   %ax,%ax
8010251f:	90                   	nop

80102520 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102520:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102521:	ba 64 00 00 00       	mov    $0x64,%edx
80102526:	89 e5                	mov    %esp,%ebp
80102528:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102529:	a8 01                	test   $0x1,%al
8010252b:	0f 84 af 00 00 00    	je     801025e0 <kbdgetc+0xc0>
80102531:	ba 60 00 00 00       	mov    $0x60,%edx
80102536:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102537:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010253a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102540:	74 7e                	je     801025c0 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102542:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102544:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010254a:	79 24                	jns    80102570 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010254c:	f6 c1 40             	test   $0x40,%cl
8010254f:	75 05                	jne    80102556 <kbdgetc+0x36>
80102551:	89 c2                	mov    %eax,%edx
80102553:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102556:	0f b6 82 20 76 10 80 	movzbl -0x7fef89e0(%edx),%eax
8010255d:	83 c8 40             	or     $0x40,%eax
80102560:	0f b6 c0             	movzbl %al,%eax
80102563:	f7 d0                	not    %eax
80102565:	21 c8                	and    %ecx,%eax
80102567:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010256c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010256e:	5d                   	pop    %ebp
8010256f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102570:	f6 c1 40             	test   $0x40,%cl
80102573:	74 09                	je     8010257e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102575:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102578:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010257b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010257e:	0f b6 82 20 76 10 80 	movzbl -0x7fef89e0(%edx),%eax
80102585:	09 c1                	or     %eax,%ecx
80102587:	0f b6 82 20 75 10 80 	movzbl -0x7fef8ae0(%edx),%eax
8010258e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102590:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102592:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102598:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010259b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010259e:	8b 04 85 00 75 10 80 	mov    -0x7fef8b00(,%eax,4),%eax
801025a5:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025a9:	74 c3                	je     8010256e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
801025ab:	8d 50 9f             	lea    -0x61(%eax),%edx
801025ae:	83 fa 19             	cmp    $0x19,%edx
801025b1:	77 1d                	ja     801025d0 <kbdgetc+0xb0>
      c += 'A' - 'a';
801025b3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025b6:	5d                   	pop    %ebp
801025b7:	c3                   	ret    
801025b8:	90                   	nop
801025b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
801025c0:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801025c2:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025c9:	5d                   	pop    %ebp
801025ca:	c3                   	ret    
801025cb:	90                   	nop
801025cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801025d0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025d3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801025d6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801025d7:	83 f9 19             	cmp    $0x19,%ecx
801025da:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801025dd:	c3                   	ret    
801025de:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801025e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025e5:	5d                   	pop    %ebp
801025e6:	c3                   	ret    
801025e7:	89 f6                	mov    %esi,%esi
801025e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025f0 <kbdintr>:

void
kbdintr(void)
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801025f6:	68 20 25 10 80       	push   $0x80102520
801025fb:	e8 00 e2 ff ff       	call   80100800 <consoleintr>
}
80102600:	83 c4 10             	add    $0x10,%esp
80102603:	c9                   	leave  
80102604:	c3                   	ret    
80102605:	66 90                	xchg   %ax,%ax
80102607:	66 90                	xchg   %ax,%ax
80102609:	66 90                	xchg   %ax,%ax
8010260b:	66 90                	xchg   %ax,%ax
8010260d:	66 90                	xchg   %ax,%ax
8010260f:	90                   	nop

80102610 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102610:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102615:	55                   	push   %ebp
80102616:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102618:	85 c0                	test   %eax,%eax
8010261a:	0f 84 c8 00 00 00    	je     801026e8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102620:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102627:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010262a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010262d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102634:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102637:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010263a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102641:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102644:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102647:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010264e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102651:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102654:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010265b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010265e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102661:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102668:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010266b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010266e:	8b 50 30             	mov    0x30(%eax),%edx
80102671:	c1 ea 10             	shr    $0x10,%edx
80102674:	80 fa 03             	cmp    $0x3,%dl
80102677:	77 77                	ja     801026f0 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102679:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102680:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102683:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102686:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010268d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102690:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102693:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010269a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010269d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026a0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026a7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026aa:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ad:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026b4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ba:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026c1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026c4:	8b 50 20             	mov    0x20(%eax),%edx
801026c7:	89 f6                	mov    %esi,%esi
801026c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026d0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026d6:	80 e6 10             	and    $0x10,%dh
801026d9:	75 f5                	jne    801026d0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026db:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801026e2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801026e8:	5d                   	pop    %ebp
801026e9:	c3                   	ret    
801026ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026f0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801026f7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026fa:	8b 50 20             	mov    0x20(%eax),%edx
801026fd:	e9 77 ff ff ff       	jmp    80102679 <lapicinit+0x69>
80102702:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102710 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102710:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102715:	55                   	push   %ebp
80102716:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102718:	85 c0                	test   %eax,%eax
8010271a:	74 0c                	je     80102728 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010271c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010271f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102720:	c1 e8 18             	shr    $0x18,%eax
}
80102723:	c3                   	ret    
80102724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102728:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010272a:	5d                   	pop    %ebp
8010272b:	c3                   	ret    
8010272c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102730 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102730:	a1 7c 26 11 80       	mov    0x8011267c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102735:	55                   	push   %ebp
80102736:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102738:	85 c0                	test   %eax,%eax
8010273a:	74 0d                	je     80102749 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010273c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102743:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102746:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102749:	5d                   	pop    %ebp
8010274a:	c3                   	ret    
8010274b:	90                   	nop
8010274c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102750 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102750:	55                   	push   %ebp
80102751:	89 e5                	mov    %esp,%ebp
}
80102753:	5d                   	pop    %ebp
80102754:	c3                   	ret    
80102755:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102760:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102761:	ba 70 00 00 00       	mov    $0x70,%edx
80102766:	b8 0f 00 00 00       	mov    $0xf,%eax
8010276b:	89 e5                	mov    %esp,%ebp
8010276d:	53                   	push   %ebx
8010276e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102771:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102774:	ee                   	out    %al,(%dx)
80102775:	ba 71 00 00 00       	mov    $0x71,%edx
8010277a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010277f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102780:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102782:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102785:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010278b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010278d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102790:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102793:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102795:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102798:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010279e:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801027a3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027a9:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027b3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b6:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027c0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c3:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027cc:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027cf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027d8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027de:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027e1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027e7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801027ea:	5b                   	pop    %ebx
801027eb:	5d                   	pop    %ebp
801027ec:	c3                   	ret    
801027ed:	8d 76 00             	lea    0x0(%esi),%esi

801027f0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801027f0:	55                   	push   %ebp
801027f1:	ba 70 00 00 00       	mov    $0x70,%edx
801027f6:	b8 0b 00 00 00       	mov    $0xb,%eax
801027fb:	89 e5                	mov    %esp,%ebp
801027fd:	57                   	push   %edi
801027fe:	56                   	push   %esi
801027ff:	53                   	push   %ebx
80102800:	83 ec 4c             	sub    $0x4c,%esp
80102803:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102804:	ba 71 00 00 00       	mov    $0x71,%edx
80102809:	ec                   	in     (%dx),%al
8010280a:	83 e0 04             	and    $0x4,%eax
8010280d:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102810:	31 db                	xor    %ebx,%ebx
80102812:	88 45 b7             	mov    %al,-0x49(%ebp)
80102815:	bf 70 00 00 00       	mov    $0x70,%edi
8010281a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102820:	89 d8                	mov    %ebx,%eax
80102822:	89 fa                	mov    %edi,%edx
80102824:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102825:	b9 71 00 00 00       	mov    $0x71,%ecx
8010282a:	89 ca                	mov    %ecx,%edx
8010282c:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010282d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102830:	89 fa                	mov    %edi,%edx
80102832:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102835:	b8 02 00 00 00       	mov    $0x2,%eax
8010283a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010283b:	89 ca                	mov    %ecx,%edx
8010283d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010283e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102841:	89 fa                	mov    %edi,%edx
80102843:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102846:	b8 04 00 00 00       	mov    $0x4,%eax
8010284b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284c:	89 ca                	mov    %ecx,%edx
8010284e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010284f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102852:	89 fa                	mov    %edi,%edx
80102854:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102857:	b8 07 00 00 00       	mov    $0x7,%eax
8010285c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285d:	89 ca                	mov    %ecx,%edx
8010285f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102860:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102863:	89 fa                	mov    %edi,%edx
80102865:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102868:	b8 08 00 00 00       	mov    $0x8,%eax
8010286d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286e:	89 ca                	mov    %ecx,%edx
80102870:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102871:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102874:	89 fa                	mov    %edi,%edx
80102876:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102879:	b8 09 00 00 00       	mov    $0x9,%eax
8010287e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287f:	89 ca                	mov    %ecx,%edx
80102881:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102882:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102885:	89 fa                	mov    %edi,%edx
80102887:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010288a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010288f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102890:	89 ca                	mov    %ecx,%edx
80102892:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102893:	84 c0                	test   %al,%al
80102895:	78 89                	js     80102820 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102897:	89 d8                	mov    %ebx,%eax
80102899:	89 fa                	mov    %edi,%edx
8010289b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289c:	89 ca                	mov    %ecx,%edx
8010289e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010289f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a2:	89 fa                	mov    %edi,%edx
801028a4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028a7:	b8 02 00 00 00       	mov    $0x2,%eax
801028ac:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ad:	89 ca                	mov    %ecx,%edx
801028af:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801028b0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b3:	89 fa                	mov    %edi,%edx
801028b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028b8:	b8 04 00 00 00       	mov    $0x4,%eax
801028bd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028be:	89 ca                	mov    %ecx,%edx
801028c0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801028c1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028c4:	89 fa                	mov    %edi,%edx
801028c6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028c9:	b8 07 00 00 00       	mov    $0x7,%eax
801028ce:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028cf:	89 ca                	mov    %ecx,%edx
801028d1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801028d2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d5:	89 fa                	mov    %edi,%edx
801028d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801028da:	b8 08 00 00 00       	mov    $0x8,%eax
801028df:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e0:	89 ca                	mov    %ecx,%edx
801028e2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801028e3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e6:	89 fa                	mov    %edi,%edx
801028e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028eb:	b8 09 00 00 00       	mov    $0x9,%eax
801028f0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f1:	89 ca                	mov    %ecx,%edx
801028f3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801028f4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028f7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
801028fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028fd:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102900:	6a 18                	push   $0x18
80102902:	56                   	push   %esi
80102903:	50                   	push   %eax
80102904:	e8 f7 1d 00 00       	call   80104700 <memcmp>
80102909:	83 c4 10             	add    $0x10,%esp
8010290c:	85 c0                	test   %eax,%eax
8010290e:	0f 85 0c ff ff ff    	jne    80102820 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102914:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102918:	75 78                	jne    80102992 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010291a:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010291d:	89 c2                	mov    %eax,%edx
8010291f:	83 e0 0f             	and    $0xf,%eax
80102922:	c1 ea 04             	shr    $0x4,%edx
80102925:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102928:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010292b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010292e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102931:	89 c2                	mov    %eax,%edx
80102933:	83 e0 0f             	and    $0xf,%eax
80102936:	c1 ea 04             	shr    $0x4,%edx
80102939:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010293c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010293f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102942:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102945:	89 c2                	mov    %eax,%edx
80102947:	83 e0 0f             	and    $0xf,%eax
8010294a:	c1 ea 04             	shr    $0x4,%edx
8010294d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102950:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102953:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102956:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102959:	89 c2                	mov    %eax,%edx
8010295b:	83 e0 0f             	and    $0xf,%eax
8010295e:	c1 ea 04             	shr    $0x4,%edx
80102961:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102964:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102967:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010296a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010296d:	89 c2                	mov    %eax,%edx
8010296f:	83 e0 0f             	and    $0xf,%eax
80102972:	c1 ea 04             	shr    $0x4,%edx
80102975:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102978:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010297e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102981:	89 c2                	mov    %eax,%edx
80102983:	83 e0 0f             	and    $0xf,%eax
80102986:	c1 ea 04             	shr    $0x4,%edx
80102989:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010298f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102992:	8b 75 08             	mov    0x8(%ebp),%esi
80102995:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102998:	89 06                	mov    %eax,(%esi)
8010299a:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010299d:	89 46 04             	mov    %eax,0x4(%esi)
801029a0:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029a3:	89 46 08             	mov    %eax,0x8(%esi)
801029a6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029a9:	89 46 0c             	mov    %eax,0xc(%esi)
801029ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029af:	89 46 10             	mov    %eax,0x10(%esi)
801029b2:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029b5:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029b8:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801029bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029c2:	5b                   	pop    %ebx
801029c3:	5e                   	pop    %esi
801029c4:	5f                   	pop    %edi
801029c5:	5d                   	pop    %ebp
801029c6:	c3                   	ret    
801029c7:	66 90                	xchg   %ax,%ax
801029c9:	66 90                	xchg   %ax,%ax
801029cb:	66 90                	xchg   %ax,%ax
801029cd:	66 90                	xchg   %ax,%ax
801029cf:	90                   	nop

801029d0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029d0:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
801029d6:	85 c9                	test   %ecx,%ecx
801029d8:	0f 8e 85 00 00 00    	jle    80102a63 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801029de:	55                   	push   %ebp
801029df:	89 e5                	mov    %esp,%ebp
801029e1:	57                   	push   %edi
801029e2:	56                   	push   %esi
801029e3:	53                   	push   %ebx
801029e4:	31 db                	xor    %ebx,%ebx
801029e6:	83 ec 0c             	sub    $0xc,%esp
801029e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801029f0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
801029f5:	83 ec 08             	sub    $0x8,%esp
801029f8:	01 d8                	add    %ebx,%eax
801029fa:	83 c0 01             	add    $0x1,%eax
801029fd:	50                   	push   %eax
801029fe:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a04:	e8 c7 d6 ff ff       	call   801000d0 <bread>
80102a09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a0b:	58                   	pop    %eax
80102a0c:	5a                   	pop    %edx
80102a0d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102a14:	ff 35 c4 26 11 80    	pushl  0x801126c4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a1a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a1d:	e8 ae d6 ff ff       	call   801000d0 <bread>
80102a22:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a24:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a27:	83 c4 0c             	add    $0xc,%esp
80102a2a:	68 00 02 00 00       	push   $0x200
80102a2f:	50                   	push   %eax
80102a30:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a33:	50                   	push   %eax
80102a34:	e8 27 1d 00 00       	call   80104760 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a39:	89 34 24             	mov    %esi,(%esp)
80102a3c:	e8 5f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a41:	89 3c 24             	mov    %edi,(%esp)
80102a44:	e8 97 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a49:	89 34 24             	mov    %esi,(%esp)
80102a4c:	e8 8f d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a51:	83 c4 10             	add    $0x10,%esp
80102a54:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102a5a:	7f 94                	jg     801029f0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a5f:	5b                   	pop    %ebx
80102a60:	5e                   	pop    %esi
80102a61:	5f                   	pop    %edi
80102a62:	5d                   	pop    %ebp
80102a63:	f3 c3                	repz ret 
80102a65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a70 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a70:	55                   	push   %ebp
80102a71:	89 e5                	mov    %esp,%ebp
80102a73:	53                   	push   %ebx
80102a74:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a77:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102a7d:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a83:	e8 48 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a88:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102a8e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102a91:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102a93:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a95:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102a98:	7e 1f                	jle    80102ab9 <write_head+0x49>
80102a9a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102aa1:	31 d2                	xor    %edx,%edx
80102aa3:	90                   	nop
80102aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102aa8:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102aae:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102ab2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ab5:	39 c2                	cmp    %eax,%edx
80102ab7:	75 ef                	jne    80102aa8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102ab9:	83 ec 0c             	sub    $0xc,%esp
80102abc:	53                   	push   %ebx
80102abd:	e8 de d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102ac2:	89 1c 24             	mov    %ebx,(%esp)
80102ac5:	e8 16 d7 ff ff       	call   801001e0 <brelse>
}
80102aca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102acd:	c9                   	leave  
80102ace:	c3                   	ret    
80102acf:	90                   	nop

80102ad0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	53                   	push   %ebx
80102ad4:	83 ec 2c             	sub    $0x2c,%esp
80102ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102ada:	68 20 77 10 80       	push   $0x80107720
80102adf:	68 80 26 11 80       	push   $0x80112680
80102ae4:	e8 57 19 00 00       	call   80104440 <initlock>
  readsb(dev, &sb);
80102ae9:	58                   	pop    %eax
80102aea:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102aed:	5a                   	pop    %edx
80102aee:	50                   	push   %eax
80102aef:	53                   	push   %ebx
80102af0:	e8 cb e8 ff ff       	call   801013c0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102af5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102af8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102afb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102afc:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b02:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b08:	a3 b4 26 11 80       	mov    %eax,0x801126b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b0d:	5a                   	pop    %edx
80102b0e:	50                   	push   %eax
80102b0f:	53                   	push   %ebx
80102b10:	e8 bb d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b15:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b18:	83 c4 10             	add    $0x10,%esp
80102b1b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b1d:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102b23:	7e 1c                	jle    80102b41 <initlog+0x71>
80102b25:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102b2c:	31 d2                	xor    %edx,%edx
80102b2e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102b30:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b34:	83 c2 04             	add    $0x4,%edx
80102b37:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b3d:	39 da                	cmp    %ebx,%edx
80102b3f:	75 ef                	jne    80102b30 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b41:	83 ec 0c             	sub    $0xc,%esp
80102b44:	50                   	push   %eax
80102b45:	e8 96 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b4a:	e8 81 fe ff ff       	call   801029d0 <install_trans>
  log.lh.n = 0;
80102b4f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102b56:	00 00 00 
  write_head(); // clear the log
80102b59:	e8 12 ff ff ff       	call   80102a70 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102b5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b61:	c9                   	leave  
80102b62:	c3                   	ret    
80102b63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b70 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102b76:	68 80 26 11 80       	push   $0x80112680
80102b7b:	e8 c0 19 00 00       	call   80104540 <acquire>
80102b80:	83 c4 10             	add    $0x10,%esp
80102b83:	eb 18                	jmp    80102b9d <begin_op+0x2d>
80102b85:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b88:	83 ec 08             	sub    $0x8,%esp
80102b8b:	68 80 26 11 80       	push   $0x80112680
80102b90:	68 80 26 11 80       	push   $0x80112680
80102b95:	e8 06 14 00 00       	call   80103fa0 <sleep>
80102b9a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102b9d:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102ba2:	85 c0                	test   %eax,%eax
80102ba4:	75 e2                	jne    80102b88 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ba6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102bab:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102bb1:	83 c0 01             	add    $0x1,%eax
80102bb4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102bb7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bba:	83 fa 1e             	cmp    $0x1e,%edx
80102bbd:	7f c9                	jg     80102b88 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bbf:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102bc2:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102bc7:	68 80 26 11 80       	push   $0x80112680
80102bcc:	e8 8f 1a 00 00       	call   80104660 <release>
      break;
    }
  }
}
80102bd1:	83 c4 10             	add    $0x10,%esp
80102bd4:	c9                   	leave  
80102bd5:	c3                   	ret    
80102bd6:	8d 76 00             	lea    0x0(%esi),%esi
80102bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102be0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102be0:	55                   	push   %ebp
80102be1:	89 e5                	mov    %esp,%ebp
80102be3:	57                   	push   %edi
80102be4:	56                   	push   %esi
80102be5:	53                   	push   %ebx
80102be6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102be9:	68 80 26 11 80       	push   $0x80112680
80102bee:	e8 4d 19 00 00       	call   80104540 <acquire>
  log.outstanding -= 1;
80102bf3:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102bf8:	8b 1d c0 26 11 80    	mov    0x801126c0,%ebx
80102bfe:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c01:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102c04:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c06:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80102c0b:	0f 85 23 01 00 00    	jne    80102d34 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102c11:	85 c0                	test   %eax,%eax
80102c13:	0f 85 f7 00 00 00    	jne    80102d10 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c19:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102c1c:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102c23:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c26:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c28:	68 80 26 11 80       	push   $0x80112680
80102c2d:	e8 2e 1a 00 00       	call   80104660 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c32:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c38:	83 c4 10             	add    $0x10,%esp
80102c3b:	85 c9                	test   %ecx,%ecx
80102c3d:	0f 8e 8a 00 00 00    	jle    80102ccd <end_op+0xed>
80102c43:	90                   	nop
80102c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c48:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102c4d:	83 ec 08             	sub    $0x8,%esp
80102c50:	01 d8                	add    %ebx,%eax
80102c52:	83 c0 01             	add    $0x1,%eax
80102c55:	50                   	push   %eax
80102c56:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102c5c:	e8 6f d4 ff ff       	call   801000d0 <bread>
80102c61:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c63:	58                   	pop    %eax
80102c64:	5a                   	pop    %edx
80102c65:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102c6c:	ff 35 c4 26 11 80    	pushl  0x801126c4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c72:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c75:	e8 56 d4 ff ff       	call   801000d0 <bread>
80102c7a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c7c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c7f:	83 c4 0c             	add    $0xc,%esp
80102c82:	68 00 02 00 00       	push   $0x200
80102c87:	50                   	push   %eax
80102c88:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c8b:	50                   	push   %eax
80102c8c:	e8 cf 1a 00 00       	call   80104760 <memmove>
    bwrite(to);  // write the log
80102c91:	89 34 24             	mov    %esi,(%esp)
80102c94:	e8 07 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c99:	89 3c 24             	mov    %edi,(%esp)
80102c9c:	e8 3f d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ca1:	89 34 24             	mov    %esi,(%esp)
80102ca4:	e8 37 d5 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ca9:	83 c4 10             	add    $0x10,%esp
80102cac:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102cb2:	7c 94                	jl     80102c48 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cb4:	e8 b7 fd ff ff       	call   80102a70 <write_head>
    install_trans(); // Now install writes to home locations
80102cb9:	e8 12 fd ff ff       	call   801029d0 <install_trans>
    log.lh.n = 0;
80102cbe:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102cc5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cc8:	e8 a3 fd ff ff       	call   80102a70 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102ccd:	83 ec 0c             	sub    $0xc,%esp
80102cd0:	68 80 26 11 80       	push   $0x80112680
80102cd5:	e8 66 18 00 00       	call   80104540 <acquire>
    log.committing = 0;
    wakeup(&log);
80102cda:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102ce1:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102ce8:	00 00 00 
    wakeup(&log);
80102ceb:	e8 90 14 00 00       	call   80104180 <wakeup>
    release(&log.lock);
80102cf0:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102cf7:	e8 64 19 00 00       	call   80104660 <release>
80102cfc:	83 c4 10             	add    $0x10,%esp
  }
}
80102cff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d02:	5b                   	pop    %ebx
80102d03:	5e                   	pop    %esi
80102d04:	5f                   	pop    %edi
80102d05:	5d                   	pop    %ebp
80102d06:	c3                   	ret    
80102d07:	89 f6                	mov    %esi,%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102d10:	83 ec 0c             	sub    $0xc,%esp
80102d13:	68 80 26 11 80       	push   $0x80112680
80102d18:	e8 63 14 00 00       	call   80104180 <wakeup>
  }
  release(&log.lock);
80102d1d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d24:	e8 37 19 00 00       	call   80104660 <release>
80102d29:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102d2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d2f:	5b                   	pop    %ebx
80102d30:	5e                   	pop    %esi
80102d31:	5f                   	pop    %edi
80102d32:	5d                   	pop    %ebp
80102d33:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d34:	83 ec 0c             	sub    $0xc,%esp
80102d37:	68 24 77 10 80       	push   $0x80107724
80102d3c:	e8 3f d6 ff ff       	call   80100380 <panic>
80102d41:	eb 0d                	jmp    80102d50 <log_write>
80102d43:	90                   	nop
80102d44:	90                   	nop
80102d45:	90                   	nop
80102d46:	90                   	nop
80102d47:	90                   	nop
80102d48:	90                   	nop
80102d49:	90                   	nop
80102d4a:	90                   	nop
80102d4b:	90                   	nop
80102d4c:	90                   	nop
80102d4d:	90                   	nop
80102d4e:	90                   	nop
80102d4f:	90                   	nop

80102d50 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d50:	55                   	push   %ebp
80102d51:	89 e5                	mov    %esp,%ebp
80102d53:	53                   	push   %ebx
80102d54:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d57:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d60:	83 fa 1d             	cmp    $0x1d,%edx
80102d63:	0f 8f 97 00 00 00    	jg     80102e00 <log_write+0xb0>
80102d69:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102d6e:	83 e8 01             	sub    $0x1,%eax
80102d71:	39 c2                	cmp    %eax,%edx
80102d73:	0f 8d 87 00 00 00    	jge    80102e00 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d79:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102d7e:	85 c0                	test   %eax,%eax
80102d80:	0f 8e 87 00 00 00    	jle    80102e0d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d86:	83 ec 0c             	sub    $0xc,%esp
80102d89:	68 80 26 11 80       	push   $0x80112680
80102d8e:	e8 ad 17 00 00       	call   80104540 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d93:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102d99:	83 c4 10             	add    $0x10,%esp
80102d9c:	83 fa 00             	cmp    $0x0,%edx
80102d9f:	7e 50                	jle    80102df1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102da1:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102da4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102da6:	3b 0d cc 26 11 80    	cmp    0x801126cc,%ecx
80102dac:	75 0b                	jne    80102db9 <log_write+0x69>
80102dae:	eb 38                	jmp    80102de8 <log_write+0x98>
80102db0:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102db7:	74 2f                	je     80102de8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102db9:	83 c0 01             	add    $0x1,%eax
80102dbc:	39 d0                	cmp    %edx,%eax
80102dbe:	75 f0                	jne    80102db0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102dc0:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102dc7:	83 c2 01             	add    $0x1,%edx
80102dca:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102dd0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102dd3:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102dda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ddd:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102dde:	e9 7d 18 00 00       	jmp    80104660 <release>
80102de3:	90                   	nop
80102de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102de8:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
80102def:	eb df                	jmp    80102dd0 <log_write+0x80>
80102df1:	8b 43 08             	mov    0x8(%ebx),%eax
80102df4:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102df9:	75 d5                	jne    80102dd0 <log_write+0x80>
80102dfb:	eb ca                	jmp    80102dc7 <log_write+0x77>
80102dfd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e00:	83 ec 0c             	sub    $0xc,%esp
80102e03:	68 33 77 10 80       	push   $0x80107733
80102e08:	e8 73 d5 ff ff       	call   80100380 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e0d:	83 ec 0c             	sub    $0xc,%esp
80102e10:	68 49 77 10 80       	push   $0x80107749
80102e15:	e8 66 d5 ff ff       	call   80100380 <panic>
80102e1a:	66 90                	xchg   %ax,%ax
80102e1c:	66 90                	xchg   %ax,%ax
80102e1e:	66 90                	xchg   %ax,%ax

80102e20 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	53                   	push   %ebx
80102e24:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e27:	e8 64 09 00 00       	call   80103790 <cpuid>
80102e2c:	89 c3                	mov    %eax,%ebx
80102e2e:	e8 5d 09 00 00       	call   80103790 <cpuid>
80102e33:	83 ec 04             	sub    $0x4,%esp
80102e36:	53                   	push   %ebx
80102e37:	50                   	push   %eax
80102e38:	68 64 77 10 80       	push   $0x80107764
80102e3d:	e8 2e d8 ff ff       	call   80100670 <cprintf>
  idtinit();       // load idt register
80102e42:	e8 19 2c 00 00       	call   80105a60 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e47:	e8 c4 08 00 00       	call   80103710 <mycpu>
80102e4c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e4e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e5a:	e8 d1 0c 00 00       	call   80103b30 <scheduler>
80102e5f:	90                   	nop

80102e60 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e66:	e8 45 3d 00 00       	call   80106bb0 <switchkvm>
  seginit();
80102e6b:	e8 40 3c 00 00       	call   80106ab0 <seginit>
  lapicinit();
80102e70:	e8 9b f7 ff ff       	call   80102610 <lapicinit>
  mpmain();
80102e75:	e8 a6 ff ff ff       	call   80102e20 <mpmain>
80102e7a:	66 90                	xchg   %ax,%ax
80102e7c:	66 90                	xchg   %ax,%ax
80102e7e:	66 90                	xchg   %ax,%ax

80102e80 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102e80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102e84:	83 e4 f0             	and    $0xfffffff0,%esp
80102e87:	ff 71 fc             	pushl  -0x4(%ecx)
80102e8a:	55                   	push   %ebp
80102e8b:	89 e5                	mov    %esp,%ebp
80102e8d:	53                   	push   %ebx
80102e8e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102e8f:	bb 80 27 11 80       	mov    $0x80112780,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e94:	83 ec 08             	sub    $0x8,%esp
80102e97:	68 00 00 40 80       	push   $0x80400000
80102e9c:	68 a8 6d 11 80       	push   $0x80116da8
80102ea1:	e8 3a f5 ff ff       	call   801023e0 <kinit1>
  kvmalloc();      // kernel page table
80102ea6:	e8 a5 41 00 00       	call   80107050 <kvmalloc>
  mpinit();        // detect other processors
80102eab:	e8 70 01 00 00       	call   80103020 <mpinit>
  lapicinit();     // interrupt controller
80102eb0:	e8 5b f7 ff ff       	call   80102610 <lapicinit>
  seginit();       // segment descriptors
80102eb5:	e8 f6 3b 00 00       	call   80106ab0 <seginit>
  picinit();       // disable pic
80102eba:	e8 31 03 00 00       	call   801031f0 <picinit>
  ioapicinit();    // another interrupt controller
80102ebf:	e8 4c f3 ff ff       	call   80102210 <ioapicinit>
  consoleinit();   // console hardware
80102ec4:	e8 e7 da ff ff       	call   801009b0 <consoleinit>
  uartinit();      // serial port
80102ec9:	e8 b2 2e 00 00       	call   80105d80 <uartinit>
  pinit();         // process table
80102ece:	e8 1d 08 00 00       	call   801036f0 <pinit>
  tvinit();        // trap vectors
80102ed3:	e8 e8 2a 00 00       	call   801059c0 <tvinit>
  binit();         // buffer cache
80102ed8:	e8 63 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102edd:	e8 7e de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102ee2:	e8 09 f1 ff ff       	call   80101ff0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102ee7:	83 c4 0c             	add    $0xc,%esp
80102eea:	68 8a 00 00 00       	push   $0x8a
80102eef:	68 8c a4 10 80       	push   $0x8010a48c
80102ef4:	68 00 70 00 80       	push   $0x80007000
80102ef9:	e8 62 18 00 00       	call   80104760 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102efe:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f05:	00 00 00 
80102f08:	83 c4 10             	add    $0x10,%esp
80102f0b:	05 80 27 11 80       	add    $0x80112780,%eax
80102f10:	39 d8                	cmp    %ebx,%eax
80102f12:	76 6f                	jbe    80102f83 <main+0x103>
80102f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102f18:	e8 f3 07 00 00       	call   80103710 <mycpu>
80102f1d:	39 d8                	cmp    %ebx,%eax
80102f1f:	74 49                	je     80102f6a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f21:	e8 8a f5 ff ff       	call   801024b0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f26:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80102f2b:	c7 05 f8 6f 00 80 60 	movl   $0x80102e60,0x80006ff8
80102f32:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f35:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f3c:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f3f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f44:	0f b6 03             	movzbl (%ebx),%eax
80102f47:	83 ec 08             	sub    $0x8,%esp
80102f4a:	68 00 70 00 00       	push   $0x7000
80102f4f:	50                   	push   %eax
80102f50:	e8 0b f8 ff ff       	call   80102760 <lapicstartap>
80102f55:	83 c4 10             	add    $0x10,%esp
80102f58:	90                   	nop
80102f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f60:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f66:	85 c0                	test   %eax,%eax
80102f68:	74 f6                	je     80102f60 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f6a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f71:	00 00 00 
80102f74:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f7a:	05 80 27 11 80       	add    $0x80112780,%eax
80102f7f:	39 c3                	cmp    %eax,%ebx
80102f81:	72 95                	jb     80102f18 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f83:	83 ec 08             	sub    $0x8,%esp
80102f86:	68 00 00 00 8e       	push   $0x8e000000
80102f8b:	68 00 00 40 80       	push   $0x80400000
80102f90:	e8 bb f4 ff ff       	call   80102450 <kinit2>
  userinit();      // first user process
80102f95:	e8 46 08 00 00       	call   801037e0 <userinit>
  mpmain();        // finish this processor's setup
80102f9a:	e8 81 fe ff ff       	call   80102e20 <mpmain>
80102f9f:	90                   	nop

80102fa0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fa0:	55                   	push   %ebp
80102fa1:	89 e5                	mov    %esp,%ebp
80102fa3:	57                   	push   %edi
80102fa4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fa5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fab:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102fac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102faf:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102fb2:	39 de                	cmp    %ebx,%esi
80102fb4:	73 48                	jae    80102ffe <mpsearch1+0x5e>
80102fb6:	8d 76 00             	lea    0x0(%esi),%esi
80102fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fc0:	83 ec 04             	sub    $0x4,%esp
80102fc3:	8d 7e 10             	lea    0x10(%esi),%edi
80102fc6:	6a 04                	push   $0x4
80102fc8:	68 78 77 10 80       	push   $0x80107778
80102fcd:	56                   	push   %esi
80102fce:	e8 2d 17 00 00       	call   80104700 <memcmp>
80102fd3:	83 c4 10             	add    $0x10,%esp
80102fd6:	85 c0                	test   %eax,%eax
80102fd8:	75 1e                	jne    80102ff8 <mpsearch1+0x58>
80102fda:	8d 7e 10             	lea    0x10(%esi),%edi
80102fdd:	89 f2                	mov    %esi,%edx
80102fdf:	31 c9                	xor    %ecx,%ecx
80102fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80102fe8:	0f b6 02             	movzbl (%edx),%eax
80102feb:	83 c2 01             	add    $0x1,%edx
80102fee:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102ff0:	39 fa                	cmp    %edi,%edx
80102ff2:	75 f4                	jne    80102fe8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102ff4:	84 c9                	test   %cl,%cl
80102ff6:	74 10                	je     80103008 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102ff8:	39 fb                	cmp    %edi,%ebx
80102ffa:	89 fe                	mov    %edi,%esi
80102ffc:	77 c2                	ja     80102fc0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
80102ffe:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103001:	31 c0                	xor    %eax,%eax
}
80103003:	5b                   	pop    %ebx
80103004:	5e                   	pop    %esi
80103005:	5f                   	pop    %edi
80103006:	5d                   	pop    %ebp
80103007:	c3                   	ret    
80103008:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010300b:	89 f0                	mov    %esi,%eax
8010300d:	5b                   	pop    %ebx
8010300e:	5e                   	pop    %esi
8010300f:	5f                   	pop    %edi
80103010:	5d                   	pop    %ebp
80103011:	c3                   	ret    
80103012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103020 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103020:	55                   	push   %ebp
80103021:	89 e5                	mov    %esp,%ebp
80103023:	57                   	push   %edi
80103024:	56                   	push   %esi
80103025:	53                   	push   %ebx
80103026:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103029:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103030:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103037:	c1 e0 08             	shl    $0x8,%eax
8010303a:	09 d0                	or     %edx,%eax
8010303c:	c1 e0 04             	shl    $0x4,%eax
8010303f:	85 c0                	test   %eax,%eax
80103041:	75 1b                	jne    8010305e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103043:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010304a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103051:	c1 e0 08             	shl    $0x8,%eax
80103054:	09 d0                	or     %edx,%eax
80103056:	c1 e0 0a             	shl    $0xa,%eax
80103059:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010305e:	ba 00 04 00 00       	mov    $0x400,%edx
80103063:	e8 38 ff ff ff       	call   80102fa0 <mpsearch1>
80103068:	85 c0                	test   %eax,%eax
8010306a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010306d:	0f 84 37 01 00 00    	je     801031aa <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103073:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103076:	8b 58 04             	mov    0x4(%eax),%ebx
80103079:	85 db                	test   %ebx,%ebx
8010307b:	0f 84 43 01 00 00    	je     801031c4 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103081:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103087:	83 ec 04             	sub    $0x4,%esp
8010308a:	6a 04                	push   $0x4
8010308c:	68 7d 77 10 80       	push   $0x8010777d
80103091:	56                   	push   %esi
80103092:	e8 69 16 00 00       	call   80104700 <memcmp>
80103097:	83 c4 10             	add    $0x10,%esp
8010309a:	85 c0                	test   %eax,%eax
8010309c:	0f 85 22 01 00 00    	jne    801031c4 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801030a2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030a9:	3c 01                	cmp    $0x1,%al
801030ab:	74 08                	je     801030b5 <mpinit+0x95>
801030ad:	3c 04                	cmp    $0x4,%al
801030af:	0f 85 0f 01 00 00    	jne    801031c4 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030b5:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030bc:	85 ff                	test   %edi,%edi
801030be:	74 21                	je     801030e1 <mpinit+0xc1>
801030c0:	31 d2                	xor    %edx,%edx
801030c2:	31 c0                	xor    %eax,%eax
801030c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801030c8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801030cf:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030d0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801030d3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030d5:	39 c7                	cmp    %eax,%edi
801030d7:	75 ef                	jne    801030c8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030d9:	84 d2                	test   %dl,%dl
801030db:	0f 85 e3 00 00 00    	jne    801031c4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801030e1:	85 f6                	test   %esi,%esi
801030e3:	0f 84 db 00 00 00    	je     801031c4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801030e9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801030ef:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030f4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801030fb:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103101:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103106:	01 d6                	add    %edx,%esi
80103108:	90                   	nop
80103109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103110:	39 c6                	cmp    %eax,%esi
80103112:	76 23                	jbe    80103137 <mpinit+0x117>
80103114:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103117:	80 fa 04             	cmp    $0x4,%dl
8010311a:	0f 87 c0 00 00 00    	ja     801031e0 <mpinit+0x1c0>
80103120:	ff 24 95 bc 77 10 80 	jmp    *-0x7fef8844(,%edx,4)
80103127:	89 f6                	mov    %esi,%esi
80103129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103130:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103133:	39 c6                	cmp    %eax,%esi
80103135:	77 dd                	ja     80103114 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103137:	85 db                	test   %ebx,%ebx
80103139:	0f 84 92 00 00 00    	je     801031d1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010313f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103142:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103146:	74 15                	je     8010315d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103148:	ba 22 00 00 00       	mov    $0x22,%edx
8010314d:	b8 70 00 00 00       	mov    $0x70,%eax
80103152:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103153:	ba 23 00 00 00       	mov    $0x23,%edx
80103158:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103159:	83 c8 01             	or     $0x1,%eax
8010315c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010315d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103160:	5b                   	pop    %ebx
80103161:	5e                   	pop    %esi
80103162:	5f                   	pop    %edi
80103163:	5d                   	pop    %ebp
80103164:	c3                   	ret    
80103165:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103168:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
8010316e:	83 f9 07             	cmp    $0x7,%ecx
80103171:	7f 19                	jg     8010318c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103173:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103177:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010317d:	83 c1 01             	add    $0x1,%ecx
80103180:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103186:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010318c:	83 c0 14             	add    $0x14,%eax
      continue;
8010318f:	e9 7c ff ff ff       	jmp    80103110 <mpinit+0xf0>
80103194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103198:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010319c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010319f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      p += sizeof(struct mpioapic);
      continue;
801031a5:	e9 66 ff ff ff       	jmp    80103110 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031aa:	ba 00 00 01 00       	mov    $0x10000,%edx
801031af:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031b4:	e8 e7 fd ff ff       	call   80102fa0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031b9:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031be:	0f 85 af fe ff ff    	jne    80103073 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801031c4:	83 ec 0c             	sub    $0xc,%esp
801031c7:	68 82 77 10 80       	push   $0x80107782
801031cc:	e8 af d1 ff ff       	call   80100380 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801031d1:	83 ec 0c             	sub    $0xc,%esp
801031d4:	68 9c 77 10 80       	push   $0x8010779c
801031d9:	e8 a2 d1 ff ff       	call   80100380 <panic>
801031de:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031e0:	31 db                	xor    %ebx,%ebx
801031e2:	e9 30 ff ff ff       	jmp    80103117 <mpinit+0xf7>
801031e7:	66 90                	xchg   %ax,%ax
801031e9:	66 90                	xchg   %ax,%ax
801031eb:	66 90                	xchg   %ax,%ax
801031ed:	66 90                	xchg   %ax,%ax
801031ef:	90                   	nop

801031f0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801031f0:	55                   	push   %ebp
801031f1:	ba 21 00 00 00       	mov    $0x21,%edx
801031f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801031fb:	89 e5                	mov    %esp,%ebp
801031fd:	ee                   	out    %al,(%dx)
801031fe:	ba a1 00 00 00       	mov    $0xa1,%edx
80103203:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103204:	5d                   	pop    %ebp
80103205:	c3                   	ret    
80103206:	66 90                	xchg   %ax,%ax
80103208:	66 90                	xchg   %ax,%ax
8010320a:	66 90                	xchg   %ax,%ax
8010320c:	66 90                	xchg   %ax,%ax
8010320e:	66 90                	xchg   %ax,%ax

80103210 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103210:	55                   	push   %ebp
80103211:	89 e5                	mov    %esp,%ebp
80103213:	57                   	push   %edi
80103214:	56                   	push   %esi
80103215:	53                   	push   %ebx
80103216:	83 ec 0c             	sub    $0xc,%esp
80103219:	8b 75 08             	mov    0x8(%ebp),%esi
8010321c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010321f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103225:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010322b:	e8 50 db ff ff       	call   80100d80 <filealloc>
80103230:	85 c0                	test   %eax,%eax
80103232:	89 06                	mov    %eax,(%esi)
80103234:	0f 84 a8 00 00 00    	je     801032e2 <pipealloc+0xd2>
8010323a:	e8 41 db ff ff       	call   80100d80 <filealloc>
8010323f:	85 c0                	test   %eax,%eax
80103241:	89 03                	mov    %eax,(%ebx)
80103243:	0f 84 87 00 00 00    	je     801032d0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103249:	e8 62 f2 ff ff       	call   801024b0 <kalloc>
8010324e:	85 c0                	test   %eax,%eax
80103250:	89 c7                	mov    %eax,%edi
80103252:	0f 84 b0 00 00 00    	je     80103308 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103258:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010325b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103262:	00 00 00 
  p->writeopen = 1;
80103265:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010326c:	00 00 00 
  p->nwrite = 0;
8010326f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103276:	00 00 00 
  p->nread = 0;
80103279:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103280:	00 00 00 
  initlock(&p->lock, "pipe");
80103283:	68 d0 77 10 80       	push   $0x801077d0
80103288:	50                   	push   %eax
80103289:	e8 b2 11 00 00       	call   80104440 <initlock>
  (*f0)->type = FD_PIPE;
8010328e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103290:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103293:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103299:	8b 06                	mov    (%esi),%eax
8010329b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010329f:	8b 06                	mov    (%esi),%eax
801032a1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801032a5:	8b 06                	mov    (%esi),%eax
801032a7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801032aa:	8b 03                	mov    (%ebx),%eax
801032ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801032b2:	8b 03                	mov    (%ebx),%eax
801032b4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801032b8:	8b 03                	mov    (%ebx),%eax
801032ba:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801032be:	8b 03                	mov    (%ebx),%eax
801032c0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801032c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801032c6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801032c8:	5b                   	pop    %ebx
801032c9:	5e                   	pop    %esi
801032ca:	5f                   	pop    %edi
801032cb:	5d                   	pop    %ebp
801032cc:	c3                   	ret    
801032cd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032d0:	8b 06                	mov    (%esi),%eax
801032d2:	85 c0                	test   %eax,%eax
801032d4:	74 1e                	je     801032f4 <pipealloc+0xe4>
    fileclose(*f0);
801032d6:	83 ec 0c             	sub    $0xc,%esp
801032d9:	50                   	push   %eax
801032da:	e8 61 db ff ff       	call   80100e40 <fileclose>
801032df:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032e2:	8b 03                	mov    (%ebx),%eax
801032e4:	85 c0                	test   %eax,%eax
801032e6:	74 0c                	je     801032f4 <pipealloc+0xe4>
    fileclose(*f1);
801032e8:	83 ec 0c             	sub    $0xc,%esp
801032eb:	50                   	push   %eax
801032ec:	e8 4f db ff ff       	call   80100e40 <fileclose>
801032f1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801032f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032fc:	5b                   	pop    %ebx
801032fd:	5e                   	pop    %esi
801032fe:	5f                   	pop    %edi
801032ff:	5d                   	pop    %ebp
80103300:	c3                   	ret    
80103301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103308:	8b 06                	mov    (%esi),%eax
8010330a:	85 c0                	test   %eax,%eax
8010330c:	75 c8                	jne    801032d6 <pipealloc+0xc6>
8010330e:	eb d2                	jmp    801032e2 <pipealloc+0xd2>

80103310 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103310:	55                   	push   %ebp
80103311:	89 e5                	mov    %esp,%ebp
80103313:	56                   	push   %esi
80103314:	53                   	push   %ebx
80103315:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103318:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010331b:	83 ec 0c             	sub    $0xc,%esp
8010331e:	53                   	push   %ebx
8010331f:	e8 1c 12 00 00       	call   80104540 <acquire>
  if(writable){
80103324:	83 c4 10             	add    $0x10,%esp
80103327:	85 f6                	test   %esi,%esi
80103329:	74 45                	je     80103370 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010332b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103331:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103334:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010333b:	00 00 00 
    wakeup(&p->nread);
8010333e:	50                   	push   %eax
8010333f:	e8 3c 0e 00 00       	call   80104180 <wakeup>
80103344:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103347:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010334d:	85 d2                	test   %edx,%edx
8010334f:	75 0a                	jne    8010335b <pipeclose+0x4b>
80103351:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103357:	85 c0                	test   %eax,%eax
80103359:	74 35                	je     80103390 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010335b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010335e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103361:	5b                   	pop    %ebx
80103362:	5e                   	pop    %esi
80103363:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103364:	e9 f7 12 00 00       	jmp    80104660 <release>
80103369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103370:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103376:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103379:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103380:	00 00 00 
    wakeup(&p->nwrite);
80103383:	50                   	push   %eax
80103384:	e8 f7 0d 00 00       	call   80104180 <wakeup>
80103389:	83 c4 10             	add    $0x10,%esp
8010338c:	eb b9                	jmp    80103347 <pipeclose+0x37>
8010338e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103390:	83 ec 0c             	sub    $0xc,%esp
80103393:	53                   	push   %ebx
80103394:	e8 c7 12 00 00       	call   80104660 <release>
    kfree((char*)p);
80103399:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010339c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010339f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033a2:	5b                   	pop    %ebx
801033a3:	5e                   	pop    %esi
801033a4:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801033a5:	e9 56 ef ff ff       	jmp    80102300 <kfree>
801033aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801033b0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	57                   	push   %edi
801033b4:	56                   	push   %esi
801033b5:	53                   	push   %ebx
801033b6:	83 ec 28             	sub    $0x28,%esp
801033b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801033bc:	53                   	push   %ebx
801033bd:	e8 7e 11 00 00       	call   80104540 <acquire>
  for(i = 0; i < n; i++){
801033c2:	8b 45 10             	mov    0x10(%ebp),%eax
801033c5:	83 c4 10             	add    $0x10,%esp
801033c8:	85 c0                	test   %eax,%eax
801033ca:	0f 8e b9 00 00 00    	jle    80103489 <pipewrite+0xd9>
801033d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801033d3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801033d9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033df:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801033e5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801033e8:	03 4d 10             	add    0x10(%ebp),%ecx
801033eb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033ee:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801033f4:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801033fa:	39 d0                	cmp    %edx,%eax
801033fc:	74 3b                	je     80103439 <pipewrite+0x89>
801033fe:	eb 5c                	jmp    8010345c <pipewrite+0xac>
      if(p->readopen == 0 || myproc()->killed){
80103400:	e8 ab 03 00 00       	call   801037b0 <myproc>
80103405:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
8010340b:	85 c9                	test   %ecx,%ecx
8010340d:	75 34                	jne    80103443 <pipewrite+0x93>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010340f:	83 ec 0c             	sub    $0xc,%esp
80103412:	57                   	push   %edi
80103413:	e8 68 0d 00 00       	call   80104180 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103418:	58                   	pop    %eax
80103419:	5a                   	pop    %edx
8010341a:	53                   	push   %ebx
8010341b:	56                   	push   %esi
8010341c:	e8 7f 0b 00 00       	call   80103fa0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103421:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103427:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010342d:	83 c4 10             	add    $0x10,%esp
80103430:	05 00 02 00 00       	add    $0x200,%eax
80103435:	39 c2                	cmp    %eax,%edx
80103437:	75 27                	jne    80103460 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103439:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010343f:	85 c0                	test   %eax,%eax
80103441:	75 bd                	jne    80103400 <pipewrite+0x50>
        release(&p->lock);
80103443:	83 ec 0c             	sub    $0xc,%esp
80103446:	53                   	push   %ebx
80103447:	e8 14 12 00 00       	call   80104660 <release>
        return -1;
8010344c:	83 c4 10             	add    $0x10,%esp
8010344f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103454:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103457:	5b                   	pop    %ebx
80103458:	5e                   	pop    %esi
80103459:	5f                   	pop    %edi
8010345a:	5d                   	pop    %ebp
8010345b:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010345c:	89 c2                	mov    %eax,%edx
8010345e:	66 90                	xchg   %ax,%ax
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103460:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103463:	8d 42 01             	lea    0x1(%edx),%eax
80103466:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010346a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103470:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103476:	0f b6 09             	movzbl (%ecx),%ecx
80103479:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010347d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103480:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103483:	0f 85 65 ff ff ff    	jne    801033ee <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103489:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010348f:	83 ec 0c             	sub    $0xc,%esp
80103492:	50                   	push   %eax
80103493:	e8 e8 0c 00 00       	call   80104180 <wakeup>
  release(&p->lock);
80103498:	89 1c 24             	mov    %ebx,(%esp)
8010349b:	e8 c0 11 00 00       	call   80104660 <release>
  return n;
801034a0:	83 c4 10             	add    $0x10,%esp
801034a3:	8b 45 10             	mov    0x10(%ebp),%eax
801034a6:	eb ac                	jmp    80103454 <pipewrite+0xa4>
801034a8:	90                   	nop
801034a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034b0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801034b0:	55                   	push   %ebp
801034b1:	89 e5                	mov    %esp,%ebp
801034b3:	57                   	push   %edi
801034b4:	56                   	push   %esi
801034b5:	53                   	push   %ebx
801034b6:	83 ec 18             	sub    $0x18,%esp
801034b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801034bf:	53                   	push   %ebx
801034c0:	e8 7b 10 00 00       	call   80104540 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034c5:	83 c4 10             	add    $0x10,%esp
801034c8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801034ce:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801034d4:	75 72                	jne    80103548 <piperead+0x98>
801034d6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801034dc:	85 f6                	test   %esi,%esi
801034de:	0f 84 d4 00 00 00    	je     801035b8 <piperead+0x108>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801034e4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801034ea:	eb 2d                	jmp    80103519 <piperead+0x69>
801034ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034f0:	83 ec 08             	sub    $0x8,%esp
801034f3:	53                   	push   %ebx
801034f4:	56                   	push   %esi
801034f5:	e8 a6 0a 00 00       	call   80103fa0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034fa:	83 c4 10             	add    $0x10,%esp
801034fd:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103503:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103509:	75 3d                	jne    80103548 <piperead+0x98>
8010350b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103511:	85 d2                	test   %edx,%edx
80103513:	0f 84 9f 00 00 00    	je     801035b8 <piperead+0x108>
    if(myproc()->killed){
80103519:	e8 92 02 00 00       	call   801037b0 <myproc>
8010351e:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80103524:	85 c9                	test   %ecx,%ecx
80103526:	74 c8                	je     801034f0 <piperead+0x40>
      release(&p->lock);
80103528:	83 ec 0c             	sub    $0xc,%esp
8010352b:	53                   	push   %ebx
8010352c:	e8 2f 11 00 00       	call   80104660 <release>
      return -1;
80103531:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103534:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103537:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010353c:	5b                   	pop    %ebx
8010353d:	5e                   	pop    %esi
8010353e:	5f                   	pop    %edi
8010353f:	5d                   	pop    %ebp
80103540:	c3                   	ret    
80103541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103548:	8b 45 10             	mov    0x10(%ebp),%eax
8010354b:	85 c0                	test   %eax,%eax
8010354d:	7e 69                	jle    801035b8 <piperead+0x108>
    if(p->nread == p->nwrite)
8010354f:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103555:	31 c9                	xor    %ecx,%ecx
80103557:	eb 15                	jmp    8010356e <piperead+0xbe>
80103559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103560:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103566:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
8010356c:	74 5a                	je     801035c8 <piperead+0x118>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010356e:	8d 70 01             	lea    0x1(%eax),%esi
80103571:	25 ff 01 00 00       	and    $0x1ff,%eax
80103576:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
8010357c:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103581:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103584:	83 c1 01             	add    $0x1,%ecx
80103587:	39 4d 10             	cmp    %ecx,0x10(%ebp)
8010358a:	75 d4                	jne    80103560 <piperead+0xb0>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010358c:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103592:	83 ec 0c             	sub    $0xc,%esp
80103595:	50                   	push   %eax
80103596:	e8 e5 0b 00 00       	call   80104180 <wakeup>
  release(&p->lock);
8010359b:	89 1c 24             	mov    %ebx,(%esp)
8010359e:	e8 bd 10 00 00       	call   80104660 <release>
  return i;
801035a3:	8b 45 10             	mov    0x10(%ebp),%eax
801035a6:	83 c4 10             	add    $0x10,%esp
}
801035a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035ac:	5b                   	pop    %ebx
801035ad:	5e                   	pop    %esi
801035ae:	5f                   	pop    %edi
801035af:	5d                   	pop    %ebp
801035b0:	c3                   	ret    
801035b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035b8:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801035bf:	eb cb                	jmp    8010358c <piperead+0xdc>
801035c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035c8:	89 4d 10             	mov    %ecx,0x10(%ebp)
801035cb:	eb bf                	jmp    8010358c <piperead+0xdc>
801035cd:	66 90                	xchg   %ax,%ax
801035cf:	90                   	nop

801035d0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035d4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035d9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801035dc:	68 20 2d 11 80       	push   $0x80112d20
801035e1:	e8 5a 0f 00 00       	call   80104540 <acquire>
801035e6:	83 c4 10             	add    $0x10,%esp
801035e9:	eb 17                	jmp    80103602 <allocproc+0x32>
801035eb:	90                   	nop
801035ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035f0:	81 c3 e0 00 00 00    	add    $0xe0,%ebx
801035f6:	81 fb 54 65 11 80    	cmp    $0x80116554,%ebx
801035fc:	0f 84 7e 00 00 00    	je     80103680 <allocproc+0xb0>
    if(p->state == UNUSED)
80103602:	8b 43 68             	mov    0x68(%ebx),%eax
80103605:	85 c0                	test   %eax,%eax
80103607:	75 e7                	jne    801035f0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103609:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
8010360e:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103611:	c7 43 68 01 00 00 00 	movl   $0x1,0x68(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103618:	68 20 2d 11 80       	push   $0x80112d20
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
8010361d:	8d 50 01             	lea    0x1(%eax),%edx
80103620:	89 43 6c             	mov    %eax,0x6c(%ebx)
80103623:	89 15 04 a0 10 80    	mov    %edx,0x8010a004

  release(&ptable.lock);
80103629:	e8 32 10 00 00       	call   80104660 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010362e:	e8 7d ee ff ff       	call   801024b0 <kalloc>
80103633:	83 c4 10             	add    $0x10,%esp
80103636:	85 c0                	test   %eax,%eax
80103638:	89 43 64             	mov    %eax,0x64(%ebx)
8010363b:	74 5a                	je     80103697 <allocproc+0xc7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010363d:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103643:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103646:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010364b:	89 53 7c             	mov    %edx,0x7c(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010364e:	c7 40 14 a9 59 10 80 	movl   $0x801059a9,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103655:	6a 14                	push   $0x14
80103657:	6a 00                	push   $0x0
80103659:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
8010365a:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103660:	e8 4b 10 00 00       	call   801046b0 <memset>
  p->context->eip = (uint)forkret;
80103665:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax

  return p;
8010366b:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
8010366e:	c7 40 10 a0 36 10 80 	movl   $0x801036a0,0x10(%eax)

  return p;
80103675:	89 d8                	mov    %ebx,%eax
}
80103677:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010367a:	c9                   	leave  
8010367b:	c3                   	ret    
8010367c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103680:	83 ec 0c             	sub    $0xc,%esp
80103683:	68 20 2d 11 80       	push   $0x80112d20
80103688:	e8 d3 0f 00 00       	call   80104660 <release>
  return 0;
8010368d:	83 c4 10             	add    $0x10,%esp
80103690:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103692:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103695:	c9                   	leave  
80103696:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103697:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
    return 0;
8010369e:	eb d7                	jmp    80103677 <allocproc+0xa7>

801036a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036a6:	68 20 2d 11 80       	push   $0x80112d20
801036ab:	e8 b0 0f 00 00       	call   80104660 <release>

  if (first) {
801036b0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801036b5:	83 c4 10             	add    $0x10,%esp
801036b8:	85 c0                	test   %eax,%eax
801036ba:	75 04                	jne    801036c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036bc:	c9                   	leave  
801036bd:	c3                   	ret    
801036be:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801036c0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801036c3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801036ca:	00 00 00 
    iinit(ROOTDEV);
801036cd:	6a 01                	push   $0x1
801036cf:	e8 ac dd ff ff       	call   80101480 <iinit>
    initlog(ROOTDEV);
801036d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801036db:	e8 f0 f3 ff ff       	call   80102ad0 <initlog>
801036e0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036e3:	c9                   	leave  
801036e4:	c3                   	ret    
801036e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036f0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801036f6:	68 d5 77 10 80       	push   $0x801077d5
801036fb:	68 20 2d 11 80       	push   $0x80112d20
80103700:	e8 3b 0d 00 00       	call   80104440 <initlock>
}
80103705:	83 c4 10             	add    $0x10,%esp
80103708:	c9                   	leave  
80103709:	c3                   	ret    
8010370a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103710 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103710:	55                   	push   %ebp
80103711:	89 e5                	mov    %esp,%ebp
80103713:	56                   	push   %esi
80103714:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103715:	9c                   	pushf  
80103716:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103717:	f6 c4 02             	test   $0x2,%ah
8010371a:	75 5b                	jne    80103777 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010371c:	e8 ef ef ff ff       	call   80102710 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103721:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103727:	85 f6                	test   %esi,%esi
80103729:	7e 3f                	jle    8010376a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010372b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103732:	39 d0                	cmp    %edx,%eax
80103734:	74 30                	je     80103766 <mycpu+0x56>
80103736:	b9 30 28 11 80       	mov    $0x80112830,%ecx
8010373b:	31 d2                	xor    %edx,%edx
8010373d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103740:	83 c2 01             	add    $0x1,%edx
80103743:	39 f2                	cmp    %esi,%edx
80103745:	74 23                	je     8010376a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103747:	0f b6 19             	movzbl (%ecx),%ebx
8010374a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103750:	39 d8                	cmp    %ebx,%eax
80103752:	75 ec                	jne    80103740 <mycpu+0x30>
      return &cpus[i];
80103754:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010375a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010375d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010375e:	05 80 27 11 80       	add    $0x80112780,%eax
  }
  panic("unknown apicid\n");
}
80103763:	5e                   	pop    %esi
80103764:	5d                   	pop    %ebp
80103765:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103766:	31 d2                	xor    %edx,%edx
80103768:	eb ea                	jmp    80103754 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010376a:	83 ec 0c             	sub    $0xc,%esp
8010376d:	68 dc 77 10 80       	push   $0x801077dc
80103772:	e8 09 cc ff ff       	call   80100380 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103777:	83 ec 0c             	sub    $0xc,%esp
8010377a:	68 b8 78 10 80       	push   $0x801078b8
8010377f:	e8 fc cb ff ff       	call   80100380 <panic>
80103784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010378a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103790 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103796:	e8 75 ff ff ff       	call   80103710 <mycpu>
8010379b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
801037a0:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
801037a1:	c1 f8 04             	sar    $0x4,%eax
801037a4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037aa:	c3                   	ret    
801037ab:	90                   	nop
801037ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037b0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	53                   	push   %ebx
801037b4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801037b7:	e8 44 0d 00 00       	call   80104500 <pushcli>
  c = mycpu();
801037bc:	e8 4f ff ff ff       	call   80103710 <mycpu>
  p = c->proc;
801037c1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037c7:	e8 24 0e 00 00       	call   801045f0 <popcli>
  return p;
}
801037cc:	83 c4 04             	add    $0x4,%esp
801037cf:	89 d8                	mov    %ebx,%eax
801037d1:	5b                   	pop    %ebx
801037d2:	5d                   	pop    %ebp
801037d3:	c3                   	ret    
801037d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037e0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	53                   	push   %ebx
801037e4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801037e7:	e8 e4 fd ff ff       	call   801035d0 <allocproc>
801037ec:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801037ee:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801037f3:	e8 d8 37 00 00       	call   80106fd0 <setupkvm>
801037f8:	85 c0                	test   %eax,%eax
801037fa:	89 43 60             	mov    %eax,0x60(%ebx)
801037fd:	0f 84 c4 00 00 00    	je     801038c7 <userinit+0xe7>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103803:	83 ec 04             	sub    $0x4,%esp
80103806:	68 2c 00 00 00       	push   $0x2c
8010380b:	68 60 a4 10 80       	push   $0x8010a460
80103810:	50                   	push   %eax
80103811:	e8 ca 34 00 00       	call   80106ce0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103816:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103819:	c7 43 5c 00 10 00 00 	movl   $0x1000,0x5c(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103820:	6a 4c                	push   $0x4c
80103822:	6a 00                	push   $0x0
80103824:	ff 73 7c             	pushl  0x7c(%ebx)
80103827:	e8 84 0e 00 00       	call   801046b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010382c:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010382f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103834:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103839:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010383c:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103840:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103843:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103847:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010384a:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010384e:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103852:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103855:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103859:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010385d:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103860:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103867:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010386a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103871:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103874:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010387b:	8d 83 d0 00 00 00    	lea    0xd0(%ebx),%eax
80103881:	6a 10                	push   $0x10
80103883:	68 05 78 10 80       	push   $0x80107805
80103888:	50                   	push   %eax
80103889:	e8 22 10 00 00       	call   801048b0 <safestrcpy>
  p->cwd = namei("/");
8010388e:	c7 04 24 0e 78 10 80 	movl   $0x8010780e,(%esp)
80103895:	e8 46 e6 ff ff       	call   80101ee0 <namei>
8010389a:	89 83 cc 00 00 00    	mov    %eax,0xcc(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
801038a0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801038a7:	e8 94 0c 00 00       	call   80104540 <acquire>

  p->state = RUNNABLE;
801038ac:	c7 43 68 03 00 00 00 	movl   $0x3,0x68(%ebx)

  release(&ptable.lock);
801038b3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801038ba:	e8 a1 0d 00 00       	call   80104660 <release>
}
801038bf:	83 c4 10             	add    $0x10,%esp
801038c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038c5:	c9                   	leave  
801038c6:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801038c7:	83 ec 0c             	sub    $0xc,%esp
801038ca:	68 ec 77 10 80       	push   $0x801077ec
801038cf:	e8 ac ca ff ff       	call   80100380 <panic>
801038d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038e0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	56                   	push   %esi
801038e4:	53                   	push   %ebx
801038e5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801038e8:	e8 13 0c 00 00       	call   80104500 <pushcli>
  c = mycpu();
801038ed:	e8 1e fe ff ff       	call   80103710 <mycpu>
  p = c->proc;
801038f2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038f8:	e8 f3 0c 00 00       	call   801045f0 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
801038fd:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103900:	8b 43 5c             	mov    0x5c(%ebx),%eax
  if(n > 0){
80103903:	7e 33                	jle    80103938 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103905:	83 ec 04             	sub    $0x4,%esp
80103908:	01 c6                	add    %eax,%esi
8010390a:	56                   	push   %esi
8010390b:	50                   	push   %eax
8010390c:	ff 73 60             	pushl  0x60(%ebx)
8010390f:	e8 0c 35 00 00       	call   80106e20 <allocuvm>
80103914:	83 c4 10             	add    $0x10,%esp
80103917:	85 c0                	test   %eax,%eax
80103919:	74 35                	je     80103950 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
8010391b:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
8010391e:	89 43 5c             	mov    %eax,0x5c(%ebx)
  switchuvm(curproc);
80103921:	53                   	push   %ebx
80103922:	e8 a9 32 00 00       	call   80106bd0 <switchuvm>
  return 0;
80103927:	83 c4 10             	add    $0x10,%esp
8010392a:	31 c0                	xor    %eax,%eax
}
8010392c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010392f:	5b                   	pop    %ebx
80103930:	5e                   	pop    %esi
80103931:	5d                   	pop    %ebp
80103932:	c3                   	ret    
80103933:	90                   	nop
80103934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103938:	74 e1                	je     8010391b <growproc+0x3b>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010393a:	83 ec 04             	sub    $0x4,%esp
8010393d:	01 c6                	add    %eax,%esi
8010393f:	56                   	push   %esi
80103940:	50                   	push   %eax
80103941:	ff 73 60             	pushl  0x60(%ebx)
80103944:	e8 d7 35 00 00       	call   80106f20 <deallocuvm>
80103949:	83 c4 10             	add    $0x10,%esp
8010394c:	85 c0                	test   %eax,%eax
8010394e:	75 cb                	jne    8010391b <growproc+0x3b>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103950:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103955:	eb d5                	jmp    8010392c <growproc+0x4c>
80103957:	89 f6                	mov    %esi,%esi
80103959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103960 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	57                   	push   %edi
80103964:	56                   	push   %esi
80103965:	53                   	push   %ebx
80103966:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103969:	e8 92 0b 00 00       	call   80104500 <pushcli>
  c = mycpu();
8010396e:	e8 9d fd ff ff       	call   80103710 <mycpu>
  p = c->proc;
80103973:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103979:	e8 72 0c 00 00       	call   801045f0 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
8010397e:	e8 4d fc ff ff       	call   801035d0 <allocproc>
80103983:	85 c0                	test   %eax,%eax
80103985:	89 c7                	mov    %eax,%edi
80103987:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010398a:	0f 84 cf 00 00 00    	je     80103a5f <fork+0xff>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103990:	83 ec 08             	sub    $0x8,%esp
80103993:	ff 73 5c             	pushl  0x5c(%ebx)
80103996:	ff 73 60             	pushl  0x60(%ebx)
80103999:	e8 02 37 00 00       	call   801070a0 <copyuvm>
8010399e:	83 c4 10             	add    $0x10,%esp
801039a1:	85 c0                	test   %eax,%eax
801039a3:	89 47 60             	mov    %eax,0x60(%edi)
801039a6:	0f 84 ba 00 00 00    	je     80103a66 <fork+0x106>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
801039ac:	8b 43 5c             	mov    0x5c(%ebx),%eax
801039af:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801039b2:	89 41 5c             	mov    %eax,0x5c(%ecx)
  np->parent = curproc;
801039b5:	89 59 78             	mov    %ebx,0x78(%ecx)
  *np->tf = *curproc->tf;
801039b8:	89 c8                	mov    %ecx,%eax
801039ba:	8b 79 7c             	mov    0x7c(%ecx),%edi
801039bd:	8b 73 7c             	mov    0x7c(%ebx),%esi
801039c0:	b9 13 00 00 00       	mov    $0x13,%ecx
801039c5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801039c7:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801039c9:	8b 40 7c             	mov    0x7c(%eax),%eax
801039cc:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801039d3:	90                   	nop
801039d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
801039d8:	8b 84 b3 8c 00 00 00 	mov    0x8c(%ebx,%esi,4),%eax
801039df:	85 c0                	test   %eax,%eax
801039e1:	74 16                	je     801039f9 <fork+0x99>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039e3:	83 ec 0c             	sub    $0xc,%esp
801039e6:	50                   	push   %eax
801039e7:	e8 04 d4 ff ff       	call   80100df0 <filedup>
801039ec:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039ef:	83 c4 10             	add    $0x10,%esp
801039f2:	89 84 b2 8c 00 00 00 	mov    %eax,0x8c(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801039f9:	83 c6 01             	add    $0x1,%esi
801039fc:	83 fe 10             	cmp    $0x10,%esi
801039ff:	75 d7                	jne    801039d8 <fork+0x78>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a01:	83 ec 0c             	sub    $0xc,%esp
80103a04:	ff b3 cc 00 00 00    	pushl  0xcc(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a0a:	81 c3 d0 00 00 00    	add    $0xd0,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a10:	e8 3b dc ff ff       	call   80101650 <idup>
80103a15:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a18:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a1b:	89 87 cc 00 00 00    	mov    %eax,0xcc(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a21:	8d 87 d0 00 00 00    	lea    0xd0(%edi),%eax
80103a27:	6a 10                	push   $0x10
80103a29:	53                   	push   %ebx
80103a2a:	50                   	push   %eax
80103a2b:	e8 80 0e 00 00       	call   801048b0 <safestrcpy>

  pid = np->pid;
80103a30:	8b 5f 6c             	mov    0x6c(%edi),%ebx

  acquire(&ptable.lock);
80103a33:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a3a:	e8 01 0b 00 00       	call   80104540 <acquire>

  np->state = RUNNABLE;
80103a3f:	c7 47 68 03 00 00 00 	movl   $0x3,0x68(%edi)

  release(&ptable.lock);
80103a46:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a4d:	e8 0e 0c 00 00       	call   80104660 <release>

  return pid;
80103a52:	83 c4 10             	add    $0x10,%esp
80103a55:	89 d8                	mov    %ebx,%eax
}
80103a57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a5a:	5b                   	pop    %ebx
80103a5b:	5e                   	pop    %esi
80103a5c:	5f                   	pop    %edi
80103a5d:	5d                   	pop    %ebp
80103a5e:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103a5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a64:	eb f1                	jmp    80103a57 <fork+0xf7>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103a66:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103a69:	83 ec 0c             	sub    $0xc,%esp
80103a6c:	ff 77 64             	pushl  0x64(%edi)
80103a6f:	e8 8c e8 ff ff       	call   80102300 <kfree>
    np->kstack = 0;
80103a74:	c7 47 64 00 00 00 00 	movl   $0x0,0x64(%edi)
    np->state = UNUSED;
80103a7b:	c7 47 68 00 00 00 00 	movl   $0x0,0x68(%edi)
    return -1;
80103a82:	83 c4 10             	add    $0x10,%esp
80103a85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a8a:	eb cb                	jmp    80103a57 <fork+0xf7>
80103a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103a90 <currproc>:
  	//release(&ptable.lock);
  }
}

struct proc * currproc(void)
{
80103a90:	55                   	push   %ebp
    struct proc * p;    //Currently working process
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a91:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
  	//release(&ptable.lock);
  }
}

struct proc * currproc(void)
{
80103a96:	89 e5                	mov    %esp,%ebp
80103a98:	eb 12                	jmp    80103aac <currproc+0x1c>
80103a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    struct proc * p;    //Currently working process
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103aa0:	05 e0 00 00 00       	add    $0xe0,%eax
80103aa5:	3d 54 65 11 80       	cmp    $0x80116554,%eax
80103aaa:	74 06                	je     80103ab2 <currproc+0x22>
    {
      if(p->state == RUNNING) return p;
80103aac:	83 78 68 04          	cmpl   $0x4,0x68(%eax)
80103ab0:	75 ee                	jne    80103aa0 <currproc+0x10>
      
    }
    return p;
}
80103ab2:	5d                   	pop    %ebp
80103ab3:	c3                   	ret    
80103ab4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103aba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ac0 <change_priority>:


// CS153 EDITED CODE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void
change_priority(int priority)
{
80103ac0:	55                   	push   %ebp
}

struct proc * currproc(void)
{
    struct proc * p;    //Currently working process
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ac1:	b8 54 2d 11 80       	mov    $0x80112d54,%eax


// CS153 EDITED CODE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void
change_priority(int priority)
{
80103ac6:	89 e5                	mov    %esp,%ebp
80103ac8:	eb 12                	jmp    80103adc <change_priority+0x1c>
80103aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

struct proc * currproc(void)
{
    struct proc * p;    //Currently working process
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ad0:	05 e0 00 00 00       	add    $0xe0,%eax
80103ad5:	3d 54 65 11 80       	cmp    $0x80116554,%eax
80103ada:	74 06                	je     80103ae2 <change_priority+0x22>
    {
      if(p->state == RUNNING) return p;
80103adc:	83 78 68 04          	cmpl   $0x4,0x68(%eax)
80103ae0:	75 ee                	jne    80103ad0 <change_priority+0x10>
void
change_priority(int priority)
{
	struct proc * p;
	p = currproc();	
	p->priority = priority;
80103ae2:	8b 55 08             	mov    0x8(%ebp),%edx
80103ae5:	89 50 04             	mov    %edx,0x4(%eax)
}
80103ae8:	5d                   	pop    %ebp
80103ae9:	c3                   	ret    
80103aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103af0 <high_priority>:

int high_priority(void)
{
80103af0:	55                   	push   %ebp
	int priority_uno = 0;
	struct proc * p;
	
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103af1:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
	p->priority = priority;
}

int high_priority(void)
{
	int priority_uno = 0;
80103af6:	31 c0                	xor    %eax,%eax
	p = currproc();	
	p->priority = priority;
}

int high_priority(void)
{
80103af8:	89 e5                	mov    %esp,%ebp
80103afa:	eb 12                	jmp    80103b0e <high_priority+0x1e>
80103afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	int priority_uno = 0;
	struct proc * p;
	
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b00:	81 c2 e0 00 00 00    	add    $0xe0,%edx
80103b06:	81 fa 54 65 11 80    	cmp    $0x80116554,%edx
80103b0c:	74 1c                	je     80103b2a <high_priority+0x3a>
	{
		if(p->state != RUNNABLE)
80103b0e:	83 7a 68 03          	cmpl   $0x3,0x68(%edx)
80103b12:	75 ec                	jne    80103b00 <high_priority+0x10>
		   continue;
		if(p->priority > priority_uno)
80103b14:	8b 4a 04             	mov    0x4(%edx),%ecx
80103b17:	39 c8                	cmp    %ecx,%eax
80103b19:	0f 4c c1             	cmovl  %ecx,%eax
int high_priority(void)
{
	int priority_uno = 0;
	struct proc * p;
	
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b1c:	81 c2 e0 00 00 00    	add    $0xe0,%edx
80103b22:	81 fa 54 65 11 80    	cmp    $0x80116554,%edx
80103b28:	75 e4                	jne    80103b0e <high_priority+0x1e>
		   continue;
		if(p->priority > priority_uno)
	           priority_uno = p->priority;
	}
	return priority_uno;
}
80103b2a:	5d                   	pop    %ebp
80103b2b:	c3                   	ret    
80103b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b30 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103b30:	55                   	push   %ebp
80103b31:	89 e5                	mov    %esp,%ebp
80103b33:	57                   	push   %edi
80103b34:	56                   	push   %esi
80103b35:	53                   	push   %ebx
80103b36:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103b39:	e8 d2 fb ff ff       	call   80103710 <mycpu>
80103b3e:	89 c6                	mov    %eax,%esi
80103b40:	8d 40 04             	lea    0x4(%eax),%eax
80103b43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b46:	8d 76 00             	lea    0x0(%esi),%esi
80103b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103b50:	fb                   	sti    
	p->priority = priority;
}

int high_priority(void)
{
	int priority_uno = 0;
80103b51:	31 ff                	xor    %edi,%edi
	struct proc * p;
	
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b53:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103b58:	eb 12                	jmp    80103b6c <scheduler+0x3c>
80103b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b60:	05 e0 00 00 00       	add    $0xe0,%eax
80103b65:	3d 54 65 11 80       	cmp    $0x80116554,%eax
80103b6a:	74 1a                	je     80103b86 <scheduler+0x56>
	{
		if(p->state != RUNNABLE)
80103b6c:	83 78 68 03          	cmpl   $0x3,0x68(%eax)
80103b70:	75 ee                	jne    80103b60 <scheduler+0x30>
		   continue;
		if(p->priority > priority_uno)
80103b72:	8b 48 04             	mov    0x4(%eax),%ecx
80103b75:	39 cf                	cmp    %ecx,%edi
80103b77:	0f 4c f9             	cmovl  %ecx,%edi
int high_priority(void)
{
	int priority_uno = 0;
	struct proc * p;
	
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b7a:	05 e0 00 00 00       	add    $0xe0,%eax
80103b7f:	3d 54 65 11 80       	cmp    $0x80116554,%eax
80103b84:	75 e6                	jne    80103b6c <scheduler+0x3c>
    sti();

    priority_uno = high_priority();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b86:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b89:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    sti();

    priority_uno = high_priority();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b8e:	68 20 2d 11 80       	push   $0x80112d20
80103b93:	e8 a8 09 00 00       	call   80104540 <acquire>
80103b98:	83 c4 10             	add    $0x10,%esp
80103b9b:	eb 11                	jmp    80103bae <scheduler+0x7e>
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ba0:	81 c3 e0 00 00 00    	add    $0xe0,%ebx
80103ba6:	81 fb 54 65 11 80    	cmp    $0x80116554,%ebx
80103bac:	74 52                	je     80103c00 <scheduler+0xd0>
      if(p->state != RUNNABLE)
80103bae:	83 7b 68 03          	cmpl   $0x3,0x68(%ebx)
80103bb2:	75 ec                	jne    80103ba0 <scheduler+0x70>
        continue;

      if(priority_uno > p->priority)
80103bb4:	39 7b 04             	cmp    %edi,0x4(%ebx)
80103bb7:	7c e7                	jl     80103ba0 <scheduler+0x70>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103bb9:	83 ec 0c             	sub    $0xc,%esp
	continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103bbc:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103bc2:	53                   	push   %ebx

    priority_uno = high_priority();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bc3:	81 c3 e0 00 00 00    	add    $0xe0,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103bc9:	e8 02 30 00 00       	call   80106bd0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103bce:	58                   	pop    %eax
80103bcf:	5a                   	pop    %edx
80103bd0:	ff 73 a0             	pushl  -0x60(%ebx)
80103bd3:	ff 75 e4             	pushl  -0x1c(%ebp)
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103bd6:	c7 43 88 04 00 00 00 	movl   $0x4,-0x78(%ebx)

      swtch(&(c->scheduler), p->context);
80103bdd:	e8 29 0d 00 00       	call   8010490b <swtch>
      switchkvm();
80103be2:	e8 c9 2f 00 00       	call   80106bb0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103be7:	83 c4 10             	add    $0x10,%esp

    priority_uno = high_priority();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bea:	81 fb 54 65 11 80    	cmp    $0x80116554,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103bf0:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103bf7:	00 00 00 

    priority_uno = high_priority();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bfa:	75 b2                	jne    80103bae <scheduler+0x7e>
80103bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103c00:	83 ec 0c             	sub    $0xc,%esp
80103c03:	68 20 2d 11 80       	push   $0x80112d20
80103c08:	e8 53 0a 00 00       	call   80104660 <release>

  }
80103c0d:	83 c4 10             	add    $0x10,%esp
80103c10:	e9 3b ff ff ff       	jmp    80103b50 <scheduler+0x20>
80103c15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c20 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	56                   	push   %esi
80103c24:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c25:	e8 d6 08 00 00       	call   80104500 <pushcli>
  c = mycpu();
80103c2a:	e8 e1 fa ff ff       	call   80103710 <mycpu>
  p = c->proc;
80103c2f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c35:	e8 b6 09 00 00       	call   801045f0 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103c3a:	83 ec 0c             	sub    $0xc,%esp
80103c3d:	68 20 2d 11 80       	push   $0x80112d20
80103c42:	e8 79 08 00 00       	call   801044c0 <holding>
80103c47:	83 c4 10             	add    $0x10,%esp
80103c4a:	85 c0                	test   %eax,%eax
80103c4c:	74 4f                	je     80103c9d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103c4e:	e8 bd fa ff ff       	call   80103710 <mycpu>
80103c53:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c5a:	75 68                	jne    80103cc4 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103c5c:	83 7b 68 04          	cmpl   $0x4,0x68(%ebx)
80103c60:	74 55                	je     80103cb7 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c62:	9c                   	pushf  
80103c63:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103c64:	f6 c4 02             	test   $0x2,%ah
80103c67:	75 41                	jne    80103caa <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103c69:	e8 a2 fa ff ff       	call   80103710 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c6e:	83 eb 80             	sub    $0xffffff80,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103c71:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c77:	e8 94 fa ff ff       	call   80103710 <mycpu>
80103c7c:	83 ec 08             	sub    $0x8,%esp
80103c7f:	ff 70 04             	pushl  0x4(%eax)
80103c82:	53                   	push   %ebx
80103c83:	e8 83 0c 00 00       	call   8010490b <swtch>
  mycpu()->intena = intena;
80103c88:	e8 83 fa ff ff       	call   80103710 <mycpu>
}
80103c8d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103c90:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c96:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c99:	5b                   	pop    %ebx
80103c9a:	5e                   	pop    %esi
80103c9b:	5d                   	pop    %ebp
80103c9c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103c9d:	83 ec 0c             	sub    $0xc,%esp
80103ca0:	68 10 78 10 80       	push   $0x80107810
80103ca5:	e8 d6 c6 ff ff       	call   80100380 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103caa:	83 ec 0c             	sub    $0xc,%esp
80103cad:	68 3c 78 10 80       	push   $0x8010783c
80103cb2:	e8 c9 c6 ff ff       	call   80100380 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103cb7:	83 ec 0c             	sub    $0xc,%esp
80103cba:	68 2e 78 10 80       	push   $0x8010782e
80103cbf:	e8 bc c6 ff ff       	call   80100380 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103cc4:	83 ec 0c             	sub    $0xc,%esp
80103cc7:	68 22 78 10 80       	push   $0x80107822
80103ccc:	e8 af c6 ff ff       	call   80100380 <panic>
80103cd1:	eb 0d                	jmp    80103ce0 <exit>
80103cd3:	90                   	nop
80103cd4:	90                   	nop
80103cd5:	90                   	nop
80103cd6:	90                   	nop
80103cd7:	90                   	nop
80103cd8:	90                   	nop
80103cd9:	90                   	nop
80103cda:	90                   	nop
80103cdb:	90                   	nop
80103cdc:	90                   	nop
80103cdd:	90                   	nop
80103cde:	90                   	nop
80103cdf:	90                   	nop

80103ce0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(int status)
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	57                   	push   %edi
80103ce4:	56                   	push   %esi
80103ce5:	53                   	push   %ebx
80103ce6:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ce9:	e8 12 08 00 00       	call   80104500 <pushcli>
  c = mycpu();
80103cee:	e8 1d fa ff ff       	call   80103710 <mycpu>
  p = c->proc;
80103cf3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103cf9:	e8 f2 08 00 00       	call   801045f0 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103cfe:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d04:	8d 9e 8c 00 00 00    	lea    0x8c(%esi),%ebx
80103d0a:	8d be cc 00 00 00    	lea    0xcc(%esi),%edi
80103d10:	0f 84 14 01 00 00    	je     80103e2a <exit+0x14a>
80103d16:	8d 76 00             	lea    0x0(%esi),%esi
80103d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103d20:	8b 03                	mov    (%ebx),%eax
80103d22:	85 c0                	test   %eax,%eax
80103d24:	74 12                	je     80103d38 <exit+0x58>
      fileclose(curproc->ofile[fd]);
80103d26:	83 ec 0c             	sub    $0xc,%esp
80103d29:	50                   	push   %eax
80103d2a:	e8 11 d1 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103d2f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d35:	83 c4 10             	add    $0x10,%esp
80103d38:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103d3b:	39 df                	cmp    %ebx,%edi
80103d3d:	75 e1                	jne    80103d20 <exit+0x40>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103d3f:	e8 2c ee ff ff       	call   80102b70 <begin_op>
  iput(curproc->cwd);
80103d44:	83 ec 0c             	sub    $0xc,%esp
80103d47:	ff b6 cc 00 00 00    	pushl  0xcc(%esi)
80103d4d:	e8 5e da ff ff       	call   801017b0 <iput>
  end_op();
80103d52:	e8 89 ee ff ff       	call   80102be0 <end_op>
  curproc->cwd = 0;
80103d57:	c7 86 cc 00 00 00 00 	movl   $0x0,0xcc(%esi)
80103d5e:	00 00 00 

  acquire(&ptable.lock);
80103d61:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d68:	e8 d3 07 00 00       	call   80104540 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103d6d:	8b 56 78             	mov    0x78(%esi),%edx
80103d70:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d73:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d78:	eb 12                	jmp    80103d8c <exit+0xac>
80103d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d80:	05 e0 00 00 00       	add    $0xe0,%eax
80103d85:	3d 54 65 11 80       	cmp    $0x80116554,%eax
80103d8a:	74 21                	je     80103dad <exit+0xcd>
    if(p->state == SLEEPING && p->chan == chan)
80103d8c:	83 78 68 02          	cmpl   $0x2,0x68(%eax)
80103d90:	75 ee                	jne    80103d80 <exit+0xa0>
80103d92:	3b 90 84 00 00 00    	cmp    0x84(%eax),%edx
80103d98:	75 e6                	jne    80103d80 <exit+0xa0>
      p->state = RUNNABLE;
80103d9a:	c7 40 68 03 00 00 00 	movl   $0x3,0x68(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103da1:	05 e0 00 00 00       	add    $0xe0,%eax
80103da6:	3d 54 65 11 80       	cmp    $0x80116554,%eax
80103dab:	75 df                	jne    80103d8c <exit+0xac>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103dad:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
80103db3:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103db8:	eb 14                	jmp    80103dce <exit+0xee>
80103dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dc0:	81 c2 e0 00 00 00    	add    $0xe0,%edx
80103dc6:	81 fa 54 65 11 80    	cmp    $0x80116554,%edx
80103dcc:	74 3d                	je     80103e0b <exit+0x12b>
    if(p->parent == curproc){
80103dce:	39 72 78             	cmp    %esi,0x78(%edx)
80103dd1:	75 ed                	jne    80103dc0 <exit+0xe0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103dd3:	83 7a 68 05          	cmpl   $0x5,0x68(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103dd7:	89 4a 78             	mov    %ecx,0x78(%edx)
      if(p->state == ZOMBIE)
80103dda:	75 e4                	jne    80103dc0 <exit+0xe0>
80103ddc:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103de1:	eb 11                	jmp    80103df4 <exit+0x114>
80103de3:	90                   	nop
80103de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103de8:	05 e0 00 00 00       	add    $0xe0,%eax
80103ded:	3d 54 65 11 80       	cmp    $0x80116554,%eax
80103df2:	74 cc                	je     80103dc0 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
80103df4:	83 78 68 02          	cmpl   $0x2,0x68(%eax)
80103df8:	75 ee                	jne    80103de8 <exit+0x108>
80103dfa:	3b 88 84 00 00 00    	cmp    0x84(%eax),%ecx
80103e00:	75 e6                	jne    80103de8 <exit+0x108>
      p->state = RUNNABLE;
80103e02:	c7 40 68 03 00 00 00 	movl   $0x3,0x68(%eax)
80103e09:	eb dd                	jmp    80103de8 <exit+0x108>
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

 curproc->exit_status = status;
80103e0b:	8b 45 08             	mov    0x8(%ebp),%eax

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103e0e:	c7 46 68 05 00 00 00 	movl   $0x5,0x68(%esi)
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

 curproc->exit_status = status;
80103e15:	89 46 70             	mov    %eax,0x70(%esi)

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
80103e18:	e8 03 fe ff ff       	call   80103c20 <sched>
  panic("zombie exit");
80103e1d:	83 ec 0c             	sub    $0xc,%esp
80103e20:	68 5d 78 10 80       	push   $0x8010785d
80103e25:	e8 56 c5 ff ff       	call   80100380 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103e2a:	83 ec 0c             	sub    $0xc,%esp
80103e2d:	68 50 78 10 80       	push   $0x80107850
80103e32:	e8 49 c5 ff ff       	call   80100380 <panic>
80103e37:	89 f6                	mov    %esi,%esi
80103e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e40 <waitpid>:
// CS153 EDITED CODE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// waitpid takes in pid number to kill, its status, and options 
// with what to do with the collected resources
int
waitpid(int firstpid, int* status,int options)
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	57                   	push   %edi
80103e44:	56                   	push   %esi
80103e45:	53                   	push   %ebx
80103e46:	83 ec 18             	sub    $0x18,%esp
80103e49:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct proc *p;
  int havekids,pid;

  acquire(&ptable.lock);
80103e4c:	68 20 2d 11 80       	push   $0x80112d20
80103e51:	e8 ea 06 00 00       	call   80104540 <acquire>
80103e56:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80103e59:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e5b:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103e60:	eb 14                	jmp    80103e76 <waitpid+0x36>
80103e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e68:	81 c3 e0 00 00 00    	add    $0xe0,%ebx
80103e6e:	81 fb 54 65 11 80    	cmp    $0x80116554,%ebx
80103e74:	74 20                	je     80103e96 <waitpid+0x56>
      if(p->pid != firstpid)
80103e76:	8b 73 6c             	mov    0x6c(%ebx),%esi
80103e79:	39 fe                	cmp    %edi,%esi
80103e7b:	75 eb                	jne    80103e68 <waitpid+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103e7d:	83 7b 68 05          	cmpl   $0x5,0x68(%ebx)
80103e81:	74 3d                	je     80103ec0 <waitpid+0x80>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e83:	81 c3 e0 00 00 00    	add    $0xe0,%ebx
      if(p->pid != firstpid)
        continue;
      havekids = 1;
80103e89:	ba 01 00 00 00       	mov    $0x1,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e8e:	81 fb 54 65 11 80    	cmp    $0x80116554,%ebx
80103e94:	75 e0                	jne    80103e76 <waitpid+0x36>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
80103e96:	85 d2                	test   %edx,%edx
80103e98:	0f 84 97 00 00 00    	je     80103f35 <waitpid+0xf5>
80103e9e:	a1 dc 65 11 80       	mov    0x801165dc,%eax
80103ea3:	85 c0                	test   %eax,%eax
80103ea5:	0f 85 8a 00 00 00    	jne    80103f35 <waitpid+0xf5>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    // sleep(proc, &ptable.lock);  //DOC: wait-sleep
        //acquire(&ptable.lock);  //DOC: yieldlock
  	p->state = RUNNABLE;
80103eab:	c7 05 bc 65 11 80 03 	movl   $0x3,0x801165bc
80103eb2:	00 00 00 
 	sched();
80103eb5:	e8 66 fd ff ff       	call   80103c20 <sched>
  	//release(&ptable.lock);
  }
80103eba:	eb 9d                	jmp    80103e59 <waitpid+0x19>
80103ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103ec0:	83 ec 0c             	sub    $0xc,%esp
80103ec3:	ff 73 64             	pushl  0x64(%ebx)
80103ec6:	e8 35 e4 ff ff       	call   80102300 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103ecb:	5a                   	pop    %edx
80103ecc:	ff 73 60             	pushl  0x60(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103ecf:	c7 43 64 00 00 00 00 	movl   $0x0,0x64(%ebx)
        freevm(p->pgdir);
80103ed6:	e8 75 30 00 00       	call   80106f50 <freevm>
        p->state = UNUSED;
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
80103edb:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->state = UNUSED;
80103ee2:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
        p->pid = 0;
80103ee9:	c7 43 6c 00 00 00 00 	movl   $0x0,0x6c(%ebx)
        p->parent = 0;
80103ef0:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
        p->name[0] = 0;
80103ef7:	c6 83 d0 00 00 00 00 	movb   $0x0,0xd0(%ebx)
        p->killed = 0;
80103efe:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103f05:	00 00 00 
        release(&ptable.lock);
80103f08:	e8 53 07 00 00       	call   80104660 <release>
       // pid = status;// added for assignmetn one
        if(*status == 0)
80103f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f10:	83 c4 10             	add    $0x10,%esp
80103f13:	8b 08                	mov    (%eax),%ecx
80103f15:	85 c9                	test   %ecx,%ecx
80103f17:	75 0a                	jne    80103f23 <waitpid+0xe3>
        //acquire(&ptable.lock);  //DOC: yieldlock
  	p->state = RUNNABLE;
 	sched();
  	//release(&ptable.lock);
  }
}
80103f19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f1c:	89 f0                	mov    %esi,%eax
80103f1e:	5b                   	pop    %ebx
80103f1f:	5e                   	pop    %esi
80103f20:	5f                   	pop    %edi
80103f21:	5d                   	pop    %ebp
80103f22:	c3                   	ret    
        if(*status == 0)
        {
        }
        else
        {
           *status = p->status;
80103f23:	8b 43 08             	mov    0x8(%ebx),%eax
80103f26:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103f29:	89 01                	mov    %eax,(%ecx)
        //acquire(&ptable.lock);  //DOC: yieldlock
  	p->state = RUNNABLE;
 	sched();
  	//release(&ptable.lock);
  }
}
80103f2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f2e:	89 f0                	mov    %esi,%eax
80103f30:	5b                   	pop    %ebx
80103f31:	5e                   	pop    %esi
80103f32:	5f                   	pop    %edi
80103f33:	5d                   	pop    %ebp
80103f34:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
      release(&ptable.lock);
80103f35:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103f38:	be ff ff ff ff       	mov    $0xffffffff,%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
      release(&ptable.lock);
80103f3d:	68 20 2d 11 80       	push   $0x80112d20
80103f42:	e8 19 07 00 00       	call   80104660 <release>
      return -1;
80103f47:	83 c4 10             	add    $0x10,%esp
80103f4a:	eb cd                	jmp    80103f19 <waitpid+0xd9>
80103f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f50 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	53                   	push   %ebx
80103f54:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103f57:	68 20 2d 11 80       	push   $0x80112d20
80103f5c:	e8 df 05 00 00       	call   80104540 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f61:	e8 9a 05 00 00       	call   80104500 <pushcli>
  c = mycpu();
80103f66:	e8 a5 f7 ff ff       	call   80103710 <mycpu>
  p = c->proc;
80103f6b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f71:	e8 7a 06 00 00       	call   801045f0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103f76:	c7 43 68 03 00 00 00 	movl   $0x3,0x68(%ebx)
  sched();
80103f7d:	e8 9e fc ff ff       	call   80103c20 <sched>
  release(&ptable.lock);
80103f82:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f89:	e8 d2 06 00 00       	call   80104660 <release>
}
80103f8e:	83 c4 10             	add    $0x10,%esp
80103f91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f94:	c9                   	leave  
80103f95:	c3                   	ret    
80103f96:	8d 76 00             	lea    0x0(%esi),%esi
80103f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fa0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	57                   	push   %edi
80103fa4:	56                   	push   %esi
80103fa5:	53                   	push   %ebx
80103fa6:	83 ec 0c             	sub    $0xc,%esp
80103fa9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103fac:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103faf:	e8 4c 05 00 00       	call   80104500 <pushcli>
  c = mycpu();
80103fb4:	e8 57 f7 ff ff       	call   80103710 <mycpu>
  p = c->proc;
80103fb9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fbf:	e8 2c 06 00 00       	call   801045f0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103fc4:	85 db                	test   %ebx,%ebx
80103fc6:	0f 84 95 00 00 00    	je     80104061 <sleep+0xc1>
    panic("sleep");

  if(lk == 0)
80103fcc:	85 f6                	test   %esi,%esi
80103fce:	0f 84 80 00 00 00    	je     80104054 <sleep+0xb4>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103fd4:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103fda:	74 54                	je     80104030 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103fdc:	83 ec 0c             	sub    $0xc,%esp
80103fdf:	68 20 2d 11 80       	push   $0x80112d20
80103fe4:	e8 57 05 00 00       	call   80104540 <acquire>
    release(lk);
80103fe9:	89 34 24             	mov    %esi,(%esp)
80103fec:	e8 6f 06 00 00       	call   80104660 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103ff1:	89 bb 84 00 00 00    	mov    %edi,0x84(%ebx)
  p->state = SLEEPING;
80103ff7:	c7 43 68 02 00 00 00 	movl   $0x2,0x68(%ebx)

  sched();
80103ffe:	e8 1d fc ff ff       	call   80103c20 <sched>

  // Tidy up.
  p->chan = 0;
80104003:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
8010400a:	00 00 00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
8010400d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104014:	e8 47 06 00 00       	call   80104660 <release>
    acquire(lk);
80104019:	89 75 08             	mov    %esi,0x8(%ebp)
8010401c:	83 c4 10             	add    $0x10,%esp
  }
}
8010401f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104022:	5b                   	pop    %ebx
80104023:	5e                   	pop    %esi
80104024:	5f                   	pop    %edi
80104025:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80104026:	e9 15 05 00 00       	jmp    80104540 <acquire>
8010402b:	90                   	nop
8010402c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80104030:	89 bb 84 00 00 00    	mov    %edi,0x84(%ebx)
  p->state = SLEEPING;
80104036:	c7 43 68 02 00 00 00 	movl   $0x2,0x68(%ebx)

  sched();
8010403d:	e8 de fb ff ff       	call   80103c20 <sched>

  // Tidy up.
  p->chan = 0;
80104042:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80104049:	00 00 00 
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
8010404c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010404f:	5b                   	pop    %ebx
80104050:	5e                   	pop    %esi
80104051:	5f                   	pop    %edi
80104052:	5d                   	pop    %ebp
80104053:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80104054:	83 ec 0c             	sub    $0xc,%esp
80104057:	68 6f 78 10 80       	push   $0x8010786f
8010405c:	e8 1f c3 ff ff       	call   80100380 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80104061:	83 ec 0c             	sub    $0xc,%esp
80104064:	68 69 78 10 80       	push   $0x80107869
80104069:	e8 12 c3 ff ff       	call   80100380 <panic>
8010406e:	66 90                	xchg   %ax,%ax

80104070 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(int * status) // CS153 EDITED CODE
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	56                   	push   %esi
80104074:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104075:	e8 86 04 00 00       	call   80104500 <pushcli>
  c = mycpu();
8010407a:	e8 91 f6 ff ff       	call   80103710 <mycpu>
  p = c->proc;
8010407f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104085:	e8 66 05 00 00       	call   801045f0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
8010408a:	83 ec 0c             	sub    $0xc,%esp
8010408d:	68 20 2d 11 80       	push   $0x80112d20
80104092:	e8 a9 04 00 00       	call   80104540 <acquire>
80104097:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010409a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010409c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
801040a1:	eb 13                	jmp    801040b6 <wait+0x46>
801040a3:	90                   	nop
801040a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040a8:	81 c3 e0 00 00 00    	add    $0xe0,%ebx
801040ae:	81 fb 54 65 11 80    	cmp    $0x80116554,%ebx
801040b4:	74 22                	je     801040d8 <wait+0x68>
      if(p->parent != curproc)
801040b6:	39 73 78             	cmp    %esi,0x78(%ebx)
801040b9:	75 ed                	jne    801040a8 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
801040bb:	83 7b 68 05          	cmpl   $0x5,0x68(%ebx)
801040bf:	74 38                	je     801040f9 <wait+0x89>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040c1:	81 c3 e0 00 00 00    	add    $0xe0,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
801040c7:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040cc:	81 fb 54 65 11 80    	cmp    $0x80116554,%ebx
801040d2:	75 e2                	jne    801040b6 <wait+0x46>
801040d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
801040d8:	85 c0                	test   %eax,%eax
801040da:	74 79                	je     80104155 <wait+0xe5>
801040dc:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
801040e2:	85 c0                	test   %eax,%eax
801040e4:	75 6f                	jne    80104155 <wait+0xe5>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801040e6:	83 ec 08             	sub    $0x8,%esp
801040e9:	68 20 2d 11 80       	push   $0x80112d20
801040ee:	56                   	push   %esi
801040ef:	e8 ac fe ff ff       	call   80103fa0 <sleep>
  }
801040f4:	83 c4 10             	add    $0x10,%esp
801040f7:	eb a1                	jmp    8010409a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
801040f9:	83 ec 0c             	sub    $0xc,%esp
801040fc:	ff 73 64             	pushl  0x64(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
801040ff:	8b 73 6c             	mov    0x6c(%ebx),%esi
        kfree(p->kstack);
80104102:	e8 f9 e1 ff ff       	call   80102300 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80104107:	5a                   	pop    %edx
80104108:	ff 73 60             	pushl  0x60(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
8010410b:	c7 43 64 00 00 00 00 	movl   $0x0,0x64(%ebx)
        freevm(p->pgdir);
80104112:	e8 39 2e 00 00       	call   80106f50 <freevm>
        p->pid = 0;
80104117:	c7 43 6c 00 00 00 00 	movl   $0x0,0x6c(%ebx)
        p->parent = 0;
8010411e:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
        p->name[0] = 0;
80104125:	c6 83 d0 00 00 00 00 	movb   $0x0,0xd0(%ebx)
        p->killed = 0;
8010412c:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80104133:	00 00 00 
        p->state = UNUSED;
80104136:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
        release(&ptable.lock);
8010413d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104144:	e8 17 05 00 00       	call   80104660 <release>
        return pid;
80104149:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010414c:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
8010414f:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104151:	5b                   	pop    %ebx
80104152:	5e                   	pop    %esi
80104153:	5d                   	pop    %ebp
80104154:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104155:	83 ec 0c             	sub    $0xc,%esp
80104158:	68 20 2d 11 80       	push   $0x80112d20
8010415d:	e8 fe 04 00 00       	call   80104660 <release>
      return -1;
80104162:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104165:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104168:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010416d:	5b                   	pop    %ebx
8010416e:	5e                   	pop    %esi
8010416f:	5d                   	pop    %ebp
80104170:	c3                   	ret    
80104171:	eb 0d                	jmp    80104180 <wakeup>
80104173:	90                   	nop
80104174:	90                   	nop
80104175:	90                   	nop
80104176:	90                   	nop
80104177:	90                   	nop
80104178:	90                   	nop
80104179:	90                   	nop
8010417a:	90                   	nop
8010417b:	90                   	nop
8010417c:	90                   	nop
8010417d:	90                   	nop
8010417e:	90                   	nop
8010417f:	90                   	nop

80104180 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	53                   	push   %ebx
80104184:	83 ec 10             	sub    $0x10,%esp
80104187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010418a:	68 20 2d 11 80       	push   $0x80112d20
8010418f:	e8 ac 03 00 00       	call   80104540 <acquire>
80104194:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104197:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010419c:	eb 0e                	jmp    801041ac <wakeup+0x2c>
8010419e:	66 90                	xchg   %ax,%ax
801041a0:	05 e0 00 00 00       	add    $0xe0,%eax
801041a5:	3d 54 65 11 80       	cmp    $0x80116554,%eax
801041aa:	74 21                	je     801041cd <wakeup+0x4d>
    if(p->state == SLEEPING && p->chan == chan)
801041ac:	83 78 68 02          	cmpl   $0x2,0x68(%eax)
801041b0:	75 ee                	jne    801041a0 <wakeup+0x20>
801041b2:	3b 98 84 00 00 00    	cmp    0x84(%eax),%ebx
801041b8:	75 e6                	jne    801041a0 <wakeup+0x20>
      p->state = RUNNABLE;
801041ba:	c7 40 68 03 00 00 00 	movl   $0x3,0x68(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041c1:	05 e0 00 00 00       	add    $0xe0,%eax
801041c6:	3d 54 65 11 80       	cmp    $0x80116554,%eax
801041cb:	75 df                	jne    801041ac <wakeup+0x2c>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801041cd:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
801041d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041d7:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801041d8:	e9 83 04 00 00       	jmp    80104660 <release>
801041dd:	8d 76 00             	lea    0x0(%esi),%esi

801041e0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	53                   	push   %ebx
801041e4:	83 ec 10             	sub    $0x10,%esp
801041e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801041ea:	68 20 2d 11 80       	push   $0x80112d20
801041ef:	e8 4c 03 00 00       	call   80104540 <acquire>
801041f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041f7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801041fc:	eb 0e                	jmp    8010420c <kill+0x2c>
801041fe:	66 90                	xchg   %ax,%ax
80104200:	05 e0 00 00 00       	add    $0xe0,%eax
80104205:	3d 54 65 11 80       	cmp    $0x80116554,%eax
8010420a:	74 44                	je     80104250 <kill+0x70>
    if(p->pid == pid){
8010420c:	39 58 6c             	cmp    %ebx,0x6c(%eax)
8010420f:	75 ef                	jne    80104200 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104211:	83 78 68 02          	cmpl   $0x2,0x68(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104215:	c7 80 88 00 00 00 01 	movl   $0x1,0x88(%eax)
8010421c:	00 00 00 
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010421f:	74 1f                	je     80104240 <kill+0x60>
        p->state = RUNNABLE;
      release(&ptable.lock);
80104221:	83 ec 0c             	sub    $0xc,%esp
80104224:	68 20 2d 11 80       	push   $0x80112d20
80104229:	e8 32 04 00 00       	call   80104660 <release>
      return 0;
8010422e:	83 c4 10             	add    $0x10,%esp
80104231:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104233:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104236:	c9                   	leave  
80104237:	c3                   	ret    
80104238:	90                   	nop
80104239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104240:	c7 40 68 03 00 00 00 	movl   $0x3,0x68(%eax)
80104247:	eb d8                	jmp    80104221 <kill+0x41>
80104249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104250:	83 ec 0c             	sub    $0xc,%esp
80104253:	68 20 2d 11 80       	push   $0x80112d20
80104258:	e8 03 04 00 00       	call   80104660 <release>
  return -1;
8010425d:	83 c4 10             	add    $0x10,%esp
80104260:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104265:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104268:	c9                   	leave  
80104269:	c3                   	ret    
8010426a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104270 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	57                   	push   %edi
80104274:	56                   	push   %esi
80104275:	53                   	push   %ebx
80104276:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104279:	bb 24 2e 11 80       	mov    $0x80112e24,%ebx
8010427e:	83 ec 3c             	sub    $0x3c,%esp
80104281:	eb 27                	jmp    801042aa <procdump+0x3a>
80104283:	90                   	nop
80104284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104288:	83 ec 0c             	sub    $0xc,%esp
8010428b:	68 03 7c 10 80       	push   $0x80107c03
80104290:	e8 db c3 ff ff       	call   80100670 <cprintf>
80104295:	83 c4 10             	add    $0x10,%esp
80104298:	81 c3 e0 00 00 00    	add    $0xe0,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010429e:	81 fb 24 66 11 80    	cmp    $0x80116624,%ebx
801042a4:	0f 84 7e 00 00 00    	je     80104328 <procdump+0xb8>
    if(p->state == UNUSED)
801042aa:	8b 43 98             	mov    -0x68(%ebx),%eax
801042ad:	85 c0                	test   %eax,%eax
801042af:	74 e7                	je     80104298 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042b1:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801042b4:	ba 80 78 10 80       	mov    $0x80107880,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042b9:	77 11                	ja     801042cc <procdump+0x5c>
801042bb:	8b 14 85 e0 78 10 80 	mov    -0x7fef8720(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801042c2:	b8 80 78 10 80       	mov    $0x80107880,%eax
801042c7:	85 d2                	test   %edx,%edx
801042c9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801042cc:	53                   	push   %ebx
801042cd:	52                   	push   %edx
801042ce:	ff 73 9c             	pushl  -0x64(%ebx)
801042d1:	68 84 78 10 80       	push   $0x80107884
801042d6:	e8 95 c3 ff ff       	call   80100670 <cprintf>
    if(p->state == SLEEPING){
801042db:	83 c4 10             	add    $0x10,%esp
801042de:	83 7b 98 02          	cmpl   $0x2,-0x68(%ebx)
801042e2:	75 a4                	jne    80104288 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801042e4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801042e7:	83 ec 08             	sub    $0x8,%esp
801042ea:	8d 7d c0             	lea    -0x40(%ebp),%edi
801042ed:	50                   	push   %eax
801042ee:	8b 43 b0             	mov    -0x50(%ebx),%eax
801042f1:	8b 40 0c             	mov    0xc(%eax),%eax
801042f4:	83 c0 08             	add    $0x8,%eax
801042f7:	50                   	push   %eax
801042f8:	e8 63 01 00 00       	call   80104460 <getcallerpcs>
801042fd:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104300:	8b 17                	mov    (%edi),%edx
80104302:	85 d2                	test   %edx,%edx
80104304:	74 82                	je     80104288 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104306:	83 ec 08             	sub    $0x8,%esp
80104309:	83 c7 04             	add    $0x4,%edi
8010430c:	52                   	push   %edx
8010430d:	68 c1 72 10 80       	push   $0x801072c1
80104312:	e8 59 c3 ff ff       	call   80100670 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104317:	83 c4 10             	add    $0x10,%esp
8010431a:	39 f7                	cmp    %esi,%edi
8010431c:	75 e2                	jne    80104300 <procdump+0x90>
8010431e:	e9 65 ff ff ff       	jmp    80104288 <procdump+0x18>
80104323:	90                   	nop
80104324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104328:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010432b:	5b                   	pop    %ebx
8010432c:	5e                   	pop    %esi
8010432d:	5f                   	pop    %edi
8010432e:	5d                   	pop    %ebp
8010432f:	c3                   	ret    

80104330 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	53                   	push   %ebx
80104334:	83 ec 0c             	sub    $0xc,%esp
80104337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010433a:	68 f8 78 10 80       	push   $0x801078f8
8010433f:	8d 43 04             	lea    0x4(%ebx),%eax
80104342:	50                   	push   %eax
80104343:	e8 f8 00 00 00       	call   80104440 <initlock>
  lk->name = name;
80104348:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010434b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104351:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104354:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010435b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010435e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104361:	c9                   	leave  
80104362:	c3                   	ret    
80104363:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104370 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	56                   	push   %esi
80104374:	53                   	push   %ebx
80104375:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104378:	83 ec 0c             	sub    $0xc,%esp
8010437b:	8d 73 04             	lea    0x4(%ebx),%esi
8010437e:	56                   	push   %esi
8010437f:	e8 bc 01 00 00       	call   80104540 <acquire>
  while (lk->locked) {
80104384:	8b 13                	mov    (%ebx),%edx
80104386:	83 c4 10             	add    $0x10,%esp
80104389:	85 d2                	test   %edx,%edx
8010438b:	74 16                	je     801043a3 <acquiresleep+0x33>
8010438d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104390:	83 ec 08             	sub    $0x8,%esp
80104393:	56                   	push   %esi
80104394:	53                   	push   %ebx
80104395:	e8 06 fc ff ff       	call   80103fa0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010439a:	8b 03                	mov    (%ebx),%eax
8010439c:	83 c4 10             	add    $0x10,%esp
8010439f:	85 c0                	test   %eax,%eax
801043a1:	75 ed                	jne    80104390 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
801043a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801043a9:	e8 02 f4 ff ff       	call   801037b0 <myproc>
801043ae:	8b 40 6c             	mov    0x6c(%eax),%eax
801043b1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801043b4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043ba:	5b                   	pop    %ebx
801043bb:	5e                   	pop    %esi
801043bc:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
801043bd:	e9 9e 02 00 00       	jmp    80104660 <release>
801043c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043d0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	56                   	push   %esi
801043d4:	53                   	push   %ebx
801043d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043d8:	83 ec 0c             	sub    $0xc,%esp
801043db:	8d 73 04             	lea    0x4(%ebx),%esi
801043de:	56                   	push   %esi
801043df:	e8 5c 01 00 00       	call   80104540 <acquire>
  lk->locked = 0;
801043e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801043ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801043f1:	89 1c 24             	mov    %ebx,(%esp)
801043f4:	e8 87 fd ff ff       	call   80104180 <wakeup>
  release(&lk->lk);
801043f9:	89 75 08             	mov    %esi,0x8(%ebp)
801043fc:	83 c4 10             	add    $0x10,%esp
}
801043ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104402:	5b                   	pop    %ebx
80104403:	5e                   	pop    %esi
80104404:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104405:	e9 56 02 00 00       	jmp    80104660 <release>
8010440a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104410 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	56                   	push   %esi
80104414:	53                   	push   %ebx
80104415:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104418:	83 ec 0c             	sub    $0xc,%esp
8010441b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010441e:	53                   	push   %ebx
8010441f:	e8 1c 01 00 00       	call   80104540 <acquire>
  r = lk->locked;
80104424:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104426:	89 1c 24             	mov    %ebx,(%esp)
80104429:	e8 32 02 00 00       	call   80104660 <release>
  return r;
}
8010442e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104431:	89 f0                	mov    %esi,%eax
80104433:	5b                   	pop    %ebx
80104434:	5e                   	pop    %esi
80104435:	5d                   	pop    %ebp
80104436:	c3                   	ret    
80104437:	66 90                	xchg   %ax,%ax
80104439:	66 90                	xchg   %ax,%ax
8010443b:	66 90                	xchg   %ax,%ax
8010443d:	66 90                	xchg   %ax,%ax
8010443f:	90                   	nop

80104440 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104446:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104449:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010444f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104452:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104459:	5d                   	pop    %ebp
8010445a:	c3                   	ret    
8010445b:	90                   	nop
8010445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104460 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104464:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104467:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010446a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010446d:	31 c0                	xor    %eax,%eax
8010446f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104470:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104476:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010447c:	77 1a                	ja     80104498 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010447e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104481:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104484:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104487:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104489:	83 f8 0a             	cmp    $0xa,%eax
8010448c:	75 e2                	jne    80104470 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010448e:	5b                   	pop    %ebx
8010448f:	5d                   	pop    %ebp
80104490:	c3                   	ret    
80104491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104498:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010449f:	83 c0 01             	add    $0x1,%eax
801044a2:	83 f8 0a             	cmp    $0xa,%eax
801044a5:	74 e7                	je     8010448e <getcallerpcs+0x2e>
    pcs[i] = 0;
801044a7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801044ae:	83 c0 01             	add    $0x1,%eax
801044b1:	83 f8 0a             	cmp    $0xa,%eax
801044b4:	75 e2                	jne    80104498 <getcallerpcs+0x38>
801044b6:	eb d6                	jmp    8010448e <getcallerpcs+0x2e>
801044b8:	90                   	nop
801044b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044c0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	53                   	push   %ebx
801044c4:	83 ec 04             	sub    $0x4,%esp
801044c7:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
801044ca:	8b 02                	mov    (%edx),%eax
801044cc:	85 c0                	test   %eax,%eax
801044ce:	75 10                	jne    801044e0 <holding+0x20>
}
801044d0:	83 c4 04             	add    $0x4,%esp
801044d3:	31 c0                	xor    %eax,%eax
801044d5:	5b                   	pop    %ebx
801044d6:	5d                   	pop    %ebp
801044d7:	c3                   	ret    
801044d8:	90                   	nop
801044d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044e0:	8b 5a 08             	mov    0x8(%edx),%ebx
801044e3:	e8 28 f2 ff ff       	call   80103710 <mycpu>
801044e8:	39 c3                	cmp    %eax,%ebx
801044ea:	0f 94 c0             	sete   %al
}
801044ed:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044f0:	0f b6 c0             	movzbl %al,%eax
}
801044f3:	5b                   	pop    %ebx
801044f4:	5d                   	pop    %ebp
801044f5:	c3                   	ret    
801044f6:	8d 76 00             	lea    0x0(%esi),%esi
801044f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104500 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	53                   	push   %ebx
80104504:	83 ec 04             	sub    $0x4,%esp
80104507:	9c                   	pushf  
80104508:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104509:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010450a:	e8 01 f2 ff ff       	call   80103710 <mycpu>
8010450f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104515:	85 c0                	test   %eax,%eax
80104517:	75 11                	jne    8010452a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104519:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010451f:	e8 ec f1 ff ff       	call   80103710 <mycpu>
80104524:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010452a:	e8 e1 f1 ff ff       	call   80103710 <mycpu>
8010452f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104536:	83 c4 04             	add    $0x4,%esp
80104539:	5b                   	pop    %ebx
8010453a:	5d                   	pop    %ebp
8010453b:	c3                   	ret    
8010453c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104540 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104545:	e8 b6 ff ff ff       	call   80104500 <pushcli>
  if(holding(lk))
8010454a:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
8010454d:	8b 03                	mov    (%ebx),%eax
8010454f:	85 c0                	test   %eax,%eax
80104551:	75 7d                	jne    801045d0 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104553:	ba 01 00 00 00       	mov    $0x1,%edx
80104558:	eb 09                	jmp    80104563 <acquire+0x23>
8010455a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104560:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104563:	89 d0                	mov    %edx,%eax
80104565:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104568:	85 c0                	test   %eax,%eax
8010456a:	75 f4                	jne    80104560 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010456c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104571:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104574:	e8 97 f1 ff ff       	call   80103710 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104579:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010457b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010457e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104581:	31 c0                	xor    %eax,%eax
80104583:	90                   	nop
80104584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104588:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010458e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104594:	77 1a                	ja     801045b0 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104596:	8b 5a 04             	mov    0x4(%edx),%ebx
80104599:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010459c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010459f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801045a1:	83 f8 0a             	cmp    $0xa,%eax
801045a4:	75 e2                	jne    80104588 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801045a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045a9:	5b                   	pop    %ebx
801045aa:	5e                   	pop    %esi
801045ab:	5d                   	pop    %ebp
801045ac:	c3                   	ret    
801045ad:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801045b0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801045b7:	83 c0 01             	add    $0x1,%eax
801045ba:	83 f8 0a             	cmp    $0xa,%eax
801045bd:	74 e7                	je     801045a6 <acquire+0x66>
    pcs[i] = 0;
801045bf:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801045c6:	83 c0 01             	add    $0x1,%eax
801045c9:	83 f8 0a             	cmp    $0xa,%eax
801045cc:	75 e2                	jne    801045b0 <acquire+0x70>
801045ce:	eb d6                	jmp    801045a6 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801045d0:	8b 73 08             	mov    0x8(%ebx),%esi
801045d3:	e8 38 f1 ff ff       	call   80103710 <mycpu>
801045d8:	39 c6                	cmp    %eax,%esi
801045da:	0f 85 73 ff ff ff    	jne    80104553 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
801045e0:	83 ec 0c             	sub    $0xc,%esp
801045e3:	68 03 79 10 80       	push   $0x80107903
801045e8:	e8 93 bd ff ff       	call   80100380 <panic>
801045ed:	8d 76 00             	lea    0x0(%esi),%esi

801045f0 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045f6:	9c                   	pushf  
801045f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045f8:	f6 c4 02             	test   $0x2,%ah
801045fb:	75 52                	jne    8010464f <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801045fd:	e8 0e f1 ff ff       	call   80103710 <mycpu>
80104602:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104608:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010460b:	85 d2                	test   %edx,%edx
8010460d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104613:	78 2d                	js     80104642 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104615:	e8 f6 f0 ff ff       	call   80103710 <mycpu>
8010461a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104620:	85 d2                	test   %edx,%edx
80104622:	74 0c                	je     80104630 <popcli+0x40>
    sti();
}
80104624:	c9                   	leave  
80104625:	c3                   	ret    
80104626:	8d 76 00             	lea    0x0(%esi),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104630:	e8 db f0 ff ff       	call   80103710 <mycpu>
80104635:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010463b:	85 c0                	test   %eax,%eax
8010463d:	74 e5                	je     80104624 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010463f:	fb                   	sti    
    sti();
}
80104640:	c9                   	leave  
80104641:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80104642:	83 ec 0c             	sub    $0xc,%esp
80104645:	68 22 79 10 80       	push   $0x80107922
8010464a:	e8 31 bd ff ff       	call   80100380 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010464f:	83 ec 0c             	sub    $0xc,%esp
80104652:	68 0b 79 10 80       	push   $0x8010790b
80104657:	e8 24 bd ff ff       	call   80100380 <panic>
8010465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104660 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	56                   	push   %esi
80104664:	53                   	push   %ebx
80104665:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104668:	8b 03                	mov    (%ebx),%eax
8010466a:	85 c0                	test   %eax,%eax
8010466c:	75 12                	jne    80104680 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010466e:	83 ec 0c             	sub    $0xc,%esp
80104671:	68 29 79 10 80       	push   $0x80107929
80104676:	e8 05 bd ff ff       	call   80100380 <panic>
8010467b:	90                   	nop
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104680:	8b 73 08             	mov    0x8(%ebx),%esi
80104683:	e8 88 f0 ff ff       	call   80103710 <mycpu>
80104688:	39 c6                	cmp    %eax,%esi
8010468a:	75 e2                	jne    8010466e <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
8010468c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104693:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010469a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010469f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
801046a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046a8:	5b                   	pop    %ebx
801046a9:	5e                   	pop    %esi
801046aa:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
801046ab:	e9 40 ff ff ff       	jmp    801045f0 <popcli>

801046b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	57                   	push   %edi
801046b4:	53                   	push   %ebx
801046b5:	8b 55 08             	mov    0x8(%ebp),%edx
801046b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801046bb:	f6 c2 03             	test   $0x3,%dl
801046be:	75 05                	jne    801046c5 <memset+0x15>
801046c0:	f6 c1 03             	test   $0x3,%cl
801046c3:	74 13                	je     801046d8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801046c5:	89 d7                	mov    %edx,%edi
801046c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801046ca:	fc                   	cld    
801046cb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801046cd:	5b                   	pop    %ebx
801046ce:	89 d0                	mov    %edx,%eax
801046d0:	5f                   	pop    %edi
801046d1:	5d                   	pop    %ebp
801046d2:	c3                   	ret    
801046d3:	90                   	nop
801046d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801046d8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801046dc:	c1 e9 02             	shr    $0x2,%ecx
801046df:	89 fb                	mov    %edi,%ebx
801046e1:	89 f8                	mov    %edi,%eax
801046e3:	c1 e3 18             	shl    $0x18,%ebx
801046e6:	c1 e0 10             	shl    $0x10,%eax
801046e9:	09 d8                	or     %ebx,%eax
801046eb:	09 f8                	or     %edi,%eax
801046ed:	c1 e7 08             	shl    $0x8,%edi
801046f0:	09 f8                	or     %edi,%eax
801046f2:	89 d7                	mov    %edx,%edi
801046f4:	fc                   	cld    
801046f5:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801046f7:	5b                   	pop    %ebx
801046f8:	89 d0                	mov    %edx,%eax
801046fa:	5f                   	pop    %edi
801046fb:	5d                   	pop    %ebp
801046fc:	c3                   	ret    
801046fd:	8d 76 00             	lea    0x0(%esi),%esi

80104700 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	57                   	push   %edi
80104704:	56                   	push   %esi
80104705:	8b 45 10             	mov    0x10(%ebp),%eax
80104708:	53                   	push   %ebx
80104709:	8b 75 0c             	mov    0xc(%ebp),%esi
8010470c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010470f:	85 c0                	test   %eax,%eax
80104711:	74 29                	je     8010473c <memcmp+0x3c>
    if(*s1 != *s2)
80104713:	0f b6 13             	movzbl (%ebx),%edx
80104716:	0f b6 0e             	movzbl (%esi),%ecx
80104719:	38 d1                	cmp    %dl,%cl
8010471b:	75 2b                	jne    80104748 <memcmp+0x48>
8010471d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104720:	31 c0                	xor    %eax,%eax
80104722:	eb 14                	jmp    80104738 <memcmp+0x38>
80104724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104728:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010472d:	83 c0 01             	add    $0x1,%eax
80104730:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104734:	38 ca                	cmp    %cl,%dl
80104736:	75 10                	jne    80104748 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104738:	39 f8                	cmp    %edi,%eax
8010473a:	75 ec                	jne    80104728 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010473c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010473d:	31 c0                	xor    %eax,%eax
}
8010473f:	5e                   	pop    %esi
80104740:	5f                   	pop    %edi
80104741:	5d                   	pop    %ebp
80104742:	c3                   	ret    
80104743:	90                   	nop
80104744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104748:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010474b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010474c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010474e:	5e                   	pop    %esi
8010474f:	5f                   	pop    %edi
80104750:	5d                   	pop    %ebp
80104751:	c3                   	ret    
80104752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104760 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	56                   	push   %esi
80104764:	53                   	push   %ebx
80104765:	8b 45 08             	mov    0x8(%ebp),%eax
80104768:	8b 75 0c             	mov    0xc(%ebp),%esi
8010476b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010476e:	39 c6                	cmp    %eax,%esi
80104770:	73 2e                	jae    801047a0 <memmove+0x40>
80104772:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104775:	39 c8                	cmp    %ecx,%eax
80104777:	73 27                	jae    801047a0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104779:	85 db                	test   %ebx,%ebx
8010477b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010477e:	74 17                	je     80104797 <memmove+0x37>
      *--d = *--s;
80104780:	29 d9                	sub    %ebx,%ecx
80104782:	89 cb                	mov    %ecx,%ebx
80104784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104788:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010478c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010478f:	83 ea 01             	sub    $0x1,%edx
80104792:	83 fa ff             	cmp    $0xffffffff,%edx
80104795:	75 f1                	jne    80104788 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104797:	5b                   	pop    %ebx
80104798:	5e                   	pop    %esi
80104799:	5d                   	pop    %ebp
8010479a:	c3                   	ret    
8010479b:	90                   	nop
8010479c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801047a0:	31 d2                	xor    %edx,%edx
801047a2:	85 db                	test   %ebx,%ebx
801047a4:	74 f1                	je     80104797 <memmove+0x37>
801047a6:	8d 76 00             	lea    0x0(%esi),%esi
801047a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
801047b0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801047b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801047b7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801047ba:	39 d3                	cmp    %edx,%ebx
801047bc:	75 f2                	jne    801047b0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801047be:	5b                   	pop    %ebx
801047bf:	5e                   	pop    %esi
801047c0:	5d                   	pop    %ebp
801047c1:	c3                   	ret    
801047c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047d0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801047d3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801047d4:	eb 8a                	jmp    80104760 <memmove>
801047d6:	8d 76 00             	lea    0x0(%esi),%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047e0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	57                   	push   %edi
801047e4:	56                   	push   %esi
801047e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047e8:	53                   	push   %ebx
801047e9:	8b 7d 08             	mov    0x8(%ebp),%edi
801047ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801047ef:	85 c9                	test   %ecx,%ecx
801047f1:	74 37                	je     8010482a <strncmp+0x4a>
801047f3:	0f b6 17             	movzbl (%edi),%edx
801047f6:	0f b6 1e             	movzbl (%esi),%ebx
801047f9:	84 d2                	test   %dl,%dl
801047fb:	74 3f                	je     8010483c <strncmp+0x5c>
801047fd:	38 d3                	cmp    %dl,%bl
801047ff:	75 3b                	jne    8010483c <strncmp+0x5c>
80104801:	8d 47 01             	lea    0x1(%edi),%eax
80104804:	01 cf                	add    %ecx,%edi
80104806:	eb 1b                	jmp    80104823 <strncmp+0x43>
80104808:	90                   	nop
80104809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104810:	0f b6 10             	movzbl (%eax),%edx
80104813:	84 d2                	test   %dl,%dl
80104815:	74 21                	je     80104838 <strncmp+0x58>
80104817:	0f b6 19             	movzbl (%ecx),%ebx
8010481a:	83 c0 01             	add    $0x1,%eax
8010481d:	89 ce                	mov    %ecx,%esi
8010481f:	38 da                	cmp    %bl,%dl
80104821:	75 19                	jne    8010483c <strncmp+0x5c>
80104823:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104825:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104828:	75 e6                	jne    80104810 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010482a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010482b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010482d:	5e                   	pop    %esi
8010482e:	5f                   	pop    %edi
8010482f:	5d                   	pop    %ebp
80104830:	c3                   	ret    
80104831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104838:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010483c:	0f b6 c2             	movzbl %dl,%eax
8010483f:	29 d8                	sub    %ebx,%eax
}
80104841:	5b                   	pop    %ebx
80104842:	5e                   	pop    %esi
80104843:	5f                   	pop    %edi
80104844:	5d                   	pop    %ebp
80104845:	c3                   	ret    
80104846:	8d 76 00             	lea    0x0(%esi),%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104850 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	56                   	push   %esi
80104854:	53                   	push   %ebx
80104855:	8b 45 08             	mov    0x8(%ebp),%eax
80104858:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010485b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010485e:	89 c2                	mov    %eax,%edx
80104860:	eb 19                	jmp    8010487b <strncpy+0x2b>
80104862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104868:	83 c3 01             	add    $0x1,%ebx
8010486b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010486f:	83 c2 01             	add    $0x1,%edx
80104872:	84 c9                	test   %cl,%cl
80104874:	88 4a ff             	mov    %cl,-0x1(%edx)
80104877:	74 09                	je     80104882 <strncpy+0x32>
80104879:	89 f1                	mov    %esi,%ecx
8010487b:	85 c9                	test   %ecx,%ecx
8010487d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104880:	7f e6                	jg     80104868 <strncpy+0x18>
    ;
  while(n-- > 0)
80104882:	31 c9                	xor    %ecx,%ecx
80104884:	85 f6                	test   %esi,%esi
80104886:	7e 17                	jle    8010489f <strncpy+0x4f>
80104888:	90                   	nop
80104889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104890:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104894:	89 f3                	mov    %esi,%ebx
80104896:	83 c1 01             	add    $0x1,%ecx
80104899:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010489b:	85 db                	test   %ebx,%ebx
8010489d:	7f f1                	jg     80104890 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010489f:	5b                   	pop    %ebx
801048a0:	5e                   	pop    %esi
801048a1:	5d                   	pop    %ebp
801048a2:	c3                   	ret    
801048a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048b0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	56                   	push   %esi
801048b4:	53                   	push   %ebx
801048b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048b8:	8b 45 08             	mov    0x8(%ebp),%eax
801048bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801048be:	85 c9                	test   %ecx,%ecx
801048c0:	7e 26                	jle    801048e8 <safestrcpy+0x38>
801048c2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801048c6:	89 c1                	mov    %eax,%ecx
801048c8:	eb 17                	jmp    801048e1 <safestrcpy+0x31>
801048ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801048d0:	83 c2 01             	add    $0x1,%edx
801048d3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801048d7:	83 c1 01             	add    $0x1,%ecx
801048da:	84 db                	test   %bl,%bl
801048dc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801048df:	74 04                	je     801048e5 <safestrcpy+0x35>
801048e1:	39 f2                	cmp    %esi,%edx
801048e3:	75 eb                	jne    801048d0 <safestrcpy+0x20>
    ;
  *s = 0;
801048e5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801048e8:	5b                   	pop    %ebx
801048e9:	5e                   	pop    %esi
801048ea:	5d                   	pop    %ebp
801048eb:	c3                   	ret    
801048ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048f0 <strlen>:

int
strlen(const char *s)
{
801048f0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801048f1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801048f3:	89 e5                	mov    %esp,%ebp
801048f5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801048f8:	80 3a 00             	cmpb   $0x0,(%edx)
801048fb:	74 0c                	je     80104909 <strlen+0x19>
801048fd:	8d 76 00             	lea    0x0(%esi),%esi
80104900:	83 c0 01             	add    $0x1,%eax
80104903:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104907:	75 f7                	jne    80104900 <strlen+0x10>
    ;
  return n;
}
80104909:	5d                   	pop    %ebp
8010490a:	c3                   	ret    

8010490b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010490b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010490f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104913:	55                   	push   %ebp
  pushl %ebx
80104914:	53                   	push   %ebx
  pushl %esi
80104915:	56                   	push   %esi
  pushl %edi
80104916:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104917:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104919:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010491b:	5f                   	pop    %edi
  popl %esi
8010491c:	5e                   	pop    %esi
  popl %ebx
8010491d:	5b                   	pop    %ebx
  popl %ebp
8010491e:	5d                   	pop    %ebp
  ret
8010491f:	c3                   	ret    

80104920 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	53                   	push   %ebx
80104924:	83 ec 04             	sub    $0x4,%esp
80104927:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010492a:	e8 81 ee ff ff       	call   801037b0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010492f:	8b 40 5c             	mov    0x5c(%eax),%eax
80104932:	39 d8                	cmp    %ebx,%eax
80104934:	76 1a                	jbe    80104950 <fetchint+0x30>
80104936:	8d 53 04             	lea    0x4(%ebx),%edx
80104939:	39 d0                	cmp    %edx,%eax
8010493b:	72 13                	jb     80104950 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010493d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104940:	8b 13                	mov    (%ebx),%edx
80104942:	89 10                	mov    %edx,(%eax)
  return 0;
80104944:	31 c0                	xor    %eax,%eax
}
80104946:	83 c4 04             	add    $0x4,%esp
80104949:	5b                   	pop    %ebx
8010494a:	5d                   	pop    %ebp
8010494b:	c3                   	ret    
8010494c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104950:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104955:	eb ef                	jmp    80104946 <fetchint+0x26>
80104957:	89 f6                	mov    %esi,%esi
80104959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104960 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	53                   	push   %ebx
80104964:	83 ec 04             	sub    $0x4,%esp
80104967:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010496a:	e8 41 ee ff ff       	call   801037b0 <myproc>

  if(addr >= curproc->sz)
8010496f:	39 58 5c             	cmp    %ebx,0x5c(%eax)
80104972:	76 28                	jbe    8010499c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104974:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104977:	89 da                	mov    %ebx,%edx
80104979:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010497b:	8b 40 5c             	mov    0x5c(%eax),%eax
  for(s = *pp; s < ep; s++){
8010497e:	39 c3                	cmp    %eax,%ebx
80104980:	73 1a                	jae    8010499c <fetchstr+0x3c>
    if(*s == 0)
80104982:	80 3b 00             	cmpb   $0x0,(%ebx)
80104985:	75 0e                	jne    80104995 <fetchstr+0x35>
80104987:	eb 27                	jmp    801049b0 <fetchstr+0x50>
80104989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104990:	80 3a 00             	cmpb   $0x0,(%edx)
80104993:	74 1b                	je     801049b0 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104995:	83 c2 01             	add    $0x1,%edx
80104998:	39 d0                	cmp    %edx,%eax
8010499a:	77 f4                	ja     80104990 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
8010499c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010499f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801049a4:	5b                   	pop    %ebx
801049a5:	5d                   	pop    %ebp
801049a6:	c3                   	ret    
801049a7:	89 f6                	mov    %esi,%esi
801049a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049b0:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801049b3:	89 d0                	mov    %edx,%eax
801049b5:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801049b7:	5b                   	pop    %ebx
801049b8:	5d                   	pop    %ebp
801049b9:	c3                   	ret    
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049c0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	56                   	push   %esi
801049c4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049c5:	e8 e6 ed ff ff       	call   801037b0 <myproc>
801049ca:	8b 40 7c             	mov    0x7c(%eax),%eax
801049cd:	8b 55 08             	mov    0x8(%ebp),%edx
801049d0:	8b 40 44             	mov    0x44(%eax),%eax
801049d3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801049d6:	e8 d5 ed ff ff       	call   801037b0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049db:	8b 40 5c             	mov    0x5c(%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049de:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049e1:	39 c6                	cmp    %eax,%esi
801049e3:	73 1b                	jae    80104a00 <argint+0x40>
801049e5:	8d 53 08             	lea    0x8(%ebx),%edx
801049e8:	39 d0                	cmp    %edx,%eax
801049ea:	72 14                	jb     80104a00 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
801049ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801049ef:	8b 53 04             	mov    0x4(%ebx),%edx
801049f2:	89 10                	mov    %edx,(%eax)
  return 0;
801049f4:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
801049f6:	5b                   	pop    %ebx
801049f7:	5e                   	pop    %esi
801049f8:	5d                   	pop    %ebp
801049f9:	c3                   	ret    
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104a00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a05:	eb ef                	jmp    801049f6 <argint+0x36>
80104a07:	89 f6                	mov    %esi,%esi
80104a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a10 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	56                   	push   %esi
80104a14:	53                   	push   %ebx
80104a15:	83 ec 10             	sub    $0x10,%esp
80104a18:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104a1b:	e8 90 ed ff ff       	call   801037b0 <myproc>
80104a20:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104a22:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a25:	83 ec 08             	sub    $0x8,%esp
80104a28:	50                   	push   %eax
80104a29:	ff 75 08             	pushl  0x8(%ebp)
80104a2c:	e8 8f ff ff ff       	call   801049c0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a31:	c1 e8 1f             	shr    $0x1f,%eax
80104a34:	83 c4 10             	add    $0x10,%esp
80104a37:	84 c0                	test   %al,%al
80104a39:	75 2d                	jne    80104a68 <argptr+0x58>
80104a3b:	89 d8                	mov    %ebx,%eax
80104a3d:	c1 e8 1f             	shr    $0x1f,%eax
80104a40:	84 c0                	test   %al,%al
80104a42:	75 24                	jne    80104a68 <argptr+0x58>
80104a44:	8b 56 5c             	mov    0x5c(%esi),%edx
80104a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a4a:	39 c2                	cmp    %eax,%edx
80104a4c:	76 1a                	jbe    80104a68 <argptr+0x58>
80104a4e:	01 c3                	add    %eax,%ebx
80104a50:	39 da                	cmp    %ebx,%edx
80104a52:	72 14                	jb     80104a68 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104a54:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a57:	89 02                	mov    %eax,(%edx)
  return 0;
80104a59:	31 c0                	xor    %eax,%eax
}
80104a5b:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a5e:	5b                   	pop    %ebx
80104a5f:	5e                   	pop    %esi
80104a60:	5d                   	pop    %ebp
80104a61:	c3                   	ret    
80104a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104a68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a6d:	eb ec                	jmp    80104a5b <argptr+0x4b>
80104a6f:	90                   	nop

80104a70 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a76:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a79:	50                   	push   %eax
80104a7a:	ff 75 08             	pushl  0x8(%ebp)
80104a7d:	e8 3e ff ff ff       	call   801049c0 <argint>
80104a82:	83 c4 10             	add    $0x10,%esp
80104a85:	85 c0                	test   %eax,%eax
80104a87:	78 17                	js     80104aa0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104a89:	83 ec 08             	sub    $0x8,%esp
80104a8c:	ff 75 0c             	pushl  0xc(%ebp)
80104a8f:	ff 75 f4             	pushl  -0xc(%ebp)
80104a92:	e8 c9 fe ff ff       	call   80104960 <fetchstr>
80104a97:	83 c4 10             	add    $0x10,%esp
}
80104a9a:	c9                   	leave  
80104a9b:	c3                   	ret    
80104a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104aa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104aa5:	c9                   	leave  
80104aa6:	c3                   	ret    
80104aa7:	89 f6                	mov    %esi,%esi
80104aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ab0 <syscall>:
[SYS_change_priority]	sys_change_priority,
};

void
syscall(void)
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	56                   	push   %esi
80104ab4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104ab5:	e8 f6 ec ff ff       	call   801037b0 <myproc>

  num = curproc->tf->eax;
80104aba:	8b 70 7c             	mov    0x7c(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104abd:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104abf:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104ac2:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ac5:	83 fa 17             	cmp    $0x17,%edx
80104ac8:	77 1e                	ja     80104ae8 <syscall+0x38>
80104aca:	8b 14 85 60 79 10 80 	mov    -0x7fef86a0(,%eax,4),%edx
80104ad1:	85 d2                	test   %edx,%edx
80104ad3:	74 13                	je     80104ae8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104ad5:	ff d2                	call   *%edx
80104ad7:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104ada:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104add:	5b                   	pop    %ebx
80104ade:	5e                   	pop    %esi
80104adf:	5d                   	pop    %ebp
80104ae0:	c3                   	ret    
80104ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104ae8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ae9:	8d 83 d0 00 00 00    	lea    0xd0(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104aef:	50                   	push   %eax
80104af0:	ff 73 6c             	pushl  0x6c(%ebx)
80104af3:	68 31 79 10 80       	push   $0x80107931
80104af8:	e8 73 bb ff ff       	call   80100670 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104afd:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104b00:	83 c4 10             	add    $0x10,%esp
80104b03:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104b0a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b0d:	5b                   	pop    %ebx
80104b0e:	5e                   	pop    %esi
80104b0f:	5d                   	pop    %ebp
80104b10:	c3                   	ret    
80104b11:	66 90                	xchg   %ax,%ax
80104b13:	66 90                	xchg   %ax,%ax
80104b15:	66 90                	xchg   %ax,%ax
80104b17:	66 90                	xchg   %ax,%ax
80104b19:	66 90                	xchg   %ax,%ax
80104b1b:	66 90                	xchg   %ax,%ax
80104b1d:	66 90                	xchg   %ax,%ax
80104b1f:	90                   	nop

80104b20 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	57                   	push   %edi
80104b24:	56                   	push   %esi
80104b25:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b26:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b29:	83 ec 44             	sub    $0x44,%esp
80104b2c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104b2f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b32:	56                   	push   %esi
80104b33:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b34:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104b37:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b3a:	e8 c1 d3 ff ff       	call   80101f00 <nameiparent>
80104b3f:	83 c4 10             	add    $0x10,%esp
80104b42:	85 c0                	test   %eax,%eax
80104b44:	0f 84 f6 00 00 00    	je     80104c40 <create+0x120>
    return 0;
  ilock(dp);
80104b4a:	83 ec 0c             	sub    $0xc,%esp
80104b4d:	89 c7                	mov    %eax,%edi
80104b4f:	50                   	push   %eax
80104b50:	e8 2b cb ff ff       	call   80101680 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104b55:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b58:	83 c4 0c             	add    $0xc,%esp
80104b5b:	50                   	push   %eax
80104b5c:	56                   	push   %esi
80104b5d:	57                   	push   %edi
80104b5e:	e8 4d d0 ff ff       	call   80101bb0 <dirlookup>
80104b63:	83 c4 10             	add    $0x10,%esp
80104b66:	85 c0                	test   %eax,%eax
80104b68:	89 c3                	mov    %eax,%ebx
80104b6a:	74 54                	je     80104bc0 <create+0xa0>
    iunlockput(dp);
80104b6c:	83 ec 0c             	sub    $0xc,%esp
80104b6f:	57                   	push   %edi
80104b70:	e8 9b cd ff ff       	call   80101910 <iunlockput>
    ilock(ip);
80104b75:	89 1c 24             	mov    %ebx,(%esp)
80104b78:	e8 03 cb ff ff       	call   80101680 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b7d:	83 c4 10             	add    $0x10,%esp
80104b80:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104b85:	75 19                	jne    80104ba0 <create+0x80>
80104b87:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104b8c:	89 d8                	mov    %ebx,%eax
80104b8e:	75 10                	jne    80104ba0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b93:	5b                   	pop    %ebx
80104b94:	5e                   	pop    %esi
80104b95:	5f                   	pop    %edi
80104b96:	5d                   	pop    %ebp
80104b97:	c3                   	ret    
80104b98:	90                   	nop
80104b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104ba0:	83 ec 0c             	sub    $0xc,%esp
80104ba3:	53                   	push   %ebx
80104ba4:	e8 67 cd ff ff       	call   80101910 <iunlockput>
    return 0;
80104ba9:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104bac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104baf:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104bb1:	5b                   	pop    %ebx
80104bb2:	5e                   	pop    %esi
80104bb3:	5f                   	pop    %edi
80104bb4:	5d                   	pop    %ebp
80104bb5:	c3                   	ret    
80104bb6:	8d 76 00             	lea    0x0(%esi),%esi
80104bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104bc0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104bc4:	83 ec 08             	sub    $0x8,%esp
80104bc7:	50                   	push   %eax
80104bc8:	ff 37                	pushl  (%edi)
80104bca:	e8 41 c9 ff ff       	call   80101510 <ialloc>
80104bcf:	83 c4 10             	add    $0x10,%esp
80104bd2:	85 c0                	test   %eax,%eax
80104bd4:	89 c3                	mov    %eax,%ebx
80104bd6:	0f 84 cc 00 00 00    	je     80104ca8 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104bdc:	83 ec 0c             	sub    $0xc,%esp
80104bdf:	50                   	push   %eax
80104be0:	e8 9b ca ff ff       	call   80101680 <ilock>
  ip->major = major;
80104be5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104be9:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104bed:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104bf1:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104bf5:	b8 01 00 00 00       	mov    $0x1,%eax
80104bfa:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104bfe:	89 1c 24             	mov    %ebx,(%esp)
80104c01:	e8 ca c9 ff ff       	call   801015d0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104c06:	83 c4 10             	add    $0x10,%esp
80104c09:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104c0e:	74 40                	je     80104c50 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104c10:	83 ec 04             	sub    $0x4,%esp
80104c13:	ff 73 04             	pushl  0x4(%ebx)
80104c16:	56                   	push   %esi
80104c17:	57                   	push   %edi
80104c18:	e8 03 d2 ff ff       	call   80101e20 <dirlink>
80104c1d:	83 c4 10             	add    $0x10,%esp
80104c20:	85 c0                	test   %eax,%eax
80104c22:	78 77                	js     80104c9b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104c24:	83 ec 0c             	sub    $0xc,%esp
80104c27:	57                   	push   %edi
80104c28:	e8 e3 cc ff ff       	call   80101910 <iunlockput>

  return ip;
80104c2d:	83 c4 10             	add    $0x10,%esp
}
80104c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104c33:	89 d8                	mov    %ebx,%eax
}
80104c35:	5b                   	pop    %ebx
80104c36:	5e                   	pop    %esi
80104c37:	5f                   	pop    %edi
80104c38:	5d                   	pop    %ebp
80104c39:	c3                   	ret    
80104c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104c40:	31 c0                	xor    %eax,%eax
80104c42:	e9 49 ff ff ff       	jmp    80104b90 <create+0x70>
80104c47:	89 f6                	mov    %esi,%esi
80104c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104c50:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104c55:	83 ec 0c             	sub    $0xc,%esp
80104c58:	57                   	push   %edi
80104c59:	e8 72 c9 ff ff       	call   801015d0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c5e:	83 c4 0c             	add    $0xc,%esp
80104c61:	ff 73 04             	pushl  0x4(%ebx)
80104c64:	68 e0 79 10 80       	push   $0x801079e0
80104c69:	53                   	push   %ebx
80104c6a:	e8 b1 d1 ff ff       	call   80101e20 <dirlink>
80104c6f:	83 c4 10             	add    $0x10,%esp
80104c72:	85 c0                	test   %eax,%eax
80104c74:	78 18                	js     80104c8e <create+0x16e>
80104c76:	83 ec 04             	sub    $0x4,%esp
80104c79:	ff 77 04             	pushl  0x4(%edi)
80104c7c:	68 df 79 10 80       	push   $0x801079df
80104c81:	53                   	push   %ebx
80104c82:	e8 99 d1 ff ff       	call   80101e20 <dirlink>
80104c87:	83 c4 10             	add    $0x10,%esp
80104c8a:	85 c0                	test   %eax,%eax
80104c8c:	79 82                	jns    80104c10 <create+0xf0>
      panic("create dots");
80104c8e:	83 ec 0c             	sub    $0xc,%esp
80104c91:	68 d3 79 10 80       	push   $0x801079d3
80104c96:	e8 e5 b6 ff ff       	call   80100380 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104c9b:	83 ec 0c             	sub    $0xc,%esp
80104c9e:	68 e2 79 10 80       	push   $0x801079e2
80104ca3:	e8 d8 b6 ff ff       	call   80100380 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104ca8:	83 ec 0c             	sub    $0xc,%esp
80104cab:	68 c4 79 10 80       	push   $0x801079c4
80104cb0:	e8 cb b6 ff ff       	call   80100380 <panic>
80104cb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cc0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104cc0:	55                   	push   %ebp
80104cc1:	89 e5                	mov    %esp,%ebp
80104cc3:	56                   	push   %esi
80104cc4:	53                   	push   %ebx
80104cc5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104cc7:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104cca:	89 d3                	mov    %edx,%ebx
80104ccc:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104ccf:	50                   	push   %eax
80104cd0:	6a 00                	push   $0x0
80104cd2:	e8 e9 fc ff ff       	call   801049c0 <argint>
80104cd7:	83 c4 10             	add    $0x10,%esp
80104cda:	85 c0                	test   %eax,%eax
80104cdc:	78 32                	js     80104d10 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104cde:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ce2:	77 2c                	ja     80104d10 <argfd.constprop.0+0x50>
80104ce4:	e8 c7 ea ff ff       	call   801037b0 <myproc>
80104ce9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104cec:	8b 84 90 8c 00 00 00 	mov    0x8c(%eax,%edx,4),%eax
80104cf3:	85 c0                	test   %eax,%eax
80104cf5:	74 19                	je     80104d10 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104cf7:	85 f6                	test   %esi,%esi
80104cf9:	74 02                	je     80104cfd <argfd.constprop.0+0x3d>
    *pfd = fd;
80104cfb:	89 16                	mov    %edx,(%esi)
  if(pf)
80104cfd:	85 db                	test   %ebx,%ebx
80104cff:	74 1f                	je     80104d20 <argfd.constprop.0+0x60>
    *pf = f;
80104d01:	89 03                	mov    %eax,(%ebx)
  return 0;
80104d03:	31 c0                	xor    %eax,%eax
}
80104d05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d08:	5b                   	pop    %ebx
80104d09:	5e                   	pop    %esi
80104d0a:	5d                   	pop    %ebp
80104d0b:	c3                   	ret    
80104d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d10:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104d13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104d18:	5b                   	pop    %ebx
80104d19:	5e                   	pop    %esi
80104d1a:	5d                   	pop    %ebp
80104d1b:	c3                   	ret    
80104d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104d20:	31 c0                	xor    %eax,%eax
80104d22:	eb e1                	jmp    80104d05 <argfd.constprop.0+0x45>
80104d24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d30 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104d30:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d31:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104d33:	89 e5                	mov    %esp,%ebp
80104d35:	56                   	push   %esi
80104d36:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d37:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104d3a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104d3d:	e8 7e ff ff ff       	call   80104cc0 <argfd.constprop.0>
80104d42:	85 c0                	test   %eax,%eax
80104d44:	78 1d                	js     80104d63 <sys_dup+0x33>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d46:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104d48:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104d4b:	e8 60 ea ff ff       	call   801037b0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104d50:	8b 94 98 8c 00 00 00 	mov    0x8c(%eax,%ebx,4),%edx
80104d57:	85 d2                	test   %edx,%edx
80104d59:	74 15                	je     80104d70 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104d5b:	83 c3 01             	add    $0x1,%ebx
80104d5e:	83 fb 10             	cmp    $0x10,%ebx
80104d61:	75 ed                	jne    80104d50 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d63:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104d66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104d6b:	5b                   	pop    %ebx
80104d6c:	5e                   	pop    %esi
80104d6d:	5d                   	pop    %ebp
80104d6e:	c3                   	ret    
80104d6f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104d70:	89 b4 98 8c 00 00 00 	mov    %esi,0x8c(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104d77:	83 ec 0c             	sub    $0xc,%esp
80104d7a:	ff 75 f4             	pushl  -0xc(%ebp)
80104d7d:	e8 6e c0 ff ff       	call   80100df0 <filedup>
  return fd;
80104d82:	83 c4 10             	add    $0x10,%esp
}
80104d85:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104d88:	89 d8                	mov    %ebx,%eax
}
80104d8a:	5b                   	pop    %ebx
80104d8b:	5e                   	pop    %esi
80104d8c:	5d                   	pop    %ebp
80104d8d:	c3                   	ret    
80104d8e:	66 90                	xchg   %ax,%ax

80104d90 <sys_read>:

int
sys_read(void)
{
80104d90:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d91:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104d93:	89 e5                	mov    %esp,%ebp
80104d95:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d9b:	e8 20 ff ff ff       	call   80104cc0 <argfd.constprop.0>
80104da0:	85 c0                	test   %eax,%eax
80104da2:	78 4c                	js     80104df0 <sys_read+0x60>
80104da4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104da7:	83 ec 08             	sub    $0x8,%esp
80104daa:	50                   	push   %eax
80104dab:	6a 02                	push   $0x2
80104dad:	e8 0e fc ff ff       	call   801049c0 <argint>
80104db2:	83 c4 10             	add    $0x10,%esp
80104db5:	85 c0                	test   %eax,%eax
80104db7:	78 37                	js     80104df0 <sys_read+0x60>
80104db9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dbc:	83 ec 04             	sub    $0x4,%esp
80104dbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104dc2:	50                   	push   %eax
80104dc3:	6a 01                	push   $0x1
80104dc5:	e8 46 fc ff ff       	call   80104a10 <argptr>
80104dca:	83 c4 10             	add    $0x10,%esp
80104dcd:	85 c0                	test   %eax,%eax
80104dcf:	78 1f                	js     80104df0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104dd1:	83 ec 04             	sub    $0x4,%esp
80104dd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104dd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dda:	ff 75 ec             	pushl  -0x14(%ebp)
80104ddd:	e8 7e c1 ff ff       	call   80100f60 <fileread>
80104de2:	83 c4 10             	add    $0x10,%esp
}
80104de5:	c9                   	leave  
80104de6:	c3                   	ret    
80104de7:	89 f6                	mov    %esi,%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <sys_write>:

int
sys_write(void)
{
80104e00:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e01:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104e03:	89 e5                	mov    %esp,%ebp
80104e05:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e0b:	e8 b0 fe ff ff       	call   80104cc0 <argfd.constprop.0>
80104e10:	85 c0                	test   %eax,%eax
80104e12:	78 4c                	js     80104e60 <sys_write+0x60>
80104e14:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e17:	83 ec 08             	sub    $0x8,%esp
80104e1a:	50                   	push   %eax
80104e1b:	6a 02                	push   $0x2
80104e1d:	e8 9e fb ff ff       	call   801049c0 <argint>
80104e22:	83 c4 10             	add    $0x10,%esp
80104e25:	85 c0                	test   %eax,%eax
80104e27:	78 37                	js     80104e60 <sys_write+0x60>
80104e29:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e2c:	83 ec 04             	sub    $0x4,%esp
80104e2f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e32:	50                   	push   %eax
80104e33:	6a 01                	push   $0x1
80104e35:	e8 d6 fb ff ff       	call   80104a10 <argptr>
80104e3a:	83 c4 10             	add    $0x10,%esp
80104e3d:	85 c0                	test   %eax,%eax
80104e3f:	78 1f                	js     80104e60 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104e41:	83 ec 04             	sub    $0x4,%esp
80104e44:	ff 75 f0             	pushl  -0x10(%ebp)
80104e47:	ff 75 f4             	pushl  -0xc(%ebp)
80104e4a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e4d:	e8 9e c1 ff ff       	call   80100ff0 <filewrite>
80104e52:	83 c4 10             	add    $0x10,%esp
}
80104e55:	c9                   	leave  
80104e56:	c3                   	ret    
80104e57:	89 f6                	mov    %esi,%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104e60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104e65:	c9                   	leave  
80104e66:	c3                   	ret    
80104e67:	89 f6                	mov    %esi,%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <sys_close>:

int
sys_close(void)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104e76:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e79:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e7c:	e8 3f fe ff ff       	call   80104cc0 <argfd.constprop.0>
80104e81:	85 c0                	test   %eax,%eax
80104e83:	78 2b                	js     80104eb0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104e85:	e8 26 e9 ff ff       	call   801037b0 <myproc>
80104e8a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e8d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104e90:	c7 84 90 8c 00 00 00 	movl   $0x0,0x8c(%eax,%edx,4)
80104e97:	00 00 00 00 
  fileclose(f);
80104e9b:	ff 75 f4             	pushl  -0xc(%ebp)
80104e9e:	e8 9d bf ff ff       	call   80100e40 <fileclose>
  return 0;
80104ea3:	83 c4 10             	add    $0x10,%esp
80104ea6:	31 c0                	xor    %eax,%eax
}
80104ea8:	c9                   	leave  
80104ea9:	c3                   	ret    
80104eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104eb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104eb5:	c9                   	leave  
80104eb6:	c3                   	ret    
80104eb7:	89 f6                	mov    %esi,%esi
80104eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ec0 <sys_fstat>:

int
sys_fstat(void)
{
80104ec0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ec1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104ec3:	89 e5                	mov    %esp,%ebp
80104ec5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ec8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104ecb:	e8 f0 fd ff ff       	call   80104cc0 <argfd.constprop.0>
80104ed0:	85 c0                	test   %eax,%eax
80104ed2:	78 2c                	js     80104f00 <sys_fstat+0x40>
80104ed4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ed7:	83 ec 04             	sub    $0x4,%esp
80104eda:	6a 14                	push   $0x14
80104edc:	50                   	push   %eax
80104edd:	6a 01                	push   $0x1
80104edf:	e8 2c fb ff ff       	call   80104a10 <argptr>
80104ee4:	83 c4 10             	add    $0x10,%esp
80104ee7:	85 c0                	test   %eax,%eax
80104ee9:	78 15                	js     80104f00 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104eeb:	83 ec 08             	sub    $0x8,%esp
80104eee:	ff 75 f4             	pushl  -0xc(%ebp)
80104ef1:	ff 75 f0             	pushl  -0x10(%ebp)
80104ef4:	e8 17 c0 ff ff       	call   80100f10 <filestat>
80104ef9:	83 c4 10             	add    $0x10,%esp
}
80104efc:	c9                   	leave  
80104efd:	c3                   	ret    
80104efe:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104f05:	c9                   	leave  
80104f06:	c3                   	ret    
80104f07:	89 f6                	mov    %esi,%esi
80104f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f10 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	57                   	push   %edi
80104f14:	56                   	push   %esi
80104f15:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f16:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104f19:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f1c:	50                   	push   %eax
80104f1d:	6a 00                	push   $0x0
80104f1f:	e8 4c fb ff ff       	call   80104a70 <argstr>
80104f24:	83 c4 10             	add    $0x10,%esp
80104f27:	85 c0                	test   %eax,%eax
80104f29:	0f 88 fb 00 00 00    	js     8010502a <sys_link+0x11a>
80104f2f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f32:	83 ec 08             	sub    $0x8,%esp
80104f35:	50                   	push   %eax
80104f36:	6a 01                	push   $0x1
80104f38:	e8 33 fb ff ff       	call   80104a70 <argstr>
80104f3d:	83 c4 10             	add    $0x10,%esp
80104f40:	85 c0                	test   %eax,%eax
80104f42:	0f 88 e2 00 00 00    	js     8010502a <sys_link+0x11a>
    return -1;

  begin_op();
80104f48:	e8 23 dc ff ff       	call   80102b70 <begin_op>
  if((ip = namei(old)) == 0){
80104f4d:	83 ec 0c             	sub    $0xc,%esp
80104f50:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f53:	e8 88 cf ff ff       	call   80101ee0 <namei>
80104f58:	83 c4 10             	add    $0x10,%esp
80104f5b:	85 c0                	test   %eax,%eax
80104f5d:	89 c3                	mov    %eax,%ebx
80104f5f:	0f 84 f3 00 00 00    	je     80105058 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104f65:	83 ec 0c             	sub    $0xc,%esp
80104f68:	50                   	push   %eax
80104f69:	e8 12 c7 ff ff       	call   80101680 <ilock>
  if(ip->type == T_DIR){
80104f6e:	83 c4 10             	add    $0x10,%esp
80104f71:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f76:	0f 84 c4 00 00 00    	je     80105040 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104f7c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f81:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104f84:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104f87:	53                   	push   %ebx
80104f88:	e8 43 c6 ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
80104f8d:	89 1c 24             	mov    %ebx,(%esp)
80104f90:	e8 cb c7 ff ff       	call   80101760 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104f95:	58                   	pop    %eax
80104f96:	5a                   	pop    %edx
80104f97:	57                   	push   %edi
80104f98:	ff 75 d0             	pushl  -0x30(%ebp)
80104f9b:	e8 60 cf ff ff       	call   80101f00 <nameiparent>
80104fa0:	83 c4 10             	add    $0x10,%esp
80104fa3:	85 c0                	test   %eax,%eax
80104fa5:	89 c6                	mov    %eax,%esi
80104fa7:	74 5b                	je     80105004 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104fa9:	83 ec 0c             	sub    $0xc,%esp
80104fac:	50                   	push   %eax
80104fad:	e8 ce c6 ff ff       	call   80101680 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104fb2:	83 c4 10             	add    $0x10,%esp
80104fb5:	8b 03                	mov    (%ebx),%eax
80104fb7:	39 06                	cmp    %eax,(%esi)
80104fb9:	75 3d                	jne    80104ff8 <sys_link+0xe8>
80104fbb:	83 ec 04             	sub    $0x4,%esp
80104fbe:	ff 73 04             	pushl  0x4(%ebx)
80104fc1:	57                   	push   %edi
80104fc2:	56                   	push   %esi
80104fc3:	e8 58 ce ff ff       	call   80101e20 <dirlink>
80104fc8:	83 c4 10             	add    $0x10,%esp
80104fcb:	85 c0                	test   %eax,%eax
80104fcd:	78 29                	js     80104ff8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104fcf:	83 ec 0c             	sub    $0xc,%esp
80104fd2:	56                   	push   %esi
80104fd3:	e8 38 c9 ff ff       	call   80101910 <iunlockput>
  iput(ip);
80104fd8:	89 1c 24             	mov    %ebx,(%esp)
80104fdb:	e8 d0 c7 ff ff       	call   801017b0 <iput>

  end_op();
80104fe0:	e8 fb db ff ff       	call   80102be0 <end_op>

  return 0;
80104fe5:	83 c4 10             	add    $0x10,%esp
80104fe8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104fea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fed:	5b                   	pop    %ebx
80104fee:	5e                   	pop    %esi
80104fef:	5f                   	pop    %edi
80104ff0:	5d                   	pop    %ebp
80104ff1:	c3                   	ret    
80104ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104ff8:	83 ec 0c             	sub    $0xc,%esp
80104ffb:	56                   	push   %esi
80104ffc:	e8 0f c9 ff ff       	call   80101910 <iunlockput>
    goto bad;
80105001:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105004:	83 ec 0c             	sub    $0xc,%esp
80105007:	53                   	push   %ebx
80105008:	e8 73 c6 ff ff       	call   80101680 <ilock>
  ip->nlink--;
8010500d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105012:	89 1c 24             	mov    %ebx,(%esp)
80105015:	e8 b6 c5 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
8010501a:	89 1c 24             	mov    %ebx,(%esp)
8010501d:	e8 ee c8 ff ff       	call   80101910 <iunlockput>
  end_op();
80105022:	e8 b9 db ff ff       	call   80102be0 <end_op>
  return -1;
80105027:	83 c4 10             	add    $0x10,%esp
}
8010502a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
8010502d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105032:	5b                   	pop    %ebx
80105033:	5e                   	pop    %esi
80105034:	5f                   	pop    %edi
80105035:	5d                   	pop    %ebp
80105036:	c3                   	ret    
80105037:	89 f6                	mov    %esi,%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80105040:	83 ec 0c             	sub    $0xc,%esp
80105043:	53                   	push   %ebx
80105044:	e8 c7 c8 ff ff       	call   80101910 <iunlockput>
    end_op();
80105049:	e8 92 db ff ff       	call   80102be0 <end_op>
    return -1;
8010504e:	83 c4 10             	add    $0x10,%esp
80105051:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105056:	eb 92                	jmp    80104fea <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80105058:	e8 83 db ff ff       	call   80102be0 <end_op>
    return -1;
8010505d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105062:	eb 86                	jmp    80104fea <sys_link+0xda>
80105064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010506a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105070 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	57                   	push   %edi
80105074:	56                   	push   %esi
80105075:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105076:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105079:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
8010507c:	50                   	push   %eax
8010507d:	6a 00                	push   $0x0
8010507f:	e8 ec f9 ff ff       	call   80104a70 <argstr>
80105084:	83 c4 10             	add    $0x10,%esp
80105087:	85 c0                	test   %eax,%eax
80105089:	0f 88 82 01 00 00    	js     80105211 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010508f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105092:	e8 d9 da ff ff       	call   80102b70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105097:	83 ec 08             	sub    $0x8,%esp
8010509a:	53                   	push   %ebx
8010509b:	ff 75 c0             	pushl  -0x40(%ebp)
8010509e:	e8 5d ce ff ff       	call   80101f00 <nameiparent>
801050a3:	83 c4 10             	add    $0x10,%esp
801050a6:	85 c0                	test   %eax,%eax
801050a8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801050ab:	0f 84 6a 01 00 00    	je     8010521b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
801050b1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
801050b4:	83 ec 0c             	sub    $0xc,%esp
801050b7:	56                   	push   %esi
801050b8:	e8 c3 c5 ff ff       	call   80101680 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801050bd:	58                   	pop    %eax
801050be:	5a                   	pop    %edx
801050bf:	68 e0 79 10 80       	push   $0x801079e0
801050c4:	53                   	push   %ebx
801050c5:	e8 c6 ca ff ff       	call   80101b90 <namecmp>
801050ca:	83 c4 10             	add    $0x10,%esp
801050cd:	85 c0                	test   %eax,%eax
801050cf:	0f 84 fc 00 00 00    	je     801051d1 <sys_unlink+0x161>
801050d5:	83 ec 08             	sub    $0x8,%esp
801050d8:	68 df 79 10 80       	push   $0x801079df
801050dd:	53                   	push   %ebx
801050de:	e8 ad ca ff ff       	call   80101b90 <namecmp>
801050e3:	83 c4 10             	add    $0x10,%esp
801050e6:	85 c0                	test   %eax,%eax
801050e8:	0f 84 e3 00 00 00    	je     801051d1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801050ee:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801050f1:	83 ec 04             	sub    $0x4,%esp
801050f4:	50                   	push   %eax
801050f5:	53                   	push   %ebx
801050f6:	56                   	push   %esi
801050f7:	e8 b4 ca ff ff       	call   80101bb0 <dirlookup>
801050fc:	83 c4 10             	add    $0x10,%esp
801050ff:	85 c0                	test   %eax,%eax
80105101:	89 c3                	mov    %eax,%ebx
80105103:	0f 84 c8 00 00 00    	je     801051d1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105109:	83 ec 0c             	sub    $0xc,%esp
8010510c:	50                   	push   %eax
8010510d:	e8 6e c5 ff ff       	call   80101680 <ilock>

  if(ip->nlink < 1)
80105112:	83 c4 10             	add    $0x10,%esp
80105115:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010511a:	0f 8e 24 01 00 00    	jle    80105244 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105120:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105125:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105128:	74 66                	je     80105190 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010512a:	83 ec 04             	sub    $0x4,%esp
8010512d:	6a 10                	push   $0x10
8010512f:	6a 00                	push   $0x0
80105131:	56                   	push   %esi
80105132:	e8 79 f5 ff ff       	call   801046b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105137:	6a 10                	push   $0x10
80105139:	ff 75 c4             	pushl  -0x3c(%ebp)
8010513c:	56                   	push   %esi
8010513d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105140:	e8 1b c9 ff ff       	call   80101a60 <writei>
80105145:	83 c4 20             	add    $0x20,%esp
80105148:	83 f8 10             	cmp    $0x10,%eax
8010514b:	0f 85 e6 00 00 00    	jne    80105237 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105151:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105156:	0f 84 9c 00 00 00    	je     801051f8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010515c:	83 ec 0c             	sub    $0xc,%esp
8010515f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105162:	e8 a9 c7 ff ff       	call   80101910 <iunlockput>

  ip->nlink--;
80105167:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010516c:	89 1c 24             	mov    %ebx,(%esp)
8010516f:	e8 5c c4 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
80105174:	89 1c 24             	mov    %ebx,(%esp)
80105177:	e8 94 c7 ff ff       	call   80101910 <iunlockput>

  end_op();
8010517c:	e8 5f da ff ff       	call   80102be0 <end_op>

  return 0;
80105181:	83 c4 10             	add    $0x10,%esp
80105184:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105189:	5b                   	pop    %ebx
8010518a:	5e                   	pop    %esi
8010518b:	5f                   	pop    %edi
8010518c:	5d                   	pop    %ebp
8010518d:	c3                   	ret    
8010518e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105190:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105194:	76 94                	jbe    8010512a <sys_unlink+0xba>
80105196:	bf 20 00 00 00       	mov    $0x20,%edi
8010519b:	eb 0f                	jmp    801051ac <sys_unlink+0x13c>
8010519d:	8d 76 00             	lea    0x0(%esi),%esi
801051a0:	83 c7 10             	add    $0x10,%edi
801051a3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801051a6:	0f 83 7e ff ff ff    	jae    8010512a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051ac:	6a 10                	push   $0x10
801051ae:	57                   	push   %edi
801051af:	56                   	push   %esi
801051b0:	53                   	push   %ebx
801051b1:	e8 aa c7 ff ff       	call   80101960 <readi>
801051b6:	83 c4 10             	add    $0x10,%esp
801051b9:	83 f8 10             	cmp    $0x10,%eax
801051bc:	75 6c                	jne    8010522a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
801051be:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801051c3:	74 db                	je     801051a0 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801051c5:	83 ec 0c             	sub    $0xc,%esp
801051c8:	53                   	push   %ebx
801051c9:	e8 42 c7 ff ff       	call   80101910 <iunlockput>
    goto bad;
801051ce:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
801051d1:	83 ec 0c             	sub    $0xc,%esp
801051d4:	ff 75 b4             	pushl  -0x4c(%ebp)
801051d7:	e8 34 c7 ff ff       	call   80101910 <iunlockput>
  end_op();
801051dc:	e8 ff d9 ff ff       	call   80102be0 <end_op>
  return -1;
801051e1:	83 c4 10             	add    $0x10,%esp
}
801051e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801051e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051ec:	5b                   	pop    %ebx
801051ed:	5e                   	pop    %esi
801051ee:	5f                   	pop    %edi
801051ef:	5d                   	pop    %ebp
801051f0:	c3                   	ret    
801051f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801051f8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801051fb:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801051fe:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105203:	50                   	push   %eax
80105204:	e8 c7 c3 ff ff       	call   801015d0 <iupdate>
80105209:	83 c4 10             	add    $0x10,%esp
8010520c:	e9 4b ff ff ff       	jmp    8010515c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105211:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105216:	e9 6b ff ff ff       	jmp    80105186 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010521b:	e8 c0 d9 ff ff       	call   80102be0 <end_op>
    return -1;
80105220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105225:	e9 5c ff ff ff       	jmp    80105186 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010522a:	83 ec 0c             	sub    $0xc,%esp
8010522d:	68 04 7a 10 80       	push   $0x80107a04
80105232:	e8 49 b1 ff ff       	call   80100380 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105237:	83 ec 0c             	sub    $0xc,%esp
8010523a:	68 16 7a 10 80       	push   $0x80107a16
8010523f:	e8 3c b1 ff ff       	call   80100380 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105244:	83 ec 0c             	sub    $0xc,%esp
80105247:	68 f2 79 10 80       	push   $0x801079f2
8010524c:	e8 2f b1 ff ff       	call   80100380 <panic>
80105251:	eb 0d                	jmp    80105260 <sys_open>
80105253:	90                   	nop
80105254:	90                   	nop
80105255:	90                   	nop
80105256:	90                   	nop
80105257:	90                   	nop
80105258:	90                   	nop
80105259:	90                   	nop
8010525a:	90                   	nop
8010525b:	90                   	nop
8010525c:	90                   	nop
8010525d:	90                   	nop
8010525e:	90                   	nop
8010525f:	90                   	nop

80105260 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	57                   	push   %edi
80105264:	56                   	push   %esi
80105265:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105266:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105269:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010526c:	50                   	push   %eax
8010526d:	6a 00                	push   $0x0
8010526f:	e8 fc f7 ff ff       	call   80104a70 <argstr>
80105274:	83 c4 10             	add    $0x10,%esp
80105277:	85 c0                	test   %eax,%eax
80105279:	0f 88 a1 00 00 00    	js     80105320 <sys_open+0xc0>
8010527f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105282:	83 ec 08             	sub    $0x8,%esp
80105285:	50                   	push   %eax
80105286:	6a 01                	push   $0x1
80105288:	e8 33 f7 ff ff       	call   801049c0 <argint>
8010528d:	83 c4 10             	add    $0x10,%esp
80105290:	85 c0                	test   %eax,%eax
80105292:	0f 88 88 00 00 00    	js     80105320 <sys_open+0xc0>
    return -1;

  begin_op();
80105298:	e8 d3 d8 ff ff       	call   80102b70 <begin_op>

  if(omode & O_CREATE){
8010529d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801052a1:	0f 85 89 00 00 00    	jne    80105330 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801052a7:	83 ec 0c             	sub    $0xc,%esp
801052aa:	ff 75 e0             	pushl  -0x20(%ebp)
801052ad:	e8 2e cc ff ff       	call   80101ee0 <namei>
801052b2:	83 c4 10             	add    $0x10,%esp
801052b5:	85 c0                	test   %eax,%eax
801052b7:	89 c6                	mov    %eax,%esi
801052b9:	0f 84 8e 00 00 00    	je     8010534d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
801052bf:	83 ec 0c             	sub    $0xc,%esp
801052c2:	50                   	push   %eax
801052c3:	e8 b8 c3 ff ff       	call   80101680 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052c8:	83 c4 10             	add    $0x10,%esp
801052cb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052d0:	0f 84 da 00 00 00    	je     801053b0 <sys_open+0x150>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052d6:	e8 a5 ba ff ff       	call   80100d80 <filealloc>
801052db:	85 c0                	test   %eax,%eax
801052dd:	89 c7                	mov    %eax,%edi
801052df:	74 2e                	je     8010530f <sys_open+0xaf>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801052e1:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801052e3:	e8 c8 e4 ff ff       	call   801037b0 <myproc>
801052e8:	90                   	nop
801052e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801052f0:	8b 94 98 8c 00 00 00 	mov    0x8c(%eax,%ebx,4),%edx
801052f7:	85 d2                	test   %edx,%edx
801052f9:	74 65                	je     80105360 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801052fb:	83 c3 01             	add    $0x1,%ebx
801052fe:	83 fb 10             	cmp    $0x10,%ebx
80105301:	75 ed                	jne    801052f0 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105303:	83 ec 0c             	sub    $0xc,%esp
80105306:	57                   	push   %edi
80105307:	e8 34 bb ff ff       	call   80100e40 <fileclose>
8010530c:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010530f:	83 ec 0c             	sub    $0xc,%esp
80105312:	56                   	push   %esi
80105313:	e8 f8 c5 ff ff       	call   80101910 <iunlockput>
    end_op();
80105318:	e8 c3 d8 ff ff       	call   80102be0 <end_op>
    return -1;
8010531d:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105320:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105323:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105328:	5b                   	pop    %ebx
80105329:	5e                   	pop    %esi
8010532a:	5f                   	pop    %edi
8010532b:	5d                   	pop    %ebp
8010532c:	c3                   	ret    
8010532d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105330:	83 ec 0c             	sub    $0xc,%esp
80105333:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105336:	31 c9                	xor    %ecx,%ecx
80105338:	6a 00                	push   $0x0
8010533a:	ba 02 00 00 00       	mov    $0x2,%edx
8010533f:	e8 dc f7 ff ff       	call   80104b20 <create>
    if(ip == 0){
80105344:	83 c4 10             	add    $0x10,%esp
80105347:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105349:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010534b:	75 89                	jne    801052d6 <sys_open+0x76>
      end_op();
8010534d:	e8 8e d8 ff ff       	call   80102be0 <end_op>
      return -1;
80105352:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105357:	eb 46                	jmp    8010539f <sys_open+0x13f>
80105359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105360:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105363:	89 bc 98 8c 00 00 00 	mov    %edi,0x8c(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010536a:	56                   	push   %esi
8010536b:	e8 f0 c3 ff ff       	call   80101760 <iunlock>
  end_op();
80105370:	e8 6b d8 ff ff       	call   80102be0 <end_op>

  f->type = FD_INODE;
80105375:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010537b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010537e:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
80105381:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105384:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010538b:	89 d0                	mov    %edx,%eax
8010538d:	83 e0 01             	and    $0x1,%eax
80105390:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105393:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105396:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105399:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
8010539d:	89 d8                	mov    %ebx,%eax
}
8010539f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053a2:	5b                   	pop    %ebx
801053a3:	5e                   	pop    %esi
801053a4:	5f                   	pop    %edi
801053a5:	5d                   	pop    %ebp
801053a6:	c3                   	ret    
801053a7:	89 f6                	mov    %esi,%esi
801053a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
801053b0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801053b3:	85 c9                	test   %ecx,%ecx
801053b5:	0f 84 1b ff ff ff    	je     801052d6 <sys_open+0x76>
801053bb:	e9 4f ff ff ff       	jmp    8010530f <sys_open+0xaf>

801053c0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053c6:	e8 a5 d7 ff ff       	call   80102b70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801053cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053ce:	83 ec 08             	sub    $0x8,%esp
801053d1:	50                   	push   %eax
801053d2:	6a 00                	push   $0x0
801053d4:	e8 97 f6 ff ff       	call   80104a70 <argstr>
801053d9:	83 c4 10             	add    $0x10,%esp
801053dc:	85 c0                	test   %eax,%eax
801053de:	78 30                	js     80105410 <sys_mkdir+0x50>
801053e0:	83 ec 0c             	sub    $0xc,%esp
801053e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053e6:	31 c9                	xor    %ecx,%ecx
801053e8:	6a 00                	push   $0x0
801053ea:	ba 01 00 00 00       	mov    $0x1,%edx
801053ef:	e8 2c f7 ff ff       	call   80104b20 <create>
801053f4:	83 c4 10             	add    $0x10,%esp
801053f7:	85 c0                	test   %eax,%eax
801053f9:	74 15                	je     80105410 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053fb:	83 ec 0c             	sub    $0xc,%esp
801053fe:	50                   	push   %eax
801053ff:	e8 0c c5 ff ff       	call   80101910 <iunlockput>
  end_op();
80105404:	e8 d7 d7 ff ff       	call   80102be0 <end_op>
  return 0;
80105409:	83 c4 10             	add    $0x10,%esp
8010540c:	31 c0                	xor    %eax,%eax
}
8010540e:	c9                   	leave  
8010540f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105410:	e8 cb d7 ff ff       	call   80102be0 <end_op>
    return -1;
80105415:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010541a:	c9                   	leave  
8010541b:	c3                   	ret    
8010541c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105420 <sys_mknod>:

int
sys_mknod(void)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105426:	e8 45 d7 ff ff       	call   80102b70 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010542b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010542e:	83 ec 08             	sub    $0x8,%esp
80105431:	50                   	push   %eax
80105432:	6a 00                	push   $0x0
80105434:	e8 37 f6 ff ff       	call   80104a70 <argstr>
80105439:	83 c4 10             	add    $0x10,%esp
8010543c:	85 c0                	test   %eax,%eax
8010543e:	78 60                	js     801054a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105440:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105443:	83 ec 08             	sub    $0x8,%esp
80105446:	50                   	push   %eax
80105447:	6a 01                	push   $0x1
80105449:	e8 72 f5 ff ff       	call   801049c0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010544e:	83 c4 10             	add    $0x10,%esp
80105451:	85 c0                	test   %eax,%eax
80105453:	78 4b                	js     801054a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105455:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105458:	83 ec 08             	sub    $0x8,%esp
8010545b:	50                   	push   %eax
8010545c:	6a 02                	push   $0x2
8010545e:	e8 5d f5 ff ff       	call   801049c0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105463:	83 c4 10             	add    $0x10,%esp
80105466:	85 c0                	test   %eax,%eax
80105468:	78 36                	js     801054a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010546a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010546e:	83 ec 0c             	sub    $0xc,%esp
80105471:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105475:	ba 03 00 00 00       	mov    $0x3,%edx
8010547a:	50                   	push   %eax
8010547b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010547e:	e8 9d f6 ff ff       	call   80104b20 <create>
80105483:	83 c4 10             	add    $0x10,%esp
80105486:	85 c0                	test   %eax,%eax
80105488:	74 16                	je     801054a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010548a:	83 ec 0c             	sub    $0xc,%esp
8010548d:	50                   	push   %eax
8010548e:	e8 7d c4 ff ff       	call   80101910 <iunlockput>
  end_op();
80105493:	e8 48 d7 ff ff       	call   80102be0 <end_op>
  return 0;
80105498:	83 c4 10             	add    $0x10,%esp
8010549b:	31 c0                	xor    %eax,%eax
}
8010549d:	c9                   	leave  
8010549e:	c3                   	ret    
8010549f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801054a0:	e8 3b d7 ff ff       	call   80102be0 <end_op>
    return -1;
801054a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801054aa:	c9                   	leave  
801054ab:	c3                   	ret    
801054ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054b0 <sys_chdir>:

int
sys_chdir(void)
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	56                   	push   %esi
801054b4:	53                   	push   %ebx
801054b5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801054b8:	e8 f3 e2 ff ff       	call   801037b0 <myproc>
801054bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801054bf:	e8 ac d6 ff ff       	call   80102b70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054c7:	83 ec 08             	sub    $0x8,%esp
801054ca:	50                   	push   %eax
801054cb:	6a 00                	push   $0x0
801054cd:	e8 9e f5 ff ff       	call   80104a70 <argstr>
801054d2:	83 c4 10             	add    $0x10,%esp
801054d5:	85 c0                	test   %eax,%eax
801054d7:	78 77                	js     80105550 <sys_chdir+0xa0>
801054d9:	83 ec 0c             	sub    $0xc,%esp
801054dc:	ff 75 f4             	pushl  -0xc(%ebp)
801054df:	e8 fc c9 ff ff       	call   80101ee0 <namei>
801054e4:	83 c4 10             	add    $0x10,%esp
801054e7:	85 c0                	test   %eax,%eax
801054e9:	89 c3                	mov    %eax,%ebx
801054eb:	74 63                	je     80105550 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054ed:	83 ec 0c             	sub    $0xc,%esp
801054f0:	50                   	push   %eax
801054f1:	e8 8a c1 ff ff       	call   80101680 <ilock>
  if(ip->type != T_DIR){
801054f6:	83 c4 10             	add    $0x10,%esp
801054f9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054fe:	75 30                	jne    80105530 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105500:	83 ec 0c             	sub    $0xc,%esp
80105503:	53                   	push   %ebx
80105504:	e8 57 c2 ff ff       	call   80101760 <iunlock>
  iput(curproc->cwd);
80105509:	58                   	pop    %eax
8010550a:	ff b6 cc 00 00 00    	pushl  0xcc(%esi)
80105510:	e8 9b c2 ff ff       	call   801017b0 <iput>
  end_op();
80105515:	e8 c6 d6 ff ff       	call   80102be0 <end_op>
  curproc->cwd = ip;
8010551a:	89 9e cc 00 00 00    	mov    %ebx,0xcc(%esi)
  return 0;
80105520:	83 c4 10             	add    $0x10,%esp
80105523:	31 c0                	xor    %eax,%eax
}
80105525:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105528:	5b                   	pop    %ebx
80105529:	5e                   	pop    %esi
8010552a:	5d                   	pop    %ebp
8010552b:	c3                   	ret    
8010552c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105530:	83 ec 0c             	sub    $0xc,%esp
80105533:	53                   	push   %ebx
80105534:	e8 d7 c3 ff ff       	call   80101910 <iunlockput>
    end_op();
80105539:	e8 a2 d6 ff ff       	call   80102be0 <end_op>
    return -1;
8010553e:	83 c4 10             	add    $0x10,%esp
80105541:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105546:	eb dd                	jmp    80105525 <sys_chdir+0x75>
80105548:	90                   	nop
80105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105550:	e8 8b d6 ff ff       	call   80102be0 <end_op>
    return -1;
80105555:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010555a:	eb c9                	jmp    80105525 <sys_chdir+0x75>
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105560 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
80105565:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105566:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010556c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105572:	50                   	push   %eax
80105573:	6a 00                	push   $0x0
80105575:	e8 f6 f4 ff ff       	call   80104a70 <argstr>
8010557a:	83 c4 10             	add    $0x10,%esp
8010557d:	85 c0                	test   %eax,%eax
8010557f:	78 7f                	js     80105600 <sys_exec+0xa0>
80105581:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105587:	83 ec 08             	sub    $0x8,%esp
8010558a:	50                   	push   %eax
8010558b:	6a 01                	push   $0x1
8010558d:	e8 2e f4 ff ff       	call   801049c0 <argint>
80105592:	83 c4 10             	add    $0x10,%esp
80105595:	85 c0                	test   %eax,%eax
80105597:	78 67                	js     80105600 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105599:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010559f:	83 ec 04             	sub    $0x4,%esp
801055a2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801055a8:	68 80 00 00 00       	push   $0x80
801055ad:	6a 00                	push   $0x0
801055af:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801055b5:	50                   	push   %eax
801055b6:	31 db                	xor    %ebx,%ebx
801055b8:	e8 f3 f0 ff ff       	call   801046b0 <memset>
801055bd:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055c0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055c6:	83 ec 08             	sub    $0x8,%esp
801055c9:	57                   	push   %edi
801055ca:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801055cd:	50                   	push   %eax
801055ce:	e8 4d f3 ff ff       	call   80104920 <fetchint>
801055d3:	83 c4 10             	add    $0x10,%esp
801055d6:	85 c0                	test   %eax,%eax
801055d8:	78 26                	js     80105600 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801055da:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055e0:	85 c0                	test   %eax,%eax
801055e2:	74 2c                	je     80105610 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801055e4:	83 ec 08             	sub    $0x8,%esp
801055e7:	56                   	push   %esi
801055e8:	50                   	push   %eax
801055e9:	e8 72 f3 ff ff       	call   80104960 <fetchstr>
801055ee:	83 c4 10             	add    $0x10,%esp
801055f1:	85 c0                	test   %eax,%eax
801055f3:	78 0b                	js     80105600 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801055f5:	83 c3 01             	add    $0x1,%ebx
801055f8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801055fb:	83 fb 20             	cmp    $0x20,%ebx
801055fe:	75 c0                	jne    801055c0 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105600:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105603:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105608:	5b                   	pop    %ebx
80105609:	5e                   	pop    %esi
8010560a:	5f                   	pop    %edi
8010560b:	5d                   	pop    %ebp
8010560c:	c3                   	ret    
8010560d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105610:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105616:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105619:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105620:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105624:	50                   	push   %eax
80105625:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010562b:	e8 d0 b3 ff ff       	call   80100a00 <exec>
80105630:	83 c4 10             	add    $0x10,%esp
}
80105633:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105636:	5b                   	pop    %ebx
80105637:	5e                   	pop    %esi
80105638:	5f                   	pop    %edi
80105639:	5d                   	pop    %ebp
8010563a:	c3                   	ret    
8010563b:	90                   	nop
8010563c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105640 <sys_pipe>:

int
sys_pipe(void)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	57                   	push   %edi
80105644:	56                   	push   %esi
80105645:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105646:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105649:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010564c:	6a 08                	push   $0x8
8010564e:	50                   	push   %eax
8010564f:	6a 00                	push   $0x0
80105651:	e8 ba f3 ff ff       	call   80104a10 <argptr>
80105656:	83 c4 10             	add    $0x10,%esp
80105659:	85 c0                	test   %eax,%eax
8010565b:	78 4d                	js     801056aa <sys_pipe+0x6a>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010565d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105660:	83 ec 08             	sub    $0x8,%esp
80105663:	50                   	push   %eax
80105664:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105667:	50                   	push   %eax
80105668:	e8 a3 db ff ff       	call   80103210 <pipealloc>
8010566d:	83 c4 10             	add    $0x10,%esp
80105670:	85 c0                	test   %eax,%eax
80105672:	78 36                	js     801056aa <sys_pipe+0x6a>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105674:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105676:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105679:	e8 32 e1 ff ff       	call   801037b0 <myproc>
8010567e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105680:	8b b4 98 8c 00 00 00 	mov    0x8c(%eax,%ebx,4),%esi
80105687:	85 f6                	test   %esi,%esi
80105689:	74 35                	je     801056c0 <sys_pipe+0x80>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
8010568b:	83 c3 01             	add    $0x1,%ebx
8010568e:	83 fb 10             	cmp    $0x10,%ebx
80105691:	75 ed                	jne    80105680 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105693:	83 ec 0c             	sub    $0xc,%esp
80105696:	ff 75 e0             	pushl  -0x20(%ebp)
80105699:	e8 a2 b7 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
8010569e:	58                   	pop    %eax
8010569f:	ff 75 e4             	pushl  -0x1c(%ebp)
801056a2:	e8 99 b7 ff ff       	call   80100e40 <fileclose>
    return -1;
801056a7:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801056aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801056ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801056b2:	5b                   	pop    %ebx
801056b3:	5e                   	pop    %esi
801056b4:	5f                   	pop    %edi
801056b5:	5d                   	pop    %ebp
801056b6:	c3                   	ret    
801056b7:	89 f6                	mov    %esi,%esi
801056b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801056c0:	8d 73 20             	lea    0x20(%ebx),%esi
801056c3:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056c7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801056ca:	e8 e1 e0 ff ff       	call   801037b0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801056cf:	31 d2                	xor    %edx,%edx
801056d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801056d8:	8b 8c 90 8c 00 00 00 	mov    0x8c(%eax,%edx,4),%ecx
801056df:	85 c9                	test   %ecx,%ecx
801056e1:	74 1d                	je     80105700 <sys_pipe+0xc0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801056e3:	83 c2 01             	add    $0x1,%edx
801056e6:	83 fa 10             	cmp    $0x10,%edx
801056e9:	75 ed                	jne    801056d8 <sys_pipe+0x98>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801056eb:	e8 c0 e0 ff ff       	call   801037b0 <myproc>
801056f0:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
801056f7:	00 
801056f8:	eb 99                	jmp    80105693 <sys_pipe+0x53>
801056fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105700:	89 bc 90 8c 00 00 00 	mov    %edi,0x8c(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105707:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010570a:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
8010570c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010570f:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
80105712:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105715:	31 c0                	xor    %eax,%eax
}
80105717:	5b                   	pop    %ebx
80105718:	5e                   	pop    %esi
80105719:	5f                   	pop    %edi
8010571a:	5d                   	pop    %ebp
8010571b:	c3                   	ret    
8010571c:	66 90                	xchg   %ax,%ax
8010571e:	66 90                	xchg   %ax,%ax

80105720 <sys_fork>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
int
sys_fork(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105723:	5d                   	pop    %ebp
#include "mmu.h"
#include "proc.h"
int
sys_fork(void)
{
  return fork();
80105724:	e9 37 e2 ff ff       	jmp    80103960 <fork>
80105729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105730 <sys_exit>:
}

int
sys_exit(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	83 ec 1c             	sub    $0x1c,%esp
  int status;
  argptr(0, (char **) &status, 4);
80105736:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105739:	6a 04                	push   $0x4
8010573b:	50                   	push   %eax
8010573c:	6a 00                	push   $0x0
8010573e:	e8 cd f2 ff ff       	call   80104a10 <argptr>
  exit(status);
80105743:	58                   	pop    %eax
80105744:	ff 75 f4             	pushl  -0xc(%ebp)
80105747:	e8 94 e5 ff ff       	call   80103ce0 <exit>
  return 0;  // not reached
}
8010574c:	31 c0                	xor    %eax,%eax
8010574e:	c9                   	leave  
8010574f:	c3                   	ret    

80105750 <sys_wait>:

int
sys_wait(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 1c             	sub    $0x1c,%esp
  int size = 4;
  int val;
  int * value = &val;
80105756:	8d 45 f0             	lea    -0x10(%ebp),%eax

  if(argptr(0, (char**) value, size) < 0)
80105759:	6a 04                	push   $0x4
8010575b:	50                   	push   %eax
8010575c:	6a 00                	push   $0x0
int
sys_wait(void)
{
  int size = 4;
  int val;
  int * value = &val;
8010575e:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(argptr(0, (char**) value, size) < 0)
80105761:	e8 aa f2 ff ff       	call   80104a10 <argptr>
80105766:	83 c4 10             	add    $0x10,%esp
80105769:	85 c0                	test   %eax,%eax
8010576b:	78 13                	js     80105780 <sys_wait+0x30>
  { return -1; }

  int* status = (int*)(&value);
  return wait(status);
8010576d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105770:	83 ec 0c             	sub    $0xc,%esp
80105773:	50                   	push   %eax
80105774:	e8 f7 e8 ff ff       	call   80104070 <wait>
80105779:	83 c4 10             	add    $0x10,%esp
}
8010577c:	c9                   	leave  
8010577d:	c3                   	ret    
8010577e:	66 90                	xchg   %ax,%ax
  int size = 4;
  int val;
  int * value = &val;

  if(argptr(0, (char**) value, size) < 0)
  { return -1; }
80105780:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  int* status = (int*)(&value);
  return wait(status);
}
80105785:	c9                   	leave  
80105786:	c3                   	ret    
80105787:	89 f6                	mov    %esi,%esi
80105789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105790 <sys_waitpid>:

//CS153 Edited Code~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int
sys_waitpid()
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	53                   	push   %ebx
	int pid;
	int *status;
	int opts;
	
	argint(0,&pid);
80105794:	8d 5d ec             	lea    -0x14(%ebp),%ebx
}

//CS153 Edited Code~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int
sys_waitpid()
{
80105797:	83 ec 1c             	sub    $0x1c,%esp
	int pid;
	int *status;
	int opts;
	
	argint(0,&pid);
8010579a:	53                   	push   %ebx
8010579b:	6a 00                	push   $0x0
8010579d:	e8 1e f2 ff ff       	call   801049c0 <argint>
	argptr(0,(char**) &pid, 4);
801057a2:	83 c4 0c             	add    $0xc,%esp
801057a5:	6a 04                	push   $0x4
801057a7:	53                   	push   %ebx
801057a8:	6a 00                	push   $0x0
801057aa:	e8 61 f2 ff ff       	call   80104a10 <argptr>
	argptr(1,(char**) &status, 4);
801057af:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057b2:	83 c4 0c             	add    $0xc,%esp
801057b5:	6a 04                	push   $0x4
801057b7:	50                   	push   %eax
801057b8:	6a 01                	push   $0x1
801057ba:	e8 51 f2 ff ff       	call   80104a10 <argptr>
	argptr(2, (char**) &opts, 4);
801057bf:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057c2:	83 c4 0c             	add    $0xc,%esp
801057c5:	6a 04                	push   $0x4
801057c7:	50                   	push   %eax
801057c8:	6a 02                	push   $0x2
801057ca:	e8 41 f2 ff ff       	call   80104a10 <argptr>

	return waitpid(pid, status, opts);
801057cf:	83 c4 0c             	add    $0xc,%esp
801057d2:	ff 75 f4             	pushl  -0xc(%ebp)
801057d5:	ff 75 f0             	pushl  -0x10(%ebp)
801057d8:	ff 75 ec             	pushl  -0x14(%ebp)
801057db:	e8 60 e6 ff ff       	call   80103e40 <waitpid>
	return 0; //should never reach this point
}
801057e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057e3:	c9                   	leave  
801057e4:	c3                   	ret    
801057e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057f0 <sys_kill>:

int
sys_kill(void)
{
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801057f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057f9:	50                   	push   %eax
801057fa:	6a 00                	push   $0x0
801057fc:	e8 bf f1 ff ff       	call   801049c0 <argint>
80105801:	83 c4 10             	add    $0x10,%esp
80105804:	85 c0                	test   %eax,%eax
80105806:	78 18                	js     80105820 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105808:	83 ec 0c             	sub    $0xc,%esp
8010580b:	ff 75 f4             	pushl  -0xc(%ebp)
8010580e:	e8 cd e9 ff ff       	call   801041e0 <kill>
80105813:	83 c4 10             	add    $0x10,%esp

}
80105816:	c9                   	leave  
80105817:	c3                   	ret    
80105818:	90                   	nop
80105819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);

}
80105825:	c9                   	leave  
80105826:	c3                   	ret    
80105827:	89 f6                	mov    %esi,%esi
80105829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105830 <sys_getpid>:

int
sys_getpid(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105836:	e8 75 df ff ff       	call   801037b0 <myproc>
8010583b:	8b 40 6c             	mov    0x6c(%eax),%eax
}
8010583e:	c9                   	leave  
8010583f:	c3                   	ret    

80105840 <sys_sbrk>:

int
sys_sbrk(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105844:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105847:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010584a:	50                   	push   %eax
8010584b:	6a 00                	push   $0x0
8010584d:	e8 6e f1 ff ff       	call   801049c0 <argint>
80105852:	83 c4 10             	add    $0x10,%esp
80105855:	85 c0                	test   %eax,%eax
80105857:	78 27                	js     80105880 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105859:	e8 52 df ff ff       	call   801037b0 <myproc>
  if(growproc(n) < 0)
8010585e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105861:	8b 58 5c             	mov    0x5c(%eax),%ebx
  if(growproc(n) < 0)
80105864:	ff 75 f4             	pushl  -0xc(%ebp)
80105867:	e8 74 e0 ff ff       	call   801038e0 <growproc>
8010586c:	83 c4 10             	add    $0x10,%esp
8010586f:	85 c0                	test   %eax,%eax
80105871:	78 0d                	js     80105880 <sys_sbrk+0x40>
    return -1;
  return addr;
80105873:	89 d8                	mov    %ebx,%eax
}
80105875:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105878:	c9                   	leave  
80105879:	c3                   	ret    
8010587a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105885:	eb ee                	jmp    80105875 <sys_sbrk+0x35>
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105890 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105894:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105897:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010589a:	50                   	push   %eax
8010589b:	6a 00                	push   $0x0
8010589d:	e8 1e f1 ff ff       	call   801049c0 <argint>
801058a2:	83 c4 10             	add    $0x10,%esp
801058a5:	85 c0                	test   %eax,%eax
801058a7:	0f 88 8a 00 00 00    	js     80105937 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801058ad:	83 ec 0c             	sub    $0xc,%esp
801058b0:	68 60 65 11 80       	push   $0x80116560
801058b5:	e8 86 ec ff ff       	call   80104540 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801058ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058bd:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801058c0:	8b 1d a0 6d 11 80    	mov    0x80116da0,%ebx
  while(ticks - ticks0 < n){
801058c6:	85 d2                	test   %edx,%edx
801058c8:	75 27                	jne    801058f1 <sys_sleep+0x61>
801058ca:	eb 54                	jmp    80105920 <sys_sleep+0x90>
801058cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801058d0:	83 ec 08             	sub    $0x8,%esp
801058d3:	68 60 65 11 80       	push   $0x80116560
801058d8:	68 a0 6d 11 80       	push   $0x80116da0
801058dd:	e8 be e6 ff ff       	call   80103fa0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801058e2:	a1 a0 6d 11 80       	mov    0x80116da0,%eax
801058e7:	83 c4 10             	add    $0x10,%esp
801058ea:	29 d8                	sub    %ebx,%eax
801058ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801058ef:	73 2f                	jae    80105920 <sys_sleep+0x90>
    if(myproc()->killed){
801058f1:	e8 ba de ff ff       	call   801037b0 <myproc>
801058f6:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
801058fc:	85 c0                	test   %eax,%eax
801058fe:	74 d0                	je     801058d0 <sys_sleep+0x40>
      release(&tickslock);
80105900:	83 ec 0c             	sub    $0xc,%esp
80105903:	68 60 65 11 80       	push   $0x80116560
80105908:	e8 53 ed ff ff       	call   80104660 <release>
      return -1;
8010590d:	83 c4 10             	add    $0x10,%esp
80105910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105915:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105918:	c9                   	leave  
80105919:	c3                   	ret    
8010591a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105920:	83 ec 0c             	sub    $0xc,%esp
80105923:	68 60 65 11 80       	push   $0x80116560
80105928:	e8 33 ed ff ff       	call   80104660 <release>
  return 0;
8010592d:	83 c4 10             	add    $0x10,%esp
80105930:	31 c0                	xor    %eax,%eax
}
80105932:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105935:	c9                   	leave  
80105936:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105937:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010593c:	eb d7                	jmp    80105915 <sys_sleep+0x85>
8010593e:	66 90                	xchg   %ax,%ax

80105940 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	53                   	push   %ebx
80105944:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105947:	68 60 65 11 80       	push   $0x80116560
8010594c:	e8 ef eb ff ff       	call   80104540 <acquire>
  xticks = ticks;
80105951:	8b 1d a0 6d 11 80    	mov    0x80116da0,%ebx
  release(&tickslock);
80105957:	c7 04 24 60 65 11 80 	movl   $0x80116560,(%esp)
8010595e:	e8 fd ec ff ff       	call   80104660 <release>
  return xticks;
}
80105963:	89 d8                	mov    %ebx,%eax
80105965:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105968:	c9                   	leave  
80105969:	c3                   	ret    
8010596a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105970 <sys_change_priority>:

void
sys_change_priority(int priority)
{
80105970:	55                   	push   %ebp
80105971:	89 e5                	mov    %esp,%ebp
80105973:	83 ec 0c             	sub    $0xc,%esp
	//int priority;

	argptr(0,(char**)&priority,4);
80105976:	8d 45 08             	lea    0x8(%ebp),%eax
80105979:	6a 04                	push   $0x4
8010597b:	50                   	push   %eax
8010597c:	6a 00                	push   $0x0
8010597e:	e8 8d f0 ff ff       	call   80104a10 <argptr>
	return change_priority(priority);
80105983:	58                   	pop    %eax
80105984:	ff 75 08             	pushl  0x8(%ebp)
80105987:	e8 34 e1 ff ff       	call   80103ac0 <change_priority>
8010598c:	83 c4 10             	add    $0x10,%esp
}
8010598f:	c9                   	leave  
80105990:	c3                   	ret    

80105991 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105991:	1e                   	push   %ds
  pushl %es
80105992:	06                   	push   %es
  pushl %fs
80105993:	0f a0                	push   %fs
  pushl %gs
80105995:	0f a8                	push   %gs
  pushal
80105997:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105998:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010599c:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010599e:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801059a0:	54                   	push   %esp
  call trap
801059a1:	e8 ea 00 00 00       	call   80105a90 <trap>
  addl $4, %esp
801059a6:	83 c4 04             	add    $0x4,%esp

801059a9 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801059a9:	61                   	popa   
  popl %gs
801059aa:	0f a9                	pop    %gs
  popl %fs
801059ac:	0f a1                	pop    %fs
  popl %es
801059ae:	07                   	pop    %es
  popl %ds
801059af:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801059b0:	83 c4 08             	add    $0x8,%esp
  iret
801059b3:	cf                   	iret   
801059b4:	66 90                	xchg   %ax,%ax
801059b6:	66 90                	xchg   %ax,%ax
801059b8:	66 90                	xchg   %ax,%ax
801059ba:	66 90                	xchg   %ax,%ax
801059bc:	66 90                	xchg   %ax,%ax
801059be:	66 90                	xchg   %ax,%ax

801059c0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801059c0:	31 c0                	xor    %eax,%eax
801059c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801059c8:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801059cf:	b9 08 00 00 00       	mov    $0x8,%ecx
801059d4:	c6 04 c5 a4 65 11 80 	movb   $0x0,-0x7fee9a5c(,%eax,8)
801059db:	00 
801059dc:	66 89 0c c5 a2 65 11 	mov    %cx,-0x7fee9a5e(,%eax,8)
801059e3:	80 
801059e4:	c6 04 c5 a5 65 11 80 	movb   $0x8e,-0x7fee9a5b(,%eax,8)
801059eb:	8e 
801059ec:	66 89 14 c5 a0 65 11 	mov    %dx,-0x7fee9a60(,%eax,8)
801059f3:	80 
801059f4:	c1 ea 10             	shr    $0x10,%edx
801059f7:	66 89 14 c5 a6 65 11 	mov    %dx,-0x7fee9a5a(,%eax,8)
801059fe:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801059ff:	83 c0 01             	add    $0x1,%eax
80105a02:	3d 00 01 00 00       	cmp    $0x100,%eax
80105a07:	75 bf                	jne    801059c8 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a09:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a0a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a0f:	89 e5                	mov    %esp,%ebp
80105a11:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a14:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105a19:	68 25 7a 10 80       	push   $0x80107a25
80105a1e:	68 60 65 11 80       	push   $0x80116560
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a23:	66 89 15 a2 67 11 80 	mov    %dx,0x801167a2
80105a2a:	c6 05 a4 67 11 80 00 	movb   $0x0,0x801167a4
80105a31:	66 a3 a0 67 11 80    	mov    %ax,0x801167a0
80105a37:	c1 e8 10             	shr    $0x10,%eax
80105a3a:	c6 05 a5 67 11 80 ef 	movb   $0xef,0x801167a5
80105a41:	66 a3 a6 67 11 80    	mov    %ax,0x801167a6

  initlock(&tickslock, "time");
80105a47:	e8 f4 e9 ff ff       	call   80104440 <initlock>
}
80105a4c:	83 c4 10             	add    $0x10,%esp
80105a4f:	c9                   	leave  
80105a50:	c3                   	ret    
80105a51:	eb 0d                	jmp    80105a60 <idtinit>
80105a53:	90                   	nop
80105a54:	90                   	nop
80105a55:	90                   	nop
80105a56:	90                   	nop
80105a57:	90                   	nop
80105a58:	90                   	nop
80105a59:	90                   	nop
80105a5a:	90                   	nop
80105a5b:	90                   	nop
80105a5c:	90                   	nop
80105a5d:	90                   	nop
80105a5e:	90                   	nop
80105a5f:	90                   	nop

80105a60 <idtinit>:

void
idtinit(void)
{
80105a60:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105a61:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a66:	89 e5                	mov    %esp,%ebp
80105a68:	83 ec 10             	sub    $0x10,%esp
80105a6b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a6f:	b8 a0 65 11 80       	mov    $0x801165a0,%eax
80105a74:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a78:	c1 e8 10             	shr    $0x10,%eax
80105a7b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105a7f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a82:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a85:	c9                   	leave  
80105a86:	c3                   	ret    
80105a87:	89 f6                	mov    %esi,%esi
80105a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a90 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	57                   	push   %edi
80105a94:	56                   	push   %esi
80105a95:	53                   	push   %ebx
80105a96:	83 ec 1c             	sub    $0x1c,%esp
80105a99:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105a9c:	8b 47 30             	mov    0x30(%edi),%eax
80105a9f:	83 f8 40             	cmp    $0x40,%eax
80105aa2:	0f 84 98 01 00 00    	je     80105c40 <trap+0x1b0>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80105aa8:	83 e8 20             	sub    $0x20,%eax
80105aab:	83 f8 1f             	cmp    $0x1f,%eax
80105aae:	77 10                	ja     80105ac0 <trap+0x30>
80105ab0:	ff 24 85 cc 7a 10 80 	jmp    *-0x7fef8534(,%eax,4)
80105ab7:	89 f6                	mov    %esi,%esi
80105ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105ac0:	e8 eb dc ff ff       	call   801037b0 <myproc>
80105ac5:	85 c0                	test   %eax,%eax
80105ac7:	0f 84 07 02 00 00    	je     80105cd4 <trap+0x244>
80105acd:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105ad1:	0f 84 fd 01 00 00    	je     80105cd4 <trap+0x244>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105ad7:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ada:	8b 57 38             	mov    0x38(%edi),%edx
80105add:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105ae0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105ae3:	e8 a8 dc ff ff       	call   80103790 <cpuid>
80105ae8:	8b 77 34             	mov    0x34(%edi),%esi
80105aeb:	8b 5f 30             	mov    0x30(%edi),%ebx
80105aee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105af1:	e8 ba dc ff ff       	call   801037b0 <myproc>
80105af6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105af9:	e8 b2 dc ff ff       	call   801037b0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105afe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105b01:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105b04:	51                   	push   %ecx
80105b05:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b06:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b09:	ff 75 e4             	pushl  -0x1c(%ebp)
80105b0c:	56                   	push   %esi
80105b0d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b0e:	81 c2 d0 00 00 00    	add    $0xd0,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b14:	52                   	push   %edx
80105b15:	ff 70 6c             	pushl  0x6c(%eax)
80105b18:	68 88 7a 10 80       	push   $0x80107a88
80105b1d:	e8 4e ab ff ff       	call   80100670 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105b22:	83 c4 20             	add    $0x20,%esp
80105b25:	e8 86 dc ff ff       	call   801037b0 <myproc>
80105b2a:	c7 80 88 00 00 00 01 	movl   $0x1,0x88(%eax)
80105b31:	00 00 00 
80105b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b38:	e8 73 dc ff ff       	call   801037b0 <myproc>
80105b3d:	85 c0                	test   %eax,%eax
80105b3f:	74 0f                	je     80105b50 <trap+0xc0>
80105b41:	e8 6a dc ff ff       	call   801037b0 <myproc>
80105b46:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80105b4c:	85 d2                	test   %edx,%edx
80105b4e:	75 48                	jne    80105b98 <trap+0x108>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b50:	e8 5b dc ff ff       	call   801037b0 <myproc>
80105b55:	85 c0                	test   %eax,%eax
80105b57:	74 0b                	je     80105b64 <trap+0xd4>
80105b59:	e8 52 dc ff ff       	call   801037b0 <myproc>
80105b5e:	83 78 68 04          	cmpl   $0x4,0x68(%eax)
80105b62:	74 54                	je     80105bb8 <trap+0x128>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b64:	e8 47 dc ff ff       	call   801037b0 <myproc>
80105b69:	85 c0                	test   %eax,%eax
80105b6b:	74 20                	je     80105b8d <trap+0xfd>
80105b6d:	e8 3e dc ff ff       	call   801037b0 <myproc>
80105b72:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
80105b78:	85 c0                	test   %eax,%eax
80105b7a:	74 11                	je     80105b8d <trap+0xfd>
80105b7c:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b80:	83 e0 03             	and    $0x3,%eax
80105b83:	66 83 f8 03          	cmp    $0x3,%ax
80105b87:	0f 84 e2 00 00 00    	je     80105c6f <trap+0x1df>
    exit(0);
}
80105b8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b90:	5b                   	pop    %ebx
80105b91:	5e                   	pop    %esi
80105b92:	5f                   	pop    %edi
80105b93:	5d                   	pop    %ebp
80105b94:	c3                   	ret    
80105b95:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b98:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b9c:	83 e0 03             	and    $0x3,%eax
80105b9f:	66 83 f8 03          	cmp    $0x3,%ax
80105ba3:	75 ab                	jne    80105b50 <trap+0xc0>
    exit(0);
80105ba5:	83 ec 0c             	sub    $0xc,%esp
80105ba8:	6a 00                	push   $0x0
80105baa:	e8 31 e1 ff ff       	call   80103ce0 <exit>
80105baf:	83 c4 10             	add    $0x10,%esp
80105bb2:	eb 9c                	jmp    80105b50 <trap+0xc0>
80105bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105bb8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105bbc:	75 a6                	jne    80105b64 <trap+0xd4>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105bbe:	e8 8d e3 ff ff       	call   80103f50 <yield>
80105bc3:	eb 9f                	jmp    80105b64 <trap+0xd4>
80105bc5:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105bc8:	e8 c3 db ff ff       	call   80103790 <cpuid>
80105bcd:	85 c0                	test   %eax,%eax
80105bcf:	0f 84 cb 00 00 00    	je     80105ca0 <trap+0x210>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105bd5:	e8 56 cb ff ff       	call   80102730 <lapiceoi>
    break;
80105bda:	e9 59 ff ff ff       	jmp    80105b38 <trap+0xa8>
80105bdf:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105be0:	e8 0b ca ff ff       	call   801025f0 <kbdintr>
    lapiceoi();
80105be5:	e8 46 cb ff ff       	call   80102730 <lapiceoi>
    break;
80105bea:	e9 49 ff ff ff       	jmp    80105b38 <trap+0xa8>
80105bef:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105bf0:	e8 7b 02 00 00       	call   80105e70 <uartintr>
    lapiceoi();
80105bf5:	e8 36 cb ff ff       	call   80102730 <lapiceoi>
    break;
80105bfa:	e9 39 ff ff ff       	jmp    80105b38 <trap+0xa8>
80105bff:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105c00:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105c04:	8b 77 38             	mov    0x38(%edi),%esi
80105c07:	e8 84 db ff ff       	call   80103790 <cpuid>
80105c0c:	56                   	push   %esi
80105c0d:	53                   	push   %ebx
80105c0e:	50                   	push   %eax
80105c0f:	68 30 7a 10 80       	push   $0x80107a30
80105c14:	e8 57 aa ff ff       	call   80100670 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105c19:	e8 12 cb ff ff       	call   80102730 <lapiceoi>
    break;
80105c1e:	83 c4 10             	add    $0x10,%esp
80105c21:	e9 12 ff ff ff       	jmp    80105b38 <trap+0xa8>
80105c26:	8d 76 00             	lea    0x0(%esi),%esi
80105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105c30:	e8 3b c4 ff ff       	call   80102070 <ideintr>
80105c35:	eb 9e                	jmp    80105bd5 <trap+0x145>
80105c37:	89 f6                	mov    %esi,%esi
80105c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105c40:	e8 6b db ff ff       	call   801037b0 <myproc>
80105c45:	8b 98 88 00 00 00    	mov    0x88(%eax),%ebx
80105c4b:	85 db                	test   %ebx,%ebx
80105c4d:	75 39                	jne    80105c88 <trap+0x1f8>
      exit(0);
    myproc()->tf = tf;
80105c4f:	e8 5c db ff ff       	call   801037b0 <myproc>
80105c54:	89 78 7c             	mov    %edi,0x7c(%eax)
    syscall();
80105c57:	e8 54 ee ff ff       	call   80104ab0 <syscall>
    if(myproc()->killed)
80105c5c:	e8 4f db ff ff       	call   801037b0 <myproc>
80105c61:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80105c67:	85 c9                	test   %ecx,%ecx
80105c69:	0f 84 1e ff ff ff    	je     80105b8d <trap+0xfd>
      exit(0);
80105c6f:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit(0);
}
80105c76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c79:	5b                   	pop    %ebx
80105c7a:	5e                   	pop    %esi
80105c7b:	5f                   	pop    %edi
80105c7c:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit(0);
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit(0);
80105c7d:	e9 5e e0 ff ff       	jmp    80103ce0 <exit>
80105c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit(0);
80105c88:	83 ec 0c             	sub    $0xc,%esp
80105c8b:	6a 00                	push   $0x0
80105c8d:	e8 4e e0 ff ff       	call   80103ce0 <exit>
80105c92:	83 c4 10             	add    $0x10,%esp
80105c95:	eb b8                	jmp    80105c4f <trap+0x1bf>
80105c97:	89 f6                	mov    %esi,%esi
80105c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105ca0:	83 ec 0c             	sub    $0xc,%esp
80105ca3:	68 60 65 11 80       	push   $0x80116560
80105ca8:	e8 93 e8 ff ff       	call   80104540 <acquire>
      ticks++;
      wakeup(&ticks);
80105cad:	c7 04 24 a0 6d 11 80 	movl   $0x80116da0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105cb4:	83 05 a0 6d 11 80 01 	addl   $0x1,0x80116da0
      wakeup(&ticks);
80105cbb:	e8 c0 e4 ff ff       	call   80104180 <wakeup>
      release(&tickslock);
80105cc0:	c7 04 24 60 65 11 80 	movl   $0x80116560,(%esp)
80105cc7:	e8 94 e9 ff ff       	call   80104660 <release>
80105ccc:	83 c4 10             	add    $0x10,%esp
80105ccf:	e9 01 ff ff ff       	jmp    80105bd5 <trap+0x145>
80105cd4:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105cd7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105cda:	e8 b1 da ff ff       	call   80103790 <cpuid>
80105cdf:	83 ec 0c             	sub    $0xc,%esp
80105ce2:	56                   	push   %esi
80105ce3:	53                   	push   %ebx
80105ce4:	50                   	push   %eax
80105ce5:	ff 77 30             	pushl  0x30(%edi)
80105ce8:	68 54 7a 10 80       	push   $0x80107a54
80105ced:	e8 7e a9 ff ff       	call   80100670 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105cf2:	83 c4 14             	add    $0x14,%esp
80105cf5:	68 2a 7a 10 80       	push   $0x80107a2a
80105cfa:	e8 81 a6 ff ff       	call   80100380 <panic>
80105cff:	90                   	nop

80105d00 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105d00:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105d05:	55                   	push   %ebp
80105d06:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105d08:	85 c0                	test   %eax,%eax
80105d0a:	74 1c                	je     80105d28 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d0c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d11:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105d12:	a8 01                	test   $0x1,%al
80105d14:	74 12                	je     80105d28 <uartgetc+0x28>
80105d16:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d1b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105d1c:	0f b6 c0             	movzbl %al,%eax
}
80105d1f:	5d                   	pop    %ebp
80105d20:	c3                   	ret    
80105d21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105d28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105d2d:	5d                   	pop    %ebp
80105d2e:	c3                   	ret    
80105d2f:	90                   	nop

80105d30 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105d30:	55                   	push   %ebp
80105d31:	89 e5                	mov    %esp,%ebp
80105d33:	57                   	push   %edi
80105d34:	56                   	push   %esi
80105d35:	53                   	push   %ebx
80105d36:	89 c7                	mov    %eax,%edi
80105d38:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d3d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d42:	83 ec 0c             	sub    $0xc,%esp
80105d45:	eb 1b                	jmp    80105d62 <uartputc.part.0+0x32>
80105d47:	89 f6                	mov    %esi,%esi
80105d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105d50:	83 ec 0c             	sub    $0xc,%esp
80105d53:	6a 0a                	push   $0xa
80105d55:	e8 f6 c9 ff ff       	call   80102750 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d5a:	83 c4 10             	add    $0x10,%esp
80105d5d:	83 eb 01             	sub    $0x1,%ebx
80105d60:	74 07                	je     80105d69 <uartputc.part.0+0x39>
80105d62:	89 f2                	mov    %esi,%edx
80105d64:	ec                   	in     (%dx),%al
80105d65:	a8 20                	test   $0x20,%al
80105d67:	74 e7                	je     80105d50 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d69:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d6e:	89 f8                	mov    %edi,%eax
80105d70:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105d71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d74:	5b                   	pop    %ebx
80105d75:	5e                   	pop    %esi
80105d76:	5f                   	pop    %edi
80105d77:	5d                   	pop    %ebp
80105d78:	c3                   	ret    
80105d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d80 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105d80:	55                   	push   %ebp
80105d81:	31 c9                	xor    %ecx,%ecx
80105d83:	89 c8                	mov    %ecx,%eax
80105d85:	89 e5                	mov    %esp,%ebp
80105d87:	57                   	push   %edi
80105d88:	56                   	push   %esi
80105d89:	53                   	push   %ebx
80105d8a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105d8f:	89 da                	mov    %ebx,%edx
80105d91:	83 ec 0c             	sub    $0xc,%esp
80105d94:	ee                   	out    %al,(%dx)
80105d95:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d9a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d9f:	89 fa                	mov    %edi,%edx
80105da1:	ee                   	out    %al,(%dx)
80105da2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105da7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dac:	ee                   	out    %al,(%dx)
80105dad:	be f9 03 00 00       	mov    $0x3f9,%esi
80105db2:	89 c8                	mov    %ecx,%eax
80105db4:	89 f2                	mov    %esi,%edx
80105db6:	ee                   	out    %al,(%dx)
80105db7:	b8 03 00 00 00       	mov    $0x3,%eax
80105dbc:	89 fa                	mov    %edi,%edx
80105dbe:	ee                   	out    %al,(%dx)
80105dbf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105dc4:	89 c8                	mov    %ecx,%eax
80105dc6:	ee                   	out    %al,(%dx)
80105dc7:	b8 01 00 00 00       	mov    $0x1,%eax
80105dcc:	89 f2                	mov    %esi,%edx
80105dce:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105dcf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105dd4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105dd5:	3c ff                	cmp    $0xff,%al
80105dd7:	74 5a                	je     80105e33 <uartinit+0xb3>
    return;
  uart = 1;
80105dd9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105de0:	00 00 00 
80105de3:	89 da                	mov    %ebx,%edx
80105de5:	ec                   	in     (%dx),%al
80105de6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105deb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105dec:	83 ec 08             	sub    $0x8,%esp
80105def:	bb 4c 7b 10 80       	mov    $0x80107b4c,%ebx
80105df4:	6a 00                	push   $0x0
80105df6:	6a 04                	push   $0x4
80105df8:	e8 c3 c4 ff ff       	call   801022c0 <ioapicenable>
80105dfd:	83 c4 10             	add    $0x10,%esp
80105e00:	b8 78 00 00 00       	mov    $0x78,%eax
80105e05:	eb 13                	jmp    80105e1a <uartinit+0x9a>
80105e07:	89 f6                	mov    %esi,%esi
80105e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105e10:	83 c3 01             	add    $0x1,%ebx
80105e13:	0f be 03             	movsbl (%ebx),%eax
80105e16:	84 c0                	test   %al,%al
80105e18:	74 19                	je     80105e33 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105e1a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105e20:	85 d2                	test   %edx,%edx
80105e22:	74 ec                	je     80105e10 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105e24:	83 c3 01             	add    $0x1,%ebx
80105e27:	e8 04 ff ff ff       	call   80105d30 <uartputc.part.0>
80105e2c:	0f be 03             	movsbl (%ebx),%eax
80105e2f:	84 c0                	test   %al,%al
80105e31:	75 e7                	jne    80105e1a <uartinit+0x9a>
    uartputc(*p);
}
80105e33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e36:	5b                   	pop    %ebx
80105e37:	5e                   	pop    %esi
80105e38:	5f                   	pop    %edi
80105e39:	5d                   	pop    %ebp
80105e3a:	c3                   	ret    
80105e3b:	90                   	nop
80105e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e40 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105e40:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105e46:	55                   	push   %ebp
80105e47:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105e49:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105e4e:	74 10                	je     80105e60 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105e50:	5d                   	pop    %ebp
80105e51:	e9 da fe ff ff       	jmp    80105d30 <uartputc.part.0>
80105e56:	8d 76 00             	lea    0x0(%esi),%esi
80105e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e60:	5d                   	pop    %ebp
80105e61:	c3                   	ret    
80105e62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e70 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e76:	68 00 5d 10 80       	push   $0x80105d00
80105e7b:	e8 80 a9 ff ff       	call   80100800 <consoleintr>
}
80105e80:	83 c4 10             	add    $0x10,%esp
80105e83:	c9                   	leave  
80105e84:	c3                   	ret    

80105e85 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e85:	6a 00                	push   $0x0
  pushl $0
80105e87:	6a 00                	push   $0x0
  jmp alltraps
80105e89:	e9 03 fb ff ff       	jmp    80105991 <alltraps>

80105e8e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e8e:	6a 00                	push   $0x0
  pushl $1
80105e90:	6a 01                	push   $0x1
  jmp alltraps
80105e92:	e9 fa fa ff ff       	jmp    80105991 <alltraps>

80105e97 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e97:	6a 00                	push   $0x0
  pushl $2
80105e99:	6a 02                	push   $0x2
  jmp alltraps
80105e9b:	e9 f1 fa ff ff       	jmp    80105991 <alltraps>

80105ea0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105ea0:	6a 00                	push   $0x0
  pushl $3
80105ea2:	6a 03                	push   $0x3
  jmp alltraps
80105ea4:	e9 e8 fa ff ff       	jmp    80105991 <alltraps>

80105ea9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105ea9:	6a 00                	push   $0x0
  pushl $4
80105eab:	6a 04                	push   $0x4
  jmp alltraps
80105ead:	e9 df fa ff ff       	jmp    80105991 <alltraps>

80105eb2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105eb2:	6a 00                	push   $0x0
  pushl $5
80105eb4:	6a 05                	push   $0x5
  jmp alltraps
80105eb6:	e9 d6 fa ff ff       	jmp    80105991 <alltraps>

80105ebb <vector6>:
.globl vector6
vector6:
  pushl $0
80105ebb:	6a 00                	push   $0x0
  pushl $6
80105ebd:	6a 06                	push   $0x6
  jmp alltraps
80105ebf:	e9 cd fa ff ff       	jmp    80105991 <alltraps>

80105ec4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105ec4:	6a 00                	push   $0x0
  pushl $7
80105ec6:	6a 07                	push   $0x7
  jmp alltraps
80105ec8:	e9 c4 fa ff ff       	jmp    80105991 <alltraps>

80105ecd <vector8>:
.globl vector8
vector8:
  pushl $8
80105ecd:	6a 08                	push   $0x8
  jmp alltraps
80105ecf:	e9 bd fa ff ff       	jmp    80105991 <alltraps>

80105ed4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105ed4:	6a 00                	push   $0x0
  pushl $9
80105ed6:	6a 09                	push   $0x9
  jmp alltraps
80105ed8:	e9 b4 fa ff ff       	jmp    80105991 <alltraps>

80105edd <vector10>:
.globl vector10
vector10:
  pushl $10
80105edd:	6a 0a                	push   $0xa
  jmp alltraps
80105edf:	e9 ad fa ff ff       	jmp    80105991 <alltraps>

80105ee4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105ee4:	6a 0b                	push   $0xb
  jmp alltraps
80105ee6:	e9 a6 fa ff ff       	jmp    80105991 <alltraps>

80105eeb <vector12>:
.globl vector12
vector12:
  pushl $12
80105eeb:	6a 0c                	push   $0xc
  jmp alltraps
80105eed:	e9 9f fa ff ff       	jmp    80105991 <alltraps>

80105ef2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105ef2:	6a 0d                	push   $0xd
  jmp alltraps
80105ef4:	e9 98 fa ff ff       	jmp    80105991 <alltraps>

80105ef9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105ef9:	6a 0e                	push   $0xe
  jmp alltraps
80105efb:	e9 91 fa ff ff       	jmp    80105991 <alltraps>

80105f00 <vector15>:
.globl vector15
vector15:
  pushl $0
80105f00:	6a 00                	push   $0x0
  pushl $15
80105f02:	6a 0f                	push   $0xf
  jmp alltraps
80105f04:	e9 88 fa ff ff       	jmp    80105991 <alltraps>

80105f09 <vector16>:
.globl vector16
vector16:
  pushl $0
80105f09:	6a 00                	push   $0x0
  pushl $16
80105f0b:	6a 10                	push   $0x10
  jmp alltraps
80105f0d:	e9 7f fa ff ff       	jmp    80105991 <alltraps>

80105f12 <vector17>:
.globl vector17
vector17:
  pushl $17
80105f12:	6a 11                	push   $0x11
  jmp alltraps
80105f14:	e9 78 fa ff ff       	jmp    80105991 <alltraps>

80105f19 <vector18>:
.globl vector18
vector18:
  pushl $0
80105f19:	6a 00                	push   $0x0
  pushl $18
80105f1b:	6a 12                	push   $0x12
  jmp alltraps
80105f1d:	e9 6f fa ff ff       	jmp    80105991 <alltraps>

80105f22 <vector19>:
.globl vector19
vector19:
  pushl $0
80105f22:	6a 00                	push   $0x0
  pushl $19
80105f24:	6a 13                	push   $0x13
  jmp alltraps
80105f26:	e9 66 fa ff ff       	jmp    80105991 <alltraps>

80105f2b <vector20>:
.globl vector20
vector20:
  pushl $0
80105f2b:	6a 00                	push   $0x0
  pushl $20
80105f2d:	6a 14                	push   $0x14
  jmp alltraps
80105f2f:	e9 5d fa ff ff       	jmp    80105991 <alltraps>

80105f34 <vector21>:
.globl vector21
vector21:
  pushl $0
80105f34:	6a 00                	push   $0x0
  pushl $21
80105f36:	6a 15                	push   $0x15
  jmp alltraps
80105f38:	e9 54 fa ff ff       	jmp    80105991 <alltraps>

80105f3d <vector22>:
.globl vector22
vector22:
  pushl $0
80105f3d:	6a 00                	push   $0x0
  pushl $22
80105f3f:	6a 16                	push   $0x16
  jmp alltraps
80105f41:	e9 4b fa ff ff       	jmp    80105991 <alltraps>

80105f46 <vector23>:
.globl vector23
vector23:
  pushl $0
80105f46:	6a 00                	push   $0x0
  pushl $23
80105f48:	6a 17                	push   $0x17
  jmp alltraps
80105f4a:	e9 42 fa ff ff       	jmp    80105991 <alltraps>

80105f4f <vector24>:
.globl vector24
vector24:
  pushl $0
80105f4f:	6a 00                	push   $0x0
  pushl $24
80105f51:	6a 18                	push   $0x18
  jmp alltraps
80105f53:	e9 39 fa ff ff       	jmp    80105991 <alltraps>

80105f58 <vector25>:
.globl vector25
vector25:
  pushl $0
80105f58:	6a 00                	push   $0x0
  pushl $25
80105f5a:	6a 19                	push   $0x19
  jmp alltraps
80105f5c:	e9 30 fa ff ff       	jmp    80105991 <alltraps>

80105f61 <vector26>:
.globl vector26
vector26:
  pushl $0
80105f61:	6a 00                	push   $0x0
  pushl $26
80105f63:	6a 1a                	push   $0x1a
  jmp alltraps
80105f65:	e9 27 fa ff ff       	jmp    80105991 <alltraps>

80105f6a <vector27>:
.globl vector27
vector27:
  pushl $0
80105f6a:	6a 00                	push   $0x0
  pushl $27
80105f6c:	6a 1b                	push   $0x1b
  jmp alltraps
80105f6e:	e9 1e fa ff ff       	jmp    80105991 <alltraps>

80105f73 <vector28>:
.globl vector28
vector28:
  pushl $0
80105f73:	6a 00                	push   $0x0
  pushl $28
80105f75:	6a 1c                	push   $0x1c
  jmp alltraps
80105f77:	e9 15 fa ff ff       	jmp    80105991 <alltraps>

80105f7c <vector29>:
.globl vector29
vector29:
  pushl $0
80105f7c:	6a 00                	push   $0x0
  pushl $29
80105f7e:	6a 1d                	push   $0x1d
  jmp alltraps
80105f80:	e9 0c fa ff ff       	jmp    80105991 <alltraps>

80105f85 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f85:	6a 00                	push   $0x0
  pushl $30
80105f87:	6a 1e                	push   $0x1e
  jmp alltraps
80105f89:	e9 03 fa ff ff       	jmp    80105991 <alltraps>

80105f8e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f8e:	6a 00                	push   $0x0
  pushl $31
80105f90:	6a 1f                	push   $0x1f
  jmp alltraps
80105f92:	e9 fa f9 ff ff       	jmp    80105991 <alltraps>

80105f97 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f97:	6a 00                	push   $0x0
  pushl $32
80105f99:	6a 20                	push   $0x20
  jmp alltraps
80105f9b:	e9 f1 f9 ff ff       	jmp    80105991 <alltraps>

80105fa0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105fa0:	6a 00                	push   $0x0
  pushl $33
80105fa2:	6a 21                	push   $0x21
  jmp alltraps
80105fa4:	e9 e8 f9 ff ff       	jmp    80105991 <alltraps>

80105fa9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105fa9:	6a 00                	push   $0x0
  pushl $34
80105fab:	6a 22                	push   $0x22
  jmp alltraps
80105fad:	e9 df f9 ff ff       	jmp    80105991 <alltraps>

80105fb2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105fb2:	6a 00                	push   $0x0
  pushl $35
80105fb4:	6a 23                	push   $0x23
  jmp alltraps
80105fb6:	e9 d6 f9 ff ff       	jmp    80105991 <alltraps>

80105fbb <vector36>:
.globl vector36
vector36:
  pushl $0
80105fbb:	6a 00                	push   $0x0
  pushl $36
80105fbd:	6a 24                	push   $0x24
  jmp alltraps
80105fbf:	e9 cd f9 ff ff       	jmp    80105991 <alltraps>

80105fc4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105fc4:	6a 00                	push   $0x0
  pushl $37
80105fc6:	6a 25                	push   $0x25
  jmp alltraps
80105fc8:	e9 c4 f9 ff ff       	jmp    80105991 <alltraps>

80105fcd <vector38>:
.globl vector38
vector38:
  pushl $0
80105fcd:	6a 00                	push   $0x0
  pushl $38
80105fcf:	6a 26                	push   $0x26
  jmp alltraps
80105fd1:	e9 bb f9 ff ff       	jmp    80105991 <alltraps>

80105fd6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105fd6:	6a 00                	push   $0x0
  pushl $39
80105fd8:	6a 27                	push   $0x27
  jmp alltraps
80105fda:	e9 b2 f9 ff ff       	jmp    80105991 <alltraps>

80105fdf <vector40>:
.globl vector40
vector40:
  pushl $0
80105fdf:	6a 00                	push   $0x0
  pushl $40
80105fe1:	6a 28                	push   $0x28
  jmp alltraps
80105fe3:	e9 a9 f9 ff ff       	jmp    80105991 <alltraps>

80105fe8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105fe8:	6a 00                	push   $0x0
  pushl $41
80105fea:	6a 29                	push   $0x29
  jmp alltraps
80105fec:	e9 a0 f9 ff ff       	jmp    80105991 <alltraps>

80105ff1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105ff1:	6a 00                	push   $0x0
  pushl $42
80105ff3:	6a 2a                	push   $0x2a
  jmp alltraps
80105ff5:	e9 97 f9 ff ff       	jmp    80105991 <alltraps>

80105ffa <vector43>:
.globl vector43
vector43:
  pushl $0
80105ffa:	6a 00                	push   $0x0
  pushl $43
80105ffc:	6a 2b                	push   $0x2b
  jmp alltraps
80105ffe:	e9 8e f9 ff ff       	jmp    80105991 <alltraps>

80106003 <vector44>:
.globl vector44
vector44:
  pushl $0
80106003:	6a 00                	push   $0x0
  pushl $44
80106005:	6a 2c                	push   $0x2c
  jmp alltraps
80106007:	e9 85 f9 ff ff       	jmp    80105991 <alltraps>

8010600c <vector45>:
.globl vector45
vector45:
  pushl $0
8010600c:	6a 00                	push   $0x0
  pushl $45
8010600e:	6a 2d                	push   $0x2d
  jmp alltraps
80106010:	e9 7c f9 ff ff       	jmp    80105991 <alltraps>

80106015 <vector46>:
.globl vector46
vector46:
  pushl $0
80106015:	6a 00                	push   $0x0
  pushl $46
80106017:	6a 2e                	push   $0x2e
  jmp alltraps
80106019:	e9 73 f9 ff ff       	jmp    80105991 <alltraps>

8010601e <vector47>:
.globl vector47
vector47:
  pushl $0
8010601e:	6a 00                	push   $0x0
  pushl $47
80106020:	6a 2f                	push   $0x2f
  jmp alltraps
80106022:	e9 6a f9 ff ff       	jmp    80105991 <alltraps>

80106027 <vector48>:
.globl vector48
vector48:
  pushl $0
80106027:	6a 00                	push   $0x0
  pushl $48
80106029:	6a 30                	push   $0x30
  jmp alltraps
8010602b:	e9 61 f9 ff ff       	jmp    80105991 <alltraps>

80106030 <vector49>:
.globl vector49
vector49:
  pushl $0
80106030:	6a 00                	push   $0x0
  pushl $49
80106032:	6a 31                	push   $0x31
  jmp alltraps
80106034:	e9 58 f9 ff ff       	jmp    80105991 <alltraps>

80106039 <vector50>:
.globl vector50
vector50:
  pushl $0
80106039:	6a 00                	push   $0x0
  pushl $50
8010603b:	6a 32                	push   $0x32
  jmp alltraps
8010603d:	e9 4f f9 ff ff       	jmp    80105991 <alltraps>

80106042 <vector51>:
.globl vector51
vector51:
  pushl $0
80106042:	6a 00                	push   $0x0
  pushl $51
80106044:	6a 33                	push   $0x33
  jmp alltraps
80106046:	e9 46 f9 ff ff       	jmp    80105991 <alltraps>

8010604b <vector52>:
.globl vector52
vector52:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $52
8010604d:	6a 34                	push   $0x34
  jmp alltraps
8010604f:	e9 3d f9 ff ff       	jmp    80105991 <alltraps>

80106054 <vector53>:
.globl vector53
vector53:
  pushl $0
80106054:	6a 00                	push   $0x0
  pushl $53
80106056:	6a 35                	push   $0x35
  jmp alltraps
80106058:	e9 34 f9 ff ff       	jmp    80105991 <alltraps>

8010605d <vector54>:
.globl vector54
vector54:
  pushl $0
8010605d:	6a 00                	push   $0x0
  pushl $54
8010605f:	6a 36                	push   $0x36
  jmp alltraps
80106061:	e9 2b f9 ff ff       	jmp    80105991 <alltraps>

80106066 <vector55>:
.globl vector55
vector55:
  pushl $0
80106066:	6a 00                	push   $0x0
  pushl $55
80106068:	6a 37                	push   $0x37
  jmp alltraps
8010606a:	e9 22 f9 ff ff       	jmp    80105991 <alltraps>

8010606f <vector56>:
.globl vector56
vector56:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $56
80106071:	6a 38                	push   $0x38
  jmp alltraps
80106073:	e9 19 f9 ff ff       	jmp    80105991 <alltraps>

80106078 <vector57>:
.globl vector57
vector57:
  pushl $0
80106078:	6a 00                	push   $0x0
  pushl $57
8010607a:	6a 39                	push   $0x39
  jmp alltraps
8010607c:	e9 10 f9 ff ff       	jmp    80105991 <alltraps>

80106081 <vector58>:
.globl vector58
vector58:
  pushl $0
80106081:	6a 00                	push   $0x0
  pushl $58
80106083:	6a 3a                	push   $0x3a
  jmp alltraps
80106085:	e9 07 f9 ff ff       	jmp    80105991 <alltraps>

8010608a <vector59>:
.globl vector59
vector59:
  pushl $0
8010608a:	6a 00                	push   $0x0
  pushl $59
8010608c:	6a 3b                	push   $0x3b
  jmp alltraps
8010608e:	e9 fe f8 ff ff       	jmp    80105991 <alltraps>

80106093 <vector60>:
.globl vector60
vector60:
  pushl $0
80106093:	6a 00                	push   $0x0
  pushl $60
80106095:	6a 3c                	push   $0x3c
  jmp alltraps
80106097:	e9 f5 f8 ff ff       	jmp    80105991 <alltraps>

8010609c <vector61>:
.globl vector61
vector61:
  pushl $0
8010609c:	6a 00                	push   $0x0
  pushl $61
8010609e:	6a 3d                	push   $0x3d
  jmp alltraps
801060a0:	e9 ec f8 ff ff       	jmp    80105991 <alltraps>

801060a5 <vector62>:
.globl vector62
vector62:
  pushl $0
801060a5:	6a 00                	push   $0x0
  pushl $62
801060a7:	6a 3e                	push   $0x3e
  jmp alltraps
801060a9:	e9 e3 f8 ff ff       	jmp    80105991 <alltraps>

801060ae <vector63>:
.globl vector63
vector63:
  pushl $0
801060ae:	6a 00                	push   $0x0
  pushl $63
801060b0:	6a 3f                	push   $0x3f
  jmp alltraps
801060b2:	e9 da f8 ff ff       	jmp    80105991 <alltraps>

801060b7 <vector64>:
.globl vector64
vector64:
  pushl $0
801060b7:	6a 00                	push   $0x0
  pushl $64
801060b9:	6a 40                	push   $0x40
  jmp alltraps
801060bb:	e9 d1 f8 ff ff       	jmp    80105991 <alltraps>

801060c0 <vector65>:
.globl vector65
vector65:
  pushl $0
801060c0:	6a 00                	push   $0x0
  pushl $65
801060c2:	6a 41                	push   $0x41
  jmp alltraps
801060c4:	e9 c8 f8 ff ff       	jmp    80105991 <alltraps>

801060c9 <vector66>:
.globl vector66
vector66:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $66
801060cb:	6a 42                	push   $0x42
  jmp alltraps
801060cd:	e9 bf f8 ff ff       	jmp    80105991 <alltraps>

801060d2 <vector67>:
.globl vector67
vector67:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $67
801060d4:	6a 43                	push   $0x43
  jmp alltraps
801060d6:	e9 b6 f8 ff ff       	jmp    80105991 <alltraps>

801060db <vector68>:
.globl vector68
vector68:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $68
801060dd:	6a 44                	push   $0x44
  jmp alltraps
801060df:	e9 ad f8 ff ff       	jmp    80105991 <alltraps>

801060e4 <vector69>:
.globl vector69
vector69:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $69
801060e6:	6a 45                	push   $0x45
  jmp alltraps
801060e8:	e9 a4 f8 ff ff       	jmp    80105991 <alltraps>

801060ed <vector70>:
.globl vector70
vector70:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $70
801060ef:	6a 46                	push   $0x46
  jmp alltraps
801060f1:	e9 9b f8 ff ff       	jmp    80105991 <alltraps>

801060f6 <vector71>:
.globl vector71
vector71:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $71
801060f8:	6a 47                	push   $0x47
  jmp alltraps
801060fa:	e9 92 f8 ff ff       	jmp    80105991 <alltraps>

801060ff <vector72>:
.globl vector72
vector72:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $72
80106101:	6a 48                	push   $0x48
  jmp alltraps
80106103:	e9 89 f8 ff ff       	jmp    80105991 <alltraps>

80106108 <vector73>:
.globl vector73
vector73:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $73
8010610a:	6a 49                	push   $0x49
  jmp alltraps
8010610c:	e9 80 f8 ff ff       	jmp    80105991 <alltraps>

80106111 <vector74>:
.globl vector74
vector74:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $74
80106113:	6a 4a                	push   $0x4a
  jmp alltraps
80106115:	e9 77 f8 ff ff       	jmp    80105991 <alltraps>

8010611a <vector75>:
.globl vector75
vector75:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $75
8010611c:	6a 4b                	push   $0x4b
  jmp alltraps
8010611e:	e9 6e f8 ff ff       	jmp    80105991 <alltraps>

80106123 <vector76>:
.globl vector76
vector76:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $76
80106125:	6a 4c                	push   $0x4c
  jmp alltraps
80106127:	e9 65 f8 ff ff       	jmp    80105991 <alltraps>

8010612c <vector77>:
.globl vector77
vector77:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $77
8010612e:	6a 4d                	push   $0x4d
  jmp alltraps
80106130:	e9 5c f8 ff ff       	jmp    80105991 <alltraps>

80106135 <vector78>:
.globl vector78
vector78:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $78
80106137:	6a 4e                	push   $0x4e
  jmp alltraps
80106139:	e9 53 f8 ff ff       	jmp    80105991 <alltraps>

8010613e <vector79>:
.globl vector79
vector79:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $79
80106140:	6a 4f                	push   $0x4f
  jmp alltraps
80106142:	e9 4a f8 ff ff       	jmp    80105991 <alltraps>

80106147 <vector80>:
.globl vector80
vector80:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $80
80106149:	6a 50                	push   $0x50
  jmp alltraps
8010614b:	e9 41 f8 ff ff       	jmp    80105991 <alltraps>

80106150 <vector81>:
.globl vector81
vector81:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $81
80106152:	6a 51                	push   $0x51
  jmp alltraps
80106154:	e9 38 f8 ff ff       	jmp    80105991 <alltraps>

80106159 <vector82>:
.globl vector82
vector82:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $82
8010615b:	6a 52                	push   $0x52
  jmp alltraps
8010615d:	e9 2f f8 ff ff       	jmp    80105991 <alltraps>

80106162 <vector83>:
.globl vector83
vector83:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $83
80106164:	6a 53                	push   $0x53
  jmp alltraps
80106166:	e9 26 f8 ff ff       	jmp    80105991 <alltraps>

8010616b <vector84>:
.globl vector84
vector84:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $84
8010616d:	6a 54                	push   $0x54
  jmp alltraps
8010616f:	e9 1d f8 ff ff       	jmp    80105991 <alltraps>

80106174 <vector85>:
.globl vector85
vector85:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $85
80106176:	6a 55                	push   $0x55
  jmp alltraps
80106178:	e9 14 f8 ff ff       	jmp    80105991 <alltraps>

8010617d <vector86>:
.globl vector86
vector86:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $86
8010617f:	6a 56                	push   $0x56
  jmp alltraps
80106181:	e9 0b f8 ff ff       	jmp    80105991 <alltraps>

80106186 <vector87>:
.globl vector87
vector87:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $87
80106188:	6a 57                	push   $0x57
  jmp alltraps
8010618a:	e9 02 f8 ff ff       	jmp    80105991 <alltraps>

8010618f <vector88>:
.globl vector88
vector88:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $88
80106191:	6a 58                	push   $0x58
  jmp alltraps
80106193:	e9 f9 f7 ff ff       	jmp    80105991 <alltraps>

80106198 <vector89>:
.globl vector89
vector89:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $89
8010619a:	6a 59                	push   $0x59
  jmp alltraps
8010619c:	e9 f0 f7 ff ff       	jmp    80105991 <alltraps>

801061a1 <vector90>:
.globl vector90
vector90:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $90
801061a3:	6a 5a                	push   $0x5a
  jmp alltraps
801061a5:	e9 e7 f7 ff ff       	jmp    80105991 <alltraps>

801061aa <vector91>:
.globl vector91
vector91:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $91
801061ac:	6a 5b                	push   $0x5b
  jmp alltraps
801061ae:	e9 de f7 ff ff       	jmp    80105991 <alltraps>

801061b3 <vector92>:
.globl vector92
vector92:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $92
801061b5:	6a 5c                	push   $0x5c
  jmp alltraps
801061b7:	e9 d5 f7 ff ff       	jmp    80105991 <alltraps>

801061bc <vector93>:
.globl vector93
vector93:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $93
801061be:	6a 5d                	push   $0x5d
  jmp alltraps
801061c0:	e9 cc f7 ff ff       	jmp    80105991 <alltraps>

801061c5 <vector94>:
.globl vector94
vector94:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $94
801061c7:	6a 5e                	push   $0x5e
  jmp alltraps
801061c9:	e9 c3 f7 ff ff       	jmp    80105991 <alltraps>

801061ce <vector95>:
.globl vector95
vector95:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $95
801061d0:	6a 5f                	push   $0x5f
  jmp alltraps
801061d2:	e9 ba f7 ff ff       	jmp    80105991 <alltraps>

801061d7 <vector96>:
.globl vector96
vector96:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $96
801061d9:	6a 60                	push   $0x60
  jmp alltraps
801061db:	e9 b1 f7 ff ff       	jmp    80105991 <alltraps>

801061e0 <vector97>:
.globl vector97
vector97:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $97
801061e2:	6a 61                	push   $0x61
  jmp alltraps
801061e4:	e9 a8 f7 ff ff       	jmp    80105991 <alltraps>

801061e9 <vector98>:
.globl vector98
vector98:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $98
801061eb:	6a 62                	push   $0x62
  jmp alltraps
801061ed:	e9 9f f7 ff ff       	jmp    80105991 <alltraps>

801061f2 <vector99>:
.globl vector99
vector99:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $99
801061f4:	6a 63                	push   $0x63
  jmp alltraps
801061f6:	e9 96 f7 ff ff       	jmp    80105991 <alltraps>

801061fb <vector100>:
.globl vector100
vector100:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $100
801061fd:	6a 64                	push   $0x64
  jmp alltraps
801061ff:	e9 8d f7 ff ff       	jmp    80105991 <alltraps>

80106204 <vector101>:
.globl vector101
vector101:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $101
80106206:	6a 65                	push   $0x65
  jmp alltraps
80106208:	e9 84 f7 ff ff       	jmp    80105991 <alltraps>

8010620d <vector102>:
.globl vector102
vector102:
  pushl $0
8010620d:	6a 00                	push   $0x0
  pushl $102
8010620f:	6a 66                	push   $0x66
  jmp alltraps
80106211:	e9 7b f7 ff ff       	jmp    80105991 <alltraps>

80106216 <vector103>:
.globl vector103
vector103:
  pushl $0
80106216:	6a 00                	push   $0x0
  pushl $103
80106218:	6a 67                	push   $0x67
  jmp alltraps
8010621a:	e9 72 f7 ff ff       	jmp    80105991 <alltraps>

8010621f <vector104>:
.globl vector104
vector104:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $104
80106221:	6a 68                	push   $0x68
  jmp alltraps
80106223:	e9 69 f7 ff ff       	jmp    80105991 <alltraps>

80106228 <vector105>:
.globl vector105
vector105:
  pushl $0
80106228:	6a 00                	push   $0x0
  pushl $105
8010622a:	6a 69                	push   $0x69
  jmp alltraps
8010622c:	e9 60 f7 ff ff       	jmp    80105991 <alltraps>

80106231 <vector106>:
.globl vector106
vector106:
  pushl $0
80106231:	6a 00                	push   $0x0
  pushl $106
80106233:	6a 6a                	push   $0x6a
  jmp alltraps
80106235:	e9 57 f7 ff ff       	jmp    80105991 <alltraps>

8010623a <vector107>:
.globl vector107
vector107:
  pushl $0
8010623a:	6a 00                	push   $0x0
  pushl $107
8010623c:	6a 6b                	push   $0x6b
  jmp alltraps
8010623e:	e9 4e f7 ff ff       	jmp    80105991 <alltraps>

80106243 <vector108>:
.globl vector108
vector108:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $108
80106245:	6a 6c                	push   $0x6c
  jmp alltraps
80106247:	e9 45 f7 ff ff       	jmp    80105991 <alltraps>

8010624c <vector109>:
.globl vector109
vector109:
  pushl $0
8010624c:	6a 00                	push   $0x0
  pushl $109
8010624e:	6a 6d                	push   $0x6d
  jmp alltraps
80106250:	e9 3c f7 ff ff       	jmp    80105991 <alltraps>

80106255 <vector110>:
.globl vector110
vector110:
  pushl $0
80106255:	6a 00                	push   $0x0
  pushl $110
80106257:	6a 6e                	push   $0x6e
  jmp alltraps
80106259:	e9 33 f7 ff ff       	jmp    80105991 <alltraps>

8010625e <vector111>:
.globl vector111
vector111:
  pushl $0
8010625e:	6a 00                	push   $0x0
  pushl $111
80106260:	6a 6f                	push   $0x6f
  jmp alltraps
80106262:	e9 2a f7 ff ff       	jmp    80105991 <alltraps>

80106267 <vector112>:
.globl vector112
vector112:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $112
80106269:	6a 70                	push   $0x70
  jmp alltraps
8010626b:	e9 21 f7 ff ff       	jmp    80105991 <alltraps>

80106270 <vector113>:
.globl vector113
vector113:
  pushl $0
80106270:	6a 00                	push   $0x0
  pushl $113
80106272:	6a 71                	push   $0x71
  jmp alltraps
80106274:	e9 18 f7 ff ff       	jmp    80105991 <alltraps>

80106279 <vector114>:
.globl vector114
vector114:
  pushl $0
80106279:	6a 00                	push   $0x0
  pushl $114
8010627b:	6a 72                	push   $0x72
  jmp alltraps
8010627d:	e9 0f f7 ff ff       	jmp    80105991 <alltraps>

80106282 <vector115>:
.globl vector115
vector115:
  pushl $0
80106282:	6a 00                	push   $0x0
  pushl $115
80106284:	6a 73                	push   $0x73
  jmp alltraps
80106286:	e9 06 f7 ff ff       	jmp    80105991 <alltraps>

8010628b <vector116>:
.globl vector116
vector116:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $116
8010628d:	6a 74                	push   $0x74
  jmp alltraps
8010628f:	e9 fd f6 ff ff       	jmp    80105991 <alltraps>

80106294 <vector117>:
.globl vector117
vector117:
  pushl $0
80106294:	6a 00                	push   $0x0
  pushl $117
80106296:	6a 75                	push   $0x75
  jmp alltraps
80106298:	e9 f4 f6 ff ff       	jmp    80105991 <alltraps>

8010629d <vector118>:
.globl vector118
vector118:
  pushl $0
8010629d:	6a 00                	push   $0x0
  pushl $118
8010629f:	6a 76                	push   $0x76
  jmp alltraps
801062a1:	e9 eb f6 ff ff       	jmp    80105991 <alltraps>

801062a6 <vector119>:
.globl vector119
vector119:
  pushl $0
801062a6:	6a 00                	push   $0x0
  pushl $119
801062a8:	6a 77                	push   $0x77
  jmp alltraps
801062aa:	e9 e2 f6 ff ff       	jmp    80105991 <alltraps>

801062af <vector120>:
.globl vector120
vector120:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $120
801062b1:	6a 78                	push   $0x78
  jmp alltraps
801062b3:	e9 d9 f6 ff ff       	jmp    80105991 <alltraps>

801062b8 <vector121>:
.globl vector121
vector121:
  pushl $0
801062b8:	6a 00                	push   $0x0
  pushl $121
801062ba:	6a 79                	push   $0x79
  jmp alltraps
801062bc:	e9 d0 f6 ff ff       	jmp    80105991 <alltraps>

801062c1 <vector122>:
.globl vector122
vector122:
  pushl $0
801062c1:	6a 00                	push   $0x0
  pushl $122
801062c3:	6a 7a                	push   $0x7a
  jmp alltraps
801062c5:	e9 c7 f6 ff ff       	jmp    80105991 <alltraps>

801062ca <vector123>:
.globl vector123
vector123:
  pushl $0
801062ca:	6a 00                	push   $0x0
  pushl $123
801062cc:	6a 7b                	push   $0x7b
  jmp alltraps
801062ce:	e9 be f6 ff ff       	jmp    80105991 <alltraps>

801062d3 <vector124>:
.globl vector124
vector124:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $124
801062d5:	6a 7c                	push   $0x7c
  jmp alltraps
801062d7:	e9 b5 f6 ff ff       	jmp    80105991 <alltraps>

801062dc <vector125>:
.globl vector125
vector125:
  pushl $0
801062dc:	6a 00                	push   $0x0
  pushl $125
801062de:	6a 7d                	push   $0x7d
  jmp alltraps
801062e0:	e9 ac f6 ff ff       	jmp    80105991 <alltraps>

801062e5 <vector126>:
.globl vector126
vector126:
  pushl $0
801062e5:	6a 00                	push   $0x0
  pushl $126
801062e7:	6a 7e                	push   $0x7e
  jmp alltraps
801062e9:	e9 a3 f6 ff ff       	jmp    80105991 <alltraps>

801062ee <vector127>:
.globl vector127
vector127:
  pushl $0
801062ee:	6a 00                	push   $0x0
  pushl $127
801062f0:	6a 7f                	push   $0x7f
  jmp alltraps
801062f2:	e9 9a f6 ff ff       	jmp    80105991 <alltraps>

801062f7 <vector128>:
.globl vector128
vector128:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $128
801062f9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801062fe:	e9 8e f6 ff ff       	jmp    80105991 <alltraps>

80106303 <vector129>:
.globl vector129
vector129:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $129
80106305:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010630a:	e9 82 f6 ff ff       	jmp    80105991 <alltraps>

8010630f <vector130>:
.globl vector130
vector130:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $130
80106311:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106316:	e9 76 f6 ff ff       	jmp    80105991 <alltraps>

8010631b <vector131>:
.globl vector131
vector131:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $131
8010631d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106322:	e9 6a f6 ff ff       	jmp    80105991 <alltraps>

80106327 <vector132>:
.globl vector132
vector132:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $132
80106329:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010632e:	e9 5e f6 ff ff       	jmp    80105991 <alltraps>

80106333 <vector133>:
.globl vector133
vector133:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $133
80106335:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010633a:	e9 52 f6 ff ff       	jmp    80105991 <alltraps>

8010633f <vector134>:
.globl vector134
vector134:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $134
80106341:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106346:	e9 46 f6 ff ff       	jmp    80105991 <alltraps>

8010634b <vector135>:
.globl vector135
vector135:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $135
8010634d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106352:	e9 3a f6 ff ff       	jmp    80105991 <alltraps>

80106357 <vector136>:
.globl vector136
vector136:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $136
80106359:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010635e:	e9 2e f6 ff ff       	jmp    80105991 <alltraps>

80106363 <vector137>:
.globl vector137
vector137:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $137
80106365:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010636a:	e9 22 f6 ff ff       	jmp    80105991 <alltraps>

8010636f <vector138>:
.globl vector138
vector138:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $138
80106371:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106376:	e9 16 f6 ff ff       	jmp    80105991 <alltraps>

8010637b <vector139>:
.globl vector139
vector139:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $139
8010637d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106382:	e9 0a f6 ff ff       	jmp    80105991 <alltraps>

80106387 <vector140>:
.globl vector140
vector140:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $140
80106389:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010638e:	e9 fe f5 ff ff       	jmp    80105991 <alltraps>

80106393 <vector141>:
.globl vector141
vector141:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $141
80106395:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010639a:	e9 f2 f5 ff ff       	jmp    80105991 <alltraps>

8010639f <vector142>:
.globl vector142
vector142:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $142
801063a1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801063a6:	e9 e6 f5 ff ff       	jmp    80105991 <alltraps>

801063ab <vector143>:
.globl vector143
vector143:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $143
801063ad:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801063b2:	e9 da f5 ff ff       	jmp    80105991 <alltraps>

801063b7 <vector144>:
.globl vector144
vector144:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $144
801063b9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801063be:	e9 ce f5 ff ff       	jmp    80105991 <alltraps>

801063c3 <vector145>:
.globl vector145
vector145:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $145
801063c5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801063ca:	e9 c2 f5 ff ff       	jmp    80105991 <alltraps>

801063cf <vector146>:
.globl vector146
vector146:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $146
801063d1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801063d6:	e9 b6 f5 ff ff       	jmp    80105991 <alltraps>

801063db <vector147>:
.globl vector147
vector147:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $147
801063dd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801063e2:	e9 aa f5 ff ff       	jmp    80105991 <alltraps>

801063e7 <vector148>:
.globl vector148
vector148:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $148
801063e9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801063ee:	e9 9e f5 ff ff       	jmp    80105991 <alltraps>

801063f3 <vector149>:
.globl vector149
vector149:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $149
801063f5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801063fa:	e9 92 f5 ff ff       	jmp    80105991 <alltraps>

801063ff <vector150>:
.globl vector150
vector150:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $150
80106401:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106406:	e9 86 f5 ff ff       	jmp    80105991 <alltraps>

8010640b <vector151>:
.globl vector151
vector151:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $151
8010640d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106412:	e9 7a f5 ff ff       	jmp    80105991 <alltraps>

80106417 <vector152>:
.globl vector152
vector152:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $152
80106419:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010641e:	e9 6e f5 ff ff       	jmp    80105991 <alltraps>

80106423 <vector153>:
.globl vector153
vector153:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $153
80106425:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010642a:	e9 62 f5 ff ff       	jmp    80105991 <alltraps>

8010642f <vector154>:
.globl vector154
vector154:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $154
80106431:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106436:	e9 56 f5 ff ff       	jmp    80105991 <alltraps>

8010643b <vector155>:
.globl vector155
vector155:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $155
8010643d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106442:	e9 4a f5 ff ff       	jmp    80105991 <alltraps>

80106447 <vector156>:
.globl vector156
vector156:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $156
80106449:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010644e:	e9 3e f5 ff ff       	jmp    80105991 <alltraps>

80106453 <vector157>:
.globl vector157
vector157:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $157
80106455:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010645a:	e9 32 f5 ff ff       	jmp    80105991 <alltraps>

8010645f <vector158>:
.globl vector158
vector158:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $158
80106461:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106466:	e9 26 f5 ff ff       	jmp    80105991 <alltraps>

8010646b <vector159>:
.globl vector159
vector159:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $159
8010646d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106472:	e9 1a f5 ff ff       	jmp    80105991 <alltraps>

80106477 <vector160>:
.globl vector160
vector160:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $160
80106479:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010647e:	e9 0e f5 ff ff       	jmp    80105991 <alltraps>

80106483 <vector161>:
.globl vector161
vector161:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $161
80106485:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010648a:	e9 02 f5 ff ff       	jmp    80105991 <alltraps>

8010648f <vector162>:
.globl vector162
vector162:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $162
80106491:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106496:	e9 f6 f4 ff ff       	jmp    80105991 <alltraps>

8010649b <vector163>:
.globl vector163
vector163:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $163
8010649d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801064a2:	e9 ea f4 ff ff       	jmp    80105991 <alltraps>

801064a7 <vector164>:
.globl vector164
vector164:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $164
801064a9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801064ae:	e9 de f4 ff ff       	jmp    80105991 <alltraps>

801064b3 <vector165>:
.globl vector165
vector165:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $165
801064b5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801064ba:	e9 d2 f4 ff ff       	jmp    80105991 <alltraps>

801064bf <vector166>:
.globl vector166
vector166:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $166
801064c1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801064c6:	e9 c6 f4 ff ff       	jmp    80105991 <alltraps>

801064cb <vector167>:
.globl vector167
vector167:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $167
801064cd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801064d2:	e9 ba f4 ff ff       	jmp    80105991 <alltraps>

801064d7 <vector168>:
.globl vector168
vector168:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $168
801064d9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801064de:	e9 ae f4 ff ff       	jmp    80105991 <alltraps>

801064e3 <vector169>:
.globl vector169
vector169:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $169
801064e5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801064ea:	e9 a2 f4 ff ff       	jmp    80105991 <alltraps>

801064ef <vector170>:
.globl vector170
vector170:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $170
801064f1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801064f6:	e9 96 f4 ff ff       	jmp    80105991 <alltraps>

801064fb <vector171>:
.globl vector171
vector171:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $171
801064fd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106502:	e9 8a f4 ff ff       	jmp    80105991 <alltraps>

80106507 <vector172>:
.globl vector172
vector172:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $172
80106509:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010650e:	e9 7e f4 ff ff       	jmp    80105991 <alltraps>

80106513 <vector173>:
.globl vector173
vector173:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $173
80106515:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010651a:	e9 72 f4 ff ff       	jmp    80105991 <alltraps>

8010651f <vector174>:
.globl vector174
vector174:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $174
80106521:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106526:	e9 66 f4 ff ff       	jmp    80105991 <alltraps>

8010652b <vector175>:
.globl vector175
vector175:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $175
8010652d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106532:	e9 5a f4 ff ff       	jmp    80105991 <alltraps>

80106537 <vector176>:
.globl vector176
vector176:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $176
80106539:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010653e:	e9 4e f4 ff ff       	jmp    80105991 <alltraps>

80106543 <vector177>:
.globl vector177
vector177:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $177
80106545:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010654a:	e9 42 f4 ff ff       	jmp    80105991 <alltraps>

8010654f <vector178>:
.globl vector178
vector178:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $178
80106551:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106556:	e9 36 f4 ff ff       	jmp    80105991 <alltraps>

8010655b <vector179>:
.globl vector179
vector179:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $179
8010655d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106562:	e9 2a f4 ff ff       	jmp    80105991 <alltraps>

80106567 <vector180>:
.globl vector180
vector180:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $180
80106569:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010656e:	e9 1e f4 ff ff       	jmp    80105991 <alltraps>

80106573 <vector181>:
.globl vector181
vector181:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $181
80106575:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010657a:	e9 12 f4 ff ff       	jmp    80105991 <alltraps>

8010657f <vector182>:
.globl vector182
vector182:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $182
80106581:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106586:	e9 06 f4 ff ff       	jmp    80105991 <alltraps>

8010658b <vector183>:
.globl vector183
vector183:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $183
8010658d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106592:	e9 fa f3 ff ff       	jmp    80105991 <alltraps>

80106597 <vector184>:
.globl vector184
vector184:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $184
80106599:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010659e:	e9 ee f3 ff ff       	jmp    80105991 <alltraps>

801065a3 <vector185>:
.globl vector185
vector185:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $185
801065a5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801065aa:	e9 e2 f3 ff ff       	jmp    80105991 <alltraps>

801065af <vector186>:
.globl vector186
vector186:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $186
801065b1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801065b6:	e9 d6 f3 ff ff       	jmp    80105991 <alltraps>

801065bb <vector187>:
.globl vector187
vector187:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $187
801065bd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801065c2:	e9 ca f3 ff ff       	jmp    80105991 <alltraps>

801065c7 <vector188>:
.globl vector188
vector188:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $188
801065c9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801065ce:	e9 be f3 ff ff       	jmp    80105991 <alltraps>

801065d3 <vector189>:
.globl vector189
vector189:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $189
801065d5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801065da:	e9 b2 f3 ff ff       	jmp    80105991 <alltraps>

801065df <vector190>:
.globl vector190
vector190:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $190
801065e1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801065e6:	e9 a6 f3 ff ff       	jmp    80105991 <alltraps>

801065eb <vector191>:
.globl vector191
vector191:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $191
801065ed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801065f2:	e9 9a f3 ff ff       	jmp    80105991 <alltraps>

801065f7 <vector192>:
.globl vector192
vector192:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $192
801065f9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801065fe:	e9 8e f3 ff ff       	jmp    80105991 <alltraps>

80106603 <vector193>:
.globl vector193
vector193:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $193
80106605:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010660a:	e9 82 f3 ff ff       	jmp    80105991 <alltraps>

8010660f <vector194>:
.globl vector194
vector194:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $194
80106611:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106616:	e9 76 f3 ff ff       	jmp    80105991 <alltraps>

8010661b <vector195>:
.globl vector195
vector195:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $195
8010661d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106622:	e9 6a f3 ff ff       	jmp    80105991 <alltraps>

80106627 <vector196>:
.globl vector196
vector196:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $196
80106629:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010662e:	e9 5e f3 ff ff       	jmp    80105991 <alltraps>

80106633 <vector197>:
.globl vector197
vector197:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $197
80106635:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010663a:	e9 52 f3 ff ff       	jmp    80105991 <alltraps>

8010663f <vector198>:
.globl vector198
vector198:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $198
80106641:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106646:	e9 46 f3 ff ff       	jmp    80105991 <alltraps>

8010664b <vector199>:
.globl vector199
vector199:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $199
8010664d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106652:	e9 3a f3 ff ff       	jmp    80105991 <alltraps>

80106657 <vector200>:
.globl vector200
vector200:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $200
80106659:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010665e:	e9 2e f3 ff ff       	jmp    80105991 <alltraps>

80106663 <vector201>:
.globl vector201
vector201:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $201
80106665:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010666a:	e9 22 f3 ff ff       	jmp    80105991 <alltraps>

8010666f <vector202>:
.globl vector202
vector202:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $202
80106671:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106676:	e9 16 f3 ff ff       	jmp    80105991 <alltraps>

8010667b <vector203>:
.globl vector203
vector203:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $203
8010667d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106682:	e9 0a f3 ff ff       	jmp    80105991 <alltraps>

80106687 <vector204>:
.globl vector204
vector204:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $204
80106689:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010668e:	e9 fe f2 ff ff       	jmp    80105991 <alltraps>

80106693 <vector205>:
.globl vector205
vector205:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $205
80106695:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010669a:	e9 f2 f2 ff ff       	jmp    80105991 <alltraps>

8010669f <vector206>:
.globl vector206
vector206:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $206
801066a1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801066a6:	e9 e6 f2 ff ff       	jmp    80105991 <alltraps>

801066ab <vector207>:
.globl vector207
vector207:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $207
801066ad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801066b2:	e9 da f2 ff ff       	jmp    80105991 <alltraps>

801066b7 <vector208>:
.globl vector208
vector208:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $208
801066b9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801066be:	e9 ce f2 ff ff       	jmp    80105991 <alltraps>

801066c3 <vector209>:
.globl vector209
vector209:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $209
801066c5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801066ca:	e9 c2 f2 ff ff       	jmp    80105991 <alltraps>

801066cf <vector210>:
.globl vector210
vector210:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $210
801066d1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801066d6:	e9 b6 f2 ff ff       	jmp    80105991 <alltraps>

801066db <vector211>:
.globl vector211
vector211:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $211
801066dd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801066e2:	e9 aa f2 ff ff       	jmp    80105991 <alltraps>

801066e7 <vector212>:
.globl vector212
vector212:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $212
801066e9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801066ee:	e9 9e f2 ff ff       	jmp    80105991 <alltraps>

801066f3 <vector213>:
.globl vector213
vector213:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $213
801066f5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801066fa:	e9 92 f2 ff ff       	jmp    80105991 <alltraps>

801066ff <vector214>:
.globl vector214
vector214:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $214
80106701:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106706:	e9 86 f2 ff ff       	jmp    80105991 <alltraps>

8010670b <vector215>:
.globl vector215
vector215:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $215
8010670d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106712:	e9 7a f2 ff ff       	jmp    80105991 <alltraps>

80106717 <vector216>:
.globl vector216
vector216:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $216
80106719:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010671e:	e9 6e f2 ff ff       	jmp    80105991 <alltraps>

80106723 <vector217>:
.globl vector217
vector217:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $217
80106725:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010672a:	e9 62 f2 ff ff       	jmp    80105991 <alltraps>

8010672f <vector218>:
.globl vector218
vector218:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $218
80106731:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106736:	e9 56 f2 ff ff       	jmp    80105991 <alltraps>

8010673b <vector219>:
.globl vector219
vector219:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $219
8010673d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106742:	e9 4a f2 ff ff       	jmp    80105991 <alltraps>

80106747 <vector220>:
.globl vector220
vector220:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $220
80106749:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010674e:	e9 3e f2 ff ff       	jmp    80105991 <alltraps>

80106753 <vector221>:
.globl vector221
vector221:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $221
80106755:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010675a:	e9 32 f2 ff ff       	jmp    80105991 <alltraps>

8010675f <vector222>:
.globl vector222
vector222:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $222
80106761:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106766:	e9 26 f2 ff ff       	jmp    80105991 <alltraps>

8010676b <vector223>:
.globl vector223
vector223:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $223
8010676d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106772:	e9 1a f2 ff ff       	jmp    80105991 <alltraps>

80106777 <vector224>:
.globl vector224
vector224:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $224
80106779:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010677e:	e9 0e f2 ff ff       	jmp    80105991 <alltraps>

80106783 <vector225>:
.globl vector225
vector225:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $225
80106785:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010678a:	e9 02 f2 ff ff       	jmp    80105991 <alltraps>

8010678f <vector226>:
.globl vector226
vector226:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $226
80106791:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106796:	e9 f6 f1 ff ff       	jmp    80105991 <alltraps>

8010679b <vector227>:
.globl vector227
vector227:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $227
8010679d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801067a2:	e9 ea f1 ff ff       	jmp    80105991 <alltraps>

801067a7 <vector228>:
.globl vector228
vector228:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $228
801067a9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801067ae:	e9 de f1 ff ff       	jmp    80105991 <alltraps>

801067b3 <vector229>:
.globl vector229
vector229:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $229
801067b5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801067ba:	e9 d2 f1 ff ff       	jmp    80105991 <alltraps>

801067bf <vector230>:
.globl vector230
vector230:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $230
801067c1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801067c6:	e9 c6 f1 ff ff       	jmp    80105991 <alltraps>

801067cb <vector231>:
.globl vector231
vector231:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $231
801067cd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801067d2:	e9 ba f1 ff ff       	jmp    80105991 <alltraps>

801067d7 <vector232>:
.globl vector232
vector232:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $232
801067d9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801067de:	e9 ae f1 ff ff       	jmp    80105991 <alltraps>

801067e3 <vector233>:
.globl vector233
vector233:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $233
801067e5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801067ea:	e9 a2 f1 ff ff       	jmp    80105991 <alltraps>

801067ef <vector234>:
.globl vector234
vector234:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $234
801067f1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801067f6:	e9 96 f1 ff ff       	jmp    80105991 <alltraps>

801067fb <vector235>:
.globl vector235
vector235:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $235
801067fd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106802:	e9 8a f1 ff ff       	jmp    80105991 <alltraps>

80106807 <vector236>:
.globl vector236
vector236:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $236
80106809:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010680e:	e9 7e f1 ff ff       	jmp    80105991 <alltraps>

80106813 <vector237>:
.globl vector237
vector237:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $237
80106815:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010681a:	e9 72 f1 ff ff       	jmp    80105991 <alltraps>

8010681f <vector238>:
.globl vector238
vector238:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $238
80106821:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106826:	e9 66 f1 ff ff       	jmp    80105991 <alltraps>

8010682b <vector239>:
.globl vector239
vector239:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $239
8010682d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106832:	e9 5a f1 ff ff       	jmp    80105991 <alltraps>

80106837 <vector240>:
.globl vector240
vector240:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $240
80106839:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010683e:	e9 4e f1 ff ff       	jmp    80105991 <alltraps>

80106843 <vector241>:
.globl vector241
vector241:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $241
80106845:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010684a:	e9 42 f1 ff ff       	jmp    80105991 <alltraps>

8010684f <vector242>:
.globl vector242
vector242:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $242
80106851:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106856:	e9 36 f1 ff ff       	jmp    80105991 <alltraps>

8010685b <vector243>:
.globl vector243
vector243:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $243
8010685d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106862:	e9 2a f1 ff ff       	jmp    80105991 <alltraps>

80106867 <vector244>:
.globl vector244
vector244:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $244
80106869:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010686e:	e9 1e f1 ff ff       	jmp    80105991 <alltraps>

80106873 <vector245>:
.globl vector245
vector245:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $245
80106875:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010687a:	e9 12 f1 ff ff       	jmp    80105991 <alltraps>

8010687f <vector246>:
.globl vector246
vector246:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $246
80106881:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106886:	e9 06 f1 ff ff       	jmp    80105991 <alltraps>

8010688b <vector247>:
.globl vector247
vector247:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $247
8010688d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106892:	e9 fa f0 ff ff       	jmp    80105991 <alltraps>

80106897 <vector248>:
.globl vector248
vector248:
  pushl $0
80106897:	6a 00                	push   $0x0
  pushl $248
80106899:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010689e:	e9 ee f0 ff ff       	jmp    80105991 <alltraps>

801068a3 <vector249>:
.globl vector249
vector249:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $249
801068a5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801068aa:	e9 e2 f0 ff ff       	jmp    80105991 <alltraps>

801068af <vector250>:
.globl vector250
vector250:
  pushl $0
801068af:	6a 00                	push   $0x0
  pushl $250
801068b1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801068b6:	e9 d6 f0 ff ff       	jmp    80105991 <alltraps>

801068bb <vector251>:
.globl vector251
vector251:
  pushl $0
801068bb:	6a 00                	push   $0x0
  pushl $251
801068bd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801068c2:	e9 ca f0 ff ff       	jmp    80105991 <alltraps>

801068c7 <vector252>:
.globl vector252
vector252:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $252
801068c9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801068ce:	e9 be f0 ff ff       	jmp    80105991 <alltraps>

801068d3 <vector253>:
.globl vector253
vector253:
  pushl $0
801068d3:	6a 00                	push   $0x0
  pushl $253
801068d5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801068da:	e9 b2 f0 ff ff       	jmp    80105991 <alltraps>

801068df <vector254>:
.globl vector254
vector254:
  pushl $0
801068df:	6a 00                	push   $0x0
  pushl $254
801068e1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801068e6:	e9 a6 f0 ff ff       	jmp    80105991 <alltraps>

801068eb <vector255>:
.globl vector255
vector255:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $255
801068ed:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801068f2:	e9 9a f0 ff ff       	jmp    80105991 <alltraps>
801068f7:	66 90                	xchg   %ax,%ax
801068f9:	66 90                	xchg   %ax,%ax
801068fb:	66 90                	xchg   %ax,%ax
801068fd:	66 90                	xchg   %ax,%ax
801068ff:	90                   	nop

80106900 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106900:	55                   	push   %ebp
80106901:	89 e5                	mov    %esp,%ebp
80106903:	57                   	push   %edi
80106904:	56                   	push   %esi
80106905:	53                   	push   %ebx
80106906:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106908:	c1 ea 16             	shr    $0x16,%edx
8010690b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010690e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106911:	8b 07                	mov    (%edi),%eax
80106913:	a8 01                	test   $0x1,%al
80106915:	74 29                	je     80106940 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106917:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010691c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106922:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106925:	c1 eb 0a             	shr    $0xa,%ebx
80106928:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010692e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106931:	5b                   	pop    %ebx
80106932:	5e                   	pop    %esi
80106933:	5f                   	pop    %edi
80106934:	5d                   	pop    %ebp
80106935:	c3                   	ret    
80106936:	8d 76 00             	lea    0x0(%esi),%esi
80106939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106940:	85 c9                	test   %ecx,%ecx
80106942:	74 2c                	je     80106970 <walkpgdir+0x70>
80106944:	e8 67 bb ff ff       	call   801024b0 <kalloc>
80106949:	85 c0                	test   %eax,%eax
8010694b:	89 c6                	mov    %eax,%esi
8010694d:	74 21                	je     80106970 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010694f:	83 ec 04             	sub    $0x4,%esp
80106952:	68 00 10 00 00       	push   $0x1000
80106957:	6a 00                	push   $0x0
80106959:	50                   	push   %eax
8010695a:	e8 51 dd ff ff       	call   801046b0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010695f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106965:	83 c4 10             	add    $0x10,%esp
80106968:	83 c8 07             	or     $0x7,%eax
8010696b:	89 07                	mov    %eax,(%edi)
8010696d:	eb b3                	jmp    80106922 <walkpgdir+0x22>
8010696f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106970:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106973:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106975:	5b                   	pop    %ebx
80106976:	5e                   	pop    %esi
80106977:	5f                   	pop    %edi
80106978:	5d                   	pop    %ebp
80106979:	c3                   	ret    
8010697a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106980 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	56                   	push   %esi
80106985:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106986:	89 d3                	mov    %edx,%ebx
80106988:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010698e:	83 ec 1c             	sub    $0x1c,%esp
80106991:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106994:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106998:	8b 7d 08             	mov    0x8(%ebp),%edi
8010699b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801069a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801069a6:	29 df                	sub    %ebx,%edi
801069a8:	83 c8 01             	or     $0x1,%eax
801069ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
801069ae:	eb 15                	jmp    801069c5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801069b0:	f6 00 01             	testb  $0x1,(%eax)
801069b3:	75 45                	jne    801069fa <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801069b5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801069b8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801069bb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801069bd:	74 31                	je     801069f0 <mappages+0x70>
      break;
    a += PGSIZE;
801069bf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801069c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069c8:	b9 01 00 00 00       	mov    $0x1,%ecx
801069cd:	89 da                	mov    %ebx,%edx
801069cf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801069d2:	e8 29 ff ff ff       	call   80106900 <walkpgdir>
801069d7:	85 c0                	test   %eax,%eax
801069d9:	75 d5                	jne    801069b0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801069db:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801069de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801069e3:	5b                   	pop    %ebx
801069e4:	5e                   	pop    %esi
801069e5:	5f                   	pop    %edi
801069e6:	5d                   	pop    %ebp
801069e7:	c3                   	ret    
801069e8:	90                   	nop
801069e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801069f3:	31 c0                	xor    %eax,%eax
}
801069f5:	5b                   	pop    %ebx
801069f6:	5e                   	pop    %esi
801069f7:	5f                   	pop    %edi
801069f8:	5d                   	pop    %ebp
801069f9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801069fa:	83 ec 0c             	sub    $0xc,%esp
801069fd:	68 54 7b 10 80       	push   $0x80107b54
80106a02:	e8 79 99 ff ff       	call   80100380 <panic>
80106a07:	89 f6                	mov    %esi,%esi
80106a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a10 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	57                   	push   %edi
80106a14:	56                   	push   %esi
80106a15:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a16:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a1c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a1e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a24:	83 ec 1c             	sub    $0x1c,%esp
80106a27:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a2a:	39 d3                	cmp    %edx,%ebx
80106a2c:	73 66                	jae    80106a94 <deallocuvm.part.0+0x84>
80106a2e:	89 d6                	mov    %edx,%esi
80106a30:	eb 3d                	jmp    80106a6f <deallocuvm.part.0+0x5f>
80106a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106a38:	8b 10                	mov    (%eax),%edx
80106a3a:	f6 c2 01             	test   $0x1,%dl
80106a3d:	74 26                	je     80106a65 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106a3f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a45:	74 58                	je     80106a9f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106a47:	83 ec 0c             	sub    $0xc,%esp
80106a4a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106a50:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a53:	52                   	push   %edx
80106a54:	e8 a7 b8 ff ff       	call   80102300 <kfree>
      *pte = 0;
80106a59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a5c:	83 c4 10             	add    $0x10,%esp
80106a5f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a65:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a6b:	39 f3                	cmp    %esi,%ebx
80106a6d:	73 25                	jae    80106a94 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a6f:	31 c9                	xor    %ecx,%ecx
80106a71:	89 da                	mov    %ebx,%edx
80106a73:	89 f8                	mov    %edi,%eax
80106a75:	e8 86 fe ff ff       	call   80106900 <walkpgdir>
    if(!pte)
80106a7a:	85 c0                	test   %eax,%eax
80106a7c:	75 ba                	jne    80106a38 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106a7e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106a84:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a8a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a90:	39 f3                	cmp    %esi,%ebx
80106a92:	72 db                	jb     80106a6f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a94:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a9a:	5b                   	pop    %ebx
80106a9b:	5e                   	pop    %esi
80106a9c:	5f                   	pop    %edi
80106a9d:	5d                   	pop    %ebp
80106a9e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106a9f:	83 ec 0c             	sub    $0xc,%esp
80106aa2:	68 e6 74 10 80       	push   $0x801074e6
80106aa7:	e8 d4 98 ff ff       	call   80100380 <panic>
80106aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ab0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106ab6:	e8 d5 cc ff ff       	call   80103790 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106abb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106ac1:	31 c9                	xor    %ecx,%ecx
80106ac3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106ac8:	66 89 90 f8 27 11 80 	mov    %dx,-0x7feed808(%eax)
80106acf:	66 89 88 fa 27 11 80 	mov    %cx,-0x7feed806(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ad6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106adb:	31 c9                	xor    %ecx,%ecx
80106add:	66 89 90 00 28 11 80 	mov    %dx,-0x7feed800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ae4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ae9:	66 89 88 02 28 11 80 	mov    %cx,-0x7feed7fe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106af0:	31 c9                	xor    %ecx,%ecx
80106af2:	66 89 90 08 28 11 80 	mov    %dx,-0x7feed7f8(%eax)
80106af9:	66 89 88 0a 28 11 80 	mov    %cx,-0x7feed7f6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b00:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106b05:	31 c9                	xor    %ecx,%ecx
80106b07:	66 89 90 10 28 11 80 	mov    %dx,-0x7feed7f0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b0e:	c6 80 fc 27 11 80 00 	movb   $0x0,-0x7feed804(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106b15:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106b1a:	c6 80 fd 27 11 80 9a 	movb   $0x9a,-0x7feed803(%eax)
80106b21:	c6 80 fe 27 11 80 cf 	movb   $0xcf,-0x7feed802(%eax)
80106b28:	c6 80 ff 27 11 80 00 	movb   $0x0,-0x7feed801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b2f:	c6 80 04 28 11 80 00 	movb   $0x0,-0x7feed7fc(%eax)
80106b36:	c6 80 05 28 11 80 92 	movb   $0x92,-0x7feed7fb(%eax)
80106b3d:	c6 80 06 28 11 80 cf 	movb   $0xcf,-0x7feed7fa(%eax)
80106b44:	c6 80 07 28 11 80 00 	movb   $0x0,-0x7feed7f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b4b:	c6 80 0c 28 11 80 00 	movb   $0x0,-0x7feed7f4(%eax)
80106b52:	c6 80 0d 28 11 80 fa 	movb   $0xfa,-0x7feed7f3(%eax)
80106b59:	c6 80 0e 28 11 80 cf 	movb   $0xcf,-0x7feed7f2(%eax)
80106b60:	c6 80 0f 28 11 80 00 	movb   $0x0,-0x7feed7f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b67:	66 89 88 12 28 11 80 	mov    %cx,-0x7feed7ee(%eax)
80106b6e:	c6 80 14 28 11 80 00 	movb   $0x0,-0x7feed7ec(%eax)
80106b75:	c6 80 15 28 11 80 f2 	movb   $0xf2,-0x7feed7eb(%eax)
80106b7c:	c6 80 16 28 11 80 cf 	movb   $0xcf,-0x7feed7ea(%eax)
80106b83:	c6 80 17 28 11 80 00 	movb   $0x0,-0x7feed7e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106b8a:	05 f0 27 11 80       	add    $0x801127f0,%eax
80106b8f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106b93:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b97:	c1 e8 10             	shr    $0x10,%eax
80106b9a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106b9e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ba1:	0f 01 10             	lgdtl  (%eax)
}
80106ba4:	c9                   	leave  
80106ba5:	c3                   	ret    
80106ba6:	8d 76 00             	lea    0x0(%esi),%esi
80106ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bb0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106bb0:	a1 a4 6d 11 80       	mov    0x80116da4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106bb5:	55                   	push   %ebp
80106bb6:	89 e5                	mov    %esp,%ebp
80106bb8:	05 00 00 00 80       	add    $0x80000000,%eax
80106bbd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106bc0:	5d                   	pop    %ebp
80106bc1:	c3                   	ret    
80106bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bd0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
80106bd4:	56                   	push   %esi
80106bd5:	53                   	push   %ebx
80106bd6:	83 ec 1c             	sub    $0x1c,%esp
80106bd9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106bdc:	85 f6                	test   %esi,%esi
80106bde:	0f 84 cd 00 00 00    	je     80106cb1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106be4:	8b 46 64             	mov    0x64(%esi),%eax
80106be7:	85 c0                	test   %eax,%eax
80106be9:	0f 84 dc 00 00 00    	je     80106ccb <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106bef:	8b 7e 60             	mov    0x60(%esi),%edi
80106bf2:	85 ff                	test   %edi,%edi
80106bf4:	0f 84 c4 00 00 00    	je     80106cbe <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106bfa:	e8 01 d9 ff ff       	call   80104500 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106bff:	e8 0c cb ff ff       	call   80103710 <mycpu>
80106c04:	89 c3                	mov    %eax,%ebx
80106c06:	e8 05 cb ff ff       	call   80103710 <mycpu>
80106c0b:	89 c7                	mov    %eax,%edi
80106c0d:	e8 fe ca ff ff       	call   80103710 <mycpu>
80106c12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c15:	83 c7 08             	add    $0x8,%edi
80106c18:	e8 f3 ca ff ff       	call   80103710 <mycpu>
80106c1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c20:	83 c0 08             	add    $0x8,%eax
80106c23:	ba 67 00 00 00       	mov    $0x67,%edx
80106c28:	c1 e8 18             	shr    $0x18,%eax
80106c2b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106c32:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106c39:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106c40:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106c47:	83 c1 08             	add    $0x8,%ecx
80106c4a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106c50:	c1 e9 10             	shr    $0x10,%ecx
80106c53:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c59:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106c5e:	e8 ad ca ff ff       	call   80103710 <mycpu>
80106c63:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c6a:	e8 a1 ca ff ff       	call   80103710 <mycpu>
80106c6f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106c74:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c78:	e8 93 ca ff ff       	call   80103710 <mycpu>
80106c7d:	8b 56 64             	mov    0x64(%esi),%edx
80106c80:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106c86:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c89:	e8 82 ca ff ff       	call   80103710 <mycpu>
80106c8e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106c92:	b8 28 00 00 00       	mov    $0x28,%eax
80106c97:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c9a:	8b 46 60             	mov    0x60(%esi),%eax
80106c9d:	05 00 00 00 80       	add    $0x80000000,%eax
80106ca2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106ca5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ca8:	5b                   	pop    %ebx
80106ca9:	5e                   	pop    %esi
80106caa:	5f                   	pop    %edi
80106cab:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106cac:	e9 3f d9 ff ff       	jmp    801045f0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106cb1:	83 ec 0c             	sub    $0xc,%esp
80106cb4:	68 5a 7b 10 80       	push   $0x80107b5a
80106cb9:	e8 c2 96 ff ff       	call   80100380 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106cbe:	83 ec 0c             	sub    $0xc,%esp
80106cc1:	68 85 7b 10 80       	push   $0x80107b85
80106cc6:	e8 b5 96 ff ff       	call   80100380 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106ccb:	83 ec 0c             	sub    $0xc,%esp
80106cce:	68 70 7b 10 80       	push   $0x80107b70
80106cd3:	e8 a8 96 ff ff       	call   80100380 <panic>
80106cd8:	90                   	nop
80106cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ce0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	57                   	push   %edi
80106ce4:	56                   	push   %esi
80106ce5:	53                   	push   %ebx
80106ce6:	83 ec 1c             	sub    $0x1c,%esp
80106ce9:	8b 75 10             	mov    0x10(%ebp),%esi
80106cec:	8b 45 08             	mov    0x8(%ebp),%eax
80106cef:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106cf2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106cf8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106cfb:	77 49                	ja     80106d46 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106cfd:	e8 ae b7 ff ff       	call   801024b0 <kalloc>
  memset(mem, 0, PGSIZE);
80106d02:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106d05:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106d07:	68 00 10 00 00       	push   $0x1000
80106d0c:	6a 00                	push   $0x0
80106d0e:	50                   	push   %eax
80106d0f:	e8 9c d9 ff ff       	call   801046b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106d14:	58                   	pop    %eax
80106d15:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d1b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d20:	5a                   	pop    %edx
80106d21:	6a 06                	push   $0x6
80106d23:	50                   	push   %eax
80106d24:	31 d2                	xor    %edx,%edx
80106d26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d29:	e8 52 fc ff ff       	call   80106980 <mappages>
  memmove(mem, init, sz);
80106d2e:	89 75 10             	mov    %esi,0x10(%ebp)
80106d31:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106d34:	83 c4 10             	add    $0x10,%esp
80106d37:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106d3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d3d:	5b                   	pop    %ebx
80106d3e:	5e                   	pop    %esi
80106d3f:	5f                   	pop    %edi
80106d40:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106d41:	e9 1a da ff ff       	jmp    80104760 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106d46:	83 ec 0c             	sub    $0xc,%esp
80106d49:	68 99 7b 10 80       	push   $0x80107b99
80106d4e:	e8 2d 96 ff ff       	call   80100380 <panic>
80106d53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d60 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	57                   	push   %edi
80106d64:	56                   	push   %esi
80106d65:	53                   	push   %ebx
80106d66:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106d69:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106d70:	0f 85 91 00 00 00    	jne    80106e07 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106d76:	8b 75 18             	mov    0x18(%ebp),%esi
80106d79:	31 db                	xor    %ebx,%ebx
80106d7b:	85 f6                	test   %esi,%esi
80106d7d:	75 1a                	jne    80106d99 <loaduvm+0x39>
80106d7f:	eb 6f                	jmp    80106df0 <loaduvm+0x90>
80106d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d88:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d8e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d94:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d97:	76 57                	jbe    80106df0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d99:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d9c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d9f:	31 c9                	xor    %ecx,%ecx
80106da1:	01 da                	add    %ebx,%edx
80106da3:	e8 58 fb ff ff       	call   80106900 <walkpgdir>
80106da8:	85 c0                	test   %eax,%eax
80106daa:	74 4e                	je     80106dfa <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106dac:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106dae:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106db1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106db6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106dbb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106dc1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106dc4:	01 d9                	add    %ebx,%ecx
80106dc6:	05 00 00 00 80       	add    $0x80000000,%eax
80106dcb:	57                   	push   %edi
80106dcc:	51                   	push   %ecx
80106dcd:	50                   	push   %eax
80106dce:	ff 75 10             	pushl  0x10(%ebp)
80106dd1:	e8 8a ab ff ff       	call   80101960 <readi>
80106dd6:	83 c4 10             	add    $0x10,%esp
80106dd9:	39 c7                	cmp    %eax,%edi
80106ddb:	74 ab                	je     80106d88 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106ddd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106de5:	5b                   	pop    %ebx
80106de6:	5e                   	pop    %esi
80106de7:	5f                   	pop    %edi
80106de8:	5d                   	pop    %ebp
80106de9:	c3                   	ret    
80106dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106df0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106df3:	31 c0                	xor    %eax,%eax
}
80106df5:	5b                   	pop    %ebx
80106df6:	5e                   	pop    %esi
80106df7:	5f                   	pop    %edi
80106df8:	5d                   	pop    %ebp
80106df9:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106dfa:	83 ec 0c             	sub    $0xc,%esp
80106dfd:	68 b3 7b 10 80       	push   $0x80107bb3
80106e02:	e8 79 95 ff ff       	call   80100380 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106e07:	83 ec 0c             	sub    $0xc,%esp
80106e0a:	68 54 7c 10 80       	push   $0x80107c54
80106e0f:	e8 6c 95 ff ff       	call   80100380 <panic>
80106e14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e20 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	57                   	push   %edi
80106e24:	56                   	push   %esi
80106e25:	53                   	push   %ebx
80106e26:	83 ec 0c             	sub    $0xc,%esp
80106e29:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106e2c:	85 ff                	test   %edi,%edi
80106e2e:	0f 88 ca 00 00 00    	js     80106efe <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106e34:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106e37:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106e3a:	0f 82 82 00 00 00    	jb     80106ec2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106e40:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106e46:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106e4c:	39 df                	cmp    %ebx,%edi
80106e4e:	77 43                	ja     80106e93 <allocuvm+0x73>
80106e50:	e9 bb 00 00 00       	jmp    80106f10 <allocuvm+0xf0>
80106e55:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106e58:	83 ec 04             	sub    $0x4,%esp
80106e5b:	68 00 10 00 00       	push   $0x1000
80106e60:	6a 00                	push   $0x0
80106e62:	50                   	push   %eax
80106e63:	e8 48 d8 ff ff       	call   801046b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e68:	58                   	pop    %eax
80106e69:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106e6f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e74:	5a                   	pop    %edx
80106e75:	6a 06                	push   $0x6
80106e77:	50                   	push   %eax
80106e78:	89 da                	mov    %ebx,%edx
80106e7a:	8b 45 08             	mov    0x8(%ebp),%eax
80106e7d:	e8 fe fa ff ff       	call   80106980 <mappages>
80106e82:	83 c4 10             	add    $0x10,%esp
80106e85:	85 c0                	test   %eax,%eax
80106e87:	78 47                	js     80106ed0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e89:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e8f:	39 df                	cmp    %ebx,%edi
80106e91:	76 7d                	jbe    80106f10 <allocuvm+0xf0>
    mem = kalloc();
80106e93:	e8 18 b6 ff ff       	call   801024b0 <kalloc>
    if(mem == 0){
80106e98:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e9a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e9c:	75 ba                	jne    80106e58 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106e9e:	83 ec 0c             	sub    $0xc,%esp
80106ea1:	68 d1 7b 10 80       	push   $0x80107bd1
80106ea6:	e8 c5 97 ff ff       	call   80100670 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106eab:	83 c4 10             	add    $0x10,%esp
80106eae:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106eb1:	76 4b                	jbe    80106efe <allocuvm+0xde>
80106eb3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106eb6:	8b 45 08             	mov    0x8(%ebp),%eax
80106eb9:	89 fa                	mov    %edi,%edx
80106ebb:	e8 50 fb ff ff       	call   80106a10 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106ec0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106ec2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ec5:	5b                   	pop    %ebx
80106ec6:	5e                   	pop    %esi
80106ec7:	5f                   	pop    %edi
80106ec8:	5d                   	pop    %ebp
80106ec9:	c3                   	ret    
80106eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106ed0:	83 ec 0c             	sub    $0xc,%esp
80106ed3:	68 e9 7b 10 80       	push   $0x80107be9
80106ed8:	e8 93 97 ff ff       	call   80100670 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106edd:	83 c4 10             	add    $0x10,%esp
80106ee0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ee3:	76 0d                	jbe    80106ef2 <allocuvm+0xd2>
80106ee5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ee8:	8b 45 08             	mov    0x8(%ebp),%eax
80106eeb:	89 fa                	mov    %edi,%edx
80106eed:	e8 1e fb ff ff       	call   80106a10 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106ef2:	83 ec 0c             	sub    $0xc,%esp
80106ef5:	56                   	push   %esi
80106ef6:	e8 05 b4 ff ff       	call   80102300 <kfree>
      return 0;
80106efb:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106efe:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106f01:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106f03:	5b                   	pop    %ebx
80106f04:	5e                   	pop    %esi
80106f05:	5f                   	pop    %edi
80106f06:	5d                   	pop    %ebp
80106f07:	c3                   	ret    
80106f08:	90                   	nop
80106f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f10:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106f13:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106f15:	5b                   	pop    %ebx
80106f16:	5e                   	pop    %esi
80106f17:	5f                   	pop    %edi
80106f18:	5d                   	pop    %ebp
80106f19:	c3                   	ret    
80106f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f20 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106f20:	55                   	push   %ebp
80106f21:	89 e5                	mov    %esp,%ebp
80106f23:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f26:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106f29:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106f2c:	39 d1                	cmp    %edx,%ecx
80106f2e:	73 10                	jae    80106f40 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106f30:	5d                   	pop    %ebp
80106f31:	e9 da fa ff ff       	jmp    80106a10 <deallocuvm.part.0>
80106f36:	8d 76 00             	lea    0x0(%esi),%esi
80106f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106f40:	89 d0                	mov    %edx,%eax
80106f42:	5d                   	pop    %ebp
80106f43:	c3                   	ret    
80106f44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f50 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106f50:	55                   	push   %ebp
80106f51:	89 e5                	mov    %esp,%ebp
80106f53:	57                   	push   %edi
80106f54:	56                   	push   %esi
80106f55:	53                   	push   %ebx
80106f56:	83 ec 0c             	sub    $0xc,%esp
80106f59:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106f5c:	85 f6                	test   %esi,%esi
80106f5e:	74 59                	je     80106fb9 <freevm+0x69>
80106f60:	31 c9                	xor    %ecx,%ecx
80106f62:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106f67:	89 f0                	mov    %esi,%eax
80106f69:	e8 a2 fa ff ff       	call   80106a10 <deallocuvm.part.0>
80106f6e:	89 f3                	mov    %esi,%ebx
80106f70:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f76:	eb 0f                	jmp    80106f87 <freevm+0x37>
80106f78:	90                   	nop
80106f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f80:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f83:	39 fb                	cmp    %edi,%ebx
80106f85:	74 23                	je     80106faa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f87:	8b 03                	mov    (%ebx),%eax
80106f89:	a8 01                	test   $0x1,%al
80106f8b:	74 f3                	je     80106f80 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106f8d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f92:	83 ec 0c             	sub    $0xc,%esp
80106f95:	83 c3 04             	add    $0x4,%ebx
80106f98:	05 00 00 00 80       	add    $0x80000000,%eax
80106f9d:	50                   	push   %eax
80106f9e:	e8 5d b3 ff ff       	call   80102300 <kfree>
80106fa3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106fa6:	39 fb                	cmp    %edi,%ebx
80106fa8:	75 dd                	jne    80106f87 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106faa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106fad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fb0:	5b                   	pop    %ebx
80106fb1:	5e                   	pop    %esi
80106fb2:	5f                   	pop    %edi
80106fb3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106fb4:	e9 47 b3 ff ff       	jmp    80102300 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106fb9:	83 ec 0c             	sub    $0xc,%esp
80106fbc:	68 05 7c 10 80       	push   $0x80107c05
80106fc1:	e8 ba 93 ff ff       	call   80100380 <panic>
80106fc6:	8d 76 00             	lea    0x0(%esi),%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fd0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	56                   	push   %esi
80106fd4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106fd5:	e8 d6 b4 ff ff       	call   801024b0 <kalloc>
80106fda:	85 c0                	test   %eax,%eax
80106fdc:	74 6a                	je     80107048 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106fde:	83 ec 04             	sub    $0x4,%esp
80106fe1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106fe3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106fe8:	68 00 10 00 00       	push   $0x1000
80106fed:	6a 00                	push   $0x0
80106fef:	50                   	push   %eax
80106ff0:	e8 bb d6 ff ff       	call   801046b0 <memset>
80106ff5:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ff8:	8b 43 04             	mov    0x4(%ebx),%eax
80106ffb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ffe:	83 ec 08             	sub    $0x8,%esp
80107001:	8b 13                	mov    (%ebx),%edx
80107003:	ff 73 0c             	pushl  0xc(%ebx)
80107006:	50                   	push   %eax
80107007:	29 c1                	sub    %eax,%ecx
80107009:	89 f0                	mov    %esi,%eax
8010700b:	e8 70 f9 ff ff       	call   80106980 <mappages>
80107010:	83 c4 10             	add    $0x10,%esp
80107013:	85 c0                	test   %eax,%eax
80107015:	78 19                	js     80107030 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107017:	83 c3 10             	add    $0x10,%ebx
8010701a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107020:	75 d6                	jne    80106ff8 <setupkvm+0x28>
80107022:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80107024:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107027:	5b                   	pop    %ebx
80107028:	5e                   	pop    %esi
80107029:	5d                   	pop    %ebp
8010702a:	c3                   	ret    
8010702b:	90                   	nop
8010702c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80107030:	83 ec 0c             	sub    $0xc,%esp
80107033:	56                   	push   %esi
80107034:	e8 17 ff ff ff       	call   80106f50 <freevm>
      return 0;
80107039:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
8010703c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
8010703f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80107041:	5b                   	pop    %ebx
80107042:	5e                   	pop    %esi
80107043:	5d                   	pop    %ebp
80107044:	c3                   	ret    
80107045:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107048:	31 c0                	xor    %eax,%eax
8010704a:	eb d8                	jmp    80107024 <setupkvm+0x54>
8010704c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107050 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107056:	e8 75 ff ff ff       	call   80106fd0 <setupkvm>
8010705b:	a3 a4 6d 11 80       	mov    %eax,0x80116da4
80107060:	05 00 00 00 80       	add    $0x80000000,%eax
80107065:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107068:	c9                   	leave  
80107069:	c3                   	ret    
8010706a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107070 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107070:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107071:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107073:	89 e5                	mov    %esp,%ebp
80107075:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107078:	8b 55 0c             	mov    0xc(%ebp),%edx
8010707b:	8b 45 08             	mov    0x8(%ebp),%eax
8010707e:	e8 7d f8 ff ff       	call   80106900 <walkpgdir>
  if(pte == 0)
80107083:	85 c0                	test   %eax,%eax
80107085:	74 05                	je     8010708c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107087:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010708a:	c9                   	leave  
8010708b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010708c:	83 ec 0c             	sub    $0xc,%esp
8010708f:	68 16 7c 10 80       	push   $0x80107c16
80107094:	e8 e7 92 ff ff       	call   80100380 <panic>
80107099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801070a0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	57                   	push   %edi
801070a4:	56                   	push   %esi
801070a5:	53                   	push   %ebx
801070a6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801070a9:	e8 22 ff ff ff       	call   80106fd0 <setupkvm>
801070ae:	85 c0                	test   %eax,%eax
801070b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801070b3:	0f 84 b2 00 00 00    	je     8010716b <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801070b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801070bc:	85 c9                	test   %ecx,%ecx
801070be:	0f 84 9c 00 00 00    	je     80107160 <copyuvm+0xc0>
801070c4:	31 f6                	xor    %esi,%esi
801070c6:	eb 4a                	jmp    80107112 <copyuvm+0x72>
801070c8:	90                   	nop
801070c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801070d0:	83 ec 04             	sub    $0x4,%esp
801070d3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801070d9:	68 00 10 00 00       	push   $0x1000
801070de:	57                   	push   %edi
801070df:	50                   	push   %eax
801070e0:	e8 7b d6 ff ff       	call   80104760 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801070e5:	58                   	pop    %eax
801070e6:	5a                   	pop    %edx
801070e7:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
801070ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070f0:	ff 75 e4             	pushl  -0x1c(%ebp)
801070f3:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070f8:	52                   	push   %edx
801070f9:	89 f2                	mov    %esi,%edx
801070fb:	e8 80 f8 ff ff       	call   80106980 <mappages>
80107100:	83 c4 10             	add    $0x10,%esp
80107103:	85 c0                	test   %eax,%eax
80107105:	78 3e                	js     80107145 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107107:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010710d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107110:	76 4e                	jbe    80107160 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107112:	8b 45 08             	mov    0x8(%ebp),%eax
80107115:	31 c9                	xor    %ecx,%ecx
80107117:	89 f2                	mov    %esi,%edx
80107119:	e8 e2 f7 ff ff       	call   80106900 <walkpgdir>
8010711e:	85 c0                	test   %eax,%eax
80107120:	74 5a                	je     8010717c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107122:	8b 18                	mov    (%eax),%ebx
80107124:	f6 c3 01             	test   $0x1,%bl
80107127:	74 46                	je     8010716f <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107129:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010712b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80107131:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107134:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
8010713a:	e8 71 b3 ff ff       	call   801024b0 <kalloc>
8010713f:	85 c0                	test   %eax,%eax
80107141:	89 c3                	mov    %eax,%ebx
80107143:	75 8b                	jne    801070d0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107145:	83 ec 0c             	sub    $0xc,%esp
80107148:	ff 75 e0             	pushl  -0x20(%ebp)
8010714b:	e8 00 fe ff ff       	call   80106f50 <freevm>
  return 0;
80107150:	83 c4 10             	add    $0x10,%esp
80107153:	31 c0                	xor    %eax,%eax
}
80107155:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107158:	5b                   	pop    %ebx
80107159:	5e                   	pop    %esi
8010715a:	5f                   	pop    %edi
8010715b:	5d                   	pop    %ebp
8010715c:	c3                   	ret    
8010715d:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107160:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107163:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107166:	5b                   	pop    %ebx
80107167:	5e                   	pop    %esi
80107168:	5f                   	pop    %edi
80107169:	5d                   	pop    %ebp
8010716a:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010716b:	31 c0                	xor    %eax,%eax
8010716d:	eb e6                	jmp    80107155 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
8010716f:	83 ec 0c             	sub    $0xc,%esp
80107172:	68 3a 7c 10 80       	push   $0x80107c3a
80107177:	e8 04 92 ff ff       	call   80100380 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010717c:	83 ec 0c             	sub    $0xc,%esp
8010717f:	68 20 7c 10 80       	push   $0x80107c20
80107184:	e8 f7 91 ff ff       	call   80100380 <panic>
80107189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107190 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107190:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107191:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107193:	89 e5                	mov    %esp,%ebp
80107195:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107198:	8b 55 0c             	mov    0xc(%ebp),%edx
8010719b:	8b 45 08             	mov    0x8(%ebp),%eax
8010719e:	e8 5d f7 ff ff       	call   80106900 <walkpgdir>
  if((*pte & PTE_P) == 0)
801071a3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801071a5:	89 c2                	mov    %eax,%edx
801071a7:	83 e2 05             	and    $0x5,%edx
801071aa:	83 fa 05             	cmp    $0x5,%edx
801071ad:	75 11                	jne    801071c0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801071af:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
801071b4:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801071b5:	05 00 00 00 80       	add    $0x80000000,%eax
}
801071ba:	c3                   	ret    
801071bb:	90                   	nop
801071bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801071c0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801071c2:	c9                   	leave  
801071c3:	c3                   	ret    
801071c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801071ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801071d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801071d0:	55                   	push   %ebp
801071d1:	89 e5                	mov    %esp,%ebp
801071d3:	57                   	push   %edi
801071d4:	56                   	push   %esi
801071d5:	53                   	push   %ebx
801071d6:	83 ec 1c             	sub    $0x1c,%esp
801071d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801071dc:	8b 55 0c             	mov    0xc(%ebp),%edx
801071df:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801071e2:	85 db                	test   %ebx,%ebx
801071e4:	75 40                	jne    80107226 <copyout+0x56>
801071e6:	eb 70                	jmp    80107258 <copyout+0x88>
801071e8:	90                   	nop
801071e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801071f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801071f3:	89 f1                	mov    %esi,%ecx
801071f5:	29 d1                	sub    %edx,%ecx
801071f7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801071fd:	39 d9                	cmp    %ebx,%ecx
801071ff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107202:	29 f2                	sub    %esi,%edx
80107204:	83 ec 04             	sub    $0x4,%esp
80107207:	01 d0                	add    %edx,%eax
80107209:	51                   	push   %ecx
8010720a:	57                   	push   %edi
8010720b:	50                   	push   %eax
8010720c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010720f:	e8 4c d5 ff ff       	call   80104760 <memmove>
    len -= n;
    buf += n;
80107214:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107217:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010721a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107220:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107222:	29 cb                	sub    %ecx,%ebx
80107224:	74 32                	je     80107258 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107226:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107228:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010722b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010722e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107234:	56                   	push   %esi
80107235:	ff 75 08             	pushl  0x8(%ebp)
80107238:	e8 53 ff ff ff       	call   80107190 <uva2ka>
    if(pa0 == 0)
8010723d:	83 c4 10             	add    $0x10,%esp
80107240:	85 c0                	test   %eax,%eax
80107242:	75 ac                	jne    801071f0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107244:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107247:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010724c:	5b                   	pop    %ebx
8010724d:	5e                   	pop    %esi
8010724e:	5f                   	pop    %edi
8010724f:	5d                   	pop    %ebp
80107250:	c3                   	ret    
80107251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107258:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010725b:	31 c0                	xor    %eax,%eax
}
8010725d:	5b                   	pop    %ebx
8010725e:	5e                   	pop    %esi
8010725f:	5f                   	pop    %edi
80107260:	5d                   	pop    %ebp
80107261:	c3                   	ret    
