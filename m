Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930743BED7B;
	Wed,  1 Jul 2026 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892287; cv=none; b=VIPX1qhVn4JZzIQPySSRWjUGJzJMhvw5uUqm2o3SnjuQx/XGVBUcp/suOoMD39D5jI1X0MsdLEg93zw4/xuhwYSw5CNl6riyaHQ12FZBJIymoMua2wiXjWyt5yXPxgrG6kgcqcogMtbLT1wWBHP03uvWoihozczniQW1h7Cui/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892287; c=relaxed/simple;
	bh=O3R52/XAgY6lyHgCuRwmWhwRX1eB3vPvY1ifuDF+l24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEVPjBdiZAv5xfy9dK8YHaxNCuvC0TnzEZFkeu8NJQwZ2oVFU22Rg7o8vl1Ci3nfg6OzEfAdg6DQ6spX82dTSmzq1U2fx5DjesryYiP1S8DMqm+cxErgKLCL1ON3iI9AWhg+aIJlsFqX33Iy/aUEbWVj/p8nRJpe3rG2owT02i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j6a9MPzc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j6a9MPzc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zpRmqBw2d/BuwSmd5ZtVCTIuzSljaizV+0pXzMURJ+8=; b=j6a9MPzcYzAGwEOLPkaaXkpxor
	HHFUJadTbuVUTl2iCZAJ/9C0oOT36FSlhZYXp2Ku9CyK3BEN/H+DBPYizvvUu0HiD1KFPZH7qO2Nm
	HCN0YO3kd7n/6HQDZNJlFZrkjvpRSHGKyvBaP96C1buqTQbiPvaOFRyCzpJi4SnU5sFJDGWoPA2Ip
	P72UFMuyrJ8mCNYPtkQ79XU/8gtt2Z8t0JGkxY4+iexSkCJywsYaN20p4IWVWnax6ENNdp7RLFqqO
	I9o03yhgYOXT3Rdeyp7WDL1PzDhvL0LdYOIwDmLQ4In6xkuq7g3xGJ30wbZP8Ldb8xsWBl9gDiZwY
	cw62hX9A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wepj4-00000002UKC-124h;
	Wed, 01 Jul 2026 07:51:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 559D3300402; Wed, 01 Jul 2026 09:51:17 +0200 (CEST)
Date: Wed, 1 Jul 2026 09:51:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Liu <liuqi@hygon.cn>
Cc: "mingo@redhat.com" <mingo@redhat.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jing Li <lijing@hygon.cn>, Zhenglang Hu <huzhenglang@hygon.cn>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= 1/3]
 perf/x86/amd/uncore: Add common PMU helper functions
Message-ID: <20260701075117.GO48970@noisy.programming.kicks-ass.net>
References: <20260701034413.718872-1-liuqi@hygon.cn>
 <20260701034413.718872-2-liuqi@hygon.cn>
 <20260701070013.GJ48970@noisy.programming.kicks-ass.net>
 <dab0dd2b31d14bef9fdc9d0c887dc460@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dab0dd2b31d14bef9fdc9d0c887dc460@hygon.cn>

On Wed, Jul 01, 2026 at 07:50:16AM +0000, Qi Liu wrote:
> 
> 
> -----邮件原件-----
> 发件人: Peter Zijlstra <peterz@infradead.org> 
> 发送时间: 2026年7月1日 15:00
> 收件人: Qi Liu <liuqi@hygon.cn>
> 抄送: mingo@redhat.com; namhyung@kernel.org; alexander.shishkin@linux.intel.com; jolsa@kernel.org; x86@kernel.org; linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Jing Li <lijing@hygon.cn>; Zhenglang Hu <huzhenglang@hygon.cn>
> 主题: Re: [PATCH 1/3] perf/x86/amd/uncore: Add common PMU helper functions
> 
> On Wed, Jul 01, 2026 at 03:44:11AM +0000, Qi Liu wrote:
> > Add common helper functions for AMD-family uncore PMU handling.
> > 
> > The helpers cover event initialization, counter allocation, counter 
> > read/update, event start/stop and per-CPU context management.  These 
> > paths are not tied to a specific uncore unit and can be reused by 
> > drivers with a similar uncore PMU programming model.
> > 
> > Signed-off-by: Qi Liu <liuqi@hygon.cn>
> > Tested-by: Zhenglang Hu <huzhenglang@hygon.cn>
> 
> > +EXPORT_SYMBOL_GPL(uncore_common_set_update_interval);
> > +EXPORT_SYMBOL_GPL(event_to_uncore_common_pmu);
> > +EXPORT_SYMBOL_GPL(uncore_common_attr_group);
> > +EXPORT_SYMBOL_GPL(uncore_common_start_hrtimer);
> > +EXPORT_SYMBOL_GPL(uncore_common_read);
> > +EXPORT_SYMBOL_GPL(uncore_common_start);
> > +EXPORT_SYMBOL_GPL(uncore_common_stop);
> > +EXPORT_SYMBOL_GPL(uncore_common_event_init);
> > +EXPORT_SYMBOL_GPL(uncore_common_add);
> > +EXPORT_SYMBOL_GPL(uncore_common_del);
> > +EXPORT_SYMBOL_GPL(uncore_common_ctx_init);
> > +EXPORT_SYMBOL_GPL(uncore_common_ctx_free);
> > +EXPORT_SYMBOL_GPL(uncore_common_ctx_move);
> 
> I like the idea, but I don't particularly like the namespace.
> 'uncore_common' is too generic, there are a ton of uncore drivers, even on x86 and these functions are specific to the AMD family. That is, they aren't really common at all.
> 
> Hi Peter,
> 
> Thanks for your reply!
> 
> Yes, that namespace is a fair point — "common" is too broad. Here are two options:
> A) amd_uncore_* — The prefix describes the programming model origin, not the vendor running it.
> B) amd_family_uncore_* — makes it explicit that this is AMD-family uncore infrastructure.
> 
> Do you have a preference?  Or something else entirely?

'amd_uncore_' works for me.
