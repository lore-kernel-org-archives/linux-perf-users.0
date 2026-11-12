Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486913;
	b=rgGXRGCabqb2Bapwkz/W9mbT3EulIIQP3Xg+wU1XvM2SRGmk8ekcdsbLfLJE/gcdiRq3
	 LTZh1iqgovJQGr0Ow5cJAqv6dJpKEu/n0/mBBgBNeDs2R4Xf9eUKGd5ELiXgUOGOrD8mM
	 gphs6gQA03HwQ9oDYgj35IbiXDmaQanjszW7msXPScJr0xGWsRUdIhqXn9g658FO9TGt6
	 K/iEQFp+O77OZEHyQ8FmCcT0vIQaUi0SYqETq4ozaPezWnAnHiS4Elgldw4kGv3SfQbKX
	 vK1ir7KDs+1u26UBCvmY1rlZ0OIPJLkSrmF8L2nY6fWXbUXaArb7MXYV0G9VpN3splA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IkGDBwHlwTGNIT3K2hy4icKVSMYs+E75BUUujXS6suY=;
	b=LvL3ltEeuo2TilK2dv+TM6JYey+pQQ+gabktCehz52UXZ+fHeM28NcRsu8BRtQsVvYUq
	 nGMsMdZRxddphmyHuFDk9T7TLX/wcW2iBoTjfSG35A8dzAft5Va/cuK848s/+DP4Be6/p
	 +m3PdIaAFIaz7XoBIheESK1iMNzek9MdFT3DkUcquCK0j27Ofb1UJ4AoCahqltq/82hch
	 meWMU7GrdAgWzdbkVA9oNmgpGEdY8Gz1HlI5IDKJfcEmCLF9+IQj06J7Eitm89kd5hYlC
	 i94vw01gEWmEPLqZvO5qC5sJ4pF+ruDSvkEz+0FeiEz2V71PYgI+ytbLldXVd61necA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ng9SzBdY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E086606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ng9SzBdY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50651F00A05;
	Thu, 12 Nov 2026 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486912;
	bh=IkGDBwHlwTGNIT3K2hy4icKVSMYs+E75BUUujXS6suY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ng9SzBdYLqjy1NIHKV3uEj0gbIGXv5Gh9lRtoPeAcyNb+IJXDC7oDjrQ3EAfeRHNo
	 s66jcsMSBBqRa1GIg14PoVj6+SRTh4rOC9MFV53vvcMKnKMPs6FyMJq1neH/X8sWWg
	 f/VLs9LIBgjC9uCvqVN44WChT1J+WtMdfa8im4c7yAEWfE4YkOFe1uyZxfl4RZYEaN
	 32XC6wMNT433mFpe6YSrcRZBQ/vj0yNYbbV0/A7g3CoYiOsf9YWHW9huc5SA5e10un
	 Hj4it/t79ETEwqZu8dOJgnPFiNTpquBcmsUDdhX0D+wbxBzxZen5oxL2EJyLgZMIH8
	 9ZtVYbDJVaJQQ==
Message-ID: <sashiko-outbox-211095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] MIPS: eyeq6_defconfig: enable the CM3 PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112-i6500-cm3-pmu-v2-6-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
 <20261112-i6500-cm3-pmu-v2-6-cd2569571819@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 12:35:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable perf events and build the Coherence Manager 3 PMU driver as a
> module.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-i6500-cm3-=
pmu-v2-0-cd2569571819@mobileye.com?part=3D6

