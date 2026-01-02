Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63542D2488
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Jan 2026 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355723; cv=none; b=qdyLxs1e3XOdvxP8HmlNcXQJOgMbkILg2Bmq2x4K09/FBewHsJ3cW0v+nXoYkpQZlsDxIm3i58kVwh7YahG3+DLALMmHQ4a3Wu5bEzXP0aHeAJrCNAjFRH7ACE2uWkgDzre4W3t1Dihvi0Q7mAZ1AclJ4RAOUIcniy+JJ9C74r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355723; c=relaxed/simple;
	bh=3nkZrcc5j+0Nk1g7ieFmO1/l8QNUszzn6mny4EdXQBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6drboC2x/12r0RaiD7QvyMi86PIRKt7gvjlS95j7TLRk7+RACnxDBA9RFDgsMdf2Uhk94EsG+a5j+0qPgBprOVk3qsLX1LOwF7DHfgJN+7FcOIb203eCo2yICae0Hyvsg9JP64gJ1eS6HNhhwlwN8yiDOr1eySZw87H7eihs0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/hcX8XU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/hcX8XU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso35832625e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jan 2026 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767355720; x=1767960520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TF3ESRnX7HyjEvyH5IW+sfXutUHBPZeRqz7VoI+iycI=;
        b=c/hcX8XUesJrxiufwFug3JrW3E7aNZtiMNN4m40r19OVh1HejYBdIdbh4sBonVBtKa
         F/3emy164C5gdvj2L6xhAk2W7jWU1iW1+LWKyXGnHuzaTjemAooz+vHAiw02HZvs0IQj
         lGC3DhUxAmPne1w06r5vDzP7MosCiVW3MEBhToR8hvuLG+qpBmtHrAJlvcSHA5n2ri5d
         U1PIyfClVGilDurlph4QFoNznhNJ4PLLVTcxoT/36ppnZBK/dLIQsI8Gkcv/V3Inkxxo
         hiNBWFjw+h+tu/5an17llJ21tZL6sk3juWcCUXXaVaX3EHQPWJwlkyrqcNg7Jh7SUl0G
         sUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767355720; x=1767960520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TF3ESRnX7HyjEvyH5IW+sfXutUHBPZeRqz7VoI+iycI=;
        b=qbjycc1hGIDwQbYeXtiD6bfaE/xBOPuyZEeyoZv3IyjyvFlFHWAAKDgvbD6Kw6BRIp
         AmDqil/Dt+H5IVbLWfz+MmW1DNCO9+5PB5vubU/mquHmTfGozmBFENaHdsUIvNpIBR3v
         H02WXxHcDGinTv2Jlz5gkUiMKJMu+ZoQrgxqS4vUKAhF/ItAP4iDZ0eby8Kf/M+Ia9DA
         cpyCrWlQSXjFCEGfPeYnC6EnsNuoQzt/oQ5Ne2Hewx6Umf52f6r+jXXHjcKjl2IUTPnI
         /N+a/QH98f0wEtcG9xeOipPPcUwJOthebGFb4cLzP4EuRTDA2a+h/vXPQ9fPx/VBBJAr
         GCyA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Mrhh4AYauea80YZG+uKZb/n+xD5Igk6+hj74ANZpYs4ui2GjR1HvTTUMTPvzzaYxp+d8/m5VgEwwgUXF93zq@vger.kernel.org
X-Gm-Message-State: AOJu0YyiK5MrH3XUAcdXjhH4xDPRKOXVpE7HMwXNpCVlTsGEnigSqApr
	S+O8yz2MiPq0BIurn/1od7rUqTLaxj9EmdKMIK7WeQwd3EvveR3UqqdZEDBWCwIqXOkHsBJZw29
	1yILI9uc=
