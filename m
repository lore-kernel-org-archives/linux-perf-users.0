Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEDD3081D7;
	Tue,  9 Sep 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411399; cv=none; b=FnRhnibPMMgVhFYW35y4/MfYy2AzgFKneWzaWrhDBQdPloEn2PuYapIgcHezL0Y5XpXKwA8bgg5vycwe/Yr//aW80HmziuxnH01W/Egbfp2FhZaooWDLbGveRxcruIXUDd9x+0oZJ9+T2AGZM4aeZFgzyHw4rKuF74Hv9w/u7bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411399; c=relaxed/simple;
	bh=wEV85phRpWANT882n8tmkdgXk2TdLjOwnPk9a6vwZiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7i0Nh6DwtQLbE2VUcdiIxMNIl1coc3JIPfxg0tXlBh7fRtTYW601iJqVHsQzRZAl3W17cx7SsqSqJxtsogRfnBZZI8M6cANjkHaX178+xv/hnzoMfhfua2Po1tosVRnrmF0nGf1FatDUVtBecFQPfUUbUmNQm5wPeJZCKQ5ewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 43C5D340F14;
	Tue, 09 Sep 2025 09:49:57 +0000 (UTC)
From: Guilherme Amadio <amadio@gentoo.org>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mingo@kernel.org,
	peterz@infradead.org
Subject: perf --help triggers an assertion
Date: Tue,  9 Sep 2025 11:49:53 +0200
Message-ID: <20250909094953.106706-1-amadio@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250701201027.1171561-3-namhyung@kernel.org>
References: <20250701201027.1171561-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

I was updating perf's package in Gentoo Linux and noticed some problems
which were not there before. I tested with the version below and the problem
still seems to be there. perf --help triggers an assertion (see below).
Looking in the list, it seems related to the patch below:

https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3-namhyung@kernel.org/

Cheers,
-Guilherme

The problem:

gentoo perf $ ./perf --help
perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
Aborted                    (core dumped) ./perf --help

Some extra information:

gentoo perf $ ./perf version
perf version 6.17.rc5.gf777d1112ee5
gentoo perf $ ./perf test subcmd
 69: libsubcmd help tests                                            :
 69.1: Load subcmd names                                             : Ok
 69.2: Uniquify subcmd names                                         : Ok
 69.3: Exclude duplicate subcmd names                                : Ok
gentoo perf $ ./perf bad-command
perf: 'bad-command' is not a perf-command. See 'perf --help'.
gentoo perf $ ./perf --help
perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
Aborted                    (core dumped) ./perf --help
gentoo perf $ gdb run --args ./perf --help
GNU gdb (Gentoo 16.3 vanilla) 16.3
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://bugs.gentoo.org/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./perf...
(gdb) run
Starting program: /home/amadio/src/linux/tools/perf/perf --help
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib64/libthread_db.so.1".
perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.

Program received signal SIGABRT, Aborted.
__pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
44	      return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) : 0;
(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
#1  0x00007ffff74c1656 in __pthread_kill_internal (threadid=<optimized out>, signo=signo@entry=6) at pthread_kill.c:89
#2  0x00007ffff74c166d in __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at pthread_kill.c:100
#3  0x00007ffff747509c in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#4  0x00007ffff747637e in __GI_abort () at abort.c:77
#5  0x00007ffff746e023 in __assert_fail_base (fmt=<optimized out>, assertion=assertion@entry=0x555555974d03 "cmds->names[ci] == NULL", 
    file=file@entry=0x555555974cfc "help.c", line=line@entry=104, function=function@entry=0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cmds")
    at assert.c:118
#6  0x00007ffff746e075 in __assert_fail (assertion=0x555555974d03 "cmds->names[ci] == NULL", file=0x555555974cfc "help.c", line=104, 
    function=0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cmds") at assert.c:127
#7  0x0000555555693813 in exclude_cmds (cmds=0x55555614e5e0 <other_cmds>, excludes=0x55555614e5c0 <main_cmds>) at help.c:104
#8  0x0000555555693eb3 in load_command_list (prefix=0x555555954071 "perf-", main_cmds=0x55555614e5c0 <main_cmds>, 
    other_cmds=0x55555614e5e0 <other_cmds>) at help.c:252
#9  0x00005555555e9987 in cmd_help (argc=1, argv=0x7fffffffd1a0) at builtin-help.c:458
#10 0x0000555555685d45 in run_builtin (p=0x555556130de0 <commands+192>, argc=1, argv=0x7fffffffd1a0) at perf.c:349
#11 0x0000555555685fe1 in handle_internal_command (argc=1, argv=0x7fffffffd1a0) at perf.c:401
#12 0x0000555555686142 in run_argv (argcp=0x7fffffffcfac, argv=0x7fffffffcfa0) at perf.c:445
#13 0x0000555555686493 in main (argc=1, argv=0x7fffffffd1a0) at perf.c:553
(gdb) quit
