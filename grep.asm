
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  19:	83 f8 01             	cmp    $0x1,%eax
  }
}

int
main(int argc, char *argv[])
{
  1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1f:	0f 8e 8d 00 00 00    	jle    b2 <main+0xb2>
    printf(2, "usage: grep pattern [file ...]\n");
    exit(1);
  }
  pattern = argv[1];
  25:	8b 43 04             	mov    0x4(%ebx),%eax
  28:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  2b:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  2f:	be 02 00 00 00       	mov    $0x2,%esi

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    exit(1);
  }
  pattern = argv[1];
  34:	89 45 e0             	mov    %eax,-0x20(%ebp)

  if(argc <= 2){
  37:	74 63                	je     9c <main+0x9c>
  39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    grep(pattern, 0);
    exit(0);
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  40:	83 ec 08             	sub    $0x8,%esp
  43:	6a 00                	push   $0x0
  45:	ff 33                	pushl  (%ebx)
  47:	e8 76 05 00 00       	call   5c2 <open>
  4c:	83 c4 10             	add    $0x10,%esp
  4f:	85 c0                	test   %eax,%eax
  51:	89 c7                	mov    %eax,%edi
  53:	78 2c                	js     81 <main+0x81>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit(1);
    }
    grep(pattern, fd);
  55:	83 ec 08             	sub    $0x8,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit(0);
  }

  for(i = 2; i < argc; i++){
  58:	83 c6 01             	add    $0x1,%esi
  5b:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit(1);
    }
    grep(pattern, fd);
  5e:	50                   	push   %eax
  5f:	ff 75 e0             	pushl  -0x20(%ebp)
  62:	e8 d9 01 00 00       	call   240 <grep>
    close(fd);
  67:	89 3c 24             	mov    %edi,(%esp)
  6a:	e8 3b 05 00 00       	call   5aa <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit(0);
  }

  for(i = 2; i < argc; i++){
  6f:	83 c4 10             	add    $0x10,%esp
  72:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  75:	7f c9                	jg     40 <main+0x40>
      exit(1);
    }
    grep(pattern, fd);
    close(fd);
  }
  exit(0);
  77:	83 ec 0c             	sub    $0xc,%esp
  7a:	6a 00                	push   $0x0
  7c:	e8 01 05 00 00       	call   582 <exit>
    exit(0);
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
  81:	50                   	push   %eax
  82:	ff 33                	pushl  (%ebx)
  84:	68 20 0a 00 00       	push   $0xa20
  89:	6a 01                	push   $0x1
  8b:	e8 50 06 00 00       	call   6e0 <printf>
      exit(1);
  90:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  97:	e8 e6 04 00 00       	call   582 <exit>
    exit(1);
  }
  pattern = argv[1];

  if(argc <= 2){
    grep(pattern, 0);
  9c:	52                   	push   %edx
  9d:	52                   	push   %edx
  9e:	6a 00                	push   $0x0
  a0:	50                   	push   %eax
  a1:	e8 9a 01 00 00       	call   240 <grep>
    exit(0);
  a6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  ad:	e8 d0 04 00 00       	call   582 <exit>
{
  int fd, i;
  char *pattern;

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
  b2:	51                   	push   %ecx
  b3:	51                   	push   %ecx
  b4:	68 00 0a 00 00       	push   $0xa00
  b9:	6a 02                	push   $0x2
  bb:	e8 20 06 00 00       	call   6e0 <printf>
    exit(1);
  c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c7:	e8 b6 04 00 00       	call   582 <exit>
  cc:	66 90                	xchg   %ax,%ax
  ce:	66 90                	xchg   %ax,%ax

000000d0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	57                   	push   %edi
  d4:	56                   	push   %esi
  d5:	53                   	push   %ebx
  d6:	83 ec 0c             	sub    $0xc,%esp
  d9:	8b 75 08             	mov    0x8(%ebp),%esi
  dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  df:	8b 5d 10             	mov    0x10(%ebp),%ebx
  e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  e8:	83 ec 08             	sub    $0x8,%esp
  eb:	53                   	push   %ebx
  ec:	57                   	push   %edi
  ed:	e8 3e 00 00 00       	call   130 <matchhere>
  f2:	83 c4 10             	add    $0x10,%esp
  f5:	85 c0                	test   %eax,%eax
  f7:	75 1f                	jne    118 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  f9:	0f be 13             	movsbl (%ebx),%edx
  fc:	84 d2                	test   %dl,%dl
  fe:	74 0c                	je     10c <matchstar+0x3c>
 100:	83 c3 01             	add    $0x1,%ebx
 103:	83 fe 2e             	cmp    $0x2e,%esi
 106:	74 e0                	je     e8 <matchstar+0x18>
 108:	39 f2                	cmp    %esi,%edx
 10a:	74 dc                	je     e8 <matchstar+0x18>
  return 0;
}
 10c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 10f:	5b                   	pop    %ebx
 110:	5e                   	pop    %esi
 111:	5f                   	pop    %edi
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 118:	8d 65 f4             	lea    -0xc(%ebp),%esp
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
 11b:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
 120:	5b                   	pop    %ebx
 121:	5e                   	pop    %esi
 122:	5f                   	pop    %edi
 123:	5d                   	pop    %ebp
 124:	c3                   	ret    
 125:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	56                   	push   %esi
 135:	53                   	push   %ebx
 136:	83 ec 0c             	sub    $0xc,%esp
 139:	8b 45 08             	mov    0x8(%ebp),%eax
 13c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
 13f:	0f b6 18             	movzbl (%eax),%ebx
 142:	84 db                	test   %bl,%bl
 144:	74 63                	je     1a9 <matchhere+0x79>
    return 1;
  if(re[1] == '*')
 146:	0f be 50 01          	movsbl 0x1(%eax),%edx
 14a:	80 fa 2a             	cmp    $0x2a,%dl
 14d:	74 7b                	je     1ca <matchhere+0x9a>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 14f:	80 fb 24             	cmp    $0x24,%bl
 152:	75 08                	jne    15c <matchhere+0x2c>
 154:	84 d2                	test   %dl,%dl
 156:	0f 84 8a 00 00 00    	je     1e6 <matchhere+0xb6>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 15c:	0f b6 37             	movzbl (%edi),%esi
 15f:	89 f1                	mov    %esi,%ecx
 161:	84 c9                	test   %cl,%cl
 163:	74 5b                	je     1c0 <matchhere+0x90>
 165:	38 cb                	cmp    %cl,%bl
 167:	74 05                	je     16e <matchhere+0x3e>
 169:	80 fb 2e             	cmp    $0x2e,%bl
 16c:	75 52                	jne    1c0 <matchhere+0x90>
    return matchhere(re+1, text+1);
 16e:	83 c7 01             	add    $0x1,%edi
 171:	83 c0 01             	add    $0x1,%eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 174:	84 d2                	test   %dl,%dl
 176:	74 31                	je     1a9 <matchhere+0x79>
    return 1;
  if(re[1] == '*')
 178:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
 17c:	80 fb 2a             	cmp    $0x2a,%bl
 17f:	74 4c                	je     1cd <matchhere+0x9d>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 181:	80 fa 24             	cmp    $0x24,%dl
 184:	75 04                	jne    18a <matchhere+0x5a>
 186:	84 db                	test   %bl,%bl
 188:	74 5c                	je     1e6 <matchhere+0xb6>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 18a:	0f b6 37             	movzbl (%edi),%esi
 18d:	89 f1                	mov    %esi,%ecx
 18f:	84 c9                	test   %cl,%cl
 191:	74 2d                	je     1c0 <matchhere+0x90>
 193:	80 fa 2e             	cmp    $0x2e,%dl
 196:	74 04                	je     19c <matchhere+0x6c>
 198:	38 d1                	cmp    %dl,%cl
 19a:	75 24                	jne    1c0 <matchhere+0x90>
 19c:	0f be d3             	movsbl %bl,%edx
    return matchhere(re+1, text+1);
 19f:	83 c7 01             	add    $0x1,%edi
 1a2:	83 c0 01             	add    $0x1,%eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 1a5:	84 d2                	test   %dl,%dl
 1a7:	75 cf                	jne    178 <matchhere+0x48>
    return 1;
 1a9:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 1ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b1:	5b                   	pop    %ebx
 1b2:	5e                   	pop    %esi
 1b3:	5f                   	pop    %edi
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    
 1b6:	8d 76 00             	lea    0x0(%esi),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 1c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
 1c3:	31 c0                	xor    %eax,%eax
}
 1c5:	5b                   	pop    %ebx
 1c6:	5e                   	pop    %esi
 1c7:	5f                   	pop    %edi
 1c8:	5d                   	pop    %ebp
 1c9:	c3                   	ret    
// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
 1ca:	0f be d3             	movsbl %bl,%edx
    return matchstar(re[0], re+2, text);
 1cd:	83 ec 04             	sub    $0x4,%esp
 1d0:	83 c0 02             	add    $0x2,%eax
 1d3:	57                   	push   %edi
 1d4:	50                   	push   %eax
 1d5:	52                   	push   %edx
 1d6:	e8 f5 fe ff ff       	call   d0 <matchstar>
 1db:	83 c4 10             	add    $0x10,%esp
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 1de:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e1:	5b                   	pop    %ebx
 1e2:	5e                   	pop    %esi
 1e3:	5f                   	pop    %edi
 1e4:	5d                   	pop    %ebp
 1e5:	c3                   	ret    
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
 1e6:	31 c0                	xor    %eax,%eax
 1e8:	80 3f 00             	cmpb   $0x0,(%edi)
 1eb:	0f 94 c0             	sete   %al
 1ee:	eb be                	jmp    1ae <matchhere+0x7e>

000001f0 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
 1f5:	8b 75 08             	mov    0x8(%ebp),%esi
 1f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1fb:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1fe:	75 11                	jne    211 <match+0x21>
 200:	eb 2c                	jmp    22e <match+0x3e>
 202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
 208:	83 c3 01             	add    $0x1,%ebx
 20b:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 20f:	74 16                	je     227 <match+0x37>
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
 211:	83 ec 08             	sub    $0x8,%esp
 214:	53                   	push   %ebx
 215:	56                   	push   %esi
 216:	e8 15 ff ff ff       	call   130 <matchhere>
 21b:	83 c4 10             	add    $0x10,%esp
 21e:	85 c0                	test   %eax,%eax
 220:	74 e6                	je     208 <match+0x18>
      return 1;
 222:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 227:	8d 65 f8             	lea    -0x8(%ebp),%esp
 22a:	5b                   	pop    %ebx
 22b:	5e                   	pop    %esi
 22c:	5d                   	pop    %ebp
 22d:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 22e:	83 c6 01             	add    $0x1,%esi
 231:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
 234:	8d 65 f8             	lea    -0x8(%ebp),%esp
 237:	5b                   	pop    %ebx
 238:	5e                   	pop    %esi
 239:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 23a:	e9 f1 fe ff ff       	jmp    130 <matchhere>
 23f:	90                   	nop

