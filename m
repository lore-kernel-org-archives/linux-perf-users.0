Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C8B3A8749;
	Fri,  2 Oct 2026 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961767; cv=none; b=Yizn5jGSqC0oNZh4A8MLyiIIHgBp1M78SUcXnpU2bVNm+YrMlEqu1+UhEsx/ktsbvkrWUFLTb8e1Zm+RlaMEmD1PAPqOJKj6wJ24FsNarPo9ceh1UrD/ITgy9oGpmU4qdpa+S1RqhTsarGyGxt8wIZQ7DHEy/FCiUbjRRVYS7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961767; c=relaxed/simple;
	bh=r1bFA/wmy6Ap4hGtjh0xolrIUAwgjGIPa6hz30QI12A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6ihqulV7gFUzceoyHrgz4k1pBgQWxlb93QhgVR91dYiJu6R3qTInSF21mpoSnHDp44m2yMrI39+Sv/XWFy71sL0w7XUfjGGYNTPU9tEodnMP5l2AhQKDdUMEujIcHL23bpPEpRl5RlT1GInAgx/yno50+GYNv4NZdHKv0D2lLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZiW3um5N; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZiW3um5N"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14B262F;
	Fri,  2 Oct 2026 10:22:41 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16DF23F85F;
	Fri,  2 Oct 2026 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790961764; bh=r1bFA/wmy6Ap4hGtjh0xolrIUAwgjGIPa6hz30QI12A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiW3um5Ng6FQCYYSC2M090W3ZquSMnCMTaaO3cxrjvV9LpXa29iUPU7Vkhv5eyEbX
	 dIbjyZnL+E+1WMXfIYibOTOGvY6W89eKA4IP998ebbZea1oa48cIEpq++5pZ+5Itik
	 nbdmFyyGITvGX4oQRXBuKqUIxPZG46+CTbCl4T7o=
Date: Fri, 2 Oct 2026 18:22:42 +0100
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
Subject: Re: [PATCH v3 4/4] perf: cs-etm: Respect --no-itrace option
Message-ID: <20261002172242.GH1208404@e132581.arm.com>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <20261002-james-cs-hw_id-output-failure-v3-4-1d8b6ef339c8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-4-1d8b6ef339c8@linaro.org>

On Fri, Oct 02, 2026 at 12:15:14PM +0100, James Clark wrote:
> If there is a bug in decoding then Perf will exit early and you can't
> investigate by using the raw dump mode. Make the --no-itrace option stop
> Coresight decoding after printing the aux header so decode errors don't
> stop the rest of the samples being printed.
> 
> pmu_type and evsel_is_auxtrace need to be set so that the
> unleader_auxtrace() behavior is the same as without --no-itrace.
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
