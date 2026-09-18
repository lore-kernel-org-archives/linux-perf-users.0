Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C4365A14
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713719; cv=none; b=V85gog6ZneaeQDQNK+Z5cKQd5/w02y4X+so4UgoStR4/7DlprwM+1bJK8yddRpwxEgYlDfuHLB04FIylnpUslOJW9ZnazGcTrpqPt52KSlxWPGR1bmJSqpTkrff3PaRgethfMkRaK76v/QNUr76rkv9Y2FffCVbgXw/ajm2NRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713719; c=relaxed/simple;
	bh=yQCQdvjMZc+CK+oWJMZXJcGVMg83i6rmKfGzT2aaZvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ggF2jp4ZD+JHqFcn49EKFFnLKdgDSjaLsunb6Z1bmwgAHBuzBsc14z0K2OiZYfUjzSFrfaHIXNb8D+aN176sdbag7US1aiyeZoOnMhHu+2Q4DoGeqVerX4XHjlqXFachYoJUvns7b5tRiESD+bzXXg2Y+tHG1wknH7jp8IGCgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHmjCs4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHmjCs4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6741F00893;
	Fri, 18 Sep 2026 06:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713717;
	bh=gjmQEL6wZHld4SlUtjlaCjzzDoYEgnVdCk2Vh2VSvo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHmjCs4WWPyW3TGiwdT37LCCjWpFDvBuz0FxNLMze6edFy2uEvxrWmfKBiQExGS4r
	 JmJxUF8kDf3FnbzAlfnXh1rwad6j779KUlcITXO8xIPtL3i5iMIOfSYf+opSqFtnBn
	 FjAbLkg+9LfUwwvy/ScVxXAN/XsRVgDvEFbdIRs5XvXSd28FSkjjMMRAgp8znTEAWl
	 G4JHOtX+Jv7zPMtPl8xTjn5Q3FHxOeklCkx3RFBx4Jt4AoxSncIl/mwohzRcFZXKku
	 ZjZwIL5LtrnLZETsKQzqiY/H0VD6RWGLk8Mp4a0rgaPlsRoGoGvl5oZ70kv4jJvzQz
	 YsQi2bJsRkn4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/5] perf trace-event: Report tracepoint format
 errors with NULL and errno
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918063249.2172589-2-irogers@google.com>
References: <20260918063249.2172589-1-irogers@google.com>
 <20260918063249.2172589-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:41:57 +0000
Message-Id: <20260918064157.7C6741F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_event__tp_format() encoded failure with ERR_PTR() while
> trace_event__tp_format_id() returned a plain NULL when tep_find_event()
> found nothing, and tp_format() itself returned NULL when
> tep_parse_format() failed, as its return value was discarded. Callers
> test with IS_ERR(), which NULL does not satisfy, so those two failures
> were taken for success. In syscall__read_info() that leads straight to:
>=20
> 	if (IS_ERR(sc->tp_format)) {
> 		...
> 		return err;
> 	}
> 	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
>=20
> which dereferences NULL when a format file fails to parse.
>=20
> Mixing encoded error pointers with pointers that are compared against
> NULL is what allows that to happen, so drop ERR_PTR() here and report
> failures the way the rest of these paths already expect, by returning
> NULL with errno set. evsel__tp_format() no longer has to translate the
> error back into errno before printing it with %m, and the remaining
> callers become NULL tests.
>=20
> syscall__scnprintf_args() gains back its fallback of printing raw
> arguments: it asked for IS_ERR(sc->tp_format), but syscall__read_info()
> had already replaced the error pointer with NULL, so the branch could
> never be taken.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918063249.2172=
589-1-irogers@google.com?part=3D1

