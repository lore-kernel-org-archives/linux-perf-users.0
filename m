Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93220D46;
	Thu, 23 Nov 2023 09:15:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A9B1042;
	Thu, 23 Nov 2023 09:16:28 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B38C3F7A6;
	Thu, 23 Nov 2023 09:15:41 -0800 (PST)
Date: Thu, 23 Nov 2023 17:15:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>, Marc Zyngier <maz@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <ZV-ItX1eMeIdo_00@FVFF77S0Q05N.cambridge.arm.com>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org>
 <86o7fnyvrq.wl-maz@kernel.org>
 <ZV9gThJ52slPHqlV@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fW8exsmUg_9K09Oy6T4ZAvvD7ZbZN2sxODdqisZOR6mUA@mail.gmail.com>
 <ZV-CUlQhlkdOzfFZ@FVFF77S0Q05N.cambridge.arm.com>
 <96fa7b1a-9f64-315b-c767-e582db55c7a4@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96fa7b1a-9f64-315b-c767-e582db55c7a4@arm.com>

On Thu, Nov 23, 2023 at 05:08:43PM +0000, James Clark wrote:
> On 23/11/2023 16:48, Mark Rutland wrote:
> > Ah, so IIUC what's happening is:
> > 
> > 1) Userspace tries to detect extended type support, with a cycles event
> >    directed to one of the CPU PMUs. The attr for this does not have
> >    exclude_guest set.
> > 
> > 2) In the kernel, the core perf code sees the extended hw type id, and directs
> >    this towards the correct PMU (apple_icestorm_pmu).
> > 
> > 3) The PMU driver looks at the attr, sees exclude_guest is not set, and returns
> >    -EOPNOTSUPP, exactly as it would regardless of whether the extended hw type
> >    is used.
> > 
> >    Note: this happens to be a difference between x86 PMUs and the apple_* PMUs,
> >    but this is a legitimate part of the perf ABI, not an arm-specific quirk or
> >    bug.
> > 
> > 4) Userspace receives -EOPNOTSUPP, and so decide the extended hw_type is not
> >    supported (even though the kernel does support the extended hw type id, and
> >    the event was rejected for orthogonal reasons).

> > It sounds like we need to make (4) more robust? I'm not immediately sure how, 
> > given the rats nest of returns in perf_event_open(), but I'm happy to try to
> > help with that.
> 
> It might be worth reporting extended HW ID support in the caps folder of
> the PMU so that Perf can look there instead of trying to open the event.
> It's something that we know will always be on or always be off so it
> doesn't make sense to try to discover it by opening an event.

Yep, I'm open to that idea. I'm more than happy to expose something that
indicates "this PMU supports the extended HW ID" and/or "this kernel supports
the extended HW ID".

Given that the actual PMU drivers don't see the extended cap, and that's
handled by the core, I'd like to make the core logic unconditional and remove
the kernel-internal PERF_PMU_CAP_EXTENDED_HW_TYPE cap. So I'd lean towards the
"this kernel supports the extended HW ID" option.

Thanks,
Mark.
