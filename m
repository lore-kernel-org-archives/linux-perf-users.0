Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486746;
	b=hqThEW/HlJzQNQBmNQ0nZsGobuccTxq3uf/lJl3WiccGAKKXn/XcZ3wi615eif/1/IDQ
	 L58LmoJ0ycxHdwJG7+9JEob6+1s2TOUBXCL+c1xe2XJsxGtP+pbvbMGzrTa5k+t8Ju8m7
	 pA/lHD8jIOEBZWA72dMXHMYv74m/0yBx44pU72N0W00QsqPwLHdJRccVBM9dWD2EicSvh
	 GflZUKuKKE4xImEp8DNrKMk2ftvf6oX7mU+2bYg8FV9bMP6a9VYFntIMYWNpgMgFq6vDZ
	 jhTno8Y7xq0IvroL797jP4zzptPXCcE73ddrF1wSdWgHDvcQMIBcclhnv4jT1+eqRLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E1lkNiJEwQN5t8sSgN4ojZ1+v52zFbs71K2AkBX6TvA=;
	b=H+eOlx0CgTTYwWxuBdKLrA/R2Cp+rKxkIp/T6SEByuBAtDkoK3Rt/Hh7jTYVt4c3WP+H
	 SbbQ59zkONFHDrfMHtPWoE+HWAzOm5LWnwq8D7wJjbtDAyjhUentvd5nAdlknli04OMVP
	 14ABFr0Vu6rIuWGIsK9Inc7hidIjEMukNoDjPdVTpPC4X+ngaXRC8j3GvXcqkBYVECBfm
	 vuFcL2nH9/dmXlBi2fodi4DdgUhOCOQVQQ8u0onjFV0nb/AodhPjMXrLTX/4UjxCsvJs6
	 1VB1oe4VROipWCpYe1uoC9MmH5f4XljW3sZBtQzn2v88PhryGQP7kORyWlnZglKxnyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvlxgAnX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C458606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvlxgAnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F9B1F00A06;
	Thu, 12 Nov 2026 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486746;
	bh=E1lkNiJEwQN5t8sSgN4ojZ1+v52zFbs71K2AkBX6TvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lvlxgAnXPS9sZUT/BOdow9iQtOZXZ33RZd+8LI7Nf2rJGi5vzy5bAZMcofcSsMa7O
	 DTv8gx7flLAVlPJ9bXMUYcL2pXZ3Xxr2v4KqDx429kHeunF/Ba8GbWeNep21GVMwoc
	 3zmS/GvYuqTgki2nK/yGCYf2YqTh1AI5QuWn3FYhATW8a+aVvfD6c0QW8igUtOcLWV
	 6Uz7ZajRUrPdEYFA/5jYjQTpIG4UyCwCZqkoGeZN87ypD7qGZ/0vhBQGvk670osfiv
	 tusHDBqVQHxqZ8CXbAePFnSCuKOeoOJ4QqXBjkn4bac6n1Ew878z/mQuOl+2EXgA2E
	 JZfi3H+p7KUww==
Message-ID: <sashiko-outbox-211091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: mips: mti,mips-cm: add performance
 counter interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112-i6500-cm3-pmu-v2-4-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
 <20261112-i6500-cm3-pmu-v2-4-cd2569571819@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 12:32:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The CM3 asserts so_cm_perf_cnt_int when one of its performance counters
> overflows. Whether that output is connected to an interrupt controller
> input is up to the SoC integrator, so describe it as an optional
> 'interrupts' property of the coherency-manager node. When absent, the
> counters have to be polled by software.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-i6500-cm3-=
pmu-v2-0-cd2569571819@mobileye.com?part=3D4

