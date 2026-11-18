Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039472;
	b=bpLI/sNrmoequCfvrd153HPtCK2QfLWRgXg9uEu5W/IwerSxRGRVTcjaRLdDk8TfRFcm
	 t8E4hWfYkEDGZznuPW0SsUVX0A3LN16o3V17uwhiXlTwui1PSdKPzvJCECpz+T4wHEVRD
	 lFqeBeU9JzYjt4wuu4fzKNR0sy8M14zkrvnVzN/TyWnAWIIBKNyHxu8tiSY3VWV9+VabQ
	 eOwmZvQ4rN6zXivMnQQcskfAXFLdb367p2yiaffKQP6/AB9AzwXG/9XXUuPDwcALAazgy
	 F6ix4R/cBokhyckUjBCOKiVrp1tqJXzJcWJRKARx3jX9gQEOC/FMVygfUW7GSqILeFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N/AdLQWcLBjhVfDr0/TANt0tYvrZ37IoEnKjPz+t4oc=;
	b=288GSWWODbNG1EyzIZXXqoOD8XQCajgKw7lKJ5AkFydb40fcLUDTQ/dMilNHPuAR2uIV
	 v+/CAsT9hTnm8K3AT/Yf01wgoCRD7wAqxwQ+qpDpJapVs4L0qUq4PVigy7SoyAjWS7+d0
	 NGBqiRwbCz58DUh3/+ARv2ScqBg4WEUkBrru6lN0TrL3ORZA7Be3hGD+wiaK/1RWYdwwi
	 UsMKC/bH/URxZuihHZ9mwxFWpeKhA+HhStiMfOSbC0q5SI0QjZ4OFQelqdAW47BSw0Xp2
	 9b2+UhXttA0hU/6OO5nuhCgASWOZTh+LlgLgXqd3qz74zlUyfwZvzv+HUcae1KTA+/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhkLkAXA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC6606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhkLkAXA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055481F000C4;
	Wed, 18 Nov 2026 22:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039472;
	bh=N/AdLQWcLBjhVfDr0/TANt0tYvrZ37IoEnKjPz+t4oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OhkLkAXAYoPLTHw14MeccESZ9QtLr5CKg4/Iia2VVjuCYYewRUwOUfA+2twldc/3i
	 a00LjQcjW70QuIdiS4ZT/20pBqp3+ck/ayOC99a44KG1OQ+OTQgjQYAZjmGBkOGDHR
	 nmLei42WLoLfgaruLgQLfejI69g7VFdtOhi8DfIABQrxie9tJmtz7wWVcKvATuxiCI
	 Bk5g6fnpJklFjRCIEekys4TeoWUUV2Ti+ZKePPpz7p/jXIJ4QaGg/3WEzOla0psmkO
	 /fj8EdPwptT8Ih+81XgQRqFJUZgH7FYe3lTeE2zaHvk29od5Zi8zLZ36qdTxBaCVwo
	 47F22eCDEeHig==
Message-ID: <sashiko-outbox-222074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/13] perf test: Skip the LBR inline unwinding check
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-14-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:04:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The LBR check takes caps/branches as sufficient to record cycles with
> --call-graph lbr, but the file only says the PMU has an LBR: AMD LBRv2
> rejects the call stack mode with EOPNOTSUPP and AMD BRS, which samples
> only its own retired branches event, rejects cycles with EINVAL, so the
> test fails on AMD instead of skipping.
>=20
> Skip when the same event records without the branch stack, so a PMU
> without the LBR call stack skips while a perf record that fails for
> another reason still shows its error and fails the test.
>=20
> Fixes: 446c595dc0dd1759 ("perf test addr2line_inlines: Ensure inline info=
rmation shows on LBR leaves")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D13

