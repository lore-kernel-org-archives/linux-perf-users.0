Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0B359A68
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936332; cv=none; b=XTWZ75IofeuGBbWqqGwvJ7LecKxJOKS4vuSt3gGvbiZzqhFZbk+Kb9LKrdgzd6U4veXKVNaqd91wYA2ZiH52Z2SVfo58SKGeB1VRdyoP7zzZbg9ozywFkCr9byoNishLNXbe3HzmVvjB1sxUf/KJQ66rU1+sbyemXDnHd1psuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936332; c=relaxed/simple;
	bh=LJR7EGLD5xxI6cgXnAVRPsXvMBsj4pll3N8x93MTuCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxdJWK/357VVEeaI96FXbF6S2H0Qe+q9malmzsCtgfAg5LqBWuGnevjNdIEPPmiF71IOf15KZWwnZaDkyDaB5f2a2UFVEfMGMf3fMuyp2we4Fv7QcTseZliMQNoaFzAGam1L41j9GkN1FJspGqqo1soJQlFfFLYnV52HNvyU0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F83bIdbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F83bIdbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E811F000E9;
	Fri, 28 Aug 2026 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787936329;
	bh=nlAc6dBl0gjSAbn1tpd1k2E5jR7qNDQhtE6tuysjdlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F83bIdbUpzhPh4fPtlk1UN6Wu66rpfoC9+NJtjz3UtWLGhCsbGwnFH+quD4gMQHAk
	 bJ4PYG4XuRGFpcIIBERffCaXgZJfcOuTR1MPsH8+8oJ5TqC7lkP1PiJq3kaFfqI3Dw
	 ZQDLluQd0/fPJipxXfKKHkxvIopMW2QmOp4NKGjcWvVkkss4SbT+MBoHotmVp6ntWa
	 DXLZaM4VC1LYNGTw/E7rpX7e5wlLvYdwkuxuGQM2Qf77FpQfhs452vJQ6ERxEHfBQA
	 r/QGCfdgy+OnHLO1q3z0VfdrT83OnYbWfBWS/W5cZACfugC6tUngTrg0GaEXhoKnXK
	 TcRxENCap9zcQ==
Date: Fri, 28 Aug 2026 09:58:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Gennady Kupava <gennady.kupava@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
Message-ID: <apG-RzV0zyjoC-FY@google.com>
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apCyQ93c48Dy4H-S@google.com>

On Thu, Aug 27, 2026 at 02:55:15PM -0700, Namhyung Kim wrote:
> Hello,
> 
> Thanks a lot for your detailed report!  It's good but let me jump into
> the action items directly.
> 
> On Fri, Aug 21, 2026 at 10:49:59PM +0100, Gennady Kupava wrote:
[SNIP]
> > 2. perf: precise events and DWARF call graphs are mutually exclusive on this
> >    hardware, so arguably perf should simply not let the two be combined.  I
> >    would suggest two rules rather than one, because a blanket refusal would
> >    make the common case worse:
> > 
> >    - for the default event, drop the P when --call-graph dwarf is requested,
> >      silently and on PMUs where precision means IBS.  Otherwise a plain
> >      "perf record -g --call-graph dwarf" starts failing outright on every AMD
> >      box, which is worse than today.  The s390 case in evlist.c suggests this
> >      kind of substitution is considered acceptable;
> > 
> >    - if the user asked for a precise event explicitly and also asked for
> >      DWARF call chains, refuse with a message that says why and what to do,
> >      instead of quietly producing a useless result.
> > 
> >    Note that this should be scoped to IBS.  On Intel, PEBS records the whole
> >    register set, so precise events and DWARF unwinding work together there
> >    and nothing needs restricting.  Frame-pointer call graphs are also fine
> >    with precise events - only the leaf frame is off.
> 
> I think we can enable both precise IP and dwarf callchains by using
> PERF_SAMPLE_REGS_INTR.  For unwinding, it should use PERF_REG_X86_IP
> from the REGS_INTR instead of sample.ip

Ok, it seems we already do this in the perf tools but it looks like the
kernel already overwrote the PERF_REG_X86_IP with the precise IP.  I
feel like we should fix the kernel.

Thanks,
Namhyung

