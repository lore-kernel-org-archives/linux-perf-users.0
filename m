Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452633998;
	Mon, 14 Sep 2026 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348800; cv=none; b=WZXW74ZpoSQUNjM6TtbqkqXG5/zZgzot6HfXBMfCewDJrEUn/HJkCHz/KZKveZBGMiKXLTDtuA5o6tUjdliMRapedrZj+OFRVhjC0Lijzim95emfbe7gRotS3+3EjqvecRdBCIBJIq5rWDWaEKaVOnrEW85w8FrZraosEbL03ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348800; c=relaxed/simple;
	bh=h4HLfCBw39k1uGmhOKkOXmoE6EGjSt6l1D7LdjE/jQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn2wcbzATfSSksUeMMBgQr2IrgXlpEGbkyWcoZq5QMj9F59cHUtl8bumPthQHvYY7RBDAe9o4CDWoqc8zE2d7SiLuxwG2dTdb9PKS7Byn46K4CIiRyTn/fdmXnD0vrJCRWI98nL6fD8sbytNaTcnXFFs7H0MJKBaQk7891kYh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5xmT6Qq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5xmT6Qq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014D61F000FF;
	Mon, 14 Sep 2026 01:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789348799;
	bh=3vwp8PKIBw+VorumMc9FZECvD/JGRt4vd/qp1AZfAVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S5xmT6Qq/l9OwPCcUV5dIl1E4T0Mf/jo3XTyh0QLMInhoJyJZInVoujWJgGX5baiY
	 uXOLd/mSHMbnhgVqcobC7K+RLNBdeOQgs4/cYutijk+erJp55bmgc9Zkp7C3wGve94
	 9s0jm35xUhz68CvLKjvvjDZczWLbNx0DrrONJcCRKV7eCZO4l/BZ+kjhUrwWAjaSck
	 JBSDpH+YMDQhgAaG7B/eLGnzitEV/WjWgfAzfJEqGJ3crtJBMy/0pE8U1Blvi6D4I7
	 3Ji0YNrwT85aVy9d0dahqE4xCdQ4afQ8ZtBglhSUWxboBcOrZw1kyuvZQzDq4CUTPF
	 E2z6mcxUusUrg==
Date: Sun, 13 Sep 2026 18:19:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Hui Su <sh_def@163.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf thread_map: Deduplicate numerically equivalent
 PID and TID strings
Message-ID: <aqdLvZJykgu94WnV@google.com>
References: <20260912031112.1814574-2-sh_def@163.com>
 <20260912051747.2215776-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912051747.2215776-1-sh_def@163.com>

