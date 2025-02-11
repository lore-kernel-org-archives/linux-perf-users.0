Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B411CBA
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233084; cv=none; b=EewL+5Poi32hqEO/mOe8+yBPbZsudfiv+LdCh0mLnMhVqMDJETZJOgoWi31EJDNxO9G7ciusCU1suRc8gqLecm7SmRESKV61k/pw1A4ov1p9s3TyP5jj1m7Co8j7hxpYu1L+LsXVD2ubiO9UjLOXCkHLQXYMADGWfie+B7odcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233084; c=relaxed/simple;
	bh=eVsrryGE5O/cI9ESRsbCfp4i10FBMQzjwRYBogDynB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn0zEMkNLD3ErtmU8X8LQPZ7oGLSnObXnYQRZrH54D69LO6pS2RMifAOoVf+a5YDDfFKFxmHdx8ePyEnLwLodvRZvqc7mqHzhpl6ZpUxG5qxwDXlBBvrwDIvZcGs8SsdHZPENjvqr3DJRLordT6sxLQ3lFpqSMn/A1o2Ld7oBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Mq7IgsEu; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Mq7IgsEu"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6f678a27787so45168397b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 16:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739233080; x=1739837880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISAQBQ0fr+yj+zIbyh7W8nrLRTzv2QG8A8GpANmjBC4=;
        b=Mq7IgsEuk6cwOqr5SoPldHD1UZknyX8nKmDPMnsQiVeZ8gCqfP/g8F1GUGK2ReCuYC
         a3m4sIn7tfo9rRor85QG8jemD7yS6ht/4hI0WchyJ5k4TYWv0GeiDkvKiBWVgHAR5EzF
         NIW5ZsANgsJbjeEDGYk63FhFwLuhwE81SHQ/y+FF/Coyf4Zf8tcCj+NGtliRpFyaWM6H
         uA6/ZaTXaqTfW2z9cIahqDm89ODH0pdth1aO/mGtDhIzKVtl12nfLKPPZ6j1vP0LMKI0
         xjy44OWl2Ev/ZlauLk3/w26GM3IQJAakZnw7DXt09j/kUqWTi6edVA7ZD19BREFp2oAJ
         K6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739233080; x=1739837880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISAQBQ0fr+yj+zIbyh7W8nrLRTzv2QG8A8GpANmjBC4=;
        b=vkHMWY2pYLrZL0M4YB/jK65YKrEOo7yI5dCu6ur96wWZhgH9yi34wPo//Y1lsHcM/P
         qLQM+Wr8DU1geQ2Yd5Sr2fuLk3ban4lT7oGozmGkKn8LCEuOKI9evdoONVTlBPBD6KjE
         FWSIIpet6YriMHQtSd3jL6XKuVod873zvnvE53a9FWnZ8hOVpakKgOATL6aycKhuKS6g
         BMUF+6W2pMyHtNBC2sJ7BdDjJrcKw6eDez9UhHtXt04BsLZFIU3dwsRrFM5VLY5JLOBc
         SAi+VlzTRTcmV/SCEV8Y5jioublG30Wjc8cJ9owv342LCfup1aMZXt5HOi1YMzcvxd5M
         /KLA==
X-Forwarded-Encrypted: i=1; AJvYcCVIiniSvA3KK9cjjf/cTLForXhk0YGyz+e7IFx3qjYPe8bk5BqqsorUievTKIm8GwJh16dSW4DkjoBtEski5C3E@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0h+jCJumSrvwldKGIjfo8CH2CpbFWwmDEGvBDGJ9KRiwJov9
	YByxLkprS1YeCdbkZy7t8lZpNU3OoYkigKKIhLXkNQHR2LTymFSvnbhXL5sDmPk=
X-Gm-Gg: ASbGncvdCwVcYPROq7tYd/hb55udb4Ot9EEhY0tiFkO/PoCBdyaigVpFdwGGJlLuQuF
	gaSwldqb9LpnZgfKIMac6o6xM6FpKo7KDaE1PMgQI4sNF00OmoXzXGjP59511DpxeQ/dPjxFOV/
	8IQKlNVCuw0dXIj/IUiq1gv1lXtD2dNvjejsudliG56/lg/6emCtnvKs+UP5Zoa4IIueVQ37w+v
	n91ZIyCXvarQgJtywQWLBYDVbzNJRattn2EauTTwqAf06P8gx26XwBVJtmfKHzlaH6VxARkQCZ+
	vRY=
X-Google-Smtp-Source: AGHT+IG2lYjSA9U8mtH8kqy2zToEQOfHxV7dx2DoND3Wn8X6MxCq6iEaLq5Q27PfBoeN7LzH0kZjXg==
X-Received: by 2002:a05:690c:4d44:b0:6ef:8177:c322 with SMTP id 00721157ae682-6f9b28783cbmr160095467b3.13.1739233080336;
        Mon, 10 Feb 2025 16:18:00 -0800 (PST)
