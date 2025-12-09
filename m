Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E822C0263;
	Tue,  9 Dec 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295847; cv=none; b=ZSHo6lJR9L51pIY/pi8uGM0z9WDgjJuHCwCMGr0tE1LQdrlUMBhMtn/FtxBmoLNwuvHqZD8xAfpgoXjJD+7tlHG9FKB2Zmen8J3fNFGbJqK45pvZKUhXp52G6wcWWXBsaWgfNU+5hhyEHEJ69McPRSoiE8OxUKvqh+oXoMnC3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295847; c=relaxed/simple;
	bh=F61cIfXxouBbpi53cpu2Eh0cn/nAP2vMHrT5Qv5kjD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVaxPrF9GEhPqw/4hS9LGFaf9uzMfSwTlZkroKpb8xu+Jn4tqCBGxJSMPux6QUfUxzueqdY6GcZtwhrbjSj+kXm8++dpgFnxu0uC427b7uZP3S3dmfvNYxOi2ORj4zkXjs82HJzr0eA/VvpasnEUOsGvEpUgD2GIqETPI9n6KW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89E97175D;
	Tue,  9 Dec 2025 07:57:17 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66D3F3F73B;
	Tue,  9 Dec 2025 07:57:24 -0800 (PST)
Date: Tue, 9 Dec 2025 15:57:22 +0000
From: Leo Yan <leo.yan@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
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
Subject: Re: [PATCH 06/19] coresight: trbe: Refactor syndrome decoding
Message-ID: <20251209155722.GX724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-6-7da32b076b28@arm.com>
 <ae63c69c-eff9-4665-a9a6-d395e61bea86@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae63c69c-eff9-4665-a9a6-d395e61bea86@arm.com>

On Fri, Dec 05, 2025 at 09:40:33AM +0530, Anshuman Khandual wrote:
> On 01/12/25 4:51 PM, Leo Yan wrote:
> > It gives priority to TRBSR_EL1.EA (external abort); an external abort
> > will immediately bail out and return an error.
> 
> This is an abrupt starting for a commit message without giving context.
> The rationale for the change needs to be explained rather than details
> of implementation.

Agreed.  I will refine the commit log to state that we need to diagnose
the error code based on the hierarchy information (EC and BSC).

> > Next, the syndrome decoding is refactored based on two levels of
> > information: the EC (Event Class) bits and the BSC (Trace Buffer Status
> > Code) bits.
> > 
> > If TRBSR_EL1.EC==0b000000, the driver continues parsing TRBSR_EL1.BSC to
> > identify the specific trace buffer event.  Otherwise, any non-zero
> > TRBSR_EL1.EC is treated as an error.
> > 
> > For error cases, the driver prints an error string and dumps registers
> > for debugging.
> > 
> > No additional checks are required for wrap mode beyond verifying the
> > TRBSR_EL1.WRAP bit, even on units with overwrite errata, as this bit
> > reliably indicates a buffer wrap.
> 
> Should the errata related changes be done in a separate patch instead ?

Good point.  I will consider extracting the change; this would make
the review clearer.

[...]

> >  static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle,
> >  						 u64 trbsr)
> >  {
> > +	const char *err_str;
> >  	int ec = get_trbe_ec(trbsr);
> >  	int bsc = get_trbe_bsc(trbsr);
> > -	struct trbe_buf *buf = etm_perf_sink_config(handle);
> > -	struct trbe_cpudata *cpudata = buf->cpudata;
> >  
> >  	WARN_ON(is_trbe_running(trbsr));
> > -	if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
> > -		return TRBE_FAULT_ACT_FATAL;
> >  
> > -	if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
> > -		return TRBE_FAULT_ACT_FATAL;
> > +	if (is_trbe_abort(trbsr)) {
> > +		err_str = "External abort";
> > +		goto out_fatal;
> > +	}
> >  
> > -	/*
> > -	 * If the trbe is affected by TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
> > -	 * it might write data after a WRAP event in the fill mode.
> > -	 * Thus the check TRBPTR == TRBBASER will not be honored.
> > -	 */
> > -	if ((is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) &&
> > -	    (trbe_may_overwrite_in_fill_mode(cpudata) ||
> > -	     get_trbe_write_pointer() == get_trbe_base_pointer()))
> > +	switch (ec) {
> > +	case TRBE_EC_OTHERS:
> > +		break;
> 
> No message for this ?

No.  EC_OTHERS means "this is a normal maintenance interrupt".

> > +	case TRBE_EC_BUF_MGMT_IMPL:
> > +		err_str = "Unexpected implemented management";
> > +		goto out_fatal;
> > +	case TRBE_EC_GP_CHECK_FAULT:
> > +		err_str = "Granule Protection Check fault";
> > +		goto out_fatal;
> > +	case TRBE_EC_STAGE1_ABORT:
> > +		err_str = "Stage 1 data abort";
> > +		goto out_fatal;
> > +	case TRBE_EC_STAGE2_ABORT:
> > +		err_str = "Stage 2 data abort";
> > +		goto out_fatal;
> > +	default:
> > +		err_str = "Unknown error code";
> > +		goto out_fatal;
> > +	}
> > +
> > +	switch (bsc) {
> > +	case TRBE_BSC_NOT_STOPPED:
> > +		break;
> > +	case TRBE_BSC_FILLED:
> > +		break;
> > +	case TRBE_BSC_TRIGGERED:
> > +		err_str = "Unexpected trigger status";
> > +		goto out_fatal;
> > +	default:
> > +		err_str = "Unexpected buffer status code";
> > +		goto out_fatal;
> > +	}
> 
> Just wondering if it would be cleaner to add a const char * based
> static array mapping these EC/BSC codes with above error messages.

Now we have two level's (EC/BSC) error codes, it would be complex to
maintain a string array and map to two level's error codes.

> > +	if (is_trbe_wrap(trbsr))
> 
> But what about TRBE affected with trbe_may_overwrite_in_fill_mode()
> is that still being taken care of some how ?

The TRBSR_EL1.WRAP bit reliably indicates that the pointer has
wrapped.  I don't think we need any special handling for the overwrite
erratum here; we can simply return TRBE_FAULT_ACT_WRAP.

Afterward, trbe_get_trace_size() consumes the wrap flag and will
compute the trace size appropriately for the overwrite erratum when
the wrap flag is set.

[...]

> > -#define TRBE_EC_OTHERS		0
> > -#define TRBE_EC_STAGE1_ABORT	36
> > -#define TRBE_EC_STAGE2_ABORT	37
> > +#define TRBE_EC_OTHERS			0x0
> > +#define TRBE_EC_GP_CHECK_FAULT		0X1e
> > +#define TRBE_EC_BUF_MGMT_IMPL		0x1f
> > +#define TRBE_EC_STAGE1_ABORT		0x24
> > +#define TRBE_EC_STAGE2_ABORT		0x25
> 
> Please do mention the document source for these new EC codes in the
> commit message.

As James suggested in another reply, I will consider to add sysreg
enum.

Thanks,
Leo
