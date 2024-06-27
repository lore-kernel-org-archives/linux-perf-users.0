Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2A4D8B1
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524192; cv=none; b=i+jE5T8dAEAqy3lmYV5dRlkYbMY7Zmy89ykahSwQLF03cWC99z8yYrn4UdGP5iodaQQAVGk/tkArrQgsolEgzxzvN7wKAX10jlPBUL5dt3SncOIlemDfa6FIrwdxN4aIMKKEN6GHbIpoqKVGWl+LOICSA86YualTinoegmgj4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524192; c=relaxed/simple;
	bh=+00x/7DmOxtwRusaJY5Tk/kmn/X4YxK4Gc1yVLLlLZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJoqJG4ZmfXqZcRsr9NqIrNqMuEqvLCs2QDY79+T2SDUJohXV52lxzuXmQc7gKAIhwg5Bc5Krft6RpIPmEhMzD2YKa7ChrjWEtsne4oBxoMTxzxIDr/yvrP4YYqSRTRhBjynNi5dl+9cRkxDZosMPaAZMK4A8aBtRsFsM/ch8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RUn+aJeo; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RUn+aJeo"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-648b16e5e47so20225137b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 14:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1719524189; x=1720128989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ji44MXud8LABg7yyad8M2tfmvrGyhfTENkhmYXgIXRc=;
        b=RUn+aJeoilZqqZqT2GlDM/9smCYeaTFtuVx6CXrHv4rMxTxvaqsNkikXMAlDSZgYXz
         Fst0cFLkbCSM/cqDKXCbxBb5+Rr8dBbIMTuHIboWW+z9ZR2Fei7vka1W7IXg1VN30poK
         WUmyNxxA6YcHB7xek7XAsXNm4pWFefZ5tFsRgx9NC2WunzbH5uJjL/r9v2XHG4GLbER5
         FhgVDYL41LWKTw1K+KdlMMutRjfn4bAyjvJWrS1pWW3n8Z0EUGyrauoiPP6e806EAEZA
         v/sAoMPo+tdFZA9Wrtlbud0An0YH6pIgass5LyWJB+peG93JwAAFeVQ6y3qhf9QnK35t
         8rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719524189; x=1720128989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ji44MXud8LABg7yyad8M2tfmvrGyhfTENkhmYXgIXRc=;
        b=Iu5UopiBdgbg8Cx1QH4/OPw7JCCos0IkcEbm1maiRzwIFv0aRv6dOdjruL1HN71d0n
         MSyImk8Rya28GtG8WgOeRuFbF95GpHWTRwx5VJx3giTwJzmfP4uQwAuk9aegc6/LVQ8O
         BnTPPeegVm5DWMkbEMMHtrqhVLmC1qWAe2z5QlbZ8PTeSoE1E2MbzrYBuqprb4WzlbVT
         41ld/uKvGrjVHLMYF8yEFh2ukqSPhKo6YaNJX9GZtvp/vk+yrjQA46BNEGVhTRkmwkMf
         dldE/lg7U80cDq0M0Rz+9cm50TpjL0tgtkVTlwaSF8w0VlQWlwLHZDZMiq3FKH/8wGRd
         6vBg==
X-Gm-Message-State: AOJu0YzauL9pgHF4RvCs0OrQ91XsQvCc672kn0Ji01NbaMbvKQ6qnooU
	zov9AoFHNxQ2HY1liGtpeyISamVi+Hg7K8eWvn60Ai7l/4sIVavORHZPp32HzDZtTdbTEuNkreM
	/qjBzq5GC9JpjuGELfEf0KWMVOrGQIfd88KhEeDk36RhuyELQH4aTIvW+6ygu5zOlHwqbFso1Gw
	sHe1//gZWmT7AwrCfIU25qKklqwiA1a7oEwsb0TyLf8UcE+yDIpFJ6t5GhMs+KmRA=
X-Google-Smtp-Source: AGHT+IHlB3hanocdQQtbdzk/oWYOgyfpsuBvUCbY2YEjV8K7faHcWFcGutcMDfD7PNOLeR7AVc3kBg==
X-Received: by 2002:a81:ad26:0:b0:645:25d:b741 with SMTP id 00721157ae682-645026cf997mr126348947b3.11.1719524188824;
        Thu, 27 Jun 2024 14:36:28 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-64a99c717c0sm1009467b3.2.2024.06.27.14.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 14:36:28 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH 0/1] perf report: fix missing references to maps and map in thread__find_map
Date: Thu, 27 Jun 2024 15:36:17 -0600
Message-ID: <20240627213619.718-1-cachen@purestorage.com>
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

The fix is to add back references to struct maps/map in thread__find_map(),
please see 0001-perf-probe-fix-missing-references-to-maps-and-map-in.patch,
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

Casey Chen (1):
  perf probe: fix missing references to maps and map in thread__find_map

 tools/perf/util/event.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.45.2

