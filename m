Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D224DCF9;
	Fri, 31 Jul 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533650; cv=none; b=oPqmtTnydI97eA3WqYnEq9I+pawaSNxHerohm+CfSr3NlDo+83dfOFGS7NRLd6Q9p3MsS6NpNvN6KM1r/D6sz9bSwIPg3s6Ju6CAnss/RT8d1BloAgPF1UMI/tP4GZsNQdQEWhkZS2gJ2rJmhlh+XKQxYKrqo0aXpXIAdAkM1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533650; c=relaxed/simple;
	bh=FudgXTU4ZJTufU4pi0e481awJUx5986po5dy55dOzOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuzAcLOMFMqxxmdaZbTm5AJ3zAcYwujlG9GWcETYIlj5/Xf2tPEKHsO16MQ9zmpXwIaLLPELOeqn3fra5dl6AuT5qgY18n6c0lr22jG8N1RQxFRBEBVTmu7c4dZI9muMW4/h9WsMKYLMmURJNk+nwW2o8ARv81fEpgnbVQbe82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsQ/ANIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsQ/ANIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079BF1F00AC4;
	Fri, 31 Jul 2026 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785533649;
	bh=yEVnA1WSQ0ag/HvhcHi5kYIwwHhi6yD3GWY3cF6g9ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VsQ/ANIwKbiglIwBHfdv/XX3deRlIUO17Y5Qb+2+n7NNOI5NmxiNTEix+J5KLylbF
	 mV7UY55Toj6t2GUYNNhYFFoFB0JiE9M/WFFqkBI3WBOCNHtWdw3WBtIQR3BjVDib2p
	 6b0uFMYsLG+ni8md30LG0nc0T2dch75kggHpDBhdLQcVtst71T9RINI4Gd299bEmCL
	 DQkXnoM7UlnlaKzxfCN5CXh9eDomIChxc3Ky2QRWn5Kc2pDsnakrueUOaWxaeF+xNF
	 pPFew+pSluMjZKa+WfQRURY+akhyR4L35sxPWbfzF0+D9GFY0RZljG6rYWXk5e69D0
	 arg1+KG3MWrkQ==
Date: Fri, 31 Jul 2026 14:34:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] perf c2c: add a function view
Message-ID: <am0UzxbS-K61_eAd@google.com>
References: <amwL794Mj0O3vOkr@google.com>
 <20260731074420.359844-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731074420.359844-1-jiebin.sun@intel.com>

On Fri, Jul 31, 2026 at 03:44:20PM +0800, Jiebin Sun wrote:
> On Thu, Jul 30, 2026 at 07:43:59PM -0700, Namhyung Kim wrote:
> > Is it possible to add proper refcounts instead of borrowing?  I guess
> > that'd make the code simpler.
> 
> Yes, and it is simpler. Let me check the approach with you before I post v6.
> 
> The children now take their own references:
> 
>       child_he->ops = &c2c_function_entry_ops;
>       map_symbol__copy(&child_he->ms, &src_he->ms);   /* was memcpy() */
>       child_he->thread = thread__get(src_he->thread); /* was a raw assign */
> 
>       hist_entry__delete(child_he);                   /* was a custom free */
> 
> hist_entry__delete() takes care of thread/ms, mem_info, stat_acc and
> srcline/srcfile, and calls ops->free() for the c2c-private fields. So the
> custom destructor and the WARN_ON_ONCE(report_hierarchy) guard both go away.
> 
> Two sashiko comments fall out of this as well: the leaked srcline/srcfile and
> the missing ops are both covered by the generic destructor now, so I did not
> treat them separately. It also asked for NO_SLANG stubs for the two entry
> points declared in c2c.h, so I added them the way util/hist.h does.
> 
> If this looks right, I will send v6.

Sounds good to me.

Thanks,
Namhyung

