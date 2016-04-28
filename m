From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Comparing output of two perf cpu profiling reports
Date: Thu, 28 Apr 2016 11:16:43 -0300
Message-ID: <20160428141643.GA3386@kernel.org>
References: <CAPe7T+9fYXHWa7X4x-su6LujYuOFv7BB7j-jCcdH-hw3oQM9Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56960 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbcD1OQs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Apr 2016 10:16:48 -0400
Content-Disposition: inline
In-Reply-To: <CAPe7T+9fYXHWa7X4x-su6LujYuOFv7BB7j-jCcdH-hw3oQM9Vw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Davis <markdavisinboston@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>

Em Thu, Apr 28, 2016 at 09:27:07AM -0400, Mark Davis escreveu:
> Hi, what is the recommend way to compare two different perf reports
> from CPU event profiling (via sampling with perf record)?

> I'm comparing two macro benchmarks, with a couple small implementation
> details between the two.

> Right now I'm manually comparing the output of perf report to
> determine the salient differences.

> However, I'm wondering if there's a tool or otherwise best practice to
> essentially "diff" the two outputs.

> I could just use diff on the --stdio version of the reports, but
> sometimes lines get mangled and I loose context/hierarchy.

Can you try:

perf diff --help

- Arnaldo