X-Gm-Gg: AY/fxX5XoE266VPLWkedlp+e1yZUtrfUn7UUN/BcRZDJ0CISKL7UF2hhVusp5/21IPs
	2e9/Z/Y2KH2LvKs/GoKJMT3V4jRTnyvH0hqayGUtYCVVNrM09Xg+SkUmIfVvuu2h7L2KL02v6g+
	aoXo5H5no5dadTntf0fOeP4i14jorM+oORdilIBCXHIU59N/M1IO52hsGsC4Bjw6DmxpYywERDb
	b+fKcUJqlI2D5wIPMiDzDOJuhJmaAzJeS5/zlhtGaO/An9X2JvYL3f/zhoYkMwakh4cgMAiQpXT
	YBJRuQz8UiJspp82IUd3HnsSBwAlvJbB4sf7HT23phyN4rqc/MiRrodjbF37xqZfnWzFneo3ASJ
	haVHWglfsWP24/OcnXleVqeXdgHVKLKYlrjcgckpXWTiBetN1WrmNzkwrRKeYZQmHg1V2lE6OfD
	8BRlHmeFfFZ/jUIY0cVy0Q0ddiOII=
X-Google-Smtp-Source: AGHT+IF4G8+F1dx9BIF4mxSLe1LQVG7gQ/JIEH+9VB1aebVQsK9EcOBTGd/xPmfP3QeR/58VvZzRkA==
X-Received: by 2002:a05:600c:8718:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-47d19593864mr443146525e9.26.1767355719653;
        Fri, 02 Jan 2026 04:08:39 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d1936d220sm815672935e9.8.2026.01.02.04.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 04:08:39 -0800 (PST)
Message-ID: <c6beb2f6-3f36-45e2-bdb7-17925cbdc9d0@linaro.org>
Date: Fri, 2 Jan 2026 12:08:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] perf inject: Add --convert-callchain option
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20251218215741.2446883-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251218215741.2446883-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/12/2025 9:57 pm, Namhyung Kim wrote:
> There are applications not built with frame pointers, so DWARF is needed
> to get the stack traces.  So `perf record --call-graph dwarf` saves the
> stack and register data for each sample to get the stacktrace offline.
> But sometimes those data may have sensitive information and we don't
> want to keep them in the file.
> 
> This perf inject --convert-callchain option parses the callchains and
> discard the stack and register after that.  This will save storage space
> and processing time for the new data file.  Of course, users should
> remove the original data file. :)
> 
> The down side is that it cannot handle inlined callchain entries as they
> all have the same IPs.  Maybe we can add an option to perf report to
> look up inlined functions using DWARF - IIUC it won't requires stack and
> register data.
> 

If this works it could also be used to augment frame pointer unwinds 
with inlines too.

