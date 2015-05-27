From: =?windows-1252?Q?Martin_Li=9Aka?= <mliska@suse.cz>
Subject: Re: [RFC] Add --show-total-period for perf annotate
Date: Wed, 27 May 2015 10:46:26 +0200
Message-ID: <55658462.1000605@suse.cz>
References: <555F3F8A.6000204@suse.cz> <87mw0wc4vt.fsf@tassilo.jf.intel.com> <5562D33F.70706@suse.cz> <20150525151450.GK19417@two.firstfloor.org> <5564685D.1020204@suse.cz> <20150526170316.GO19417@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49124 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbbE0Iq2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 May 2015 04:46:28 -0400
In-Reply-To: <20150526170316.GO19417@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

On 05/26/2015 07:03 PM, Andi Kleen wrote:
>> Anyway, attached patch is capable of displaying milliseconds approximation for each instruction.
>
> You realize that the events perf is not counting do not directly map to
> wall time? Even if you count cycles, the cycles are either stopping in idle
> or changing unit as the CPU's frequencies change. For other events the
> relationship is even more remote, think what happens when counting cache or
> TLB misses.
>
> Also even if it was mapping to time somehow, it's just a hit, not a
> duration, so it cannot say how long a individual instruction took.
>
> So you cannot map a sample event to time.
>
> To do what you want you would need to use something like processor
> trace, which can do exact accounting.
>
> I think the only thing that makes sense is to account it relative to
> the event counts.
>
> -Andi
>

Hello Andi.

I realize all aspects and capabilities of perf infrastructure. Even though
these numbers are not precise, I helped me a lot with debugging of a benchmark
which heavily utilizes a single CPU and runs in magnitude of seconds.

Ok, so let's convert the patch to feature that we can map an instruction
to a percentage number of events (cycles) it takes.

If I understand correctly, is it just about division of the number of events
related to an instruction and total number of events?

Thanks,
Martin
