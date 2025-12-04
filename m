Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B51E57C9F;
	Thu,  4 Dec 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854705; cv=none; b=MFLjGX/C7/sD01Ef0sqaBKquPOvuy/pWox1/ojzuPJ/moU7rIc8qldXg1v+Jd+vPqGZeNYoNY8CGJOHb5v8vL+TKFnq7d+XeTwBocDhCprAxzQCLtCo6Cw4Y/3oreD/KDU9COR0gMY460lPUQSBcXOUajV+CcYz/knlTTa8rC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854705; c=relaxed/simple;
	bh=OOI4kalaLoF/dOxZ4+gFPnsi4luGfIgIQi/HdzrvzlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTRmP/BLN/h71fjespO40uLMYVs32UYus+nysSwW7ghgWkEZPubSJHFzCxnc+uNu9ZE8gZGqFcWF0MiJeUs0nMYAUSzut4YHCFH6mSASgM5ldfuzOCVXIpe9Mwck6Td2UUIAUPE/P/gq0Ifw+4jihNxsDRR/apT/0K8nX3+yLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B7CE339;
	Thu,  4 Dec 2025 05:24:55 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C32F3F59E;
	Thu,  4 Dec 2025 05:25:02 -0800 (PST)
Date: Thu, 4 Dec 2025 13:25:00 +0000
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
Subject: Re: [PATCH 04/19] coresight: trbe: Remove set_trbe_disabled() from
 the enable flow
Message-ID: <20251204132500.GM724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-4-7da32b076b28@arm.com>
 <789573eb-c12b-419f-80bc-3de65367583e@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <789573eb-c12b-419f-80bc-3de65367583e@arm.com>

On Thu, Dec 04, 2025 at 06:13:56PM +0530, Anshuman Khandual wrote:
> On 01/12/25 4:51 PM, Leo Yan wrote:
> > set_trbe_disabled() should never appear in the enable flow, otherwise,
> > it may potentially hide bugs in the disable flow.
> > 
> > Remove set_trbe_disabled() from the enable path.
> 
> IIRC without first disabling TRBLIMITR_EL1_E - TRBE registers or their
> fields should not be fetched or interpreted.

Yes. I think you are referring to the rule DJMDD in Arm ARM: "The PE
might ignore a direct or external write to any of certain Trace Buffer
Unit registers ... (when) TRBLIMITR_EL1.E is 1, and the Trace Buffer
Unit is using Self-hosted mode."

> Without that none of the
> subsequent HW operations should be performed inside trbe_enable_hw()
> leading upto enabling it.

Fair enough.

If we can conclude the trace unit has been disabled properly in below
cases, no reason to arbitrarily calling set_trbe_disabled() during each
enable.

  1) The SYS_TRBLIMITR_EL1 register is cleared in trbe_reset_local()
     during probe phase.
  2) The SYS_TRBLIMITR_EL1.E bit is cleared in arm_trbe_irq_handler()
     for interrupt handling.
  3) The SYS_TRBLIMITR_EL1.E bit is cleared in the disable flow.


Seems to me, this is not only for code cleanup, we need to promise a
sane logic in the flow.

Thanks,
Leo
