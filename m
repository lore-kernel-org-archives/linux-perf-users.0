From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: User defined metrics for perf stat?
Date: Mon, 1 Feb 2016 14:15:40 -0300
Message-ID: <20160201171540.GB20817@kernel.org>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44852 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbcBARPx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 1 Feb 2016 12:15:53 -0500
Content-Disposition: inline
In-Reply-To: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Sun, Jan 31, 2016 at 05:53:49PM +0100, Andreas Hollmann escreveu:
> Hi,
> 
> is there any way to create user defined metrics in perf stat?
> 
> Many hardware performance counters make only sense if you relate them
> to other counters, so it would be nice to have it in perf.

I think what you want is the 'perf stat recording' feature that was
recently merged, contributed by Jiri Olsa, that I am CCing this reply.
Jiri, is there something still to be merged in that series?

- Arnaldo
 
> I thought that I have seen something like that, but I coundn't find it again.
