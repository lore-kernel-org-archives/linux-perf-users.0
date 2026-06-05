Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D741FF1C7
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701455; cv=none; b=UOPvzj2IwdM5bwdOhAbvWG/aNKnJVsqHU3ohPqSq4qIke5JN/ahZCSy/LNmzq6jhP1hjkvuC1wEtD2KZKa7eiQ7jgNvrryjp9MKEQIgaz2NAabbFsCzF+sudtbebNFsZD02dyGkcR9Z83J38otcRKpcCyL945G2Zgs1H3FKEoxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701455; c=relaxed/simple;
	bh=lrfBM9ChRFrxQ+Tsaedahfa2iD5HjBVpEdqJPmXV4kE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UKiP18qjg3MPMuulwexCbAYosN9h57p8Yf5lFl2YpbBuXG4H0rRmdfCMC2noGW22bzhv23JEicaFE9W4BYm8+hhf/xONac6cdi91c9ULDxB2GwX0K+3ql1n9xVNDeb34yVujy1Xs8sV/ytKjPu7O1mf788hWY0bFVtbs6J4xGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFr7GEO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFr7GEO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1241B1F00893;
	Fri,  5 Jun 2026 23:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701454;
	bh=+UlpggCtymIX860qKeUzOTLXvNBC7QbNVLQtayNeYy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MFr7GEO6Ra5YxJg/2xJUe+iB0GSWdu6j2EC+8S6fvkUhw2RqcWy9/JkMvx9KXbIgR
	 wXOgYK3YhMbeUNtdNzZwXsS1laIyslfXW+WxeEZNYxy+rmS52hX1BmeToEkPdB5h+r
	 5kOpRTY3MWmNKJP4cf1R0rDtbPIqpj//JoW++Wveik2fNm4/zhZE6DOMYmSEBA7W0c
	 kflS/QUnjrSwkN6mCCg4c17xRQDUJ+AFW6x57Ri+2NXdNMDCiJ7fywTSM5Wuw1PC8m
	 mI8bhOwlEW/pLoCxizZYD7U0YHkrbnUolCIo8sTevyooEfLTrzPHUsj8bS/BqKcmX3
	 FL1ZTqUicxhIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf timechart: Fix memory leaks in draw_wakeups()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605231155.2415760-4-namhyung@kernel.org>
References: <20260605231155.2415760-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:17:33 +0000
Message-Id: <20260605231734.1241B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The modified fallback loop condition `while (c && !from && !to)`=
 prematurely aborts the search for task coordinates if either `from` or `to=
` has already been found.
--

commit 757fad46c9b9ecd50deaba0cc7cc1ec56200ab8e
Author: Namhyung Kim <namhyung@kernel.org>

perf timechart: Fix memory leaks in draw_wakeups()

This commit modifies the fallback coordinate search in draw_wakeups()
to only run when it doesn't have from and to tasks, and ensures c->Y is
set before copying the comm string to fix memory leaks.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index fded4be93de0d..9ac4662ef16e9 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c

[ ... ]

> @@ -1071,12 +1071,12 @@ static void draw_wakeups(struct timechart *tchart)
>  					c =3D c->next;
>  				}
>  				c =3D p->all;
> -				while (c) {
> -					if (p->pid =3D=3D we->waker && !from) {
> +				while (c && !from && !to) {

[Severity: Medium]
Will this condition prematurely abort the search for the second task's
coordinates?

Because the waker and wakee are typically two different PIDs, they are
processed in different iterations of the outer per_pid loop. When the first
one is found, either from or to becomes non-zero.

When the outer loop reaches the second PID, the condition !from && !to
evaluates to false immediately, which skips the fallback coordinate search
entirely for that second task.

Should this condition instead be !from || !to so the loop continues as long
as either coordinate is still missing?

> +					if (c->Y && p->pid =3D=3D we->waker && !from) {
>  						from =3D c->Y;
>  						task_from =3D strdup(c->comm);
>  					}
> -					if (p->pid =3D=3D we->wakee && !to) {
> +					if (c->Y && p->pid =3D=3D we->wakee && !to) {
>  						to =3D c->Y;
>  						task_to =3D strdup(c->comm);
>  					}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605231155.2415=
760-1-namhyung@kernel.org?part=3D3