00000240 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
 245:	53                   	push   %ebx
 246:	83 ec 1c             	sub    $0x1c,%esp
 249:	8b 75 08             	mov    0x8(%ebp),%esi
  int n, m;
  char *p, *q;

  m = 0;
 24c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 253:	90                   	nop
 254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 258:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 25b:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 260:	83 ec 04             	sub    $0x4,%esp
 263:	29 c8                	sub    %ecx,%eax
 265:	50                   	push   %eax
 266:	8d 81 00 0e 00 00    	lea    0xe00(%ecx),%eax
 26c:	50                   	push   %eax
 26d:	ff 75 0c             	pushl  0xc(%ebp)
 270:	e8 25 03 00 00       	call   59a <read>
 275:	83 c4 10             	add    $0x10,%esp
 278:	85 c0                	test   %eax,%eax
 27a:	0f 8e ac 00 00 00    	jle    32c <grep+0xec>
    m += n;
 280:	01 45 e4             	add    %eax,-0x1c(%ebp)
    buf[m] = '\0';
    p = buf;
 283:	bb 00 0e 00 00       	mov    $0xe00,%ebx
  int n, m;
  char *p, *q;

  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
 288:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 28b:	c6 82 00 0e 00 00 00 	movb   $0x0,0xe00(%edx)
 292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    p = buf;
    while((q = strchr(p, '\n')) != 0){
 298:	83 ec 08             	sub    $0x8,%esp
 29b:	6a 0a                	push   $0xa
 29d:	53                   	push   %ebx
 29e:	e8 6d 01 00 00       	call   410 <strchr>
 2a3:	83 c4 10             	add    $0x10,%esp
 2a6:	85 c0                	test   %eax,%eax
 2a8:	89 c7                	mov    %eax,%edi
 2aa:	74 3c                	je     2e8 <grep+0xa8>
      *q = 0;
      if(match(pattern, p)){
 2ac:	83 ec 08             	sub    $0x8,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
      *q = 0;
 2af:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 2b2:	53                   	push   %ebx
 2b3:	56                   	push   %esi
 2b4:	e8 37 ff ff ff       	call   1f0 <match>
 2b9:	83 c4 10             	add    $0x10,%esp
 2bc:	85 c0                	test   %eax,%eax
 2be:	75 08                	jne    2c8 <grep+0x88>
 2c0:	8d 5f 01             	lea    0x1(%edi),%ebx
 2c3:	eb d3                	jmp    298 <grep+0x58>
 2c5:	8d 76 00             	lea    0x0(%esi),%esi
        *q = '\n';
 2c8:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 2cb:	83 c7 01             	add    $0x1,%edi
 2ce:	83 ec 04             	sub    $0x4,%esp
 2d1:	89 f8                	mov    %edi,%eax
 2d3:	29 d8                	sub    %ebx,%eax
 2d5:	50                   	push   %eax
 2d6:	53                   	push   %ebx
 2d7:	89 fb                	mov    %edi,%ebx
 2d9:	6a 01                	push   $0x1
 2db:	e8 c2 02 00 00       	call   5a2 <write>
 2e0:	83 c4 10             	add    $0x10,%esp
 2e3:	eb b3                	jmp    298 <grep+0x58>
 2e5:	8d 76 00             	lea    0x0(%esi),%esi
      }
      p = q+1;
    }
    if(p == buf)
 2e8:	81 fb 00 0e 00 00    	cmp    $0xe00,%ebx
 2ee:	74 30                	je     320 <grep+0xe0>
      m = 0;
    if(m > 0){
 2f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2f3:	85 c0                	test   %eax,%eax
 2f5:	0f 8e 5d ff ff ff    	jle    258 <grep+0x18>
      m -= p - buf;
 2fb:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2fd:	83 ec 04             	sub    $0x4,%esp
      p = q+1;
    }
    if(p == buf)
      m = 0;
    if(m > 0){
      m -= p - buf;
 300:	2d 00 0e 00 00       	sub    $0xe00,%eax
 305:	29 45 e4             	sub    %eax,-0x1c(%ebp)
 308:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      memmove(buf, p, m);
 30b:	51                   	push   %ecx
 30c:	53                   	push   %ebx
 30d:	68 00 0e 00 00       	push   $0xe00
 312:	e8 39 02 00 00       	call   550 <memmove>
 317:	83 c4 10             	add    $0x10,%esp
 31a:	e9 39 ff ff ff       	jmp    258 <grep+0x18>
 31f:	90                   	nop
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 320:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 327:	e9 2c ff ff ff       	jmp    258 <grep+0x18>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 32c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 32f:	5b                   	pop    %ebx
 330:	5e                   	pop    %esi
 331:	5f                   	pop    %edi
 332:	5d                   	pop    %ebp
 333:	c3                   	ret    
 334:	66 90                	xchg   %ax,%ax
 336:	66 90                	xchg   %ax,%ax
 338:	66 90                	xchg   %ax,%ax
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 45 08             	mov    0x8(%ebp),%eax
 347:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 34a:	89 c2                	mov    %eax,%edx
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 350:	83 c1 01             	add    $0x1,%ecx
 353:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 357:	83 c2 01             	add    $0x1,%edx
 35a:	84 db                	test   %bl,%bl
 35c:	88 5a ff             	mov    %bl,-0x1(%edx)
 35f:	75 ef                	jne    350 <strcpy+0x10>
    ;
  return os;
}
 361:	5b                   	pop    %ebx
 362:	5d                   	pop    %ebp
 363:	c3                   	ret    
 364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 36a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	56                   	push   %esi
 374:	53                   	push   %ebx
 375:	8b 55 08             	mov    0x8(%ebp),%edx
 378:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 37b:	0f b6 02             	movzbl (%edx),%eax
 37e:	0f b6 19             	movzbl (%ecx),%ebx
 381:	84 c0                	test   %al,%al
 383:	75 1e                	jne    3a3 <strcmp+0x33>
 385:	eb 29                	jmp    3b0 <strcmp+0x40>
 387:	89 f6                	mov    %esi,%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 390:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 393:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 396:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 399:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 39d:	84 c0                	test   %al,%al
 39f:	74 0f                	je     3b0 <strcmp+0x40>
 3a1:	89 f1                	mov    %esi,%ecx
 3a3:	38 d8                	cmp    %bl,%al
 3a5:	74 e9                	je     390 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3a7:	29 d8                	sub    %ebx,%eax
}
 3a9:	5b                   	pop    %ebx
 3aa:	5e                   	pop    %esi
 3ab:	5d                   	pop    %ebp
 3ac:	c3                   	ret    
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3b0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3b2:	29 d8                	sub    %ebx,%eax
}
 3b4:	5b                   	pop    %ebx
 3b5:	5e                   	pop    %esi
 3b6:	5d                   	pop    %ebp
 3b7:	c3                   	ret    
 3b8:	90                   	nop
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003c0 <strlen>:

