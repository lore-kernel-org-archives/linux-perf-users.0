Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC91EE7BD;
	Tue, 25 Mar 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900027; cv=none; b=d4QJw3NEpNN/i5t+3tPXHCD/4TgetI19ZeScF/zWJUfXDILTG9ahTQZ7xzBNGygzSqKP0/S4RBwFEwSSoLDF70G7+iXTOInxoI8VeSqs7Pk0Df9v5+pHj612IEfYim7YCi9l3Vh+HC6XwW+AeXINk4aeSLDpjw6TyZSbTTBzRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900027; c=relaxed/simple;
	bh=wOlH4b2HejrysZeyBI2IuhdZWBRpPWmrhF128i5vQbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYwd0+Ej4o8Y8hbm4e3FWGDe19RoeIuwnvp22DZdbYvhYPYRbyC9aAH2PWFrT3KaVFPnnbQZ/cse4sluk297lNAFJbEatIgAUkVGVtA5He/g+cbo9BhO/+sfxCVLUep7Bp90Q5qdw/brg3UQ8o4VWxpgDvTSpWf/bGn2E/GDVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KgO5HIou; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KgO5HIou"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nb567w52U4VX6RZjUZZTTfiL9LAMzEOtwHBwdKK5Hbc=; b=KgO5HIoukwLGEoCeX08x3EAFwK
	GguROLbOvjWQ/+UilEVKvr0ye+kuwYiGN3sLL+QkP8mE6bXpw2MSDESAE5pCllViCqmRZB2+iaoHz
	BS9uZlyi5xy1y+rQVtWNi78ok9I5/x+dxOij5WuzFLkmmLF3fChSUVuQwUZe0ph/OHXmRHqxwuZRS
	v8m9zjz4AJ89tVe6vQMNuLPXBb6KMI5L7acEYKAnXanttEy3ATH33I9MwGcTbk/6AGa6GhSV7S6Hv
	5T9m7oyaE4C1pGtBIceHds6d1vwSbTcSo6jSy/qtxIEKJAS2YO9xGVwBf5cmry9olzAS3sdLDY2Q9
	VF14oI6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tx1uU-00000003qLq-3WNM;
	Tue, 25 Mar 2025 10:53:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 66A333004AF; Tue, 25 Mar 2025 11:53:30 +0100 (CET)
Date: Tue, 25 Mar 2025 11:53:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH v3 0/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
Message-ID: <20250325105330.GI36322@noisy.programming.kicks-ass.net>
References: <20250321113713.204682-1-david@redhat.com>
 <20250321133401.GB4776@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321133401.GB4776@redhat.com>

On Fri, Mar 21, 2025 at 02:34:01PM +0100, Oleg Nesterov wrote:
> On 03/21, David Hildenbrand wrote:
> >
> > Based on mm/unstable.
> 
> which has another fix from David in __replace_page() plus the fix from
> Tong in uprobe_write_opcode().
> 
> So, Andrew, could you take this series as well? Peter, will you agree?

Yeah,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