On Sat, Sep 12, 2026 at 02:17:47PM +0900, Hui Su wrote:
> thread_map__new_by_pid_str() and thread_map__new_by_tid_str() attempt
> to deduplicate adjacent PIDs/TIDs using prev_pid and prev_tid.
> However, prev_pid and prev_tid were never updated inside the loop,
> making the check "if (pid == prev_pid)" dead code.
> 
> Furthermore, even if prev_pid/prev_tid were updated, strlist sorts
> lexicographically (e.g. "010", "011", "10"), which means identical
> numeric values with different string representations (e.g. leading
> zeros) are not adjacent in the list and would never be deduplicated.
> 
> Before this fix, the new tests fail at the first duplicate TID case:
> 
>   $ perf test -v 35
>   35: Thread map                                                      :
>   --- start ---
>   test child forked, pid 363297
>   FAILED tests/thread-map.c:63 wrong nr for duplicate TIDs
>     (nr=3, expected 1)
>   test child finished with -1
>   ---- end ----
>   Thread map: FAILED!
> 
> Replace the ineffective prev_pid/prev_tid check with an intlist seen-set.
> This ensures that any numeric duplicate PID or TID is properly
> recognized and skipped, regardless of string formatting or order.
> 
> Add tests for numerically equivalent PID and TID strings.
> 
> After this fix:
> 
>   $ perf test -v 35
>   35: Thread map                                                      :
>   --- start ---
>   test child forked, pid 363650
>   test child finished with 0
>   ---- end ----
>   Thread map: Ok
> 
> Fixes: b52956c961be ("perf tools: Allow multiple threads or processes in record, stat, top")
> Signed-off-by: Hui Su <sh_def@163.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> Differences in v2:
>  - Explicitly include <stdio.h> in tools/perf/tests/thread-map.c for snprintf.
>  - Link to v1: https://lore.kernel.org/r/20260912031112.1814574-2-sh_def@163.com/
> 
>  tools/perf/tests/thread-map.c | 34 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/thread_map.c  | 28 ++++++++++++++++++++--------
>  2 files changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
> index 877868107455..690ccae17c31 100644
> --- a/tools/perf/tests/thread-map.c
> +++ b/tools/perf/tests/thread-map.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/types.h>
> @@ -56,6 +57,39 @@ static int test__thread_map(struct test_suite *test __maybe_unused, int subtest
>  	TEST_ASSERT_VAL("wrong refcnt",
>  			refcount_read(&map->refcnt) == 1);
>  	perf_thread_map__put(map);
> +
> +	/* test numeric deduplication of TIDs */
> +	map = thread_map__new_by_tid_str("123,0123,00123");
> +	TEST_ASSERT_VAL("failed to alloc map", map);
> +	TEST_ASSERT_VAL("wrong nr for duplicate TIDs", map->nr == 1);
> +	TEST_ASSERT_VAL("wrong pid", perf_thread_map__pid(map, 0) == 123);
> +	perf_thread_map__put(map);
> +
> +	/* test non-adjacent numeric duplicates (strlist lexicographic: 010, 011, 10) */
> +	map = thread_map__new_by_tid_str("010,011,10");
> +	TEST_ASSERT_VAL("failed to alloc map", map);
> +	TEST_ASSERT_VAL("wrong nr for non-adjacent duplicate TIDs", map->nr == 2);
> +	perf_thread_map__put(map);
> +
> +	/* test numeric deduplication of PIDs */
> +	{
> +		struct perf_thread_map *base, *dup;
> +		char pid_str[64];
> +
> +		base = thread_map__new_by_pid(getpid());
> +		TEST_ASSERT_VAL("failed to alloc baseline map", base);
> +
> +		snprintf(pid_str, sizeof(pid_str), "%d,0%d", getpid(), getpid());
> +
> +		dup = thread_map__new_str(pid_str, NULL, false);
> +		TEST_ASSERT_VAL("failed to alloc duplicate pid map", dup);
> +		TEST_ASSERT_VAL("wrong nr for duplicate PIDs",
> +				dup->nr == base->nr);
> +
> +		perf_thread_map__put(dup);
> +		perf_thread_map__put(base);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
> index 48c70f149e92..7b59b3f7f2e4 100644
> --- a/tools/perf/util/thread_map.c
> +++ b/tools/perf/util/thread_map.c
> @@ -10,6 +10,7 @@
>  #include <unistd.h>
>  #include "string2.h"
>  #include "strlist.h"
> +#include "intlist.h"
>  #include <string.h>
>  #include <api/fs/fs.h>
>  #include <linux/string.h>
> @@ -163,12 +164,13 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
>  	int items, total_tasks = 0;
>  	struct dirent **namelist = NULL;
>  	int i, j = 0;
> -	pid_t pid, prev_pid = INT_MAX;
> +	pid_t pid;
>  	struct str_node *pos;
>  	struct strlist *slist = strlist__new(pid_str, NULL);
> +	struct intlist *seen = intlist__new(NULL);
>  
> -	if (!slist)
> -		return NULL;
> +	if (!slist || !seen)
> +		goto out;
>  
>  	strlist__for_each_entry(pos, slist) {
>  		pid = strtol(pos->s, NULL, 10);
> @@ -176,9 +178,12 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
>  		if (pid == INT_MIN || pid == INT_MAX)
>  			goto out_free_threads;
>  
> -		if (pid == prev_pid)
> +		if (intlist__has_entry(seen, (unsigned long)pid))
>  			continue;
>  
> +		if (intlist__add(seen, (unsigned long)pid))
> +			goto out_free_threads;
> +
>  		sprintf(name, "/proc/%d/task", pid);
>  		items = scandir(name, &namelist, filter, NULL);
>  		if (items <= 0)
> @@ -200,6 +205,7 @@ static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
>  	}
>  
>  out:
> +	intlist__delete(seen);
>  	strlist__delete(slist);
>  	if (threads)
>  		refcount_set(&threads->refcnt, 1);
> @@ -219,17 +225,19 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
>  {
>  	struct perf_thread_map *threads = NULL, *nt;
>  	int ntasks = 0;
> -	pid_t tid, prev_tid = INT_MAX;
> +	pid_t tid;
>  	struct str_node *pos;
>  	struct strlist *slist;
> +	struct intlist *seen;
>  
>  	/* perf-stat expects threads to be generated even if tid not given */
>  	if (!tid_str)
>  		return perf_thread_map__new_dummy();
>  
>  	slist = strlist__new(tid_str, NULL);
> -	if (!slist)
> -		return NULL;
> +	seen = intlist__new(NULL);
> +	if (!slist || !seen)
> +		goto out;
>  
>  	strlist__for_each_entry(pos, slist) {
>  		tid = strtol(pos->s, NULL, 10);
> @@ -237,9 +245,12 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
>  		if (tid == INT_MIN || tid == INT_MAX)
>  			goto out_free_threads;
>  
> -		if (tid == prev_tid)
> +		if (intlist__has_entry(seen, (unsigned long)tid))
>  			continue;
>  
> +		if (intlist__add(seen, (unsigned long)tid))
> +			goto out_free_threads;
> +
>  		ntasks++;
>  		nt = perf_thread_map__realloc(threads, ntasks);
>  
> @@ -251,6 +262,7 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
>  		threads->nr = ntasks;
>  	}
>  out:
> +	intlist__delete(seen);
>  	strlist__delete(slist);
>  	if (threads)
>  		refcount_set(&threads->refcnt, 1);
> -- 
> 2.55.0
> 