uint
strlen(char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3c6:	80 39 00             	cmpb   $0x0,(%ecx)
 3c9:	74 12                	je     3dd <strlen+0x1d>
 3cb:	31 d2                	xor    %edx,%edx
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	83 c2 01             	add    $0x1,%edx
 3d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3d7:	89 d0                	mov    %edx,%eax
 3d9:	75 f5                	jne    3d0 <strlen+0x10>
    ;
  return n;
}
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 3dd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 3df:	5d                   	pop    %ebp
 3e0:	c3                   	ret    
 3e1:	eb 0d                	jmp    3f0 <memset>
 3e3:	90                   	nop
 3e4:	90                   	nop
 3e5:	90                   	nop
 3e6:	90                   	nop
 3e7:	90                   	nop
 3e8:	90                   	nop
 3e9:	90                   	nop
 3ea:	90                   	nop
 3eb:	90                   	nop
 3ec:	90                   	nop
 3ed:	90                   	nop
 3ee:	90                   	nop
 3ef:	90                   	nop

000003f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fd:	89 d7                	mov    %edx,%edi
 3ff:	fc                   	cld    
 400:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 402:	89 d0                	mov    %edx,%eax
 404:	5f                   	pop    %edi
 405:	5d                   	pop    %ebp
 406:	c3                   	ret    
 407:	89 f6                	mov    %esi,%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <strchr>:

char*
strchr(const char *s, char c)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	53                   	push   %ebx
 414:	8b 45 08             	mov    0x8(%ebp),%eax
 417:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 41a:	0f b6 10             	movzbl (%eax),%edx
 41d:	84 d2                	test   %dl,%dl
 41f:	74 1d                	je     43e <strchr+0x2e>
    if(*s == c)
 421:	38 d3                	cmp    %dl,%bl
 423:	89 d9                	mov    %ebx,%ecx
 425:	75 0d                	jne    434 <strchr+0x24>
 427:	eb 17                	jmp    440 <strchr+0x30>
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 430:	38 ca                	cmp    %cl,%dl
 432:	74 0c                	je     440 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 434:	83 c0 01             	add    $0x1,%eax
 437:	0f b6 10             	movzbl (%eax),%edx
 43a:	84 d2                	test   %dl,%dl
 43c:	75 f2                	jne    430 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 43e:	31 c0                	xor    %eax,%eax
}
 440:	5b                   	pop    %ebx
 441:	5d                   	pop    %ebp
 442:	c3                   	ret    
 443:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <gets>:

