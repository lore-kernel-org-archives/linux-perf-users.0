Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2723ABB3;
	Tue,  9 Sep 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404823; cv=none; b=AcfFug4i41zKBqLNs2JL3Q8n9pNnVw1NNMwgJRGUbEdjr/bqLVUg0iXf5dmCoF9p/kYpqCmwf0gAlB0Gt+QnFTVlyqL6uSobFUxfCYJwRMRNl+nsYCb2qLyDHe1i0W9ucKOuXgeanzje6/tlpkoamEChbCn657rqHMGrIgdPOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404823; c=relaxed/simple;
	bh=K7GblolWpH5vXVt7lV0OwPq0/5beVmtAVKdl40YTYVI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W3XXeaMCRIQYoBQO2vEEX6MwMZ61I3qzQ2TTFdrpOM53qpNFKDfIoHimMkj6SLyTTAxk/fYC+BdJON6nx+2ibdZX8hRDbGPiO64+YwSWtyQ9YNwlO0TN2UU/7LQZdHIpk/Ypo2XulqCDEGcvtLjpZyoFswlfdfcdQqxmlDHfqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob+6CPee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob+6CPee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9383C4CEF5;
	Tue,  9 Sep 2025 08:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757404822;
	bh=K7GblolWpH5vXVt7lV0OwPq0/5beVmtAVKdl40YTYVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ob+6CPeeInY7cEDDkLJkolERb1xruKi8RF2xolA3kA3KbGl+f1j4eHFnnB/FIpA3E
	 WGSSxLBq9AL+Wncf73XRrwALw7eckgNr6JjvUF/IYXphwn/PH4Z/3WZ69YK1XiTCr1
	 BEhynHQs4Ez+Plfb9/qgPBdgEGgHVpgkrWZPkDqZx0yFBAmGM5eE99BN9sDa8XnzpF
	 D0e+MpU4dMGo+o9G3tzQlFjPaPe/V0swBQ/SLNMmi3wjUaIViKYaMGc2oLmiPee/xH
	 vSpdnsRsjhYHXpQS3b0rTUNV0xNxrRdZt2js02hBb+vnDWkCxL/HoDjGbuFh0b59xF
	 G8ujjvYOmi+oQ==
Date: Tue, 9 Sep 2025 17:00:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "Naveen N . Rao" <naveen@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, David
 Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-perf-users@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/18] x86/hw_breakpoint: introduce
 arch_reinstall_hw_breakpoint() for atomic context
Message-Id: <20250909170017.dae27d8be77f9ec634e0d56c@kernel.org>
In-Reply-To: <aL5ns7h1NaoD9LPg@mdev>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
	<20250904002126.1514566-6-wangjinchao600@gmail.com>
	<20250904063832.GT4067720@noisy.programming.kicks-ass.net>
	<aL5ns7h1NaoD9LPg@mdev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 13:20:51 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> On Thu, Sep 04, 2025 at 08:38:32AM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 04, 2025 at 08:21:02AM +0800, Jinchao Wang wrote:
> > > Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
> > > parameters (address, length, type) without freeing and reallocating the
> > > debug register slot.
> > > 
> > > This allows atomic updates in contexts where memory allocation is not
> > > permitted, such as kprobe handlers.
> > > 
> > > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > > ---
> > >  arch/x86/include/asm/hw_breakpoint.h |  1 +
> > >  arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
> > >  2 files changed, 51 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> > > index 0bc931cd0698..bb7c70ad22fe 100644
> > > --- a/arch/x86/include/asm/hw_breakpoint.h
> > > +++ b/arch/x86/include/asm/hw_breakpoint.h
> > > @@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> > >  
> > >  
> > >  int arch_install_hw_breakpoint(struct perf_event *bp);
> > > +int arch_reinstall_hw_breakpoint(struct perf_event *bp);
> > >  void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> > >  void hw_breakpoint_pmu_read(struct perf_event *bp);
> > >  void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
> > > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > > index b01644c949b2..89135229ed21 100644
> > > --- a/arch/x86/kernel/hw_breakpoint.c
> > > +++ b/arch/x86/kernel/hw_breakpoint.c
> > > @@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * Reinstall a hardware breakpoint on the current CPU.
> > > + *
> > > + * This function is used to re-establish a perf counter hardware breakpoint.
> > > + * It finds the debug address register slot previously allocated for the
> > > + * breakpoint and re-enables it by writing the address to the debug register
> > > + * and setting the corresponding bits in the debug control register (DR7).
> > > + *
> > > + * It is expected that the breakpoint's event context lock is already held
> > > + * and interrupts are disabled, ensuring atomicity and safety from other
> > > + * event handlers.
> > > + */
> > > +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> > > +{
> > > +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > > +	unsigned long *dr7;
> > > +	int i;
> > > +
> > > +	lockdep_assert_irqs_disabled();
> > > +
> > > +	for (i = 0; i < HBP_NUM; i++) {
> > > +		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> > > +
> > > +		if (*slot == bp)
> > > +			break;
> > > +	}
> > > +
> > > +	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
> > > +		return -EINVAL;
> > > +
> > > +	set_debugreg(info->address, i);
> > > +	__this_cpu_write(cpu_debugreg[i], info->address);
> > > +
> > > +	dr7 = this_cpu_ptr(&cpu_dr7);
> > > +	*dr7 |= encode_dr7(i, info->len, info->type);
> > > +
> > > +	/*
> > > +	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> > > +	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> > > +	 */
> > > +	barrier();
> > > +
> > > +	set_debugreg(*dr7, 7);
> > > +	if (info->mask)
> > > +		amd_set_dr_addr_mask(info->mask, i);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
> > 
> > Yeah, I think not. For one this is an almost verbatim copy of
> > arch_install_hw_breakpoint() with zero re-use. Surely you've been taught
> > better?
> I introduced this to modify bp_addr in atomic context in my RFC series.
> I thought it was clearer to split the introduction and refactor.
> And then It was used in the wprobe series, so I left it as introduced
> in the RFC series.
> 
> I agree your suggestion is right. I am willing to refactor after wprobe.

I'm OK to refactor it to reuse arch_install_hw_breakpoint().
My point is to have CONFIG_HAVE_REINSTALL_HW_BREAKPOINT so that
we can easily implement the dependency for other features which
requires this feature in Kconfig level.

> > And why would we want to export guts like this?
> I wanted to introduce a real-time stack corruption debugging tool,
> which needs a helper to change bp_addr in atomic context (kprobe handler).
> And wprobe needs it also.

I agree with Peter, it should not expose the architecture
dependent code directly. Instead, we need a wrapper.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
