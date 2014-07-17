From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: kprobe string
Date: Wed, 16 Jul 2014 17:51:49 -0700
Message-ID: <CAE40pdfJpksb-LJghF+w4XZBagKo7wg6fh3irGPha5F9Uknb=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:42386 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091AbaGQAvu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Jul 2014 20:51:50 -0400
Received: by mail-qa0-f42.google.com with SMTP id j15so1388091qaq.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2014 17:51:50 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day,

I'm not sure where else to ask this; I don't think this functionality
is in perf_events yet...

kprobes is supposed to be able to handle string arguments, but I've
not been able to find a single working example. I'm trying (on 3.16):

# cd /sys/kernel/debug/tracing
# echo 'r:getname getname $retval:string' > kprobe_events
-bash: echo: write error: Invalid argument
# echo 'p:myprobe do_sys_open %dx:string' > kprobe_events
-bash: echo: write error: Invalid argument

I'm following the syntax in Documentation/trace/kprobetrace.txt by
Masami Hiramatsu, and it is recognizing "string". But I'm getting
these errors:

# dmesg | tail -4
[98021.813560] string type has no corresponding fetch method.
[98021.813564] Parse error at argument[0]. (-22)
[98705.956199] string type has no corresponding fetch method.
[98705.956203] Parse error at argument[0]. (-22)

Anyone seen this work? I'm checking the source... Thanks in advance,

Brendan
-- 
http://www.brendangregg.com
