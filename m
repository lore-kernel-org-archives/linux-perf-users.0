From: zhao bao <baozhao@gmail.com>
Subject: perf trace cannot work with software events ?
Date: Sat, 26 Mar 2011 16:04:28 +0800
Message-ID: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35189 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab1CZIE3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 26 Mar 2011 04:04:29 -0400
Received: by yia27 with SMTP id 27so721688yia.19
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Mar 2011 01:04:28 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

 Hi,  I want to trace page faults in my program. The result I wanted like this:
 1st page fault at addrA.
 2nd page fault at addrB.
 3rd page fault at addrC
 ...

 Perf seems providing this function, but I can't get what I want.
 I use Perf on Fedora 14(kernel 2.6.35). The following is what I have
done in my machine.
Thanks for help in advance.

[root@localhost lab]# perf record -R -c 1  -d  -e  faults ./hello
hello,world
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.010 MB perf.data (~418 samples) ]

[root@localhost lab]# perf trace
  Fatal: no event_list!
