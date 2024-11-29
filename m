Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F219A298;
	Fri, 29 Nov 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883201; cv=none; b=r62QdC768Rr+IZT1a6RgxET2xHb/RG6AaNCwff1LnqID4gdtBR9DCrCxdEHkDpDsVZeM7NBPM1TY2AgwF9CQZKldBs+AHsg9zyOJ/M27i0nMVhPh+/nOZlplYreY2j0L3naym1liAoJhUIXarVicUCY/mWoAyBtIxFrPsQK5ihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883201; c=relaxed/simple;
	bh=UQr+/B1z2IymeIf9YwvN4+kyAO7G19doOHthKkkHumM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nscDLJ5AG/rD2rjDLvNzjm/Z56s3zWRkYpC9L/uxvgZIXDmh2XOtVlHPv8rofX3fFJc8ETJbu+3PoIEZkQ6bVOG7oGiyPO9dWxWftd7FTCsRKSFinpacEImrV0OmU+h/8HV99UJc8eXacHxWjI6rHE1+tpxzSIwkx5oAi+rE/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gJMb/ujd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gJMb/ujd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E5PHdBcZ7E2Sz57KgUghDb+dnK9fhZZoK3Dg1gINpug=; b=gJMb/ujd6dMaig0EBXfRnzgaov
	7HVZ3t5Hu3sUp6sQ9Mv4e2FeZBcK8/czH+/SJ4Sigkoj0gpw3XJD4JBB0Gf4j0QkVHtM+QQBhVRHK
	stx11l0OWxsI6iEmnyJ7EHihbtnWY601wy+qwmx//qoRyyZ44J8mOqcTgakVCW7RtaKBsCffYrliv
	rc25K2gpLMSsex9rnVqx+1uECYGUn0y4Vz1mi6eRlQ+1FcWW/WAoRXw/basVLZCaZ+9TLqZPmlDnC
	X1lg0LNbl1OnWH+b4RnEZq7rb3bR301B8HUI+T43kbppMvrtFJivqlLtuF2Tgoci19qjLwdb0bGms
	s8ONSAxA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tH04m-000000040Ay-2Er9;
	Fri, 29 Nov 2024 12:26:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1638730026A; Fri, 29 Nov 2024 13:26:25 +0100 (CET)
Date: Fri, 29 Nov 2024 13:26:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] perf: map pages in advance
Message-ID: <20241129122624.GH24400@noisy.programming.kicks-ass.net>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>

On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:

> Well, I think we simply will want vm_insert_pages_prot() that stops treating
> these things like folios :) . *likely*  we'd want a distinct memdesc/type.
> 
> We could start that work right now by making some user (iouring,
> ring_buffer) set a new page->_type, and checking that in
> vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
> and the mapcount.
> 
> Because then, we can just make all the relevant drivers set the type, refuse
> in vm_insert_pages_prot() anything that doesn't have the type set, and
> refuse in vm_normal_page() any pages with this memdesc.
> 
> Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
> these things will stop working, I hope that is not a problem.

Well... perf-tool likes to call write() upon these pages in order to
write out the data from the mmap() into a file.
