Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634567;
	b=a8ejPm85OkO545ItzaFEl1VvGJSAshbwKPBK3LzNRi6CEpYNFLz/1j/XmJw6ctNeJ9LU
	 WBHXT1BW84LHlVsBGl7ALxRGVpHVmxitGArSEAK20y7ccehlJm/y57bSRd8H7mwqRUDQO
	 cNBXLVASnDkRbvRsN1oVtIOKG4+kVXuhDKVTT2/XHBlmDnv97xlyRwPVzzVPj1FlJuTM0
	 4AGjmd+vvaUKcm8DHXjuX90jpB1x0VYaMFACWW2RgYi7yuO+nfKP/SqnL1+EYcdgX0dDc
	 gW1kH30JwUzrpXAafNXbVmUjEa+c6llmrN5zMdn5OTuGXt2ShaDSbhH/w0E40xOguZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634567;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5TAesQ16n6/HYrkmR0RXwl5BfvO7DFIxCH5kr/EvYMQ=;
	b=GqXlOEYtVe7tKSPlxJNElpaI9gr+vqQmyZ3ROWfpONxUAFv6UFrAzA3cCvNAkrkcu98i
	 pGQwgi2z/adnPQixA+E3njqs0FSFOoSqhncd+VSsYvie81T2UVrnaQGvNmgQQ3oLrsVde
	 /zcvoha2O9xklMuKjX4HZJ8mCWvCo12M+ebEJX4C7gGutYN82H6yoEd0tzX462XRcfejH
	 dYbY90AhowT32prHqgHbaTLqwH0XorNtTKkkl68adGQWhq8q0ppmEUX5aP54PioAeUgqG
	 CbcOy8rRHQ/mMcQiZ1tgnDJhnHSjMGvFRFASRhDYow1Wl+qcnqxQsWJCYpwlNSaw55Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzBQKTnp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55418606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzBQKTnp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE33F1F000C1;
	Thu, 22 Oct 2026 02:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634566;
	bh=5TAesQ16n6/HYrkmR0RXwl5BfvO7DFIxCH5kr/EvYMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzBQKTnpA7QtaTeNlpyfnV/zmAhYOOCkrqc639/GGZJeMygRF+igLBBKkBoV0DmiS
	 bWHg5BpXYNNpC8mvjalxT3KLPBuqyclyVxugMRkxnkBetzbs+pkvniBMiUAjmnD0Cv
	 wU35Ja+TOkS9T/n8XiVfYr1HRxe/0UnFS3cAyZycfYTbWzE1OdoPzkfnQkROf2aVA7
	 o2z1mCu6gaChHiIPeAbKmA8+6K7kohj9joNRqKFcWhWEGp39rtixQX8ICczBBT3EZh
	 8jLhp1LkcHTQEn44KPXVu3uqRm7+hTeECwfU028gTWOX0uczmY5wzLNjFIDyWoDviR
	 vfsXbGzqmbpLg==
Message-ID: <sashiko-outbox-180853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/9] mm: Bring back mmap_write_trylock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022015712.1297331-2-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:02:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Commit cf95e337cb63 ("mm: delete mmap_write_trylock() and
> vma_try_start_write()") removed it when khugepaged stopped using it.
> uprobes and dup_mmap() are going to use it.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015712.1297=
331-1-alexei.starovoitov@gmail.com?part=3D1

