Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BE194C96
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805373; cv=none; b=jhv+lGa2444m7PrHSDoD9qYWqzht7IAgeGmfbavkdwoKXysA6eNgXFw1uM3bFxaNzVS3TYLAmkJmon9k3s5JGzRjeAIZhG81o5ipSi5tP1ePxJRpzxlJaoJUnoqsOz9+6skxAZL/Z5pLZ2AywO42ovBEGTMKeJSSE+SIHPO9gGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805373; c=relaxed/simple;
	bh=WMxgBOHAUG8w4LYrm/aBc66H5aAO4WJsPQELaOPo39o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rHLq2VKrgT2kinkHWNQvW8eIa0qLaoeQnSGTarVoZawfPKzuPyH0q2u3elPBYeEKq0grohylpyR/n5fHR2LqoCJ9Lwwb6vYwO7uZktAVeMeL61epVsC+6S8s6Si8HPvPezI1qf8n76bsmUpHIPzx2FTfQudc8Nn+hXA5J3RYfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP/Y0z0V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP/Y0z0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B407C2BCB0;
	Tue, 21 Apr 2026 21:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776805372;
	bh=WMxgBOHAUG8w4LYrm/aBc66H5aAO4WJsPQELaOPo39o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UP/Y0z0VaQIqzeRHl8LI9huaAnjYGbwuUqVdBHxxmco4G0wcXZGZaxI5RwDP3lCdP
	 w3B2TXUT9sJIFZrHwPVOd9Pilr/3v3ytJAiJ9+2Mbuk9JhYD4Nd0dKQzVKTnbk67K0
	 opjBQfJjQQ/D2GYZup32okhC1bG5YS/Olb+OjbSg1HL+1xlws2YP6bhnmBheEiCVAU
	 pFuERIk4vfT5fClM6odFPCGLD0xjgSFXbWMU5ycKCA6vIT+yovFk8Q16BbgukjBV7H
	 wPJcSru8XRQT9qkyobzeebSAYh4O670QD2efbxwttVrrwCCy4SSKQaycJuyeTEqW1d
	 dtRjXgn9V+uuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: Introduce --show-cpu option to display cpu
 id
Reply-To: sashiko@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260421203934.64032-1-atomlin@atomlin.com>
References: <20260421203934.64032-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 21:02:51 +0000
Message-Id: <20260421210252.8B407C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The `--show-cpu` option fails to request the PERF_SAMPLE_CPU att=
ribute and incorrectly uses `%03d` to print a u32, resulting in `[-01]` bei=
ng printed.
- [Medium] The `--show-cpu` feature has no effect on the core events of `pe=
rf trace` (system calls and page faults).
--

commit 85a27484af518bd604f94598d0e741862be09625
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Introduce --show-cpu option to display cpu id

This commit introduces a new "--show-cpu" command-line option to perf trace.
When provided, it extracts the CPU from the perf sample and prints it
alongside the timestamp.

> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -3277,6 +3278,9 @@ static int trace__event_handler(struct trace *trace=
, struct evsel *evsel,
>  	trace__printf_interrupted_entry(trace);
>  	trace__fprintf_tstamp(trace, sample->time, trace->output);
> =20
> +	if (trace->show_cpu)
> +		fprintf(trace->output, "[%03d] ", sample->cpu);
> +

When tracing specific processes using non-tracepoint events,
target__has_cpu() is false and CPU samples might not be recorded. If the CPU
data is missing, evsel__parse_sample() assigns a default value of -1
(0xFFFFFFFF) to the u32 sample->cpu field.

Since %03d is a signed format specifier, will this cause [-01] to be printed
instead of a valid CPU id?

Furthermore, this modifies trace__event_handler(), which processes secondary
events. System calls and page faults, which make up the primary workload of
perf trace, are processed by dedicated handlers like trace__sys_enter(),
trace__sys_exit(), and trace__pgfault().

Because those core handlers format their output prefixes using
trace__fprintf_entry_head(), will --show-cpu silently fail to display CPU
information for the default trace output?

[ ... ]

> @@ -5422,6 +5426,7 @@ int cmd_trace(int argc, const char **argv)
>  	OPT_CALLBACK('m', "mmap-pages", &trace.opts.mmap_pages, "pages",
>  		     "number of mmap data pages", evlist__parse_mmap_pages),
>  	OPT_STRING('u', "uid", &trace.uid_str, "user", "user to profile"),
> +	OPT_BOOLEAN(0, "show-cpu", &trace.show_cpu, "show cpu id"),

Does trace.opts.sample_cpu need to be set to true when --show-cpu is
provided, to ensure the kernel is instructed to actually record the CPU
samples?

>  	OPT_CALLBACK(0, "duration", &trace, "float",
>  		     "show only events with duration > N.M ms",
>  		     trace__set_duration),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421203934.6403=
2-1-atomlin@atomlin.com?part=3D1
