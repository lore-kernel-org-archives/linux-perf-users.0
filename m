From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf sched record with -p option
Date: Thu, 8 Feb 2018 14:07:08 +0900
Message-ID: <20180208050708.GC24686@sejong>
References: <30C2D590D16A5C46ADFE65219103779892616691@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:45483 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeBHFHR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Feb 2018 00:07:17 -0500
Content-Disposition: inline
In-Reply-To: <30C2D590D16A5C46ADFE65219103779892616691@AZ-US1EXMB02.global.avaya.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, kernel-team@lge.com

Hello,

On Sun, Feb 04, 2018 at 05:31:07PM +0000, Vuille, Martin (Martin) wrote:
> The data files collected by 'perf sched record' are very large and our embedded
> system target has limited storage, so I thought of using the '-p PID' option on
> 'perf sched record' to focus only on a single PID and its threads/children and
> thus reduce the amount of data.
> 
> However, when I review the results with 'perf sched latency', the results from
> data collected with '-p PID' are significantly different (e.g., ten-times longer
> latencies) that those from data collected without the '-p PID' option. Workloads
> are the same.
> 
> Is there some reason why using '-p PID' option on 'perf sched record' wouldn't
> make sense?

I think it's because perf missed sched-in and wakeup events for the PID
since they are from different tasks.

Thanks,
Namhyung