char*
gets(char *buf, int max)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 456:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 458:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 45b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 45e:	eb 29                	jmp    489 <gets+0x39>
    cc = read(0, &c, 1);
 460:	83 ec 04             	sub    $0x4,%esp
 463:	6a 01                	push   $0x1
 465:	57                   	push   %edi
 466:	6a 00                	push   $0x0
 468:	e8 2d 01 00 00       	call   59a <read>
    if(cc < 1)
 46d:	83 c4 10             	add    $0x10,%esp
 470:	85 c0                	test   %eax,%eax
 472:	7e 1d                	jle    491 <gets+0x41>
      break;
    buf[i++] = c;
 474:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 478:	8b 55 08             	mov    0x8(%ebp),%edx
 47b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 47d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 47f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 483:	74 1b                	je     4a0 <gets+0x50>
 485:	3c 0d                	cmp    $0xd,%al
 487:	74 17                	je     4a0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 489:	8d 5e 01             	lea    0x1(%esi),%ebx
 48c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 48f:	7c cf                	jl     460 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 491:	8b 45 08             	mov    0x8(%ebp),%eax
 494:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 498:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49b:	5b                   	pop    %ebx
 49c:	5e                   	pop    %esi
 49d:	5f                   	pop    %edi
 49e:	5d                   	pop    %ebp
 49f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4a0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4a3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ac:	5b                   	pop    %ebx
 4ad:	5e                   	pop    %esi
 4ae:	5f                   	pop    %edi
 4af:	5d                   	pop    %ebp
 4b0:	c3                   	ret    
 4b1:	eb 0d                	jmp    4c0 <stat>
 4b3:	90                   	nop
 4b4:	90                   	nop
 4b5:	90                   	nop
 4b6:	90                   	nop
 4b7:	90                   	nop
 4b8:	90                   	nop
 4b9:	90                   	nop
 4ba:	90                   	nop
 4bb:	90                   	nop
 4bc:	90                   	nop
 4bd:	90                   	nop
 4be:	90                   	nop
 4bf:	90                   	nop

000004c0 <stat>:

int
stat(char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c5:	83 ec 08             	sub    $0x8,%esp
 4c8:	6a 00                	push   $0x0
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 f0 00 00 00       	call   5c2 <open>
  if(fd < 0)
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	85 c0                	test   %eax,%eax
 4d7:	78 27                	js     500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4d9:	83 ec 08             	sub    $0x8,%esp
 4dc:	ff 75 0c             	pushl  0xc(%ebp)
 4df:	89 c3                	mov    %eax,%ebx
 4e1:	50                   	push   %eax
 4e2:	e8 f3 00 00 00       	call   5da <fstat>
 4e7:	89 c6                	mov    %eax,%esi
  close(fd);
 4e9:	89 1c 24             	mov    %ebx,(%esp)
 4ec:	e8 b9 00 00 00       	call   5aa <close>
  return r;
 4f1:	83 c4 10             	add    $0x10,%esp
 4f4:	89 f0                	mov    %esi,%eax
}
 4f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4f9:	5b                   	pop    %ebx
 4fa:	5e                   	pop    %esi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 505:	eb ef                	jmp    4f6 <stat+0x36>
 507:	89 f6                	mov    %esi,%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000510 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 517:	0f be 11             	movsbl (%ecx),%edx
 51a:	8d 42 d0             	lea    -0x30(%edx),%eax
 51d:	3c 09                	cmp    $0x9,%al
 51f:	b8 00 00 00 00       	mov    $0x0,%eax
 524:	77 1f                	ja     545 <atoi+0x35>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 530:	8d 04 80             	lea    (%eax,%eax,4),%eax
 533:	83 c1 01             	add    $0x1,%ecx
 536:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 53a:	0f be 11             	movsbl (%ecx),%edx
 53d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 540:	80 fb 09             	cmp    $0x9,%bl
 543:	76 eb                	jbe    530 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 545:	5b                   	pop    %ebx
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000550 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	53                   	push   %ebx
 555:	8b 5d 10             	mov    0x10(%ebp),%ebx
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 db                	test   %ebx,%ebx
 560:	7e 14                	jle    576 <memmove+0x26>
 562:	31 d2                	xor    %edx,%edx
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 568:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 56c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 56f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 572:	39 da                	cmp    %ebx,%edx
 574:	75 f2                	jne    568 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5d                   	pop    %ebp
 579:	c3                   	ret    

0000057a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 57a:	b8 01 00 00 00       	mov    $0x1,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <exit>:
SYSCALL(exit)
 582:	b8 02 00 00 00       	mov    $0x2,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <wait>:
SYSCALL(wait)
 58a:	b8 03 00 00 00       	mov    $0x3,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <pipe>:
SYSCALL(pipe)
 592:	b8 04 00 00 00       	mov    $0x4,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <read>:
SYSCALL(read)
 59a:	b8 05 00 00 00       	mov    $0x5,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <write>:
SYSCALL(write)
 5a2:	b8 10 00 00 00       	mov    $0x10,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <close>:
SYSCALL(close)
 5aa:	b8 15 00 00 00       	mov    $0x15,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <kill>:
SYSCALL(kill)
 5b2:	b8 06 00 00 00       	mov    $0x6,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <exec>:
SYSCALL(exec)
 5ba:	b8 07 00 00 00       	mov    $0x7,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <open>:
SYSCALL(open)
 5c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <mknod>:
SYSCALL(mknod)
 5ca:	b8 11 00 00 00       	mov    $0x11,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <unlink>:
SYSCALL(unlink)
 5d2:	b8 12 00 00 00       	mov    $0x12,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <fstat>:
SYSCALL(fstat)
 5da:	b8 08 00 00 00       	mov    $0x8,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <link>:
SYSCALL(link)
 5e2:	b8 13 00 00 00       	mov    $0x13,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <mkdir>:
