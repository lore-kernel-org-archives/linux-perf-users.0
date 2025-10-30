Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5935770E;
	Thu, 30 Oct 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819993; cv=none; b=AQDCe9Msdo0sXbG/f2kYxt9iRGdUsEHhh1YptLks5/jySY0nmwolbB8+xDhHHvf4uXL2NQ+3IiLQjcSqnIAgtHgSQxgDNICcHBKpBRYCkQEwNZJ6mylrbpMdeEeSSYl5RMkZ5/aAlZ+pgS5JkZkd8jU7VXnqr8ic2JRQZnGPyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819993; c=relaxed/simple;
	bh=ZQeaTIYo2PFyGQuYnH377IMHaMcvvo9URIFWHLeo0VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gImi+kq/7o4SgVIOCVG95Jqh/w5bqKe6SUCnmyT31tcAQjpHeL9AUxwsuXsRXCDshVTid49HX+nj27JB71HttAMNyhrMrq/9dLpcvtiKBA94ZnT3LUiaMcMhT5IwsVpB9qk18CB9lVJUQ98aTuNwJv6DdbIWa/Ma3qj67G1a9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tyxxwIBq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tyxxwIBq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qZnGQAq5O4/vMj3v2hACrPoi8P+jbL/qYhOyDwFD/Kc=; b=tyxxwIBq7tHMVKJrNyLmjFBeSZ
	/8x/LWNZGtlRWqC6d8UQ32z5RzEh2Sn/SZk6U22iOqxuS6SUMj5D2Ih+9B8AImKeopZkyqAVGlB4F
	Azdl0mh7yWuEg+wiHcp7QGFfCMVOlqxadZ8PWgG+YxFdD1cCpKs2XEjpziRxslrPE9A0o3snD0ZP6
	t24dASKEDrHbXl9IHVjue0Q1ZaXnltqRPkbasMuAN0asT4uEXMblsE41IbUJM1jr+2Wdg2e0XZqBn
	DGms2Fj+SwzIMVlLas2kwbSRcwbTkBhBUxVuWMCqGCKpEb4EMGlZ1c2fu44YOZ/Kzwr990sAqMHqn
	9yuNXI8A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPrO-00000002AaN-30xr;
	Thu, 30 Oct 2025 10:26:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE61830029E; Thu, 30 Oct 2025 11:26:26 +0100 (CET)
Date: Thu, 30 Oct 2025 11:26:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Fangrui Song <maskray@sourceware.org>
Cc: linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>

On Wed, Oct 29, 2025 at 11:53:32PM -0700, Fangrui Song wrote:
> I've been following the SFrame discussion and wanted to share some
> concerns about its viability for userspace adoption, based on concrete
> measurements and comparison with existing compact unwind
> implementations in LLVM.
> 
> **Size overhead concerns**
> 
> Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is
> approximately 10% larger than the combined size of .eh_frame and
> .eh_frame_hdr (8.06 MiB total).  This is problematic because .eh_frame
> cannot be eliminated - it contains essential information for restoring
> callee-saved registers, LSDA, and personality information needed for
> debugging (e.g. reading local variables in a coredump) and C++
> exception handling.
> 
> This means adopting SFrame would result in carrying both formats, with
> a large net size increase.

So the SFrame unwinder is fairly simple code, but what does an .eh_frame
unwinder look like? Having read most of the links in your email, there
seem to be references to DWARF byte code interpreters and stuff like
that.

So while the format compactness is one aspect, the thing I find no
mention of, is the unwinder complexity.

There have been a number of attempts to do DWARF unwinding in
kernel space and while I think some architecture do it, x86_64 has had
very bad experiences with it. At some point I think Linus just said no
more, no DWARF, not ever.

So from a situation where compilers were generating bad CFI unwind
information, a horribly complex unwinder that could crash the kernel
harder than the thing it was reporting on and manual CFI annotations in
assembly that were never quite right, objtool and ORC were born.

The win was many:

 - simple robust unwinder
 - no manual CFI annotations that could be wrong
 - no reliance on compilers that would get it wrong

and I think this is where SFrame came from. I don't think the x86_64
Linux kernel will ever natively adopt SFrame, ORC works really well for
us.

However, we do need something to unwind userspace. And yes, personally
I'm in the frame-pointer camp, that's always worked well for me.
Distro's however don't seem to like it much, which means that every time
I do have to profile something userspace, I get to rebuild all the
relevant code with framepointers on (which is not hard, but tedious).

Barring that, we need something for which the unwind code is simple and
robust -- and I *think* this has disqualified .eh_frame and full on
DWARF.

And this is again where SFrame comes in -- its unwinder is simple,
something we can run in kernel space.

I really don't much care for the particulars, and frame pointers work
for me -- but I do care about the kernel unwinder code. It had better be
simple and robvst.

So if you want us to use .eh_frame, great, show us a simple and robust
unwinder.
