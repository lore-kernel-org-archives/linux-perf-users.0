Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795763849;
	b=z0xFi3SpmqV2VDTI2CcjaYWMz7brF1YxBSer1Twg2j3fvTJBLhPa+QEK+4l2GpVPJ258
	 vITjSvmB60gfOp+CKAQyGNw4y6ExWmvGWnukZdpx8T8I0kLcqPFv0F3b3y57cYRCpcD2V
	 6pd7SAt7RXFEIHvbVRSxvWukurJ8Lvz5j8MUd/qGBsjBxI7pMeo+M18z/DLm9FgC/FJzF
	 eOrdoO1JFH8hvpnm6Ou2sIaL4v1LDN48Rx22Y6q9bYSj7asdQfZ8cdD3aMqiC3m4iaqZJ
	 CxjGIzTh9u4QoWy9c4Trkoo2unNuYlhJ+2aYKVFl3NzL0aZOcHVkWqqtkafFPK5iSog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763849;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eP3tYe9rI1wJYVXAXn5+Iy9dUk4ir4aqHNGOZ9B5hp4=;
	b=L5T9rdyozyXxoajw8FaMpDOoK+hD3IoZ65kl5ZDjurAFtWTiJKqkSnsrKFEx1jQKWZSJ
	 l+nSi67WBHilusaSbPMkvU7MUyfqHbWGvo3SDvFaDUt3s5ept7pAbv4GgfZB+BgAEtQ25
	 ZpLV4WTgcd2ll18AzWvmIkMXTHGcWlNRRrXacMyLi/rpuAIE5yvjtY7P/zuU57f8/uTSe
	 aT74At9bfbv1bz9iUgNXyOjTPZC+mOA9a/A66XUe6Atg9u8rRvJjWd+ZqRo64/hBJ/giF
	 NoWx9GTnuJRFTbxbWWhn89smNCs0ak9jiPTiDJTt0A3a6Z2YGBXGi5snA15Vw9+JXng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EESVxp0w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECFA606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EESVxp0w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3851F00897;
	Fri, 27 Nov 2026 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795763849;
	bh=eP3tYe9rI1wJYVXAXn5+Iy9dUk4ir4aqHNGOZ9B5hp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EESVxp0wiM4bKmQ9m0r7bdpGZvop3q675HV/ZjO+vwmF3+kFeRPr8tzJI8Lbxof3E
	 Ey/3oQ7iDeNloif4N9X5v3jxFKOjFmrkV3wITB8Bqs5ckF49FL8lD3l9qJ6RheLhif
	 UzkZ/kAxRISb0YngdFh7CwVvo2ijIvXD3a93kYso95eYxyJOLqV+pHJid+NK932323
	 fZ6p/qlrRdftcYFCQURtRGgDE6aUJoIUfyt9bLA0Zt1WL92mt2upGhRAWLXC1R7xoZ
	 XZ0oknlvHQiEnQkSdygJJb1A3eim5W4PrlktV0Mal7lmfvQukyemEew/itirbazXEr
	 5RikTiH/RG0ng==
Message-ID: <sashiko-outbox-236795@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] perf/arm_cspmu: nvidia: Fix TGT address-filter
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiangtian Feng" <jiangtianfeng@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261127071021.820833-1-jiangtianfeng@linux.alibaba.com>
References: <20261127071021.820833-1-jiangtianfeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 07:17:28 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127071021.8208=
33-1-jiangtianfeng@linux.alibaba.com
