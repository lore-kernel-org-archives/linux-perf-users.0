Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040057;
	b=HA5C572Luczc5JXZ/8uiJPKvzCDEJSEG5RG5joW+hSSb5/CfNjM2X+WKeeJrstHQOu0i
	 gE6kiQ/jFlOBX7k+LbKyihBFYODFsrrTP2lnvgFvvIoOeXcfEH5r8SC3YJeo82iD74spl
	 lvwev56EW+4JqpTF7Z6Wpaf10sPzc+9LFRQOsdo7d/MVflNL0GIoS+MdUGMIuUGMzQ1PR
	 glmAI9rgdLoIV5nqr0q85FRo/cN/h8v+Lx2dFKEKEFn5x/W4Oj+GuMA8Nh2JXrnma2QNX
	 550zvvo5eJz50OMQnlJeOV1GmzkqWFfoLM9parfOrZaJdmQWO+Vg0eGFlZBu3/Alb5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040057;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=az3BWKh9t1So4clyWIgVDP5gQO+qP8GeuvCcw0XQAmM=;
	b=yARQC11A/jdDLiAHZlDuv8+K9ov2hOzGFheT2f/em1CCtMEnSWzy8UBqyfQcnG++53AW
	 jjw26ULhDISxExw+BdMFbZcd6eAkuWqPNpy4vr8ID49Dmxtw6438VpaHiSMzgWGA5GZqo
	 z/INe4FguuXMnoUesecZZ69bkGeyhxproVplU0Gr25/ruSGnIwsUkNqb6y+8qxG5nSZ78
	 nycPOLetvMJDAXWNmHin21adaCidSH+pw95uLWCltTvjOo2DbFBpv1ZxM1zenvNpH+EOw
	 FPs7I988RYFFQtx0c0wTce5Nz03bFSy/ojo3Y9rxIzuEapbUyMC2WbEN9r8xkLhdOfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lndXHxG+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED4606A32F
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lndXHxG+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796491F000C5;
	Wed, 18 Nov 2026 22:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795040057;
	bh=az3BWKh9t1So4clyWIgVDP5gQO+qP8GeuvCcw0XQAmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lndXHxG+jRxUFKWysXMyoY73QUOGNWdZu0gmvYr2TE2M/ra4NEZZq+0CMga4JVuyP
	 fsx3qt8B9uw7NBR7ofTDV86pmRreye+iDDbTsHfCTb5fL762ZJhYw8tVd3JwPIi8Ux
	 fNh/ttqPRB3gp+aUCkflh67vYoOy0nzAwyJNzrR4Ew76WUtxmraECHTRWPHbRFzZoG
	 kpkmE2sSi2MBbsIpEhJp7VoRbFrbJeVNXWGbyCam26KObhcOzXpmQwk5Fxnk9OV31I
	 f97N4NXryns5H5YQnNRhAZTiOGMW8nsxcDbU73m31mlz3Ma9vnBQYl9I6ZIdlQo3jS
	 2/kscAABO6Fyg==
Message-ID: <sashiko-outbox-222103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/13] perf annotate: Handle absolute addressing in
 data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-4-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:14:17 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D3

