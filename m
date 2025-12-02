Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A487248896;
	Tue,  2 Dec 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695559; cv=none; b=prgXmu5ju/S81qUl5VgDrIjNqEBhkoaruswLL6+yBP61nKo/8o8Bblk/6pqu9R6Pv+862a+errzkSKuDGlgZEV6x+AfOgcxY7nCQ2NI2TG12ALQETiMKbx2Y87uEfUXj6BfO/2A2rTwNFLNrNEsFGbZn7B1TVp+LxBhK2MZa+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695559; c=relaxed/simple;
	bh=dygzfaG+wD1nBew3lbcSnFxch4DT0ln1gxp9EcCjxM8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skB8r6oP9QusodkOd7EyheCsbvKQc9VuaI/NyNpcxgIAUB0FT3oxaWdDNYUtIFUlYtahGY/T4G8HSpMtd5mhttCgWUayyPF/tF/Kc6uov0rgMgOgLNC3yudnR5U2+e4PtPIV1evNElU/rXEKU411dWfNnZCz4YDqRDGS0RJzkxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D5C01477;
	Tue,  2 Dec 2025 09:12:28 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 867673F66E;
	Tue,  2 Dec 2025 09:12:35 -0800 (PST)
Date: Tue, 2 Dec 2025 17:12:33 +0000
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
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
Message-ID: <20251202171233.GF724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-11-7da32b076b28@arm.com>
 <cca13ee6-83d9-4478-ace0-1e7bedf79d0e@arm.com>
 <20251202165647.GE724103@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202165647.GE724103@e132581.arm.com>

On Tue, Dec 02, 2025 at 04:56:47PM +0000, Coresight ML wrote:
> On Tue, Dec 02, 2025 at 12:05:52PM +0000, Suzuki K Poulose wrote:
> > On 01/12/2025 11:22, Leo Yan wrote:
> > > The overwrite erratum occurs only on wrap events, so apply the extra
> > > wrap condition check in the workaround.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-trbe.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> > > index e579ea98523c24d23a0cd265dcdd0a46b52b52da..2600af12a8fb94bb8c74efda2a101aacd01b0b34 100644
> > > --- a/drivers/hwtracing/coresight/coresight-trbe.c
> > > +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> > > @@ -714,7 +714,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
> > >   	 * 64bytes. Thus we ignore the potential triggering of the erratum
> > >   	 * on WRAP and limit the data to LIMIT.
> > >   	 */
> > > -	if (wrap)
> > > +	if (wrap && trbe_may_overwrite_in_fill_mode(buf->cpudata))
> > >   		write = get_trbe_limit_pointer();
> > 
> > This must be trbe_may_write_out_of_range() ?
> 
> SDEN (e.g., [1]) is ambiguous about how the write pointer acts for the
> out-of-range erratum.

Thought again, we should not worry about out-of-range case.

As the workaround always ensures sufficient space beyond the limit, the
write pointer remains valid within the allocated buffer even if it is
updated and crosses that limit.
