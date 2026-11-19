Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114634;
	b=S3PLAltrM+D6msnfTd3QcstjxxHs1Vuj4rRVtZA8btUNk87hvV0GxDzTT+8fDEHQbqGu
	 a9JUvCrPVlO0RoAhcDyL8m7lUn2mxMCG7NPiQ+w09fQ7cb+3x0vk6IZnQ2wFEwKxUxE/w
	 9f+UbK5DvAQrCYtsPpJR62PSM3mBSF5do/p0W8vAhK9hwT4zhJ3++WF4WnYM+kTCrtIqI
	 s5E731c4xkfWkxqoP4evokmCgFcYYNSJYoWSfomoeL99kEeg4XF1b240RhytmSkKOcVpP
	 CYNZ3yU4Ph1wd73SrXt97qiY3KhghSDA7PDK9XB6P6cEKoUqEt/wp6dnAp/Av/sni7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ndoGWBw6wqwUYLXZOQ9ApmJA5B9NCdxauxLM5t6SYA=;
	b=4NXuVQDSJtl/6CIT1nCW0Ag8s/ePg9d8yQZE1llVMc5wPcIT/GGUHGDpE9aaxXvLdvGP
	 Yjq+wSIr1vWnRgFnRocnKISRBO2Pr2R4PVLMhjaDLGTab3d6UIjcS9zoAyBcyC+icANWc
	 kqKtafm0OIUqDMe7ZWXjSSJJhI7FFWv/E7ICL+Jmposzoci5ukj3cHW2E60yM4aO/SpkO
	 dfyPuyo9ZlQ1DLDLuvrFgjNBQSSaNH2AU+F6c1zj6gEIohF5V3UCts7XzHCgKJHVaoxOe
	 f/Fhiwvahd/6TyJJH6VsVxKZZSGQhjpy8FyOhJ0gJvgWA2+ZW7bvuHXmkI8DgSvvL4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojEm+2g9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F3606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojEm+2g9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A581F000C4;
	Thu, 19 Nov 2026 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114634;
	bh=3ndoGWBw6wqwUYLXZOQ9ApmJA5B9NCdxauxLM5t6SYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ojEm+2g9VOqymSiTwAum27JWV59bjGdbvQjMpq5iJ0eH7Zr7eDRr5gH5eUjiAOmxZ
	 lgemUCUXbyrHAw7hRx7aG0aFSFgKH1elq2pXrVrpBiqEIacPy+ZnU2uFNHvjvgcgAO
	 +VTf0b7ThYNjgJSZH9+Q9U+tvWUmxHzaVzUPYWhYHepHE0NetRgv0YIg+EXSMnqiYe
	 CkjMM2R9LoN8vI9Y20/Em2Ywb3TjIkvhBTBEGbI+7tOXBzM+fXLhP8IaTI6wE8tp6x
	 GUul6cFCUfAGQcN4uGI24ZsNJJgTJZ5qEWtnrviRdmWrX6VqQvXjUTzEegF0zG4mMH
	 FBVwvrndmJXfw==
Message-ID: <sashiko-outbox-223812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/33] perf: arm_pmuv3: Expose number of
 general-purpose counters in sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-11-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-11-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:57:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Expose the number of general-purpose event counters implemented by each
> ARMv8 PMUv3 instance at
> /sys/bus/event_source/devices/<pmu>/caps/num_counters.
>=20
> This allows userspace (such as VMMs configuring
> KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS for a Partitioned PMU on
> heterogeneous systems) to query the maximum number of general-purpose
> counters for a specific PMU without reading PMCR_EL0.N directly from
> EL0.
>=20
> Suggested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D10

