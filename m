Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE2163;
	Tue,  5 Nov 2024 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764899; cv=none; b=r6DW3jdRXeYjx9J5zz0VP/4OOPFkEBbuKTFKJJXTlto5xanD9NfRAJ9fTDaAaPtIQlLKIqmeE21i87ZmZrQPP2WA6pgyrgEMRMxD8litwnVLhmhkh0s41knRaaWN6wi/JXswhxk9VMFga5EG4qQlTaUhhULM87evFWnYMD8/Lh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764899; c=relaxed/simple;
	bh=72JyDhaXBpsov2fuJm6Viu/J5lE0KyyyUuWbgRPfHII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAlbNArQQo0DMQGqTwdIr8g4RwQttfanl/I5bGkL8wU5Yhg6Sb38f/nenrjoCp1hmrjbCwIo3/+4FlvFPtgLRpApsv30O0yWFA8aubbSLX7XmuOR6BOS313q5S6+8MElcSiZjW/8iq5+sNQc0kYV8Dsb/9yzEbvMTVlLFqxqcdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu11+GSk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu11+GSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7A4C4CECE;
	Tue,  5 Nov 2024 00:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730764898;
	bh=72JyDhaXBpsov2fuJm6Viu/J5lE0KyyyUuWbgRPfHII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gu11+GSkfkaTcT/lzFu975CTQ5TRYitwFFVGWRpCkcIxCrmLmU80vrTLjk9VLbdZ/
	 nMDvfomzIXXjMX/+MktlSf96idUHMudtYG196MB4pQC8U+//iHNAQXnmqDPUrLB0ko
	 xL/ToyyzQsKqAzsrA5DvjgYEiYsJ/0XHEIoofg7tDJBlnQYJb2UWHWrfvz+V9+kotN
	 diFxkQoKuwm6qjbXeiu5CGEGUon2WRPOSKzD30SzpFUCcd++FXdwq21QlSn5PVrogc
	 GVl3uykCvLc3APL/UrxVtZSYQqwnuzM/eCDHw8/2u/3vtkTyxiu7zNfvMijpBiFCDo
	 9waev02uYgUlA==
Date: Mon, 4 Nov 2024 16:01:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf evsel: Improve the evsel__open_strerror for
 EBUSY
Message-ID: <ZylgYE2HXzGpAdKQ@google.com>
References: <20241101211757.824743-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101211757.824743-1-ctshao@google.com>

Hello CT,

On Fri, Nov 01, 2024 at 09:17:55PM +0000, Chun-Tse Shao wrote:
> From: Ian Rogers <irogers@google.com>
> 
> The existing EBUSY strerror message is:
> ```
> The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (intel_bts//).
> "dmesg | grep -i perf" may provide additional information.
> ```

Just a nitpick.  I'd like to avoid this github markdown style notation
of triple backticks as it doesn't clearly separate code blocks (IMHO)
nor protect anything like '#' sign in the beginning of a line.

I prefer indenting with 2 spaces before and after a blank line.


