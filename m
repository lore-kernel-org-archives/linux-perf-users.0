Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E30D531
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776056482; cv=none; b=Z10qOZq3msTmF4d7+yxLMOlOR+fFLY1/u58Rze1CK0X1WUsGAkvQVpQtItLxz0kDP92i78Gx+O0g05A5MNniOn3vGE0oGiITi9LEMIh5zWD2kHU7yiNz1S73x9KR7tFn6IK6I8g6H+0uShwnIMARqB55fuzUPIQF55uk3Vhk0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776056482; c=relaxed/simple;
	bh=P8Xl1XktRfNOV68cxnXcAkUpVUu6/vqL26a/mwgO6mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qouqhVZGf2169h8dxK/4dMTq4qVA5Up8k90C7f1n7Xk0SDADQ3KQxsbZyzuoASaq7YYvDKZNHzHZDoodcYrxfACHJB5PxOSdwKu0wZZMXAb459srX501cvKpq0VWXG6w74ljwv3XE4HfZ26MBsQ42soxdQ0LscbrSXhUOUW9ClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv8FZdUF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv8FZdUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF41C116C6;
	Mon, 13 Apr 2026 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776056481;
	bh=P8Xl1XktRfNOV68cxnXcAkUpVUu6/vqL26a/mwgO6mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Dv8FZdUFY95jASLfBP3lp9Z+cIYbwtWN4s5VvvDUfJhnYiYmWKIcEOdCZYlysBsZW
	 6O1/C/wwrQryVayqEdwaLWKmCrBOC8cWrS6pxoNhmrt+ZV5WKhcPVsMi0ey7RJA3A7
	 Tm5v3VIflwTC+9IEmCcAbzG2z+MMb7SxPHBpFRdbqOqjbt/GUTETpm9bMyw+fQUNzT
	 3bat27F7afvXv/H//7zyFIakjsEC/Zcx0Spu3lkcm+1NvNr+LahvWJXxVBt0hLxJfF
	 1hw+o+1KRs9jj6s3o2TcH7HeQWVJ7ELY3pcxpciVuBuj6ti4PLUid33U4h4hYUWytQ
	 uT2jwWfOHWJ2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 30/33] perf timechart: Bounds check CPU
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-31-irogers@google.com>
References: <20260413041143.1736055-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 05:01:21 +0000
Message-Id: <20260413050121.CDF41C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Returning -1 for out-of-bounds CPUs aborts trace processing enti=
rely instead of gracefully skipping the sample.
--

commit 36a79d2c9327a8724476c894c099eea3a4e3fced
Author: Ian Rogers <irogers@google.com>

perf timechart: Bounds check CPU

This commit adds bounds checks for the CPU ID in various sample processing
functions in the timechart tool to prevent out-of-bounds memory accesses.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 64f69bd67c6b7..64903b54e8a73 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -607,6 +607,10 @@ process_sample_cpu_idle(struct timechart *tchart __m=
aybe_unused,
>  	u32 state  =3D perf_sample__intval(sample, "state");
>  	u32 cpu_id =3D perf_sample__intval(sample, "cpu_id");
> =20
> +	if (cpu_id >=3D MAX_CPUS) {
> +		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
> +		return -1;

Does returning -1 here abort the entire trace processing?

These handlers are called via evsel->handler() during event processing.
Returning a negative value from a tracepoint handler typically propagates up
and causes the perf session to immediately stop parsing the trace file.

Would it be better to return 0 here to gracefully skip the out-of-bounds
sample, allowing the rest of the trace to be processed?

> +	}
>  	if (state =3D=3D (u32)PWR_EVENT_EXIT)
>  		c_state_end(tchart, cpu_id, sample->time);
>  	else

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D30
