Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43F32BE051;
	Tue,  2 Dec 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694613; cv=none; b=uZVB5yhVKJ0R1GBFl5R1pMRj1TTP3XQaAesdYwWf60X7OTgDyC3TmS/OYP3fN9ERM5y1//cXkaK6eFK6hU7aBVuLBPACm4wQlRVi3pUWpwgA7h1gvK8A6XX0MQFoWaaJ9zsMc5PAtNyFphQkDXOLrLJeayl9JmR4oNcIndecOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694613; c=relaxed/simple;
	bh=5jGJPOu/QCYhX1AnpslbAm1Vx/h/4ayy2JUFzAfJZso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMg3k5++sTKlRQTAUsxfjHBP3E6YRDZvrUO/sj6V86Kp83mDedtRK0Q8LCjJMWfzhNucWy1KPecU/p7lDDFRzh1dGbgxVU3Rfwgcpsc2KkDmR0MGo8tc8e1Qo9cIFYQeTn5ogbJwXkQLeyGw4xXgNamogMv88Z/SkwBHbAljb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A93AD1477;
	Tue,  2 Dec 2025 08:56:42 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A29E63F66E;
	Tue,  2 Dec 2025 08:56:49 -0800 (PST)
Date: Tue, 2 Dec 2025 16:56:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 11/19] coresight: trbe: Apply overwrite erratum for only
 wrap event
Message-ID: <20251202165647.GE724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-11-7da32b076b28@arm.com>
 <cca13ee6-83d9-4478-ace0-1e7bedf79d0e@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca13ee6-83d9-4478-ace0-1e7bedf79d0e@arm.com>

On Tue, Dec 02, 2025 at 12:05:52PM +0000, Suzuki K Poulose wrote:
> On 01/12/2025 11:22, Leo Yan wrote:
> > The overwrite erratum occurs only on wrap events, so apply the extra
> > wrap condition check in the workaround.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-trbe.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> > index e579ea98523c24d23a0cd265dcdd0a46b52b52da..2600af12a8fb94bb8c74efda2a101aacd01b0b34 100644
> > --- a/drivers/hwtracing/coresight/coresight-trbe.c
> > +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> > @@ -714,7 +714,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
> >   	 * 64bytes. Thus we ignore the potential triggering of the erratum
> >   	 * on WRAP and limit the data to LIMIT.
> >   	 */
> > -	if (wrap)
> > +	if (wrap && trbe_may_overwrite_in_fill_mode(buf->cpudata))
> >   		write = get_trbe_limit_pointer();
> 
> This must be trbe_may_write_out_of_range() ?

SDEN (e.g., [1]) is ambiguous about how the write pointer acts for the
out-of-range erratum.

However, SDEN explicitly states for overwrite erratum: "The current
write pointer also increments by the same number of cache line
locations.

If this is still concerned, I can add check
trbe_may_write_out_of_range() in next spin.

Thanks,
Leo

[1] https://documentation-service.arm.com/static/636a660b4e6cf12278ad89c4?token=
