Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250673;
	b=oWWCAX8SY2CpAEUQGxmTS0D0RCWYliWnPmWyC0BB9wq7upOr2qh7x2TVOLWQk4fkOOLg
	 +mm7CEfUulURU4pVv8z6MNgaJ1oZQgUQuuN09YjPnk4d/aljHIsHZ561vsItpRXT5FG6G
	 YgcNFaRgi8BVrRqovsiZn7Xqj7jlQSohCQUT2w5wsMj/tMY2JLNyCek9kvP4KRPsxjncq
	 4UYUA/9lVOiTTBQ91Ch6i6YCRnUg89X8wa4miq/+3pz3V6X0K340zT/xi6i6ePsKJmC9W
	 t5g+rZI9GrfgOhNHG2mEuN3y0y3OXtee5IkjlOB7I54ow67upYmnVHSKEJmKCC9qg6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AzGhxUW3AP7h8vVnj/68v8zJPalOXYuo0Sdv0jLM9Og=;
	b=cjPxncef4UGuHk7jz/FC2VAbyH7q8+vAWXJcVqnNI8uAlTxzU9LlC0V5EBJIPkVzFtD8
	 2yRpuB3yRVsql6pGZ7OEY/OfhFkBzYD1Yc7uQgq25+HIwioJZGAX5w/WVqu8B75kvqrIz
	 QV4TlXI3acgV2bnulCdw1cfBX6rT1vfT1koYSA49bZWZc1aoL/9Q5tuZ6F+wac9oEQjig
	 pIEBU+85MwKTET4kNAeI1+dlHzq2p91SPV9+Em8U1/e4+mIkkN94yTOQYZdNXkWU2AVhe
	 Incuw/J/ZR/ehJh3Mxv7oW5AygG/7P7yA6fcg7dAp4r8Vs4UXonWg2N1gSQthzdCUOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azovZRFA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359D606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 05:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azovZRFA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0981F01825;
	Thu, 29 Oct 2026 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250672;
	bh=AzGhxUW3AP7h8vVnj/68v8zJPalOXYuo0Sdv0jLM9Og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=azovZRFAQVk4dijeBqjwRNBgsdCjC8xUtk4NH21bodC7cPJ3OSJt2NTJyXeK6BLl+
	 sR34JpFLd5AN57byxhf1FksK5jHPG3vSHGro5ovzeXXaQ2KmxEYBTsGYfJGsjLibmA
	 Y6hmCrERI6et8j0XPFHWX3BJjoHhZbG5Z2zaTNg1/nydaNvyrmX+ZCzI29vl1pHxVF
	 /lPQE5uJW4pnhAaVMm7u1xVrwOoDNTduAjboTaNB23bjjWMH2+xVcPsO4jZtZYsZME
	 LPEd47qhI2ywwA6Cyo5aJiD3puCXQwvb4FTfMtDkZn+6S3++uBP8Bt3+mDtgFtsyL7
	 yX4O1cjEHzSaw==
Message-ID: <sashiko-outbox-188737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 02/18] perf/x86/intel: Validate LBR XSAVE state
 before updating LBR stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-3-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:11:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> intel_pmu_arch_lbr_read_xsave() doesn't check if the LBR data is present
> in the xsave area. If LBR data is in the INIT state, the LBR data may not
> be really written into the xsave area.
>=20
> Add an explicit LBR XSAVE state presence check before updating the cached
> LBR stack. Also clear the cached LBR stack when intel_pmu_lbr_reset() is
> called, in addition to resetting the hardware LBR register file, to preve=
nt
> stale LBR data from being reused after a context switch or similar
> transition.
>=20
> Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR rea=
d")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D2

