From: David Ahern <dsahern@gmail.com>
Subject: Re: Appended data not reportable
Date: Fri, 04 Jan 2013 16:17:44 -0700
Message-ID: <50E76318.8040805@gmail.com>
References: <50E75786.4040902@nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:64113 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab3ADXRs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Jan 2013 18:17:48 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so9382912pbb.11
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Jan 2013 15:17:47 -0800 (PST)
In-Reply-To: <50E75786.4040902@nist.gov>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Flater <dflater@nist.gov>
Cc: Perf Users <linux-perf-users@vger.kernel.org>

On 1/4/13 3:28 PM, David Flater wrote:
> With kernel/perf 3.7.1, trying to do something akin to the "sum" option of
> gprof to pool the samples from multiple runs.
>
> This option from the perf-record man page looked promising:
> -A, --append
>      Append to the output file to do incremental profiling.
>
> bash-4.2$ perf record -F 1000 ./app
> bash-4.2$ perf record -F 1000 -A ./app
>
> perf.data gets bigger, but then neither perf report nor perf script work.  Both
> say:
> 0x1a0 [0]: failed to process type: 0
>
> Is this a regression?

It's been broken for a long time now.

David
