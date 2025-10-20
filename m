Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907C2FA0E9;
	Mon, 20 Oct 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978322; cv=none; b=ICo6CjdHzWf/Pe0ScRscSeEk9d6UmnT0LNLV5Pnlg7tQNlBiCdsfOWvM/LMzSZ9kJuQBQ1NHF7jsPcR1inhzff6eQvOxkEK8VhgaP3RgK73+T9KJk1ir9jZfhiYm0ab7jDNCbLqE0N5f6CWuXaD0lgSYzYn6cENbmI0A3fo2mLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978322; c=relaxed/simple;
	bh=0+14mm1yJ78GH/V3LahL7L1yuljvywo6YBHye7ykRqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTgkaYwNjbDx7BtZN8wOx58TNjNTsJtmN8XZcOswPTiy9+vyff3dOcSDp85FvlxYCtnuZbV48ZTxbmoISLmduKGcKWYnhxtkuLJyS/kjlbpWKOUIDziVVZy7JDLf56SLc23kqkPmS2iWUxeeJVH8JJxYiapGkgtdgBF/I9NmDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247AD2B;
	Mon, 20 Oct 2025 09:38:30 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 976843F63F;
	Mon, 20 Oct 2025 09:38:37 -0700 (PDT)
Date: Mon, 20 Oct 2025 17:38:35 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf jevents: Fix build when there are other json
 files in the tree
Message-ID: <20251020163835.GI281971@e132581.arm.com>
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
 <20251020-james-perf-fix-json-find-v1-1-627b938ccf0d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-james-perf-fix-json-find-v1-1-627b938ccf0d@linaro.org>

On Mon, Oct 20, 2025 at 05:08:26PM +0100, James Clark wrote:
> The unquoted glob *.json will expand to a real file if, for example,
> there is any file in the Perf source ending in .json. This can happen
> when using tools like Bear and clangd which generate a
> compile_commands.json file. With the glob already expanded by the shell,
> the find command will fail to wildcard any real json events files.
> 
> Fix it by wrapping the star in quotes so it's passed to find rather than
> the shell.
> 
> This fixes the following build error (most of the diff output omitted):
> 
>   $ make V=1 -C tools/perf O=/tmp/perf_build_with_json
> 
>   TEST    /tmp/perf_build_with_json/pmu-events/empty-pmu-events.log
>   ...
>    /* offset=121053 */ "node-access\000legacy cache\000Local memory read accesses\000legacy-cache-config=6\000\00010\000\000\000\000\000"
>    /* offset=121135 */ "node-misses\000legacy cache\000Local memory read misses\000legacy-cache-config=0x10006\000\00010\000\000\000\000\000"
>    /* offset=121221 */ "node-miss\000legacy cache\000Local memory read misses\000legacy-cache-config=0x10006\000\00010\000\000\000\000\000"
>   ...
>   -       {
>                   .event_table = { 0, 0 },
>                   .metric_table = { 0, 0 },
>           },
>   make[3]: *** [pmu-events/Build:54: /tmp/perf_build_with_json/pmu-events/empty-pmu-events.log] Error 1
> 
> Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
> Signed-off-by: James Clark <james.clark@linaro.org>

Searched a bit, if without quotes, the wildcard will be expanded by make
but not by shell.  It makes sense for me to fix it with quotes.

Reviewed-by: Leo Yan <leo.yan@arm.com>