> This is an example.
> 
>    $ perf record --call-graph dwarf -- perf test -w noploop
> 
>    $ perf report --stdio --no-children --percent-limit=0 > output-prev
> 
>    $ perf inject -i perf.data --convert-callchain -o perf.data.out
> 
>    $ perf report --stdio --no-children --percent-limit=0 -i perf.data.out > output-next
> 
>    $ diff -u output-prev output-next
>    ...
>          0.23%  perf          ld-linux-x86-64.so.2  [.] _dl_relocate_object_no_relro
>                 |
>    -            ---elf_dynamic_do_Rela (inlined)
>    -               _dl_relocate_object_no_relro
>    +            ---_dl_relocate_object_no_relro
>                    _dl_relocate_object
>                    dl_main
>                    _dl_sysdep_start
>    -               _dl_start_final (inlined)
>                    _dl_start
>                    _start
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/Documentation/perf-inject.txt |   5 +
>   tools/perf/builtin-inject.c              | 128 +++++++++++++++++++++++
>   2 files changed, 133 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
> index c972032f4ca0d248..95dfdf39666efe89 100644
> --- a/tools/perf/Documentation/perf-inject.txt
> +++ b/tools/perf/Documentation/perf-inject.txt
> @@ -109,6 +109,11 @@ include::itrace.txt[]
>   	should be used, and also --buildid-all and --switch-events may be
>   	useful.
>   
> +--convert-callchain::
> +	Parse DWARF callchains and convert them to usual callchains.  This also
> +	discards stack and register data from the samples.  This will lose
> +	inlined callchain entries.
> +
>   :GMEXAMPLECMD: inject
>   :GMEXAMPLESUBCMD:
>   include::guestmount.txt[]
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6080afec537d2178..2a2fcc8e3e9e5fe5 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -122,6 +122,7 @@ struct perf_inject {
>   	bool			in_place_update;
>   	bool			in_place_update_dry_run;
>   	bool			copy_kcore_dir;
> +	bool			convert_callchain;
>   	const char		*input_name;
>   	struct perf_data	output;
>   	u64			bytes_written;
> @@ -133,6 +134,7 @@ struct perf_inject {
>   	struct guest_session	guest_session;
>   	struct strlist		*known_build_ids;
>   	const struct evsel	*mmap_evsel;
> +	struct ip_callchain	*raw_callchain;
>   };
>   
>   struct event_entry {
> @@ -383,6 +385,89 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
>   	return perf_event__repipe_synth(tool, event);
>   }
>   
> +static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
> +						union perf_event *event,
> +						struct perf_sample *sample,
> +						struct evsel *evsel,
> +						struct machine *machine)
> +{
> +	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
> +	struct callchain_cursor *cursor = get_tls_callchain_cursor();
> +	union perf_event *event_copy = (void *)inject->event_copy;
> +	struct callchain_cursor_node *node;
> +	struct thread *thread;
> +	u64 sample_type = evsel->core.attr.sample_type;
> +	u32 sample_size = event->header.size;
> +	u64 i, k;
> +	int ret;
> +
> +	if (event_copy == NULL) {
> +		inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
> +		if (!inject->event_copy)
> +			return -ENOMEM;
> +
> +		event_copy = (void *)inject->event_copy;
> +	}
> +
> +	if (cursor == NULL)
> +		return perf_event__repipe_synth(tool, event);
> +
> +	callchain_cursor_reset(cursor);
> +
> +	thread = machine__find_thread(machine, -1, sample->pid);
> +	if (thread == NULL)
> +		return perf_event__repipe_synth(tool, event);
> +
> +	/* this will parse DWARF using stack and register data */
> +	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
> +					/*parent=*/NULL, /*root_al=*/NULL,
> +					PERF_MAX_STACK_DEPTH);
> +	thread__put(thread);
> +	if (ret != 0)
> +		return perf_event__repipe_synth(tool, event);
> +
> +	/* copy kernel callchain and context entries */
> +	for (i = 0; i < sample->callchain->nr; i++) {
> +		inject->raw_callchain->ips[i] = sample->callchain->ips[i];
> +		if (sample->callchain->ips[i] == PERF_CONTEXT_USER) {
> +			i++;
> +			break;
> +		}
> +	}
> +	if (i == 0 || inject->raw_callchain->ips[i - 1] != PERF_CONTEXT_USER)
> +		inject->raw_callchain->ips[i++] = PERF_CONTEXT_USER;
> +
> +	node = cursor->first;
> +	for (k = 0; k < cursor->nr && i < PERF_MAX_STACK_DEPTH; k++) {
> +		if (node->ms.map && __map__is_kernel(node->ms.map))

This ends up duplicating the kernel stack if ms.map is NULL. Maybe "if 
(machine__kernel_ip(machine, node->ip))" is better because it works with 
only the IP?

> +			/* kernel IPs were added already */;
> +		else if (node->ms.sym && node->ms.sym->inlined)
> +			/* we don't handle inlined symbols */;
> +		else
> +			inject->raw_callchain->ips[i++] = node->ip;
> +
> +		node = node->next;
> +	}
> +
> +	inject->raw_callchain->nr = i;
> +	sample->callchain = inject->raw_callchain;
> +
> +	memcpy(event_copy, event, sizeof(event->header));
> +
> +	/* adjust sample size for stack and regs */
> +	sample_size -= sample->user_stack.size;
> +	sample_size -= (hweight64(evsel->core.attr.sample_regs_user) + 1) * sizeof(u64);

I think you need to make sure sample regs and user_stack are present 
before removing them. If you run this on a file without them you get a 
segfault.

