From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Sample memory references with at least a given latency?
Date: Thu, 5 Feb 2015 19:59:10 +0100
Message-ID: <20150205185910.GT3552@two.firstfloor.org>
References: <54D21524.8010305@bsc.es>
 <87bnl8jnwf.fsf@tassilo.jf.intel.com>
 <54D3BC55.1050302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:48925 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbbBES7M (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Feb 2015 13:59:12 -0500
Content-Disposition: inline
In-Reply-To: <54D3BC55.1050302@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Harald Servat <harald.servat@bsc.es>, linux-perf-users@vger.kernel.org

On Thu, Feb 05, 2015 at 07:54:13PM +0100, Manuel Selva wrote:
> What information is present in the samples recorded by perf record
> (on which ocperf relies) ?

man perf_event_open
man perf-record

It depends on what options you pass to record. As of the latest kernel
practically everything in PEBS is supported. Before that the GPRs were missing.
You can get for example memory source, address or TSX information.

-Andi
