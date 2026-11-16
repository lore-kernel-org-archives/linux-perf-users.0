Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812792;
	b=0wu/iHuIKYcQbc3rlQfpZmjK9YUwYes8J25HaTKlx5QvRN9bW9Fk5HhhpTJv+EWPisw7
	 13peAnTerBrfuiKcnP4fBzbXm6RMmmW4g//hjdlEdQB+vEEg/NcrZY3feOLX1UoE+SpRI
	 L61UGnRzttfIKCt8kKz2peV/oB8nWC8eD5lEA8oLMRLtn3yC/ziQtrQ/WinzMXu3YAbFJ
	 YppFhmlHmLrlxNn9ue4pgL77YAC7oke4QgqFs/WX/vXLNkItA5LKY4bWRpdcCa1V+Wv1s
	 A8HpIjxU1KaWv5jVLQ9hJHSa7tP++RN5bYeEGqr++5uf4UhYLlUsK2sCV55NUrPXPmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PHeRgXJ5c/88wDE6WtkFiEFleh+LU4lYzDW7TILmSlQ=;
	b=rp1XiLv/hhdu2fmf043fYBttLc6MH6lETVuK4b50cTcEgM5WZMJotWTa7ej25tf2CjkX
	 zQg0YMbZdcLuJB5obMpv9eWgswuGJNyNBuMFYi/faZbvvoC6DFlaxS3BYlZhrQB6LzjCq
	 iWDcbE0/vN933k+imC4vEnHVQn1AXWevQc7v0RYVbcgM8gEZC76i+m7afbcZAH/8G3xH1
	 HRqjVckbaW+cebR6X1W0DgrQYr+wiB3BHAm2F4eNxgrNH0RJUwzN3m4NVU2PPW7PZ+eM8
	 3CESHUeetQI0ojuFvplgTlnyigIWs8122kHdvDjMzOzby/wZQOCFKnKS3poyvYY4v1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiyAQ0ju;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF57606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiyAQ0ju
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E16A1F000C4;
	Mon, 16 Nov 2026 07:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812792;
	bh=PHeRgXJ5c/88wDE6WtkFiEFleh+LU4lYzDW7TILmSlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CiyAQ0juNBucew0+QbUzfDdUKEjdJAUB6H5DCSbVK6+MZUYGRGUsKsKbNdpi3ZzH+
	 Ip0yx6w2fwJJORBuBF6BD5m4teNgkqE1eUIIIrbpcq4jhuDK8sBHG/23eLUmmjH11L
	 5Mgc/vz7wvo9Lp169pkyLdZ+otkpv6k8AgUQhXW/mc6rOoGgYzozyvHwsShvZBxDqP
	 guGeAUBO3HMvKMxKqWQZXEQTjK8Yog36ZtOhC5WKbUlIkcCSH7ngbsZlkTjcp+7Trt
	 pDW9cTUeKSJCo0j4SJK5vtrkhW3v9/NOzvkqsctpl+Bf7Xx0oU4Z72be0hz3Vctq2i
	 nPs0jZvGgqtFw==
Message-ID: <sashiko-outbox-216381@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] perf jevents: Store PMU names as string
 literals in struct pmu_table_entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-4-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:06:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Every PMU table lookup (perf_pmu__find_events_table(), map_for_pmu(),
> pmu_events_table__for_each_event(), pmu_events_table__find_event(),
> pmu_events_table__num_events(), pmu_metrics_table__find_metric()) scans
> table_pmu->pmu_name across PMU table entries to check wildcard matches.
>=20
> Across all architectures, there are only 68 unique PMU name strings
> (536 bytes total) across ~443 pmu_table_entry rows (which already reside
> in .data.rel.ro due to their entries pointer). Replace
> struct compact_pmu_event pmu_name in struct pmu_table_entry with a plain
> const char *pmu_name string literal so the compiler and linker merge the
> PMU name strings in .rodata.str1.1 while hot PMU wildcard scans never
> touch big_c_string or trigger block decompression.
>=20
> Regenerate empty-pmu-events.c accordingly.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D3