> The dmesg won't be useful. What is more useful is knowing what
> processes are potentially using the PMU, which some procfs scanning can
> reveal. When parallel testing tests/shell/stat_all_pmu.sh this yields:
> ```
> Testing intel_bts//
> Error:
> The PMU intel_bts counters are busy and in use by another process.
> Possible processes:
> 2585882 perf list
> 2585902 perf list -j -o /tmp/__perf_test.list_output.json.KF9MY
> 2585904 perf list
> 2585911 perf record -e task-clock --filter period > 1 -o /dev/null --quiet true
> 2585912 perf list
> 2585915 perf list
> 2586042 /tmp/perf/perf record -asdg -e cpu-clock -o /tmp/perftool-testsuite_report.dIF/perf_report/perf.data -- sleep 2
> 2589078 perf record -g -e task-clock:u -o - perf test -w noploop
> 2589148 /tmp/perf/perf record --control=fifo:control,ack -e cpu-clock -m 1 sleep 10
> 2589379 perf --buildid-dir /tmp/perf.debug.Umx record --buildid-all -o /tmp/perf.data.YBm /tmp/perf.ex.MD5.ZQW
> 2589568 perf record -o /tmp/__perf_test.program.mtcZH/perf.data --branch-filter any,save_type,u -- perf test -w brstack
> 2589649 perf record --per-thread -o /tmp/__perf_test.perf.data.5d3dc perf test -w thloop
> 2589898 perf record -o /tmp/perf-test-script.BX2b27Dcnj/pp-perf.data --sample-cpu uname
> ```
> Which gets a little closer to finding the issue.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 79 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbf9c8cee3c56..9a5b6a6f8d2e5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3286,6 +3286,78 @@ static bool find_process(const char *name)
>  	return ret ? false : true;
>  }
> 
> +static int dump_perf_event_processes(char *msg, size_t size)
> +{
> +	DIR *proc_dir;
> +	struct dirent *proc_entry;
> +	int printed = 0;
> +
> +	proc_dir = opendir(procfs__mountpoint());
> +	if (!proc_dir)
> +		return 0;
> +
> +	/* Walk through the /proc directory. */
> +	while ((proc_entry = readdir(proc_dir)) != NULL) {
> +		char path[PATH_MAX];

Can we use a much smaller buffer as it expects PIDs only?


> +		DIR *fd_dir;
> +		struct dirent *fd_entry;
> +		int fd_dir_fd;
> +
> +		if ((proc_entry->d_type != DT_DIR) ||
> +		     !strcmp(".", proc_entry->d_name) ||
> +		     !strcmp("..", proc_entry->d_name))

Maybe something like this?

		if (proc_entry->d_type != DT_DIR ||
		    !isdigit(proc_entry->d_name[0]) ||
		    strlen(proc_entry->d_name) > sizeof(path) - 4)

Thanks,
Namhyung


> +			continue;
> +
> +		scnprintf(path, sizeof(path), "%s/fd", proc_entry->d_name);
> +		fd_dir_fd = openat(dirfd(proc_dir), path, O_DIRECTORY);
> +		if (fd_dir_fd == -1)
> +			continue;
> +		fd_dir = fdopendir(fd_dir_fd);
> +		if (!fd_dir) {
> +			close(fd_dir_fd);
> +			continue;
> +		}
> +		while ((fd_entry = readdir(fd_dir)) != NULL) {
> +			ssize_t link_size;
> +
> +			if (fd_entry->d_type != DT_LNK)
> +				continue;
> +			link_size = readlinkat(fd_dir_fd, fd_entry->d_name, path, sizeof(path));
> +			if (link_size < 0)
> +				continue;
> +			/* Take care as readlink doesn't null terminate the string. */
> +			if (!strncmp(path, "anon_inode:[perf_event]", link_size)) {
> +				int cmdline_fd;
> +				ssize_t cmdline_size;
> +
> +				scnprintf(path, sizeof(path), "%s/cmdline", proc_entry->d_name);
> +				cmdline_fd = openat(dirfd(proc_dir), path, O_RDONLY);
> +				if (cmdline_fd == -1)
> +					continue;
> +				cmdline_size = read(cmdline_fd, path, sizeof(path) - 1);
> +				close(cmdline_fd);
> +				if (cmdline_size < 0)
> +					continue;
> +				path[cmdline_size] = '\0';
> +				for (ssize_t i = 0; i < cmdline_size; i++) {
> +					if (path[i] == '\0')
> +						path[i] = ' ';
> +				}
> +
> +				if (printed == 0)
> +					printed += scnprintf(msg, size, "Possible processes:\n");
> +
> +				printed += scnprintf(msg + printed, size - printed,
> +						"%s %s\n", proc_entry->d_name, path);
> +				break;
> +			}
> +		}
> +		closedir(fd_dir);
> +	}
> +	closedir(proc_dir);
> +	return printed;
> +}
> +
>  int __weak arch_evsel__open_strerror(struct evsel *evsel __maybe_unused,
>  				     char *msg __maybe_unused,
>  				     size_t size __maybe_unused)
> @@ -3319,7 +3391,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			printed += scnprintf(msg, size,
>  				"No permission to enable %s event.\n\n", evsel__name(evsel));
> 
> -		return scnprintf(msg + printed, size - printed,
> +		return printed + scnprintf(msg + printed, size - printed,
>  		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
>  		 "access to performance monitoring and observability operations for processes\n"
>  		 "without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.\n"
> @@ -3382,6 +3454,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			return scnprintf(msg, size,
>  	"The PMU counters are busy/taken by another profiler.\n"
>  	"We found oprofile daemon running, please stop it and try again.");
> +		printed += scnprintf(
> +			msg, size,
> +			"The PMU %s counters are busy and in use by another process.\n",
> +			evsel->pmu ? evsel->pmu->name : "");
> +		return printed + dump_perf_event_processes(msg + printed, size - printed);
>  		break;
>  	case EINVAL:
>  		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
> --
> 2.47.0.163.g1226f6d8fa-goog
> 
