From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf record and intel_cqm/llc_occupancy
Date: Thu, 23 Jun 2016 13:53:38 -0700
Message-ID: <8760szocdp.fsf@tassilo.jf.intel.com>
References: <etPan.576ab1e0.2383613b.84d3@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23378 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbcFWUxj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Jun 2016 16:53:39 -0400
In-Reply-To: <etPan.576ab1e0.2383613b.84d3@cern.ch> (Omar Awile's message of
	"Wed, 22 Jun 2016 15:42:25 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Omar Awile <omar.awile@cern.ch>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Aram Santogidis <aram.santogidis@cern.ch>

Omar Awile <omar.awile@cern.ch> writes:
>
> Is it possible that for intel_cqm/llc_occupancy interrupts are not
> supported?5A

Interrupts wouldn't be meaningful on these counters because they
don't count continuous events, but just report the current cache
occupancy. So yes.

You can use perf stat -I ... instead to get a time series.

-Andi
