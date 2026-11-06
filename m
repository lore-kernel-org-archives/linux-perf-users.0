Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943149;
	b=aXfqFqWilEqP4LEcMaWytMSiV1GXv8utB+UGoESXld3Y4caXmA8BCtz1+Kauvfi5CynK
	 HnGlb1m0X1RsnJgdcUoo9DJrQAryW9ANW/y7/G38Ip1gRBEjnfreXCc0kLis0jtbyOSrC
	 GKALJNk98wVkoEDmNDfeUSP/n6MfMLVBhZc74p9mmdrpyAkPJ17uqwh4SAaZcpqMbM5Ex
	 MR2WwcgFOQa6ljs/xECln+uQb5MFnDiaUzAfNb2NfFiWWKH72T+h4j456Wy3cVldZJn/y
	 cWAZbNEAqpEMafX2csstHRk13u1lwUqD3+IFEhd9N3pOaHY+kn98Ua8ZByAcPTKZIUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943149;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I1WDWMS/yU6MEecwgQvcWn4+XYzVTcOgyQeZ4rgeoQY=;
	b=RbM04Uhhags0RsTFO4O/0NMlqoFago7yT4Kkvwn++cR40fx2jPgnf/7WaZ0Rv0fxbP53
	 k/ULVLVRXvAHVu2WtOS9LdztepB/G0NEHCAxeIvC8yK8+iHjnbsHWNqKNspOTF0gp4505
	 tM/q0+74PJjjSpEfol01B04oPPNCo+wKNfg7iPBcugZzfMc4Zy2V5yKIh8i96+mG6Bx9D
	 AFcJ+vAZ+z6mkrDk5ThY+ZcEmM85qhXWD0ancDIEeCEYCdFZU7fAvcrkrAyCWNZnI81ZP
	 rpQXSeLu8zThH0cTjRTGXdDCGrbEqS3AmOLqbeXnMgVGgVQ9jmpvuTZv1roiu7avt1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAprKkKR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDC606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAprKkKR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2011F0089F;
	Fri,  6 Nov 2026 05:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943148;
	bh=I1WDWMS/yU6MEecwgQvcWn4+XYzVTcOgyQeZ4rgeoQY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bAprKkKRXdoQhfK+o/IWffHCeF+cZdNmYEezb1D8Fk6ZXCiTOLL1bPpmTb5Kf4Q0R
	 eMbYgztcL84H1HrVIoPZOK/UH4uaq48ZDtBIhj4l/3nNdcdXRfNw810WsynU2OXcc9
	 JhYAjmYpuDZs0PjLkAUU0aAVgMPHd/zXXqQVe56gYkFcT2Em70s9lrZ9uXkXbBjOtS
	 Ek6oJTQFsNmeS4UFxXCBnOwGz/jpopy9HHfoX/Ew/G7HSKGPZ1rm7fNyvzmpYn47uX
	 p57E+Pv7/ZxzEMyOf8+vBZmwSnpDxTrTLK5aq7rFtlCmQVmxTa8m3s6KSXHsRTjXBH
	 i9YxD4Oa6l1ng==
Message-ID: <sashiko-outbox-200828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf intel-bts: Free the old snapshot reference array
 after growing it
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261104022042.1894-1-lirongqing@baidu.com>
References: <20261104022042.1894-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:32:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> The snapshot reference array grows when a mapping index exceeds its
> capacity. Its old entries are copied into a new allocation, but the old
> array is abandoned when snapshot_refs is replaced.
>=20
> Release the old array after copying it so expanding past sixteen
> mappings does not leak it.
>=20
> Fixes: d0170af7004d ("perf tools: Add Intel BTS support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104022042.1894=
-1-lirongqing@baidu.com?part=3D1

