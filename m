From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Understanding perf mem -t load results
Date: Tue, 24 Dec 2013 03:18:22 +0100
Message-ID: <20131224021822.GH20765@two.firstfloor.org>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
 <877gb5vmmn.fsf@tassilo.jf.intel.com>
 <52AE2721.8020501@insa-lyon.fr>
 <20131215234548.GP21717@two.firstfloor.org>
 <CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com>
 <CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:53518 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab3LXCSZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 Dec 2013 21:18:25 -0500
Content-Disposition: inline
In-Reply-To: <CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

> In my experiments I get LFB samples with weight equal or greater than
> local RAM samples, I should I interpret these values ?

The measured latency can include the pipeline latency.

> Moreover, because I am more interested in identifying remote memory
> accesses sources than in effective load latency weight, I am wondering
> if using the perf mem tool (using the
> MEM_INST_RETIRED.LATENCY_ABOVE_THRESHOLD event) is the best solution.
> Couldn't I use sampling on other events such as UNCORE ones more
> easily and efficiently ?

You cannot use uncore events to sample on IPs. 

-Andi
