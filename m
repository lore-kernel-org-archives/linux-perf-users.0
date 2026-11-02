Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582043;
	b=jCsT2Eo2WcFFswT8IO2vkAc+EclfPI6wZ7A3DwShq9ySHIi82Zys5fzmPPwXYhFPg3Cq
	 PhkUol9er7P/z1GZZhAnxk24JOoydY4hMZ+yMi9Y85kT2W15A8ZOchmw2ltJsXJidnGMU
	 a/TVU77bzHKlobs4PZYsBF2+Up5nCTD/M+YQBDzca8GJ2E1HOl7q55vLVJjNNXJCjnbzD
	 vMM02qJwBWfcDfaHDAdPVgvNtt3tG+Zzzg5HS0osh78PLNx1ZMncDXpwL4PKJiMaWIje3
	 jA/mXz+EuaIFr/z68sieFlw/0DPGfQMeEjpVcW+4uAVelM5KMO3qdvTNz17PwwYE4Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=81xJ4NmLXyqfQgv8qLU8vUmJMjW/Kg5tJTX9AJtQMS0=;
	b=vegItQI8eVc9gU72IEyj8UFvKiDk+cXkA3mC7AtSvhF+ZsBoJp8nv8zkzqL8m6fzcXTH
	 iH6H6QcOygtuTrIaqz0ypi7AS5p1DtnlWX7QOSk/EPsZ6XWenu/7PkXmHTNKLewIf+hYV
	 1llzTa8eWa810Ra9TpW4FAONMqIYMJimv8Q96VYG5QwtNnDaJityhYaZ1t72FQoJAZKCs
	 mAkmz9j5PZXsa63tg/8d6BObJITrV3GVvnG4FygZcL4w+VH3DIDLwHVQ7AJB3QRQayUhY
	 0xMYWm7O8XC9XguDyra83emfawSd0HXLUQ0BnhXHvqz12tgREX09HDaGN2ELzxcrHdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHMpzHLp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D213606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHMpzHLp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45331F000C1;
	Mon,  2 Nov 2026 01:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793582043;
	bh=81xJ4NmLXyqfQgv8qLU8vUmJMjW/Kg5tJTX9AJtQMS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHMpzHLp5uNSSUwEi/gXGB9UxNXVRfAZBKEtY/UQRWlXJAeijZBq/LoqJrg5zxcbz
	 Do2O63MN6+TCD5IDAmuhbwkBiqEqFREXSlkkpGvKm/TtUk5PQ8YXRIbnAVBXxlClVz
	 lfDZPLi+w6RCdrGWO2H2+C4E1F2oubJBVJ/b0lAMc59ARCWhQp/SGekPKXTEPo92w6
	 SWbn8KFFAyBr2b/d/4Ou2xNwfK+0L14QcRp17e9xJvkkWCA/Ry9C38jrDJGcEik1Zj
	 cS3G3+zNittLJOWG2exzREEhrzzR6GNYQHNAKKepErBB6ORX7EN3AjmDJ18ImfMfmk
	 QVVzAskajqEHQ==
Message-ID: <sashiko-outbox-192800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/core: Cancel PMU mux hrtimer before freeing
 per-CPU context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102005905.2017784-2-dapeng1.mi@linux.intel.com>
References: <20261102005905.2017784-1-dapeng1.mi@linux.intel.com>
 <20261102005905.2017784-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 01:14:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_pmu_free() can free the PMU's per-CPU perf_cpu_pmu_context while
> the multiplexing hrtimer is still armed. Once the timer expires, it
> dereferences the freed cpc and can crash the kernel.
>=20
> Cancel the multiplexing hrtimer before freeing the PMU context by adding
> a perf_mux_cancel_hrtimer() helper and invoking it from the PMU free
> path.
>=20
> Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
> Closes: https://lore.kernel.org/all/ca4f133.14714.1a162b8654c.Coremail.xu=
hx@hust.edu.cn/
> Fixes: 8f4c4963d283 ("perf/core: Simplify the perf_pmu_register() error p=
ath")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102005905.2017=
784-1-dapeng1.mi@linux.intel.com?part=3D2

