Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663270;
	b=b1zHYLFbLwJRjp/TgUzJJsKJLEXPXC301pG9AtmvLrEKhdiYfCyBJYH2cBAjAv47zgWB
	 PsdZHMelkeQWNk9GiGinr4Qd3LDdBU4zwAFjLiR+zjwy2Rp7sU5TejNWpBYVU6P4ManN2
	 duvpIv4N4gK59GtGLznvI1RdVAeNHvAzh8x9zwKMw3CasWH+SzJsMIIxq+kY1ZMiRP/oS
	 7EakdfrM/Aag8kiXgzGjx4kokcobJ2qY1Dx8MCiLwT0XBgFfmHsNJ6MUldISqPnyl7HhE
	 t1ejS9J8hpGSbFzCT5LQ+c6LiNeyF0YTZ2qF1Hqpp79gxcg17lNt0zGeFa1PPHWYGWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663270;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rGxSYk8V6KJsfQCIp0RcTnnLQduPlr3yPwgLrv2EpPs=;
	b=jumhuGPB0Uillxj+Am6pO5AUA+5J1A4GcsPZr25qdMRqQ0xiyDUhKwEsl+tISsLi42UG
	 b87gB1lD5YTtA5VQo9189IuksqiXPhhx8/79TH2HTwehjgYLRM2+TxYwd4qpoFYwHyePJ
	 9apYc8bAwDfXDh5S8IefvTJtI/vgAZfkcBbOF9L7BY9AwvroCkDLO2+VIYJczNu0qydAu
	 sxKIl0iZE7vXXeTtUoBVp0Kgin9KJp48m1WFCgG9Owj1YUCp0QV8Hfrsnh5igDFotYbB0
	 SdbKmtuiVU9Kdq6sNuLrMS3QZ54kcvbibEsk2WXR/4Xp6OsFALcinzKvrTw2l91T8LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8VeKKI5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923F1606A32C
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8VeKKI5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155EE1F00A16;
	Mon,  2 Nov 2026 23:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663270;
	bh=rGxSYk8V6KJsfQCIp0RcTnnLQduPlr3yPwgLrv2EpPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8VeKKI57wE1M0hjPz7treYO3WypaNFcY2wvZPYnNEiD2Awq74VMP99Q38kV32V4I
	 B/BC+R/KOd8j2pJi8GdnsG+geOnFrLbkLzFMo4U25RFAxe6Z5yvWYjRnZeJgmc2taW
	 KUQyV9sZ6fT4ZC8wuvaeKzL6WKFWqRGBue6dvQMTCsy0Bx9wCbq0APeyIqVaCpI+Yf
	 +zSJ7/tQbHVlioirPXm5RvvWCcFtGo1cx06Q991i7Q2RgtixTcyYD+zM45Wax/x7IR
	 YEGrH63D52QjBKvFQCYl/v/Zd8huGn8/pecVgtt1SWn57E3pe/uHXqGuux1zClt9d2
	 rF64whJBP11Sg==
Message-ID: <sashiko-outbox-194341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi
 AXI PMU definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102234301.2242242-2-irogers@google.com>
References: <20261102234301.2242242-1-irogers@google.com>
 <20261102234301.2242242-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:47:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
> found on BCM2835, BCM2711, and BCM2712 SoCs.
>=20
> Depending on the SoC and security configuration, these PMUs support
> either direct MMIO access for the System monitor or routing via the
> Raspberry Pi firmware mailbox IPC for the VideoCore VPU monitor.
>=20
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102234301.2242=
242-1-irogers@google.com?part=3D1

