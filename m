Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2956766;
	Mon,  8 Jul 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437310; cv=none; b=ERRoyRsmGNJKOPh4IcuJwNnhcOniV08Azu7+rY8FcHMDoO689pjvXIV+vhNe0tR4UNQsdYJhbAfRS3dj90MjM4Qdf2ILihjkSBKnMH6xYrmMOx42uvHFSA03/++jLqYhi5J2ZXBfMEd77nVDkSwztpEBVH760dH7tcpz3yHOEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437310; c=relaxed/simple;
	bh=MKgpxLh6aDM5ly4yBJOmK4CJOZT0PS1xUqiDWOzoQuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUfgCp+jFE3pwUkB/Kbg1KJGVzfhlIO8xSfs6ET5Vphi3kqXJJQD9JSnC8pb6kxGWNZQ21DsoTRq4c7V+h9xzZIqnb1hmSSOhU0mRdO31mPEmI42htC2K2Re4QqlJn8xFsgBO2K71AOELtHx5PRXI0ir/CEmDHpH9byfBLdb+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7ObckCB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7ObckCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070BFC116B1;
	Mon,  8 Jul 2024 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720437309;
	bh=MKgpxLh6aDM5ly4yBJOmK4CJOZT0PS1xUqiDWOzoQuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7ObckCBJqYgVbTWmIuilgBXfq7fXrZsEd/VkbxyKAtpmfeKEqQbtq81uKeftR7kW
	 XGd1iJqmfSSD7fHojNeAXrYOq2/E2Uf85Sbr594Lm7w4LN3HvDn0u0ZtnuYTDtC/pJ
	 a2mPz2ObVAf2mfXiCEZeL/mo5hJRPFlDX3VVzD2CeMG3l1ONJ/bkGnCOuO3XTdfAdW
	 4oPjoN06mNzMyFOzykzHpq7TtA2VH5L93ws7ebAWPdQ9csgH0Nh1LCLjunGoQZZp+m
	 EZMmQ+kpon6I3tg3Fi0LgiwowZU2Pc2VQWOARqr5YePKVmy+s7dRA7Pc2W6B3isLzA
	 lHGS0nusWyBrA==
Date: Mon, 8 Jul 2024 12:15:03 +0100
From: Will Deacon <will@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf: Add perf_event_attr::bp_priv
Message-ID: <20240708111503.GA11567@willie-the-truck>
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
User-Agent: Mutt/1.10.1 (2018-07-13)

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
> bp_type, bp_addr and bp_len

I disagree, as these are properties specific to hw_breakpoint. Privilege
is not.

> , the meaning of bp_priv field is
> explicit and different with exclude_{user,kernel,hv} fields.

How? You're changing the user ABI here, it needs to be properly justified.

> Additionally, there is only 1 bit for exclude_{user,kernel,hv},
> but bp_priv field has at least 2 bit according to the explanation
> of Arm Reference Manual. At last, the initial aim is to remove
> the check condition to assign the value of hw->ctrl.privilege.

Why? What problem is hw->ctrl.privilege causing?

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

You're just quoting bits of the Arm ARM. The architectural permission
checking is much more complicated and takes into account all of the PAC,
HMC, SSC and SSCE fields, but Linux doesn't need to care about most of
that because it's only managing user, kernel and possibly hypervisor.
These three can be expressed with the exclude_ options that we already
have.

So I really don't understand the rationale here.

Will
