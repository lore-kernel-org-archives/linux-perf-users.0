From: Vinson Lee <vlee@twopensource.com>
Subject: perf linking error with NO_DWARF=1 and NO_LIBUNWIND=1
Date: Sat, 18 Apr 2015 00:05:39 -0700
Message-ID: <CAHTgTXVqzwcP39PqwaLNUFSdc-q_fk6cWEdfGQoNzqsGu9Qb8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34003 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbDRHFk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 18 Apr 2015 03:05:40 -0400
Received: by qgfi89 with SMTP id i89so31735450qgf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 18 Apr 2015 00:05:39 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I build perf with NO_DWARF=1 and my spec file does not require libunwind-devel.

With this combination I see perf linking errors such as the following.

  LINK     perf
libperf.a(unwind-libdw.o): In function `libdw__arch_set_initial_registers':
tools/perf/arch/x86/util/unwind-libdw.c:50: undefined reference to
`dwfl_thread_state_registers'

This linking error was introduced with commit
0a4f2b6a3ba5066947a8cbd7cfa26fb8a9280625 "perf tools: Setup default
dwarf post unwinder" in Linux 3.15-rc1.

The above error can also be reproduced with this command line.
make -C tools/perf NO_DWARF=1 NO_LIBUNWIND=1

Cheers,
Vinson
