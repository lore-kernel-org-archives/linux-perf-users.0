Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942294;
	b=PyLS0C8a+baFrvG184atfddl/mLblkNqP5+MJCH1iMXx7oSHpe47DtIv1J3hFeKHLzNV
	 ynAuSW3GmtjFUA6s3RwQOQHbTnyosPBCCCIfV8abgnGVRxdrhDmYuHUqCUJU+aanw7f33
	 Bo3sqFGJx6l6uDbXixgRqjf85KSfztpwBiIrHKfE9yp7xOB3X4BVRTTmo5Z5eBrgdPnYs
	 unlU+fwZGmnrsDowQ0HS2lugy8K9KoQ8No6nJEa9MJggUhctAbHx3fwml7HP1HljB0OTD
	 H485/ba9As3qDl/KpbL39RLxmHKwdMmyWAB/d0N3S5f3f1v0IVaX6Eagu6XykAaYC7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942294;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H/NZbEVbxqDL9DZm+8ukoj3ClDEU5TK9RjL4xfzPKcA=;
	b=OsZGzkkA1gr2zWpc7M2thX3JoGNuV2W/nankRbXlNskmkfdwN2PmxI1YFrJNmVUAmUq0
	 wsOjgo8RvYIDnIWDnNHbNIAeMDclaT78kWaf8YOKFzk8YkHJaEbF1XnM948rw+kybry5X
	 T+BG3YnTdcAer8U9rgJgaJQ7vxTFTTVFB+HDsNDgRPD2VmehgU4oQeeRMe5flWZXc1L9M
	 kYUl5AsfQAaaVi7HyHOTjfTXWIMkyCDRGYkgoPhFtqYLgZZLRc+zygZRPfvImI7qV530C
	 MC0beSv//Qpg9kZg+/gtmdDNBeeRZo1WebYg+BeBeAWNHPs+eeUb/quOObQVTuahReA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n80GgVoh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC0606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n80GgVoh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6A31F000C4;
	Tue, 17 Nov 2026 19:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942294;
	bh=H/NZbEVbxqDL9DZm+8ukoj3ClDEU5TK9RjL4xfzPKcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n80GgVoh8m+e9uzBsNsDORQNGnJoQa/y/yyjC8BJj9mv2nkGzb7f5Aq3sNABXsogP
	 MT24pYsD9dv9PCjxOFT4QDx/1bU5Ur0dYWvxIZ+o0N/76NPFlwrWLhqnehKg8oCmiG
	 G77IoefPq9q7g/unDh5dyRON6rc9RgJtck5jS9Xs2jAvVQepab8PeuKGLzFSLnZFEn
	 ovGGYo+9qxHQlFGi3uqWKHIeRKIFNhRIcqrlr/w2v56PU0m8oW6A5PCTnr0FtNbs7a
	 JRVmP9dw79aOBu9HGKP8kMyL359qwYOHB0AzbpZQ+jOs36ysjNaibWVzizv9Mm6Cp4
	 6RJYEby5pHcOw==
Message-ID: <sashiko-outbox-219436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] perf annotate: Move struct annotation to a
 hashmap and remove symbol_conf.priv_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117185305.108003-3-irogers@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:04:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Previously, enabling annotation added sizeof(struct annotation) to
> symbol_conf.priv_size, bloating every loaded struct symbol in every DSO
> even though only a small fraction of symbols are ever annotated.
>=20
> Move struct annotation storage to an on-demand hashmap in
> util/annotate.c keyed by struct symbol pointer, guarded by
> annotations_lock, with an atomic nr_annotations count so unannotated
> sessions skip lock and teardown overhead while symbol__annotated()
> checks the hashmap under a read lock. Return NULL from
> symbol__annotation() on allocation failure and check for NULL at
> entry-point callers.
>=20
> With annotation, TUI map browser indices, and db-export symbol IDs no
> longer using negative-offset space ahead of struct symbol, remove
> symbol_conf.priv_size and symbol__priv().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185305.1080=
03-1-irogers@google.com?part=3D2

