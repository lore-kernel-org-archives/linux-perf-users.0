From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: perf report and symbol addresses
Date: Wed, 2 Sep 2015 16:43:24 +0000
Message-ID: <1441212204.3349.256.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:63540 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbbIBQwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 12:52:01 -0400
Received: from exch2.transmode.se (exch2.transmode.se [192.168.203.24])
	by smtp.transmode.se (Postfix) with ESMTP id 4E13B11870C4
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2015 18:43:25 +0200 (CEST)
Content-Language: en-US
Content-ID: <E0F12A427358064283F5449110298F24@transmode.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

on PPC I do:
# > perf record -a   /root/a.out

then 
#> perf report -v
...
50.36%        a.out  /root/a.out                                               0x2c4      d [.] main

compare the address 0x2c4 with
#> nm -a a.out  | grep main
         U __libc_start_main@@GLIBC_2.0
100002c0 T main

The perf reported address is lacking 0x10000000.

How do I list the absolut symbol address?

 Jocke