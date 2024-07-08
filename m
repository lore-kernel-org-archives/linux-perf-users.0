Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6822095;
	Mon,  8 Jul 2024 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424274; cv=none; b=OJKcVrCATg7s0uxuAp3TiGoy9P9XSAR2FlcBLPur+uV4FnawvGHWWhlJxGnASeNnM2/2LfaJtGkUAqXySVW/hXAz3uQdj/o/wXh7rgs89A2b5nsG6r61yuuJtSOgslRosAxkuT5mWndH6HGYaHgsmBY77KGjL7dpRgcXULazLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424274; c=relaxed/simple;
	bh=g4o1xr6Crafi9yRcowpsJLGwb+QAGSmp73mOaSOPxY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7SItwn11U3d5KAEl5nKglkYXYcR9Dsa3WOXT535dCLfw+a3aqZykQGhkSiMnKBOmvznFlGPqeG+n+LyPrr2pKyMS+kc/+nJvvi1wrng9lqYTM+KjmA7uYAH2I3WoUhMmWp9nh1SQK84P9xO70UFbdCwi2zaol2G92DU5h8z0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cp1GYETU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cp1GYETU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+JO92pEYx4L3Ve/o9tRJ/weO2h9oGuUkMq71ljyT/1Q=; b=cp1GYETUXi0udWp/tFqovjeI+Q
	TxP2JiTPB4qQ6Z6Q3KqGLtXQ/2wJq4HmR1dCNjwquNSLdll5GLWvFgUnmNz/jE5bLSseM7V8dgCAX
	OPy7ikU/pMO46Yc/6dgsMqo+BiwvbsIjoZGG/xTHwwk4r0U9B4yAcYmFaFDjqqsRG39QtySIBKPlf
	brIIA+BwEKF7Hxhl647iBWyj0e2YDNCI30MWPkZPglVvhxJEtiwStjrB7yDE+KQUZBkWW6sHzj1MU
	t3qeseUAmGmuJY+HiuaSoAVdqepB8jVaaNWsDkEpM35ylIHnO9yvfrLlWYc+U4nq94qWSsO3LnOrS
	NsTRY3kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQivg-00000000ZEc-0Hnk;
	Mon, 08 Jul 2024 07:37:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C0595300694; Mon,  8 Jul 2024 09:36:52 +0200 (CEST)
Date: Mon, 8 Jul 2024 09:36:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf: Add perf_event_attr::bp_priv
Message-ID: <20240708073652.GE11386@noisy.programming.kicks-ass.net>
References: <20240621073910.8465-1-yangtiezhu@loongson.cn>
 <20240621073910.8465-2-yangtiezhu@loongson.cn>
 <20240705103413.GA8971@willie-the-truck>
 <7522fc14-aacc-a8e3-3258-9064d7e2936f@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7522fc14-aacc-a8e3-3258-9064d7e2936f@loongson.cn>

On Sat, Jul 06, 2024 at 01:31:03PM +0800, Tiezhu Yang wrote:
> 
> 
> On 07/05/2024 06:34 PM, Will Deacon wrote:
> > On Fri, Jun 21, 2024 at 03:39:08PM +0800, Tiezhu Yang wrote:
> > > Add a member "bp_priv" at the end of the uapi struct perf_event_attr
> > > to make a bridge between ptrace and hardware breakpoint.
> > > 
> > > This is preparation for later patch on some archs such as ARM, ARM64
> > > and LoongArch which have privilege level of breakpoint.
> > > 
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > >  include/uapi/linux/perf_event.h | 3 +++
> > >  kernel/events/hw_breakpoint.c   | 1 +
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index 3a64499b0f5d..f9f917e854e6 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -379,6 +379,7 @@ enum perf_event_read_format {
> > >  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
> > >  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
> > >  #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
> > > +#define PERF_ATTR_SIZE_VER9	144	/* add: bp_priv */
> > > 
> > >  /*
> > >   * Hardware event_id to monitor via a performance monitoring event:
> > > @@ -522,6 +523,8 @@ struct perf_event_attr {
> > >  	__u64	sig_data;
> > > 
> > >  	__u64	config3; /* extension of config2 */
> > > +
> > > +	__u8	bp_priv; /* privilege level of breakpoint */
> > >  };
> > 
> > Why are we extending the user ABI for this? Perf events already have the
> > privilege encoded (indirectly) by the exclude_{user,kernel,hv} fields in
> > 'struct perf_event_attr'.
> 
> IMO, add bp_priv is to keep consistent with the other fields
> bp_type, bp_addr and bp_len, the meaning of bp_priv field is
> explicit and different with exclude_{user,kernel,hv} fields.

In case it wasn't obvious, this structure has __u64 granularity. You
don't just add a __u8 to the end. Also, since you mention consistency,
you might have noticed those other bp_ fields are in a union on
config[12], so why can't this live in a union on config3 ?

> Additionally, there is only 1 bit for exclude_{user,kernel,hv},
> but bp_priv field has at least 2 bit according to the explanation
> of Arm Reference Manual. At last, the initial aim is to remove
> the check condition to assign the value of hw->ctrl.privilege.
> 
> https://developer.arm.com/documentation/ddi0487/latest/
> 
> 1. D23: AArch64 System Register Descriptions (Page 8562)
>    D23.3.11 DBGWCR<n>_EL1, Debug Watchpoint Control Registers, n = 0 - 63
>    PAC, bits [2:1]
>    Privilege of access control. Determines the Exception level or levels at
> which a Watchpoint debug
>    event for watchpoint n is generated.
> 
> 2. G8: AArch32 System Register Descriptions (Page 12334)
>    G8.3.26 DBGWCR<n>, Debug Watchpoint Control Registers, n = 0 - 15
>    PAC, bits [2:1]
>    Privilege of access control. Determines the Exception level or levels at
> which a Watchpoint debug
>    event for watchpoint n is generated.

That's all clear as mud for someone that don't speak arm. Can you please
provide a coherent reason for all this that does not rely on external
resources?

