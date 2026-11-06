Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941702;
	b=aDNjEUHGKon/nanjDMbWTCGBpXoguK8gvtxaDlKMqIRx2nF6BAQsImHZW0D0k7ouuspO
	 lfL0T3p49Ru1mJoHuSZYb/SSrXj2hTYED4cKYxgBN6y/BthLeKNxXLo2Ya0+ZB1A+rPML
	 SLRyLViu1juCjtErpwcfTryLeIkiOWhtKD/iZbZFCSMmswdFAGGSMY1L8n6LWHv44RMhp
	 SLPcqTSCmaNmAJLA5Xza31NHCiOo6wWiNm1E+59/i/Boc13ztWp3ZK56vn+hkroH8z2DM
	 880mkuY+gkGytzj2Lwoh3rnlpxbUP9Cikv1QkY4w7EFTY6Oya1UfXt/BNy2HrD0Z0pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R8YvvxpY21CcIeie01W8M5kqMF8gpmoQ5XklopsjTEI=;
	b=W9IRgcwXnSqBi6DdKiJIVVdb4dhXoIhk0e4OG9Vrl6PI8G8WIfQxGYRr/rK+XdyqGvKR
	 9o4OS6TZl8i0gqpGzrqSD9oQtBS6gKBkFCIPHB7kIH3ddhl3ank8lxUDCb+TOBizbtzxT
	 1N6074N6qyrpMBOjBKR1ckviHs2JPYT62i560YUQUWQN7l4B/s22BDLQBLByCMhbTp1Qz
	 Zqmx/cakYi3El1l6Gx2gc7YNwDCIz8AU+NLapyhJcUqAj+PirLRTfvQ/vImLb2lqVtjcj
	 9/ZSFX+/Hek39XCuDEKshm0SOX9z9eQRe4g5mE80rBsQHUsfAR2s5hnUYqF77GBEmtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWzMmZUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4F606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWzMmZUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C190D1F0089F;
	Fri,  6 Nov 2026 05:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941701;
	bh=R8YvvxpY21CcIeie01W8M5kqMF8gpmoQ5XklopsjTEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UWzMmZUAPkNv3bICacSWU2X9w1B8WBwtVE4fBFQ/DeYFpwJG/LCdIHpwImnMkuxOL
	 /8NEnW4wcoDdv41G8mYotnF3bDDEuoFusi05n5Ee+OIS2L3YvwQJ9lLFqolw2Je8OR
	 +j0AWUtlP428RYPeMgijbjzTA+YJTJtzaOAjQrOgQM9Q1L1tRYvGeDVmBUNnqRzp2n
	 nU+lLzkh4pvVVXJKspZ5Nx72+TB2nHD389vNHiv3Y02pdYRwA0V3BscoX7rLHrBSAk
	 5kz00xPTYtFdlQ4ibO1oV2GQChAQ29yjwGKOv7KF6xAxkkDWhxDv6URaL9cutMGm2h
	 vHzNAzaCAOTSg==
Message-ID: <sashiko-outbox-200796@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 16/20] perf/x86/intel: Remove dead lbr_pebs_users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-17-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-17-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:08:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The lbr_pebs_users accounting is no longer used, so remove the dead
> field and the related code paths that maintain it.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D16

