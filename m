Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD2D15217A
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jul 2024 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480994; cv=none; b=MKc8bzHeZpP/f/WOiChjBNHjdSNyC06LvZ7RyQTZrjGGx6Wa5E24VCNcNKNYc541XZISehjFsVNjkHrBSPDXJabR6Jp/Zg8mU9Eik4GebGUJ7A9dl2JsWkYucAIcrKFMkGtsMWroZ5yy9gs9+M2ZYRUEVYjkc2G7CKI+e1knHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480994; c=relaxed/simple;
	bh=MFSGJD3nwcJI8ETw4DBy0zzHG4DY/83bE/eiWtvu90g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxKR140/EhiakyHqeEAe0KJlFeLHrutFf+UjlEJaueA3sNtxqqoKsTBZqDGop5BNZuZ8QR0ZTN3Wg2JGPrDb7NrlOscmxBtxHdvM7wyN+aP+6KH0NN4RxUGlYBe3eAjWMZxuQXdZVtpqHprgjHjXlQw/9oaN/ArxjwMXCoWI6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IQQ80gPm; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IQQ80gPm"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso3042918b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jul 2024 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1720480992; x=1721085792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HETypXtaF2wU7wCZrgMWj95uf6eaRfqAsfHPOMZKG/g=;
        b=IQQ80gPmcw15xYFE2YFFPj7ZABqFGz6o1ZKdRvXVrnyLYE93+Q1amntj4u4sA/EOtx
         XoegOPc/Wit6TQqGG8zwHuCmgR+Aanv8L5qxVKIIUosyN9o18N4PGhAJ4pBDxHoui2kj
         ol53wKHYiGiLQejIfZzS72CiANycGi588IdrU1PRQkgd3M1bFvAbNfE6TEaBaLVzplaP
         pzDM+kU9FIWZIb7N6Zm5ng8zcSgKudcHBZmevaAlwwjWN+12Qz8Al/5X59/lM8ZXs/nB
         Ie6E6QaGm+iTpTek8Vd++zCnU1tdzqI3J5mZubufhKoEK7VtjxE9G5iLCX/wvh3o0dSM
         wcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720480992; x=1721085792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HETypXtaF2wU7wCZrgMWj95uf6eaRfqAsfHPOMZKG/g=;
        b=hL+1NewhX5/20rezL5hPBeS+6pIisT/i0LWOGGqHc6+LzoGB0kdgg+2c8vpeBIsz9H
         jNyQ2oWVpEdsgYpSt1lhlfHN5N2W8vb6A1T47KiHO/zZH6c3GssUTqvtpXaRy33sqEFs
         1yKQGzNwbvW4JcRNNWkcLsyblfLgFelG8KWyacraIWunMTtNsREh/4PlzmRM8psRxKFD
         Q4C8OnHgUkOJoEotwdvPAjKeZhPBM60fUDE40lqVE/c/vNbBSXu0okOjjalp6BVFKYFE
         KhHLlc9qJ6GwyN1VR9QNF/nxjg/OwJjFH5aXpb7fpO9LsETeOXsoJSDbe+G5yCKavQHk
         t4BA==
X-Gm-Message-State: AOJu0YwciX6TLEHfCY4uW9IpKHXGrnA+l6E42IO03lbVugsXodybcTqf
	CY6DGHRx1RUcje7TOef45eCQIAQF1nT5y3CcPL6YiKFn6QvVyvReN4LrDm0vnWlDkY/fPCa1gKC
	RcYmSK1+YOyRlvVsnBgttr55Cys/N0Q23ZqJizuEQTdslF8stB3rLwqGghUxrp2BaKjTG3lWUu2
	SBGxM7/6Bm4nco0ixdCvapdjr328gQZGeuvCefecNn9gOwCkr2tkNNaL3HOQ==
