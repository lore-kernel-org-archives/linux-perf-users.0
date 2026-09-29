Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3C3EAC68
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 03:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653634; cv=none; b=O1WVNo1woTOyd/FvlqPLHnF/eEbAf4Ill2HS/7ib0C5sCX2VEJ9c4Nk5lxahG+vaaaCEnWt9YEcnlV66jvvhvMUvr25aN0IE8hho/aSzPV5QdLvcBoyPUGwSgvB9cYtgqApcRbTlXfinCaK8pWQl8TW/NhkWWGEOts1ERxVsCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653634; c=relaxed/simple;
	bh=wgD17Z0I2xKr9HnXQsdOT8+zXE2vQzGqpsm6puC+kjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TACAzLnkI+QHR1wZFaMGp3OMrW6m+AsB00/QcaLsx0Kb9gpri6x6NV7oMPKIcnkTyDLHamyJxlsALI03reNHSVgMmcZERoSpO+2VpcU4fv1a0Ehhifx1HET4av0fEBhW1XgXjquFzXkxJeD4fZg365hAc3YMPQNOFYvwE20n1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAMXhqd4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAMXhqd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5EB1F000FF;
	Tue, 29 Sep 2026 03:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790653633;
	bh=7GJ5RZfwcrGHuQE21bdKmIIYEJ1GzJt7oMUqQU/D4Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAMXhqd4enzHfA41DK1oDG+3bCgq07vSV7lmTDxAG7QunVCqJcQLGIj+RfPU7JC5+
	 nWv8dBUb9IwJ2Krqydp2og5LaGi/hHJ+VgfFvkDzg5EjSj05VICvrcdhXbMuGUaCa2
	 QK3PQ3alJT0VDt+qT1tiwrC0PjXSvyEXx2Q8Kwe8b1YowXbDbwKh+Kj44hs8Jpe6tG
	 MLR0IKZCJyYUMtx1VVGrmzrrTuIk5WVnjaabnij9bPVRbjfSSKyNmIM6sFHmU5YMH5
	 amBniB5oSSDiVnM0i2pGjeKgTHhWn097kLA3Ijmq+u31x+33NOluwFGc1E7HBF+9vw
	 ya46Md3vradug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf riscv: Implement rdtsc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929034133.2153-2-cp0613@linux.alibaba.com>
References: <20260929034133.2153-1-cp0613@linux.alibaba.com>
 <20260929034133.2153-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 03:47:12 +0000
Message-Id: <20260929034713.2D5EB1F000FF@smtp.kernel.org>
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
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034133.2153=
-1-cp0613@linux.alibaba.com?part=3D1

