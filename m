Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D12D7817;
	Thu,  9 Apr 2026 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699509; cv=none; b=A1Gno/c+6/SZlDb99jDqe1mTHEZxIdoJL11ZpPh/IzYRCJwnwIauX6TfBLTkadHm81cl2AKZM2/dVOmf4lNGXR82QpFzzYBVZdUoHT8yvOedo78IJHJAHmydJtoHIc7GoGzR9vzKuNNGrd4ktT/QklOq5s2TE1bByofDtgTFT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699509; c=relaxed/simple;
	bh=rtymwEFPfh8Z5dK9imsoQ2aOCsbap5Zbqe7RVmpeLuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUalkKKHLlXYbzefeK2/6GLG7HEYCAEULqOJGC8W/su/MlGor6B88KhpLAFj0IZyQNfI4Txbq98nYELS22BjNWMdNaXXKBOroM2kphl1AE0lolR5HYeVxIMGY0P+vqF1rMVyFuJsHnoIbqR1iVi+Qup7X2cLBskaY6U1J8dkjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIucprTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIucprTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7475FC19421;
	Thu,  9 Apr 2026 01:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775699509;
	bh=rtymwEFPfh8Z5dK9imsoQ2aOCsbap5Zbqe7RVmpeLuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIucprTSxuxgoFzT/dZzMCD7cNqkj5NrJw7AeVKsrXZU2moZQfG7qNzPjzD+s+x99
	 Nd0o5YI1QTjI31XfbO9X9v2f2leMCPtud82C/VMSWIJgg5fKWPK1HOrpJpj+lwnQoM
	 xm31j3GqVda+XlUmiGT4ZAk42+hS1bQcSH9j/5Tgqj3Zo0Fi5NaAcgrptlO3bsFJAo
	 rJSelG6kxBHanSLzebILMGS7SPoUym3fXMgCk3APT85eDLEf+yvVV2dXOgsA5VnY00
	 kwWIrrzvcPnMD6J5v5Y3hJS+d74wmKtwjnZ0I3yMAUdLFfpYAlh9CidQKlBmgzxR0E
	 UoNTgwk1Hl9ww==
Date: Wed, 8 Apr 2026 18:51:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 03/23] perf evsel: Refactor evsel tracepoint sample
 accessors perf_sample
Message-ID: <adcGMruruUxSVBMZ@google.com>
References: <20260408072601.210837-4-irogers@google.com>
 <20260408082023.41F14C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408082023.41F14C2BCB3@smtp.kernel.org>

On Wed, Apr 08, 2026 at 08:20:22AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Integer overflow and incomplete validation in the newly added tracepoint bounds checks allow out-of-bounds memory accesses.
> --
> 
> commit f7dda507e65d40381a27ba2e39e45e8a6050afff
> Author: Ian Rogers <irogers@google.com>
> 
> perf evsel: Refactor evsel tracepoint sample accessors perf_sample
> 
> This commit refactors tracepoint sample accessors to remove the evsel
> argument. It also adds bounds checks when reading values from tracepoint
> fields based on review feedback.
> 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 2ee87fd84d3ea..b653e683d7a12 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3687,15 +3687,20 @@ struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *na
> >  	return tp_format ? tep_find_common_field(tp_format, name) : NULL;
> >  }
> >  
> > -void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name)
> > +void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
> >  {
> > -	struct tep_format_field *field = evsel__field(evsel, name);
> > +	struct tep_format_field *field = evsel__field(sample->evsel, name);
> >  	int offset;
> >  
> >  	if (!field)
> >  		return NULL;
> >  
> >  	offset = field->offset;
> > +	if ((u32)(offset + field->size) > sample->raw_size) {
> > +		pr_warning("Invalid trace point field offset %d for field of length %d in sample raw data of size %u\n",
> > +			   offset, field->size, sample->raw_size);
> > +		return NULL;
> > +	}
> 
> Can this bounds check be bypassed due to integer overflow? If a malformed
> perf.data file provides an exceptionally large offset (for example,
> 0xFFFFFFFC) and a size of 4, the sum could wrap around to 0. Would this
> allow an out-of-bounds read when accessing the memory?

I think it's better not to include any bounds check in the patch.
It's adding a lot of review noise and doesn't help making progress.
You can ignore security issues in this series as they are pre-existing,
and just make this patch simple, doing one thing - removing 'evsel'
argument.

The review comments can be addressed in a separate patch series
(preferrably) or different patches in this series.

Thanks,
Namhyung

> 
> >  	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> >  		offset = *(int *)(sample->raw_data + field->offset);
> >  		offset &= 0xffff;
> >  		if (tep_field_is_relative(field->flags))
> >  			offset += field->offset + field->size;
> >  	}
> > 
> >  	return sample->raw_data + offset;
> 
> Is the dynamically computed offset validated against sample->raw_size? It
> appears the initial check covers the initial field offset, but the newly
> computed offset for dynamic fields is added directly to sample->raw_data
> without a subsequent bounds check, which might lead to out-of-bounds memory
> accesses.
> 
> [ ... ]
> 
> > @@ -3713,6 +3718,12 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
> >  	u64 value;
> >  	void *ptr = sample->raw_data + field->offset;
> >  
> > +	if ((u32)(field->offset + field->size) > sample->raw_size) {
> > +		pr_warning("Invalid trace point field offset %d for field of length %d in sample raw data of size %u\n",
> > +			   field->offset, field->size, sample->raw_size);
> > +		return 0;
> > +	}
> > +
> 
> Can this suffer from the same integer overflow issue? If field->offset and
> field->size wrap around when added together, it looks like an out-of-bounds
> pointer could be dereferenced when evaluating the field.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260408072601.210837-1-irogers@google.com?part=3
