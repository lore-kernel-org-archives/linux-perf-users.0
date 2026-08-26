Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716C4252B1;
	Wed, 26 Aug 2026 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756517; cv=none; b=HI1AgQsHh5X/CGkSSTAUAvcPOOJ8lvZUuIU4Y2dddmSz12frsxr6AB7K0KB5UX2o8qm1pBSElx/fzYLDiWGmk9orE7nqsvKoECqVtdI7xjmxFuXNv6S9aeDEsY4z5vf9ifqWrYqYgaYgcAk/whR6evgI4OKC28M6Fh4aPF5iN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756517; c=relaxed/simple;
	bh=ephLTZo60aLchZTC8JPArjDYj9cSMJNs4QXwAT0nfNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mew6xnRiFJ038buC+56O2azWBju0hFcJLiU7PKviVJIf26lBSFmuGnLLVUI8/fR9wLw2X/7xn6Jh4JuQua1NSdQx0LDrZxqfFrtuU0E/EVsMIKxHX8JTcUAAZjecmWQ1oIH5TQLC3DjOfLtUKK+UcbPD9RO/cWWzveatfcjEod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ciRmwxR6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ciRmwxR6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C379416F2;
	Wed, 26 Aug 2026 08:01:50 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FA4D3F7D8;
	Wed, 26 Aug 2026 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787756514; bh=ephLTZo60aLchZTC8JPArjDYj9cSMJNs4QXwAT0nfNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciRmwxR6vL9yxxc3rqvSD2GqOFqzd/uI7aq0IG1hiF3ZglJ1qmbnq0zxSpjZ3wMQa
	 m2SSYM6vz5esS/0h7GRlM0pXdnOomYldR6p+iIhZ9rqoZG+ZdYzGOhDM1aquXZMSba
	 Mb5wdUXppYVGufJ0Dz+i8tf2m9oRewaqwSKKZqkw=
Date: Wed, 26 Aug 2026 16:01:52 +0100
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
Subject: Re: [PATCH v2 01/14] perf cs-etm: Fix nVHE per-thread decoding
Message-ID: <20260826150152.GI8904@e132581.arm.com>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-1-00c4fd0701b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-1-00c4fd0701b4@linaro.org>

On Fri, Aug 21, 2026 at 10:48:59AM +0100, James Clark wrote:
> pid_fmt is unset in per-thread mode because we don't need PIDs, so we
> can't use it as a hint to determine which EL the host is running at.
> That results in falling though to the next part where EL1 is treated as
> guest, which is wrong for nVHE.
> 
> Fix it by only returning a guest machine when run from perf kvm where a
> guest image would be provided, which matches existing behavior in other
> parts of Perf.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
