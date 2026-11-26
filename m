Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694066;
	b=MLDV9EtFXeQJ/PBhEg1CAFLreydzh08zvG9OcYrOYsRfsf6Azc9wEEpWjZlF1flylVV5
	 ZltN0fUrq3a/qWxs4GpRw+svdztlKH23moKTp0era3xtAAdbu+5j8g9jLHoix0iT4UhuV
	 QiFxs42ElPKnGfK5AlRkVNbTTy6uz6S73eOOPyaAtQ0zWKzkXTTvgCsfNV1QWax8XvzlI
	 905cwX1YEDtYelVr3Q9BR+lWZ/2Vf27pegdNdVmEVJ+dkcXitEaNVAyofyRC0mX0qcO+w
	 2UDsM6TlaiAbyB0DBwM5fa4HqMfUVjarXWA7tvSa3Wsl8fUzvDvnZfkGpThtFnV/7/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694066;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2nL5TzhBup3RskwJHcs4jyQan24sEyLOVN/ZQKujwls=;
	b=oPgt1fzezkRGof4Cysl7mLkQGhutqKA56g1WLeD1MH+smIEfdyf4qNGKdtmJipztVWeX
	 uZG50hgYNmYl/sP5Jxp0ebjhU+9OoaOAp0W116gDYiPSAd2RlyOJ812gTkj5yeTsuaWAW
	 ITMc7qvkI282ncb78NXKZgyRP1QVRCb4NVvHDcThU+kIqa58M0j2DIlw04QhpbS3k8Yrg
	 Wfc4mNC70qKb9kOTxYX9czp0IsLJnw0D1to4YK6OytDrMa6S/XXRZvcSXdOSn18IeGGIU
	 yk5+ULILlHneViHHX/vAOEh1wq3P0FVgQV24Gknou4cZA7/cnEGPlOah+znCCG2hT3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5uoaQpp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FE606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5uoaQpp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83741F000CF;
	Thu, 26 Nov 2026 11:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795694066;
	bh=2nL5TzhBup3RskwJHcs4jyQan24sEyLOVN/ZQKujwls=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=g5uoaQpplL05y6qLIBjE34fjqvufGe48w41Yth5PpVamQg3msN1zjBcOAqWa7WgdX
	 t6K/LudMQ47Ivp/yRzF93Xel8U0Dijp6U1TJM2kVTuFkgJ7z0Jb35qUCi+jHFylS/R
	 Jj4fvNQTAp2ESU2WkKzu9zLteFkcr11aTmlcH8E+VPK0kQ0CKRzjjch+iB4u1luVAq
	 4mS3KPMQRydG2URuVaPcQqe2EsC85J+7DZtstB3oY0J3wG77ABpsKTMP6t4L4qrAl0
	 Zx+tKSzBuNSY1bi8Y2ZhJuCqGj0f/DdRSYTy7jtzwRB3Yj7W/7jHjWCeZ9G2exrpPU
	 vMTa9tHqD3r6w==
Message-ID: <sashiko-outbox-235434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] exec: two more sleepers in the way of exec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:54:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-work-exec-=
update_lock-leftovers-v1-0-1024b26792bc@kernel.org
