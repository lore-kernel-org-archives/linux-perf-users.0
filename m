Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973811;
	b=R4/DHklmrnhLhP7s6qjRiUyqOhJBbgYjKGQfUbR0TyqhM2JFDh2DHOMUrFGGiqqh8jvi
	 yv5csDiX3YeIGx9xd2zt9tumzULlY5flK980lGh/TguYWOEreX4n5nnDeN50xnbZnK0zU
	 sqFgDgDPs3MDXLT8L9AvN7ukSIe807/Iu8VxI/XN2SBI0SVsuDlsXxsFR+uM7ZyQUQNey
	 mP4TLJ0YvR4s92iMAgzI303aAtBF0Ow3/EufcxEH7pNgoi7iWjtAsNjfZAEZhHb00xg6b
	 q6+Eeg8VAeWZOOUKx27o3lKNzIlAE8k5UvD9MCVYHCteuWjeChKNwBgnTMTbFELUb3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7Z7FZjTJ5GUFx2YgBC8UhrEFVK7SFsvWJ6tAGBx3N3U=;
	b=DcBMbDPE08CeHgvDulnsNIKFqjk6fM4BEtN0EY4BmdVh/XFtyWGEhPzLco+eBshhPxe4
	 EVm4K9VNluUITslVCIH6G1JI1UDu7HGQXKevWY7wMwHLt3+HDrOPV9UO/UEV+2jBVGq0z
	 VGChK+xtrEYgzY4n0h58h41hQIdpDgBNSXBsfnAypK5ufpld7BWveAeqnAlAdH5tIe4KM
	 L9JfYj3Lpa/3rLtfLXghH9Jkta07TGw/nC7m8Xok7zh9MVWWUYy/mcIy2HYLBjw4X6kup
	 +JYX4ANURt4x4ro+RRxzijO/Y3YjejdOgYoQoaAxQvxGNck5aDeafbLkVoosjeuTSIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lhxouczh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89749606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lhxouczh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73641F000C4;
	Wed, 18 Nov 2026 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973811;
	bh=7Z7FZjTJ5GUFx2YgBC8UhrEFVK7SFsvWJ6tAGBx3N3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lhxouczhg51EdJZa8EmTPkos0XSDtjZtMWY6p6Lo/zvsl5yTcIYBJp9jAwHcMsECo
	 dmGfPkX5+HhJ1IUtJ587D8By+fAuFaDoZ/IHsWci87rEEh0b4KyiKlLnlxsyM9Rbse
	 vWliZ2dRw70S/HxZTk6zk5WRhcWOINSdhHkiT/FSsuHIATVRI3AWbWgnIT9eOpjAtM
	 ls9fzqacNziyvgybTKbh81Td87E7D+BCb4fjNAavcjuNGAbpohr4ORaCdU1EJSMYVQ
	 BFrIZJqSGx6ubsWpL3NjgzN62PUBsA1M/Nnnn4/9Y37cooBlTFVi2IpVFdSti/JXsj
	 OlmH2On5IFoHg==
Message-ID: <sashiko-outbox-220050@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 01/24] perf/x86: Disable LBR if x86_pmu.lbr_nr
 exceeds MAX_LBR_ENTRIES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-2-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:50:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Disable LBR if x86_pmu.lbr_nr is larger than MAX_LBR_ENTRIES, preventing
> out-of-bounds access in the cached LBR stack handling path.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D1

