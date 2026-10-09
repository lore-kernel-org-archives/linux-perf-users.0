Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECE3A83BF
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516694; cv=none; b=CDbHHsiiaKzjBa3otT2LRvbSFN34A6Ln6m2z53l8ntmHwtjhFmKem1saa75ilQn3iHlAo7XKP8RWrfwytL7lQlWFoyeA5ORWaqfAUeem+Mx6I2brziHE0+jOGP/pY1gFBbtbjBvogOKY9gQapYO9y/w2pJz0Ky5Uv9rROGTKapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516694; c=relaxed/simple;
	bh=MyzwYERjjmbMBfpfDVnL0qkVqRb6INn7y4BLiSdOz00=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LqnPl1lwcMAo14hCXDyxbRl1h/9tDXKMer8hETYhg6areFiSokpkYzbMObTvfdzjlM4b9nG2qcvpYbB0o94e17JSMLaSV8D6iJmumE5G3kyCqNjxPluZ4NHWs0lbNKsImHBTQo/bT+gtw513ElOiJEDqpLMld4O4IdcwbV/bD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCNI60Oc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCNI60Oc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464AF1F00893;
	Fri,  9 Oct 2026 03:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791516678;
	bh=I6nl/kj655iizsJgRRWBxrdv8/TEPvrXP4kDQkXdjM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SCNI60Oc+mHLBIQfGmecUgA8IIWZQSEMeTmc4y3msdPDQBlxUmMKzx/PJyO32lAA4
	 h9++/r9LzF9pxelq43AtDnrxwkkiZjqiebD3WKgjaKs6+wll5RRKBgQpgaeW0htmiP
	 P0CuNSkWdBBf8EkUsKD31v+ha9HXoGZ4Y0oUzRiHAapoRUXVhvha+9IUpROYu6eaUC
	 r4kTbBeNKzG4+wn7DgeRawKrmJk4g/J2hfVQ8AE+as+I6Vw3VfTXzmdRBnMAdcT35z
	 1784Vjb8xe9r9D1SkNtrt6sJsBcYgbHBXx9XebqxnzUuhcrDtjy3NszFJds1hIrgkt
	 X0+gtwXE/gpDg==
Message-ID: <sashiko-outbox-164767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf riscv: Implement rdtsc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261009032715.2841-2-cp0613@linux.alibaba.com>
References: <20261009032715.2841-1-cp0613@linux.alibaba.com>
 <20261009032715.2841-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:31:17 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Perf has no riscv implementation of rdtsc(), so it links against the weak
> stub in util/tsc.c and every caller reads a constant 0 that cannot be
> told apart from a counter standing still.
>=20
> Implement rdtsc() over the time CSR with rdtime.  The time CSR is a TSC
> equivalent on riscv: readable from user mode, constant frequency, and the
> same counter riscv's arch_perf_update_userpage() builds the user page
> conversion fields from, so the counter and perf time share a timebase.
>=20
> Define it for RV64 only.  Reading the counter whole on RV32 takes time and
> timeh in a loop, and no RV32 user in tools/perf needs it that much, so
> RV32 keeps the weak stub.
>=20
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009032715.2841=
-1-cp0613@linux.alibaba.com?part=3D1