SYSCALL(mkdir)
 5ea:	b8 14 00 00 00       	mov    $0x14,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <chdir>:
SYSCALL(chdir)
 5f2:	b8 09 00 00 00       	mov    $0x9,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <dup>:
SYSCALL(dup)
 5fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <getpid>:
SYSCALL(getpid)
 602:	b8 0b 00 00 00       	mov    $0xb,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <sbrk>:
SYSCALL(sbrk)
 60a:	b8 0c 00 00 00       	mov    $0xc,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <sleep>:
SYSCALL(sleep)
 612:	b8 0d 00 00 00       	mov    $0xd,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <uptime>:
SYSCALL(uptime)
 61a:	b8 0e 00 00 00       	mov    $0xe,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <waitpid>:
SYSCALL(waitpid)
 622:	b8 17 00 00 00       	mov    $0x17,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <change_priority>:
SYSCALL(change_priority)
 62a:	b8 18 00 00 00       	mov    $0x18,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    
 632:	66 90                	xchg   %ax,%ax
 634:	66 90                	xchg   %ax,%ax
 636:	66 90                	xchg   %ax,%ax
 638:	66 90                	xchg   %ax,%ax
 63a:	66 90                	xchg   %ax,%ax
 63c:	66 90                	xchg   %ax,%ax
 63e:	66 90                	xchg   %ax,%ax

