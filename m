Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791735;
	b=0UHha5kiE9DzcG6w5VIJyZ6K4JLqLDoaZ0aBOQk8bNfscnfWxVaK84NMqL7OtMLACk4M
	 21gQ3AxOeRYW5jLYfEggCvIFECJpygFq+cJJVpK4x5fji/wGfQm1ZmRkLxml1s8c3XUPS
	 DLnr+xNz8htgalwdubPlyIlH1IAzcrVesXa9yeF42XqGv2y0HinpQR4bO8d5nGIebmg+E
	 4GG6dwe2SNGolw6GQ++bZF3CbXURpyxfB6Gj8auPcQz5hCcfYDc5IQl44VqgzoqHeUTd2
	 YQfzOnOYuZ9AbiotBRNoqCYO+ucxfs70xs7RPEFEmWzy0MFHuLR5SdzO8XX+UDvD6zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791735;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=MxLmpSnBgRxPOB/GdQE7oxCKuQgL3MVkY0GE3RH9bHw=;
	b=hNdZiMMN0tdLH828w3A7jsd+MWKYSc/Slhsqon1n/T3W9jVArhRk+dTwqYl/pwPC2Py8
	 RmMhVpolDOO+krf5gg2W7MRUykJTIWDEN+GqBQR+ty8VyBqsLDJhKWfH5k7s/SDFcozT1
	 bslkAmLWg+wgMahPOIADfnWQvZXlkGXoWdI9d2bd0kcgsCXuNGrBZwZX4MR6C8tePfAlz
	 j6M4FXjT8jvDst+OX+S2yHGz5QbbLiXX6t9chUCgzAVP9CC8J2Nv8Af/uLWpfyZedWJz2
	 PQ+vFabQmrP0dQ+BuiBQB04U8afgoZpteMN7i+hDrVz/VOYVdwLll2dYRc0FSOKP+rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p6IKKKY3;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4F0606A328;
	Wed,  4 Nov 2026 11:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A4F0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p6IKKKY3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5098A1650;
	Wed,  4 Nov 2026 03:28:51 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106933F632;
	Wed,  4 Nov 2026 03:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793791734; bh=8F49DQh3zZmW52cbnb9k98gGWrQ97cHKSsqybF+5KdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6IKKKY3vgFp5P72N8PTk/+2cJYPO2jRls1vP9+JnlPncEnxA2f/MCqe+dkbAVMyo
	 nywgg0rx5fbpFRChGsMsXOEKJdi/g5d+zfJeJB/bocRh28Jqa7/r4hCIH1ELHh0QWs
	 FaU0msIoZbztuu9hKxfoK3aPcMiyRxD95yMsTno8=
Date: Wed, 4 Nov 2026 11:28:52 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3 03/18] perf cs-etm: Turn on context packet timestamps
 in per-thread mode
Message-ID: <20261104112852.GH9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-3-dbcb0c281b9b@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-3-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:17PM +0000, James Clark wrote:
> Practically this costs nothing and preempts future changes that will be
> made to support decoding trace in order with Perf MMAP and JIT events.
> It also helps keep samples in order when we add support for multiple
> per-thread mode threads in the next commit.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
