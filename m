Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074542147E6;
	Mon, 27 Apr 2026 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268894; cv=none; b=RQlHdBe24E8pnfRosfD1htC4vfnUW0ZhO4bWGQbdF2wZYVh95MxrnR8wkSWa4FGImZULp2Cgoott2rYhnVorOHbkUcvH0VjXcn7s7HRZRJNzduRad6vpVVxZNQ4PHHZVZwSPCfzo8hrwoang7l+8p4vcpec2qKSA5iHhQN7tQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268894; c=relaxed/simple;
	bh=WqUt5YpS6S47Q95DPQQD2MZAy33tQOPfGZBmXGRZNMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CibovhhWXxwbH4Zz7n057J5JRVOfxf0QJRmiTSK1xQWHWXQwx/xpa5YZ+C1pNSpKx/8QdbJ9/8BEqcSHoViFqqT5+9XwDSpvjoFPnRXzcGhkEX3jeK+ASd/bs3iyTl/cAZpd/awqrbi7cbELC9TwZjjT22NgFJ5KNyzPP+N/lEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZi92SET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZi92SET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F8BC19425;
	Mon, 27 Apr 2026 05:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777268893;
	bh=WqUt5YpS6S47Q95DPQQD2MZAy33tQOPfGZBmXGRZNMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZi92SETZA+BIfXW2gvY1rWgcBDVxzp0co/GWB0S7ulfNU60v5RHbMcN5Ndn5X6TX
	 3L725eJvl492XN/eHiTSXOpl1E15db0A7cxGi4SEUJjw22JkhbpC+m7iAHSLqzRpbP
	 ZvPQ2eyJvkeTQCk2hpl7eeq1C2hwV2Tt+4xF7V3gUEgNrXlVBDe3M4xVuHIJY5n4r3
	 pB+gIl6DPC2grS8UqquGXTut1otOygF/FMyaPYcbo+t6lNN+9JBUUuhRJO/lh3l3mk
	 JWArDtAq5F9UTi4SkzwfYNczJRyaddRMnuCXgv4S+JlvNzA8yvS2CZMP9/+qRjda5z
	 Eyx+HKaAZzO/Q==
Date: Sun, 26 Apr 2026 22:48:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Malcom Gilbert <malcomgilbert@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: add timerfd timeout exit-code handling
Message-ID: <ae74mZg8HDYGJThA@google.com>
References: <CAJ_TQUzM+JXDy4xo4TgeWBL7f6QA0muLxQ8kEv_0hRw6NqrmZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ_TQUzM+JXDy4xo4TgeWBL7f6QA0muLxQ8kEv_0hRw6NqrmZQ@mail.gmail.com>

Hello,

On Sun, Apr 26, 2026 at 01:28:18PM -0500, Malcom Gilbert wrote:
> Assisted-by: OpenAI:gpt-5.3-codex-spark
> Signed-off-by: Malcom Gilbert <malcomgilbert@gmail.com>

Looks like this patch or your system has a problem with indentation.
Please fix.

Thanks,
Namhyung

