Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD21FCF41
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688067; cv=none; b=HkQ3Q5vlmbcClUA1QxbfiHwBBjOhYepiu28ZAKKgT9HpbJr6JEzwmDERdty8O0UVmQ0f+co0a7v1KJ9nrriErhqvBKC6EpRqtICIlRD4afm+oc5z1YnKgQbjpDfI2X8SzK7HhguzFnzoCFpsPLmXtv4U7vsyd/NVVKggaUqzhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688067; c=relaxed/simple;
	bh=liNJduuwaay9kRe019dEI3nenPtNEgtRT+r2G0aBay4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sn0sQo6mIrCWVn3YqayRUqNuawwgEuxMDTwCo/LpX1a+21SatpmhE0QE0pXoHN/0eRttn75jAMsqYccSAbIp6/1SJ3VzkzwraIqzAsWBTAgC2krAvyBy3PC2xVgVrEJMiqq0F2OvsueZpq4hKUNqzLE5wAC5QHFw6dXLeFuuLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ltf0tBdJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ltf0tBdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A97C1F00893;
	Fri,  5 Jun 2026 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688066;
	bh=ZQWZ8jaNAC4u+NOj3buyx2RUkq/ZiBA8BnawL/p4uk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ltf0tBdJ8y08uF10ELU8+lY9sNlBYMqdKhmI1ngt8Gzra1giPKJRU4ICWO9oijstO
	 qT9UdxvlYtP54CetAi2VGJUmRcrhYfN6LAHoPs7yOwrYCOizW8IcMGMVf6TC37s8sj
	 wQMiBvTXcP0+I60C+sVKDjZVc0tax6Hda4GCgtdxP4JIzX7S6Cl5knwnQvItYlD8gg
	 s4dEWf4yEeVsjcoCPapzT7XSC6tn0oM7KSVnZMSvexIahd6cCv/WPMtFtxS9Mq4cjB
	 fekLGkhzJrm7BDNH5GMLLy7bMQltKFpXIMW6jKPrDGvK5vQIMudjsZ92WRjgM8QgMF
	 tBQbr301sDXZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/19] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-15-irogers@google.com>
References: <20260605191500.2477026-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:34:25 +0000
Message-Id: <20260605193426.0A97C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The Python callback for `stat` events is unconditionally overwri=
tten by the default C handler, rendering the custom Python callback complet=
ely inactive.
--

commit cbc98fa452fc586a169f4af327209522a8d370d7
Author: Ian Rogers <irogers@google.com>

perf python: Extend API for stat events in python.c

This commit extends the perf Python API by adding stat information to the
session and providing callbacks for stat events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index d8296d4d17d86..96694360c9787 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -3466,8 +3631,13 @@ static PyObject *pyrf_session__new(PyTypeObject *t=
ype, PyObject *args, PyObject
>  	} while (0)
> =20
>  	ADD_TOOL(sample);
> +	ADD_TOOL(stat);

[Severity: Medium]
Does this ADD_TOOL(stat) assignment get overwritten later in this function?

Looking further down in pyrf_session__new(), the tool configuration
unconditionally assigns the default C handler:

    psession->tool.stat =3D perf_event__process_stat_event;

Will this overwrite the pyrf_session_tool__stat callback set up by
ADD_TOOL(), preventing the custom Python stat event handler from ever
being executed?

>  	#undef ADD_TOOL
> =20
> +	if (stat)
> +		psession->tool.stat_round =3D pyrf_session_tool__stat_round;
> +
> +
>  	psession->tool.comm		=3D perf_event__process_comm;
>  	psession->tool.mmap		=3D perf_event__process_mmap;
>  	psession->tool.mmap2            =3D perf_event__process_mmap2;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D14
