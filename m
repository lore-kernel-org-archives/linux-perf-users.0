Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F240756E;
	Tue, 20 Jan 2026 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908164; cv=none; b=E05UCtQ26Ku+c3EuzeNkXBOrEr/0x6BkBQql42KHrv/YnCR+Ngk15ri9hJu2ocOUpFltwvFmiarirhgq5FGrvGj1FnWfRzhOAv/7a9hbGDF/fjieMnS788gxzWqyomJqStIyPM0hoqA4HD/+Pb4REkV45KLjSVyQ2BlinqmeHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908164; c=relaxed/simple;
	bh=VdPcnXMBduiUmWyZDdDLtnmZ/NACjSBTEbP78UTbF04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foIQLBEexTkFmV9dVzBhmmJLsdZQjlTax2DODyfs1yJgNUzKKffIFJvJRA5xLoa2j2p6TLWh8bf2UwlCe/042KhDxkcru0pm/NVPhgza7CxT6IUJ7/H0b4wyk9MuM3/9ca/UoAuSvUbvqr2NWw0R8W1RFTdu4rfgl72viR8OzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4D751476;
	Tue, 20 Jan 2026 03:22:34 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F175B3F740;
	Tue, 20 Jan 2026 03:22:40 -0800 (PST)
Date: Tue, 20 Jan 2026 11:22:38 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf cs-etm: Test sparse CPU maps
Message-ID: <20260120112238.GH2732125@e132581.arm.com>
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
 <20260119-james-perf-coresight-cpu-map-segfault-v2-2-56b956a629ee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-james-perf-coresight-cpu-map-segfault-v2-2-56b956a629ee@linaro.org>

On Mon, Jan 19, 2026 at 10:18:36AM +0000, Coresight ML wrote:
> We only currently test with default (all CPUs) or --per-thread mode.
> Different permutations of the "-C" option can affect decoding so add
> tests for some of them.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

LGTM and verified on Juno board:

Tested-by: Leo Yan <leo.yan@arm.com>
