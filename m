From: Alex Bagehot <ceeaspb@gmail.com>
Subject: Re: Comparing output of two perf cpu profiling reports
Date: Thu, 28 Apr 2016 14:30:50 +0100
Message-ID: <CAHeneC__nhXwi=+wVwQUsFuCnHWORNJa49ppaVHxUzAVwAVzMQ@mail.gmail.com>
References: <CAPe7T+9fYXHWa7X4x-su6LujYuOFv7BB7j-jCcdH-hw3oQM9Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35080 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbcD1Nav (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Apr 2016 09:30:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id w198so9963852oiw.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2016 06:30:51 -0700 (PDT)
In-Reply-To: <CAPe7T+9fYXHWa7X4x-su6LujYuOFv7BB7j-jCcdH-hw3oQM9Vw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Davis <markdavisinboston@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi Mark,

Differential flame graphs is one way:
http://www.brendangregg.com/blog/2014-11-09/differential-flame-graphs.html

Thanks,
Alex

On Thu, Apr 28, 2016 at 2:27 PM, Mark Davis <markdavisinboston@gmail.com> wrote:
> Hi, what is the recommend way to compare two different perf reports
> from CPU event profiling (via sampling with perf record)? I'm
> comparing two macro benchmarks, with a couple small implementation
> details between the two. Right now I'm manually comparing the output
> of perf report to determine the salient differences. However, I'm
> wondering if there's a tool or otherwise best practice to essentially
> "diff" the two outputs. I could just use diff on the --stdio version
> of the reports, but sometimes lines get mangled and I loose
> context/hierarchy.
>
> Any tips?
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