00000640 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	89 c6                	mov    %eax,%esi
 648:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 64e:	85 db                	test   %ebx,%ebx
 650:	74 7e                	je     6d0 <printint+0x90>
 652:	89 d0                	mov    %edx,%eax
 654:	c1 e8 1f             	shr    $0x1f,%eax
 657:	84 c0                	test   %al,%al
 659:	74 75                	je     6d0 <printint+0x90>
    neg = 1;
    x = -xx;
 65b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 65d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 664:	f7 d8                	neg    %eax
 666:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 669:	31 ff                	xor    %edi,%edi
 66b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 66e:	89 ce                	mov    %ecx,%esi
 670:	eb 08                	jmp    67a <printint+0x3a>
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 678:	89 cf                	mov    %ecx,%edi
 67a:	31 d2                	xor    %edx,%edx
 67c:	8d 4f 01             	lea    0x1(%edi),%ecx
 67f:	f7 f6                	div    %esi
 681:	0f b6 92 40 0a 00 00 	movzbl 0xa40(%edx),%edx
  }while((x /= base) != 0);
 688:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 68a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 68d:	75 e9                	jne    678 <printint+0x38>
  if(neg)
 68f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 692:	8b 75 c0             	mov    -0x40(%ebp),%esi
 695:	85 c0                	test   %eax,%eax
 697:	74 08                	je     6a1 <printint+0x61>
    buf[i++] = '-';
 699:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 69e:	8d 4f 02             	lea    0x2(%edi),%ecx
 6a1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 6a5:	8d 76 00             	lea    0x0(%esi),%esi
 6a8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ab:	83 ec 04             	sub    $0x4,%esp
 6ae:	83 ef 01             	sub    $0x1,%edi
 6b1:	6a 01                	push   $0x1
 6b3:	53                   	push   %ebx
 6b4:	56                   	push   %esi
 6b5:	88 45 d7             	mov    %al,-0x29(%ebp)
 6b8:	e8 e5 fe ff ff       	call   5a2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6bd:	83 c4 10             	add    $0x10,%esp
 6c0:	39 df                	cmp    %ebx,%edi
 6c2:	75 e4                	jne    6a8 <printint+0x68>
    putc(fd, buf[i]);
}
 6c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6c7:	5b                   	pop    %ebx
 6c8:	5e                   	pop    %esi
 6c9:	5f                   	pop    %edi
 6ca:	5d                   	pop    %ebp
 6cb:	c3                   	ret    
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6d0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6d2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6d9:	eb 8b                	jmp    666 <printint+0x26>
 6db:	90                   	nop
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6e9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ec:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6f5:	0f b6 1e             	movzbl (%esi),%ebx
 6f8:	83 c6 01             	add    $0x1,%esi
 6fb:	84 db                	test   %bl,%bl
 6fd:	0f 84 b0 00 00 00    	je     7b3 <printf+0xd3>
 703:	31 d2                	xor    %edx,%edx
 705:	eb 39                	jmp    740 <printf+0x60>
 707:	89 f6                	mov    %esi,%esi
 709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 710:	83 f8 25             	cmp    $0x25,%eax
 713:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 716:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 71b:	74 18                	je     735 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 71d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 720:	83 ec 04             	sub    $0x4,%esp
 723:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 726:	6a 01                	push   $0x1
 728:	50                   	push   %eax
 729:	57                   	push   %edi
 72a:	e8 73 fe ff ff       	call   5a2 <write>
 72f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 732:	83 c4 10             	add    $0x10,%esp
 735:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 738:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 73c:	84 db                	test   %bl,%bl
 73e:	74 73                	je     7b3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 740:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 742:	0f be cb             	movsbl %bl,%ecx
 745:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 748:	74 c6                	je     710 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 74a:	83 fa 25             	cmp    $0x25,%edx
 74d:	75 e6                	jne    735 <printf+0x55>
      if(c == 'd'){
 74f:	83 f8 64             	cmp    $0x64,%eax
 752:	0f 84 f8 00 00 00    	je     850 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 758:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 75e:	83 f9 70             	cmp    $0x70,%ecx
 761:	74 5d                	je     7c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 763:	83 f8 73             	cmp    $0x73,%eax
 766:	0f 84 84 00 00 00    	je     7f0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 76c:	83 f8 63             	cmp    $0x63,%eax
 76f:	0f 84 ea 00 00 00    	je     85f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 775:	83 f8 25             	cmp    $0x25,%eax
 778:	0f 84 c2 00 00 00    	je     840 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 77e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 781:	83 ec 04             	sub    $0x4,%esp
 784:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 788:	6a 01                	push   $0x1
 78a:	50                   	push   %eax
 78b:	57                   	push   %edi
 78c:	e8 11 fe ff ff       	call   5a2 <write>
 791:	83 c4 0c             	add    $0xc,%esp
 794:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 797:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 79a:	6a 01                	push   $0x1
 79c:	50                   	push   %eax
 79d:	57                   	push   %edi
 79e:	83 c6 01             	add    $0x1,%esi
 7a1:	e8 fc fd ff ff       	call   5a2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7a6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7aa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7ad:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7af:	84 db                	test   %bl,%bl
 7b1:	75 8d                	jne    740 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7b6:	5b                   	pop    %ebx
 7b7:	5e                   	pop    %esi
 7b8:	5f                   	pop    %edi
 7b9:	5d                   	pop    %ebp
 7ba:	c3                   	ret    
 7bb:	90                   	nop
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7c0:	83 ec 0c             	sub    $0xc,%esp
 7c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 7c8:	6a 00                	push   $0x0
 7ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7cd:	89 f8                	mov    %edi,%eax
 7cf:	8b 13                	mov    (%ebx),%edx
 7d1:	e8 6a fe ff ff       	call   640 <printint>
        ap++;
 7d6:	89 d8                	mov    %ebx,%eax
 7d8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7db:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 7dd:	83 c0 04             	add    $0x4,%eax
 7e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7e3:	e9 4d ff ff ff       	jmp    735 <printf+0x55>
 7e8:	90                   	nop
 7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 7f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7f3:	8b 18                	mov    (%eax),%ebx
        ap++;
 7f5:	83 c0 04             	add    $0x4,%eax
 7f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 7fb:	b8 36 0a 00 00       	mov    $0xa36,%eax
 800:	85 db                	test   %ebx,%ebx
 802:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 805:	0f b6 03             	movzbl (%ebx),%eax
 808:	84 c0                	test   %al,%al
 80a:	74 23                	je     82f <printf+0x14f>
 80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 810:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 813:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 816:	83 ec 04             	sub    $0x4,%esp
 819:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 81b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 81e:	50                   	push   %eax
 81f:	57                   	push   %edi
 820:	e8 7d fd ff ff       	call   5a2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 825:	0f b6 03             	movzbl (%ebx),%eax
 828:	83 c4 10             	add    $0x10,%esp
 82b:	84 c0                	test   %al,%al
 82d:	75 e1                	jne    810 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 82f:	31 d2                	xor    %edx,%edx
 831:	e9 ff fe ff ff       	jmp    735 <printf+0x55>
 836:	8d 76 00             	lea    0x0(%esi),%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 840:	83 ec 04             	sub    $0x4,%esp
 843:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 846:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 849:	6a 01                	push   $0x1
 84b:	e9 4c ff ff ff       	jmp    79c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 850:	83 ec 0c             	sub    $0xc,%esp
 853:	b9 0a 00 00 00       	mov    $0xa,%ecx
 858:	6a 01                	push   $0x1
 85a:	e9 6b ff ff ff       	jmp    7ca <printf+0xea>
 85f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 862:	83 ec 04             	sub    $0x4,%esp
 865:	8b 03                	mov    (%ebx),%eax
 867:	6a 01                	push   $0x1
 869:	88 45 e4             	mov    %al,-0x1c(%ebp)
 86c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 86f:	50                   	push   %eax
 870:	57                   	push   %edi
 871:	e8 2c fd ff ff       	call   5a2 <write>
 876:	e9 5b ff ff ff       	jmp    7d6 <printf+0xf6>
 87b:	66 90                	xchg   %ax,%ax
 87d:	66 90                	xchg   %ax,%ax
 87f:	90                   	nop

00000880 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 880:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 881:	a1 e0 0d 00 00       	mov    0xde0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 886:	89 e5                	mov    %esp,%ebp
 888:	57                   	push   %edi
 889:	56                   	push   %esi
 88a:	53                   	push   %ebx
 88b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 890:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 893:	39 c8                	cmp    %ecx,%eax
 895:	73 19                	jae    8b0 <free+0x30>
 897:	89 f6                	mov    %esi,%esi
 899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 8a0:	39 d1                	cmp    %edx,%ecx
 8a2:	72 1c                	jb     8c0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a4:	39 d0                	cmp    %edx,%eax
 8a6:	73 18                	jae    8c0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8aa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ac:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ae:	72 f0                	jb     8a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b0:	39 d0                	cmp    %edx,%eax
 8b2:	72 f4                	jb     8a8 <free+0x28>
 8b4:	39 d1                	cmp    %edx,%ecx
 8b6:	73 f0                	jae    8a8 <free+0x28>
 8b8:	90                   	nop
 8b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8c6:	39 d7                	cmp    %edx,%edi
 8c8:	74 19                	je     8e3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8cd:	8b 50 04             	mov    0x4(%eax),%edx
 8d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8d3:	39 f1                	cmp    %esi,%ecx
 8d5:	74 23                	je     8fa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8d7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 8d9:	a3 e0 0d 00 00       	mov    %eax,0xde0
}
 8de:	5b                   	pop    %ebx
 8df:	5e                   	pop    %esi
 8e0:	5f                   	pop    %edi
 8e1:	5d                   	pop    %ebp
 8e2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8e3:	03 72 04             	add    0x4(%edx),%esi
 8e6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e9:	8b 10                	mov    (%eax),%edx
 8eb:	8b 12                	mov    (%edx),%edx
 8ed:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8f0:	8b 50 04             	mov    0x4(%eax),%edx
 8f3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8f6:	39 f1                	cmp    %esi,%ecx
 8f8:	75 dd                	jne    8d7 <free+0x57>
    p->s.size += bp->s.size;
 8fa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 8fd:	a3 e0 0d 00 00       	mov    %eax,0xde0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 902:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 905:	8b 53 f8             	mov    -0x8(%ebx),%edx
 908:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 90a:	5b                   	pop    %ebx
 90b:	5e                   	pop    %esi
 90c:	5f                   	pop    %edi
 90d:	5d                   	pop    %ebp
 90e:	c3                   	ret    
 90f:	90                   	nop

