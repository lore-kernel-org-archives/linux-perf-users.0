Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0D384CE9
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270506; cv=none; b=PooXhBPWNOaknV/oQFYts89ylcjxAepPnFJTCyNlyIcLRxEAcKRIC7tzZx1j3PFXYZJf96jSIb/GDCqFVcx8B/b42RoTKSLOnC6LfaKRV5nz2b/T5ajhwFEzmGw1H1u8ZsO8n/Ki6zRQ/7tiwMDTqrRWyslL2cZ86G7UrEdDyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270506; c=relaxed/simple;
	bh=4oVIbh8MsiM60SAD/XNLarba3u0cKeCQib01Z60SRYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TEeSYTc+k+nNtt/0IL8rduPSyqmh4TteT7xMUkezWZZpd+oeZjevgTZehDQoLQl3DX6Oly9eMtmvuEYJ61DMBVc5cbasmRG/h8XndOSavHmbpidUm09FgQCJmamjusr/GzA7eL9reWIFSrFMbvRTUfi4f7pyryP+jpREZHLiCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA1OLhFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA1OLhFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11301F000FF;
	Sun, 13 Sep 2026 03:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270505;
	bh=quD1HlZJF5sX63BY0UfrFYGy98izX0catDUmdE3Kz4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BA1OLhFZZw4+l9ibdrkfm/QnoCV1BpS5WYjwePzLLMRjeSPuIYCp1om7DZ7+hjW31
	 eSLYo/renyA+A5FIIxj1vYjIy9A6tk7M9UN9nzIB78+xfUyaGiBBVvdbWne7YXPJzJ
	 dbtWsM5BeA8cxfO2Gmy0tiFUNjnvwYmbV+ReDzbflQtfjk0k++kBUXg6Lb/xKd/njR
	 99rSgltM2OVapWEQLFH4xYB3Ol2ECMpmUevasrgdBPMLPQwzXvrQiaE4WG79t3WfKH
	 O4nfTZG7hhm1XqQcYAWezcpE26XuIlFBBmT3U6I9GTRESiyjeB6ZsA4Q6wZBmKzfi7
	 S4OxeKq1b3wgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913032632.116277-6-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
 <20260913032632.116277-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:35:04 +0000
Message-Id: <20260913033504.D11301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Stack misalignment in stdio progress tracking when STDIO_PROGRES=
S__MAX_DEPTH is exceeded.
--

commit 79112b3dd0e87e5c48cc7db61f548c4ae162bb0b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf report: Add --progress option

This commit adds a --progress option to perf report that introduces a stdio
backend for ui_progress updates. It allows for progress tracking during eve=
nt
processing, merging, and sorting phases by keeping track of nested phases.

> diff --git a/tools/perf/ui/stdio/progress.c b/tools/perf/ui/stdio/progres=
s.c
> new file mode 100644
> index 0000000000000..1d1eddd192777
> --- /dev/null
> +++ b/tools/perf/ui/stdio/progress.c

[ ... ]

> +static void stdio_progress__finish(void);
> +
> +static void __stdio_progress__init(struct ui_progress *p)
> +{
> +	/*
> +	 * The default step (total / 16) is meant for the TUI progress
> +	 * bar, for stdio, where a percentage is printed, use 1% steps.
> +	 */
> +	p->next =3D p->step =3D p->total / 100 ?: 1;
> +
> +	if (stdio_progress__depth =3D=3D STDIO_PROGRESS__MAX_DEPTH) {
> +		pr_warning("progress phases nested deeper than %d, completing %s\n",
> +			   STDIO_PROGRESS__MAX_DEPTH,
> +			   stdio_progress__stack[stdio_progress__depth - 1].p->title);
> +		stdio_progress__finish();
> +	}

[Severity: Medium]
Does this forceful drop cause stack misalignment for the unwinding callers?

When STDIO_PROGRESS__MAX_DEPTH is exceeded, this forcefully calls
stdio_progress__finish(). However, because the caller isn't informed that i=
ts
progress phase was dropped, its subsequent call to ui_progress__finish() wi=
ll
inadvertently pop the wrong phase (the one just below it on the stack).

Could this state desynchronization lead to incorrect progress reporting and
premature completion of parent phases?

> +
> +	/* Start a nested phase in a line of its own. */
> +	if (stdio_progress__depth && stdio_progress__is_tty)
> +		fputc('\n', stderr);
> +
> +	stdio_progress__stack[stdio_progress__depth++] =3D
> +		(struct stdio_progress_phase) {
> +			.p =3D p,
> +			.last_printed =3D 0,
> +			.last_len =3D 0,
> +		};
> +
> +	stdio_progress__print_phase(&stdio_progress__stack[stdio_progress__dept=
h - 1],
> +				    p->curr);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913032632.1162=
77-1-acme@kernel.org?part=3D5
