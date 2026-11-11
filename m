Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384575;
	b=ewbLJ/fJClAo7bcETuzyGNHmEgxPYotc7kc9rEYmO/5X1v5pplockLQBItv4FXd/x4t6
	 cyTN9bUp6Ec6wzeh02SE0OIVo+J8wuTzff5vfJr309Xu3Rtno6XARe4Ttp6JHcK7iIjq2
	 Jq/b86DF+vsH+53Seol1hNiZrCnc1TCP/NSfrhjzdsuZJyeHFE0rNXTbvAG+s8N8VkDJQ
	 UPwpriOZcaqtGik7oCOVbSb1N0lN/EuWAATNhPjBKWwUxkz7XBUnKmzEFSbFs24RA1Xqq
	 nblAYl6PPSCyFiQFkovF2jk5XoooGrdqGDs5Av3PQvOaTFgHLuqW6IDQHwrJSMkra9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384575;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h4t+k9gOrSv+oDPcCIwPrkJdxEPp8VjdzKlcCtT5TV4=;
	b=OHWK+c05D8PkHRMzjcdKIe7gEQFF1RKNR46UVzyRudVF64CJATazg0p3SSR6zwjf+/db
	 eot/325EOXJ9dXqaVRTuJkp/JGIxW76dhx/NdkvI4PlRuz6IILjhrlCbkHwAocVrCUhJl
	 AAGjRPNsAwwormYFDEf3U8c8MJPYppV2B/ftfzshiQsbEfCpdbeaJty6EZhaf3brTMo0G
	 FWDvhbFxvfnd2sK3z3yyMKevF5a1MuMRFuScGJ6d5PdtXRxyL/78YgNpvZtujkBAN/WSi
	 LKSCUwtDUYi25enH/ChxmY7LW5vWkp+SHtiN3gIWggPrHzKhxVj8Io16PRwP9cei/Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izPqpqO7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D9606A332
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izPqpqO7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479471F00A05;
	Wed, 11 Nov 2026 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384575;
	bh=h4t+k9gOrSv+oDPcCIwPrkJdxEPp8VjdzKlcCtT5TV4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=izPqpqO7zrCO4DDD4oD+m7pQxrATowMj0V7dMs9Q3FO32jFrtqyp5hVL3sTSWkuuA
	 mAVkw09t2vuwWUYbbAYiQXlJ8ubpYT0jCs7ymG/d0+CK42Xd2rDhu9mPrmvG+4zEQL
	 xRmyqi0nEbH6CBR3bTFEeP0qmLlcZJ2jAtstMT0ZIFjuEhHAp0KUPPqsaIXNxkC52e
	 hHFBM0Je46eUocxcRxd1Oag+UpNveeTkaVMvCRvCScJ+EEAa1F5LklxLeOVqOTQ0DH
	 pJy/oN4Ux+roxKr2oC/aVsbO886SLTVTkTh0DV8mdq7k9RSi1tPXKBDXZoBRaJW63P
	 uigtErlogcdBA==
Message-ID: <sashiko-outbox-208572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] cpu/hotplug: Use cpumask_intersects where
 applicable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111075945.3930230-3-sshegde@linux.ibm.com>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
 <20261111075945.3930230-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:09:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cpumask_any_and returns, usually the first cpu in the intersection
> of the two cpumasks. However, if the returned value is not used or
> only to check it against nr_cpu_ids, that implies whether the two
> cpumask have a bit in common. i.e cpumask_intersects.
>=20
> cpumask_any_and uses ffs on (addr1[idx] & addr2[idx]) whereas
> cpumask_intersects checks only (addr1[idx] & addr2[idx]).
>=20
> So replace such occurrences.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111075945.3930=
230-1-sshegde@linux.ibm.com?part=3D2

