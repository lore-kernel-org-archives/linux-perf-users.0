Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603096;
	b=snwhc3RCLrraNNydraa83Rb/95JNCESuoIYVUZxrJW2l6ydxWbbnsahCQO6cMifsRzQJ
	 9XPpkD5OL1R9XGZHtt1kchMKPaFjBXHKHxZkwpL5TW5Ws+Q0Q5paM3cTadrOpYSmSTLTS
	 Ux6Er05PweSRPwomCtzOtnZiOuZZqNwiHYw329O/u065t8+Q9fn0FL0zIEJnJf9ZVyeAU
	 YQcYzLVPsJ6yB+5GntShzbVORxJD3cWnB3OJhRm0vZPpM2sSoS3Toe4dq4VdlMdr3KTt/
	 PqWfGXBV+PG2a71FYUcxU9doHmorLNc1etF3BAshGij0N7qBWq7OjBTSW7MO11zZi1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603096;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kn2Y+H6fKF9/QEALafftJOCbT0k+QKjg542flZMSeVM=;
	b=2X6amHaMDziq1wqec4MXwJ+z5Ncx5+Yde8Y/zrFjEXDUUB2ntVrS41nkoJBPr7ER4OLu
	 qa0vZcBNIYKBAjy0/nGhzozHaSY2wgaQa6MMNuWbpj9NDBlhQyCazJRJ/aa8gcrlky0Ez
	 3ZvsdXb+wSg1aSX/pcVU4UcL3mBayCGY2ONLQe5+oK6U+wu1zFB7TVkXbwjc5ZI3Ylgk8
	 Z5/Q/cEMnOmrdVjHoxQoRtyQuMh9Xsfi60eb5Zw1uzs/ywZa+PUKNQ2LAn/hr1+em1dXQ
	 TEIvKradF1sMPHozOhKGZnsp5AWjf5/pAIgTBIFSR4XDIde/DbzF4K/FrWvWJ7YoD8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kU7XXEGR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247F606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kU7XXEGR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FA11F000C1;
	Wed, 21 Oct 2026 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603095;
	bh=kn2Y+H6fKF9/QEALafftJOCbT0k+QKjg542flZMSeVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kU7XXEGRZGZC6uEuavP8VY1HhWyJ/P/ii/NCU/YO75Yr3MpO2DVMyfVHj1Oao9T+d
	 upDe1roZDnGIuGmEj0bh1UB1d3ALHiE8nOBfh1KUPFKiQG/FHw4WekarlwJb4tkts6
	 qBnD9wKDs6xC/0b1yiDNMF9zR3vTo1gR+iFScPV875ff3olxECEU0Ur3tHdTcMIHKh
	 O07FdiUucXyFsjWML6Fv05r3F19wyEyvL1UaPuMRo7SL9h/gZ4Z0QNOPl6CXAp6bnZ
	 W0auACNPLQS3tIken0Tf+SXvISv7ZZDrgT/bhQX71z975ysf8plHvJ+LhJr6/JMQ7C
	 ITpuEJ/U1dpuQ==
Message-ID: <sashiko-outbox-180508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/17] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-16-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:18:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D15

