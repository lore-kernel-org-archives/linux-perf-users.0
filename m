Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032A2BEFE8
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Apr 2026 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777229914; cv=pass; b=iHFVmbqL+cnMpnrlYyO2N8k7eqvPWTHQyBEvrBT+ZnGYJ7A8hMXEfPujoxNtvYag/VxKnydSYTJPkP2qRox3dmnWg+DGGcqpuaTTtUBoUr1ImCuEj/f54nqxAanVgu0OjtDzRjPzoyYHdqxntSl2kp8CzbmlrunDdAUckZq3ghs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777229914; c=relaxed/simple;
	bh=RsCKdb0/QTCp8pyLZfK6dtHY+3oj61bUiBP3rqHjxkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrEhkhPiQ3aLAo66uyMv+ogVPDvk/wKPbFYnxP8si8JFB1DP79dcBdVmm1Hh742VZ8s+mbAJ0TurBvUqxVBSnD6rf4ip8xrP3if7TwiDZ5pKOD7MiHv/SKk1EhgI80YhDPBWn5YfhTIgEdPs6emysUEC/Rwye6Pf7rufyV2/ogU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQrZXtyg; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQrZXtyg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso339725ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Apr 2026 11:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777229909; cv=none;
        d=google.com; s=arc-20240605;
        b=TiGDhIg62dJBLiksZzWurAx9aHg6qMd5+KskZunIUSfnWzADSAuNNkMwcw7UYmyMsG
         qVUFPMkKllDb0MnMc1kj+ITfKN6y+SjY2g8d8norg9ZKeTKgrF1YbR71HNn7vc1gWRko
         y66O4kzY8VhwFsK96iiBe3/AtxNZjtm/TDG+iaTXVf8X+m21crmTB9saSD4OZSWiRuSh
         f2GpTm9cDR9lkcmYb1kshlyOyUE/6J+ML/BYHk3cyWDBRp3/gHNyJsG12/gygUPLfCQf
         wVqdWZZgnKW5hkDfy0D5QhMWF0JufQEYJWp0GWif8EY7F76aA7m1wmYCU0YvGhwONFlq
         ZfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KOHk4MZN+p2/Lw+p/j9vzga1pJNa+P5rHjLi3wslAIU=;
        fh=QtIFrt+lA5i2C+Yiv6uSkaiLjIG5stB1z6OP9CULTpY=;
        b=KWLnL3PjJm1WHW4yAJhfZpkUeIVxXRC8ayubt4u16c9hu9yu/XaiOlDLOlOPSnQFUY
         ouUxTyt5LtXNjH6ADq2cTi6vVunKHtgzw2CARy2uGGzf6byw+iuTB2G8DHnEaxwnS1Wa
         DbPXjy51b74MbDJ1CVS/gLCZu+XzZx0rY2/Ffi0We28HDAOtm/Og9VZPrcXARrhYcpm6
         iSlrGMywT5eafsPUraXEHwm7VrhQy3kCpN3C7Q2zxRlrHgoWwXy62hDViCMSvz0g0EM/
         Zl7zTpDnwoJUhKS7TsM8CXrlCpNrYc7I9qIELJSnQUGyoX1zKX9tNg7bTNQ9kUFC4dRc
         qHIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777229909; x=1777834709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOHk4MZN+p2/Lw+p/j9vzga1pJNa+P5rHjLi3wslAIU=;
        b=AQrZXtyg71d8zB6B/WaTR0yPV3Zkd4sojubpHCXsELLEH6FFdAqDzcrVYZ/lMdce9C
         GAa6F19ivftQWQFokODKA5xL0Ma+UMl/hGhLDGRgFMdLf8nJaGqgkQsqKhSvv68oAtYs
         epndcYLIAVYvi9qt84skCTgg1itPLr5nUhvGTXQQJoKxiOuyO2OwDb3aNU4SBfh/HAXB
         HkZe9ns7KGlU3d62qydex4VycX3FXymmc6nPhVFkZdONSLloh295bAaA4nKuTKM3HOGK
         aagAOBRpNGn3GxGr/Ta4Iux9Abny0oa1xcgqfKHkE8fwuMlWCdLwOdA+2ik+pRnlztsO
         /H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777229909; x=1777834709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KOHk4MZN+p2/Lw+p/j9vzga1pJNa+P5rHjLi3wslAIU=;
        b=rSIeZCC5mnnqDPyANr0ndtqd8V7rQyxoCwv9Sx/wWSYiQjEp2TaHjhjcMs59TuIQ92
         RTjC8a1Isdme5ge7+SEdcaeVGkY25lkwyK0ffQz8gEXpJ84hFVVwSe3Ib3CmY1g5jqLP
         mfttFOQgNYABB8jp/YGMy7+NPaM9FK6aHdXJnM16m0NUZKaDTkNzzaOsTyU5Lcb8YPCN
         8LvQa2NhlGyziNj4loNlcK84OkLxtkGMaJTowk4kJADYBwOBUZ5LCIxuPdYjoZnBeDP1
         PTzdfSAjX4OEzsjfMfPy+8j3V1otb0bSrJR/YviBZTR8E6AjX97fLomVaRGx5M91nXuS
         nVKg==