00000910 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	56                   	push   %esi
 915:	53                   	push   %ebx
 916:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 919:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 91c:	8b 15 e0 0d 00 00    	mov    0xde0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 922:	8d 78 07             	lea    0x7(%eax),%edi
 925:	c1 ef 03             	shr    $0x3,%edi
 928:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 92b:	85 d2                	test   %edx,%edx
 92d:	0f 84 a3 00 00 00    	je     9d6 <malloc+0xc6>
 933:	8b 02                	mov    (%edx),%eax
 935:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 938:	39 cf                	cmp    %ecx,%edi
 93a:	76 74                	jbe    9b0 <malloc+0xa0>
 93c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 942:	be 00 10 00 00       	mov    $0x1000,%esi
 947:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 94e:	0f 43 f7             	cmovae %edi,%esi
 951:	ba 00 80 00 00       	mov    $0x8000,%edx
 956:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 95c:	0f 46 da             	cmovbe %edx,%ebx
 95f:	eb 10                	jmp    971 <malloc+0x61>
 961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 968:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 96a:	8b 48 04             	mov    0x4(%eax),%ecx
 96d:	39 cf                	cmp    %ecx,%edi
 96f:	76 3f                	jbe    9b0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 971:	39 05 e0 0d 00 00    	cmp    %eax,0xde0
 977:	89 c2                	mov    %eax,%edx
 979:	75 ed                	jne    968 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 97b:	83 ec 0c             	sub    $0xc,%esp
 97e:	53                   	push   %ebx
 97f:	e8 86 fc ff ff       	call   60a <sbrk>
  if(p == (char*)-1)
 984:	83 c4 10             	add    $0x10,%esp
 987:	83 f8 ff             	cmp    $0xffffffff,%eax
 98a:	74 1c                	je     9a8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 98c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 98f:	83 ec 0c             	sub    $0xc,%esp
 992:	83 c0 08             	add    $0x8,%eax
 995:	50                   	push   %eax
 996:	e8 e5 fe ff ff       	call   880 <free>
  return freep;
 99b:	8b 15 e0 0d 00 00    	mov    0xde0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 9a1:	83 c4 10             	add    $0x10,%esp
 9a4:	85 d2                	test   %edx,%edx
 9a6:	75 c0                	jne    968 <malloc+0x58>
        return 0;
 9a8:	31 c0                	xor    %eax,%eax
 9aa:	eb 1c                	jmp    9c8 <malloc+0xb8>
 9ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 9b0:	39 cf                	cmp    %ecx,%edi
 9b2:	74 1c                	je     9d0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 9b4:	29 f9                	sub    %edi,%ecx
 9b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9bc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 9bf:	89 15 e0 0d 00 00    	mov    %edx,0xde0
      return (void*)(p + 1);
 9c5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9cb:	5b                   	pop    %ebx
 9cc:	5e                   	pop    %esi
 9cd:	5f                   	pop    %edi
 9ce:	5d                   	pop    %ebp
 9cf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 9d0:	8b 08                	mov    (%eax),%ecx
 9d2:	89 0a                	mov    %ecx,(%edx)
 9d4:	eb e9                	jmp    9bf <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 9d6:	c7 05 e0 0d 00 00 e4 	movl   $0xde4,0xde0
 9dd:	0d 00 00 
 9e0:	c7 05 e4 0d 00 00 e4 	movl   $0xde4,0xde4
 9e7:	0d 00 00 
    base.s.size = 0;
 9ea:	b8 e4 0d 00 00       	mov    $0xde4,%eax
 9ef:	c7 05 e8 0d 00 00 00 	movl   $0x0,0xde8
 9f6:	00 00 00 
 9f9:	e9 3e ff ff ff       	jmp    93c <malloc+0x2c>
