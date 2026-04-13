Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659537F8AB
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058104; cv=none; b=eikvAAcL8KO6xlJ7aSbKitUUitAMeRkp41fZy7JJcFMQwq8O6UfxHc42O8X0H9gfOkyvkeoEPan7FNhMu2QBW5UgIdy3RvWnC8hmxz0rHH4iQsBu17eGPnkXOUTpjmyTflkt/oVBcoIg6skTRDREub63FHTEttWI8ocmne+2Jz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058104; c=relaxed/simple;
	bh=AqMRYFdFodl2VC9vphOq/GPc2yH+wE2rcWcIq/vilYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f8ZRX6OG7galLc3UpadeVTjLoCbdQOfnWNAlpaLUWZZDdzbwf4+eiutt1Nl9iiOBlI828CcySNP8Wdejfgmot0QhVket/vtnRMTYTT0mGxFzBCXA1cIBn55YOXo57PVApZT3SillwQZz3CcUBX/LSTAupXbBstAw8JSZOPdXzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcpZTFkQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcpZTFkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7ADC116C6;
	Mon, 13 Apr 2026 05:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776058103;
	bh=AqMRYFdFodl2VC9vphOq/GPc2yH+wE2rcWcIq/vilYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YcpZTFkQ2S5oUbGaNyX7J9FVQM66A+gI2pIY0pUJIN2wNrzVlTyL8CGgi0p5tbuee
	 YEZreURCW9AJDLwfDa//EdubB/RJD6YkQ7iL+K+J7GIUZTKL6+hqmEfugeBYVl9nep
	 hOejhiTXePoOpvgu6jzu4vzAjpeXgPFvn3KdZGrQyswZTv0AtVEnZzhSnmf69Tbdiy
	 abpt9sNz/1wekiKKFUeK7Ct23+V/LliSA6t2BYdvHWrU+5tFaY1K8UyebF3cm/+hxQ
	 wnDdNvj84YYQhMWJ1cVmJgYdnpa41Io0UJt7YbTxNz1hrCQ8F+W/SsJ/Z0W/0EU+V1
	 ZIkFUPrN6ol+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 29/33] perf sched: Bounds check CPU in sched switch
 events
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-30-irogers@google.com>
References: <20260413041143.1736055-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 05:28:22 +0000
Message-Id: <20260413052823.1C7ADC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Pre-existing Out-of-bounds Heap Read/Write due to BUG_ON() bei=
ng compiled out in release builds.
- [Medium] Warning Flood / Denial of Service due to unconditional pr_warnin=
g() on hot paths.
- [Low] Format Specifier Mismatch for unsigned 32-bit integer.
--

commit 03e249b09fcd7c953cd15a047cd552bcf0dc0135
Author: Ian Rogers <irogers@google.com>

perf sched: Bounds check CPU in sched switch events

This commit adds bounds checking for the CPU index in various perf sched
event handlers to avoid out-of-bound memory accesses.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1791,6 +1791,11 @@ static int process_sched_switch_event(const struct=
 perf_tool *tool,
>  	u32 prev_pid =3D perf_sample__intval(sample, "prev_pid"),
>  	    next_pid =3D perf_sample__intval(sample, "next_pid");
> =20
> +	if (this_cpu < 0 || this_cpu >=3D MAX_CPUS) {
> +		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", this_cpu);

Perf trace files can contain millions of events. If a trace contains many
out-of-bounds events, will this unconditional pr_warning() cause a flood
of messages to stderr and severely degrade performance?

Would it be better to rate-limit the output or use pr_warning_once()
to avoid practically hanging the tool?

[ ... ]

> @@ -1813,6 +1818,11 @@ static int process_sched_runtime_event(const struc=
t perf_tool *tool,
>  {
>  	struct perf_sched *sched =3D container_of(tool, struct perf_sched, tool=
);
> =20
> +	if (sample->cpu >=3D MAX_CPUS) {
> +		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", sample->cp=
u);

Since sample->cpu is an unsigned 32-bit integer, should the format specifier
be %u instead of %d?

If a corrupted trace contains a very large value, %d would print it as a
negative number, leading to confusing diagnostic output.

[ ... ]

While this patch adds proper bounds checking to these event handlers, do
similar out-of-bounds risks remain in latency_switch_event() and
map_switch_event()?

Those functions currently use BUG_ON() for bounds checking:

    BUG_ON(cpu >=3D MAX_CPUS || cpu < 0);

However, in tools/perf/Makefile.config, NDEBUG is defined by default.
Under NDEBUG, BUG_ON() expands to a no-op macro, so the bounds check is
completely stripped in production builds.

The untrusted cpu index is then used directly in those functions:

    sched->cpu_last_switched[cpu] =3D timestamp;

and:

    __test_and_set_bit(this_cpu.cpu, sched->map.comp_cpus_mask);

Could processing a crafted perf.data file lead to out-of-bounds heap
reads and writes due to these compiled-out checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D29
