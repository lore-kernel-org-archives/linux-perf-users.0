Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267302EC087;
	Wed,  8 Oct 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913035; cv=none; b=tbKv4OewLq9GIv2QZK06sh4IqbnJ3KYbNFzLc60ge3rK7ADWoQiMPqjciRiGBspM3zX0qvJUftE7w907kxm3qaLNoF4zXNCST8LtNT4i9o+wVuz2cA1pgtLiE2qsfppZRok8hVWkxbsOPoajAjhtVNPhPHEa57ER3VayZiB5rsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913035; c=relaxed/simple;
	bh=f3Nb+HgY38YNSFdjvaL6hPWK/70O12LVEeSvZY06YNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8tyes7TGkUNa3Gle7OV/geaOJcRki6dPz+sJHRa7wRuYxG1i7zbupB8jroXJT+73Gv9e7OpXZravEwRxcPHMjwyHiFwUx1UE/usOPDWswaicOcFY3Tt77lrNUWi9UqzOQUH8Z2+A1oY21rHmK2eztcV9pqoirxJvT1ksPyCi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G51zqWp1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G51zqWp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DE1C4CEF4;
	Wed,  8 Oct 2025 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759913034;
	bh=f3Nb+HgY38YNSFdjvaL6hPWK/70O12LVEeSvZY06YNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G51zqWp18VzrgS9epcn8HnnTT512Xn08C+2TS7eJzGpSuYxSPFmXPQd2oM/tsySEL
	 Zdphi5Vkuv8TRbtse89geif6BI6aq/UFpiZiTYv/Lk6G7qgKiwZBukNT41s14XH2k2
	 kJaID8YyMr8Oz6YguCDFhWbSAhbdoFJm8UTuYtSABdjY0D4ui/q1ENuRUz6A6PlVLW
	 pm6uHorrQl79FXFd/zZSfHC8DChDXGjlnE3Z0Q7LiWQfUht+nmr+NtfFlvX9rz9S4s
	 BcO0M1pEiHpBn7f6wkb7nGin6oD9Au+ZepKgpqrSuHan2lgKwuOtDy20098GHfsmhp
	 kVslc6AooSbdQ==
Date: Wed, 8 Oct 2025 17:43:49 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Additional verbose details for <not
 supported> events
Message-ID: <aOYkRdU5pn_jTOq3@google.com>
References: <20251005181421.2787960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251005181421.2787960-1-irogers@google.com>

On Sun, Oct 05, 2025 at 11:14:21AM -0700, Ian Rogers wrote:
> If an event shows as "<not supported>" in perf stat output, in verbose
> mode add the strerror output to help diagnose the issue.
> 
> Consider:
> ```
> $ perf stat -e cycles,data_read,instructions true
> 
>  Performance counter stats for 'true':
> 
>            357,457      cycles:u
>    <not supported> MiB  data_read:u
>            156,182      instructions:u                   #    0.44  insn per cycle
> 
>        0.001250315 seconds time elapsed
> 
>        0.001283000 seconds user
>        0.000000000 seconds sys
> ```
> 
> To understand why the data_read uncore event failed, with this change:
> ```
> $ perf stat -v -e cycles,data_read,instructions true
> Using CPUID GenuineIntel-6-8D-1
> cycles -> cpu/cycles/
> data_read -> uncore_imc_free_running_0/data_read/
> data_read -> uncore_imc_free_running_1/data_read/
> instructions -> cpu/instructions/
> Control descriptor is not initialized
> Warning:
> kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> Warning:
> kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> Warning:
> kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> Warning:
> data_read:u event is not supported by the kernel.
> Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
> Warning:
> kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> Warning:
> data_read:u event is not supported by the kernel.
> Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
> cycles:u: 351621 362833 362833
> failed to read counter data_read:u
> failed to read counter data_read:u
> instructions:u: 156184 362833 362833
> 
>  Performance counter stats for 'true':
> 
>            351,621      cycles:u
>    <not supported> MiB  data_read:u
>            156,184      instructions:u                   #    0.44  insn per cycle
> 
>        0.001584472 seconds time elapsed
> 
>        0.001811000 seconds user
>        0.000000000 seconds sys
> ```
> where without this change only "data_read:u event is not supported by
> the kernel." is shown.

I think what you say is:

Before:
  data_read:u event is not supported by the kernel.

After:
  data_read:u event is not supported by the kernel.
  Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
 

Off-topic, it'd be great if we reduce the number of the same warning
messages.  I think the data_read is from two uncore PMUs so the message
was repeated.  If we can connect the related evsels and show the
messages once, then the output is more readable.  Maybe we also want to
show the fallback message just once (globally).

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7006f848f87a..84e06ec09cc2 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -624,8 +624,9 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
>  	 */
>  	if (err == EINVAL || err == ENOSYS || err == ENOENT || err == ENXIO) {
>  		if (verbose > 0) {
> -			ui__warning("%s event is not supported by the kernel.\n",
> -				    evsel__name(counter));
> +			evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
> +			ui__warning("%s event is not supported by the kernel.\n%s\n",
> +				    evsel__name(counter), msg);
>  		}
>  		return COUNTER_SKIP;
>  	}
> @@ -649,10 +650,11 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
>  		}
>  	}
>  	if (verbose > 0) {
> +		evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
>  		ui__warning(err == EOPNOTSUPP
> -			? "%s event is not supported by the kernel.\n"
> -			: "skipping event %s that kernel failed to open.\n",
> -			evsel__name(counter));
> +			? "%s event is not supported by the kernel.\n%s\n"
> +			: "skipping event %s that kernel failed to open.\n%s\n",
> +			evsel__name(counter), msg);
>  	}
>  	return COUNTER_SKIP;
>  }
> -- 
> 2.51.0.618.g983fd99d29-goog
> 
