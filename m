Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2DA498902;
	Fri,  2 Oct 2026 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956936; cv=none; b=ZkgGRFJvgYCx2PWZKYpu+6zA/iQOnHVb/3q7C04GvWbnyHfjd6IKXTssP1IZB7SFPeF/1V3P0dMDmfgYRGWlaWlzDYesdtrkKHy/aAk9C5gp7uZbbc+/YN7mxGX/NAcGxyPs1tFUbUriND31xuuHzWFjX144qDdpaZNvHz1Zewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956936; c=relaxed/simple;
	bh=8Sw75o9tjJqXSbACg19RtCfDI4XgP8f98T4pnm4S+Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8MX4aBjjt5akTsmgg9DHe9bHpRWEdf0QpBmKujdNNuId4jy3lEzEvKcYz8LwR3HgrJN8VXyg2HlcF0sBnMDK9pn2lMVdKLIzDsLguO9gno9sNf32j03haXVuHbG6c+fCCVwyQr4fmtbDoTpFbGtr4mgxpfIOh4Hz2fX/PVmA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vj/w1WQZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vj/w1WQZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 231822F;
	Fri,  2 Oct 2026 09:02:11 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24F2D3F85F;
	Fri,  2 Oct 2026 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790956934; bh=8Sw75o9tjJqXSbACg19RtCfDI4XgP8f98T4pnm4S+Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vj/w1WQZqhgkpRO8yRUNIPc/4HtLMagHMOlBiSw8k6qtwepsg8g5VnxAl1zMQn4aa
	 40oA/9bv7zhJxOpqplsJf83xqFXbg4wrXArgg2MEr4yA+ihsxcxfjvmYs1p5VhB/g7
	 Jj4Sxaty2UAUFrtegTmeMVeLC/KeBo2G4n3YsjFY=
Date: Fri, 2 Oct 2026 17:02:12 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] perf: cs-etm: Don't add global v0 HW_IDs to
 unformatted queues
Message-ID: <20261002160212.GF1208404@e132581.arm.com>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <20261002-james-cs-hw_id-output-failure-v3-1-1d8b6ef339c8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-1-1d8b6ef339c8@linaro.org>

On Fri, Oct 02, 2026 at 12:15:11PM +0100, James Clark wrote:
> In the case of mixed formatted and unformatted trace with v0 HW_IDs, or
> no HW_IDs at all resulting in the cs_etm__map_trace_ids_metadata()
> fallback, formatted queues will write their HW_IDs to unformatted
> queues. This will result in an assert because of multiple decoders on an
> unformatted queue.
> 
> Fix it by not inserting trace ID nodes on other unformatted queues. This
> isn't an issue for v0.1 HW_IDs because they aren't global so will only
> add to their own queue.
> 
> Fixes: 19c3e4db38c5 ("perf: cs-etm: Create decoders based on the trace ID mappings")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