X-Google-Smtp-Source: AGHT+IFNrtTyBvb0fgUj6KjUtbR/KrfiOy3zb3MzTx+C91s82YYOt+aRk7pRE6MRy15FPO7Tqj22LQ==
X-Received: by 2002:a05:6a00:4fc6:b0:706:741f:a77c with SMTP id d2e1a72fcca58-70b434f56a7mr1348102b3a.7.1720480991788;
        Mon, 08 Jul 2024 16:23:11 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b438bfa86sm437775b3a.47.2024.07.08.16.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:23:11 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH 0/1] perf tool: fix handling NULL al->maps returned from thread__find_map
Date: Mon,  8 Jul 2024 17:23:00 -0600
Message-ID: <20240708232302.15267-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We found a segfault when run perf report on raw perf_data from perf record.
Basically with 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
thread__find_map() would return with al->maps being NULL when cpumode is 3
(macro PERF_RECORD_MISC_HYPERVISOR). Later dereferencing maps->machine would crash.

The fix adds check to callers of thread__find_map() and thread__find_symbol(),
please see 0001-perf-tool-fix-handling-NULL-al-maps-returned-from-th.patch,
which is made and tested on afcd48134c58 ("Merge tag
'mm-hotfixes-stable-2024-06-26-17-28' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

Debug diffs made on 0dd5041c9a0e is attached as
0002-debug-patch-for-perf-report-segfault.patch

Steps to reproduce and what are observed:
1. Run 'gdb ./perf'
2. Initial gdb output. cpumode is 3 and address of node->ms is 0x55555684aee8.

(gdb) run report --stdio -v -i ~/perf_data
...
add_callchain_ip: i'm here! al.map (nil) al.sym (nil) ip >= PERF_CONTEXT_MAX: 0 cpumode 3 ip 0x8348fb8948535441
callchain_cursor_append addr of node->ms 0x55555684aee8 ms 0x7fffffff9e70 has no maps map (nil) symbol (nil)
Failed to open /tmp/perf-31239.map, continuing without symbols
callchain_cursor_commit: cursor 0x7ffff7a17b98 curr 0x55555684aee0 ms 0x55555684aee8
callchain_cursor_commit: cursor 0x7ffff7a17b98 curr 0x55555684aee0 ms 0x55555684aee8
callchain_cursor_commit: cursor 0x7ffff7a17b98 curr 0x55555684aee0 ms 0x55555684aee8

Program received signal SIGSEGV, Segmentation fault.
fill_callchain_info (al=0x7fffffffa120, node=0x55555684aee0, hide_unresolved=false) at util/callchain.c:1119
1119            struct machine *machine = maps__machine(node->ms.maps);

3. Backtrace from gdb
(gdb) bt
#0  fill_callchain_info (al=0x7fffffffa120, node=0x55555684aee0, hide_unresolved=false) at util/callchain.c:1119
#1  0x00005555556bdbc6 in hist_entry_iter__add (iter=iter@entry=0x7fffffffa160, al=al@entry=0x7fffffffa120, max_stack_depth=<optimized out>, arg=arg@entry=0x7fffffffb570) at util/hist.c:1245
#2  0x00005555555cd098 in process_sample_event (tool=0x7fffffffb570, event=0x7fffeb58be78, sample=0x7fffffffa210, evsel=<optimized out>, machine=0x55555585b8e0) at builtin-report.c:332
#3  0x00005555556958e3 in perf_session__deliver_event (session=0x55555585b730, event=0x7fffeb58be78, tool=0x7fffffffb570, file_offset=12656248, file_path=0x55555585ade0 "/root/perf_data/1/ct1/perf_data") at util/session.c:1645
#4  0x000055555569a5c1 in do_flush (show_progress=false, oe=0x555555862268) at util/ordered-events.c:245
#5  __ordered_events__flush (oe=0x555555862268, how=OE_FLUSH__ROUND, timestamp=<optimized out>) at util/ordered-events.c:324
#6  0x0000555555695cf5 in perf_session__process_user_event (session=0x55555585b730, event=0x7fffec19f7f8, file_offset=25319416, file_path=<optimized out>) at util/session.c:1698
#7  0x00005555556962a8 in reader__read_event (rd=rd@entry=0x7fffffffaef0, session=session@entry=0x55555585b730, prog=prog@entry=0x7fffffffaec0) at util/session.c:2371
#8  0x0000555555697e41 in reader__process_events (prog=0x7fffffffaec0, session=0x55555585b730, rd=0x7fffffffaef0) at util/session.c:2420
#9  __perf_session__process_events (session=0x55555585b730) at util/session.c:2467
#10 perf_session__process_events (session=session@entry=0x55555585b730) at util/session.c:2633
#11 0x00005555555cffcd in __cmd_report (rep=0x7fffffffb570) at builtin-report.c:991
#12 cmd_report (argc=<optimized out>, argv=<optimized out>) at builtin-report.c:1711
#13 0x0000555555631250 in run_builtin (p=p@entry=0x555555840d40 <commands+288>, argc=argc@entry=5, argv=argv@entry=0x7fffffffddd0) at perf.c:323
#14 0x00005555555b6179 in handle_internal_command (argv=0x7fffffffddd0, argc=5) at perf.c:377
#15 run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at perf.c:421
#16 main (argc=5, argv=0x7fffffffddd0) at perf.c:537

4. The line of code at fault. We can see that deferencing maps->machine caused segfault.
(gdb) disas
Dump of assembler code for function fill_callchain_info:
   0x0000555555684100 <+0>:     endbr64
   0x0000555555684104 <+4>:     push   %rbp
   0x0000555555684105 <+5>:     mov    %rsp,%rbp
   0x0000555555684108 <+8>:     push   %r14
   0x000055555568410a <+10>:    push   %r13
   0x000055555568410c <+12>:    mov    %rsi,%r13
   0x000055555568410f <+15>:    push   %r12
   0x0000555555684111 <+17>:    mov    %rdi,%r12
   0x0000555555684114 <+20>:    push   %rbx
   0x0000555555684115 <+21>:    mov    %edx,%ebx
   0x0000555555684117 <+23>:    sub    $0x10,%rsp
   0x000055555568411b <+27>:    mov    %fs:0x28,%rax
   0x0000555555684124 <+36>:    mov    %rax,-0x28(%rbp)
   0x0000555555684128 <+40>:    mov    0x8(%rsi),%rax
=> 0x000055555568412c <+44>:    mov    0x40(%rax),%r14

...
(gdb) list *0x000055555568412c
0x55555568412c is in fill_callchain_info (util/maps.h:81).
76              return &RC_CHK_ACCESS(maps)->entries;
77      }
78
79      static inline struct machine *maps__machine(struct maps *maps)
80      {
81              return RC_CHK_ACCESS(maps)->machine;
82      }
83
84      static inline struct rw_semaphore *maps__lock(struct maps *maps)
85      {

(gdb) p/x &(((struct maps *)0)->machine)
$1 = 0x40

5. Data structure in trouble. struct maps from node->ms are empty. The address of node->ms is 0x55555684aee8.
(gdb) p/x *node
$2 = {ip = 0x8348fb8948535441, ms = {maps = 0x0, map = 0x0, sym = 0x0}, srcline = 0x0, valid = 0x0, branch = 0x0, branch_flags = {{value = 0x0, {mispred = 0x0, predicted = 0x0, in_tx = 0x0, abort = 0x0, cycles = 0x0, type = 0x0, spec = 0x0, new_type = 0x0, priv = 0x0,
        reserved = 0x0}}}, branch_from = 0x0, nr_loop_iter = 0x0, iter_cycles = 0x0, next = 0x555556813730}
(gdb) p/x &(node->ms)
$3 = 0x55555684aee8

*** BLURB HERE ***

Casey Chen (1):
  perf tool: fix handling NULL al->maps returned from thread__find_map

 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 10 ++++++----
 tools/perf/util/machine.c                         |  5 +++++
 tools/perf/util/unwind-libdw.c                    |  6 ++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.45.2

