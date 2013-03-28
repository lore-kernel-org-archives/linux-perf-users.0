From: kernel kernel <kernel@kenobrien.org>
Subject: Re: Perf feature?
Date: Thu, 28 Mar 2013 18:05:53 +0000
Message-ID: <CAG=jzgB5vJAgzRhXGeLsFCivP2rE278zN2Av3sF-QkZStqTtUg@mail.gmail.com>
References: <CAG=jzgBF7qVc4LE=cMrMp3+_8h8HuRaMi3OHn510vJSGd1YN-w@mail.gmail.com>
	<alpine.DEB.2.02.1303261358560.9710@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:61851 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab3C1SF4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Mar 2013 14:05:56 -0400
Received: by mail-vc0-f173.google.com with SMTP id gd11so8036535vcb.32
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Mar 2013 11:05:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1303261358560.9710@pianoman.cluster.toy>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vince@deater.net>
Cc: linux-perf-users@vger.kernel.org

Thanks. I will try out both options.

On Tue, Mar 26, 2013 at 6:02 PM, Vince Weaver <vince@deater.net> wrote:
> On Tue, 26 Mar 2013, kernel kernel wrote:
>
>> Is it possible to use perf to record the performance counters of
>> specific lines of code instead of the entire program?
>
> If you want exact counts (i.e., these three lines of code had exactly
> 20 branch misses) you'll need to instrument your code using a library like
> PAPI, or else insert raw perf_event calls yourself before and after
> the lines of interest (see the example at the end of the perf_event_open
> manpage).
>
> Doing self-monitoring like this introduces a certain amount of overhead
> into your program and measurements.
>
> Vince



-- 
Ken O'Brien
PhD Researcher
Simulation Science and Extreme Events Cluster,
3B1, UCD CASL,
8 Belfield Business Park,
Dublin 4,
Ireland.