> ---
>  tools/perf/Documentation/perf-record.txt |  4 +
>  tools/perf/builtin-record.c              | 94 ++++++++++++++++++++++++
>  tools/perf/util/record.h                 |  1 +
>  3 files changed, 99 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt
> b/tools/perf/Documentation/perf-record.txt
> index 178f483140ed..ea48f96fe11a 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -554,6 +554,10 @@ When processing pre-existing threads
> /proc/XXX/mmap, it may take a long time,
>  because the file may be huge. A time out is needed in such cases.
>  This option sets the time out limit. The default value is 500 ms.
> 
> +--timeout=<seconds>::
> +Stop recording after the given number of seconds.
> +If `perf record` stops from timeout, it exits with status 124.
> +
>  --switch-events::
>  Record context switch events i.e. events of type PERF_RECORD_SWITCH or
>  PERF_RECORD_SWITCH_CPU_WIDE. In some cases (e.g. Intel PT, CoreSight
> or Arm SPE)
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4a5eba498c02..e666d1d475a4 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -71,6 +71,9 @@
>  #ifdef HAVE_EVENTFD_SUPPORT
>  #include <sys/eventfd.h>
>  #endif
> +#ifdef HAVE_TIMERFD_SUPPORT
> +#include <sys/timerfd.h>
> +#endif
>  #include <sys/mman.h>
>  #include <sys/wait.h>
>  #include <sys/types.h>
> @@ -154,6 +157,9 @@ struct pollfd_index_map {
>  struct record {
>   struct perf_tool tool;
>   struct record_opts opts;
> + int timeout_fd;
> + int timeout_pos;
> + bool timed_out;
>   u64 bytes_written;
>   u64 thread_bytes_written;
>   struct perf_data data;
> @@ -721,6 +727,77 @@ static void sigsegv_handler(int sig)
>   sighandler_dump_stack(sig);
>  }
> 
> +static int record__setup_timeout(struct record *rec)
> +{
> +#ifndef HAVE_TIMERFD_SUPPORT
> + pr_err("perf record --timeout is not supported on this platform\n");
> + return -1;
> +#else
> + struct itimerspec new_value = {};
> + int fd;
> + int pos;
> +
> + if (!rec->opts.timeout)
> + return 0;
> +
> + fd = timerfd_create(CLOCK_MONOTONIC, TFD_NONBLOCK);
> + if (fd < 0) {
> + pr_err("Failed to create timeout timerfd, error: %m\n");
> + return -1;
> + }
> +
> + new_value.it_value.tv_sec = rec->opts.timeout;
> +
> + if (timerfd_settime(fd, 0, &new_value, NULL) != 0) {
> + pr_err("Failed to start timeout timer, error: %m\n");
> + close(fd);
> + return -1;
> + }
> +
> + /* Recv all timer expirations in one-shot mode. */
> + pos = fdarray__add(&thread->pollfd, fd, POLLIN, fdarray_flag__nonfilterable);
> + if (pos < 0) {
> + pr_err("Failed to add timeout timerfd to poll list\n");
> + close(fd);
> + return pos;
> + }
> +
> + rec->timeout_fd = fd;
> + rec->timeout_pos = pos;
> +
> + return 0;
> +#endif
> +}
> +
> +static int record__process_timeout_event(struct record *rec)
> +{
> + uint64_t expirations;
> + int pos = rec->timeout_pos;
> + struct pollfd *timeout_pollfd;
> +
> + if (!thread || !thread->pollfd.entries || pos < 0)
> + return 0;
> + if (pos >= thread->pollfd.nr)
> + return 0;
> +
> + timeout_pollfd = &thread->pollfd.entries[pos];
> + if (!(timeout_pollfd->revents & POLLIN))
> + return 0;
> +
> + if (read(rec->timeout_fd, &expirations, sizeof(expirations)) < 0) {
> + if (errno == EAGAIN)
> + return 0;
> + pr_err("failed to read timeout timerfd, error: %m\n");
> + return -1;
> + }
> + (void)expirations;
> +
> + rec->timed_out = true;
> + done = 1;
> +
> + return 0;
> +}
> +
>  static void record__sig_exit(void)
>  {
>   if (signr == -1)
> @@ -2438,6 +2515,9 @@ static int __cmd_record(struct record *rec, int
> argc, const char **argv)
>   float ratio = 0;
>   enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
>   struct perf_env *env;
> + rec->timeout_fd = -1;
> + rec->timeout_pos = -1;
> + rec->timed_out = false;
> 
>   atexit(record__sig_exit);
>   signal(SIGCHLD, sig_handler);
> @@ -2647,6 +2727,10 @@ static int __cmd_record(struct record *rec, int
> argc, const char **argv)
>   if (rec->off_cpu)
>   evlist__enable_evsel(rec->evlist, (char *)OFFCPU_EVENT);
> 
> + err = record__setup_timeout(rec);
> + if (err)
> + goto out_child;
> +
>   /*
>   * Let the child rip
>   */
> @@ -2814,6 +2898,10 @@ static int __cmd_record(struct record *rec, int
> argc, const char **argv)
>   err = record__update_evlist_pollfd_from_thread(rec, rec->evlist, thread);
>   if (err)
>   goto out_child;
> +
> + err = record__process_timeout_event(rec);
> + if (err)
> + goto out_child;
>   }
> 
>   if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> @@ -2919,6 +3007,10 @@ static int __cmd_record(struct record *rec, int
> argc, const char **argv)
> 
>   if (rec->off_cpu)
>   rec->bytes_written += off_cpu_write(rec->session);
> + if (rec->timed_out) {
> + signr = -1;
> + status = 124;
> + }
> 
>   record__read_lost_samples(rec);
>   /* this will be recalculated during process_buildids() */
> @@ -3639,6 +3731,8 @@ static struct option __record_options[] = {
>       "\t\t\t  Optionally send control command completion ('ack\\n')
> to ack-fd descriptor.\n"
>       "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and
> used as ctl-fd / ack-fd.",
>        parse_control_option),
> + OPT_UINTEGER(0, "timeout", &record.opts.timeout,
> +     "Stop recording after the given number of seconds"),
>   OPT_CALLBACK(0, "synth", &record.opts, "no|all|task|mmap|cgroup",
>       "Fine-tune event synthesis: default=all", parse_record_synth_option),
>   OPT_STRING_OPTARG_SET(0, "debuginfod", &record.debuginfod.urls,
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 93627c9a7338..576513ed3b60 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -80,6 +80,7 @@ struct record_opts {
>   int      ctl_fd_ack;
>   bool      ctl_fd_close;
>   int      synth;
> + unsigned int  timeout;
>   int      threads_spec;
>   const char    *threads_user_spec;
>   u64      off_cpu_thresh_ns;
> --
> 2.43.0
> 
> 
> Malcom
