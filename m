Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F3263F4A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984133; cv=none; b=f+kF+hhgyhIlgU7J366fkE8smgvASwgBB7gu6MuLyeH284hWhsmq4L88eCnGZjKwDsKW4iakfAoaX4Gt1rt0456ndjVqSIY91S8q6n7AVpuQK5pWS8tvKuF4pRanDFVHgEnwO2YLiv1uJ6MpKNC6drjYY4mW56ydkawLefJDH08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984133; c=relaxed/simple;
	bh=YpDN8GQ4p10JL7SVRSuVuJ1L1tx+s5Bbs0lklxBrez4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cWxxYwOu+dhTkEFmw0/P8HRvNCAq4pxbsRATHvzy5iUzsMd2ICeT3B9lQlQdmWgpp7LnFucjkiSnt5d3NwJrtl8dUuk4rwamw1IOWpWQiLxgwTSmv1/YOE1CJi0k1TA8XixQBARXEDceoNHJVZghkyYlvq+/hGsSIIg980j/zBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4EEFLZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4EEFLZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9B5C2BCAF;
	Thu, 23 Apr 2026 22:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776984133;
	bh=YpDN8GQ4p10JL7SVRSuVuJ1L1tx+s5Bbs0lklxBrez4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=o4EEFLZt3SbaIVIzAHPTHD9e8NuV+4vkWQhAnPUkCymHvk4OuvhPc6aQFYmx4XTPn
	 vUGxZsH1VO2tb2R+zTPFCNod3+ZSv4Zo6wABMoVh+vplMHLvSy/7ogeayYTtAxB8W0
	 zeXftPvrm/vsaylIYGeWVX+ai3UN8tccylW7jj6TUlIapswty7K4W6chNDzo6DP4fQ
	 HjxFIS6aM2XsomqJGpfVVL4GB0kc4o2N37EVu9inOKSRLCxx3UZqqS6WYqNpXAQOye
	 cskd4O3+6kHOIZLy5NzzJJL8dbahNyvi0jaHGymSLL959THFTPrIvd75kbN9CeUnUE
	 OJHdlAzl9+xhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf trace: Introduce --show-cpu option to display
 cpu id
Reply-To: sashiko@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423192445.131351-1-atomlin@atomlin.com>
References: <20260423192445.131351-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 22:42:12 +0000
Message-Id: <20260423224212.DF9B5C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Hardcoded CPU 0 misattributes interrupted syscalls.
- [Medium] Tautological check on unsigned integer and format string mismatc=
h.
--

commit 1c192dba8ca61a6516bab340989a37ca856bfece
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Introduce --show-cpu option to display cpu id

This commit adds a new --show-cpu command-line option to perf trace.=20
When enabled, it extracts the CPU ID from the perf sample and includes it=20
in the trace output immediately following the timestamp.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 311d9da9896a41..264e4762ea28d2 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> +static size_t trace__fprintf_cpu(u32 cpu, FILE *fp)
> +{
> +	size_t printed =3D 0;
> +
> +	if (cpu >=3D 0)

Since cpu is an unsigned 32-bit integer (u32), is this comparison always
true? This might trigger a compiler warning for tautological comparisons.

> +		printed +=3D fprintf(fp, "[%03d] ", cpu);

Given that cpu is unsigned, should this use the %03u format specifier
instead of %03d to avoid a format signedness mismatch?

> +
> +	return printed;
> +}

[ ... ]

> @@ -2704,7 +2729,9 @@ static int trace__printf_interrupted_entry(struct t=
race *trace)
>  	if (!ttrace->entry_pending)
>  		return 0;
> =20
> -	printed  =3D trace__fprintf_entry_head(trace, trace->current, 0, false,=
 ttrace->entry_time, trace->output);
> +	printed =3D trace__fprintf_entry_head(trace, trace->current, 0, false,
> +					    ttrace->entry_time, 0,
> +					    trace->output);

Does passing a hardcoded 0 for the cpu argument cause all interrupted events
to be incorrectly attributed to CPU 0 when the --show-cpu option is enabled=
?=20

If the actual entry CPU isn't saved in struct thread_trace, would it be
better to pass (u32)-1 here so the CPU printout is properly omitted,
matching the check inside trace__fprintf_entry_head()?

[ ... ]

> @@ -3277,6 +3308,9 @@ static int trace__event_handler(struct trace *trace=
, struct evsel *evsel,
>  	trace__printf_interrupted_entry(trace);
>  	trace__fprintf_tstamp(trace, sample->time, trace->output);
> =20
> +	if (trace->show_cpu && sample->cpu !=3D (u32)-1)
> +		fprintf(trace->output, "[%03d] ", sample->cpu);

Similar to the function above, should this use %03u since sample->cpu is
an unsigned integer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423192445.1313=
51-1-atomlin@atomlin.com?part=3D1
