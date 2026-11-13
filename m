Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604334;
	b=Y/PgNhSgAuwh1X/CnsCe7FBjN1eKOz+XE8IOnresLnHRHoJ76C3sfyS1+gsODVD//udh
	 o3b69nfhsyGqbnLaiGtVn2l4VXuLon9NXDa0A1t/9XU6lTD1P13AS8mWcZ8g2K6tGZen/
	 UyF25SzVm1eJM738qBSMiuadYhHJiZtqBSEQnCx5iYxtCmsDnqSRdIVF6L/xPHzC+G2iQ
	 FAsL6hlj6PIwIoCiP5yvGpADzBptvKvyiytMfd9uyfcUWSR4LxlimGshJe+stYKEiIpAg
	 IHsYgAiDvhw7n8I/2gTtmUSrO7vNq1vD9MLmMSo4GWWBfkVcPXSR1DThzmsegW3aaLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604334;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rEmXroglDLmEr4EF3tQ15D0kzZzMFYnqQuuTa8fBBNM=;
	b=jZFZ65GKwhVo/H24IzN63Tyr/zwtquFm1RrkzKRgq94KsMhZH1/iGYihIXfdq87VtpS+
	 X7DQEDgaMeFk1yBBmdQZqL9WuJmWPq9m4aqpYu3AiEZ3ahHvqh28je2MPac88plRDc2RC
	 P+9RU9f2TGKt4hI26aN0MitoCUCJvlOmz3oqCLqPI0PKpiBUpHpFf6tZOhzu4WRuawFfA
	 dCHKeNIwt14REBuMm+lyp41S+0tLvfl4zQCFTKe0vimnzFMVnqm/r+PNCpxO9Jq/LnN7C
	 D1lMqp9oXau1D7UGDwLlAibx4S8dM0sG/hApu6qfqj7NDh38ima4vE/RSilzgzeILnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TZ/kC8c2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4841A606A333
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZ/kC8c2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC3E1F000C4;
	Fri, 13 Nov 2026 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604333;
	bh=rEmXroglDLmEr4EF3tQ15D0kzZzMFYnqQuuTa8fBBNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZ/kC8c2xOrv9FLCNtZl2kq2ayRy0N1Q2TdLoVZyU3A3SNo0HwrXXC6BaA5C3qBkf
	 p9+aDSj4/YOv/gwqDGf4JnD+lQ8+2zcVXOshtzk7FEhSesN5eJyh7yaL/rVDxgaXHj
	 +BPH1xgtYtewGjWhhbZN8oRZJuBdK9Ndv2OJmYIT2qIyqIVzJQ20AGL12zm/mTv6d9
	 k60JRbyIi2Hx0mbz1yAxz1wllfjMPFYI9SBWiXRkwcdmbO+R7WoQMGvVNYHvAvhhPH
	 7uYfSTYV8Kj+yECa9qaIUzL8y4QYVJRICK7p1kOp4yJEdPaeAFoGosZ7lsdmX4QBZy
	 e+Sxe9awP5lYQ==
Message-ID: <sashiko-outbox-213693@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] perf jevents: Encapsulate big_c_string lookups
 behind pmu_events__get_string()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-5-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:12:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace direct &big_c_string[offset] indexing in decompress_event(),
> decompress_metric(), and describe_metricgroup() with calls to
> pmu_events__get_string(uint32_t offset), and change compact_pmu_event
> and metricgroups offsets to uint32_t.
>=20
> When generating a single file (such as empty-pmu-events.c), emit
> pmu_events__get_string() as a static inline helper indexing
> static const char big_c_string[]. When generating separate pmu-events.c
> and pmu-events-string.c files, keep big_c_string static to
> pmu-events-string.c and expose pmu_events__get_string() across the two
> generated translation units. Also add explicit POSIX standard header
> inclusions to the generated C files.
>=20
> This cleanly isolates the string storage representation inside
> pmu-events-string.c so subsequent patches can replace flat byte offsets
> into big_c_string[] with block-indexed string compression (where each
> uint32_t offset encodes (block_id << 16) | sub_offset into independently
> compressed ~8 KiB blocks decompressed on demand) without changing
> pmu-events.c.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D4

