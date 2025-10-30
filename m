Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7F258EE0;
	Thu, 30 Oct 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848566; cv=none; b=NCot3snzThnzUSe/CP8elo+v2VlfkOiXmA69omspizHfyJgROJ6LdmoNKv1q1OoGMvYxJZojy1umtJdjmhzaoVoqMRGZdqRxAa0vfLKWYNukBIVdlmHmlLgjtzMUrHDETPDk7P42MuuBFYNaFqhdgKzZ/4r5UMpSkdoPaEgskxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848566; c=relaxed/simple;
	bh=7yyD5U+PYsRKwp8Uhb+m6+KksaxC3GTC2RJTL/9eup0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUY/UkuDM7kOsSncKfL7hTPDhJhdhgA6H9KShtNzrPSiBJstDFfVX7RAacP8IHA/px2UUXg62ndXM/jy7xZvu9qa3YhffG5BL8xGYtx6kymYCQziQvRkd8JUwLd6YeVw2/PbBfW1/AASzJ7MYP6fCv5BDO6D4RqvvSXe7JgqnmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M6ST0f8G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M6ST0f8G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kEelh1U2KFvGZlwyaZuMb29p7lTzeUCDxOLG+vsywwY=; b=M6ST0f8Gn1FtTUgjwQPlSSCBB8
	AXGLR45eiXW+wI5g5/msRcxDdUG3GdAqKmlTuiS9a/hS31jix2TlfsPnMDtFe0+scriNr/ghMS0vL
	1tm4NCs5N+Kou+EBun1zh0eMQve/iO8N89YwQno6wl7dMoNnOIM08N+QZW8dR2fi20wD2RcmxUj52
	rj6Nfi3uMjLbZjYCb5tcPCdWpUrLfgBiQaWMULaYyETypymP5IQxfU2Bw7nRT2At/kXhbfZygujTx
	McIDgTJ7pv5fnC/CSsyW8O3h3Z3uYzazl7fSkK53T4sqafO4SZyzpQIYdglQHE8hgakb0KFD1Le30
	GE0GWBJg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEXIE-0000000ADjb-3KPQ;
	Thu, 30 Oct 2025 18:22:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E4E41300289; Thu, 30 Oct 2025 19:22:38 +0100 (CET)
Date: Thu, 30 Oct 2025 19:22:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Fangrui Song <maskray@sourceware.org>
Cc: linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <20251030182238.GA2989771@noisy.programming.kicks-ass.net>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>

On Thu, Oct 30, 2025 at 09:48:50AM -0700, Fangrui Song wrote:

> Thanks for this perspective???the unwinder complexity concern is
> absolutely valid and critical for kernel use.
> To clarify my motivation: I've seen attempts to use SFrame for
> userspace adoption
> (https://fedoraproject.org/wiki/Changes/SFrameInBinaries ), and I
> believe it's not viable for that purpose given the size overhead I
> documented. My concerns are primarily about userspace adoption, not
> the kernel's internal unwinding.
> 
> If SFrame is exclusively a kernel-space feature, it could be
> implemented entirely within objtool ??? similar to how objtool --link
> --orc generates ORC info for vmlinux.o. This approach would eliminate
> the need for any modifications to assemblers and linkers, while
> allowing SFrame to evolve in any incompatible way.
> 
> For userspace, we could instead modify assemblers and linkers to
> support a more compact format or an extension to .eh_frame , but it
> won't be SFrame (all of Apple???s compact unwind, ARM EHABI???s
> exidx/extab, and Microsoft???s pdata/xdata can implement C++ exception
> handling , while SFrame can't, leading to a huge missed opportunity.)

No, you misunderstand. The x86_64 Linux kernel is using ORC internally
and we're happy with that. However, the kernel also needs to be able to
unwind/walk user stack frames.

We need simple robust means of walking user space stacks from the kernel.

It is here that SFrame is proposed on x86_64. The kernel consumes user
space SFrame data to unwind user space stacks. This is also why the
SFrame sections are SHF_ALLOC, such that the kernel can simply fault
them in on-demand without having to otherwise initiate IO.

