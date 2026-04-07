Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D24244692;
	Tue,  7 Apr 2026 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546313; cv=none; b=QKLDb8EBMTBZzmZm3OS7grDmnU/dTkRRr5IhBBWfMmUju2cgk3WWR2llRRQfhG92WhPR5AkpphVmAq43/nxAgnMH2zNds/V8i5v4nTbN4a+ERhIsGIfjAZSEdq/vuszUj67L7iLNjhFXooYJPND0KB+zEYoYSJE/YRqctsSYRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546313; c=relaxed/simple;
	bh=7bLXUxNlUpcYuvTrZAqMUnacIkf9w6QeTruvWULg1Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQEJxVldMLx42ow2m9YC4VVDYdo7Jusi8Sma8zCpYzI68/0QcLmmCwGX063gSXBwXsifzqsXXB6eYdSgsC5GOWXN7mQDzF/nXWwbTlqSd042I8dvyA23oGD3Onm02zDBUS9kXqDthaORfCAhgKl8C9SozbCbd8I653WMT7GkOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nImR+pzl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nImR+pzl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NDKl0CmwVm2mvyWYjyJbm938Bi5mo/cdP0hUqRq6tEE=; b=nImR+pzlf/E+k6Ma2TQTt6jT6l
	2JLKZVmBxi17iw1W/l3Ap5rhlCZD1Sc8D4LNAz+UHSJhbItR7ODULzTGUXb9Nzytd/4aEziswqZXw
	gPaLLGQv6i+rQKdovhwW1C42vaUPoDgcxwKtBaFFcHlCEZTRKwDRVgnvRTsLFMoCdCxaxGIkonduX
	S3QeDEMcyVEWErBSyZ0ptrLQy4W1OdtaXKe8rSmHZDd22q+OtGs5+VXMOZz/P7fSvk9jox/wVhCT0
	dMekWcdoBdB93vT4UGHyKzaP8Iep7ySwxQGJj8vjB8snrYcT4suIoX5TaTsDWFXaUB7YmCKAa0k24
	p9hFBJfw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA0hc-00000007kG6-3xHX;
	Tue, 07 Apr 2026 07:18:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D7DB73005E5; Tue, 07 Apr 2026 09:18:20 +0200 (CEST)
Date: Tue, 7 Apr 2026 09:18:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable
 accessors
Message-ID: <20260407071820.GA3738010@noisy.programming.kicks-ass.net>
References: <20260227062744.2215491-1-anshuman.khandual@arm.com>
 <1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
 <c7688962-d10c-49e1-a434-ab7ae2c64cdb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7688962-d10c-49e1-a434-ab7ae2c64cdb@kernel.org>

On Tue, Apr 07, 2026 at 08:48:22AM +0200, David Hildenbrand (Arm) wrote:
> On 4/7/26 05:28, Anshuman Khandual wrote:
> > 
> > 
> > On 27/02/26 11:57 AM, Anshuman Khandual wrote:
> >> Replace raw READ_ONCE() dereferences of pgtable entries with corresponding
> >> standard page table accessors pxdp_get() in perf_get_pgtable_size(). These
> >> accessors default to READ_ONCE() on platforms that don't override them. So
> >> there is no functional change on such platforms.
> >>
> >> However arm64 platform is being extended to support 128 bit page tables via
> >> a new architecture feature i.e FEAT_D128 in which case READ_ONCE() will not
> >> provide required single copy atomic access for 128 bit page table entries.
> >> Although pxdp_get() accessors can later be overridden on arm64 platform to
> >> extend required single copy atomicity support on 128 bit entries.
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: David Hildenbrand <david@kernel.org>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: linux-perf-users@vger.kernel.org
> >> Cc: linux-mm@kvack.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> This patch applies both on v7.0-rc1 and mm-unstable.
> >>
> >> Part of the D128 series but independent. Hence could be considered on its own.
> >>
> >> https://lore.kernel.org/all/20260224051153.3150613-5-anshuman.khandual@arm.com/
> >>
> >> Collected Peter's tag from an off list conversation.
> > 
> > Gentle ping. 
> > 
> > Still don't see this patch in latest next-20260406. Hence just
> > wondering which tree and branch this patch is being picked up ?
> 
> It's a trivial change and the last generic code change required for you
> arm64 D128 change, right?
> 
> I would assume this to go through the tip tree, but if Peter agrees we
> could route this (mm) patch through the MM tree.

Right, I thought this was part of a larger series and figured it would
ride along with whatever other patches.

If you still want me to pick this up, I can, just state clearly where
this ought to go.
