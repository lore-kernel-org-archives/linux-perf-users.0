Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623773;
	b=NQ2/z8gTlrDuqcf8+B4HsciJo3Dy3ZRQYKFVLeb2NJQFoom3jXU9n8+FpQaug8tZRuNI
	 gFSYtayLjBpmd2yxgiGM5QjReWAx04ri/u0dSeP4DQMkPpzrFGP6MP5h8ntzMZny8lZDv
	 UknG6Vwhf32X+2t4JmGhviJIm8YTfRzQnZP7EMTfqI8woMzGhrLfDK5Ry3rhJ4sdhmB7m
	 08St0zGq0NLe4BcmSQnk5SNXxy5mPO0t94JPVPPrlB5RYffy7yLMLRC/gs+nViPm4UCVj
	 h4bGw2nx2POEjrr1r3YHm6/Qe+r7EWoVnLph1QmeIJyXTmN631cz3BkWvD0tdtOz1XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xGndTPg96VfLGxz/GzO+8QbKxIfPFjRCQ7OalC7e3os=;
	b=mh7NzFlVJjz86fdMZk87IejxKOunnkOKrTcNvhcOHqi9SQ+cC7+M4rdL6yambc8GdUQa
	 YwEDFxswtTQULVHL/NnoXfAy50Zkj4D6/yAUwiIVWJjMLEBfEwaH3IHgDNMC0ofLGoiek
	 xHUQU06IRUzKA49kAyb1ybtmaj5XN9HC/gmlTRYZQZyuazk0IKoxYCxcOxmuSDoBbxnwv
	 2KB3+j+3PABkmrp+KYwxhyFXhluBimjzO5Y7DfcD2hBWYvCV056zRZCIvBAVItnXM5cQ3
	 vnisZw3LbGqSZzZyWYYBXQLwdF/dhn6OO685CWIb7jeeZB1maMLTBDPrIe0Y3jIa8kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kI4+a/vi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5270606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kI4+a/vi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD9B1F000C1;
	Wed, 21 Oct 2026 23:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623772;
	bh=xGndTPg96VfLGxz/GzO+8QbKxIfPFjRCQ7OalC7e3os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kI4+a/vizJVh9YoRPez33ehoQ26c/3Fo3n2zGXKUY15WfNpClf8EMXXEcua2UsgyN
	 GPEUK6dQh6UPzLSWoRVeAn+K/MpwblR9/PR9s9rKp/9wtt6edOzQ2JSnCZchyCQQIw
	 BdyhcbltstETYF4GqtS6EGX/MI5H2J3hnHmy9fNu46sc/Cj+X2CF8nVaudvhwnduJg
	 4t7BpTCvfAvD0Ld39XH5zE5HfeWecXB9T7QB1sd9D1VDYkbp1k0GI7xxoDCUBChkE+
	 oiG+wXmhLNZV/nIpGV2RXrEGXrHOGA45iDzmu+fPOYyN/Pq3h8kjmjq7x0AITjvmjT
	 v6rDHlQPslznQ==
Message-ID: <sashiko-outbox-180760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/17] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-16-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 23:02:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
> bpf_progs and cgroups trees in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D15

