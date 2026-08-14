Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597AA3C2BA2
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719544; cv=none; b=oSst46b7yIFA+rfOwSpA+QPrUm6p5480vHV8d4Lu00HDA4slJOyKDPtptu4sk8ZGrefJBg3b8A6SMtBQsRbh4N4IIscNiIYt0pfPCo3BVxDre8I8qijitZxlBVEIYX43+M0sKaSQmbg+hVVVO5WCXMOz7VREzitv5oUI43jLI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719544; c=relaxed/simple;
	bh=dP+GhkFWrapmaqHEgOxJlYtL+8mCxXx1XMLz7SouTd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OqcitoDKyyKNlg4Zy5wAEQOPOM1rcCAb+TvGzTgJdzttCgc5SI42/ChPKjgBraDVRvvNDA1MGmTNcRnK2DLQBYWHfC6X6gFBDL8DSee2bMXonLP3TGGwgaabXiDcrnNu7IgfGasixDF7y8BdNeioB7MUR8iiXS5zgcW76TD60OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvhVPHPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvhVPHPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62DC1F000E9;
	Fri, 14 Aug 2026 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719543;
	bh=IDE4FOLO9pxJNVvdGdArsmj7NFgkTRHpSB7jfVx+3TI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hvhVPHPPUzzPOZEES75QT2WkNApzh/IEXZBrJBgmoGeplvaGjiW58WyvBRQ1LVWS+
	 Cg9Mj1GatuI5CZ52HTt7cL9w/tTJzKr0bY66riQKiY8njhEsggEfPpMOG+YCuf/Ysg
	 Xz0WKtNBftZUljCmHHttFUW+7lVnBpUQT7i+z3IuftCU7m5EtjVdRgoUWTvw7wI+nY
	 Qj+dd76M1QM4F8nAQhqVp3CpzbHM6VR80Pj6IUYSVXnLRvq6HVs1Rbtn5yD/AK5mqt
	 mLhVfKofOUBT/f4ofbhXdIqw4fEa9X5QRiVVW18jogYGbZjEUdMZlwua8XLRwkqcS1
	 O76vgXvy3w48g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] perf/core: add AUX ring accessors for kernel
 consumers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260814144927.489172-3-kunwu.chan@linux.dev>
References: <20260814144927.489172-1-kunwu.chan@linux.dev>
 <20260814144927.489172-3-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:59:02 +0000
Message-Id: <20260814145902.E62DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Kunwu Chan <kunwu.chan@gmail.com>
>=20
> Add kernel-consumer accessors for the published AUX producer head, the
> consumer tail, and copying a possibly wrapped AUX interval without exposi=
ng
> perf's internal page array.
>=20
> Use the same memory ordering as mmap consumers: order data reads after the
> published head with smp_rmb() and order completed data reads before
> advancing the tail with smp_mb().  Validate cursor distances in the
> absolute cursor domain before applying the ring mask, so rewound,
> already-consumed, and future windows are rejected even across unsigned
> cursor wrap.
>=20
> Hold an AUX reference while copying so storage cannot disappear under the
> consumer.  Restrict the helpers to buffers owned by the kernel AUX setup
> API.  Document the API in
> Documentation/userspace-api/perf_ring_buffer.rst (=C2=A73.4).
>=20
> Co-developed-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144927.4891=
72-1-kunwu.chan@linux.dev?part=3D2