X-Forwarded-Encrypted: i=1; AFNElJ+fXjnwPfLDOqQcCUF9DTqff4ZuPF3xy1Qn3ZNEYbE4aqmP093ZVqa6tQ9fs9fUPPvM6anfqNG0rRKzfmmfOILt@vger.kernel.org
X-Gm-Message-State: AOJu0YysDBB+MnbdGuW84zNUu6TC58TnFVSt3RhQGb2VQZ/jUQzy7fT9
	gAXCvMVoibsL3sF/ktBb9iXL+iscdiOTGSQWxnrHjB+Lbkqyxzl5Jf5NzCzE1rdUkE9HrGyEljx
	MHITtuhzLbU+WHPIxH7R1HCIUA/4a0DiTRKdHmq5z
X-Gm-Gg: AeBDieucpivK/GUrH3Ml7ELJ3zyzntye3qE1GkFfwcrYYUGqX9HN63kPVfw8VfbtTzB
	XCXB7vv/Wkc+uI2fiqGfgTDa3bWIpNv5ej718maUqkn5C2OG3Hk1RkDlxfvRmkHLA3pvoWXqnpl
	s8IzGIKKwix57fpv/vgzuYIfu7U1359ZIX0j4YJKm1X0yqGcutzftIBno6jyGLl9M0uY+GldJpJ
	hn5Z4OpZT6qwlIvEkUFIw03gMr8+hxEjD7wuLeeSetmrmrUfSAA6RmjCIghz1UgNmiZMx9xuMdg
	w0dvG0ZbcKj7aIDYmE81GL1gJ64M3Q==
X-Received: by 2002:a17:902:f08d:b0:2ae:575f:3755 with SMTP id
 d9443c01a7336-2b60307dd17mr17895915ad.20.1777229908828; Sun, 26 Apr 2026
 11:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ_TQUz0kNV-pUzrcNM7ou3xjPdOU73z+qBAWmP7GUW2BRvpHA@mail.gmail.com>
In-Reply-To: <CAJ_TQUz0kNV-pUzrcNM7ou3xjPdOU73z+qBAWmP7GUW2BRvpHA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 26 Apr 2026 11:58:17 -0700
X-Gm-Features: AQROBzA4NjLz8v0pGDTTu4XKXvLZhH-WP9l3MEleEZsK2lNArCdYJyCBTOEtkqM
Message-ID: <CAP-5=fVGWsQKrzSjOddzEqDamH1jzcUZfX4BRPsaDLyHzdhbug@mail.gmail.com>
Subject: Re: [PATCH] perf: add timerfd timeout exit-code handling
To: Malcom Gilbert <malcomgilbert@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 11:21=E2=80=AFAM Malcom Gilbert <malcomgilbert@gmai=
l.com> wrote:
>
> Assisted-by: OpenAI:gpt-5.3-codex-spark
> Signed-off-by: Malcom Gilbert <malcomgilbert@gmail.com>

Thanks Malcolm, the commit message is empty, do you want to describe
what you are trying to achieve here? When recording system-wide, it is
common to use "perf record -a sleep 10" which limits perf to 10
seconds of data.

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-record.txt |  4 +
>  tools/perf/builtin-record.c              | 94 ++++++++++++++++++++++++
>  tools/perf/util/record.h                 |  1 +
>  3 files changed, 99 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index 178f483140ed..ea48f96fe11a 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -554,6 +554,10 @@ When processing pre-existing threads /proc/XXX/mmap,=
 it may take a long time,
