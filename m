Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8184E13FB
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172916; cv=none; b=tiAfB7SIJgMO23VSu2CUnEVhsf5jQCo2Ist0QoqCLFMAkrMWAbVBPTufkcKhOxfxBbiHJdc6xKNGDe0gOLcEw/pUW27ybCANRgVRnqKe6LO26YRQAS5w15U4Us20KO5Rizqfkg7zjwdFSL68xzCKYVBfQd9KEzrXfTp33c9foJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172916; c=relaxed/simple;
	bh=fPtCpR9yaqGmxYIsU+rvUC9iiLiRJPnvezsCS7ZdH7g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FsS9K1V05KVSqejv0oFe8abH4U+O5/pnB0xrOgLrF/aAPDsbpILblLRayPrsYGMv3+N/rN6HjRNiy+JfD3QZCNSpt8tGxqB0HVRZtcVJTX3yZbhk4FooJFzdhUkbQA1nnogvpdOUSUXU2ZKoo5vUFQ3E0qTPdMc7/ogxxiGY5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lISYqQ46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lISYqQ46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3006F1F000C4;
	Fri, 16 Oct 2026 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172915;
	bh=fPtCpR9yaqGmxYIsU+rvUC9iiLiRJPnvezsCS7ZdH7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lISYqQ462pLcO8GUwtbpp0Ub6ZmF+RyHh07MskUNSCw9loRueDf5dGY+mBSuUkoVr
	 Wx2cj+7d01ozB3UMgzQQH3vAK0FV5v4LRipSGSaAaG5wiCUZmmtZ48ZkixsSuHE0TT
	 vaR+vggoujCLghm8SK6Fcu7klVB2cXqN0KaFetu1f3PJTL73VmbalYQ4MtIpQXeHZf
	 bS+uuOzOJTr6EW9ArpZY8pvEf3Lf/MelonaWszDvE2ghRKFDbiwrp6BPmJNQnMdD+l
	 cnI4/fE90WR1JEpRlBdM5NBKEtPTHDPMWbl+dAlF5YEtKJva0x05coXGY7YjAHAsMv
	 ANGwHSgWy02fw==
Message-ID: <sashiko-outbox-174747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/17] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-15-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:48:34 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D14

