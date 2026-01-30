Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD952FB983;
	Fri, 30 Jan 2026 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772730; cv=none; b=C59TRIE/6TBbXTS9ScJHhfs56pBuHUKWfKM3WMArJBArU+eJOVCFlf+oZakAR3fISmUeY6CnQ+8bz1xEd5EHwILNftQgolJMo0upPl8R/yS2moPgob+KEM12AT7d6IDg3ImRgpa6xLZD3iunPPO7IoPS5sP0SnhsKLQdGl+R04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772730; c=relaxed/simple;
	bh=9CBTdkizXR3bvR6U0NbZn8CmRgegKQKZcEI88R5O3A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzpgN0yeiw5Bf65EGXN+eHQX+xy6O9sWkk15Fx7q/Ha1emQ6KsoGegsFzE5UAwVJfE79w2a54nBZFHPKjnOw7rZZwOuR+DRBej4eYcge5lgeaTynVH/VYO++YoVUBUa4FVPVhUcdGfNHSOtqRZcBijGgK5anRYIcNOzdCfdBBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LYqT/+Fi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LYqT/+Fi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+772sjzaBjbh9fzVpZfNORG2qh1TnA8emQl3XrkxweE=; b=LYqT/+Fiy3VGj6BDtmhFMGv9jk
	rRhYEHN4BHzQLi6yrkadlJLaR2QB1PnbM+dbt44B54bY0CQwu9WF0oacIYL6qsBnrxi/Ca0RrjCQw
	EUDJVj/Q6MCRaHEQqiUPIr2ToGCsxxAGrLQGeA1F8JMOO+t7T20pa1rJk/FWxv2nP0OzVtFQ2eXYa
	eSW9VZsFDuuDkmLaVCLp6oHKlxCsPpBCciqbCaAv10XgPaeivUgH2/93SWPEmj4v0QwN2zwEtJYnJ
	IpLTZD+mMhR11AtY/9/f2Cc4/ZLEdj/tgCH3bQMkeQfTpzMXZVT22yb6faDnxUyMbfE2DugqdCOsh
	K3nyJYPQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlmjA-0000000C6hu-0wbY;
	Fri, 30 Jan 2026 11:31:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 70F1D300BD2; Fri, 30 Jan 2026 12:31:50 +0100 (CET)
Date: Fri, 30 Jan 2026 12:31:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
Message-ID: <20260130113150.GB166857@noisy.programming.kicks-ass.net>
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev>
 <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
 <CAEf4BzYpcgC0Pi0f_ScUavJ_Tw74PKULsbPdexKsWmb8RmxLKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYpcgC0Pi0f_ScUavJ_Tw74PKULsbPdexKsWmb8RmxLKg@mail.gmail.com>

On Wed, Jan 28, 2026 at 11:12:09AM -0800, Andrii Nakryiko wrote:
> On Wed, Jan 28, 2026 at 1:10 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jan 26, 2026 at 03:43:30PM +0800, Tao Chen wrote:
> > > From BPF stack map, we want to ensure that the callchain buffer
> > > will not be overwritten by other preemptive tasks and we also aim
> > > to reduce the preempt disable interval, Based on the suggestions from Peter
> > > and Andrrii, export new API __get_perf_callchain and the usage scenarios
> > > are as follows from BPF side:
> > >
> > > preempt_disable()
> > > entry = get_callchain_entry()
> > > preempt_enable()
> > > __get_perf_callchain(entry)
> > > put_callchain_entry(entry)
> >
> > That makes no sense, this means any other task on that CPU is getting
> > screwed over.
> 
> Yes, unfortunately, but unless we dynamically allocate new entry each
> time and/or keep per-current entry cached there isn't much choice we
> have here, no?
> 
> Maybe that's what we have to do, honestly, because
> get_perf_callchain() usage we have right now from sleepable BPF isn't
> great no matter with or without changes in this patch set.

All of the perf stuff is based on the fact that if we do it from IRQ/NMI
context, we can certainly do it with preemption disabled.

Bending the interface this way is just horrible.

> > Why are you worried about the preempt_disable() here? If this were an
> > interrupt context we'd still do that unwind -- but then with IRQs
> > disabled.
> 
> Because __bpf_get_stack() from kernel/bpf/stackmap.c can be called
> from sleepable/faultable context and also we can do a rather expensive
> build ID resolution (either in sleepable or not, which only changes if
> build ID parsing logic waits for file backed pages to be paged in or
> not).

<rant>
So stack_map_get_build_id_offset() is a piece of crap -- and I've always
said it was. And I hate that any of that ever got merged -- its the
pinnacle of bad engineering and simply refusing to do the right thing in
the interest of hack now, fix never :/
</rant>

Anyway, as you well know, we now *do* have lockless vma lookups and
should be able to do this buildid thing much saner.

Also, there appears to be no buildid caching what so ever, surely that
would help some.

(and I'm not sure I've ever understood why the buildid crap needs to be
in this path in any case)
