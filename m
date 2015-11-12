From: Andi Kleen <andi@firstfloor.org>
Subject: Re: restricting counted/sampled events
Date: Thu, 12 Nov 2015 14:58:45 -0800
Message-ID: <87fv0a3jve.fsf@tassilo.jf.intel.com>
References: <5644D7DA.7050200@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40451 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270AbbKLW6q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 17:58:46 -0500
In-Reply-To: <5644D7DA.7050200@suse.de> (Tony Jones's message of "Thu, 12 Nov
	2015 10:18:02 -0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-perf-users@vger.kernel.org

Tony Jones <tonyj@suse.de> writes:

> I don't believe there is current support to do this,  but maybe I'm overlooking something?

It may be possible in systemtap, but not in the builtin tracers yes.
>
> I'd like to be able to restrict the pmu (or filter results) to report counting/sampling between two arbitrary code points,  such as a tracepoint or kprobe.
>
> I believe it will require core perf changes and was curious on peoples thoughts?

I'm not sure about messing with sampling (you can always filter that
later).

But able to collect PMU counter values are kprobes/tracepoints would be
fairly useful yes. It shouldn't be that difficult to do.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
