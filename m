From: chenggang qin <chenggang.qin@gmail.com>
Subject: Re: How to trace threads created by a process after perf has started
 recording, using the -p PID flag?
Date: Sun, 26 Aug 2012 12:56:19 +0800
Message-ID: <5039AC73.8090908@gmail.com>
References: <CAJgLYc+dMADVBkbPq1wJFptcx63UUSg24DDM5BbYSWW2bDV+tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64188 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab2HZE4X (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 26 Aug 2012 00:56:23 -0400
Received: by dady13 with SMTP id y13so1785803dad.19
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Aug 2012 21:56:23 -0700 (PDT)
In-Reply-To: <CAJgLYc+dMADVBkbPq1wJFptcx63UUSg24DDM5BbYSWW2bDV+tg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

HI:
    I submitted a patch to fix this problem. and the patch is waitting for
reviewing.

                        chenggang qin

On Sat, Aug 25, 2012 at 8:52 PM, Mikolaj Konarski <
mikolaj.konarski@gmail.com> wrote:

> Hi,
>
> Could someone clarify the behaviour of the -p PID flag of perf-record?
> In our experiments (3.2.0-27 #43-Ubuntu SMP x86_64),
> it ignores events on threads spawned after perf-record is started.
> Is this the intended behaviour, and is there any work-around?
>
> Generally, what is the best (vs CPU/IO, distortion of profiling results)
> way to record only events of a given OS process, with all its threads?
>
> Thanks a lot,
> Mikolaj
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
