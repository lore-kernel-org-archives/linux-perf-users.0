Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623575;
	b=U8SZGYtv13DkOSf/BeQkkOwCYRNsfxzkGmBJkwkoZhEu4x+4HGrYt4yk5bEHNxw2k/x4
	 xB9akU8lCRcYTVQ43rSOBnJw3ZTBZYDObJRmZDkYB/Iccg9OhaZ9m2+0aH12h7+RSCc4D
	 dAcp99ev3USnOPrQMP1e0B2scR6eH/wtVFI6L70GyePezq8tu7yQZgjOkS21OBtlflELR
	 1O6bAOzxECBJt/clGOiLd/qkvi2N+hN4JQglIkAXtjH9ySbgj0wLs5sqpFCD2qP57NVXi
	 hSJgqEMF+6xKZNddcyuhumcFKNQHVE7Gf7deGxtYITIPQuJZdDS1Zy9l5OKKvSKm2Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623575;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gvMp+ZxI2Cd8XiohHg5yKE5l3vO5YoF7vqghSpVFQE8=;
	b=cEXCcPSJ0ZfUnGQc1dtzAsr+FWwRonCJobsiILuHTPSHnmI4gp6Dhsm+VMk5g9PJXnGn
	 GOVmSQqvuV1PToGkcIWOneiabJnfTwbyvRGgoVGvFdbecDN7m8njXox1VFIHFgQKXFlGO
	 O3ah4AN1+guJY9vxTUVgxy1NOO9UtbvAtBbFfoVloNQGviTtrU0BcDwgbn4d62cuf697O
	 L0KlXYAqEYGmsfcW78rQxs96ClR1I2SuCFcoO189jIsh3U9swYBmn8+phf2giGBRUkWZ7
	 vTuDA7MCG9WsKYt7/A4eAeXajfuyyl6gNzg8QMG7iTYWCr9N3gZY/HiS0phz4lxwNmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpH5wwhG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77340606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpH5wwhG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEE71F000C1;
	Wed, 21 Oct 2026 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623575;
	bh=gvMp+ZxI2Cd8XiohHg5yKE5l3vO5YoF7vqghSpVFQE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QpH5wwhG6UCyuk13PHLhNHBNak5t7sC7CVaM+ukwpmj52SvIcHA9RBs/uB/8V6hGR
	 guNIW6elNgXBZxrVSy5+mdwZD6p9fVbN8gsqLSFjKzy3RPVYNVSQM4Mq9ryNpQ55XI
	 WUSUeIn/XjDwL9jiC90Cdzaj4Nrh9hBu07uTB4yWo3aOujj3Uw/OUCUF9mS7RacjRi
	 IfUzP9IZuMW/N2PRlPzrmG9YlYhwIEknkhPGeDJQyTtlPSje64VJ+g+yUTT5dsFw7u
	 mMs0ayLBTtIZDZfV5rAbMl3lFvzL7BaicUV4fgVkiYFowSOHCHwb1E8NckG7sprVf7
	 o9W2yNDxBxv+w==
Message-ID: <sashiko-outbox-180753@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/17] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-13-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:59:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D12

