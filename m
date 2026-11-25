Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597760;
	b=kH78WNBFSBoB52Yxndrzlj+ySBxiDFqINxwXMKipM6N6Na+MjwQe7j1GdOFJ1tTsd32r
	 yBdJjZ/TUGAPaFpz9MoAWc5XuN02IPg8B/i+dNIchApDEieov6am3LgGy7ht76HhOo3lv
	 g/BmN6W5UdeGVG9PUNqNdbs+q3JXQsykzuGiMqlecjhhqmqw8ym/0oF+f5731ZfwZLtq9
	 D0ZPm8eetyylr+E9eyyk22bipqtp0VCsIz7ooNLhAhbZi0V/Y7QSBfgKStJ3EXTpgtY0h
	 z8G//jSwLWkDr1sp9NVtH38qBsefNV6GkgcVDcqtS5VeJsyv+lr+ZHq+g9t0k3tOtHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597760;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XEvOwWMwq7l+hTKzrnGSXT51PH6uZJEdsqreTuzAcy4=;
	b=aiMHKEgjmptoe4t7tP2ISb6CIaj1Tw4PwMDel0wBQH033foSmj1qundvDk/aRc4sLthF
	 8Q+MnOnfO/e5I5IQRSN6DlWCcKmkbuUgIwbA7kglYRDuTag75+SB49m361OK5OBDsFK9E
	 IOCisJv/dU/dhq+NJv4uagI1pZQgpdub/SFgCz1DKEBU6lhxmS8XVU2QKtRsoGcYhUZRV
	 rCy82b3C8kw5sVPpV0eoKBFBvmApYcNXuID96xxnBBhxI8cL7wplCESVA2LivSOkgLrWA
	 BqP54eYRYiEz1AsGK3HadTos2M3uin9TS4BXVtO5+3m8MfoDHoK/ESz1rHO1hQkxoKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoRzMIOP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD90606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoRzMIOP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F8B1F000EE;
	Wed, 25 Nov 2026 09:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795597760;
	bh=XEvOwWMwq7l+hTKzrnGSXT51PH6uZJEdsqreTuzAcy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoRzMIOPLjcTEWTaj9lemDLk3qKXjdp5ut/AsPWZAoEg9K6wEbNag4tEMWRzbzdBa
	 FN0ILZhcHJXl01hMr9Tk3cMg5OMMgVpX4/wXk92MAtOTXJ3vgz9B3Dy6gZ1zzUmnfy
	 ik2x7tvXZ8rpNUrmVL3LC5M7kVfPpnIHReVPvcMr2na62voLBlw2P9xmCvwQbOBQOG
	 5JI/MKumXj3cJHDZUMxw2y8CQTmJKidvOOmYnO+PPZK0Aho4tQXbmYU764jdPLYOcD
	 9VVj3dKzyx6+FLmZ+ScrooHY1o2VV/OX6890ZaR0XiQDjlXDMjM+oWmGDfXV/EpwP9
	 MR88+HnGQ1hIA==
Message-ID: <sashiko-outbox-232974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 0/7] riscv: pmu: Add support for Control Transfer
 Records Ext.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
References: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:09:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 7-patch series:

- Patches 1-3: no issues found.
- Patch 4 ("riscv: pmu: Add infrastructure for Control Transfer..."): 1
  potential issue (1 High)
- Patch 5 ("riscv: pmu: Add driver for Control Transfer Records Ext"):
  14 potential issues (1 Critical, 5 High, 7 Medium, 1 Low)
- Patch 6 ("riscv: pmu: Integrate CTR Ext support in riscv_pmu_d..."): 9
  potential issues (1 Critical, 2 High, 6 Medium)
- Patch 7 ("dt-bindings: riscv: add Sxctr ISA extension description"): 7
  potential issues (1 Critical, 2 High, 4 Medium)

Detailed reviews have been sent as separate replies to patches 4-7.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125083942.3695=
072-1-vikram.singh3@oss.qualcomm.com
