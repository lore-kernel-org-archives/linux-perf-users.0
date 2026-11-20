Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188583;
	b=cJWgJ/iAJ6KGXYC72DijJgym0Y/UTNHFyAu1CYQk0vfOrtzWAAgKg1phi36c3i2oUrpU
	 yUeH7+l/vrcanZQAdBum3r55AoWNx31/j9g9a2zNJN2RUzZeRYE2Ud86UKsw2rpuxfxlV
	 Q8x4+LpAljhiAuXWgBMy14YxppqOt4kg7flEa9dvAi5qnCH6/HjjuSQ/Co/cLiHF8zC3h
	 GN4fqbW74DdPTAYX9r4OnBS/xo0hSsMz0bKjLa5j8Ghdt2XDJKyHMj2lIMiEyktrdejqw
	 fCcjyaBXBUxQM7cV5erOELmouTf4fQbQGZ2tGy2WZyDi0t2b3tsQ5yhK5u7v0WycTIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188583;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DeD8AJZKUsCpctCCmh9JsBlHIP/CCMHerWSOeEKe8i4=;
	b=eUZIJA/AciDDDZaxPx2FYOu8P/QvGsk2K/H4TqJd+YJUYEe4GFFO02chQYaEX6tGWcST
	 Pk+DE1HUrdw52SZ3j7qHnsVv4/pOvD8r/c8vYgj8I8CHlEw4hu+75RrUFzQlehXeC14Vh
	 gXcDHP+XLMPA7m0HO3XZgX5BqgRAoEaISnBZ5viLjmP0LrsIaem1LDVlv3HAzhFc7nm+p
	 slfmDqTWT1zs4ZiKTn5Elnv/2cd5mPQXDsowT9LaFpFV+DlMk8aWCMrPsEwcHIPuvfzgo
	 vipvD4AEyhSCldDBvzJZjx24yjVeHyAEmHKWwjapHFTI0DoEq3QEjOJpyBYRTcv6rpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIAgZ+k3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FB606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIAgZ+k3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A541F000CA;
	Fri, 20 Nov 2026 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795188582;
	bh=DeD8AJZKUsCpctCCmh9JsBlHIP/CCMHerWSOeEKe8i4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NIAgZ+k38MtQ8LxAsJvba6Ziat1Au6F1jAO/5mIJot1t14IPMRN8CkfjomoJYV+uG
	 lN8dw57TG/AuvTsxQn2X22IOOyXFGGnsl0UifFJz7ikqhXyEDNY+UAk4MfjdNH6ft1
	 8oD7qQ8DqPeNyorUneHS2d/JoDuFV5P6ZLcQ9IBBY6EFJQc5J+fS8SXQ8b13znC0kA
	 waP+bpQoj7lIXTMgxls+1NTV1qSugfxzIuDmJeuL0K/eIMTPHn7yMZDgMBPvvD1o4e
	 kRmNiNqNHuI40l7ttf8tESI15M/64wzi/IUQsfjPkQtMsHt92GzlIpfhWKIyZg6IH7
	 nQqRu84zB8YGg==
Message-ID: <sashiko-outbox-225461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] coresight: syscfg: Match feature capabilities
 separately from device class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a78b8ca4ea1cd447b5ca3736d5e94b81c8273364.1795182850.git.aaupov@fb.com>
References: <cover.1795182850.git.aaupov@fb.com>
 <a78b8ca4ea1cd447b5ca3736d5e94b81c8273364.1795182850.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:29:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A feature loads on a device when the two share any match flag. That works
> for device classes, where a feature wants any one of them, but not for
> capabilities a device may or may not have: a feature that sets a class
> and a capability would still load on a device of that class without the
> capability.
>=20
> Split the match flags into CS_CFG_MATCH_CLASS_MASK for device classes and
> CS_CFG_MATCH_CAP_MASK for capabilities. A feature now loads on a device
> that shares one of its classes and has all of its capabilities. Check
> this once in cscfg_load_feat_csdev(), which both the feature and the
> device registration paths call. No capability flags are defined yet, so
> matching is unchanged.
>=20
> Assisted-by: Devmate:Opus-5.5
> Reviewed-by: James Clark <james.clark@linaro.org>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795182850.gi=
t.aaupov@fb.com?part=3D3

