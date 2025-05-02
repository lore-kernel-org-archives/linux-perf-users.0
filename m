Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4F1D54D8;
	Fri,  2 May 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746209572; cv=none; b=BHVlYhoRE44eRjmdxY+btRrKKGL6blxcUIIgsf90GuWGl/OwRNTgVNBef98ka1ACegHJ/iB8343Er1j9a33tA+zzlqaCLrRMQ/4KCMMwUQyYc3GpKXwH7Q6buTxKVZ2eW8DGrVBRK44SOcViOYnLigtK7ugYp+tFlBN+WguTOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746209572; c=relaxed/simple;
	bh=bPeDXBz2uBUUjye8DAfNaDDNnGdqoUDOEmhPQOwIVSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvAwLrLEQCUqDJXKTyTM528moqaFIyeihhXywgNSjBmSQkjZgZ69u9K6ksfUKmUPHwF1teV6QjMozRghHZsi0DAtU35wjWImJhQWzufYn2zUtjW4JB+qY22eXZ164OY5FTPXOsnCYCl9mZ+6v7FQSnj+uH2kVyZ6URSsSiOhAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8jTWV8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8jTWV8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04592C4CEE4;
	Fri,  2 May 2025 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746209571;
	bh=bPeDXBz2uBUUjye8DAfNaDDNnGdqoUDOEmhPQOwIVSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8jTWV8T5PUKNuX7o32tMuuYIhKxp12+m12o+BqIbbRn4Li9/FehOockw4FrM7uFV
	 mg7S1Y0a0cUtvvOyGbIwJeGGKJT+jUiPVpqloRQqHqUiwuVPQZL8+agg0U9VJF84VR
	 UKbwLYpng5d6MCP1kIzHPQRqps26kEL5ybhG0hJYDbkduCjZ8Mq1W4ozKcRP69F+b2
	 GuPjvjmDFKi5x64Iju3VV+BgAQwglY4BL+dQR8UOYt9l9KRK5RvjelBqNkJc3mp+i9
	 JxjbsAt2wtcucJU9tiD1VWGdtl8W7H1sG7C7pMp3mQJENAxJYwfR317Iz7TErI9P2J
	 pvylqyVKzJGqA==
Date: Fri, 2 May 2025 11:12:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf hist: Remove output field from sort-list properly
Message-ID: <aBULIc_DhfnY33dZ@google.com>
References: <20250430180321.736939-1-namhyung@kernel.org>
 <aBTqq3-splDRYxO5@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBTqq3-splDRYxO5@x1>

Hi Arnaldo,

On Fri, May 02, 2025 at 12:54:19PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 30, 2025 at 11:03:21AM -0700, Namhyung Kim wrote:
> > When it removes an output format for cancelled children or latency, it
> > should delete itself from the sort list as well.  Otherwise assertion
> > in fmt_free() will fire.
> > 
> >   $ perf report -H --stdio
> >   perf: ui/hist.c:603: fmt_free: Assertion `!(!list_empty(&fmt->sort_list))' failed.
> >   Aborted (core dumped)
> > 
> > Also convert to perf_hpp__column_unregister() for the same open codes.
> > 
> > Fixes: dbd11b6bdab12f60 ("perf hist: Remove formats in hierarchy when cancel children")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Tested and added the following patch just before this one.
> 
> Please check.
> 
> Thanks, applied to perf-tools-next.

Thanks!

> 
> - Arnaldo
> 
> From 0184752e038f00ea2ccdc4ef4fdb6713ef2a328e Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Fri, 2 May 2025 12:48:28 -0300
> Subject: [PATCH 1/2] perf test perf-report-hierarchy: Add new test
> 
> Super simple test to check that at least we're not segfaulting when
> trying to use 'perf report --hierarchy', more subtests should be added
> to make sure the output is the expected one.

Thanks for doing this.  We have a test suite for perf report and there's
a test for the --hierarchy option already.  But I'm afrail it didn't
check if the command crashed.  I'm fine with adding this separately and
maybe I can add more tests later.

Thanks,
Namhyung

> 
> This is being merged right before a fix for that that this test detects:
> 
>   # perf test hierarchy
>    83: perf report --hierarchy                                         : FAILED!
>   # perf test -v hierarchy
>   --- start ---
>   test child forked, pid 102242
>   perf report --hierarchy
>   Linux
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.025 MB /tmp/perf-test-report.HX0N85TlPq/perf-report-hierarchy-perf.data (6 samples) ]
>   perf: ui/hist.c:603: fmt_free: Assertion `!(!list_empty(&fmt->sort_list))' failed.
>   /home/acme/libexec/perf-core/tests/shell/perf-report-hierarchy.sh: line 34: 102250 Aborted                 (core dumped) perf report --hierarchy > /dev/null
>   --- Cleaning up ---
>   ---- end(-1) ----
>    83: perf report --hierarchy                                         : FAILED!
>   #
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/20250430180321.736939-1-namhyung@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  .../perf/tests/shell/perf-report-hierarchy.sh | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100755 tools/perf/tests/shell/perf-report-hierarchy.sh
> 
> diff --git a/tools/perf/tests/shell/perf-report-hierarchy.sh b/tools/perf/tests/shell/perf-report-hierarchy.sh
> new file mode 100755
> index 0000000000000000..a9cc1edae36ba003
> --- /dev/null
> +++ b/tools/perf/tests/shell/perf-report-hierarchy.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +# perf report --hierarchy
> +# SPDX-License-Identifier: GPL-2.0
> +# Arnaldo Carvalho de Melo <acme@redhat.com> 
> +
> +set -e
> +
> +temp_dir=$(mktemp -d /tmp/perf-test-report.XXXXXXXXXX)
> +
> +perfdatafile="${temp_dir}/perf.data"
> +
> +err=0
> +
> +cleanup()
> +{
> +	trap - EXIT TERM INT
> +	sane=$(echo "${temp_dir}" | cut -b 1-21)
> +	if [ "${sane}" = "/tmp/perf-test-report" ] ; then
> +		echo "--- Cleaning up ---"
> +		rm -rf "${temp_dir:?}/"*
> +		rmdir "${temp_dir}"
> +	fi
> +}
> +
> +trap_cleanup()
> +{
> +	cleanup
> +	exit 1
> +}
> +
> +trap trap_cleanup EXIT TERM INT
> +
> +test_report_hierarchy()
> +{
> +	echo "perf report --hierarchy"
> +
> +	perf_data="${temp_dir}/perf-report-hierarchy-perf.data"
> +	perf record -o "${perf_data}" uname
> +	perf report --hierarchy > /dev/null
> +	echo "perf report --hierarchy test [Success]"
> +}
> +
> +test_report_hierarchy
> +
> +cleanup
> +
> +exit $err
> -- 
> 2.49.0
> 
