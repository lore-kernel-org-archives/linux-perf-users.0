Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4E38F658
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665603; cv=none; b=rRqN3jNvYEpJJiUgOa52OSOQBSso8AT9Cm9QHa9SS3uIcGRieeDm2hPdtZ+b+T9Qx75sIhNMYNuqwhiDudtYCshvTpJO6dIwpMUATR8/Uf7YWdTAH1jKvbD++R34sDX9uA5zXK7P7ozk2UrcLbXI6/fb1Wb2TvAlByFusJfINAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665603; c=relaxed/simple;
	bh=AUZAak4dp+Z1zwV82ZcjXhWQXG8FkdF+XCXwR+v+sEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rRpTOD4aN7lEYx8HslVvH/inMNzz0EQ8NSAHye1wkso/tGSqK/7LUANvKOzdEcqTKxgPCQMep8J7S9sDW41pt/CFsexH2SzgFkCRXNJqOOu2w/O9m9F98iZZCOvbApMrIllLN7eYPHLRqmynEIsPtH2hHla/dmOBkqupsxojJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxlIthcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxlIthcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3147E1F000FF;
	Tue, 29 Sep 2026 07:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665602;
	bh=5pc5GAhKRZXY57DtUsAKcBtlTN+Oqpkoxmp+PIJlSNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxlIthcstW3z2/BbQXFp14uGnfulm5TgYoxgI8k0BzXYS9/HiwHgI7Y+AIwIsCiCk
	 0L9eCWoZ/AAfYKZd55pfXB4FvMk6ngUelM0WXdBhUkdltIY7GUd+Zvu8UDtVtQqu4h
	 SHHaJLFlatrWfAWwkazoXWMB5pg6ldaMS/koA0STW3sTi9wYGZ4jAbu/MCOJhsD0Q+
	 70YWNG+W2l+8IoromLhBb1fBYl8fYHQQ7rQ9+paVvPWhrM+FsjbYBBYIj021+V8Zoo
	 TybQV/KPTpgxPfF7ZnTuO2ReT+sDxvmWl/zPRbWxiBnl4/OxBhWV9onNVio26dqhuD
	 +wkDdvuf4l4Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] perf python sctop: Fix offline interval printing
 and test flakiness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929065839.407062-3-irogers@google.com>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
 <20260929065839.407062-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:06:41 +0000
Message-Id: <20260929070642.3147E1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065839.4070=
62-1-irogers@google.com?part=3D2

