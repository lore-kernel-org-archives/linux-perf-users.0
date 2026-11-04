Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827429;
	b=PUVayz/bszGgFe9apv+7tBk5TkrogME9nteQ1YEe5zSc5BuLpICfpLGcddYEiaT3re/I
	 Gm94Ocg5n1VBANOPFb6MDrZ0Di0zM5oBeeaBOw3M/LnBLe07wVPdR1jZph73Xnjcb+fGk
	 A9DVinJIXpZKQ/AwBTGfxXbiGq+ngaLU9DCoQ59vHvyH2siKxMUUP0FPm0YEqm24KugNO
	 krcYVUuwLKTpiUU/XtoUTvGjFF+8cOX2VZeufftZukybrvGHbttx6BPJNoJlwQYHrMISi
	 aY15mIJM4vFepwhsK6VpBHpRR+HYV4X25a6uIVw6hxaoVBV9eCSM8hcBlGTWweJr1tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oXgJ/zMT4sbpH57nU0Kw4LZhJIMcKswq9NqgWg+spSc=;
	b=feLUht5djQlFTAtjQo+PTBvfaQdlodnmLG5TJU8k9QjvgvcDEdZ50BBLGZFWTunN+a5X
	 8E8F01VTJtFJvux1/sChC/obEYimorvkF0JEC9nsLtCB3/aOKyYUQ6XL0gxKVPVcNpnoc
	 nqu7rEwgFWwPq8EM9WMS0LVHkDKoDVz7DCRC+0Fh/giFBs1DJvsfSUaX7ScXzvzMo0mNR
	 ZDNA4QoqeVOlqsGOGNti1fv8gLGeIjRTz7b4UJ0J/sbtTMdgMK9u2eKA+39syPS4+KSgl
	 JS0TnloLDBlrIS8eYromitKgztr8tSGEOPOe0x8VJWqpmtoEWkTwegvnoKh+RBCSs5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YEiCTJw/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D0606B2F1
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEiCTJw/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB401F00A16;
	Wed,  4 Nov 2026 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827429;
	bh=oXgJ/zMT4sbpH57nU0Kw4LZhJIMcKswq9NqgWg+spSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEiCTJw/rTJS0kLL5+2vo+fFjc/PTn9K8p6Apv7tEQxk5ve2rySXQ5RK39Jlt0Iz8
	 L39/p/V1k073AfDsrK9l0Rx924QZ/QjoIkQ8gbAEeJvznJVMSSdglG3et/bvlhZvdZ
	 diOih8arZ7gH0BL19PErLzGSqroa0Dg7d1FLD6+i5c9LR80Hd9bZGnN7Rjl6X736fV
	 MbH0BklO6WlkzT01Ep2WtGgaBu9phwV+nHDL2x5C76KKMqvLkpOi3qOcXz5kvHJgI9
	 cFmgexWaDyFuBR3ZK0foC43wCBkjs+/K7EduInyv7V48kvskK0lYWZQRL9uwXpCepm
	 b0T7YHyFF8OmQ==
Message-ID: <sashiko-outbox-198111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/19] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-15-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:23:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D14

