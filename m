Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA044C77;
	Fri, 29 Nov 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912950; cv=none; b=uImfw3rVSeHgXSM1f/eUIatby2ugo4XeFLouf/fFt5qWFnmjx79dF3bJUrYco1JmKxg+A74EQdLm8CpLhsQXrKPx7ZiuyDwQ6r7bcsh+hdia6yvl1KzSDwNEdiKKP3JaPwmZQ7vxk0V6gzrxMC48q4Oyt9dwwjvjNrID2zG/ims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912950; c=relaxed/simple;
	bh=KQXyE0PHNGnkB7ATfiEdHb7Pa/P9Cbq3A8rIsx+QRnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL8+/0N/jOY7PUahIDQBhpIb4eW/s6Uzd9eOmwVHcTDVev5ghnTsNheKiFgqOegA2qS87jrykBUp78zlhgIvBq6eTsJ7d5j5JF56wVyM5MJEFQ3WQ8jVf5VXNLtSOWQgjpniBOB6Vw0lCOIOhGhsXIZYSdhaFQWv8AG0Tql0AQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t2ZNAuPx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t2ZNAuPx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X7aBu5N32YIZ611CK1D8iT4+0u7ZGBBz/rE6KJZjVFg=; b=t2ZNAuPxV0pf9kDXS6US/VzS+W
	cmxDeH26kCkiYsOv0Y1It2zg8JWcsZCLfaePB60voMWvlUo+i6EQZCmz6DRBjqO6dFKnYiFFkgfUA
	nwYqXQ1286mFqkEoSTxqnhgn35yfCPMIf1JU2L3jQNZ6kT8DXVQQ6KBt2dp2gub6rIRqm0AunFvtC
	IH7eaAXFoOV4e09lHvgLMj4U2nmvqTHQjkksbQzgixZx+/FVv79/9wYfzoPLVqMvPo03gAvx0103W
	9mG4vC0aLbVL9Pr38W9FszMAJouZl7jj/rLF5F951GkmQf0/ouwRDYF/3wxR6uHanbpS+Ayk7u1cC
	YXnjaAiw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tH7ob-00000004cmQ-3Ty6;
	Fri, 29 Nov 2024 20:42:13 +0000
Date: Fri, 29 Nov 2024 20:42:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] perf: map pages in advance
Message-ID: <Z0onJRnxQ8ZaWeov@casper.infradead.org>
References: <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
 <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
 <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
 <6795cc9a-6230-431f-b089-7909f7bc4f30@redhat.com>
 <60191c97-dce2-4a92-8b47-c402478ba336@lucifer.local>
 <9d4ef1a2-11fb-455f-8b37-954215bf25d2@redhat.com>
 <14895682-a013-419f-bee8-1476540ddedd@lucifer.local>
 <f637de06-41de-44be-8e1f-6a5d429e0ec9@redhat.com>
 <be33a685-f6e0-41b0-ba3b-d1d7c2d743b8@lucifer.local>
 <fda2336c-7d00-4a5d-8a81-4cb1e58bb8ce@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda2336c-7d00-4a5d-8a81-4cb1e58bb8ce@redhat.com>

On Fri, Nov 29, 2024 at 03:48:33PM +0100, David Hildenbrand wrote:
> Too long, but as some of these TODOs stand in the memdesc way, fortunately
> other people might be able to give a helping hand at some point ;)

;-)

> I'll play with using a page type for some of these "simple" cases and see
> how hard it will get.

I've deliberately made pagetype incompatible with setting a mapcount ...
hugetlb being the exception because we only use entire_mapcount.

Anyway, I agree we need something better than what we have here.
It needs to be simple for a device driver to allocate memory and
map it into userspace.  I'm willing to allow perf's ringbuffer to be
a bit harder than most because it's trying to do the weird thing of
writable-first-page-rest-read-only.

