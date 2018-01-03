From: Dmitry Dolgov <9erthalion6@gmail.com>
Subject: perf memory metrics on ec2 instance
Date: Wed, 3 Jan 2018 15:50:28 +0100
Message-ID: <CA+q6zcXGsPT3bXhUS2gNf0_JPm+jLHBaSH+T_5CNPkZ3A9GK7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:45750 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbeACOvJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Jan 2018 09:51:09 -0500
Received: by mail-io0-f170.google.com with SMTP id e20so2287149iof.12
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jan 2018 06:51:09 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I have a question, maybe a stupid one. I'm experimenting with perf
on ec2 instances, a dedicated m4.16xlarge, that should support some
hardware counters. But so far when I'm trying to get something memory
related, I'm getting this error (the same for `perf mem -t load record
-- sleep 10`):

$ perf c2c record -- sleep 10
event syntax error: '..ads,ldlat=30/P'
                                  \___ unknown term

valid terms: pc,inv,edge,cmask,event,umask,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,no-overwrite,overwrite,driver-config
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
available events


$ perf -v
perf version 4.15.rc6.g30a7a

$ uname -a
Linux ip-172-30-2-208 4.4.0-1041-aws #50-Ubuntu SMP Wed Nov 15
22:18:17 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

It's quite confusing for me, because the same works fine on my local machine,
but this error I've got is not about something being not supported. Can you tell
me what I'm doing wrong?
