Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947726;
	b=RFmSrGVk2M3OLg4DYG8hPl+ToVwKe0eCSrynN5C07m9Fw3tOln6Xar6Cl+3ICDcgaySY
	 1XqHDaSNleduScz3pF4H/Q3lJYmk19hoinlisqz0WwXsEbTdiaay1a7Vg8IY+ncMCG04W
	 GsXa1EkDs4EV3K+U2oZrSPZadRXOCUg6B9jIhynaYSct9D+7evPzbyqx9mcd8dkA4qNTd
	 eO0RccmaatYuuT+VEXJjuc5N0lqrFt1BrApkVqoo21jDkNcmM7jL/THS23elVoqDOVGSg
	 IlM8X9/75B7q1yq6owpQ8Tu2HrXpdyr/fP1NlHHha/+yDy+ShkvWq08U/4qciH4I29g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947726;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5IiQZbt703Skmjv4QWDhHZuA5YmcgUtpJP94JAXe+F4=;
	b=hFofTnM6ysT2pf2nDlQv/hX2asPs2P38cHEOtzWQCmFkf3HCp3UvQW8AT9Y8bmfUlBej
	 Yb8WxJVHGgUgpfHcaj5MikfTalhnIuNfEAlxgyi9CZ4MMiiSo2+b3+vXMUoXE7SdHK8lA
	 dBj0n3keAgoh0r48CXK6nIyb1iGxD7hK7N/9RlWJhoiYjz/4dZVUuMIFojw2EFVxPFo84
	 eyxPhG8rH5XLVhKcYjP1fHOqiGMYozoke0F3D4BJjNUPPwDm2GAkzki+jfzNRWPn5RHHU
	 WEYb36ie/7IKoOlRX7Gr8KQET5QZ7BRK4c0hT6ohC/wTZ3s3Ec4iVqVG35pS4l3cazA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyOn00CF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F6606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyOn00CF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DC11F000C5;
	Tue, 17 Nov 2026 20:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947725;
	bh=5IiQZbt703Skmjv4QWDhHZuA5YmcgUtpJP94JAXe+F4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nyOn00CFuGHBvU5gexHeFyFdOiXMSGJdhRvEOmr9EBHwFgs2BsKyb/Idu7X/xPmDh
	 GkogvyIje0bu5fz6qCfppqzklq738Wlxir8l9zeCIJCtWF7cwKdaOOQT7II+IXvvuc
	 QZ7scGU3t8UgHIXJPjf2ABHhHmUCPq94OJH+C0edTXahrrQADwRx47uwgq0dHW0tHu
	 ZsEx5xEVCs1OsZfp3hUtNrq76ruWWKSK0qH1L/TWlTm34OyZGq6mUQUZYGoB2Mka5c
	 lS76vbWHUI0fi7yh/CG6quKsQbjZFVbveSMwmm8s0Cz0URhNPdfujOyWlqkJpPyrYn
	 RxeZqG2/pap4Q==
Message-ID: <sashiko-outbox-219628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/13] perf annotate: Handle absolute addressing in
 data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-4-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:35:23 +0000
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
> offset(reg) forms, so the operand had no memory reference, the resolver
> saw a zero data address and resolved nothing.
>=20
> Parse a bare "0x" number as an absolute memory operand, leaving jumps,
> calls, loop* and the 64-bit movabs* out, use the address in the resolver,
> and let the instruction tracking record the type of an absolute global
> load in the destination register.  The displacement is sign extended for
> 64-bit objects, as the CPU does, and zero extended for 32-bit ones.
> Values that do not fit the int offset, zero, and the operands of
> relocatable objects, which are unrelocated addends, are skipped.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D3

