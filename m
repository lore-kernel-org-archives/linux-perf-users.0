Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEDCA6F;
	Fri, 12 Sep 2025 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704776; cv=none; b=aewtD3CUqaiGA/S1Le2jYSutALoxdpyDDV6rAwWltbQqSn2tH3CjlSxOnjFdfcBgw1P2Uiu70YbBl2r/QrROPqxW1Hn+xCfqEjgbRpEKnrAOWe6aMsihcB05Zrp4SN2bvl6GyrwTDCelzE2lweqDcOLSfbBaCC1N7EmbI6q1HIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704776; c=relaxed/simple;
	bh=DTRXpsg7G1sB/lC6ddyErAciWB7CXiGkJlZ4gIPEV/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+QZ6ZNvLhd94endEkPee7K+V+XktS4rufQ3892G74hqZKYXlZFCyyMkHq6WWM9T/Po0Zr0nGAidm2jFi4XnQVJdPnLMV8zrIjiX6umilrrFQuCflzMZxIglfhYNxoRrssr5u0w4MSpEZOIuj+5ZL6347u1NTyEcmgjsBsFzzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9XBqpfl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9XBqpfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16E7C4CEF1;
	Fri, 12 Sep 2025 19:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757704775;
	bh=DTRXpsg7G1sB/lC6ddyErAciWB7CXiGkJlZ4gIPEV/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9XBqpfl1P8v09CsrZXfg9nr5B+vnG5wifEMvV4z2ESRFKFsxgjL1GOX4FcJkM+Q0
	 0zNKmCQPwvJZL8A3ak1WHucnCv4JSUGDEOcaX97lOF0iSF777VFu3CDN/WtpeDN0D5
	 +kOtG6BEegr6nDzO0MyRJEdhEerdrLiLxJfzx3pBonyPzu1Gy+TDKWqSeqLiH5Jrjb
	 lsPlofiLGTZV14jEZlnDM3cKaNcmStBVW7q7SjiAWKj+TnLpziXCmHoRlRUBeVtPow
	 CeuN/m7N7bJGMuGGuWRvmqNKof3JARJDdrPW7LsfPTGnUwINL1wEwfBlFoh4pr1Snw
	 tYVStENu6368g==
Date: Fri, 12 Sep 2025 16:19:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Blake Jones <blakejones@google.com>,
	Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] tools: perf: session: avoid segfault on implicit stdin
Message-ID: <aMRyRNjEKoKeRXzY@x1>
References: <20250826001651.299560-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826001651.299560-1-stephen.s.brennan@oracle.com>

On Mon, Aug 25, 2025 at 05:16:48PM -0700, Stephen Brennan wrote:
> A user reported that running a command like:
> 
>     perf script flamegraph -ag -F99 -- sleep 10
> 
> Resulted in a segmentation fault. The reason is twofold. First, the
> "flamegraph-report" script has a shebang line which ends with "--". This
> disables option parsing, so that the exec'd "perf script report" command
> does not see the option "-i -" which is appended to its command line.
> Second, despite the unprocessed "-i -" option, the default behavior of
> perf is to use stdin if it is a pipe -- and in this case, it is. Thus, the
> report continues running, but segfaults on accessing the filename.
> 
> The fix for the second issue is a simple NULL check. Implement this
> here.

I did a test before and after and the problem is indeed present:

root@number:~# perf script flamegraph -ag -F99 -- sleep 1
/home/acme/libexec/perf-core/scripts/python/bin/flamegraph-report: line 3: 362975 Segmentation fault      (core dumped) perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py "$@"
root@number:~# 

But even after your patch, it still segfaults.

I'll try to look at this after processing lower hanging patches.

Thanks for working on this!

- Arnaldo
 
> Fixes: 4553c431e7dd2 ("perf report: Display pregress bar on redirected pipe data")
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  tools/perf/util/session.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 26ae078278cd6..a9624505c0ca3 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1854,9 +1854,11 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>  	/*
>  	 * If it's from a file saving pipe data (by redirection), it would have
>  	 * a file name other than "-".  Then we can get the total size and show
> -	 * the progress.
> +	 * the progress. However, be careful because path may be NULL if input
> +	 * is coming from stdin.
>  	 */
> -	if (strcmp(session->data->path, "-") && session->data->file.size) {
> +	if (session->data->path && strcmp(session->data->path, "-")
> +	    && session->data->file.size) {
>  		ui_progress__init_size(&prog, session->data->file.size,
>  				       "Processing events...");
>  		update_prog = true;
> -- 
> 2.47.3
