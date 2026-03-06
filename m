Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5213D329C7F;
	Fri,  6 Mar 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800053; cv=none; b=Oxe+11nZZDF2TVgGslstlRayAWrSIdz4+FjvJ/oWr0UrLGsrx9EzOZc1Fc7SR31R15HD1agHEAWqvUvIY0ai8xw0JfCYzGft7f6abghYphM5lF523S1oPjzBAMs0JuilOVguJz3zQIU1D4w/rJQEQYCrMVmmZm3wkseZSei/ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800053; c=relaxed/simple;
	bh=gP9y9DVRF6k3D5D+UbfP/rKe4YcyJ7g4A5hftQSg9Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqjJWhihzprD7bs/81NIeaWm9melAjJjc+CaUmLyTOn3Ln8AI3GfA51DZuHUtJ614u9sh5RadIEVQbCX1Xfcw6oCB+dsfiGUBmbxRtfG8Q3Djwq7vpxURomoiFouaHtznPyVF54v+mDvqTlGj02mTITyMA+04bT/ru6Sv9XR7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75C48497;
	Fri,  6 Mar 2026 04:27:25 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F77D3F694;
	Fri,  6 Mar 2026 04:27:31 -0800 (PST)
Date: Fri, 6 Mar 2026 12:27:29 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf cs-etm: Finish removal of ETM_OPT_*
Message-ID: <20260306122729.GL1098637@e132581.arm.com>
References: <20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org>
 <20260306-james-perf-remove-etm_opt-v1-1-03c662380361@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-james-perf-remove-etm_opt-v1-1-03c662380361@linaro.org>

On Fri, Mar 06, 2026 at 11:24:45AM +0000, Coresight ML wrote:

[...]

> -static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
> +static void cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm,
> +					    u64 *metadata)

nitpick: here it can avoid a new argument "metadata", directly retrieve
from etm->metadata[0].  Otherwise, LGTM.
