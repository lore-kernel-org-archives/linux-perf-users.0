Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85D4F7987;
	Wed, 16 Sep 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567055; cv=none; b=GB3mQ7iMtn01bU6fCdviykouGWTVS5XpuxuLHDSWVLeIsQSIVS7w5PLtNV7o92A3UD/dFtb9MzDCXCwtXrjl45Z4R8Jlf+9FWCmyMNam13o5QW3C/zUKoFnWN8wwYEreHBCs7td9OpmzB3L+1gRTdw1MWGjQsJvanYecvzixYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567055; c=relaxed/simple;
	bh=t46hs0/GEgmiGgZp9Os84+OnNOORKYKQb8jdq05gkxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQos4XNJOHRa/WGt2uVHnsCJwgTg5y1vNbo7BlR66OGKSxkN7LBvkJc6OvRX/Z5edMABLNRFmDdDF90mbMAwK9nvDNEEqIE8PJAMgvE1sFTriB+b2b97jk54+KCcPg40tOpwdPDaOFMUzjWxGyFrYLVgLAuGTGRECKdYpg7GfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j28oebvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j28oebvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA561F000FF;
	Wed, 16 Sep 2026 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567046;
	bh=+mvIy+ktfyCO7J35CXJ94gRBdKzmzDuLPLFeOqM1y24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j28oebvKbBFT/nU1bd70pbZcnAZWAMV3kmDAdf1VUu4h2xwujuol0OJ2oXG/aFsDq
	 VCFYYL2aYxaodyPvbpHhTPv8footUbbq7HMxEEXasLhIAIYCa5/tL0YxYXJ5u2QoGy
	 vBVHIqKdflCS6RxKL1o7fLdDoCpBm/FT+lCx8bowIlwctl+TbUq4BLKEKDhuf5/RKU
	 LjrZmVWOj/h58DZHjxXa9KPahuW+Kf+Hl8RI8vA9H/gZEAkjuD17JsEVs8nHcYxZCM
	 HqIXbiKTcAL7RqS3XiZi9vR10doSdiK7O8yd9PC0U5paxR5tDwMphwO8TwETbbOQLX
	 jed7115szDXvg==
Date: Wed, 16 Sep 2026 10:57:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9] perf evsel: Find process with busy PMUs for EBUSY
Message-ID: <aqqgQ_sbzwBTmKJ8@x2>
References: <CAP-5=fVzG-2oJ1gN=s-W+2r58k8P4M-E3r8aP9zJ2aK_w-K9vQ@mail.gmail.com>
 <20260915204951.2935261-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915204951.2935261-2-ctshao@google.com>

On Tue, Sep 15, 2026 at 01:49:51PM -0700, Chun-Tse Shao wrote:
> It parses fdinfo with PMU type, comparing with the event which failed to
> open, and report the processes causing EBUSY error.
> 
> Testing cycles and intel_pt//
> 
>   $ ./perf stat -e cycles &
>   [1] 55569
>   $ ./perf stat -e intel_pt// &
>   [2] 55683
>   $ ./perf stat -e intel_pt//
>   Error:
>   The PMU intel_pt counters are busy and in use by another process.
>   Possible processes:
>   55683 ./perf stat -e intel_pt//
> 
> Only perf with intel_pt was reported.

I'll apply this after addressing Sashiko's comments about missing
headers for building on musl libc systems, thanks.

- Arnaldo
 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> ---
