Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877522;
	b=zuT57mtNIlo+7VSR2QW07vw/iBglg0SQUgMA985Nd4+F6lgyUpR+8JpqzAVRHDbbLRTs
	 vU7KF+abjclReSlofh6w+/BerH79k5LSYCHBM5S48BJjiJ6ny0cHB61Qof0oHAHGPCIyJ
	 vqIWLlJEpaxQXmeRweazZszx2A/l9VJN9nKmqrKXI7lChkZx1OWq6Gm9bDyo3oi4V6Tnu
	 VdAgUUzVVTvD672Ynx38Z2AX3wAxpyfSyU3wnxLr278Xk+LE3xqhrSL6BdVhokqL2Jl4y
	 KhXzsEhJFXGLUuc9/o3Xn2dWq8JTWSMj+jYcxnKP+RJXJHcjlOC46oR37Y1d4IE6tFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877522;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wS6H2biKhC0qzhIyM/4fTFh7+N4OkO4FJgSbGJlSZAI=;
	b=4eIsR5BQ630basXe9FHu7GI9x3HVq9I1g99B+5egu0emHZcoiiGJaA3iuvw9V3EgXSl3
	 wMyTDwu45qng9R0C/zNjRH1KHSZkfIArAqw39A74PomWA9kyu1j0hICEYLS5hLsxZiJbu
	 nPXQr+gqSHF62QfkIsyrYRcY3KFq9/32SqBhTSyCTYBaizU5cqHiMu2m2yueKurTIGxS4
	 597zHdxkTD69vO11MBGf8JqW5T1tcZ0daUWgXOX2pwiafflmh/f7d6j4PLPpFPnR1uHB7
	 sfLefyeisZBChpCR9pL6hHvnKNpD1HDbh4L7Aoi6ucNVlyjkt8/KaYVYeLy+vTEAVAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FQ09MN4U;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD10606A328;
	Thu,  5 Nov 2026 11:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AD10606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FQ09MN4U
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D81581595;
	Thu,  5 Nov 2026 03:18:37 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77D653F628;
	Thu,  5 Nov 2026 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793877520; bh=INoWYwUb9zlHuoOC6uc1KGiYOuuaTT9Ct72EHvh4mKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQ09MN4U9LPGNrsATcEp3ppg1naYHDp5jBBBLDalF8G8bR2apa4d1HdSbb756UPTc
	 FwtbG1JZ0+FKRjDfF1evhx7TSQjedTAUwFSWOI6wqxj5e/X9le6hVW9VP738CLKjXq
	 oFcBtrTeJi/lzz1A3N02wizfpwPukxf1R9fGnDTY=
Date: Thu, 5 Nov 2026 11:18:38 +0000
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
Subject: Re: [PATCH v3 00/18] perf cs-etm: Per-thread mode fixes and snapshot
 wrap support
Message-ID: <20261105111838.GS9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
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
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:14PM +0000, James Clark wrote:
> Fix a few issues with per-thread mode:
>   - On nVHE, everything looks like guest trace instead of host
>   - Tracing multiple threads didn't really work

Tested this series:

Tested-by: Leo Yan <leo.yan@arm.com>

> prerequisite-message-id: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>

Make the dependency explicit to help maintainers pick up the patches.

This series depends on:
https://lore.kernel.org/linux-perf-users/20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com/
