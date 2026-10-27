Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124451;
	b=UQhtVBLkRzPL1v1yX5iRtG/35ZHVmRwf1z8aokZTb+udFRZt/e4/88OMl4ws+fmC5jrn
	 Jy1hX4Cf0PKwROt4GTXde641xUtygyTwDUR0DXDS1q5rtabbbPLRgcenuKy8tou70YIgF
	 1wiHuohULAmznmy8gi+Ca1W1X5icOLtjn7ZAbbTDJps4YrCk7cPRvJ3k3QPJ+gYvOpPQk
	 uy56Wx141JQGUP1I2uMTlQHIf8DibgCnP62PKuhI5UDwe0860B3aPtaKt+rQddLQ0+0mr
	 Qr2fQYZuMEr+UXum0Zsh4gz3TpS+x7QWq5fI7nikMP5GnaPdtZe9AiZ8Icd/zG4tEjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cZgeeJo4+IsViNaWBNfFfzWI3Yzri75ewoktMPCKqbA=;
	b=QaQaxL3MVdbmXLNHKqwpyW0bYl1ofbtHyqZGpdR7Moga4SoVf7l0JvBRYMlBTTST87G1
	 8N9//bZThPDS6XiNLHV4C9267A3m/aqinDN3+WDMOaDf8nSA7tyhTRR8TCQ+cKcjcUkNQ
	 vUJUQ8i9aaOlpp1jal+BixweaBopXg9K91R/UrvkxkIptV7UunbVE3CRTf3n43DkBG4wd
	 35MvJfdOhdAeVlt/m6Phx5UsKGfbqDuw/56LwpgUtyGh7Y+9aVKur1SNNQPUadDIc7xkR
	 1UYsgIWhGhUWAErGLwNxH5v2D0f7FlosY6raObY7CX0brCrADGO4NRRst4gCZuSEcqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJIl8NhC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188B606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJIl8NhC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B25C1F031E5;
	Tue, 27 Oct 2026 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793124450;
	bh=cZgeeJo4+IsViNaWBNfFfzWI3Yzri75ewoktMPCKqbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJIl8NhCOQpJcvRmHHMJLHfxAkTsSsobDWGtRMXspudhZx5oaWlJ0l/dOSUUzcbUA
	 0+C92H1ZrP6CX70bYrBVTVoQ/G1iLtqSJa920ppEehvK9c1MoWWUHXxtaxYaxeq+RX
	 PCcTHzAl7kIVHZMPR63biC0dMrERSqaTyrGa9S9PnwtGGuu5lS0a8ig9E0jVPFtwFR
	 KCc0a1FND288SeFtyWFd0ZoWcSAACSDMZeDOrd7GJQrMa7lqUHB9UEgU6F9cqdUARy
	 O5sYOm/T7BoSEtuFvmf5ytQjp1smfDQiNAHOm97sG98B3kMDq51uRe1cGFpT9LSZkb
	 ngrWgtB7b5xzA==
Message-ID: <sashiko-outbox-187001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf: Add Broadcom BCM5301X AXI Trace Module
 counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OkFSTSBQTVUgUFJPRklMSU5HIEFORCBERUJVR0dJTkc=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261027175124.3518239-3-florian.fainelli@broadcom.com>
References: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
 <20261027175124.3518239-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 18:07:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Expose unfiltered fixed counters through system-wide perf events. Keep
> hardware free-running and use per-event baselines, locking, and periodic
> 32-bit delta accounting without resetting concurrent measurements.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027175124.3518=
239-1-florian.fainelli@broadcom.com?part=3D2