>  because the file may be huge. A time out is needed in such cases.
>  This option sets the time out limit. The default value is 500 ms.
>
> +--timeout=3D<seconds>::
> +Stop recording after the given number of seconds.
> +If `perf record` stops from timeout, it exits with status 124.
> +
>  --switch-events::
>  Record context switch events i.e. events of type PERF_RECORD_SWITCH or
>  PERF_RECORD_SWITCH_CPU_WIDE. In some cases (e.g. Intel PT, CoreSight or =
Arm SPE)
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
> + struct itimerspec new_value =3D {};
> + int fd;
> + int pos;
> +
> + if (!rec->opts.timeout)
> + return 0;
> +
> + fd =3D timerfd_create(CLOCK_MONOTONIC, TFD_NONBLOCK);
> + if (fd < 0) {
> + pr_err("Failed to create timeout timerfd, error: %m\n");
> + return -1;
> + }
> +
> + new_value.it_value.tv_sec =3D rec->opts.timeout;
> +
> + if (timerfd_settime(fd, 0, &new_value, NULL) !=3D 0) {
> + pr_err("Failed to start timeout timer, error: %m\n");
> + close(fd);
> + return -1;
> + }
> +
> + /* Recv all timer expirations in one-shot mode. */
> + pos =3D fdarray__add(&thread->pollfd, fd, POLLIN, fdarray_flag__nonfilt=
erable);
> + if (pos < 0) {
> + pr_err("Failed to add timeout timerfd to poll list\n");
> + close(fd);
> + return pos;
> + }
> +
> + rec->timeout_fd =3D fd;
> + rec->timeout_pos =3D pos;
> +
> + return 0;
> +#endif
> +}
> +
> +static int record__process_timeout_event(struct record *rec)
> +{
> + uint64_t expirations;
> + int pos =3D rec->timeout_pos;
> + struct pollfd *timeout_pollfd;
> +
> + if (!thread || !thread->pollfd.entries || pos < 0)
> + return 0;
> + if (pos >=3D thread->pollfd.nr)
> + return 0;
> +
> + timeout_pollfd =3D &thread->pollfd.entries[pos];
> + if (!(timeout_pollfd->revents & POLLIN))
> + return 0;
> +
> + if (read(rec->timeout_fd, &expirations, sizeof(expirations)) < 0) {
> + if (errno =3D=3D EAGAIN)
> + return 0;
> + pr_err("failed to read timeout timerfd, error: %m\n");
> + return -1;
> + }
> + (void)expirations;
> +
> + rec->timed_out =3D true;
> + done =3D 1;
> +
> + return 0;
> +}
> +
>  static void record__sig_exit(void)
>  {
>   if (signr =3D=3D -1)
> @@ -2438,6 +2515,9 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
>   float ratio =3D 0;
>   enum evlist_ctl_cmd cmd =3D EVLIST_CTL_CMD_UNSUPPORTED;
>   struct perf_env *env;
> + rec->timeout_fd =3D -1;
> + rec->timeout_pos =3D -1;
> + rec->timed_out =3D false;
>
>   atexit(record__sig_exit);
>   signal(SIGCHLD, sig_handler);
> @@ -2647,6 +2727,10 @@ static int __cmd_record(struct record *rec, int ar=
gc, const char **argv)
>   if (rec->off_cpu)
>   evlist__enable_evsel(rec->evlist, (char *)OFFCPU_EVENT);
>
> + err =3D record__setup_timeout(rec);
> + if (err)
> + goto out_child;
> +
>   /*
>   * Let the child rip
>   */
> @@ -2814,6 +2898,10 @@ static int __cmd_record(struct record *rec, int ar=
gc, const char **argv)
>   err =3D record__update_evlist_pollfd_from_thread(rec, rec->evlist, thre=
ad);
>   if (err)
>   goto out_child;
> +
> + err =3D record__process_timeout_event(rec);
> + if (err)
> + goto out_child;
>   }
>
>   if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> @@ -2919,6 +3007,10 @@ static int __cmd_record(struct record *rec, int ar=
gc, const char **argv)
>
>   if (rec->off_cpu)
>   rec->bytes_written +=3D off_cpu_write(rec->session);
> + if (rec->timed_out) {
> + signr =3D -1;
> + status =3D 124;
> + }
>
>   record__read_lost_samples(rec);
>   /* this will be recalculated during process_buildids() */
> @@ -3639,6 +3731,8 @@ static struct option __record_options[] =3D {
>       "\t\t\t  Optionally send control command completion ('ack\\n') to a=
ck-fd descriptor.\n"
>       "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used=
 as ctl-fd / ack-fd.",
>        parse_control_option),
> + OPT_UINTEGER(0, "timeout", &record.opts.timeout,
> +     "Stop recording after the given number of seconds"),
>   OPT_CALLBACK(0, "synth", &record.opts, "no|all|task|mmap|cgroup",
>       "Fine-tune event synthesis: default=3Dall", parse_record_synth_opti=
on),
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
>
>
> Malcom
