Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949000;
	b=ZUlgpIj99clffVNbX5dO3MoA9fVK+RohCvJGWLneFSnbzjsKomQrSDQmsTkn+bbth4J7
	 4iwLvbN4DmNwmS91FunuiDCnB9QN6SFwGvjfIqRVkBLllq7eNOIeGAi0nhfNg3CTp3+by
	 ARGXN6fa1BsBikEsef3XtV9PnkIXFFLUJE+d4+XXAVg2KanT4aexjmzQ3LXtbxpYw5R32
	 zZsN16O8ED5qF/vr/2OB71S04CODcaCt1bGYy9XVJyFuf7JTaPvbOXoneVgn0BUfvGWdC
	 +Ie1iit/Jy34KL/JGkYZLQ7ceEsV0AnfbsRByQT6SMywB6Ok0Z9rGk4XO+2CtbI/V6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kaUuIdtZ1B5UxeR9BMvFSQnXzun2GhmlY4GU3tZZKao=;
	b=LKDlhBXbgGPZNMYjWLqtfat98u+UVLAFE75hVRWP+SeSzsQCc/GlGqsIzM7IOxjAhnWa
	 +TqrDAcYxeGr6ngdDMWClTwL6m1HW4Gft4R67pQgPKoZ2HaGhENmop620rdLwQwpStB8y
	 y+QdWyGvbDjt0Oy9xW3h5RLN3IJAoDiN1OTSSy3JiPljaAXgDJLsr5YN8eDFvHppkXtya
	 v2BB4xgSgOFVATNc/L6gYhzRrdoiQqJDEt2ZNNGVQUgTHsLJFUF0OQEjlNbj+To4SFmQM
	 49Fc/3N0Gk4XHDPO4i11ppYaKpW5erYHYPgaulqN5EwiuZDS/BUJdmaxC+Z2QrJunEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmxf7OqF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D2606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmxf7OqF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83731F0089F;
	Fri,  6 Nov 2026 07:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793948999;
	bh=kaUuIdtZ1B5UxeR9BMvFSQnXzun2GhmlY4GU3tZZKao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fmxf7OqFSQHmyvELm1bes4rf9hGvDiHecCBwzJtNDxycFXlzoiqUDwK+vgDXsDjZI
	 LvOAA8xXenKuI2crKVhylwARrvX6PX/tFc3EMjW7oe2C3vYoyuZ5wGHd3yuy3h6kVd
	 L37FYMYpxQ7s3JkJD9nqGye9jbUtVHuC37amwB6+FP0Hl+DSk7qX5fBuVKzT4NJ66v
	 Mf+ed3HtZzJirdm+fFj4PVKLlgvIIW1GvmGPPwTNpzZJAM6761gnbVG87RPLyd7C3V
	 SuFrBj+UX3BgiRhcIiH+y8GdRrGfxdmoCE2B8NOMmSTidfIk8MN8IgbBNfpHKvQwC+
	 3Th6KBSvmkczA==
Message-ID: <sashiko-outbox-200961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/20] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-2-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:09:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
>=20
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D1

