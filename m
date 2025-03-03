Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF512163A4;
	Mon,  3 Mar 2025 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018939; cv=none; b=t5A46dCKCeJO0d3SH0mvymOrLKgt+hwFKDuUDDNZ0E14wxZDAFZophlIUXYPhAEn5OHRkA70P+6d6uLL1LQpbu68pi9tr5PjkTSRdpzXh++ZJs/oWe4NzzKva6CUvhleD8O3qcmZOfoNegUw7g6lpb3ra8rjvoLFhYw0ih7eGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018939; c=relaxed/simple;
	bh=hXNpShBlQaqGOkOBpQ3icY/mZYgECaqMzluw+vPG8xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwBeV5w1uUbM71L2Jkf+Vdp96gxbCyM14TEGus0DseS1u+kGQWx9K4kp5VZo1EvFqGFJsvfx7xZT0dX8G2B3jiUUOhYUq0GWfuv0a3wiR3yz6YkA3SYSz0nB0pDBobBjhb1F/tbp73pdtZcpWN+8fUDIHoQGSr/V9fzoUd8uB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B55C106F;
	Mon,  3 Mar 2025 08:22:29 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D61B73F673;
	Mon,  3 Mar 2025 08:22:14 -0800 (PST)
Date: Mon, 3 Mar 2025 16:22:10 +0000
From: Leo Yan <leo.yan@arm.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/12] perf script: Make printing flags reliable
Message-ID: <20250303162210.GH2157064@e132581.arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250217195908.176207-2-leo.yan@arm.com>
 <34795c29-d256-49ce-9d01-435f8cd91611@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34795c29-d256-49ce-9d01-435f8cd91611@intel.com>

Hi Adrian,

On Mon, Mar 03, 2025 at 12:44:33PM +0200, Adrian Hunter wrote:
> On 17/02/25 21:58, Leo Yan wrote:
> > Add a check for the generated string of flags.  Print out the raw number
> > if the string generation fails.
> 
> How does it fail?

In practice, I agreed perf_sample__sprintf_flags() will not fail.  This
bases on a careful calculation for every invoking snprintf().

Please see comment below.

> > In another case, if the string length is longer than the aligned size,
> > allow the completed string to be printed.
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: James Clark <james.clark@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/perf/builtin-script.c   | 10 ++++++++--
> >  tools/perf/util/trace-event.h |  2 ++
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index d797cec4f054..2c4b1fb7dc72 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -1709,9 +1709,15 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
> >  static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
> >  {
> >  	char str[SAMPLE_FLAGS_BUF_SIZE];
> > +	int ret;
> > +
> > +	ret = perf_sample__sprintf_flags(flags, str, sizeof(str));
> > +	if (ret < 0)
> 
> AFAICT ret is always >= 0

Since I refactored perf_sample__sprintf_flags() in the sequential
patches, for easier capturing and debugging, here checks the return
value to detect any potential issues.

Later when we review a perf log, a printed raw number for error cases
can remind there must be something wrong for printing flags.

> > +		return fprintf(fp, "  raw flags:0x%-*x ",
> > +			       SAMPLE_FLAGS_STR_ALIGNED_SIZE - 12, flags);
> >  
> > -	perf_sample__sprintf_flags(flags, str, sizeof(str));
> > -	return fprintf(fp, "  %-21s ", str);
> > +	ret = max(ret, SAMPLE_FLAGS_STR_ALIGNED_SIZE);
> > +	return fprintf(fp, "  %-*s ", ret, str);
> 
> -21 means the field width is 21 and left-justified.  It should not
> truncate the string.

No, it does not truncate the string.

It calculates a maximum value between the returned length and 21 (
defined in SAMPLE_FLAGS_STR_ALIGNED_SIZE).  It keeps left-justified and
can printing a complete string if the string length is bigger than 21.

Thanks,
Leo

> 
> >  }
> >  
> >  struct printer_data {
> > diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> > index ac9fde2f980c..71e680bc3d4b 100644
> > --- a/tools/perf/util/trace-event.h
> > +++ b/tools/perf/util/trace-event.h
> > @@ -145,6 +145,8 @@ int common_flags(struct scripting_context *context);
> >  int common_lock_depth(struct scripting_context *context);
> >  
> >  #define SAMPLE_FLAGS_BUF_SIZE 64
> > +#define SAMPLE_FLAGS_STR_ALIGNED_SIZE	21
> > +
> >  int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
> >  
> >  #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
> 
