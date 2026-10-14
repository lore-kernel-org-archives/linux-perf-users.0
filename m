Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A62D5925
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791952506; cv=none; b=o76/DsY+1Uph8AlVnxO69260oDh++6NQWsFwpOSPkWQ0oq15Gf3zSLuZr5R8WPaUEllLPzg6ZbJKHwOdnrwIss5SjbqnDyD1gS77+kdGNVmz1zVVzGDmOGnEFjwAA5BwlV6rzkUJ336i7GGYMh7U3nYxQdfFAVetsDaSpQlbx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791952506; c=relaxed/simple;
	bh=cygK09XEeoLXZ1+AbLnVXODIlqMoGHZNnUt4r1IiUPw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=szlYmLM/f6fk1X5ZFsg4l503uXlW3hTrupLBxZLLmTrBNoxhK0NU4V/P0fg/HSb/Of+mBP/BSVSInLvXyXayEsdyGCQzh0zUwNlFbAtv/TvfSPDQtH/QIUdiC9+S/ifCENQXYwjVcNrslCoifCLWouN5PUHHRMzZ1jP+0imwUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS4MpoXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS4MpoXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374F41F000FF;
	Wed, 14 Oct 2026 04:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791952505;
	bh=KHoTTs9NZP1R9q2zhdrxsL3LeLkarbGB1xffLAm3zm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HS4MpoXuABaXmW5EV7gYatSux9dhpTdSL2w1HjU1COfUDTtssgKQ+6XooLQmiMP23
	 wwk5HANOWVfe5o1IS5qdIBKgPYYTdHoePTKQC9LTBs+OkAHKdZXPqluzIaq4sCHFMs
	 oTXUvSG8Aw/6HQ3bw4IhDoC2S/nB/uLMZxh+5dHNfkmWGxI2ZVtOyUAcYvoAtrLkrk
	 p0prYubkkLt8M+JCrba5i6ZIeT00S2itL1xFQtzPbl8s4znGHFAMRTgn4UJroKoNIm
	 0CRUkSL5GlVOwK368B941J/YQzB4kM5/kXlDeL5JoxRS3u5KKUghnVfa6S+P+lfD28
	 TUThhFix8CVpA==
Message-ID: <sashiko-outbox-170828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf timechart: Add a --live mode to the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014042249.2379829-2-irogers@google.com>
References: <asDHqdVt4CKq_EoL@x2>
 <20261014042249.2379829-1-irogers@google.com>
 <20261014042249.2379829-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 04:35:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing <string.h> inclusion for string functions
--

commit affd0db9a1d96743f8d4a342d96e560618e1bb09
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf timechart: Add a --live mode to the TUI

This commit adds a --live option to perf timechart and ttimechart.py that
runs perf record and displays the events interactively in the TUI.
It limits the display to the most recent window of history and allows
pausing or recording specific workloads.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 9eb335d9db167..d558ea656fe4f 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
[ ... ]
> @@ -2207,13 +2207,24 @@ int cmd_timechart(int argc, const char **argv)
>  		ret =3D -1;
>  		goto out;
>  	}
> +	if (tchart.io_only && (tchart.power_only || tchart.tasks_only)) {
> +		pr_err("-I cannot be used with -P or -T.\n");
> +		ret =3D -1;
> +		goto out;
> +	}
> =20
> -	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
> +	if (!tchart.live && argc && strlen(argv[0]) > 2 && strstarts("record", =
argv[0])) {

[Severity: Low]
Does this file need to explicitly include <string.h> for musl compatibility?
The perf subsystem guide mandates explicit inclusions of POSIX headers for =
libc
functions to ensure the tools can be compiled under musl, which strictly
separates declarations, unlike glibc. Since strlen() and strstarts() are us=
ed
here, should <string.h> be added to the includes at the top of the file?

>  		argc =3D parse_options(argc, argv, timechart_record_options,
>  				     timechart_record_usage,
>  				     PARSE_OPT_STOP_AT_NON_OPTION);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014042249.2379=
829-1-irogers@google.com?part=3D1
