Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CCC3806AF;
	Thu,  7 May 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143590; cv=none; b=Cs40hz94UqWxzN8sO/E6Y7tj0klm3noODtL2AWFSVgvYzd1ruhWcHYcQoojDfzNfaM2EVo9PaB3s4Hry5LEwohp/pSOc6wKLdmxkgFihpZ3amY9I8LNDHGy2plLDibuLeWXyeSCATvlD76orRaeGEzpVlAlqv2ii2bJJR4lYy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143590; c=relaxed/simple;
	bh=xN6s8qTCagkaRUEyuSIWh9m+rNdxQUEhlkayhoY6VAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi7LClkZHgpWRwO0Vg9MJ8e2JG1lDdBC6jbZmCohSA74yiDo4vwwyg0U5W/sUDnBR2i/s2+Lwk2DndXGJm/DzzClOZ8B9E6cYf6OH7Poxc2fVZQe+uxjGGPZHaopnAsE+L30qC2JKqkVHV+uqMdtCxe2Mgkdjq73bpllzo4jZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mEGUx7lK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mEGUx7lK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lRnM4fFKPPMoEdkTS+bDMQuR7pEpTZgpnipU4NMWWWo=; b=mEGUx7lKjwMMXn1aZgT5RnbhKM
	jFceouLYIULOyIUk68GqwF2iEmy4ROYD14iCPqjZmRvAHsl1LjAUEUHFbVBdvilnUSnnGgBHYFdMg
	dWw/l8A7YCdY420WsF0qXoHwj+z+gzP7bwJ/TXQf4zjsqcQB/ojfMWFQ2kt0Q50+9Tz599g1m71vx
	g4LDyjD0+FNJ4G45sv2xukjTiN1AMB83KqFF81nSue35F9GrbKkfKb7KaDe+umzhn1BpjBro5mfFZ
	1ajrJtYQC1IXPSiTPLvPcYU2su3qJCSaKkU51B/hpVVCloPGyPGF2gzYoc+D0oFGsrbaLAy/J47tD
	GBtnqkZg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKuN5-00000002xQR-2bSx;
	Thu, 07 May 2026 08:46:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F13E3008D6; Thu, 07 May 2026 10:46:15 +0200 (CEST)
Date: Thu, 7 May 2026 10:46:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] perf/x86: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <20260507084615.GP1026330@noisy.programming.kicks-ass.net>
References: <afJcDg1I5ZU5ZkXf@kspp>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afJcDg1I5ZU5ZkXf@kspp>

On Wed, Apr 29, 2026 at 01:29:18PM -0600, Gustavo A. R. Silva wrote:

> +	/*
> +	 * Intel LBR bits
> +	 */
> +	int				lbr_users;
> +	int				lbr_pebs_users;
> +	union {
> +		struct er_account		*lbr_sel;
> +		struct er_account		*lbr_ctl;
> +	};
> +	u64				br_sel;
> +	void				*last_task_ctx;
> +	int				last_log_id;
> +	int				lbr_select;
> +	void				*lbr_xsave;
> +
> +	/* Must be last as it ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct perf_branch_stack, lbr_stack, entries,
> +		struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
> +		u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
> +	);

FWIW, this thing is horrible crap. Per construction this thing does not
need to be last at all, you can have multiple such constructs in a
single structure and things would be perfectly fine.

Also, your TRAILING_OVERLAP() thing should probably have
__no_randomize_layout in ATTRS, rather than empty (and I'm assuming
__packed implies __no_randomized_layout, otherwise 'fun' things can
happen).

>  };
