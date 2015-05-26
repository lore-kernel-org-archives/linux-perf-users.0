From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC] Add --show-total-period for perf annotate
Date: Tue, 26 May 2015 19:03:16 +0200
Message-ID: <20150526170316.GO19417@two.firstfloor.org>
References: <555F3F8A.6000204@suse.cz>
 <87mw0wc4vt.fsf@tassilo.jf.intel.com>
 <5562D33F.70706@suse.cz>
 <20150525151450.GK19417@two.firstfloor.org>
 <5564685D.1020204@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5564685D.1020204@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> Anyway, attached patch is capable of displaying milliseconds approximation for each instruction.

You realize that the events perf is not counting do not directly map to
wall time? Even if you count cycles, the cycles are either stopping in idle
or changing unit as the CPU's frequencies change. For other events the
relationship is even more remote, think what happens when counting cache or
TLB misses.

Also even if it was mapping to time somehow, it's just a hit, not a
duration, so it cannot say how long a individual instruction took.

So you cannot map a sample event to time.

To do what you want you would need to use something like processor
trace, which can do exact accounting.

I think the only thing that makes sense is to account it relative to 
the event counts.

-Andi
