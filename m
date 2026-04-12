Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825638C1F
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775961260; cv=none; b=FNyxpr+2V3prEdVzebX7cTrRi/p0Z0fDUWB9JfGFk1j9v8N5oziiAJinwMcgJC48CBzVHbEEOSXFj5KE0r9qWNuErejhXeLwR4rrvQ22ik2KIZKbX+PhPr5VosvSaCorDqvgpwr7uzPE917dzeYUgwvDDuvYJtToWpVXUgWUE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775961260; c=relaxed/simple;
	bh=ztNl0cIKASoXM29c4o0JcM5KkQ+GDFHE3RToy20oQFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qltl4T3JSEUg7A6mSIhSFvmYWB/n0tVRn/nvwHxW+PN2+FdJXSEXgJhyStRxAboe6rMamuScg/uJR7irNf5xtzlS/jWPq2ctJ7R+GcmOH5v5BIugrXvhUoeoOTICNpYEJnt0urjDQBsWr+MXhPogjvZMuw0RhzzB344KF4KK/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTeCXNN7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTeCXNN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E47C116C6;
	Sun, 12 Apr 2026 02:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775961260;
	bh=ztNl0cIKASoXM29c4o0JcM5KkQ+GDFHE3RToy20oQFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CTeCXNN7qVO2kEFTqBRjlk2LA3VJ+pmbBC/U+yX+8SEAcHZ3770fzcz//hGAm4gtp
	 JYmg1qSFCyBydxHVLnQ+NLkqNIs3TDloZCgNm+CDk4ntwkTLQeTXyUndA/gxeXd9Rr
	 lqLg/3Yf0s8/fydv6pV3pu6goUaqYhip5CN6TL2uSRPyyNh9g9AwHRA9YiHnOrpiEo
	 6js/v5xMBHgFHHPwDmIFF7vrxmsNJM/z4a9UhC9fKuj8EPh9QvG0Fqu1cCKJlxtZhg
	 Z6GlPTMV74VzPYnSOGeWnqd8jnv+b99pJpPZhdATLDewL2saPtwuYWa/C3FpeZLcYg
	 ACoFB2uh87UXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/29] perf evsel: Refactor evsel tracepoint sample
 accessors perf_sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260412020833.641177-5-irogers@google.com>
References: <20260412020833.641177-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Apr 2026 02:34:19 +0000
Message-Id: <20260412023420.44E47C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Removal of `strdup` in `sched_work_init` introduces a Use-After-Fr=
ee vulnerability when storing the task name.
--

commit 0d7b6945ae0c6b8ad53d53aacf54fb3b747a99a7
Author: Ian Rogers <irogers@google.com>

perf evsel: Refactor evsel tracepoint sample accessors perf_sample

This commit removes the evsel argument from tracepoint sample accessor
functions, renaming them to reflect that the data is being read directly
from the sample.

Please note that the issue discussed below was resolved in a later commit
upstream, specifically commit 5e8ad46aaa11f37f17084b59fcd84e6b4bbc3d6e
(perf kwork: Fix memory management of kwork_work). It is included here
for completeness regarding this specific patch.

[ ... ]
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index d4bb19ed91b59..8ba5ea201bf94 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
[ ... ]
> @@ -1310,11 +1309,11 @@ static void sched_work_init(struct perf_kwork *kw=
ork __maybe_unused,
>  	work->cpu =3D sample->cpu;
> =20
>  	if (src_type =3D=3D KWORK_TRACE_EXIT) {
> -		work->id =3D evsel__intval(evsel, sample, "prev_pid");
> -		work->name =3D strdup(evsel__strval(evsel, sample, "prev_comm"));
> +		work->id =3D perf_sample__intval(sample, "prev_pid");
> +		work->name =3D perf_sample__strval(sample, "prev_comm");

Does removing the strdup call here leave work->name pointing directly to
the raw data inside the memory mapped ring buffer?

If perf_sample__strval returns a pointer to the sample data, that memory
will be overwritten as new events arrive. When the reporting phase later
iterates over the kwork_work tree, could this result in a use-after-free
and output garbage strings?

>  	} else if (src_type =3D=3D KWORK_TRACE_ENTRY) {
> -		work->id =3D evsel__intval(evsel, sample, "next_pid");
> -		work->name =3D strdup(evsel__strval(evsel, sample, "next_comm"));
> +		work->id =3D perf_sample__intval(sample, "next_pid");
> +		work->name =3D perf_sample__strval(sample, "next_comm");
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260412020833.6411=
77-1-irogers@google.com?part=3D4
