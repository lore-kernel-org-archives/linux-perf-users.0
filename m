Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622540;
	b=tjUd8ph3coHmDE5YRNnUdTPxVMEoNcc/S3HPAd2k+Tt4egICy489RG7PFaeox1ae1LJ/
	 blsolg4wJxMn0aoCNU+6fspViKaxausTGV59zoIxcBuokSqrY9fIf4A3VFQwgHk8758N7
	 HMRvdAiqkphJBWlX1OSmZbWc0ON5c531xZ36fMiwlpAIgqh20UNQOGwBSdaTMeBgxQRr6
	 HJf1ysqSJ2j3JC7/tRqunl6o1kyrPfUgVtA5gVF4SIugiBLaoYwe4qP9/YUThlOttBDpp
	 eI9SW38MHrybeuQTgWmj+Mlu/fj3WYVNdgVZaErO1IiiYvEZ5j6vu8mQzZZ3zECLGpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622540;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BjKdoGo5bk+Q9//bVfg8NB088jHYGtLEdId+JawRQcA=;
	b=cmjQPrb3OPCbbJZiVfKcDOtFbG6BP4Z25yV1+kljktpUdXWvt8E5GRJzO7tKm+Q0R85v
	 3FZF52v6B8f0ZT5ID9ZUi/aQ6IXmfjzGitQLc4aShUrRHizAZToYcN02VknCR1UsSJ1Yi
	 DBDGLvw6PYUF6fCwdTldKBVBonDIpiEViUXj8wzKK2f2YHjBJgIHgRM3fR1d5iA/NqfwZ
	 kvBSf0l3Bs/PwwnJNnU80fV449gE+3PF08VTcXzr9BMjLst0qbEhJvxdBccZZ5sPY685U
	 b79wX5V+mZUE2R9t3HaG5+ug4spgJi1yFFcsC+kTvP1jji3hm/aXU7SF2zCCn4P1+4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDp+eILP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B8606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDp+eILP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15AF1F00A16;
	Mon,  2 Nov 2026 12:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622540;
	bh=BjKdoGo5bk+Q9//bVfg8NB088jHYGtLEdId+JawRQcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lDp+eILPbVcLvL/F0/XIg/6PYOhUO1t+nXf+rtTiSgiCCjh2nl49aymb4yyG8NeR1
	 uaY3dxhQ56oJlMxLdoSv2AhitaE8jsfBc7sybf8B7nn/4fxErlY0vSxGiDeqmmq/fM
	 CcN03WJY0EEbDrnyH5YH1NYP4kHR+4ozVh/IFn7rFAYob66xoWVPblvX5dNMtAuW7E
	 lylU0zM+4T+Dzj/cTsVNTR8q63Q4vckq35ZAAnHJRGkm16ZU9rtnLCsCkgr4lhS+iI
	 K6jC4C7Jkx5NpzhesmrBbNBIyYuNCa9EMDExem0IRaYsT6XGA/pb7gjME47J7a29FK
	 053C89M1aJNBQ==
Message-ID: <sashiko-outbox-193407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/18] perf auxtrace: cs-etm: Capture wrapped
 snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-15-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-15-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:28:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> find_snapshot() isn't implemented for Coresight, so when a wrap occurs
> we only save from offset 0 to current head, modulo buffer size, rather
> than capturing the whole buffer. Coresight drivers currently use a
> monotonic head pointer even in snapshot mode, which gives a lot more
> information for taking snapshots than a wrapped pointer. It means we
> don't need to search for data at the end of the buffer to guess if a
> wrap has occurred, and we can go back to saving partial buffers after a
> wrap by checking if the next size to take is less than the buffer
> size.
>=20
> The drivers will always be able to generate a monotonic head because
> TRBE has a bytes written counter, so even if we stop generating an AUX
> record on every overflow, we can check if the counter indicated an
> overwrite and offset head by a whole buffer size if it wrapped. This
> forces userspace to read the whole buffer rather than between last and
> current head. ETR and other sinks use software double buffering, so can
> continue as they are.
>=20
> Add auxtrace_record__monotonic_find_snapshot() and use it for Coresight.
> A monotonic head can't be auto-detected in the default find_snapshot()
> by checking if head > buffer size, because before the first wrap a
> monotonic head looks the same as a wrapped one. The search would then
> falsely detect a wrap when head is near the end of the buffer, and the
> wrapped pointer fixup moves 'old' and 'head' a whole buffer ahead of the
> driver's head. With a wrapped head that doesn't matter because only the
> offset within the buffer is used, but with a monotonic head the next
> snapshot would either save already saved data again or drop up to a
> buffer's worth of new data.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D15

