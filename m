From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Adding cache misses and references to list of default events for perf stat?
Date: Tue, 04 Nov 2014 12:16:25 -0800
Message-ID: <87mw86k9gm.fsf@tassilo.jf.intel.com>
References: <2902317.tSPbunES6b@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4229 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbaKDUQ1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Nov 2014 15:16:27 -0500
In-Reply-To: <2902317.tSPbunES6b@milian-kdab2> (Milian Wolff's message of
	"Tue, 04 Nov 2014 17:44:35 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org

Milian Wolff <mail@milianw.de> writes:

> Hello all,
>
> could we have the cache-references,cache-misses events added to the list of 
> default events for perf stat? I think it is a very valuable metric for all 
> user-space applications.
>
> Currently, I run perf stat twice, once with the default events, and once with
>
> perf stat -e cache-references,cache-misses ...
>
> there is no easy way to append two events to the list of default events.
>
> So, what do you think?

On most systems with only four counters it'll start multiplexing, which
will give much worse results. Defaulting to non multiplexing is much
better.

Reproducing the standard perf stat output isn't that difficult. It's 

perf stat -e task-clock,cs,migrations,page-faults,cycles,instructions,branches,branch-misses

and then add more events. If you remove the bogus stalled-* events you
have even two free counters.

If you exceed four you should define appropiate groups with {} 

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
