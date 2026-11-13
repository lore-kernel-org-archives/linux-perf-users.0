Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613622;
	b=utlU4d061lvUEU1LTmZxjU8Zvrmy9xQ5yU7mHhqyxkU9+0LLFrxBD5DLSB0ulZ++8mog
	 RXPtvz5JhzWvcufBYlSc50ygN3ZIRx9lTpqMud2EEQrI6X8/7GSjWw9YXIWV/cfkTZBE5
	 UsvrhifuLO9mxSdJdpgeDYK2Gv8XqUJHeXi84Ix0qi9sUiaq3BeMitBs4m0JDvt0DAV2d
	 5G3G6jHNh7ZQgqzFlQu9ivk58Imk5uCj471e3ch2+wHnYDAJkyLUqDamVaM+xSfr9mXsB
	 b3oj6+UoZ1H1IbAC4tWkBiEAJ8Js1OERXIYOy6GpWMTDg2T4Zhd9bpVRc/auzv93xJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613622;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NsS0toXUGM9iYW3GupBFA7t0EtDkihKamooJukR9KrI=;
	b=EdXNoYKO7JxaZ3IIZOsWWuey0sp7O5WSw7s4q0k7bOtyASwjmY/+I/TfduXrQFkxhd7H
	 lkU7oSqnY9cAOryzLz0HbT0hKmRCci+YJ2Fs4kzgRAq50eMGYvCHla4sZkIU+H3R4appF
	 Ar4Hpl0Qz3l332DJbFE5fvPpkXsNDiVVjyi1zwImqSxlMqayJ8t6bhhMnGgMmCHMhGgov
	 1g1Y4D7Ms3nt7+B4xMCeP5vHbZIjwVBs/yboZUMeG3X/UTJ+dc7SBBcHXchP90rrCVXDP
	 TooeemrzncGYVEcpTbQYP9BXjRvcN9s9ZrsTndzDQ1I6LeOFRiNYK40UElylQ4/8sNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xu0D2OSW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA5606A336
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xu0D2OSW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09491F000C4;
	Fri, 13 Nov 2026 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794613622;
	bh=NsS0toXUGM9iYW3GupBFA7t0EtDkihKamooJukR9KrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xu0D2OSW7Lm9Uxvaxy+Wz2243haUPzh08ycTe7/bcYIFf+AAc625Ru8RKZ7YH91I1
	 BSbkC3QmN7ZuxbVMke8AQjh83eUslZ56kmBiWSxtBFhwjXGsypUzf80sLqUNu06SqE
	 IxESYZGlsuI9DeV/pebMqpYAVdDzYD1L/5Zur10g588uxr40AZuCw/LeZSN6Q+nMsm
	 F6ZgxvgFmJTXg1wyNY47XnAAmcYVKW7wVqBZ1sK+5DQU5HaU1x8AqU7TptMvKOliSC
	 qe8izNmvm73fXipOoIw4UuNbWP0iHPRQlTxcOZ3OGiqOQTpGDPRxMcsixtVuae7Ze2
	 xTi+wzC58QTQg==
Message-ID: <sashiko-outbox-213874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] MIPS: perf: Add SB1 userspace callchain
 unwinding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261113233358.538698-3-f.fainelli@gmail.com>
References: <20261113233358.538698-1-f.fainelli@gmail.com>
 <20261113233358.538698-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:47:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Restore the userspace callchain capability formerly available through
> MIPS OProfile, exposing it through perf for SB1 and SB1A. Commit
> 5f307491f3a0 ("MIPS: oprofile: Add callgraph support") introduced an
> in-kernel userspace prologue scanner, which disappeared with the removal
> of MIPS OProfile support in e258958945c6 ("arch: mips: Remove CONFIG_OPRO=
FILE
> support"). The MIPS perf userspace callchain hook remained unimplemented.
>=20
> Follow the former OProfile approach of examining instructions before the
> sampled PC to find standard MIPS stack adjustments and saved return
> addresses. Bound each scan to 128 instructions, use nofault user reads,
> validate frame data and stack progress, and stop at the perf stack limit.
> Handle o32, n32 and n64 address widths and the actual sw/sd return-address
> slot widths, rather than relying on the kernel's unsigned long size.
> Allow the sampled leaf to use the live return-address register, and permit
> repeated return PCs when the stack advances so recursion is not truncated.
> [ ... ]
> types retain their existing userspace callchain behavior. Nonstandard
> prologues, dynamic stack adjustments and signal trampolines can truncate
> chains.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113233358.5386=
98-1-f.fainelli@gmail.com?part=3D2

