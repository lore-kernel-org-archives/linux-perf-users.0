Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D826ED3C;
	Tue,  2 Dec 2025 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674513; cv=none; b=VAMbzsu0cjc3nKWbaA5ofVmcpPCuQJOkJVrU21wxN2lAmzyHGuSJCRCPdrtPuAVQOy92jvR1BYfFGATe4A33hgnbgy4xppw9z7kfx44xRmYNtncOf0RfnX1YKAh3pZTQLBl9+Zt4wmv2AEBZNflfmfGYruLTSo4J6i3WydYwqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674513; c=relaxed/simple;
	bh=auVLsPNpyHpzeluHHkr9ROvp3UeBCH9pm+ESfHigkgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPSCWkde+/++e4iYsR+D6/Ejy3g/YODrRjZTOqQzLDcfiENRBoKxN62kGrd//E12jCPyzXkTI9bb7Jf3Y/kJtWwW2+BnoKwLTcRCdcV4b4AWBYQqh1Qm/B2pB4nWCYA3a1wytBXS1O4BWW7cDdLQaKAUA3ZV4GaZvVUMoCci6nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8D44153B;
	Tue,  2 Dec 2025 03:21:42 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C214C3F59E;
	Tue,  2 Dec 2025 03:21:49 -0800 (PST)
Date: Tue, 2 Dec 2025 11:21:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] perf tools: Track all user changed config bits
Message-ID: <20251202112147.GT724103@e132581.arm.com>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-1-22ecbbf8007c@linaro.org>
 <20251202101556.GR724103@e132581.arm.com>
 <978dd9b1-1cb0-4338-95fa-575a858cea80@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978dd9b1-1cb0-4338-95fa-575a858cea80@linaro.org>

On Tue, Dec 02, 2025 at 10:40:49AM +0000, James Clark wrote:
> 
> 
> On 02/12/2025 10:15 am, Leo Yan wrote:
> > On Mon, Dec 01, 2025 at 04:41:04PM +0000, Coresight ML wrote:
> > 
> > [...]
> > 
> > > +#define ADD_CONFIG_CHG(format_type, term_type, new_term)		\
> > > +{									\
> > > +	struct parse_events_term *term;					\
> > > +	u64 bits = 0;							\
> > > +	int type;							\
> > > +									\
> > > +	list_for_each_entry(term, &head_config->terms, list) {		\
> > > +		if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {  \
> > > +			type = perf_pmu__format_type(pmu, term->config);\
> > > +			if (type != format_type)			\
> > > +				continue;				\
> > > +			bits |= perf_pmu__format_bits(pmu, term->config); \
> > > +		} else if (term->type_term == term_type) {		\
> > > +			bits = ~(u64)0;					\
> > > +		}							\
> > > +	}								\
> > > +									\
> > > +	if (bits)							\
> > > +		ADD_CONFIG_TERM_VAL(new_term, cfg_chg, bits, false);	\
> > > +	return 0;							\
> > 
> > Nitpick: "return 0" is not needed here.  Otherwise:
> > 
> > Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> I think it's worse than not needed, it makes it stop collecting the changes
> after the first one.

Just curious how this can happen.

  foo()
  {
      {
          chunk 1;
      }

      {
          chunk 2;
      }
  }

Seem to me, if without "return 0" in chunk 1, it still can continue to
run chunk 2, no?

> It was annoying that this had to be a macro instead of a function because
> ADD_CONFIG_TERM_VAL constructs the #define name of the first argument.
> 
> It's probably worth putting in some effort to make ADD_CONFIG_CHG() a
> function to avoid problems like this and maybe add a test.

This would be fine for me.

Thanks,
Leo
