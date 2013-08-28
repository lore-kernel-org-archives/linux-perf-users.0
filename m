From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: What should I do if I want to get Perf samples and Read Performance
 Counter at the same time?
Date: Wed, 28 Aug 2013 13:23:14 -0400
Message-ID: <CAEuYUepHR9yFkXvg2Hkmmvmo4eWBGJTU+AO19d6xnjWL9OfQTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:40391 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab3H1RXP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 28 Aug 2013 13:23:15 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz11so4343353veb.22
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2013 10:23:14 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>

Hi all,

Here is my issue, looking forward to the suggestions from you guys. I
have a java process and I can get the process id. I want to get the
information about the event cache-misses for this process at the
sampling rate 100(For this, I use perf record -e cache-misses -c 100
-p pid) . And I also want to know how many cache-misses events occurs
for each second(For this I use watch perf stat -e cache-misses -p pid
sleep 1)

Any one has ideas about how to get both of them?
Thanks for all your help!


Yours,
Wang Peipei
