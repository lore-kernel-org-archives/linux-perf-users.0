Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0318595F;
	Thu, 12 Dec 2024 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030724; cv=none; b=FsE6uIrCui/5VZrGlYuLxIgULef7bmybh8xl14VIkraZGS+pEd0h4y3NwCNCIB6S/e6GHu3BD/sh0uicKYcxsfA6wL+e7Aszu+CTzV3GH/ZLLqfsNdnYNL8PgMBfLT0tyQJSklCcVIha1UBql2TC3Ia/KQwRaM7VNuykdwAw+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030724; c=relaxed/simple;
	bh=MgY62L+MUiZnc/x6u50hA46Yaw/AFEsXyfXF5unnxqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAC0RKZ+2iO+w4+mSyLnvV0Cu8JMVYpQkCX+5UA/AP1Sw8ESmUKALR5DTwHnFWoCulszG8dEuuvs2qZ9T22NLJVx0eRTMXizJt5iqhjOQ8Hfal7MsXMKNwk3Qyei9KovLbfIXzcCTocUv18L3eg7vtVdPZN2fufhsnUKONTMmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j42MNtOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j42MNtOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059E7C4CECE;
	Thu, 12 Dec 2024 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734030723;
	bh=MgY62L+MUiZnc/x6u50hA46Yaw/AFEsXyfXF5unnxqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j42MNtOU7tEdtWqCMb/Em3Bh1sAbO4oulHVJ8lhMz/0ODwfKUB1qmALDEtAAEEm/f
	 XtI1COsIGIZ9WANU5EfM/os6dgtM4HgSignx5pdCn+sVxnQUnUnSnqhTlYwE4oILPq
	 Ls0ZS8oZbNJffrB3Bub70cVhVD6fymEI8m6UIE8IV7tWN+VYsPScJKjJOkiGKkzvIZ
	 U7z9RTmfmW9Sqmjce/+mRc8Lm3tgntNLXDv3Pbx/YmSzCdltmWsy3ZuU1GA1sT7RC0
	 n5DYIZRkEn+cMghVHSCPrPdDCFe2ZtYioVpTzH088A/y2UKLMRRWsSP+x8+tETUG63
	 jthFRDsNsSD+Q==
Date: Thu, 12 Dec 2024 16:12:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	nd@arm.com, namhyung@kernel.org, mark.rutland@arm.com,
	james.clark2@arm.com
Subject: Re: [PATCH 1/1] perf/util: initialize is_test value in
 expr__ctx_new()
Message-ID: <Z1s1gB6FQZg3ZZqL@x1>
References: <20241108143424.819126-1-yeoreum.yun@arm.com>
 <c03b1604-cc41-4746-be3a-fc326152d556@linaro.org>
 <CAP-5=fUSE9Pt+=T73wTUn+y_7iMZ6=bNNNgP0z_a1ty_KwV1Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUSE9Pt+=T73wTUn+y_7iMZ6=bNNNgP0z_a1ty_KwV1Lw@mail.gmail.com>

On Wed, Nov 13, 2024 at 08:57:08AM -0800, Ian Rogers wrote:
> On Wed, Nov 13, 2024 at 8:13 AM James Clark <james.clark@linaro.org> wrote:
> > On 08/11/2024 2:34 pm, Levi Yun wrote:
> > > when expr_parse_ctx is allocated by expr_ctx_new(),
> > > expr_scanner_ctx->is_test isn't initialize, so it has garbage value.
> > > this can affects the result of expr__parse() return when it parses
> > > non-exist event literal according to garbage value.
> > >
> > > use calloc instead of malloc in expr_ctx_new() to fix this.
> > >
> > > Fixes: 3340a08354ac ("perf pmu-events: Fix testing with JEVENTS_ARCH=all")
> > > Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> > > ---
> > >   tools/perf/util/expr.c | 5 +----
> > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > > index 5e3732bc2fa5..bc119501f091 100644
> > > --- a/tools/perf/util/expr.c
> > > +++ b/tools/perf/util/expr.c
> > > @@ -285,7 +285,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
> > >   {
> > >       struct expr_parse_ctx *ctx;
> > >
> > > -     ctx = malloc(sizeof(struct expr_parse_ctx));
> > > +     ctx = calloc(1, sizeof(struct expr_parse_ctx));
> > >       if (!ctx)
> > >               return NULL;
> > >
> > > @@ -294,9 +294,6 @@ struct expr_parse_ctx *expr__ctx_new(void)
> > >               free(ctx);
> > >               return NULL;
> > >       }
> > > -     ctx->sctx.user_requested_cpu_list = NULL;
> > > -     ctx->sctx.runtime = 0;
> > > -     ctx->sctx.system_wide = false;
> > >
> > >       return ctx;
> > >   }
> > > --
> > > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> > >
> > >
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
