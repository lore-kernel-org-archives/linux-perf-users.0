Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60713A3F7;
	Tue,  2 Dec 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685320; cv=none; b=olNr69SjoIe0xcwGOshDK3uJcumjXB5kPkLuoUAakgcu4kN5O0DI1c7Awhvg25wvmLir2AXqS1P8OXNTnBALg7HjNK1KND7xDo5W38GrQHfOxf+M8VNBfXLjhpKRVOvYqytP8P4t/1kN4ILUVmNqDEP92Hg6ODcYiXJ69EFoWOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685320; c=relaxed/simple;
	bh=YM2ubXURoSarxfea9UJsUCbNSnVA+Y4xpT7RFgBznQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONzae7LY5QPyAXhzGyHAfNEPTVJwuySweoHiM/LX4ayoUBDo5bzIP2Q8OTwVdacH5j68LFna4oKJFzxnA8047b0TJ62xLaDx0EpWCVwd1U+jyeX0xDbGlNNGMK2W8khYPuXmCYlsIaLQxRh3L6yPonXLOphemBxS6FBg41bCBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36C081477;
	Tue,  2 Dec 2025 06:21:50 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F0A23F73B;
	Tue,  2 Dec 2025 06:21:57 -0800 (PST)
Date: Tue, 2 Dec 2025 14:21:55 +0000
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
Subject: Re: [PATCH 07/19] coresight: trbe: Refactor AUX flag setting
Message-ID: <20251202142155.GB724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
 <e315b489-2ebf-4ab6-8a60-347f1b1dca16@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e315b489-2ebf-4ab6-8a60-347f1b1dca16@arm.com>

On Tue, Dec 02, 2025 at 11:15:47AM +0000, Suzuki K Poulose wrote:

[...]

> > @@ -687,6 +668,23 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
> >   		goto out_fatal;
> >   	}
> > +	/*
> > +	 * Mark the buffer to indicate that there was a WRAP event by
> > +	 * setting the COLLISION flag. This indicates to the user that
> > +	 * the TRBE trace collection was stopped without stopping the
> > +	 * ETE and thus there might be some amount of trace that was
> > +	 * lost between the time the WRAP was detected and the IRQ
> > +	 * was consumed by the CPU.
> > +	 *
> > +	 * Setting the TRUNCATED flag would move the event to STOPPED
> > +	 * state unnecessarily, even when there is space left in the
> > +	 * ring buffer. Using the COLLISION flag doesn't have this side
> > +	 * effect. We only set TRUNCATED flag when there is no space
> > +	 * left in the ring buffer.
> > +	 */
> > +	if (!is_trbe_running(trbsr))
> 
> Is this really required ? There is a WARN_ON(is_trbe_running(trbsr))
> above ?

The WARN_ON() will reports warning for running case, here it sets
COLLISION flag for not running case, which is not conflict.

This works for the Fill mode (stop collection), we always set the
COLLISION flag for it.  Once we enable trigger and wrap modes, due to
the trace continues to run, we don't set the flag for these modes.

> > +		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> 
> Also, setting this would unnecessarily mark COLLISION while stopping the
> TRBE buffer normally (when called from arm_trbe_update_buffer), when
> there is no WRAP event ?

Good point.  I should refactor arm_trbe_update_buffer(), it firstly
reads out TRBSR, stop trace afterwards, and then call
trbe_get_fault_act().

In this case, it is in running mode so COLLISION will not be set for
normal disable flow.

I will add a new patch for this and place it before this one.

> > +
> >   	if (is_trbe_wrap(trbsr))
> >   		return TRBE_FAULT_ACT_WRAP;
> 
> Couldn't this be :
> 
> 	/* Move the big fat comment here */
> 	if (is_trbe_wrap(trbsr)) {
> 		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> 		return TRBE_FAULT_ACT_WRAP;
> 	}

It deliberately de-couples the COLLISION flag from the WRAP event.

In later change, a WRAP event only means buffer wrap around, it does
mean the trace has been stopped.  The AUX flag is only set for
stopping case.

Thanks,
Leo
