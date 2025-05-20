Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F64B1E7B;
	Tue, 20 May 2025 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775846; cv=none; b=haDbMB0xyr1mS995hyei/9tZB6at7pTOK1LQTFExspqfltzxYwI8izkInxGF/1r08UKC37cdSWk2woOWXbIP3Xzty9PYlAZ/3ZXZmnSmxXxKPGslxkxDYYKNBBghvCQI3Udp7UOcIbp0OxBHSDS7p55GGQEBcyBGyTYd2YDJHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775846; c=relaxed/simple;
	bh=bGOiBceGe7MObUDUlUsMayfNL7eXQnRK0q7b1w5/tnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh/LaxdqzJoHJdm1CzEkaoXscFjGw1gAsS1LxfElEylv+ZWka5ivnlgAIVoS/0n8BsNgAyv2KA6pCP6TwbU+aHfQnK2cQ6W1n9nwpEuMH2UhF51bIBHJKKfta0KOoD9oM6YZkFYzMklcKV54BZUI+UFFtRQCYt3b8RDRvzGGV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWd9rPEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWd9rPEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F25C4CEE9;
	Tue, 20 May 2025 21:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747775846;
	bh=bGOiBceGe7MObUDUlUsMayfNL7eXQnRK0q7b1w5/tnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWd9rPExXIpe3JnVKhVXxEFhU4DRim78oTD+tnx4aIrwcRwlr4YCUB42M8bSDOXcg
	 5Dvl8QDft6k5Ilz6QWFoXoX6+JK0SRrUNuX3htev/4A/MMsog0ce1bwsiFomZxecXC
	 2Wr+eYBLjWtkMMQJcUBlt4C63NVmp8fGNjIPV067rSRLx8gritZW/cpJOGLZcPaqV3
	 oBVBX2yLL8QEMM8SCit2yXR3T93e7SqhHkhDwiBthOJ1DVWAHfrQDsYNq2JVK+kljG
	 7LvDh8zIXGDWGUUaJmL9eeRA/RoV0PbE5IraINf5yeoMiEUgAwea5GU7xPF8bN5KUL
	 yJK+gIzrtGf/w==
Date: Tue, 20 May 2025 18:17:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: langfei@huawei.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	James Clark <james.clark@linaro.org>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Howard Chu <howardchu95@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 1/3] perf dso: Minor refactor to allow Wthread-safety
 analysis
Message-ID: <aCzxYS_knO4rokdi@x1>
References: <20250519224645.1810891-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519224645.1810891-1-irogers@google.com>

On Mon, May 19, 2025 at 03:46:43PM -0700, Ian Rogers wrote:
> The pattern:
> ```
> if (x) {
>    lock(...)
> }
> block1;
> if (x) {
>    unlock(...)
> }
> ```
> defeats clang's -Wthread-safety analysis where it complains of locks
> held on one path and not another. Add helper functions for "block1"
> then restructure as:
> ```
> if (x) {
>    lock(...);
>    block1();
>    unlock(...);
> } else {
>    block1();
> }
> ```

Got the three in the tmp.perf-tools-next branch, will try and test it
further and then push it out to perf-tools-next.

Thanks,

- Arnalod
