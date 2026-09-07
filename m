Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5ADB67E;
	Mon,  7 Sep 2026 04:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753873; cv=none; b=qRlEtuAPAXiJSzF9CHzg+6CokeNq8dY4TbeVgV6tuHQ3ZWysLSaGFXbdOM8kwUEvSAkJCeql9ijBmx5VFZedzy23K+QqXPpdp8HvWLaOewfPSZDIRsRNdYd3m6dLaDW/P9d3PYeT2DRc6KH9FMOzVzVsnksLhNonTlTwfcfm+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753873; c=relaxed/simple;
	bh=Zhv8pThYNAznZKr5u9Dd20m7h2r71l6tbZSsdh9OLqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nP052m0KkJVsQSRj4yGVZPidO9YWrEVbQG+kgKEKFb+dVVvi7XtUHk9ZhhDNQz5QHiBWwMbD6abdyAt+rKy7MeTBRp0exR/SXwAlUy6egD6eAovF68HsiFbtAaP/yscEiVItZkkGdMbv+m5tMJkjqpp4R3TyWf8TTJHtG5J7wLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfzOAVvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfzOAVvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740171F00A3A;
	Mon,  7 Sep 2026 04:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753871;
	bh=Zhv8pThYNAznZKr5u9Dd20m7h2r71l6tbZSsdh9OLqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfzOAVvsVT07g1lQmJRYJb5A6aKu0zgJKMITG0Ls5U2S/pR3H6OmX/B3TsREpi6bq
	 zdBeKmvCWPAeQn0Z4mOxDa8rJQpOtoKA2OypDSh4ir99qq2TPP5w74UsCCcuu4xMjx
	 fvAfCaBFA71UcVtPVmLpL3DU+8K4jpGqXrZ8FXQcfmp19qkpXKZ0BGUCnU7Yvh1BuA
	 GaZNEzDikrojyDjvnwK+mFfTZILi3/6JqaBM5uqjl3I6Lfx7/kArIwM5izDJwISXBz
	 EpdaBFnuwWZhxVutwrgZiEG2+FQ2Z6B6t32sDcxRNK9JRzdblUxNke9FXLORxbi10J
	 8QTGoijw6p9Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 04/12] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178875282353.93794.1882454863588931285.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875282353.93794.1882454863588931285.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:04:31 +0000
Message-Id: <20260907040431.740171F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add modify_local_hw_breakpoint_addr() to update only the watched
> address of an installed hardware breakpoint on the local CPU without
> releasing and reserving its hardware slot. This is available when the
> architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.
>=20
> The caller must provide an installed local event and a valid address,
> and update other CPUs separately.
>=20
> Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf9=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D4

