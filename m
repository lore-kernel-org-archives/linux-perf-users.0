Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651C370ACD
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924366; cv=none; b=kcWToiya09RjOgl3aE8SsG55rVhtOI4aN78yd7MOSkrwEF+1xHIoORGs0PYhhLmHJfy5vZgIGUSGAV25ED12H3oocHMzWMBp1yzqAYS98UqOCgGHW30qToYHMevmiG6aySk39BasGo/gGWZlQtn1WWXBUKBTwCC3se+jCQmKfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924366; c=relaxed/simple;
	bh=W11GpjkALUPTPIeTknwEJ+0UXl7qzBqZWfZ4hHvBNZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHI7qb3JB5IZ10acupmwEF8n1keo2O/mVmDba6hfr8uGMDLbZNmpO84sRzwEU0zPrbVjVjZuG7TI28htmy3SVN1N5FjHv6Ev+7irSFpBtIM7nbvDyQA5uN4cl0JF1XuuNcmnDiO6FR5aOt8UNlrFIW2XHeUuCIYbZFD2mTz+Dng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtzjw0Xb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtzjw0Xb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06BF1F00893;
	Mon,  8 Jun 2026 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924363;
	bh=+WyrNnzJha8dwIVi8gSaeixwfwgM276eo6LBYbz250Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jtzjw0Xbf09DH7+/cKe5Am9+9b2FpJPFCkWEF06T3s64bhiDuIxHtYlZNiyjJhcpN
	 AjLRiFEFyVVWyx7Osi5zmw0vOFoBSdAt5qWwClHlO5ZNwnTA+aEdcVtbTgzV/4LpxM
	 /MPhGxKdktxfyStvMFo/JYpajsZOtb4Sr4k3c0XNMDxZzJDjoJ7ZO2qPZUbmwJ2EJH
	 898vBCL2EAVHa6/p1KCjFSlKYvGZkGEj1u86xGJiE68Qu/VW2MPqPwSWmOf6HwKe1R
	 Cj9If+BKY/ZMg29aT6zbfb+dArz612NGB/O7VHFWhv5ZvfULNXXpG3qhQPKDMY8DiW
	 4qEdgiAIsqQCA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] perf data: Add --to-trace-dat option for
 converting perf.data tracepoint events into trace.dat format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608125951.90425-6-tshah@linux.ibm.com>
References: <20260608125951.90425-6-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 13:12:43 +0000
Message-Id: <20260608131243.C06BF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `trace_convert__perf2dat` tool fails to register required `.at=
tr`, `.feature`, and `.tracing_data` callbacks, breaking pipe mode.
- [High] Accessing unverified `perf_env` field `nr_cpus_online` leads to de=
terministic failure when CPU topology feature is missing.
- [High] Failing `realloc()` in `trace_dat__collect_cpu_event()` leaks memo=
ry and causes a NULL pointer dereference in the cleanup path.
- [Low] Missing semicolon after `return -1` in the `#else` branch inside `c=
md_data_convert`.
--

commit 789bd3d29fe2134b1ed0b9a17d6c674bc7d7db23
Author: Tanushree Shah <tshah@linux.ibm.com>

perf data: Add --to-trace-dat option for converting perf.data tracepoint ev=
ents into trace.dat format
   =20
Add new command-line option to perf data convert for generating
trace.dat output files. Accepts output filename for trace.dat format,
mutually exclusive with --to-ctf and --to-json, and calls
trace_convert__perf2dat() to perform conversion.

> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index 4c08ccb8c06b7..96ccab77456a3 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c

[ ... ]

> @@ -65,16 +72,43 @@ static int cmd_data_convert(int argc, const char **ar=
gv)
[ ... ]
>  #else
> +	#ifdef HAVE_LIBTRACEEVENT
> +	if (!to_json && !trace_dat_output) {
> +		pr_err("You must specify --to-json or --to-trace-dat.\n");
> +		return -1;
> +	}
> +	#else
>  	if (!to_json) {
>  		pr_err("You must specify --to-json.\n");
> -	return -1;
> -}
> +		return -1
> +		}

[Severity: Low]
Is there a missing semicolon here? It looks like this will break compilation
for environments lacking both HAVE_LIBBABELTRACE_SUPPORT and
HAVE_LIBTRACEEVENT.

> +	#endif
> +#endif
> +
> +#ifdef HAVE_LIBTRACEEVENT
> +	if (trace_dat_output)
> +		return trace_convert__perf2dat(input_name ? input_name : "perf.data",
> +					       trace_dat_output, &opts);

[Severity: High]
Does trace_convert__perf2dat() register the required callbacks for pipe mod=
e?

Looking at the tool initialization in trace_convert__perf2dat():

	/* Initialize tool with all required callbacks */
	perf_tool__init(&tc.tool, /*ordered_events=3D*/true);
	tc.tool.sample =3D process_sample_event;

If .attr and .feature are not overridden, won't incoming
perf_event_header_attr and feature events from a pipe be silently dropped,
preventing the creation of evlists/evsels and breaking event processing?

[Severity: High]
How does this code handle missing CPU topology features?

Looking at trace_convert__perf2dat():

		if (trace_dat__init_cpu_buffers(session->header.env.nr_cpus_online) < 0) {

If the feature callback is not registered (like in pipe mode) or the CPU
topology feature wasn't recorded, wouldn't session->header.env.nr_cpus_onli=
ne
remain 0?

If trace_dat__init_cpu_buffers(0) succeeds with 0 elements, won't
trace_dat__collect_cpu_event() later check cpu >=3D trace_dat_nr_cpus (0 >=
=3D 0)
and return -EINVAL, causing process_sample_event to return -ENOMEM and abort
the conversion?

[Severity: High]
Is it possible for a reallocation failure to cause a memory leak and
subsequent NULL pointer dereference?

Looking at trace_dat__collect_cpu_event():

		cpu_events->events   =3D realloc(cpu_events->events,
				       cpu_events->capacity * sizeof(*cpu_events->events));
		if (!cpu_events->events)
			return -ENOMEM;

If realloc fails, doesn't it overwrite cpu_events->events with NULL, leaking
the old array?

Furthermore, if this returns -ENOMEM and cascades up to trigger the cleanup
path in trace_dat__free_cpu_buffers():

		for (i =3D 0; i < trace_cpu_data[cpu].count; i++)
			free(trace_cpu_data[cpu].events[i].raw);

Since count was not reset, won't this loop access events[i] and dereference
the NULL pointer?

> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608125951.9042=
5-2-tshah@linux.ibm.com?part=3D4
