Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE538B
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.126.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501464; cv=none; b=LX2YEqMjKfCDw6MaNQzwGaz3EyFefZHTtitYWlTQuWAFXbksJBYfEWXOTlMtaocQTMh+1oHfbkLgQE2mOPR/9hFRo2PZYgFN09ijb8Ut/WonFqsfj7Slc08Oae3U+Aw0LM2eCpNAsJMqX6uoCFCkLEag7px14Myto72W9HVu0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501464; c=relaxed/simple;
	bh=J3wtDl0ljxVRJN9JMslBmlKOHOJLf3yOGVMpAT30bfY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gCzd1mn6PC6uzgpn2O6vJjPeo/cDhW2SEApgrohPFdCrguGptVhJt3jjJubQ4I0ed+VGwCltvf/KthGhJBMlApnfZ7JZ1mws01nKQP+dYhOUvHyuHAkCUobYS5XuzQcYIRLKUMDiBSrnKDNqkMDWJg6s05w5D6guywSW5UNhjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com; spf=pass smtp.mailfrom=kdab.com; dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b=jV1BTKqW; arc=none smtp.client-ip=176.9.126.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="jV1BTKqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1717501458; x=1718365459; bh=SUlvBaIggpkqTRJcDSes4YlPFAc
 pK2wc8DinyxG/DV8=; b=jV1BTKqWrY/wQs8WcAOJL5E40Xl8sR8UzJe8fbxiD39
 iAE7nw1BJlKcHcAZ2/5khd1PeWVtkhTtU2JsVB6U45Fiv4yKaYfnPpSi7KxatGo8
 sIwySQCiyaWq6ZQBj6CTTwTdMbOtvjlUVjLMGHGydXTu+suxiVmPiXofd85ZMqc0
 =
X-Virus-Scanned: amavisd-new at kdab.com
From: Milian Wolff <milian.wolff@kdab.com>
To: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: perf 6.9-1 (archlinux) crashes during recording of cycles +
 raw_syscalls
Date: Tue, 04 Jun 2024 13:44:18 +0200
Message-ID: <23879991.0LEYPuXRzz@milian-workstation>
Organization: KDAB
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hey all,

the following command crashes perf for me, is this still an issue upstream and 
should I report it to arch for backporting? I cannot build the official perf/
core branch, so I am afraid I cannot test it myself there:

```
sudo /usr/bin/perf record -z --call-graph dwarf -e cycles -e 
raw_syscalls:sys_enter ls
...
[ perf record: Woken up 3 times to write data ]
malloc(): invalid next size (unsorted)
Aborted
```

Backtrace with GDB + debuginfod:
```
malloc(): invalid next size (unsorted)

Thread 1 "perf" received signal SIGABRT, Aborted.
__pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, 
no_tid=no_tid@entry=0) at pthread_kill.c:44
Downloading source file /usr/src/debug/glibc/glibc/nptl/pthread_kill.c
44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO 
(ret) : 0;                                                                                                                                                                     
(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>, 
signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
#1  0x00007ffff6ea8eb3 in __pthread_kill_internal (threadid=<optimized out>, 
signo=6) at pthread_kill.c:78
#2  0x00007ffff6e50a30 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/
raise.c:26
#3  0x00007ffff6e384c3 in __GI_abort () at abort.c:79
#4  0x00007ffff6e39354 in __libc_message_impl (fmt=fmt@entry=0x7ffff6fc22ea 
"%s\n") at ../sysdeps/posix/libc_fatal.c:132
#5  0x00007ffff6eb3085 in malloc_printerr (str=str@entry=0x7ffff6fc5850 
"malloc(): invalid next size (unsorted)") at malloc.c:5772
#6  0x00007ffff6eb657c in _int_malloc (av=av@entry=0x7ffff6ff6ac0 
<main_arena>, bytes=bytes@entry=368) at malloc.c:4081
#7  0x00007ffff6eb877e in __libc_calloc (n=<optimized out>, 
elem_size=<optimized out>) at malloc.c:3754
#8  0x000055555569bdb6 in perf_session.do_write_header ()
#9  0x00005555555a373a in __cmd_record.constprop.0 ()
#10 0x00005555555a6846 in cmd_record ()
#11 0x000055555564db7f in run_builtin ()
#12 0x000055555558ed77 in main ()
```

Valgrind memcheck:
```
==45136== Invalid write of size 8
==45136==    at 0x2B38A5: perf_event__synthesize_id_sample (in /usr/bin/perf)
==45136==    by 0x157069: __cmd_record.constprop.0 (in /usr/bin/perf)
==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
==45136==    by 0x142D76: main (in /usr/bin/perf)
==45136==  Address 0x6a866a8 is 0 bytes after a block of size 40 alloc'd
==45136==    at 0x4849BF3: calloc (vg_replace_malloc.c:1675)
==45136==    by 0x3574AB: zalloc (in /usr/bin/perf)
==45136==    by 0x1570E0: __cmd_record.constprop.0 (in /usr/bin/perf)
==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
==45136==    by 0x142D76: main (in /usr/bin/perf)
==45136== 
==45136== Syscall param write(buf) points to unaddressable byte(s)
==45136==    at 0x575953D: __libc_write (write.c:26)
==45136==    by 0x575953D: write (write.c:24)
==45136==    by 0x35761F: ion (in /usr/bin/perf)
==45136==    by 0x357778: writen (in /usr/bin/perf)
==45136==    by 0x1548F7: record__write (in /usr/bin/perf)
==45136==    by 0x15708A: __cmd_record.constprop.0 (in /usr/bin/perf)
==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
==45136==    by 0x142D76: main (in /usr/bin/perf)
==45136==  Address 0x6a866a8 is 0 bytes after a block of size 40 alloc'd
==45136==    at 0x4849BF3: calloc (vg_replace_malloc.c:1675)
==45136==    by 0x3574AB: zalloc (in /usr/bin/perf)
==45136==    by 0x1570E0: __cmd_record.constprop.0 (in /usr/bin/perf)
==45136==    by 0x15A845: cmd_record (in /usr/bin/perf)
==45136==    by 0x201B7E: run_builtin (in /usr/bin/perf)
==45136==    by 0x142D76: main (in /usr/bin/perf)
==45136==
```

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts

