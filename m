Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83158B6B3
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931371; cv=none; b=ID7oPTR4+FoAIvmA8QZQhoC3Eon04K8Kn85XhEuj88MM3QPM9h0hyjLNE0NeTg3iA3h5+k9xDAGeT1ajek5r1h80ONdoVbNLyVhilCZ6v8VNhz5rvyxO/dvVvOvXSDBpJlCNQszoTDQjKnwfJqY4fviLeWa2Kw1KDMTYFYqatCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931371; c=relaxed/simple;
	bh=B4sWK5C76gPF/jsOElZMGs2wHXkje+IR94XsCnSN8Yk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZhKUAZ2qt5qa9AefpsckqPGZ2MkFHvsiraqzLC3clbkODVdDpAeaXGhWFvjw5ADPwnq+r0EZvZxrr9Or/GFmc2togDRd2fxI5l3e1Of54yNQ36+aYl1PsIDiX1IPc9Dfn1u9Ot+OSAOLHRx1yIR8biqvUmXpNJR/BeCQU1WzN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4uvSSB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4uvSSB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1604E1F000FF;
	Tue, 13 Oct 2026 22:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931365;
	bh=B4sWK5C76gPF/jsOElZMGs2wHXkje+IR94XsCnSN8Yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4uvSSB7XizgWgS124GuHsP5b8wuuyITK/hFW+f1Vc2PearqpWI1uiutkBNjHnFCy
	 fA1dVQIva/3DNjy8ht57BGBdanYX8vPteZzt7oxm+vszyCy/gZK1mPuFVsA8JOCvWQ
	 pRPVm6ij6aEWLy2R2859BLu2WgGYRSOKeoIceL7fjVa0cU04qfduDgUStxEyC4HyIO
	 cR/t/dCKA2QK6LBLvIhTvleuLD68M3s4eHj4YQLS/6a9OhWNqouWs4rcN7+QMoMBCV
	 fs1rzCcQ9ZXevVuJCe5yuM+RUfcLnqg9QugH8t2C+FVlEoKutNS8SHorNQz8Lp9MqQ
	 LOsBVFkYO40Zg==
Message-ID: <sashiko-outbox-170591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-5-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:42:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
> builds in tools/perf/Makefile.config, replace the custom lock safety
> macros in tools/perf with the kernel's compiler-context-analysis.h
> annotations (context_lock_struct, __guarded_by, __acquires,
> __acquires_shared, __releases, __releases_shared, __cond_acquires,
> __must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
> __no_context_analysis, and __context_unsafe), and remove the redundant
> macro definitions from tools/perf/util/mutex.h.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D4

