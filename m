From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [Question] about symbol__get_source_line() in util/annotate.c
Date: Thu, 23 Feb 2017 14:26:40 +0900
Message-ID: <20170223052640.GB30710@sejong>
References: <13ff5742-c651-0211-c0e0-0961c2d1ab64@gmail.com>
 <20170223051413.GA30710@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:37392 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdBWF1c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Feb 2017 00:27:32 -0500
Content-Disposition: inline
In-Reply-To: <20170223051413.GA30710@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taeung Song <treeze.taeung@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>, kernel-team@lge.com

On Thu, Feb 23, 2017 at 02:14:13PM +0900, Namhyung Kim wrote:
> Hi Taeung,
> 
> On Thu, Feb 23, 2017 at 12:31:08PM +0900, Taeung Song wrote:
> > 2) Why use the if statement as below ?
> > 
> >     if (percent_max <= 0.5)
> >             goto next;
> > 
> > I think it is more correct to use 0.0 instead of 0.5
> > 
> > What do you think about that ?
> 
> Well, I think that the summary line doesn't want to show too many
> (small) lines.  Using 0.0 instead seems meaningless though.

Ah, that includes 0 percent..

Anyway I can see print_summary() uses MIN_GREEN for this.  We can use
it here instead of the magic number, or might change it to something
different if needed.

Thanks,
Namhyung