> v9:
>   - Rebased onto perf-tools-next
> ---
>  tools/perf/util/evsel.c | 69 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index b44fd880d2d5..f3f5519d0d3d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -4354,8 +4354,11 @@ static bool find_process(const char *name)
>  	return ret ? false : true;
>  }
> 
> -static int dump_perf_event_processes(char *msg, size_t size)
> +static int dump_perf_event_processes(const struct evsel *evsel,
> +				     char *msg, size_t size)
>  {
> +	const struct perf_event_attr *failed_attr = &evsel->core.attr;
> +	u32 target_pmu_type = evsel->pmu ? evsel->pmu->type : UINT32_MAX;
>  	DIR *proc_dir;
>  	struct dirent *proc_entry;
>  	int printed = 0;
> @@ -4386,6 +4389,15 @@ static int dump_perf_event_processes(char *msg, size_t size)
>  			continue;
>  		}
>  		while ((fd_entry = readdir(fd_dir)) != NULL) {
> +			const char *target_lnk = "anon_inode:[perf_event]";
> +			size_t target_lnk_len = sizeof("anon_inode:[perf_event]") - 1;
> +			char fdinfo_buf[1024];
> +			int fdinfo_fd;
> +			ssize_t fdinfo_size;
> +			char *line;
> +			char *saveptr;
> +			u32 perf_event_type = UINT32_MAX;
> +			u32 pmu_type = UINT32_MAX;
>  			ssize_t link_size;
> 
>  			if (fd_entry->d_type != DT_LNK)
> @@ -4394,12 +4406,51 @@ static int dump_perf_event_processes(char *msg, size_t size)
>  			if (link_size < 0)
>  				continue;
>  			/* Take care as readlink doesn't null terminate the string. */
> -			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {
> +			if (link_size != (ssize_t)target_lnk_len ||
> +			    strncmp(buf, target_lnk, target_lnk_len))
> +				continue;
> +
> +			/* Let's check the PMU type reserved by this process */
> +			scnprintf(buf, sizeof(buf), "%s/fdinfo/%s",
> +				  proc_entry->d_name, fd_entry->d_name);
> +			fdinfo_fd = openat(dirfd(proc_dir), buf, O_RDONLY | O_NONBLOCK);
> +			if (fdinfo_fd == -1)
> +				continue;
> +			fdinfo_size = read(fdinfo_fd, fdinfo_buf, sizeof(fdinfo_buf) - 1);
> +			close(fdinfo_fd);
> +			if (fdinfo_size < 0)
> +				continue;
> +			fdinfo_buf[fdinfo_size] = '\0';
> +
> +			line = strtok_r(fdinfo_buf, "\n", &saveptr);
> +			while (line) {
> +				if (sscanf(line,
> +					   "perf_event_attr.type:\t%u",
> +					   &perf_event_type) == 1) {
> +					/* continue parsing */
> +				} else if (sscanf(line,
> +						  "pmu_type:\t%u",
> +						  &pmu_type) == 1) {
> +					/* continue parsing */
> +				}
> +				line = strtok_r(NULL, "\n", &saveptr);
> +			}
> +
> +			/* Report the process which reserves the conflicted PMU. */
> +			/* If fdinfo does not contain PMU type, report it too. */
> +			if (perf_event_type == failed_attr->type ||
> +			    pmu_type == failed_attr->type ||
> +			    (target_pmu_type != UINT32_MAX &&
> +			     pmu_type == target_pmu_type) ||
> +			    (perf_event_type == UINT32_MAX &&
> +			     pmu_type == UINT32_MAX)) {
>  				int cmdline_fd;
>  				ssize_t cmdline_size;
> 
> -				scnprintf(buf, sizeof(buf), "%s/cmdline", proc_entry->d_name);
> -				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
> +				scnprintf(buf, sizeof(buf),
> +					  "%s/cmdline",
> +					  proc_entry->d_name);
> +				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY | O_NONBLOCK);
>  				if (cmdline_fd == -1)
>  					continue;
>  				cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
> @@ -4410,10 +4461,12 @@ static int dump_perf_event_processes(char *msg, size_t size)
>  				for (ssize_t i = 0; i < cmdline_size; i++) {
>  					if (buf[i] == '\0')
>  						buf[i] = ' ';
> +					else if (!isprint((unsigned char)buf[i]))
> +						buf[i] = '.';
>  				}
> -
>  				if (printed == 0)
> -					printed += scnprintf(msg, size, "Possible processes:\n");
> +					printed += scnprintf(msg, size,
> +							     "Possible processes:\n");
> 
>  				printed += scnprintf(msg + printed, size - printed,
>  						"%s %s\n", proc_entry->d_name, buf);
> @@ -4535,7 +4588,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			msg, size,
>  			"The PMU %s counters are busy and in use by another process.\n",
>  			evsel->pmu ? evsel->pmu->name : "");
> -		return printed + dump_perf_event_processes(msg + printed, size - printed);
> +		return printed + dump_perf_event_processes(evsel,
> +							   msg + printed,
> +							   size - printed);
>  		break;
>  	case EINVAL:
>  		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
> --
> 2.55.0.1032.g73a4cd73de-goog
