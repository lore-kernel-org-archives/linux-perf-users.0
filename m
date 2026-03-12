Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F32798EA;
	Thu, 12 Mar 2026 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304328; cv=none; b=oxmbl1j5Eie4r2C7RIRmQTv7gudyvB9RoJdw9XsgKxmc4i+4Fpzt+jKSmbrPxA3JUHUBzg4FgUD/maJ6H2igFWzUlhUex4F8ki22Mub0CS3HxF7cJxireeALrVUekIvxPbsqkpfndUpvxEO/YFur7xi9e40FBDmulDC26L2v29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304328; c=relaxed/simple;
	bh=x4cZ0Dfce6OMD5/VBZ7eTkkxjEeqtmznN13rbFlQsmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtU3JZflo2rwxpndJl0pbYRLFjD8mNp0zxEfmENL5pbrsUfOtvrJgBvtIuEgd70pCGDmv4n3nJgAiIEfaa3WUMb8H3otyQCiOKzTg3lU95wYZ7xITSAL55mY0QkG6d80w5N9XLy2nhmwcwkVWqmvY1uxzfrS8THNVX5up3aL5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n3eBe7ST; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n3eBe7ST"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o41HKdH/Na7yS1vLFEP9y3uceZ85kEFePlY4Q4RtVQE=; b=n3eBe7STgbrXt3DWI6LEsdt6PW
	s3ydX8mq5bZRruazBPopyCm3WECZC+GFl5qPVmr7725HJmuHZ46j0AbvbNrWY8G2N4b36qa8eOBul
	StpKX1Jz6d64THvFYNsJOmZW+XhDuXcjhs5ZX6QtR7BQrw2BMxsUcD0qVtk9SITT6g56Hmkm74tko
	dDFxLbETVki9zbZzb/e7bGtB+9Y9Q0lKB3jOH+NNaJF/6nThKJQWL60GYhIYGwItjBAUMVccPmPd7
	RtrzfNB4r2uHukJ2h7FLnZGTpgVNN4BkDdscbQRhomZvmmMrT8J6yWv1Jw/6Qk8gNvegXAbB74vPR
	ulEtWCNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0bSa-0000000B3Dp-47DR;
	Thu, 12 Mar 2026 08:32:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF885301150; Thu, 12 Mar 2026 09:31:59 +0100 (CET)
Date: Thu, 12 Mar 2026 09:31:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: dapeng1.mi@intel.com, dapeng1.mi@linux.intel.com, acme@kernel.org,
	adrian.hunter@intel.com, ak@linux.intel.com,
	alexander.shishkin@linux.intel.com, eranian@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, thomas.falcon@intel.com,
	xudong.hao@intel.com, zide.chen@intel.com
Subject: Re: [PATCH v1 1/2] perf/x86: Avoid inadvertent casts to
 x86_hybrid_pmu
Message-ID: <20260312083159.GD606826@noisy.programming.kicks-ass.net>
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
 <20260312054810.1571020-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312054810.1571020-1-irogers@google.com>

On Wed, Mar 11, 2026 at 10:48:09PM -0700, Ian Rogers wrote:
> The patch:
> https://lore.kernel.org/lkml/20260311075201.2951073-2-dapeng1.mi@linux.intel.com/
> showed it was pretty easy to accidentally cast non-x86 PMUs to
> x86_hybrid_pmus. Add a BUG_ON for that case. Restructure is_x86_event
> and add an is_x86_pmu to facilitate this.
> 

> @@ -779,6 +795,7 @@ struct x86_hybrid_pmu {
>  
>  static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
>  {
> +	BUG_ON(!is_x86_pmu(pmu));
>  	return container_of(pmu, struct x86_hybrid_pmu, pmu);
>  }

Given that hybrid_pmu will have PERF_PMU_CAP_EXTENDED_HW_TYPE, and we
should really only use hyrid_pmu() on one of those, would not the
simpler patch be so?


diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..13ec623617a9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -779,6 +779,7 @@ struct x86_hybrid_pmu {
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
 {
+	BUG_ON(!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE));
 	return container_of(pmu, struct x86_hybrid_pmu, pmu);
 }
 
