Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052694;
	b=w1FZrDgpoBVwsTveZAzVV0IMYFDmYa3mF6l9Bn1I2V/TIL/xapyFmG/cCwGWac/lm5sh
	 EYoJufJSjHXQ+70Qdl9xTvTLVauAHiSK7MII/dG/DliGFXXrSjeUZTwMxC7NrlnPfotRJ
	 FqLNiMO9bPDMoyfFv0p5IKqligdKK7GDIfDST9QYq046jt/aC/gAaFYU39Hohldv/S4B8
	 xFv/0USz/ti1pjk1v0v6Kfic1jZrig+ie+MG6dioL3PIf4pWIc4abZjZJGZZNmNPT0wqy
	 vGNEVRXhc0qZd2oiu5YhW6Zd2+jdsS6p+n11Cm/bycQXvgWjBe9VpG/TH1Jl5cqRAew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052694;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xI+/F6qovClbe37qTXZW7CQaREtqWgKOxH5t2wxX05Q=;
	b=m2WBrki4gGeEs45YSohwAYEVUCfEjQHiVSHIbgYm6hxWk0+ga2VZclv+ljSt9GsoIrJQ
	 0DgId0ArADdxUNpCqhFXM3g7M9xv5IngnGOfavBcMYbfvJBQSF0c+YFL76MiF4W2gEdS/
	 3N3Zm7YVQMjo8fv9GkzyUNAQ8QjD1+kxscI2WhSTA0KJ6s2efSCwje6F3jrUi3dG6DscZ
	 JLAPO20+LGHRTgU46uuFRZAUrpt/ARVGavCSYqgrjRMCEi+yne/KOzwi70+DEgHBiOoh1
	 hA4Z7ft80QN1PKgb7AWGT4WH22yJz+SbyF9+/lkUvMYtLO2dZw3DYwFJ9LlzWbZ6Xlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJ8Lh+F+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19B606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJ8Lh+F+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963C11F01825;
	Mon, 26 Oct 2026 22:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052693;
	bh=xI+/F6qovClbe37qTXZW7CQaREtqWgKOxH5t2wxX05Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BJ8Lh+F+WxgPl96913EV4SZWJTY4kKwG5smtFDHmv4Wm7lK9jPcGGbVWA7wfnw5Bi
	 pMT+dorVc66S4zua0PBiSI1hAJgoWx3d/rEIMzn483WvLz6BJrFz1RkV6P9Uihzbtt
	 AcH7xg4NwY5LaxDfKMOOw/0UceYrCxGg1ZfWF/tpwGGBLF0F8rj5jNp+OruHdgPo0o
	 pgckBf01ubHBx2Ig3MFuknK/G2cC6niG2Su6h4uwaxfhk/6x5bdnhUXZzJEIRuaAso
	 7pNEkfN5zAt/mshMlwDM/9wiVHSdGnXBUmTjVsEZ/OYxslc//To3NyX2haFfs62Hy1
	 4Hnuakp3hNqXg==
Message-ID: <sashiko-outbox-185785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/10] uaccess: Fail user nofault helpers quietly
 when current->mm is NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-8-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-8-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 22:11:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The user nofault helpers (copy_{from,to}_user_nofault(),
> strncpy_from_user_nofault() and strnlen_user_nofault()) are meant to be
> callable from any context, e.g. from BPF programs, kprobes or perf, which
> may run on behalf of a kernel thread or of a task that has already gone
> through exit_mm(). In such a context, there is no user memory to access,
> and the right answer is simply to fail.
>=20
> Since the previous commit, the uaccess helpers they use warn when
> current->mm is NULL, e.g. bpf_probe_read_user_str() from a BPF program
> attached to a function called by a kernel thread would now trip the
> WARN_ON_ONCE() in strncpy_from_user().
>=20
> Check for a NULL current->mm up front in these helpers, and fail without
> warning and without attempting the access.
>=20
> On x86, copy_from_user_nofault() was already refusing such accesses, as
> nmi_uaccess_okay() returns false when current->mm is not the loaded mm.
>=20
> For the same reason, make copy_to_user_iter_nofault() use
> should_fail_usercopy() directly, leaving the NULL mm check to
> copy_to_user_nofault().
>=20
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D7

