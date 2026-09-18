Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067134216C
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742791; cv=none; b=N4+TScZoYKDDni7haOvbu8scOqnZAJ3vBua/1sFeDSXVlclzi6z23wWLeZHD9I9FguOJq1sNnDNcELcIMceo/G2EOzd8OSJcxxEdkFuT3AJXEcn4ew88ehBhR09cKy5v0pUiE+3eTSuMR/MpSwvq7Gf3+vXReQawGVqPvdDcKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742791; c=relaxed/simple;
	bh=pbWU5H4elS8DPeePDcaYTGewxP8E2XEwfZPHOn2Q9aY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zmyk22OVUGZcM63jcbG1NkrHTm3X+jxhYrzdHxmW5OpdvCwIsnA9QpfhOqLslqGAvWnVWN1srqnpDwSY+LzHVsIwCxHDedweSkuhcFvvpXgGlwgt/dYwrlpKfoLBryBt/Bkn+7z595yRF8vKFVVGIbFS0XUGSnSJGNdV+AQPzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMNjx5ux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMNjx5ux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC021F000FF;
	Fri, 18 Sep 2026 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742789;
	bh=pbWU5H4elS8DPeePDcaYTGewxP8E2XEwfZPHOn2Q9aY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMNjx5uxGxdTzvy1qC+/IADc3w4RAJ+oWSwVAsl1Pgb/tJuv/u14m6BJ/ba3aaAua
	 iBL6uzmGQkyVIvkRNeCSGi2YI5WRV6QS8kOAqWQr29qBqnXVxNpJLnmTgl0poDpAT9
	 YcH9NsKYAkIGgyCL7KPJMlyIuRgvjgOOx+tPUcKB5rvWew5TmJI1EtpeVFKNkzdcMj
	 GCzojNAiJvg/dzJRVfhFFImfz5byElWaNcgzu25xGvnYso74zOgV7kIX/Pn4w05xj+
	 frwLh06DiZt/y9LyxdK5bDdh9ULlxzcMgAOn3Cc0xVw+LGjC9NJ/q2jtEHvlzhxEjI
	 BLXD6vBOhGxfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/16] perf test trace_summary: Improve error
 diagnostics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-14-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:46:29 +0000
Message-Id: <20260918144629.6BC021F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When pattern matching fails in test_perf_trace(), print the command
> that failed along with the actual match count, the matching lines
> found, and the last 20 lines of output to aid debugging.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D13

