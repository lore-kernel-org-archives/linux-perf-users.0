Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133648;
	b=R7XHbKeRuAYUZa7yKnf75xlDZg0vklgBSzSFAAXZL7gsDKpiPfj+eKbINgr3lzCORQYb
	 +iJibPPayNf3kBnl07gjkL88VYs3Rg7K+k3wgje0tmIvMZK8e3zseTmnwFs1rrMzqBwez
	 JHmKF1+60z1jtz1k8Vmm0YbN0drum7OL7sajYzyH1vqK+3PBm9nlje8/SBtBe8cPZGrTS
	 /A7HEUKVVZMwj5FQrMROM+2p+/ftpFlJ1fHROFojy+jYBnCa8gVjaSEbbVpOOPv0B9baD
	 Ep3V4xfXBWEnWOlsowRRyhs789u30aO20DKs5eHLNpkdc02Vc6TLhM74k+VwsOhvRmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133648;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vcxPYYVgrTpztiwV7VZuV/wg8ukn22PC4lJu9DlIBRs=;
	b=KC8OqGSMx0jDG/AHKzGp1m4CUhfRJByF6xUq1Z9XPRe+U2kZb6x+mZ9LdWCAzdAFES9c
	 RAqYJ3n5iA3a1XHeYXcgWcO6yTfhNg4gmGJqh0KuWkNOkPtqCbUetGEgQMwwVOBzN5bLa
	 n9UiPtrpC6zlo/UVev7RpnRzVaFbZmOfWxPjs2Bsx8bVlghC2wYyWKLZNqbL1fH/d8W2e
	 zUNPPVTBkRnzKtT/Y36jxy2qNvpjyGmctdYIFtkjMnDF3GY/XyZms9X5Qkn+G4vnFhei5
	 lcC8D8h93y9c6esTglF5CIqp+iCgihutWB/eLL+VJDTpTOFBjylKy8UqRi+Tn9Q9Yiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVmRByH1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05502606A31D
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVmRByH1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43231F01825;
	Tue, 27 Oct 2026 20:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133647;
	bh=vcxPYYVgrTpztiwV7VZuV/wg8ukn22PC4lJu9DlIBRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fVmRByH1ASjwjNeu4bpF6R48N01idga+stVV4ZX2xX3qfNGtqn9cZCsf1PcIBGPCl
	 GNFQOuOT78saPhKfIJZ8ymsBvKgYZOX/C4SC7ca+UvigWJBuhC5zapwhgPeA0EPxmN
	 aVPqeY47SlHV5FzX1PixDQfNRT+7wZYPJoUW7AZt9abiWuxuQpelgiKTBgfhyS0kiC
	 Kq5PvFdrecb5SW0N9Png9ANWp+wJChVBG3w22miRDl2vKsJM5nE5GMY5Yg7MndDVIw
	 VJph27iX0fshz9hakVIa6TByYO9V3IxMEU9UKZSrVF1m5i3OgTRs3CvaN1TVmKEcHp
	 rL4pVo9S0X4WA==
Message-ID: <sashiko-outbox-187095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261027203115.2647914-1-ctshao@google.com>
References: <20261027203115.2647914-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 20:40:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> JSON output mode (`-j`), `perf stat` evaluates metric expressions
> across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
> `uncore_iio_1`, etc.).
>=20
> However, `perf stat` previously formatted JSON output by printing only
> "cpu" : "<id>" and grouping all metric values on a single line per CPU
> without identifying which PMU instance evaluated each metric. As a
> result, when an uncore event spans multiple PMU boxes, `perf stat`
> printed repeated, ambiguous metric keys without PMU names.
>=20
> Fix this by:
> 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json when evsel->pmu
>    is a non-core or hybrid PMU in AGGR_NONE mode (-A). Tool events are
>    not labeled as they don't belong to a hardware PMU instance.
> [ ... ]
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/s =
 iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB/s=
  iio_bandwidth_read" : "0.0"}
>=20
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027203115.2647=
914-1-ctshao@google.com?part=3D1

