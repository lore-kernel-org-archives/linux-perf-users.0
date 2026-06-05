Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5C48BD52
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646731; cv=none; b=IJZiZw8i3XpfTsToAbupafRSg5yqma45cIczKCmdPZLXqpG2nongBjNcLdL18bLf06yGjo9wrnzgLrCBnrpirGh2BrOdFiyyo5S8oiKNU+M6xejt42vEQTaaWyOG5Yk2fI+2OzHGBMh1BIMn0BceEPVF/CAgnHH4F555eME7Jjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646731; c=relaxed/simple;
	bh=610M2/28jfUhIBb6/5UvkOiRRzRA2PLayZH9PmxY9SU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YUKHlWgFMvzUN9h3JZDX9UvDqcdQXwgqj3GyCn5iNT3w6KH2IKA6EVTeOJUKKrj5qLo22b0GV1NLjhZ32EBMNe6u69sQ4jEdVkME2jK/yBH4DFhcPcWUYykfDmimSmM2MGsyTQdumulgC1nP6jMkXp63HhlG2uxMyPAvcB78VBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx+a63V5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx+a63V5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0847F1F00893;
	Fri,  5 Jun 2026 08:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646730;
	bh=G2xtDHEARgYzqIbVqPgtYjFc0zWTs4NVlxuNtNGdTHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wx+a63V5sntSjSQ4Rf1Ahg4iSBTIlNCezMQkAAc9o+aKtktY1UGKr0JsobQ4u+yYb
	 3BhVh+xl2rprQGfFblLbSwMI2p2C+qWCz1nMzWi18RrEMmqgjYODvwcI0uybAd9sRf
	 P8dXWqcRoqqbTMqi9TTzFq3t2JnXOj+Tk569wRmv/uYqKUdy2SsRVi7zub+EvJI/o0
	 vaeKTvK7xnv220hR2k3n+kzdvHsuAnJt+7KFUj/BDeHp2m5bMYrou6fOSD/wxAzENh
	 lIiAuwu+nByv8k/DLkwXgObwopKLXIlNvkuBHhmIi8Vr/ZYapjmpWe0GM+GKvzRArp
	 2OJP5GurTp5jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/19] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-15-irogers@google.com>
References: <20260605074003.1730715-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:05:29 +0000
Message-Id: <20260605080530.0847F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The Python `pyrf_session` wrapper fails to register `.attr` and `.=
feature` callbacks for pipe mode, silently dropping `PERF_RECORD_HEADER_ATT=
R` events and breaking `evsel` lookup.
--

commit 9b2beeec32b11c94e99c583602b25a4f6100962e
Author: Ian Rogers <irogers@google.com>

perf python: Extend API for stat events in python.c

This commit adds stat information to the perf python session API. It
provides new callbacks and Python objects to map stat events from the
event stream.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -3573,8 +3738,13 @@ static PyObject *pyrf_session__new(PyTypeObject *t=
ype, PyObject *args, PyObject
>  	} while (0)
> =20
>  	ADD_TOOL(sample);
> +	ADD_TOOL(stat);
>  	#undef ADD_TOOL
> =20
> +	if (stat)
> +		psession->tool.stat_round =3D pyrf_session_tool__stat_round;
> +
> +
>  	psession->tool.comm		=3D perf_event__process_comm;
>  	psession->tool.mmap		=3D perf_event__process_mmap;
>  	psession->tool.mmap2            =3D perf_event__process_mmap2;

[Severity: High]
Will this configuration properly handle evsel population in pipe mode?

Because psession->tool.attr and psession->tool.feature are not assigned
handlers here, they appear to remain as stubs. Without processing
PERF_RECORD_HEADER_ATTR and PERF_RECORD_HEADER_FEATURE events from the
pipe stream, won't session->evlist remain unpopulated?

If that happens, won't evlist__id2evsel() return NULL when processing
the newly added PERF_RECORD_STAT events, resulting in an "unknown" name
for the stat records?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D14
