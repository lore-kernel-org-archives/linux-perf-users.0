Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600655;
	b=DK9t7PiSjEhVQIrR/PTuk60zR2f7tKb1D0Ptkeom7jAXt6rxGvdcIth0iTR8AsggLj3o
	 M23yDGcHsruxKAPOjejsi5EMQE+bbLDAmH9zLSQp3hGgUA9Zt5LHxaAS2858NduuoALa2
	 j0k3TPmHATWzwwAGTfNb6TtJE874/OvhyD2a8nEK8Ns90E7VSjAUG61wrbJH0VF7SSEVH
	 MEwUZyew0VnHkrEzHVAmS2GwdjZtPem+Nom/2+FEmz15H9gughphGZSbuMB58sHQbgZh7
	 h7gTMbNJrWpHFwv/BiZJnzAfNm1Wnb5BQxvMVMUy4Po5h/9YIrNj+36py+D8lDNWQIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600655;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wRQEJU4wxCFa/kAvdyFoujgeAFZtZzaav9lLdzruEYI=;
	b=zVqSWtA37jv/KpesGdAWouErb67aouPTa/FXCpjEZHa44mGRh+uExTORVI1mvp4GJ1mj
	 eWrAQMhXpqpeEJGf5t3ZyS6hNOci5gaPM62ZTI7A73/viBM+90EzvKXfBwXBfWEKPC1Cn
	 toausfdHeGS28s/AjGwI81h8ezkUZ8zBZ7T9JqyKLqZqrc7C94F9z7s/9LI5XF+JtFJI8
	 yE3mjxMqFJnlbOFlmwavi0a+R6wYGUmM7S973o0dw5J5KOIDNwCOBd+2eCArgoitUYaoM
	 WIQOYUofjwfvcrEnvz1GLshgS4/w6T+vKKJTudQjAZ8rZ6u7bMLGpEJ1shyhzPoXNdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQHLq7to;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A899606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQHLq7to
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0A01F000C4;
	Fri, 13 Nov 2026 20:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600655;
	bh=wRQEJU4wxCFa/kAvdyFoujgeAFZtZzaav9lLdzruEYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQHLq7tolAFSqsmXslH27TrLbUwqCCKzWFyJHnkm2pASWLRgiLuLQlikhMhHiqbOX
	 3l84oAJ74esTmqvO7fZiEK/EoefPlmTjqsRBbix0WebcYO1arAF/t6F0zlPaUZ999S
	 F3Ee2IDbaWLo+sxge2eYENVD5kZrLT0KTlRa6ScfS8gnpPCuiAHGMAg+oEXEYV1Luf
	 x57kqlwyciLy//0K/BE2i/uvPDkiuhZHrKH1uz5i9p3VZ83wrU9l6SwvKFVpE38deE
	 Fvam2zODbzbKhB+xhZ5OJfgWoEhHvnJoJ++bnHDJBPKYcNcNn8qM01jLjGf0XLPd3x
	 k3Pr3znAYTa9g==
Message-ID: <sashiko-outbox-213620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/30] perf pmu: Add from_env parameter to
 perf_pmu__init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-8-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:10:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a boolean from_env field to struct perf_pmu initialized via
> perf_pmu__init() to distinguish PMUs reconstructed from perf_env
> headers from live host PMUs. Guard tp_pmu, hwmon_pmu, and drm_pmu
> callbacks on !pmu->from_env so perf.data-derived PMUs do not access
> host tracepoints or cast plain struct perf_pmu allocations via
> container_of(). The hwmon and drm evsel open and read callbacks fail
> with -EINVAL for such PMUs.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D7

