From: Kant <fnord.hammer@gmail.com>
Subject: perf report -k kfoo -C bar (3.2.14) crashes
Date: Fri, 6 Apr 2012 13:36:00 +0200
Message-ID: <CAEmqk_wOgktquxBmMUyW1EskHOrca0n3OLnFp3yEk5UHPM0nHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45716 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab2DFLgC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 6 Apr 2012 07:36:02 -0400
Received: by wejx9 with SMTP id x9so1410716wej.19
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Apr 2012 04:36:00 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

(gdb) bt
#0  0x000000000041adb0 in __cmd_report () at builtin-report.c:315
#1  cmd_report (argc=<optimized out>, argv=<optimized out>,
prefix=<optimized out>) at builtin-report.c:575
#2  0x000000000041129f in run_builtin (p=p@entry=0x6aab88,
argc=argc@entry=6, argv=argv@entry=0x7e2c43b8e760) at perf.c:286
#3  0x0000000000410b2f in handle_internal_command
(argv=0x7e2c43b8e760, argc=6) at perf.c:358
#4  run_argv (argv=0x7e2c43b8e560, argcp=0x7e2c43b8e56c) at perf.c:402
#5  main (argc=6, argv=0x7e2c43b8e760) at perf.c:512
