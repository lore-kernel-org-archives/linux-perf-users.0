Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048819;
	b=YY4cyvB3f3/ZLzyjfZl/nd9CUIqhdySNwBoBoRTx46+g0x5HRCcdj97WBaTVHCOX801y
	 iwZ/NL97vOHi6qNop31HrLcrDbZJvLhdLGvUua2iOzp299lMWogiXCa9hs/nWNK7qfRcf
	 5y0sIDplIcM5Y6gQAzeMZ6wOy9IZgFDPleP5zv49vmeAVFpexLtRrIeOz3Frig+NE6vKs
	 e2U2cIRpllBFh6zFTG/D4L7Z/WXak70gRmsOlKNflf2fhaHCsurxOdrqWXBX0AwFb9pqn
	 95lTBEd+puP+I8wno4UhNYDOH0KRKfwT4wWmZjp/dquOLshKAxjWWqmWEwH+ZDO91TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048819;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xsYVk61B6f438fzWaBLZDZdIkV+BccYPTtxgRNULbZY=;
	b=ICug984EMHbRgSMmLXmbnKwhqQfMxjZ3FRvZ3X+QsBDwMmW2qKEseij2ZVTIREARKS1V
	 lKu1tpu5D+Ew5wx6Y8yO48Xb8h0WW1qZL5pNBJzJEx3JeGUp8iUimoY0fcTsp/9unD9xP
	 4eNovemUe7Ym9jFCtcJwpL+HvSKQEEmsA/uUkq7hl1hdRlf4E88d5q/dPKm2j9T2VLGXU
	 19L3q2k7deAikZZjHOxksM07AufB0lvwTSDoPWgrIDdjbPJWA4tZ8yuHjHe8cFGdnyHEE
	 YlgFSuWI3bR4C6oETFp7HUYuSHefAu1EsWvnVeg0as8g0fNQewCB2EzMjfo1PQr5vww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5ki3Dpu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2E606D807
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5ki3Dpu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919841F008A2;
	Sat,  7 Nov 2026 10:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048818;
	bh=xsYVk61B6f438fzWaBLZDZdIkV+BccYPTtxgRNULbZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N5ki3DputAP/cr40CCiuDLJ4+B8+t9/pdSGx1SSZhKnYj++wQR6pn35IinzVvLScq
	 Xyj0AWRMbXFU6/Y8FIiiwmE3LorUZd8H6CXV25oZZhpc36PNvH4B1xK7htSqTK5wVH
	 93VDTYjS8BN0xvhZELnTV1wXnu4d598s/rRP++EwWjc7uKA4PYJtRIjEENvjZNm39Q
	 vz5V7baqukKdFxaLyup4iHkW0PCnQWZ9h3ud29zG7jdS3UlABhTWneeDBzGIpG3kCL
	 wOi+V2Kt08E2QObBOS35mUUdY8OfoxXcWArQJWPnMBi+oG2+Zl/EWTmKWNO5yHo9xD
	 HwJ2ahZu7X5mA==
Message-ID: <sashiko-outbox-202826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/15] drivers/perf: apple_m1: Add Apple A18 Support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-8-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-8-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:53:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> The A18 has events and affinities identical to the M4, so use it.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D8

