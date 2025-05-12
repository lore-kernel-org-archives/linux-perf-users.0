Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB91245022;
	Mon, 12 May 2025 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072297; cv=none; b=MwcarUy2Ze8yhvyiHuxTTEDrUYk2b6p2D8Xo3QbSPKh+qsDrqKTAraG9+rI3ydKXXraqXDzhHMMoLSNSD8v6MoVmLsdIB0ShPYN4SNj3MzouCnD2SiHzDBjMbTqSBTJ9pROHqyiW+JlLIQtct2Ee5lJRPOIg4ozWVIpN0iOSjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072297; c=relaxed/simple;
	bh=nsQDG1JcQ5amYajbq7Hsmujpg7BCALH6xd/P+umfcgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC7lyJWgdJCnRb3cVM/lNfNZnJ2oWsFB3SsktGlOGYOwm504xCdCCRb3q8Gb1DpOST/loXKsEtD9b4ft8GX9K+OZH1My+ezWgimNDHrG45BPyghi5dvhmWtUlT0sg7PrGznX10wP8c4QktA+iSCBdekgMVSHNmoFWXwiZ1dgcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btgB4YDP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btgB4YDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D4BC4CEE7;
	Mon, 12 May 2025 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747072296;
	bh=nsQDG1JcQ5amYajbq7Hsmujpg7BCALH6xd/P+umfcgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btgB4YDPs8Z6d7ZDPwdIkYoruJhFcv6L/893Y0UDZf0xDGmvYLnY1SlKwE8Zx+CLg
	 /Mgg/ynnM6Y4ctYtoiBOTgMcvklaS3iDk4g+K8ADFg88MAtGRk4V6yx1XTDJva67cv
	 Ao9nmy6HJV2EmMp5VaWnAEha+7zE4zWtYYb7wdAZuHdOXtSB7f6o2pdE6fiLomJI+3
	 ZsRasjVhum5RxAsYifN0Md8R4yHCkVi81XBztwqlPrE59xcAeEZk4UA7rwN1/8V0hC
	 c4esgacDz/9HXiZj+P90PKmib7Q8VjFB9021U7UMiUnOJtoQVBJOyGwFxh5xQ/4o3t
	 JwPAXCAEeJmXw==
Date: Mon, 12 May 2025 14:51:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, howardchu95@gmail.com,
	yeoreum.yun@arm.com, linux@treblig.org, james.clark@linaro.org,
	ak@linux.intel.com, weilin.wang@intel.com, asmadeus@codewreck.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf evlist: Make uniquifying counter names
 consistent
Message-ID: <aCI1JRjBBINe0set@x1>
References: <20250327225651.642965-1-ctshao@google.com>
 <20250327225651.642965-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250327225651.642965-2-ctshao@google.com>

On Thu, Mar 27, 2025 at 03:48:16PM -0700, Chun-Tse Shao wrote:
> From: Ian Rogers <irogers@google.com>
> 
> perf stat has different uniquification logic to perf record and perf
> top. In the case of perf record and perf top all hybrid event
> names are uniquified. Perf stat is more disciplined respecting
> name config terms, libpfm4 events, etc. Perf stat will uniquify
> hybrid events and the non-core PMU cases shouldn't apply to perf
> record or perf top. For consistency, remove the uniquification for
> perf record and perf top and reuse the perf stat uniquification,
> making the code more globally visible for this.
> 
> Fix the detection of cross-PMU for disabling uniquify by correctly
> setting last_pmu. When setting uniquify on an evsel, make sure the
> PMUs between the 2 considered events differ otherwise the uniquify
> isn't adding value.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Chun-Tse Shao <ctshao@google.com>

Can you please refresh this series?

Total patches: 3
---
Cover: ./v2_20250327_ctshao_fix_incorrect_counts_when_count_the_same_uncore_event_multiple_times.cover
 Link: https://lore.kernel.org/r/20250327225651.642965-1-ctshao@google.com
 Base: not specified
       git am ./v2_20250327_ctshao_fix_incorrect_counts_when_count_the_same_uncore_event_multiple_times.mbx
⬢ [acme@toolbx perf-tools-next]$        git am ./v2_20250327_ctshao_fix_incorrect_counts_when_count_the_same_uncore_event_multiple_times.mbx
Applying: perf evlist: Make uniquifying counter names consistent
error: patch failed: tools/perf/util/evlist.h:19
error: tools/perf/util/evlist.h: patch does not apply
Patch failed at 0001 perf evlist: Make uniquifying counter names consistent
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next]$ git am --abort
⬢ [acme@toolbx perf-tools-next]$ patch -p1 < ./v2_20250327_ctshao_fix_incorrect_counts_when_count_the_same_uncore_event_multiple_times.mbx
patching file tools/perf/builtin-record.c
Hunk #2 succeeded at 2485 (offset 1 line).
patching file tools/perf/builtin-top.c
patching file tools/perf/util/evlist.c
Hunk #1 succeeded at 2565 (offset 13 lines).
patching file tools/perf/util/evlist.h
Hunk #1 succeeded at 19 with fuzz 2.
Hunk #2 succeeded at 435 with fuzz 1 (offset 1 line).
patching file tools/perf/util/evsel.c
Hunk #1 succeeded at 3954 (offset 15 lines).
patching file tools/perf/util/evsel.h
Hunk #2 succeeded at 549 (offset 6 lines).
patching file tools/perf/util/stat-display.c
Hunk #1 succeeded at 915 (offset -14 lines).
Hunk #2 succeeded at 1005 (offset -9 lines).
Hunk #3 succeeded at 1579 (offset -14 lines).
Hunk #4 succeeded at 1590 (offset -14 lines).
patching file tools/perf/util/evsel.c
Hunk #2 succeeded at 3964 (offset 15 lines).
Hunk #3 succeeded at 3992 (offset 15 lines).
patching file tools/perf/util/evsel.h
patching file tools/perf/util/parse-events.c
Hunk #1 FAILED at 228.
Hunk #2 FAILED at 262.
Hunk #3 succeeded at 318 (offset 31 lines).
Hunk #4 succeeded at 329 (offset 31 lines).
Hunk #5 succeeded at 454 (offset 31 lines).
Hunk #6 FAILED at 433.
Hunk #7 FAILED at 449.
Hunk #8 FAILED at 480.
Hunk #9 succeeded at 1387 (offset 52 lines).
Hunk #10 FAILED at 1363.
Hunk #11 succeeded at 1435 (offset 54 lines).
Hunk #12 succeeded at 1446 (offset 54 lines).
Hunk #13 succeeded at 1478 (offset 54 lines).
Hunk #14 succeeded at 1515 (offset 55 lines).
Hunk #15 FAILED at 1530.
Hunk #16 succeeded at 1623 (offset 60 lines).
Hunk #17 succeeded at 1656 (offset 60 lines).
Hunk #18 succeeded at 1672 (offset 60 lines).
Hunk #19 succeeded at 1709 (offset 60 lines).
Hunk #20 succeeded at 1720 (offset 60 lines).
Hunk #21 succeeded at 1737 (offset 60 lines).
7 out of 21 hunks FAILED -- saving rejects to file tools/perf/util/parse-events.c.rej
patching file tools/perf/util/stat-display.c
Hunk #1 succeeded at 1002 (offset -9 lines).
patching file tools/perf/util/stat.c
patching file tools/perf/tests/shell/stat+event_uniquifying.sh
⬢ [acme@toolbx perf-tools-next]$ 


