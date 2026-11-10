Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275320;
	b=vHad8DGEUnrRb1INFR8XCBPtG8o8HDSCuqg+RCZ7UlJr8cKDxjSlnrKF6Q6XaThR8FCc
	 +b2JsLAmt1E8VI5J8rFaLa0EXx1xkoxj2co/rzjTSGRI9+qg+asNNMbsI8vYyAJlt/IeL
	 s2HMgBEyWBtfhAlUM+jiQFfjwUX9w9pZY2zn8mO9zDqMdJpBFe9Z/6EESDv0wcK7mknaT
	 6sb1og8QoNNnAdYuiDc2Gtrl6fX1WVAMrt1LZDAtPF2i3nWSqr1xC8XBKTQMqbMuHqBxZ
	 AGoqcJFPxm7SxJArUDbPPY+wSy8vAsFIogVbHyRgZklvcnJhO6ATiA16qhczaFFnLzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275320;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tTKwCzHmowEFRGsyU7hy6bj7TveY2aKgty9V97f3yqQ=;
	b=FOw6a7WILeIMB98KukTFc2AC0ZJVp9XImRN8fItBfyRVcOcP9PV1bX4G9GDl7T6rikFN
	 ovaGoSBf7Ef3cBicTutfkSiXne4H7Bk1iRCDmyiEXYCNKXMMVxOHepe2whF6zaAIiYwMo
	 WZRax0scaHLqKpETS2pEV9yn8gFtzWB7RG8VrCbj60+RTfiXjWHPwuzLOP7a9QOt25qQy
	 xIReA+2tA6y4mTvjjaHIGN/B2dV+vAJqfZbBW6tmcFMyLmGIFcc3hxduL5jT/Azqnqs3g
	 JfJ6n0DtYMRNN+hprjOUfj9PV219LaoOLCE8qd/za+6pGO6hoYD9k7IG9LuN42CyEWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIJzVedj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF0606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 01:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIJzVedj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831861F0089F;
	Tue, 10 Nov 2026 01:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275319;
	bh=tTKwCzHmowEFRGsyU7hy6bj7TveY2aKgty9V97f3yqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aIJzVedjg8Y7yIbHwVT00l1i1q+x3XHEi8itfNa4Ktzyu+GQw1Djc+cXkX68q0UIF
	 4Y2BCHfumBwnQX/y8TAlzJJ0mWiULe8u+qv0H/tj8aMZtasPOdLyyhtyzb6hF+c4bA
	 DLtkGycEmnmDn2anxMCkWMQnoiaKS8vXOIv6Sl8tlPAKE43P5N9t6ZGb1I5mzq823q
	 y/TDVwZJt9iHoVwkyZKToOjfIvWIAEcwkjiNej00cxV3+mJVIto0TwpA1SzQzDINbC
	 eB0gy7DtqHj6L0k8itjtaX0zq6haA7Sh9pf8XJX2K/NEq7WmrroPieTu4+l3NCnTXA
	 3k2p10JLZn4ZQ==
Message-ID: <sashiko-outbox-205989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] selftests/livepatch: Add RISC-V syscall
 wrapper prefix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110013750.36800-11-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-11-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:48:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> The syscall livepatch selftest resolves and patches a syscall wrapper
> symbol. To use that test for RISC-V livepatch validation, add the
> RISC-V FN_PREFIX definition for ARCH_HAS_SYSCALL_WRAPPER.
>=20
> Without this macro, the syscall livepatch selftest cannot resolve the
> RISC-V target symbol, and the syscall-related livepatch test fails on
> RISC-V.
>=20
> Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
> Tested-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D10

