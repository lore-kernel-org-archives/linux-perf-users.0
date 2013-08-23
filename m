From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: what does id mean in perf script
Date: Fri, 23 Aug 2013 10:38:54 -0400
Message-ID: <CAEuYUepPXrZnGN4tZxu2usynRmQ8tdQXCKUgv2NF4uD5Z5-k1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:63455 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab3HWOiz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 23 Aug 2013 10:38:55 -0400
Received: by mail-vb0-f44.google.com with SMTP id e13so475101vbg.17
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Aug 2013 07:38:54 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, perf group <linux-perf-users@vger.kernel.org>

Hi all,

I got a file using perf script as follows. I want to know the meaning
in the array id in event,like
 id = { 672074, 672075, 672076, 672077
, 672078, 672079, 672080, 672081, 672082, 672083, 672084, 672085,
672086, 672087, 672088, 672089, 672090, 672091, 672092, 672093,
672094, 672095, 672096, 672097, 672098, 672099, 672100, 672101,
672102, 672103, 672104, 672105, 672106, 672107, 672108, 672109,
672110, 672111, 672112, 672113, 672114, 672115, 672116, 672117,
672118, 672119, 672120, 672121, 672122, 672123, 672124, 672125,
672126, 672127, 672128, 672129, 672130, 672131, 672132 }

What do these numbers mean??




# captured on: Fri Aug 23 01:26:40 2013
# hostname : vclh3-5.hpc.ncsu.edu
# os release : 2.6.32-71.el6.x86_64
# perf version : 2.6.32-358.11.1.el6.x86_64.debug
# arch : x86_64
# nrcpus online : 8
# nrcpus avail : 8
# cpudesc : Intel(R) Xeon(R) CPU E5405 @ 2.00GHz
# cpuid : GenuineIntel,6,23,10
# total memory : 16333704 kB
# cmdline : /usr/bin/perf record -e instructions -e cycles -c 1000 -p
26765 -T -o perf_TaskTracker_
1377235537.data
# event : name = instructions, type = 0, config = 0x1, config1 = 0x0,
config2 = 0x0, excl_usr = 0,
excl_kern = 0, excl_host = 0, excl_guest = 0, precise_ip = 0, id = {
672074, 672075, 672076, 672077
, 672078, 672079, 672080, 672081, 672082, 672083, 672084, 672085,
672086, 672087, 672088, 672089, 672090, 672091, 672092, 672093,
672094, 672095, 672096, 672097, 672098, 672099, 672100, 672101,
672102, 672103, 672104, 672105, 672106, 672107, 672108, 672109,
672110, 672111, 672112, 672113, 672114, 672115, 672116, 672117,
672118, 672119, 672120, 672121, 672122, 672123, 672124, 672125,
672126, 672127, 672128, 672129, 672130, 672131, 672132 }
# event : name = cycles, type = 0, config = 0x0, config1 = 0x0,
config2 = 0x0, excl_usr = 0, excl_kern = 0, excl_host = 0, excl_guest
= 0, precise_ip = 0, id = { 672133, 672134, 672135, 672136, 672137,
672138, 672139, 672140, 672141, 672142, 672143, 672144, 672145,
672146, 672147, 672148, 672149, 672150, 672151, 672152, 672153,
672154, 672155, 672156, 672157, 672158, 672159, 672160, 672161,
672162, 672163, 672164, 672165, 672166, 672167, 672168, 672169,
672170, 672171, 672172, 672173, 672174, 672175, 672176, 672177,
672178, 672179, 672180, 672181, 672182, 672183, 672184, 672185,
672186, 672187, 672188, 672189, 672190, 672191 }

Best wishes.
Yours,
Wang Peipei
