Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701188;
	b=4h4YHrd+Q6/Eh4Fov+JD+LnDmNfpVS5sPUjVMf3U1SIuDfZ+Hn2vRjxPbE5I1F7d2D5d
	 cV60MkTfE7IE8y8yaXAxj0ZZP18QHic3Xdc5O03r9t1hZ6alNfpuwkU2l4Ikh56yfm6jf
	 sT4hrLX207WwUpuuARFIsF7IkLSvflqa90JRhN20XIu2G6xZWTzj07VYrXmOb2ajsrTVg
	 9V8WPyyrlzYEywu+mYA6weKYlnvCCHvSzrqYkS8E7RAP6SKvpUkIiuOqTnofAmrRNnJ2+
	 5m0YjVs0hxBv10/7sqi06sdtgQPBMu1ka55HH24zOk8TUGi0a6auFf+NIsdkE5aJBWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701188;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pPvqFgnutWMI3OnZRlc+g55ZiTjuBBZ5hf5xyvA/SF8=;
	b=WbwB8NrVXa2ipTl22kf03MuywlhmXcrDi5b1zWYEEzLZKW+kiMnZEBkB410z62uxAAxz
	 N0QjSj8XHs+Jhl0sBRNpB/tkfQD5n8swlZqRl+l4AlBeGKX8ISXknLZ+9iEBFcXNO/DxA
	 60Kkd+cKMO2prdGhLsK5PwXqsPAfwaGcbuVJVZSQiKzrqZUDIWyxQ0ENxN/hfpvCJ2CME
	 diUbG+Z2uPpQ3AJPktqithL7fRUXAbH14tLzlK28851l3LkTicFEARAMu2Q8PZzjjaxer
	 UrCMZ6IGPYEgY5lnoXBbJ5JT3aSmI+M1My0uWz2wV4Pv88ZPNGqJZIdJwahv4wt9URQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMgklLm5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5C606BFA5
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMgklLm5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBC31F000C1;
	Tue,  3 Nov 2026 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701188;
	bh=pPvqFgnutWMI3OnZRlc+g55ZiTjuBBZ5hf5xyvA/SF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMgklLm5yeSm4gjKgvzQAYbFZgJ68DcyvkYE1UqJ3exkjfUfqbc4680Lm1bJ4ZfjJ
	 vDhLkFPqI1aPU54uZxyXgu41zRrt8kQd6ak0jCRA9LbClUlUGhl9DX1+4yLflnbixe
	 rIW/+lzod4EaFXpaUFg4TUIQTyV7HDlVELIrjgAvcDqTtawzxUR42pusA5Lw8lWKRE
	 wd/dxBuQ24OtQggowXjk+6yAWeN1FdiVfT3rP7hyppc76nsgjQa6UTXAROi4bsX7Tj
	 z2Tg9aBeewSdUD68xapbjDP6UaqtvRootV+09klOo2mdlJXQN5wPu4kgBgwpNnUC7l
	 K3vuVFc7qBIhw==
Message-ID: <sashiko-outbox-195028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] dt-bindings: arm: pmu: Add Apple M3/M4/A18 Pro
 SoC CPU PMU compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-1-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-1-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:19:47 +0000
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
> Document the compatibles for all current M3, M4 and A18 Pro SoC PMU
> variants. Note that the M4+ are split out by chip codenames, instead of
> name for the types of cores, as they no longer have individual names for
> the performance and efficiency cores.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D1

