Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424164;
	b=46aL3neaL0icvvzKXkym3TD7nHqb2GoySoUMmm1YMGo97O629qyIgfwoYo3wXU+DjGSf
	 x38nqqMLvblKgHcjeG21QcrWFXxS4UUSrIIgI3UI3D6zKB5SDDGO+RTp0/FgZ8UhTnMFo
	 JhHJiw9ZWYyCcFO8snHtm/5skuYYn/rHCv+lvlGokcI8CT81A5gp1nMt+e5KKrkVSB8MW
	 6kOQNA+WNuWOJIdoeyxUJHLv16pvfitahPLjnHIoIvQc3WULO3CvyV1sjUwwReL+9RFcL
	 bfGHUgjAe4s11skfWkcRVMsM3T4II+9ghqd2nYsXIr18wbaNCZylnwhcIsrGFfIm4SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xs/vYLzMmiRol/f0sxzDGL7zCyoJTwEcIgJCxuqGYuM=;
	b=QWrb0TDoa4bTxH11OEVprjPyojZnpaXOLD5Fsm9AUapqQkYKopKAz7eXSp16ahSQ8IGa
	 EaIRpOH3gv+njhtRlr2ye1V9q2e+WyggOO2BuC2zM1FewVZ2c+Vce88iIjCJHi0I/kQ8V
	 iiXenAdu4sknfCj5EcSQT7o8UWm1evDHbALNqy0xJ4u6d2+WwsHICbsi8betnGUtf6Vph
	 CUxdVo2cfHvk4obwepifFR5rc0l2E3DM5qyC/qCmxK/Ug7do8gxmX+4sbCXy6ZlKbGh/r
	 cIkvq1ioPsx78kz1ySXwIjPfIjhH0tj2+0JAyGdvfw80m+ZbVCoHwONwzbH+wC2Smxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heHpiIHS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3054606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heHpiIHS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330371F00A05;
	Wed, 11 Nov 2026 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424164;
	bh=xs/vYLzMmiRol/f0sxzDGL7zCyoJTwEcIgJCxuqGYuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=heHpiIHSOdpC9OHl7D8N062psLueMEYwStuQGxXCjocodCVcjUIxAKSiT84ZQ7OPe
	 kDz4o+F0r5V4JQpLw+VQFX8s0cPZFIiKcGS/TNsGsCxKQjJjPY9PDAVgr3iOClFkVu
	 J0l7UuJ5LCkUp9pRZHSue6oDi+JA/WRHUvzGLrIJ5axyXknO3xm8b1cLUrgDVpITMa
	 0fMJva7Y1ZyGirGFV+2jpOG4eRAdJARU8dZ1gg48HnSMSUKWERaLgqoy78ExxUuOI5
	 1r9xt5InhaVGkJSkOjRYxQDmVgPpZjs3Vl6eLCjU5mGXuWa7d8OMqqOm8RBzjovAhi
	 +WJXxOZ2YO+8g==
Message-ID: <sashiko-outbox-209533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/20] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-3-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:09:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D2

