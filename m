Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600866;
	b=nSSbuCEZCFUcEGHvtI8jdFnKVW/PxiQbSubLnXdlhGE1mvDqkj3VHA5ZleDp2RXFrqu/
	 IsiaQ2GwvU3hFE7nPmwaYAZnU94tKTeviTJ1ATGERmV8fvAKvNR/KRRQ3bDJztd0WT0/l
	 dwWmvX1S8McMS6TokVYrbta2fRpwbd/yjY04bRfHyaOLxSfsGDg+UPhPOrw95Fx4tdyOG
	 quLoQTb7ZW8DsSRPBD5CdsFLY1MlFUxG0ddbe/msMkhi7YgASNNVbJbYvmlAuZYKhPjXH
	 TuLTeuzIbfpf6mAJwwIJghtELajAYrG5oieXEmu+StCg7iEDiwmizWMZLA1QvLzOb6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=32bYy2ysQybawlfjEUgUmqO1t3m38aKIFHgec7/05EY=;
	b=RC+xFIIAi6yqOH6ENAzI3gvoaXugZVIX7CmoLJY524BYmHKMxAL9zdDT5QJqToYbL02i
	 DfrZqAZry+uvmO59hNX/zD3m6P2FS16iC6X02XzV03OdyOPC7+pdfBefroS87iRPSn3s+
	 asKIk9OwSTn+k9FT4L6Hcr704J1VI77B+h3fe+zGKtXwCctx4mRZ7QyBx/0UrhwhxXTHA
	 Jzqf/AJbhFV0/ALUl64e6taqxvDKfPuXhBfc5a50VfDUlq5iSreqW+/5kUiM1mpADGJyw
	 Fl7OYfuTODkbRJ0ARaGh9CnDUaVa1bG5M2C6WV577jQtB5C+EnAo5VuDPryumGnus6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAg+iMLI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9322606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAg+iMLI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB331F000C4;
	Fri, 13 Nov 2026 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600866;
	bh=32bYy2ysQybawlfjEUgUmqO1t3m38aKIFHgec7/05EY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAg+iMLITS1ViF9YBTpDjs1k55M0RQNwd22T8a2p1Aw9gt9ZybxmncKecoCVStexm
	 9BogMedTBsUAy4B7mhBlNKgnmzVuF/AASNW06PchNHUeSdCHF5KgXreLXeRBVR0X8J
	 iVmdRjuE1QOpDgH7SnwWywj0PfntcD0R0ft26Isrcuy0NyX8wJC4J9eWsfRbTShJIl
	 45n9tzs7RzSB4EO/IaIJvB1Q19vZOO1o5k+y2SW+vkvyP+qbySyGWMR0koEeHEiCqt
	 H+OgK02L164h+IVceiomgNUxs7Op6YtoxbjHD9VsCwx9oh9dirrgCTn10PDQL/7BIA
	 G52W8RpsHa3zQ==
Message-ID: <sashiko-outbox-213630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/30] perf stat: Share events between metrics and
 command line events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-25-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:14:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The metrics added by -T, --smi-cost, --topdown and the Default metric
> groups were parsed into a separate evlist and then added to the events
> from the command line, so they didn't share events with them or, for
> the Default metric groups, with each other.
>=20
> Parse them directly into evsel_list so that the evsel matcher of
> metricgroup__parse_groups() shares events counting the same thing. Only
> mark the newly added events as skippable and keep the evsel indices in
> list order after sorting the Default metric events, as required when
> writing the group descriptions of a perf.data file. This removes the
> copying of the metric events from the separate evlist with
> metricgroup__copy_metric_events(), which crashed for "perf stat -T" on
> an Alder Lake system.
>=20
> For example, "perf stat -e duration_time -T" now uses the duration_time
> event from the command line for the transaction metrics.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D24

