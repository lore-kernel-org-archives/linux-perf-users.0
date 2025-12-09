Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A452139CE;
	Tue,  9 Dec 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294151; cv=none; b=ZkgzKS7LW7h404GnGeMW9vIit0d8fx8ajakjkdCeYY18pMYfsDRtfbkVQ4XWTilnEbNa89US4d58sr/MAhFfT6ziOytAWWQelbPIUjfWct9aOy1l5m6erqNhagFrzMTIzFGPGOHNFtIhgOE+9+dqCwVIMsrtDR92CLAwZg7uAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294151; c=relaxed/simple;
	bh=lJ78JKhc0D0KRFt5O5vf0StMUM4KlODwIYT3q55ALLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2hreoiX3On8Iq/fzgwaz9jhygZ477U6pxMExghM17l6N3TLcKqHTFglq6FdsxmNgwx+kXLT6ozoHsya9YmVMWV9gagaLAHtk0jai9ncWKF/+Wvw8vCdwDIfgqZf695djqFq2nUYZ/62IynS92sn0JBACBmddrOewwcmWjEyP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9ED2175D;
	Tue,  9 Dec 2025 07:29:01 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A557D3F762;
	Tue,  9 Dec 2025 07:29:08 -0800 (PST)
Date: Tue, 9 Dec 2025 15:29:06 +0000
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
Subject: Re: [PATCH 05/19] coresight: trbe: Refactor status clearing
Message-ID: <20251209152906.GW724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-5-7da32b076b28@arm.com>
 <fb3b495a-3e04-417f-a674-e1753fd85177@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb3b495a-3e04-417f-a674-e1753fd85177@arm.com>

On Thu, Dec 04, 2025 at 06:27:27PM +0530, Anshuman Khandual wrote:
> On 01/12/25 4:51 PM, Leo Yan wrote:
> > If the driver does not clear the status when disabling the trace buffer
> > unit, stale state will carry over to the next enable, though the driver
> > clears it again on enable.
> 
> There is no problem now ! Because trbe_enable_hw() calls clr_trbe_status().
> 
> > 
> > Explicitly clear status after the trace is disabled in the interrupt
> > handling and when a perf session ends.  Keep the status for spurious
> > interrupts for continuous tracing.
> 
> But is not that the behaviour already without this change ?
> 
> clr_trbe_status() in trbe_enable_hw() ensures that no TRBE session can be
> started without first clearing the existing status. Still wondering what
> is the purpose of this change ?

It is about the driver's sanity.

The driver should clear the status immediately when the trace unit is
disabled, rather than waiting until the next enable.  This avoids
unexpected behaviour, such as a spurious TRBE interrupt.

Consider an edge case: if TRBE is being disabled at the same moment it
is about to raise an interrupt, arm_trbe_update_buffer() may miss the
IRQ bit due to latency.  If arm_trbe_disable() does not clear that bit,
arm_trbe_irq_handler() will still run after the perf event has been
stopped.  The interrupt handler then retrieves the trbe_buf pointer
from the perf output handle, which is dangerous because the perf
session has already ended.

Thanks,
Leo
