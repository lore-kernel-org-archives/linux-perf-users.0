Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192D1C84DE;
	Mon,  8 Sep 2025 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757308864; cv=none; b=iMVtXQsOJKPuGEhBAAeZCPZLQ5K3GdrgSTwfydu8XUzGcOj3HQqJwEep106wrayJTd8NRhb8mRZgIedS6QH+x2bD9tJewpPAH5+FAqIX+ucy+T32l85/o7R55YPbeLdgFuLJtCs+O1gcW0dUTIsUcIcXEN6LiBpVtdsxY25hJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757308864; c=relaxed/simple;
	bh=iAwstC8y2DiefUo51/NJsLn5S7J4lrCrJIGQIENgdA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsij24KUL5vBeEbQhp0g1S9PpqewANM4zn/8lUCMinhoDTpyjq50A9WqAHJYPBVSpy0nMTDpyDjL72r60jt0U0NenEEiUKnXttbOWWcO/+Cw2g+91tcgvrf06PCvfLbS0Y95ymGTsctzUKdwmjylDhsa/GJ3aKddweHl5cOFdeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXixhhsa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXixhhsa"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso2497870a91.0;
        Sun, 07 Sep 2025 22:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757308862; x=1757913662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z309ZEqczozAMKKKB/xzAoGf/4FE4TavsEKgcsqpes=;
        b=VXixhhsaZS4caeIwhkfvYM3royubm8KKVZFFzoduCa6z2bTca9eRHfyHT7fqnv9pJA
         OrDwdQDL+1o1aPcTvzIuxUNNVwLqvCSoqRiLxUnDZKtzhlqiSgb41ctZHoZ9YzptBk2B
         vxjrv/tSVDwTfw6nPEYzkO7ibfJ9oPeBroBuDfYyOQWLQoNH7bzv4MTq9nWXsTUP98iB
         31RcpkF1x5cBJkS0Sk/FAj2QJRoXAjW7Fzhlw0JHsj5HXeOzfCxZ1etwPUkejgss4Y78
         oflDEARVZdZFIUYRzJio4tEeptaDcDM6tBdQheHFCeH2tOvve5KqeTnf2Crs3Ajpv31I
         D4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757308862; x=1757913662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z309ZEqczozAMKKKB/xzAoGf/4FE4TavsEKgcsqpes=;
        b=PGa2aNobPYUmGP2w1W8/cJVbmUqDdyf8l12DWEIqsb293gU06T7kYRZ7Sje/OCHsLd
         e3h+ezMT2XCDToQam4i4YtjAmGMw62Y5z+GekoLfsbaKdpcLU834hN0uk3dRczk3zbiS
         F8Y4JOnl2dMP2eSgVWXq4UicRbKJAQenk5/bWCulaZK389bQcGy9SlicNWvWDHwn/A6T
         FM7oLXqReyUdEqS25DKO/BcZ+glQiFD1GljLeTiSXdSTPe1cnHBAzWxYpnmRktM48Jku
         zKSzXHwN3kbIOAeL4CbEfgNWAzRtmO4T4h3D8jHxkcDCKso2X6tI3vbWtu5fyPFCH1Bp
         o/5g==
X-Forwarded-Encrypted: i=1; AJvYcCUcE9IgZfnD2sVK7vbh5/RKe8YudUMjC86smr4JNSSngaVX0hKZKltsC5Ao+Mkn5H0mIqUv+EPgdDYPQRBZkQrVEFW+@vger.kernel.org, AJvYcCV139fWcbx19KyZHavPAAV6KprZdjuTWyzKVaPv5mvfac4pM7eW8esGCw4qh3s+mHCrFqRRXS9g9MmFcKG3jdOTjA==@vger.kernel.org, AJvYcCW6Z3jYWyMXJqQqnKJ4+LPuwfcEKurlfQXDUE6JUCGFMUEc2cEOFpGxBhtuOMoejn/P5IMb7R3q4FRfIqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP7VGlatPYvpLa9p5EGLJRXqN/oig/38HbNJX3dFRhi+V8zHYK
	8nMnTDyW1PwMezZdsvKdxYD8zLy111wBWiAcw7JneRt5ElF8SIwxEYp6
