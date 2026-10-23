Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741239;
	b=FUy+PoBGDIaGj+6UhkuCdQXSroUVmD/+p9hrd6VIgwGwoVQFeCaN71u/miXN46NcQg1l
	 d6qzkJhINQTqDajc3cun/XSwArjtmQbRMnDfyRkrCpS3oVcoPoCgjiepljHmFYIBn/1XF
	 iLzUr/RO082gTujZErChc6pJpmuiL3bU7acdZxLjeNYfwvZf8zSNdWBQCZo3PcJwq4CT7
	 6+6Q13fUNBqzQFXMBfpPkk7JqoNMIFaVoWgqiLkQkFxqFqMTKUjWTEuBQHrHECtGHCsyn
	 88xKLpnyUGvAN6zaQFOAZgjdZ3zwpsBIemps7sv7gcoGz5mCe/JF22TUSSkg4nYU8ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741239;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fI16/jk6XLCUyJE52ytjw0cpoaWg0aaqIdn/ASz2em8=;
	b=MMbu47XE6XFtrzyqkdqcPAsQNZ8daZ+36JSVWmqMgSvsMcRWH83aZgjhA/nHxfZrA5Zf
	 1JmY+v+oakIJ9jq34kGcL66DSSHdEtrAhDaunorE8igahSH9umar0ik3UrUVF3ZeW4GfP
	 bsCu0I7gNdrCPoj1FCLa3wIcGllXNWHpru9kbUdYKBnCsmW2rfXy5DNQyzn3gB/jtsi4r
	 6rK6gUw2h06oSFNvHpMt6Su/hYYEFNAfv6Uzt7guJSxG/1NHvJpcQGE1v7y6Y+qOPX8tI
	 cEVXqpl8ZSu7J1LEdVT3E1+YtqmlATDWAA2McOVOQoeNLrl5ArPSE0hUCVOn94Ablkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGj96hD+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445E606A31D
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGj96hD+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260F81F01825;
	Fri, 23 Oct 2026 07:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741238;
	bh=fI16/jk6XLCUyJE52ytjw0cpoaWg0aaqIdn/ASz2em8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGj96hD+dB+l6W9QVJ2VLh/rEEKsKzQF1yrvRHbIeiZxf0lezTrE+jOULOvyqipAp
	 WxmBhN4YrSeDWO0UZm2GTZ3JK78XOjCwlM37RUKdDDdiG4YFdfWm+m1KrX6aysNtsJ
	 aTr3zO5n6l+Hu2Zn+cZfNB5dV1pAN8WvFUMJhWGRPEk7PLiO36D3TK8k15ssuWIdu9
	 vk0KJWIiknMaL/UvWKsJrDOaPJlhvxUJ32dRWzN7TZ3OkIe60r9m9GhjLWxM7bPC/T
	 kAYXsIAZDrs4/4vKMMPUcZKS+1P2VS+HrH2YX8GC1D5Z5UulCjlposcUufblxDaVml
	 kO+yJdZowZVBg==
Message-ID: <sashiko-outbox-182427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/11] perf tools: Export
 filename__read_build_id_ns()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-9-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-9-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:40:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Export filename__read_build_id_ns() and use it in the dsos callback
> and perf-inject's dso__read_build_id() instead of open-coding
> nsinfo__mountns_enter() and dso__filename_with_chroot() fallbacks.
>=20
> Assisted-by: LLM
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D8

