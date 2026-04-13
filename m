Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CE220F49
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055132; cv=none; b=noy626ENrcESB8f2Oe5sG0A4Q3jQz7okIdpdlGU3IEOpQfqvnoIiNohCsO3RcqrnbSao+O/llVZTreyc+TlgevKRks4DKS5IoZ0HcUDbrcV1/Gm7QO86ugOWN4fmF4+Q+L+z8n2d5UmvyP0OoRBR1kqzvRr/HsYeULtOdUluib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055132; c=relaxed/simple;
	bh=D3NpVrCL+054D9h56LODERq+8oGnUo5rhD9kJL0RfU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l+gZ8P4Ca4STBcI6wFu0m31U61zCNeEJykb//S5fImpgeoGUGhBle7mOGCUERb/iD3nOhbvI5HkEx4l+f+NXAIyVb5UAkHoBatQVBNIR/VTfluh6nQHyd/9+VcLPfyyoQJ3ykXIUoiLIACSk56CcfBIafOf2r2N5pWAZcPxXjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1eoptgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1eoptgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04AEC116C6;
	Mon, 13 Apr 2026 04:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776055131;
	bh=D3NpVrCL+054D9h56LODERq+8oGnUo5rhD9kJL0RfU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Y1eoptgD92i3EZUXQgkarLcDmgwugJSn3z1ryHj3FOfIq+bYf3RkgnrynF+va8ZFa
	 d/9IWSNG98kix3OO51Rx4ToNSRM676T0Z+GUsybknxqYa6AzWisQAVNSUMR6rJJnOD
	 xK16IdA93uT6HysHiZqy4lIu+LY2zvr2+MQ6KB1XMpdQF2Jzylm/ItJJRqSVYLXaDV
	 aIp9L+mq6yz/4Jlqf0CG3qFChZr1WL/n/jI+tDmyLH30XVORc2GrA66dwlW3IFcuA8
	 nWxAXPsTdWRzc4ELokPP3of2oikBeDrcdq0mrjEi4iLSh72lsRFucDhJHjftRHuDyS
	 wPzOsQtgldpxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 16/33] perf sched: Don't pass evsel with sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-17-irogers@google.com>
References: <20260413041143.1736055-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 04:38:51 +0000
Message-Id: <20260413043851.D04AEC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] process_sched_switch_event() accesses the `sched->curr_pid` array =
using `sample->cpu` without verifying it against MAX_CPUS.
--

commit f56857eae8b9831a72ae998ca1a45fc0585d8ad9
Author: Ian Rogers <irogers@google.com>

perf sched: Don't pass evsel with sample

This patch simplifies the event handler signatures in perf sched by
removing the evsel argument. The sample structure already contains a
pointer to the evsel, making it unnecessary to pass both.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index aea14bff7e61c..45439e2af8ffa 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

>  static int process_sched_switch_event(const struct perf_tool *tool,
> -				      struct evsel *evsel,
>  				      struct perf_sample *sample,
>  				      struct machine *machine)
>  {

[ ... ]

>  	if (sched->tp_handler->switch_event)
> -		err =3D sched->tp_handler->switch_event(sched, evsel, sample, machine);
> +		err =3D sched->tp_handler->switch_event(sched, sample, machine);
> =20
>  	sched->curr_pid[this_cpu] =3D next_pid;

Can an out-of-bounds access occur here if a corrupted or malicious perf.data
file supplies an arbitrary value for sample->cpu?=20

This is not a new issue introduced by this patch, but since sched->curr_pid
is sized to MAX_CPUS (4096), an unchecked this_cpu value allows arbitrary
memory reads and writes when parsing untrusted files.

It looks like this is addressed in the later commit "perf sched: Bounds
check CPU in sched switch events" in this patch series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D16
