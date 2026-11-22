Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384492;
	b=0wC3mUk4hE1D65WV0fESeka09W6w+Xqlh0d657oMjXGR9j6wQY5vZF2HKsUv4VRmDmRU
	 gCWOhFTroimiSMfDjt2tBN4Rq+UjcCEjrvUlthf55o9LghaDODuaN6UX7RkAC7vlrQMnR
	 VJ4BjB1n8Rm4LxH/ACMXqbjNnuMtEP3qpwGj3wdzBVJmbIT5QAIKgQw6sxdLbaEFy74lH
	 5GQuMY0//b0UBaLBQqpPxuPVmgKmQxd0uTIkFN+Xjy2gh5qtM9Mbrtit8eHmSpVWv0JA9
	 +EzN+GXazPXCRxnftIEAtHB/D09ElBqWE15WffGRMmBMBjma8sjKM2a2FKZUT7BB7qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384492;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qrBeSijsCvjQDZk1rSP7CTTHAQuusJdNSy9GPqFtviw=;
	b=TsryJj5KG8lD7SvOnA0WcbdJZ5uFow/qopFtWy5prlGn6YlEdc2oZRpTbpxLrhViB8ti
	 DhOp1Q2xkicbF1EO9PlQ2p5H3OaIpf9e/nyk/DSQh8UOkeJbMlVQG/mfFuTBCyp1f9t7U
	 NfVro76cBYGNnffO56AtlQe3OM4Agkey+r7AQcDncLfya4uXPgWhMgfqt1YT4L4DXm11B
	 VohbiNsfFjZXAWFCwOfG7A5Bm+2Ue6ml2LR4ueGXMnpU23pS6clEAAakCVO/snlDXvp2I
	 RjPHjsCTu658POkB6MI8t6NEcMN5L4IKIYhADvOkuOsJV3AY8fs0DVxCGXVXPqvXi8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxdeGrT4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9A2606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxdeGrT4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAEE1F000C0;
	Sun, 22 Nov 2026 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795384491;
	bh=qrBeSijsCvjQDZk1rSP7CTTHAQuusJdNSy9GPqFtviw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxdeGrT49d4v8vpf4m6O3emcUFc5sjm0UZx2RfxaAYk0IKIfsK6F05IO4vnAfcauz
	 nV4o7YnKx5TdR7Bxb8QurHH/gko/+22U2plF/mQIYZBUB9qPwxtPWAE6RwIchIlP4I
	 OwBNUON80mdyJnnS1bxyoJJSWp7LUGO5fQ24DL5ag7gDw9kA3ZkqnihLunqPJMU3Fa
	 CddJ8hImq1O6GwFQvgb0T8kOvoPor3IDEI4wyjaF7Y/MTYt1o8J6RJuCea5w0lTjVw
	 fGJDQICwgU3usceY6EURBWD1TZVtkTnYNfWlSzxKksWtwWBrAnRtUVOxA5Gas2Jkvm
	 bhFnuix8vPGfQ==
Message-ID: <sashiko-outbox-228398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 00/19] perf coverage: A harness for perf, and the
 fixes it found
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 21:54:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 19-patch series:

- Patches 1-11, 13-17, and 19: no issues found.
- Patch 12 ("perf test: Exercise the annotate stats output"): 2
  potential issues (1 Medium, 1 Low)
- Patch 18 ("perf scripts: Add a coverage harness for perf"): 1
  potential issue (1 Medium)

Detailed reviews have been sent as separate replies to patches 12 and
18.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122214025.1676=
9-1-acme@kernel.org
