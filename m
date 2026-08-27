Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609DC47A0D7;
	Thu, 27 Aug 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840842; cv=none; b=iuyZW3n4jbQ40uL4DOorwIcmwhS1iInqTtZ8N1m2XuqpE57LZ4NKRDWHR0DBGP0/j7ifY+c2AFc+ZpK4ea2K8zgdDoPV+LrRvXHK5HekExf/05fA2oPK0tqbVbL8njst6RmtyF86pzmT/ai4TqFu9ol66lgf42jHZnzrehxpI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840842; c=relaxed/simple;
	bh=r0ySLqPyuNENyTpsvEaGFphpnJIcH3tX6bc1QHr9jqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exfOroNXRZSQ1hEH3stUTk3tscAfJvZVMYNjfW25VfplgksqapX+spZW91o+T00LI4BzM1R4uA04zczAvRPPeXfKHQlsSP87dAZsXirpo48pGJpQRglZSn54E5jqFJv/tHHinq1TVat+FNg7vEZ2Dolc2Wmk3ESW8GJAHVsHKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IeV45dqg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IeV45dqg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77BF71691;
	Thu, 27 Aug 2026 07:27:12 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F32CB3F7D8;
	Thu, 27 Aug 2026 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787840836; bh=r0ySLqPyuNENyTpsvEaGFphpnJIcH3tX6bc1QHr9jqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeV45dqgx4mRaxoEbmuZZLi7m359mdGCaHjEZzT8ye+3dWAGoS8D9re32lynaa88z
	 JeSfSWhc2s3EO8J3VgE/iJvR6Od4/WQWFvSAn5IM61hKHm5org2eLQ1hd31ZLY6VFx
	 qy4wuTAMTjSNYGKKfU4BMKZpRvEeF5DPdPO/fCsU=
Date: Thu, 27 Aug 2026 15:27:14 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 05/14] perf cs-etm: Increase default timestamp
 generation period
Message-ID: <20260827142714.GM8904@e132581.arm.com>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-5-00c4fd0701b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-5-00c4fd0701b4@linaro.org>

On Fri, Aug 21, 2026 at 10:49:03AM +0100, James Clark wrote:
> The original purpose of timestamps in per-CPU mode was to roughly emit
> samples in the order they occurred across multiple CPUs, rather than
> emit all the trace from CPU 1 followed by all from CPU 2 etc.
> Previously there was no way to change the interval from the minimum of 1
> cycle, but custom intervals are now supported by the driver.
> 
> Drastically reduce the number of timestamps emitted by increasing the
> interval, which is more than enough to interleave sample generation.
> This reduces the size of the trace generated.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
