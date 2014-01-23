From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Does perf record support event multiplexing?
Date: Wed, 22 Jan 2014 20:51:53 -0800
Message-ID: <874n4v1es6.fsf@tassilo.jf.intel.com>
References: <CAOJauOAJbbjP6kR_op4bzncDajjOZvN0YWf9+scYjpHrJeLTOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5313 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbaAWEvy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 22 Jan 2014 23:51:54 -0500
In-Reply-To: <CAOJauOAJbbjP6kR_op4bzncDajjOZvN0YWf9+scYjpHrJeLTOg@mail.gmail.com>
	(AmirReza Ghods's message of "Tue, 21 Jan 2014 13:34:15 -0500")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: AmirReza Ghods <ar.ghods@gmail.com>
Cc: linux-perf-users@vger.kernel.org

AmirReza Ghods <ar.ghods@gmail.com> writes:

> I noticed that "perf record" does not calculate the true value for the
> number of event's counts in the case of having more events than
> hardware counters.
> But in pef stat it does and there is a time interpolation algorithm
> for estimating and correcting the true value.
> Also I saw a patch for Perf's source code that implimented time
> interpolation for Perf in record mode but it did not include in the
> next official realses of Perf. I just want to know that is there any
> technical difficulty for implimenting this feature in "perf record" or
> not?

Why would you care about the exact sample count for perf report?

The only thing that counts in such a histogram is the percent
relationships, which would stay the same if the numbers
were scaled up.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