> +	sample_size += (sample->callchain->nr + 1) * sizeof(u64);
> +	event_copy->header.size = sample_size;
> +
> +	/* remove sample_type {STACK,REGS}_USER for synthesize */
> +	sample_type &= ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
> +
> +	perf_event__synthesize_sample(event_copy, sample_type,
> +				      evsel->core.attr.read_format, sample);
> +	return perf_event__repipe_synth(tool, event_copy);
> +}
> +
>   static struct dso *findnew_dso(int pid, int tid, const char *filename,
>   			       const struct dso_id *id, struct machine *machine)
>   {
> @@ -2270,6 +2355,13 @@ static int __cmd_inject(struct perf_inject *inject)
>   		/* Allow space in the header for guest attributes */
>   		output_data_offset += gs->session->header.data_offset;
>   		output_data_offset = roundup(output_data_offset, 4096);
> +	} else if (inject->convert_callchain) {
> +		inject->tool.sample	= perf_event__convert_sample_callchain;
> +		inject->tool.fork	= perf_event__repipe_fork;
> +		inject->tool.comm	= perf_event__repipe_comm;
> +		inject->tool.exit	= perf_event__repipe_exit;
> +		inject->tool.mmap	= perf_event__repipe_mmap;
> +		inject->tool.mmap2	= perf_event__repipe_mmap2;
>   	}
>   
>   	if (!inject->itrace_synth_opts.set)
> @@ -2322,6 +2414,23 @@ static int __cmd_inject(struct perf_inject *inject)
>   				perf_header__set_feat(&session->header,
>   						      HEADER_BRANCH_STACK);
>   		}
> +
> +		/*
> +		 * The converted data file won't have stack and registers.
> +		 * Update the perf_event_attr to remove them before writing.
> +		 */
> +		if (inject->convert_callchain) {
> +			struct evsel *evsel;
> +
> +			evlist__for_each_entry(session->evlist, evsel) {
> +				evsel__reset_sample_bit(evsel, REGS_USER);
> +				evsel__reset_sample_bit(evsel, STACK_USER);
> +				evsel->core.attr.sample_regs_user = 0;
> +				evsel->core.attr.sample_stack_user = 0;
> +				evsel->core.attr.exclude_callchain_user = 0;
> +			}
> +		}
> +
>   		session->header.data_offset = output_data_offset;
>   		session->header.data_size = inject->bytes_written;
>   		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc,
> @@ -2414,6 +2523,8 @@ int cmd_inject(int argc, const char **argv)
>   		OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "directory",
>   			   "guest mount directory under which every guest os"
>   			   " instance has a subdir"),
> +		OPT_BOOLEAN(0, "convert-callchain", &inject.convert_callchain,
> +			    "Generate callchains using DWARF and drop register/stack data"),
>   		OPT_END()
>   	};
>   	const char * const inject_usage[] = {
> @@ -2429,6 +2540,9 @@ int cmd_inject(int argc, const char **argv)
>   
>   #ifndef HAVE_JITDUMP
>   	set_option_nobuild(options, 'j', "jit", "NO_LIBELF=1", true);
> +#endif
> +#ifndef HAVE_LIBDW_SUPPORT
> +	set_option_nobuild(options, 0, "convert-callchain", "NO_LIBDW=1", true);
>   #endif
>   	argc = parse_options(argc, argv, options, inject_usage, 0);
>   
> @@ -2588,6 +2702,19 @@ int cmd_inject(int argc, const char **argv)
>   		}
>   	}
>   
> +	if (inject.convert_callchain) {
> +		if (inject->output.is_pipe || inject->session->data->is_pipe) {

I get a compilation error here. Some -> should be .

> +			pr_err("--convert-callchain cannot work with pipe\n");
> +			goto out_delete;
> +		}
> +
> +		inject.raw_callchain = calloc(PERF_MAX_STACK_DEPTH, sizeof(u64));
> +		if (inject.raw_callchain == NULL) {
> +			pr_err("callchain allocation failed\n");
> +			goto out_delete;
> +		}
> +	}
> +
>   #ifdef HAVE_JITDUMP
>   	if (inject.jit_mode) {
>   		inject.tool.mmap2	   = perf_event__repipe_mmap2;
> @@ -2618,5 +2745,6 @@ int cmd_inject(int argc, const char **argv)
>   	free(inject.itrace_synth_opts.vm_tm_corr_args);
>   	free(inject.event_copy);
>   	free(inject.guest_session.ev.event_buf);
> +	free(inject.raw_callchain);
>   	return ret;
>   }

