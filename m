Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185748;
	b=xwn1b0hNwxkMEFaXQ6UcUiBokrBnXoINgUlVWWcvaiKhUEYDYaVwQKR0VPo2e7wlM7dd
	 4qVVip2KKk4yWm1a3+Q6X/qdePHaylXARuTF/dg5eG7NUh1r2Ds8R9EkbedmzPH/VsGGV
	 jQXcD0iT2yMKvqD2picp2O/JuO2KZ2EHhHNPehO75QKpnF6JVJQZ6FowGNI+fb35TbH2H
	 Y02dlyN1jaA91dJnBUDtiFOB4LNDSH1D0YH3Abfx27JARgdIX/LwqA8kp9cUEc3H0fumq
	 NBSL3QOUjrIS9LHi8HS2lmXRXLBbIE8pHoQaokPSjd93aQ2VjL1a1Q2V5QcpObgq2tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185748;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hs5Vukzpfby/J+qLcEHGmxUx0LMHQGU3qflzm/Kqd+Q=;
	b=t157DLnYxHPzc0tvuglsIPoAGNYAuKWhf/G1VDTjDxUW9rieAm0wAKXc7kYfW3KBEcDV
	 RtcBC0cdscxYE32vVgdYJUfKMg0no5HOxvmVSwmIzAHzrYVGqhO9jYSuBR+smR8IhDOJy
	 EFyYCL/0yUnaUQF0fS1K433XAIXzRz1VnVxDsvQNiuwRGhI/oP+9YuVa1NL3O6J3Sdd08
	 5RjYM/J+lBBccHeBoZ1l5V+ZVI78iQQ+ZuKbcFRntsPdilkHW4oOA7VOFkkD6nOCN9gQ5
	 uK1CUnhmTkLMgMJPmx0DHMrfQD4XEDo1vv2YJhVqKWRYjOoMHzP1MJHB5ZYQjuvPCwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ipvG/M9V";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6C606A323
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipvG/M9V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825741F008A3;
	Mon,  9 Nov 2026 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185747;
	bh=hs5Vukzpfby/J+qLcEHGmxUx0LMHQGU3qflzm/Kqd+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ipvG/M9ViraLrCLcDs/G6NQEGN7TwXcPWNR2zEQXeniU0bojDYoOC+7dCNL9dwPJS
	 M5wPU1R7+CNyNtJhlLBjvy6ODEkRxLu+VLHJaNcAU5Txwgwc5aPGMFpj0yKjz2ZvVo
	 Lc5RoanDIzvAbRUD3JJ9E4LzWAx/wWVXON1vIppVxZ6bppUNR94xVcFeaMKzxKwSFP
	 +ePMqP2U9pK7JDTGNDlen7Q7B0vXDQkc60U5jWTs/j8uHcXUS/BqnLgll8gem3qTIt
	 FNjGyMuhGWOEDv4Tll5B7G/n11/pBWK79F9AGCLITwdGZDXjkKq/I0UOYl1gDRyvQh
	 uIvUkTBYwqo9Q==
Message-ID: <sashiko-outbox-204264@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 1/5] perf tests: Skip zero sample IP in object-code
 reading test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109004402.1403713-2-dapeng1.mi@linux.intel.com>
References: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
 <20261109004402.1403713-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:55:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The kernel may clear the sample IP to 0 when a user-space address is
> expected but a kernel address is sampled due to hardware skid. A zero
> sample IP causes the object-code reading test to fail incorrectly.
>=20
> Skip zero sample IP values in the object-code reading test to avoid
> false-positive failures.
>=20
> Reported-by: kernel test robot <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202609151503.cb02f753-lkp@intel.com
> Fixes: 166f10836a65 ("perf/core: Fix kernel register info leak via hardwa=
re skid")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109004402.1403=
713-1-dapeng1.mi@linux.intel.com?part=3D1

