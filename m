Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6116EB76;
	Fri, 21 Jun 2024 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014256; cv=none; b=LLmTieHqVgdXwkTnO7Wf4okDJbOrW7zcrA9I0QHOHDMMqCJbTzeF6F8KWwrupvq8zuGKKPycPz12HgkDLpxmWHlmOMmHGUo9orSt8MTRbaOgsdxAcbVUIDK2WRY8FUE2C2LZZCiRNJ/XUlw96z6QJHC8kGZTIZo2dc3sc14hSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014256; c=relaxed/simple;
	bh=dQ56fFgECEl6ZpF2/AeRJC8HqFL85IfaRermg5g+Iqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXJyojETJBb0p2mrwdfM+QW6+58g0YUZCZ+T3ZqIJFxa+Yn8pKPTKWi+7mNQGKrncir+upBKAB/a7Wh/JIwGhTdm6JRX6+ItyVeRHDdNXP3a9cVtQvUxQmYygPTrOyTteyzx33XC2YPwLYORx+yDx2J+yC40D1ZMcL5oLCijQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKDJZJX6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKDJZJX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E715C2BBFC;
	Fri, 21 Jun 2024 23:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719014255;
	bh=dQ56fFgECEl6ZpF2/AeRJC8HqFL85IfaRermg5g+Iqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKDJZJX6gQz1MmmIKErHCQZ7kJP90q0WZ3UcO1m7+D+UY1CdvDzXTxzBkrVC9SLI9
	 uI3k7OnBZ2au7yXhG0/UJJUBkOx/aPEKyw65U8aNifOoUcXEt+uNWSShgKj/P42rJy
	 5vwxl5VNV+Bgau1oM36LwgvSTU3Uwfiv1gDIQyha64rGn53nUKA/mSVynxNjHP1RDN
	 xeaB3ER5UmTvfAiNsCf92/qooPeVd14jq2uj2qqfopb+Y+dfM23t+3JXPL7P96mqhz
	 CtASAWLFyXaND4ZFUxFa8jGZ9qXmEx9/5YlBmRAnXQY3BXEIda42VTvtoA1C5Dgx6j
	 KCZWLQMs/DL+A==
Date: Fri, 21 Jun 2024 16:57:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>, Spoorthy S <spoorts2@in.ibm.com>,
	German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Make test_arm_callgraph_fp.sh more robust
Message-ID: <ZnYTbZ30Vkrzm8xI@google.com>
References: <20240612140316.3006660-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612140316.3006660-1-james.clark@arm.com>

On Wed, Jun 12, 2024 at 03:03:14PM +0100, James Clark wrote:
> The 2 second sleep can cause the test to fail on very slow network file
> systems because Perf ends up being killed before it finishes starting
> up.
> 
> Fix it by making the leafloop workload end after a fixed time like the
> other workloads so there is no need to kill it after 2 seconds.
> 
> Also remove the 1 second start sampling delay because it is similarly
> fragile. Instead, search through all samples for a matching one, rather
> than just checking the first sample and hoping it's in the right place.
> 
> Fixes: cd6382d82752 ("perf test arm64: Test unwinding using fame-pointer (fp) mode")
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  .../perf/tests/shell/test_arm_callgraph_fp.sh | 27 +++++++------------
>  tools/perf/tests/workloads/leafloop.c         | 20 +++++++++++---
>  2 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> index 61898e256616..9caa36130175 100755
> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> @@ -28,28 +28,21 @@ cleanup_files()
>  
>  trap cleanup_files EXIT TERM INT
>  
> -# Add a 1 second delay to skip samples that are not in the leaf() function
>  # shellcheck disable=SC2086
> -perf record -o "$PERF_DATA" --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
> -PID=$!
> +perf record -o "$PERF_DATA" --call-graph fp -e cycles//u --user-callchains -- $TEST_PROGRAM
>  
> -echo " + Recording (PID=$PID)..."
> -sleep 2
> -echo " + Stopping perf-record..."
> -
> -kill $PID
> -wait $PID
> +# Try opening the file so any immediate errors are visible in the log
> +perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4
>  
> -# expected perf-script output:
> +# expected perf-script output if 'leaf' has been inserted correctly:
>  #
> -# program
> +# perf
>  # 	728 leaf
>  # 	753 parent
>  # 	76c leafloop
> -# ...
> +# ... remaining stack to main() ...
>  
> -perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4
> -perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4 | \
> -	awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
> -						       sym[1] != "parent" ||
> -						       sym[2] != "leafloop") exit 1 }'
> +# Each frame is separated by a tab, some spaces and an address
> +SEP="[[:space:]]+ [[:xdigit:]]+"
> +perf script -i "$PERF_DATA" -F comm,ip,sym | tr '\n' ' ' | \
> +	grep -E -q "perf $SEP leaf $SEP parent $SEP leafloop"
> diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
> index 1bf5cc97649b..f7561767e32c 100644
> --- a/tools/perf/tests/workloads/leafloop.c
> +++ b/tools/perf/tests/workloads/leafloop.c
> @@ -1,6 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#include <signal.h>
>  #include <stdlib.h>
>  #include <linux/compiler.h>
> +#include <unistd.h>
>  #include "../tests.h"
>  
>  /* We want to check these symbols in perf script */
> @@ -8,10 +10,16 @@ noinline void leaf(volatile int b);
>  noinline void parent(volatile int b);
>  
>  static volatile int a;
> +static volatile sig_atomic_t done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +	done = 1;
> +}
>  
>  noinline void leaf(volatile int b)
>  {
> -	for (;;)
> +	while (!done)
>  		a += b;
>  }
>  
> @@ -22,12 +30,16 @@ noinline void parent(volatile int b)
>  
>  static int leafloop(int argc, const char **argv)
>  {
> -	int c = 1;
> +	int sec = 1;
>  
>  	if (argc > 0)
> -		c = atoi(argv[0]);
> +		sec = atoi(argv[0]);
> +
> +	signal(SIGINT, sighandler);
> +	signal(SIGALRM, sighandler);
> +	alarm(sec);
>  
> -	parent(c);
> +	parent(sec);
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
