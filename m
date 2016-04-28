From: Mark Davis <markdavisinboston@gmail.com>
Subject: Re: Comparing output of two perf cpu profiling reports
Date: Thu, 28 Apr 2016 10:17:39 -0400
Message-ID: <CAPe7T+-siZXrqfUjktdoJmap=d77XB9YMs=QLyA0_rXUVwq7CQ@mail.gmail.com>
References: <CAPe7T+9fYXHWa7X4x-su6LujYuOFv7BB7j-jCcdH-hw3oQM9Vw@mail.gmail.com>
	<20160428141643.GA3386@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34752 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbcD1ORk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Apr 2016 10:17:40 -0400
Received: by mail-oi0-f68.google.com with SMTP id b10so14507458oig.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2016 07:17:40 -0700 (PDT)
In-Reply-To: <20160428141643.GA3386@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>

Yeah, that would do it. Thanks to you both, Alex and Arnaldo!

On Thu, Apr 28, 2016 at 10:16 AM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Thu, Apr 28, 2016 at 09:27:07AM -0400, Mark Davis escreveu:
>> Hi, what is the recommend way to compare two different perf reports
>> from CPU event profiling (via sampling with perf record)?
>
>> I'm comparing two macro benchmarks, with a couple small implementation
>> details between the two.
>
>> Right now I'm manually comparing the output of perf report to
>> determine the salient differences.
>
>> However, I'm wondering if there's a tool or otherwise best practice to
>> essentially "diff" the two outputs.
>
>> I could just use diff on the --stdio version of the reports, but
>> sometimes lines get mangled and I loose context/hierarchy.
>
> Can you try:
>
> perf diff --help
>
> - Arnaldo
