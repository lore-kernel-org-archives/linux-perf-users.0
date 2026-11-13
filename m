Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589362;
	b=tGYOkMfV45AUGnqrbGpufsSyL+ftb+3+RWqAOLiBaoXp5PNT+MgBbtwPzLk3ic3JTDea
	 G+ir/BuFomIytHW+3jGfv7LKcc/i7CXQJ1bT8g42kbw55KFWABgYrqCkmczTafoAuJlNg
	 DiwdWGEmEOaYgn6nF4p+ngRquNImbigE0Ysnn6RI3u2OWtHt8Lb1rGe/HQR41lwB01jK+
	 Tff9QstmBkiXzsr+q2DO+RJaAGheAaZSsQGgQ44L7haEeUNS7Nqp5bS9OisPg+1Tv8YAD
	 LPFoIi7sia6AbIFNmciZIdroBU0jeL91Gzlmi3nV39YK6REkafAxb4q/NO7xZXgu11A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YPPFznPOmxV3Yl48vmaTzQ0EFM6WELQunPKdJcNQMdA=;
	b=ptuHW66WEGTC6OHOEU6tda+kL9iCO2C+39/Da4dtFhnUGI49qjaytw5mFCQrbrR5SzRj
	 CmM389qrrMeuaZyaSOf3g3W+ojpqcd0hMUUhbAwf3lVqRUqHcJCz4LGWK0iiQ66BV1MlJ
	 ag6VgY7s+7dFfZQjKe/OaeNTWuyOAyHMkZJYUToi7FApN9pEzXadhorxMFAl/LfH1p74x
	 yHKNnxbuuZQ/Id7ImNtfLBplOQEv8Fdf1MPSRzmVCAWiP4FBpTKNbn4bNP8LrPysb/9wf
	 5h//fcSXID5hHQ0x5d5Vc91ZlMyoxmSuW1+KbwXW2uuNyVN9cxG6AKgGnTuF3YBcX8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gmhjn/8L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A2606A337
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gmhjn/8L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC451F000C4;
	Fri, 13 Nov 2026 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589361;
	bh=YPPFznPOmxV3Yl48vmaTzQ0EFM6WELQunPKdJcNQMdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gmhjn/8Ly75blwr/+TQ5OKB3vIBBhKa1BRt74miLsGecBhTsE3KS7+4rjJ9/b42VU
	 pHnpfZvz/svPPMH4FPIpqFHwzimg0MB47j/72YtPy0k1ivkaL3iB8FiUA7cjIX/Ekq
	 NiyYc1jyaoNq6zV0JxihbDKWfsJlo0FEF6d700Kxrz8crIjkiRDm23L23cidtkNABO
	 SeWRedw4Yuz0LOXRvYoDPUC1+V/ouNsAWW+LkNEO2u0RW/uhYkDjwO19E22QVCZDT8
	 Qmvvk12SG7P2BA/8IG3AK5mK+ATDC6aHZ1CsInJciY47vafiVM4/g/Bnc9z0prmute
	 IUfKyN+M/h7+g==
Message-ID: <sashiko-outbox-213265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/21] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-7-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:02:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D6

