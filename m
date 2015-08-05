From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: task-clock vs. cpu-clock; per-event documentation
Date: Wed, 5 Aug 2015 15:07:28 +0200
Message-ID: <CAGz0_-2CGffoKu7LG+ZA6=QkYFzts8=AVg=j7xYVHkCxJPtQSQ@mail.gmail.com>
References: <1472439.mytDSkIAAG@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:47805 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226AbbHENRa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Aug 2015 09:17:30 -0400
Received: (Authenticated sender: hollmann)
	by mail.in.tum.de (Postfix) with ESMTPSA id 455841C243D
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2015 15:07:30 +0200 (CEST)
Received: by oip136 with SMTP id 136so19673955oip.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2015 06:07:28 -0700 (PDT)
In-Reply-To: <1472439.mytDSkIAAG@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org

Hi,

I had the same question in 2013 and the best answer I got was (by David Ahern):

cpu-clock is wall-clock based -- so samples are taken at regular
intervals relative to walltime.

I believe that task-clock is relative to the task run time. So,
samples are taken at regular intervals relative to the process'
runtime.

David

2015-08-05 14:55 GMT+02:00 Milian Wolff <mail@milianw.de>:
> Hello all,
>
> I was asked by a colleague of mine what the difference between task-clock and
> cpu-clock is. I found many similar questions on the web, but none have a final
> answer:
>
> http://stackoverflow.com/questions/23965363/linux-perf-events-cpu-clock-and-task-clock-what-is-the-difference
> https://lkml.org/lkml/2010/11/3/373
>
> Could someone explain the difference between the two counters for a non-kernel
> person? What is a task for that matter? When I compare the counters on test
> applications, they deviate only marginally.
>
> In general, is there hope for more documentation on the individual performance
> counters? Perf list shows what's available but has no information whatsoever
> about the actual meaning of the counters. It would be excellent to also
> explain how to interpret the counter, or in what case you'd want to look at a
> given event.
>
> Thanks
> --
> Milian Wolff
> mail@milianw.de
> http://milianw.de
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
