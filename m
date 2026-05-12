Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C0346A04;
	Tue, 12 May 2026 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597343; cv=none; b=ctwsI9n1+XuNiSIFmVx7IX/CLAv2e7Khy+ftKHixEInmQPC41JiUxtfsefcHhBLJ1sHVUb+M64sFDD3pEicjSME87XZd1mPuP/2lOHAy9BJkDd3l7rY/jkL+NBLiaRrMzvm4JcW5MQXSlo9Y9dReR273zNj1hoOrPpol77UkXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597343; c=relaxed/simple;
	bh=TS+7ENwIB8mkF7jAT+mbjKowWfXS5h3LHtn9effebdE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k2EtL33kRxi2f0lg7n6LKRaLYWT17jR2NSnJZgvM0wBkB9gFGR7aJlCRY2rCUYMS8w6RjNpzjoNGjU6xcDpo2v4taZ2k1ilIfsjnn+dU0yQd1aPZ4t5zY1rPz6o3MNKpCkGe6FyPriQFDsdU0dQ+PCix5SHOKzSzRcy9VZoNcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrvYMDNf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrvYMDNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE093C2BCF5;
	Tue, 12 May 2026 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778597343;
	bh=TS+7ENwIB8mkF7jAT+mbjKowWfXS5h3LHtn9effebdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HrvYMDNfAQxcTIIV/PiAJq84nbXVXJd0XI/1e7Bd0kPHls+KsZCNSX+l3ILTcstWr
	 UzjbpMsrxntnO37JTcPiwa/pi1Nsn8fVt43/NZUHQMuYcqJhK0/S3K8k1o27R0+nJ1
	 qCL8hwAaz2KwLr4bxVKOc5RDxLehsxKbMnlf3FgG8V+9Q2giiMbrt+bYoylbdcErOq
	 D8fI5u6jUOpGv5uScD6ywB0XDr/vutDelOC8g2S3AAKJbgtEcRgpSuHdVJDVGg6y2G
	 hjqbgMyskjkFurSPysHcQpL7VdeNux0IMhs02Otqm1G3nRgcaYm3Vp0q15/MU6wya1
	 cr2vNfkcyfHdw==
Date: Tue, 12 May 2026 23:48:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM"
 <linux-perf-users@vger.kernel.org>, "open list:UPROBES"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] uprobes: Use flexible array for xol_area bitmap
Message-Id: <20260512234857.44e2b0fafa4961900fdb7246@kernel.org>
In-Reply-To: <agMPMAnsCH2ZRhf5@redhat.com>
References: <20260511225648.27886-1-rosenp@gmail.com>
	<agMPMAnsCH2ZRhf5@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 13:29:52 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 05/11, Rosen Penev wrote:
> >
> >  struct xol_area {
> >  	wait_queue_head_t		wq;		/* if all slots are busy */
> > -	unsigned long			*bitmap;	/* 0 = free slot */
> >
> >  	struct page			*page;
> >  	/*
> > @@ -117,6 +116,7 @@ struct xol_area {
> >  	 * the vma go away, and we must handle that reasonably gracefully.
> >  	 */
> >  	unsigned long			vaddr;		/* Page(s) of instruction slots */
> > +	unsigned long			bitmap[];	/* 0 = free slot */
> >  };
> >
> >  static void uprobe_warn(struct task_struct *t, const char *msg)
> > @@ -1755,18 +1755,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
> >  	struct xol_area *area;
> >  	void *insns;
> >
> > -	area = kzalloc_obj(*area);
> > +	area = kzalloc_flex(*area, bitmap, BITS_TO_LONGS(UINSNS_PER_PAGE));
> 
> The downside is that kmalloc will use kmem_cache with ->object_size = PAGE_SIZE * 2,
> almost half of the allocated memory won't be used...

Hmm, is the bitmap so big? 

#define UINSNS_PER_PAGE			(PAGE_SIZE/UPROBE_XOL_SLOT_BYTES)

And even on arm64, 

#define UPROBE_XOL_SLOT_BYTES	AARCH64_INSN_SIZE

So if PAGE_SIZE is 4k, UINSNS_PER_PAGE is 1k, its BITS_TO_LONGS will
be 1024/64 = 16. So 128 bytes. So the object is allocated from
object_size = 256 ?

Thank you,

> 
> But technically the patch looks correct so I won't argue.
> 
> Oleg.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
