Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E350319857;
	Thu,  9 Apr 2026 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699705; cv=none; b=CFxa11TWhN0G681f1Md0U9NALFZFVDInLqnL5pfMRnN/8Ibuhuv3ZVvpuu3lXB6eiCe7MtyrWrmpBqmnWTF9YiR70KDTHSph0C3XDuixHrVDtix9XyPut4MPLn/CZU/oKv7Ts0nVIwtkp0Fbsx1SskgXuXHN53beEqE4H5XC0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699705; c=relaxed/simple;
	bh=tfXnPO8QfGZiGbiLkCITS3SPUCv9zEX1laQcNw4VbZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdqdKPSmxQCRyfsuy3NiFXcqTN+1tGpzsgz42a0oHLcrxf3aTczhK/2rB5x3EWVPov80W2T+AxHWUX31c/vsxWnem8hFxy2l5WDaj16WuOBH0qB5KVr5o+h2d2fo6U4KyxvVC6cdGkLMqTJ4Ygu4GIyVw1q5ab3Ww305dQcKmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTrIrQ/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTrIrQ/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96499C19421;
	Thu,  9 Apr 2026 01:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775699704;
	bh=tfXnPO8QfGZiGbiLkCITS3SPUCv9zEX1laQcNw4VbZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTrIrQ/TJvpsUoji4VVTjA6l88FY5p+D43L07saGWSN7RhXXLOs428KuJDhSv/E15
	 naCgBlSNZJLT1VCyTp9of8GRsvllpeQwr7R1ovLBVru+H0mdzokmwvIDvm83mowgCn
	 T/9FT63wxQfIp/+cNgBFJw0Ii9dS/RSixwxYvxDRsONi6aYV9509GTmlKuOkZ9+dfn
	 EuiaAMFpNg/ZFZLex+BVWvatxNKoNNf0tQn3fjCfGDNHNpMPNVkzBFt/emY+Z9xZnd
	 7riuNdvfBFddbFkcgMJdKOa1BibeaxlFCoMERHeYPF6wvTff+sGdUzAoY+8L+s1jyu
	 es5VVGX5mBN7w==
Date: Wed, 8 Apr 2026 18:55:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 04/23] perf kwork: Duplicate IRQ name in irq_work_init
Message-ID: <adcG9Rlp1znYkgYJ@google.com>
References: <20260408072601.210837-5-irogers@google.com>
 <20260408080812.0EB34C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408080812.0EB34C19424@smtp.kernel.org>

On Wed, Apr 08, 2026 at 08:08:11AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] Massive per-event memory leak of dynamically allocated IRQ names when updating existing `kwork_work` entries.
> - [Medium] Missing check for `strdup()` allocation failure leads to undefined behavior in `snprintf()`.
> --
> 
> commit fd542621f59f12c7e1282f77ef0817d45c3b81a0
> Author: Ian Rogers <irogers@google.com>
> 
> perf kwork: Duplicate IRQ name in irq_work_init
> 
> This commit duplicates the IRQ name string when initializing a kwork work
> item to avoid lifecycle issues with pointers into the perf event sample.
> It also updates perf_sample__strval to return a const char pointer.
> 
> > diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> > index f600037ee4603..dceb9b79aa6ac 100644
> > --- a/tools/perf/builtin-kwork.c
> > +++ b/tools/perf/builtin-kwork.c
> > @@ -1018,7 +1018,7 @@ static void irq_work_init(struct perf_kwork *kwork,
> >  		work->name = NULL;
> >  	} else {
> >  		work->id = perf_sample__intval(sample, "irq");
> > -		work->name = perf_sample__strval(sample, "name");
> > +		work->name = strdup(perf_sample__strval(sample, "name") ?: "<unknown>");
> 
> Does this code leak the allocated name string when processing existing work
> items?
> 
> In event processing loops like work_push_atom() and work_pop_atom(), a
> temporary kwork_work struct is allocated on the stack for every single trace
> event. If the item is already present in the RB-tree, work_findnew() or
> work_search() returns the existing kwork_work object which already has its
> name populated.

Similarly, I think you can drop this patch unless you really want to fix
the memory problems in kwork code base properly.

Thanks,
Namhyung

> 
> Since the newly allocated name string on the temporary structure is ignored
> for existing items, does this leak the duplicated string for every repeated
> IRQ trace event?
> 
> What happens if strdup() fails and returns NULL here?
> 
> Later in irq_work_name(), work->name is passed directly to snprintf() with
> the %s format specifier:
> 
> static void irq_work_name(struct kwork_work *work, char *buf, int len)
> {
>         snprintf(buf, len, "%s:%" PRIu64 "", work->name, work->id);
> }
> 
> Could this regression cause a segmentation fault during memory pressure if
> work->name becomes NULL?
> 
> >  	}
> >  }
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260408072601.210837-1-irogers@google.com?part=4
