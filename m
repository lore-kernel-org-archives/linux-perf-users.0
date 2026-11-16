Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812761;
	b=jgO7F21L0yPWUWo0d9GPrdqg5BFNV75IlaMl97z60gO+NwZb/SdLTFw1c5k/TZ+m8pcf
	 2UMmNBJ5pnWihhf2gXKSskoBw6qmQZy/pQdVcJckqurPc4k/0/i/9mxuBztHvEAOzcNvP
	 Cc4+W+C91qfLMxsqvkHIUMsJFXSl8m8Dd5IVPG5k7m/mL9fZF+xuzZNl75YUhJaRb7Wuc
	 knGlZeULAp2Nnzq4NbbRU8BANeBg32cLaOMf4KP2HOEr50/MulQYLUI7rPaR6EnJn1BfQ
	 MRpwYwuNEbICzxR12FhIFWLKto5XmeVG52QouoSR4YW8BERlAqBE0OftE5ZaowLL81A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xv3fh+JgaQYYINHfPq5Pi7O/QW3CQlovfxCJJVKunqY=;
	b=Dn6mamscJl62SsfF7Q5x0ijkvM+Ah3D/SZZRte9k8i5W55GrKzQYp0UcQ7KNpL0xaeau
	 qtHJB4OFfhZi/J5+hkAx7NAPsfuV4kVqx5PSIrrX6b7jxzl+1BvqJeWQ4GSV1FF/+nGwR
	 a4xN6QHBALDiRGsb5mfbLSIZfCrZpcR5dB7Bthvf7Op3Mrebh9ky85pv124iaevnq/cRd
	 uUp2JU/cxS/ksEasLqFCZJ3/Mzt4Eb2lOVbfNlhz5kSwvDd3iqLcP3tp4AoQfWVX9Ginw
	 jZm2kLFf9TABlIL7Bp4TJxOvsqFQbU8aDUYHRkrw258G85HiWmtGVXDYUEEFPFX2pPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4+BEVIc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9D606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4+BEVIc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB641F000C4;
	Mon, 16 Nov 2026 07:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812761;
	bh=xv3fh+JgaQYYINHfPq5Pi7O/QW3CQlovfxCJJVKunqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W4+BEVIcSYIxUne3oMcAFCVkBy2NF9UOY1cSDIX2cRnTCw8UpNoLB/YZSn+9jzHms
	 IxXUnXxoZBLRpEaWFzXw5LPTyqYd4apl+ebDsUnM+7akK5sya8LafSPILei5ImzFDr
	 oQS7fnD+MXlEoOMr4OoYUjg7Bswo6a9tAbclxX40SNVJZ82QgFUTpSH8hhia8DPXri
	 8uvBFKNtpdq4GTLYPOXYB7vpNhDFoDl1wcXU+5wsh8J6ifwP5hCR4CVRPwjjqnEcZM
	 hmmMhxJoN55TkNTINrTyvXZU4fJEumaiIER28dG3gjDcM/MXlc89i1HVxnq0JDYTJK
	 mvq2K7pZUbXLA==
Message-ID: <sashiko-outbox-216378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] perf jevents: Encapsulate big_c_string lookups
 behind pmu_events__get_string()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-5-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:06:00 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D4