X-Gm-Gg: ASbGncvIL1RduxS8O4gJsfA1Hr2u+bkaYqU6OS3YAQSZ97S5d/2ZS2KrSqj8ceBo7MY
	av0eqw1wwB/mvgriiPgQ6a9GL+KEydx9NB5jZ5YSTji063OmWua7P3hZU21USOsJlq2UJgehz8i
	7euND8Fbg8hphtiUDU4RR3H8V1Nxb98uAWNslc0L5HvfKuZ0C+KQyyaN7PMf53GW3Jh5ccYgXJ5
	A/OCvNpST+3FSJ7Bp+sdai8YWy/bQD3MfsLjtbNYdzoTXNGuRVyZB0hb+Ik/GwRZtAxc4DcgDR0
	dlCw6pN74jTNTWEN74AIKsYe1wcYSgkPevEg3pleW2ikcgy5yCP5qU7sgtzlYxhzPE0R7vx2aSf
	JT7Jy21RN0eHxnZ8opHuKjb5yz19E/7KyQxNAMHRBalq8
X-Google-Smtp-Source: AGHT+IGPcXqmogWZILkA0EiWDB3UUSk4oq5HV5nWmW/FIF6iyzxQCslm6c7L4gk90ECEmg86Ndwr/A==
X-Received: by 2002:a17:90b:4ac9:b0:32b:dfd5:3527 with SMTP id 98e67ed59e1d1-32d43f2e436mr8617642a91.9.1757308862448;
        Sun, 07 Sep 2025 22:21:02 -0700 (PDT)
Received: from localhost ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb15f50d6sm11758299a12.0.2025.09.07.22.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:21:01 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:20:51 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/18] x86/hw_breakpoint: introduce
 arch_reinstall_hw_breakpoint() for atomic context
Message-ID: <aL5ns7h1NaoD9LPg@mdev>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-6-wangjinchao600@gmail.com>
 <20250904063832.GT4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904063832.GT4067720@noisy.programming.kicks-ass.net>

On Thu, Sep 04, 2025 at 08:38:32AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 04, 2025 at 08:21:02AM +0800, Jinchao Wang wrote:
> > Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
> > parameters (address, length, type) without freeing and reallocating the
> > debug register slot.
> > 
> > This allows atomic updates in contexts where memory allocation is not
> > permitted, such as kprobe handlers.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  arch/x86/include/asm/hw_breakpoint.h |  1 +
> >  arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> > index 0bc931cd0698..bb7c70ad22fe 100644
> > --- a/arch/x86/include/asm/hw_breakpoint.h
> > +++ b/arch/x86/include/asm/hw_breakpoint.h
> > @@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> >  
> >  
> >  int arch_install_hw_breakpoint(struct perf_event *bp);
> > +int arch_reinstall_hw_breakpoint(struct perf_event *bp);
> >  void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> >  void hw_breakpoint_pmu_read(struct perf_event *bp);
> >  void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
> > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > index b01644c949b2..89135229ed21 100644
> > --- a/arch/x86/kernel/hw_breakpoint.c
> > +++ b/arch/x86/kernel/hw_breakpoint.c
> > @@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Reinstall a hardware breakpoint on the current CPU.
> > + *
> > + * This function is used to re-establish a perf counter hardware breakpoint.
> > + * It finds the debug address register slot previously allocated for the
> > + * breakpoint and re-enables it by writing the address to the debug register
> > + * and setting the corresponding bits in the debug control register (DR7).
> > + *
> > + * It is expected that the breakpoint's event context lock is already held
> > + * and interrupts are disabled, ensuring atomicity and safety from other
> > + * event handlers.
> > + */
> > +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> > +{
> > +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > +	unsigned long *dr7;
> > +	int i;
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	for (i = 0; i < HBP_NUM; i++) {
> > +		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> > +
> > +		if (*slot == bp)
> > +			break;
> > +	}
> > +
> > +	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
> > +		return -EINVAL;
> > +
> > +	set_debugreg(info->address, i);
> > +	__this_cpu_write(cpu_debugreg[i], info->address);
> > +
> > +	dr7 = this_cpu_ptr(&cpu_dr7);
> > +	*dr7 |= encode_dr7(i, info->len, info->type);
> > +
> > +	/*
> > +	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> > +	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> > +	 */
> > +	barrier();
> > +
> > +	set_debugreg(*dr7, 7);
> > +	if (info->mask)
> > +		amd_set_dr_addr_mask(info->mask, i);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
> 
> Yeah, I think not. For one this is an almost verbatim copy of
> arch_install_hw_breakpoint() with zero re-use. Surely you've been taught
> better?
I introduced this to modify bp_addr in atomic context in my RFC series.
I thought it was clearer to split the introduction and refactor.
And then It was used in the wprobe series, so I left it as introduced
in the RFC series.

I agree your suggestion is right. I am willing to refactor after wprobe.

> 
> And why would we want to export guts like this?
I wanted to introduce a real-time stack corruption debugging tool,
which needs a helper to change bp_addr in atomic context (kprobe handler).
And wprobe needs it also.
