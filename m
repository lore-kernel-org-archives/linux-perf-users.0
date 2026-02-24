Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646122129B;
	Tue, 24 Feb 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929707; cv=none; b=O8t6RgzRgnuTLEPKxjqKtRYxBKXQJkn7YO33TiBoMTY3MH8hzF73BGmk0JsMc9dxR4xJkQ3kBtxxuRTX3IEnSy2UtFglPWEAFUDQPVFhw1JmRv+oVXEkrfsjKd2MCDKylFmBDM5wadK3UAwg1mI5SBIuOtcSP7DYZQ4ryvts6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929707; c=relaxed/simple;
	bh=wg8+qeLkHaKWQnLiQzpCNPEf5hQSXuJ49gxIF/7p/Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIaYF+1YO2RP9i/K8wdr76jXzWkaxdaVNosl/cJpYZXtCzqWzG36aufvjlriuOTx9VF/ONsnU2RcEhWAw8s+Sx7qUwOR62T5YZDq8JI0xwXV1Te6uuV+VYai2S2KMLQ4zeqcrPMKZtgyj//gbu1DBXDbQFDIV4QmDz9U5tfEJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YxkdXSBf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YxkdXSBf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bHwIF4V+Sfi2Dx/bo9vGSSFFbaqINJ//nOO1nfy3NhA=; b=YxkdXSBfv2J0CfNjCaNSNGxjsW
	HimhZAuJW4NO5YY8NK+llCUJeoqBRJ6Vn99JrFQjLTPSc32v5+H796fnEtoAEERJu7CHuuyt5Cq8q
	mgkfSXvXgGGNAMbbP68DvycGfejyRyfC64MxJw9nNRjI0SvikEy3mWLxWQSe7Gu6xvJjU6HWvmk74
	ChIW3W7MiMNHXPnbNOiICk5WzeaKFt1R0vsVGtgLzbNfJya6kUHttZIABiuipFnYmSVOIcKpFmkzN
	iY/HvUJjMn6/HhwyMGbK/YmZ1wOzC70WbrcIRbXBS9kJQEVEjXPYuE6ykoiI3MMcHusmIGp+/IeDl
	CVZfzgXw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuprD-0000000Gh6J-17U0;
	Tue, 24 Feb 2026 10:41:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0DEC930075A; Tue, 24 Feb 2026 11:41:34 +0100 (CET)
Date: Tue, 24 Feb 2026 11:41:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Linu Cherian <linu.cherian@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC V1 04/16] perf/events: Replace READ_ONCE() with standard
 pgtable accessors
Message-ID: <20260224104134.GW1395266@noisy.programming.kicks-ass.net>
References: <20260224051153.3150613-1-anshuman.khandual@arm.com>
 <20260224051153.3150613-5-anshuman.khandual@arm.com>
 <aZ14lUwuA86aiOH-@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ14lUwuA86aiOH-@J2N7QTR9R3>

On Tue, Feb 24, 2026 at 10:08:21AM +0000, Mark Rutland wrote:
> On Tue, Feb 24, 2026 at 10:41:41AM +0530, Anshuman Khandual wrote:
> > Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
> > anyways default into READ_ONCE() in cases where platform do not override.
> 
> For each of the patches where you make this sort of change, please
> explain in the commit message *why* it is necessary to do this.
> 
> IIUC the entire point of this is that in subsequent patches, arm64 will
> need to use something other than READ_ONCE() for all pXX levels in order
> to support D128 translation tables.
> 
> Spelling that out in the commit message makes it much easier for
> reviewers to see what's going on, and to focus any discussion/questions,
> e.g. *why* won't READ_ONCE() work?

That, and only being sent *one* patch, I have no clue what the rest of
them are doing. Didn't even get 0/n.

I hate people sending me just one patch; just send the whole series
already.