Received: from ghost ([50.146.0.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99ffc3501sm18888087b3.116.2025.02.10.16.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:17:59 -0800 (PST)
Date: Mon, 10 Feb 2025 16:17:57 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>,
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/7] perf trace: Reorganize syscalls
Message-ID: <Z6qXNcjQE2RaoDUZ@ghost>
References: <20250210165108.95894-1-irogers@google.com>
 <20250210165108.95894-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210165108.95894-3-irogers@google.com>

On Mon, Feb 10, 2025 at 08:51:03AM -0800, Ian Rogers wrote:
> Identify struct syscall information in the syscalls table by a machine
> type and syscall number, not just system call number. Having the
> machine type means that 32-bit system calls can be differentiated from
> 64-bit ones on a machine capable of both. Having a table for all
> machine types and all system call numbers would be too large, so
> maintain a sorted array of system calls as they are encountered.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 178 +++++++++++++++++++++++++------------
>  1 file changed, 119 insertions(+), 59 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 06356217adeb..916a51df236b 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -66,6 +66,7 @@
>  #include "rb_resort.h"
>  #include "../perf.h"
>  #include "trace_augment.h"
> +#include "dwarf-regs.h"
>  
>  #include <errno.h>
>  #include <inttypes.h>
> @@ -86,6 +87,7 @@
>  
>  #include <linux/ctype.h>
>  #include <perf/mmap.h>
> +#include <tools/libc_compat.h>
>  
>  #ifdef HAVE_LIBTRACEEVENT
>  #include <event-parse.h>
> @@ -143,7 +145,10 @@ struct trace {
>  	struct perf_tool	tool;
>  	struct syscalltbl	*sctbl;
>  	struct {
> +		/** Sorted sycall numbers used by the trace. */
>  		struct syscall  *table;
> +		/** Size of table. */
> +		size_t		table_size;
>  		struct {
>  			struct evsel *sys_enter,
>  				*sys_exit,
> @@ -1445,22 +1450,37 @@ static const struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
>  	return __syscall_fmt__find_by_alias(syscall_fmts, nmemb, alias);
>  }
>  
> -/*
> - * is_exit: is this "exit" or "exit_group"?
> - * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
> - * args_size: sum of the sizes of the syscall arguments, anything after that is augmented stuff: pathname for openat, etc.
> - * nonexistent: Just a hole in the syscall table, syscall id not allocated
> +/**
> + * struct syscall
>   */
>  struct syscall {
> +	/** @e_machine: The ELF machine associated with the entry. */
> +	int e_machine;
> +	/** @id: id value from the tracepoint, the system call number. */
> +	int id;
>  	struct tep_event    *tp_format;
>  	int		    nr_args;
> +	/**
> +	 * @args_size: sum of the sizes of the syscall arguments, anything
> +	 * after that is augmented stuff: pathname for openat, etc.
> +	 */
> +
>  	int		    args_size;
>  	struct {
>  		struct bpf_program *sys_enter,
>  				   *sys_exit;
>  	}		    bpf_prog;
> +	/** @is_exit: is this "exit" or "exit_group"? */
>  	bool		    is_exit;
> +	/**
> +	 * @is_open: is this "open" or "openat"? To associate the fd returned in
> +	 * sys_exit with the pathname in sys_enter.
> +	 */
>  	bool		    is_open;
> +	/**
> +	 * @nonexistent: Name lookup failed. Just a hole in the syscall table,
> +	 * syscall id not allocated.
> +	 */
>  	bool		    nonexistent;
>  	bool		    use_btf;
>  	struct tep_format_field *args;
> @@ -2066,22 +2086,21 @@ static int syscall__set_arg_fmts(struct syscall *sc)
>  	return 0;
>  }
>  
> -static int trace__read_syscall_info(struct trace *trace, int id)
> +static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  {
>  	char tp_name[128];
> -	struct syscall *sc;
> -	const char *name = syscalltbl__name(trace->sctbl, id);
> +	const char *name;
>  	int err;
>  
> -	if (trace->syscalls.table == NULL) {
> -		trace->syscalls.table = calloc(trace->sctbl->syscalls.max_id + 1, sizeof(*sc));
> -		if (trace->syscalls.table == NULL)
> -			return -ENOMEM;
> -	}
> -	sc = trace->syscalls.table + id;
>  	if (sc->nonexistent)
>  		return -EEXIST;
>  
> +	if (sc->name) {
> +		/* Info already read. */
> +		return 0;
> +	}
> +
> +	name = syscalltbl__name(trace->sctbl, sc->id);
>  	if (name == NULL) {
>  		sc->nonexistent = true;
>  		return -EEXIST;
> @@ -2104,15 +2123,16 @@ static int trace__read_syscall_info(struct trace *trace, int id)
>  	 */
>  	if (IS_ERR(sc->tp_format)) {
>  		sc->nonexistent = true;
> -		return PTR_ERR(sc->tp_format);
> +		err = PTR_ERR(sc->tp_format);
> +		sc->tp_format = NULL;
> +		return err;
>  	}
>  
>  	/*
>  	 * The tracepoint format contains __syscall_nr field, so it's one more
>  	 * than the actual number of syscall arguments.
>  	 */
> -	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
> -					RAW_SYSCALL_ARGS_NUM : sc->tp_format->format.nr_fields - 1))
> +	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
>  		return -ENOMEM;
>  
>  	sc->args = sc->tp_format->format.fields;
> @@ -2401,13 +2421,67 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  	return printed;
>  }
>  
> +static void syscall__init(struct syscall *sc, int e_machine, int id)
> +{
> +	memset(sc, 0, sizeof(*sc));
> +	sc->e_machine = e_machine;
> +	sc->id = id;
> +}
> +
> +static void syscall__exit(struct syscall *sc)
> +{
> +	if (!sc)
> +		return;
> +
> +	zfree(&sc->arg_fmt);
> +}
> +
> +static int syscall__cmp(const void *va, const void *vb)
> +{
> +	const struct syscall *a = va, *b = vb;
> +
> +	if (a->e_machine != b->e_machine)
> +		return a->e_machine - b->e_machine;
> +
> +	return a->id - b->id;
> +}
> +
> +static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, int id)
> +{
> +	struct syscall key = {
> +		.e_machine = e_machine,
> +		.id = id,
> +	};
> +	struct syscall *sc, *tmp;
> +
> +	sc = bsearch(&key, trace->syscalls.table, trace->syscalls.table_size,
> +		     sizeof(struct syscall), syscall__cmp);
> +	if (sc)
> +		return sc;
> +
> +	tmp = reallocarray(trace->syscalls.table, trace->syscalls.table_size + 1,
> +			   sizeof(struct syscall));
> +	if (!tmp)
> +		return NULL;
> +
> +	trace->syscalls.table = tmp;
> +	sc = &trace->syscalls.table[trace->syscalls.table_size++];
> +	syscall__init(sc, e_machine, id);
> +	qsort(trace->syscalls.table, trace->syscalls.table_size, sizeof(struct syscall),
> +	      syscall__cmp);
> +	sc = bsearch(&key, trace->syscalls.table, trace->syscalls.table_size,
> +		     sizeof(struct syscall), syscall__cmp);
> +	return sc;
> +}
> +
>  typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evsel,
>  				  union perf_event *event,
>  				  struct perf_sample *sample);
>  
> -static struct syscall *trace__syscall_info(struct trace *trace,
> -					   struct evsel *evsel, int id)
> +static struct syscall *trace__syscall_info(struct trace *trace, struct evsel *evsel,
> +					   int e_machine, int id)
>  {
> +	struct syscall *sc;
>  	int err = 0;
>  
>  	if (id < 0) {
> @@ -2432,28 +2506,20 @@ static struct syscall *trace__syscall_info(struct trace *trace,
>  
>  	err = -EINVAL;
>  
> -	if (id > trace->sctbl->syscalls.max_id) {
> -		goto out_cant_read;
> -	}
> -
> -	if ((trace->syscalls.table == NULL || trace->syscalls.table[id].name == NULL) &&
> -	    (err = trace__read_syscall_info(trace, id)) != 0)
> -		goto out_cant_read;
> +	sc = trace__find_syscall(trace, e_machine, id);
> +	if (sc)
> +		err = syscall__read_info(sc, trace);
>  
> -	if (trace->syscalls.table && trace->syscalls.table[id].nonexistent)
> -		goto out_cant_read;
> -
> -	return &trace->syscalls.table[id];
> -
> -out_cant_read:
> -	if (verbose > 0) {
> +	if (err && verbose > 0) {
>  		char sbuf[STRERR_BUFSIZE];
> -		fprintf(trace->output, "Problems reading syscall %d: %d (%s)", id, -err, str_error_r(-err, sbuf, sizeof(sbuf)));
> -		if (id <= trace->sctbl->syscalls.max_id && trace->syscalls.table[id].name != NULL)
> -			fprintf(trace->output, "(%s)", trace->syscalls.table[id].name);
> +
> +		fprintf(trace->output, "Problems reading syscall %d: %d (%s)", id, -err,
> +			str_error_r(-err, sbuf, sizeof(sbuf)));
> +		if (sc && sc->name)
> +			fprintf(trace->output, "(%s)", sc->name);
>  		fputs(" information\n", trace->output);
>  	}
> -	return NULL;
> +	return err ? NULL : sc;
>  }
>  
>  struct syscall_stats {
> @@ -2600,14 +2666,6 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
>  	return NULL;
>  }
>  
> -static void syscall__exit(struct syscall *sc)
> -{
> -	if (!sc)
> -		return;
> -
> -	zfree(&sc->arg_fmt);
> -}
> -
>  static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>  			    union perf_event *event __maybe_unused,
>  			    struct perf_sample *sample)
> @@ -2619,7 +2677,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>  	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
>  	int augmented_args_size = 0;
>  	void *augmented_args = NULL;
> -	struct syscall *sc = trace__syscall_info(trace, evsel, id);
> +	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
>  	struct thread_trace *ttrace;
>  
>  	if (sc == NULL)
> @@ -2693,7 +2751,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
>  	struct thread_trace *ttrace;
>  	struct thread *thread;
>  	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
> -	struct syscall *sc = trace__syscall_info(trace, evsel, id);
> +	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
>  	char msg[1024];
>  	void *args, *augmented_args = NULL;
>  	int augmented_args_size;
> @@ -2768,7 +2826,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
>  	struct thread *thread;
>  	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
>  	int alignment = trace->args_alignment;
> -	struct syscall *sc = trace__syscall_info(trace, evsel, id);
> +	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
>  	struct thread_trace *ttrace;
>  
>  	if (sc == NULL)
> @@ -3121,7 +3179,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
>  
>  	if (evsel == trace->syscalls.events.bpf_output) {
>  		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
> -		struct syscall *sc = trace__syscall_info(trace, evsel, id);
> +		struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
>  
>  		if (sc) {
>  			fprintf(trace->output, "%s(", sc->name);
> @@ -3626,7 +3684,7 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, str
>  
>  static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
>  {
> -	struct syscall *sc = trace__syscall_info(trace, NULL, id);
> +	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, id);
>  
>  	if (sc == NULL)
>  		return;
> @@ -3637,20 +3695,20 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
>  
>  static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
>  {
> -	struct syscall *sc = trace__syscall_info(trace, NULL, id);
> +	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, id);
>  	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
>  }
>  
>  static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
>  {
> -	struct syscall *sc = trace__syscall_info(trace, NULL, id);
> +	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, id);
>  	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
>  }
>  
>  static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key, unsigned int *beauty_array)
>  {
>  	struct tep_format_field *field;
> -	struct syscall *sc = trace__syscall_info(trace, NULL, key);
> +	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, key);
>  	const struct btf_type *bt;
>  	char *struct_offset, *tmp, name[32];
>  	bool can_augment = false;
> @@ -3748,7 +3806,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  try_to_find_pair:
>  	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
>  		int id = syscalltbl__id_at_idx(trace->sctbl, i);
> -		struct syscall *pair = trace__syscall_info(trace, NULL, id);
> +		struct syscall *pair = trace__syscall_info(trace, NULL, EM_HOST, id);
>  		struct bpf_program *pair_prog;
>  		bool is_candidate = false;
>  
> @@ -3898,7 +3956,7 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
>  	 */
>  	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
>  		int key = syscalltbl__id_at_idx(trace->sctbl, i);
> -		struct syscall *sc = trace__syscall_info(trace, NULL, key);
> +		struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, key);
>  		struct bpf_program *pair_prog;
>  		int prog_fd;
>  
> @@ -4663,7 +4721,11 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
>  			pct = avg ? 100.0 * stddev_stats(&stats->stats) / avg : 0.0;
>  			avg /= NSEC_PER_MSEC;
>  
> -			sc = &trace->syscalls.table[syscall_stats_entry->syscall];
> +			sc = trace__syscall_info(trace, /*evsel=*/NULL, EM_HOST,
> +						 syscall_stats_entry->syscall);
> +			if (!sc)
> +				continue;
> +
>  			printed += fprintf(fp, "   %-15s", sc->name);
>  			printed += fprintf(fp, " %8" PRIu64 " %6" PRIu64 " %9.3f %9.3f %9.3f",
>  					   n, stats->nr_failures, syscall_stats_entry->msecs, min, avg);
> @@ -5071,12 +5133,10 @@ static int trace__config(const char *var, const char *value, void *arg)
>  
>  static void trace__exit(struct trace *trace)
>  {
> -	int i;
> -
>  	strlist__delete(trace->ev_qualifier);
>  	zfree(&trace->ev_qualifier_ids.entries);
>  	if (trace->syscalls.table) {
> -		for (i = 0; i <= trace->sctbl->syscalls.max_id; i++)
> +		for (size_t i = 0; i < trace->syscalls.table_size; i++)
>  			syscall__exit(&trace->syscalls.table[i]);
>  		zfree(&trace->syscalls.table);
>  	}
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 
