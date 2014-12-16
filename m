From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf probe failed to find symbols -
Date: Tue, 16 Dec 2014 08:46:41 -0300
Message-ID: <20141216114641.GR9845@kernel.org>
References: <050363D101EB63409B222217F4B02E781EC22E9F@G6W2492.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34259 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbaLPLqo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Dec 2014 06:46:44 -0500
Content-Disposition: inline
In-Reply-To: <050363D101EB63409B222217F4B02E781EC22E9F@G6W2492.americas.hpqcorp.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Chinnathambi, Muthusamy" <muthusamy.chinnathambi@hp.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Tue, Dec 16, 2014 at 03:18:24AM +0000, Chinnathambi, Muthusamy escreveu:
> I wanted try perf probe, but I am getting the following failure.
 
> [root@force perf_tests]# ./perf probe --add sys_read
> Failed to find symbol sys_read in kernel
>   Error: Failed to add events.
> [root@force perf_tests]#
 
> I had built and installed the kernel with kprobes enabled. Looks like
> the kernel is stripped, how should I build the kernel for perf to be
> able to find symbols.

In addition to what David said, you can try using -v to get more verbose
error messages that could provide you some extra clue about what is
happening, also please check the other perf probe options, like the one
that lists the available functions to probe (-F), etc.

- Arnaldo
