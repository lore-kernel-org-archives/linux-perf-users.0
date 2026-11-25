Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628208;
	b=RcROW/r9I7lTlADckkmBNwv7Kcfd7nU3qW4GqSq+BE3zaamYsHVpIzEOO/bY/3Ue/mxS
	 6iIRONwtjoW6zFLKIy6Udvx3IbnRHzYn6LEzWuYwCBCopBSsCHfODOzETqetam7k7t1Bg
	 75+5lZkYai7DYIn1QvOLkmwwxRTtCNmX7kcTnVpdWq95YJDmf6A6QD1j+Y66lJDdVRRsA
	 gmNH3qk+EDIw+PTMMmHuRD2pWV2vqosEN0A/IuH12stLYb29c1YI7zKAjrmigkemZySeT
	 QItbtNFO84IcVGMhb3OMJBimkwNSdJfNApHZyKdKkq6S/4zlDBKPaqUk6EkbUa/Yaog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628208;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RpaJc5quY43w/5Z+x/FVriFhwpQ9urC41j0IXzQobzg=;
	b=LFMgNk5yxMbzj8JCwaSB0tDRJvk1EyCpyCDXL3X5H7KfjSxZ440JaglV9ZLCIdxuw4jY
	 UtFtSAFwEi0fLbilCPG+xVsKz+bIkeLSq3XA2WqT0RwP5Us8n1+v8K+e9Qlr+ZHxZ001v
	 iBfkf9ZuyQSVtkMJWUieDS2gJe7Jm/J7s/v7gP34DR8DlbQP6u1/voqcPeEnUuJ93Gi/f
	 SFmB6a3hzn34226e4ET5kT27sfaH2M9DOt63HtNrrz/CTdULtctDfbdSS3kfhqkxUjpMI
	 hmd06LzObGhM0hZEgdHoY1SD0tniXC3RScgIHrSw61f3aKw3scnKHwKDoHtQ5R2hn+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMzdTOsT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E43606A323
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMzdTOsT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18971F000C4;
	Wed, 25 Nov 2026 17:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628207;
	bh=RpaJc5quY43w/5Z+x/FVriFhwpQ9urC41j0IXzQobzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMzdTOsTJeX/0ktvPO5L3dkQpUimHfxOUlAdGNo6ou/ex/qEOJFQrJXECeBifmW30
	 L6CHiWxhzVwDY7BE2GZl2XqovYY5Y+OP30sa4dHbNjeqzPtudkoSCON8f1tyuj+5iD
	 h2Vs6SJE2bX7UiTX1o+ZaH97nz1k+u7CITEMkCYib5BMrCt3J6YfEm/u9/+nCIK2+V
	 3QhwnqQELDG2jIhRJooG/he8mBiTrBiB2cNeJgF7yEsTbIF7bRYp+xnpf/F0NQzQiJ
	 1qTCV9Bc7GhHLw5u/xOAzwKowu2OYT2ps3pjGxnKFU5Ij1QUopM695IXEqgI8Rb27c
	 1xIOrKp3eceHQ==
Message-ID: <sashiko-outbox-233847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build: Replace the deprecated FileType with a
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125173315.2359128-1-takano32@gmail.com>
References: <20261125173315.2359128-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:36:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> pylint-tests and pylint-pmu-events hang off `all`, so with a pylint that
> reports W4904 the build fails on a tree nobody has changed.  Measured on
> 7.4-rc4 with Python 3.14.9 and pylint 4.0.5, both targets exit 2 and
> pylint reports:
>=20
>   - W4904 deprecated-class, argparse.FileType: pmu-events/jevents.py:1494
>     and :1496, tests/shell/lib/perf_json_output_lint.py:23
>=20
> FileType is deprecated in the class's own terms - the docstring in 3.14
> reads "Deprecated factory for creating file object types" - so the two
> jevents call sites and the one in the JSON output linter are replaced by
> a helper that opens the file, or hands back stdout or stdin for '-',
> which is what FileType did.  The reader names its encoding, as the rest
> of the Python in perf does.
>=20
> Verification: pylint-tests and pylint-pmu-events exit 2 and 2 before this
> change and 0 and 0 after it.  The generated pmu-events tables are byte
> identical either side of the change, checked by running jevents.py for
> arm64 and x86 over the same input tree and comparing pmu-events.c and
> pmu-events-string.c.
>=20
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran the build and the generator as described.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125173315.2359=
128-1-takano32@gmail.com?part=3D1
