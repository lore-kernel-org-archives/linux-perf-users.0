Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BB4503EF
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663855; cv=none; b=bt3XvAIln4CJLBYpiEBA+y7m35Ejwz5DxSooGY9pau8rpiSkv5LD6rwIB71+jlk9yp0XuCAkwpi2SH2UgOPphclAluRdUcpscTdd98V02mdWBSlgRyFiDrgFx494v2t5npCU/yRN/y7v0voZw88WlG5rknouND4+3tXxOQaprGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663855; c=relaxed/simple;
	bh=seRvELYdzBnXDnNsufFZaeImN1/CjC9Jo7qR5m4VXU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M6kc87PlK+aa9augnZ8QBtovE2F/ISGAYOyPU3R8xsDu4FyAsp7v16GgKLFBxCfwT0DqvFfQH8sVbZ3qAT9Ilt7+0EDEVx7nXO1MgGRsjmJrj3q/ZIg1U+OTcI6GHiZCJ5IF9P/fChPkDtpzEWlrjrdP0egZEDZL4VFQf2vKO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAd/R4XQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAd/R4XQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3871F000FF;
	Tue, 29 Sep 2026 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663853;
	bh=s6PLqorQLG/XD5EBXz9V66EaAx4Fr36ucKdAkXCFrow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAd/R4XQBoXnMn3UAmrIXiAqzkdBArx+A9C3eSSAXMd5rBEzz9goToc5uiiy6zYnp
	 x15iJ6CcTVmVD45k2Kyv41k9nov1W4y24XYV2em4l9CwHCOsyHWbP3hNyMG5aE6GIG
	 I68F/rnhjugsP7HauEXMEH9+cwagATbmAr5gkv/IEuRlN6733696XmWwdXJCLCQkJV
	 wToyKBBnlTksmILQMdP/56YF82sUCRM16H9pQa6CF36Y8Ch9uYkCizcfInZhk46EO8
	 Z6p/z083jY1jLN7+ZJycaBqEq4YkwekG086PRrqwZPa20k49UQie6RENlaQmY0yAjh
	 rbx4AJBAYMCgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] perf python sctop: Fix offline interval printing
 and test flakiness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929062937.374137-3-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929062937.374137-1-irogers@google.com>
 <20260929062937.374137-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:37:33 +0000
Message-Id: <20260929063733.BB3871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In sctop.py:
> - If an earlier interval elapsed and printed an empty table before the
>   target comm ('sleep') executed any syscalls, analyzer.printed became
>   True and the final partial interval containing the target comm's
>   syscalls was never flushed at EOF. Flush print_current_totals() in
>   finally when analyzer.syscalls is non-empty as well as when nothing
>   has been printed yet.
> - Initialize analyzer.e_machine after creating perf.session rather than
>   when session is still None.
>=20
> In test_sctop_python.sh:
> - Use a private temporary directory via 'mktemp -d'.
> - Drop '-a' and pass '-B -N --no-bpf-event' to 'perf record', and sleep
>   briefly in the subshell ('sh -c "sleep 0.1; sleep 0.05"') with a
>   bounded retry loop so 'sleep's PERF_RECORD_COMM and sys_enter events
>   are reliably captured under heavy load.
>=20
> Fixes: b83f0bacf5e4 ("perf python: Port sctop to perf module")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929062937.3741=
37-1-irogers@google.com?part=3D2

