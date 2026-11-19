Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115329;
	b=ezexsZMdXEDD626VZ1MtOc+G6KX4Eec1LIbo4KRtkj2LUNY7km0UwDI8BDCTUM9Qgn6g
	 udGpNyP2NqK2FICuIjhnI8xWH7/kQ9BwJJzJj4sMoT8aIy1deXKa0CQOZr/cq7IYFnbC2
	 pyqsFA80vKckA5BrqoYwDO5+nmTfgIDc4chS3Y29k5usE+LwCcC7Joy/QG9NHFVSWTEaI
	 UPJlzBqq87BIhlan8vFzXj3NFLfRMVBqQpQOdO2wt8qBn/zjJw8s30k/cNVJk/aL7wP/x
	 FZma782m0qQ65QfFW73peqXWz1ceuLOdNY9TX9MOHRNSTUJnzC6Rs1uPnRM6zNCNPcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yqic0xo07fY3akncSDuHvv5cuWbhn4WbbviNr/TM5AA=;
	b=hOe2wu+fmiMo3YflX/8ou/fIM5PvcgOtSKBimBcS86dJpuJV5uhfQkFFtMhEpgwvRpbV
	 GLOGX5QVrgvm2yPv7h5aUul7MbdB/SSFunVbXTjb1VB4mgg5wCfXB3SbXSZx9Gg86/rVv
	 LV3yzbOFOMjOXyojFHbbNROvoZZNRwc+4cGlF8YHnYOefpq5FYboxhqG+5ARMga40vGAg
	 ZY2FK/AdL424QttV9XWRX5pGEZg6h+fbJbl3rNqgod8VSu739Gr/sYniWgIU2+hgUjaw6
	 wpIWIGctJlXBWz9WmVfiHr6VAUSg+WiQlVxRDrQd90ABjF1JM2ibxE2/T7AaoM6fhbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUXDOt1q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B302606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUXDOt1q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9941F000C4;
	Thu, 19 Nov 2026 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115329;
	bh=Yqic0xo07fY3akncSDuHvv5cuWbhn4WbbviNr/TM5AA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bUXDOt1q4X3it7/yHOFr5F7ibVxj1OTSC58RTrSfQrGeeCsLy8YHXoBFSABHH7eXz
	 xq2um7UCLXPRIpzz67lXUFSyQLhNlfMzSkBWFN3WogDa47h/dwjZ5x6Gc8ynbcpqC0
	 KA5NIW87sBLq3MG7CsS45zS7A1G4RLBZ7wBpgnGZa44rr87/wJjaZIhoGY+Akf7kUW
	 ZtTLs0iQpy1/DXJRCbf7D46AVp2Ps0LOqRW3KF5yvZ+4YVjTnfq9phWrf3fTqQI4VZ
	 D/GaXkjbq51TzLYzXuwmlsdfVTiym6PpFs+K8wHmbypZMCASJj0wSWKbm7nn67849R
	 DVBW7OoJ1wm4Q==
Message-ID: <sashiko-outbox-223832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/33] arm64: cpufeature: Add cpucap for HPMN0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-2-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-2-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:08:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
> counters reserved for the guest.
>=20
> This required changing HPMN0 to an UnsignedEnum in tools/sysreg
> because otherwise not all the appropriate macros are generated to add
> it to arm64_cpu_capabilities_arm64_features.
>=20
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D1

