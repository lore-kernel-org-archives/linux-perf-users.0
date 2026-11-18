Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042161;
	b=aWBt3fxPGeC1gFWsPz6Oax7HsH9MHx4yD1l7cz954KS8v+3fKb6kbzo67D6xHNCoOnjq
	 JgRh0f1NpS92YT57tz0aIAIvjKrGVZKH+Puvh+4SgbMLCf6dpwsYmN8Uo/nnMuXAvWCS5
	 ml5FccipOUHtCk6RvQ3cYE1rfgNC34RTGCut+PUNd2uHQMH1qDOWd77WFVZO4eo+3yvG9
	 Y2WDonk8ZI7uDFWf8mQ/J+ipZ4DqIQdHYqg0vYbUpqJJ0C0Lgx3Knx4omIu2jxEOHkcRN
	 FBu05B9EJ+jsOfz/5Jm4To6Ek52pyn0Pqsh4e7XTRBSeTBHoMTnMPKdX/1uwb5YCtJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ldIVAX14VaNBxMwe9MErIhratKnbjdkOyTwgdBsoX6c=;
	b=cZDzKWLq9aMGnG9gG+e68YdScFg1wEz0rXMqmJHEtx3obUGFkuXf40u4c8ROP4sGVDKZ
	 Jxjt8o41RGQ0aptuPoltZ7UbgsqOAMX9TKXezhDmUwG2eDYBLzvSe4P5+5aOIc2lje6SS
	 ScOrguS1TXWcVKkDA0TURoD2cnyvIrTJPyHx7cSz+MHXFif+nP481ftSQeNUdxyHRY7xZ
	 jGJHIAvchqR0HwpXoPl0aZUD43RDJeWvJoqQ4ivJjusnQ7qqA3T2EorcFCci0dsFibyLP
	 OAmOQgvej8MpPrDvYe7dgJhUZBQI2hztN0K34PH+EwzP0QaJzeY+CjsC3OkdFGp2qJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO28SPLq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC048606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO28SPLq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857F11F000C4;
	Wed, 18 Nov 2026 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795042161;
	bh=ldIVAX14VaNBxMwe9MErIhratKnbjdkOyTwgdBsoX6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RO28SPLqBnBF30lpPTRY4GQFBvV8OwPQzj3VKBB60btTXkhvRQq80Nx0ThOtNw56H
	 pRC3/ouIP/euj4UTvfiP8ssJlzL6Nz+tTjJZeqjaDfbGYEG4kAZOSw24kLMYmRLoiW
	 xslIl+3A2I0jdN59EPrl1zKkB+kivghGBNw5p8F10nlYN0/VYEoQ7+ZiHx1Mw3YUPq
	 5/x00TP/sS07O8gAEXKSiwMCk43Y2vwWZg6kbbgOpwmCtRDjudDO25zPTuF7ZUilVJ
	 nkiWf51xHBoIpNqCwl7H/uskoJ3xKWVaPCsngcyC0xakjk92BTGDC7EGxJU059l/ln
	 kgnQT6R/i4b6w==
Message-ID: <sashiko-outbox-222128@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/13] perf annotate: Handle absolute addressing in
 data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-4-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:49:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> 32-bit x86 accesses globals with absolute addresses, like
> "movl %eax,0x8c73448", but the operand parser only recognized the
> offset(reg) forms, so the operand had no memory reference and the
> resolver skipped it as not a memory access.
>=20
> Parse a bare hex number as an absolute memory operand, including the
> negative disp32 the LLVM disassembler prints for values that do not fit
> an int, and use the address in the resolver; calls, whose operand is a
> branch target, are left out.  Let the instruction tracking record the
> type of an absolute global load in the destination register.  The
> displacement is sign extended for 64-bit objects, as the CPU does, and
> zero extended for 32-bit ones.  Values that do not fit the int offset,
> zero and the operands of relocatable objects, which are unrelocated
> addends, are skipped.
>=20
> With bare numbers being memory operands, a frame base register of -1,
> "none", would also compare equal to the -1 "no register" of an absolute
> operand and take it for a stack access, so guard those comparisons.
> Operands left with no register, like a user space "%gs:imm", are no
> longer looked up as variables, which can change the data type stats of
> those samples.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D3

