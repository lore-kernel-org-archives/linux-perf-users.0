Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795139366;
	b=eb7Z+Xs2vSx4MaY0fW8o24jdZXVD2gjxGnAHjpSUykzL0BQfl4HXbrySOVLt5CdRGBMP
	 jkoi9suXI3YicolMc5yBFbFGw3hZrdYmFxH4DJxwvruD4yUsXhKjmjQjro52INbBklTH4
	 M0knxUo4IW6suQq83SQDObeI+l8sadAvhaDsKRp6MpLbqAIvv9tWKT9o4Tu5dBHaAIhgW
	 18FU6ozFQStwctwIEz8NcKBXL2DZTD1PJsYWc2gtr5ftR8Twlh/+Jdp2L5t4Vq5d7OHOb
	 bADGkMTUU8Lnasl79C1tscT4mvbCFr7uCJwWW2iYxHmZqWK2ToaGky9XhLelDi5/TJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795139366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mG1Or10kuLcHyDKfTSfnb+fZBwMfOtPEugqenjzXUT8=;
	b=DDV4sKB/1WrSWuEzTXATllGbV+9Sdwdez6E0afpDLOIJkqwP4/CX1BOLSYi7iVLnQ8GJ
	 UeBw7/K5532rVXI05TafqarW+uskdptcpOK51kaSoBBOGFzTLu48ccc7IlaLRWJk1Ydh2
	 61Ab9bETrk35Xr4UUsghfFYxt/TuBijYsLH6KEiOKOUvBXYvAEArxOYiETp3TDVs8py0s
	 iutADUUkE9cT19ERU3Bz9tvT6isokSgl1K8deCkybg8KNbqKIucraT7HJyQ9YSWxJvZUS
	 CW75FcQhSpa4BDr4eKf70Isxwt6PQxOWiv4o6fSvSe0aZs3fTdMRsNWRRL+hGd1/lMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRYthxCP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F98F606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRYthxCP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ED01F000C4;
	Fri, 20 Nov 2026 01:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795139366;
	bh=mG1Or10kuLcHyDKfTSfnb+fZBwMfOtPEugqenjzXUT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FRYthxCPn6Fi6+sGrGwCDZl9sCI5ZqOpDhUM328rPhnmUfsFj2qk5txuXSfFKwDz4
	 6mKUOVD51xm1i5M/Tdp44aWR5oyGl4ZyPVS/9pktSCIe/2VdH6n+jCQh1WUGDVXQsJ
	 j2F2G/KhSh45Rj8DH8ZMlCyPTVmzyTSNGJ72jJr70L0TveEl0Pd+mrBrq9lE/9VF+o
	 XG3YJlzdt79olgW7Fw/5O2VFpBt+mxjfF1ZJJpBCTylDY9L2xOJjZRPoIl94clv8nW
	 d+AaIyF8T4+TcXJ4pWJpeuEVmMPJF+LcdWlRxQg9WPgcsnlAh/Ufp6JrOPDXTSi3me
	 XvwmC46KfAhDQ==
Message-ID: <sashiko-outbox-224340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/13] perf annotate: Handle absolute addressing in
 data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-4-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:49:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf annotate: missing movabs entry in x86__instructions
  leaves it unparsed
--

commit 1846110498ff835d20605b89dd376d9b33a97c53
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf annotate: Handle absolute addressing in data type profiling

This commit parses bare hex displacements as absolute memory operands on x86
and resolves their global variable types during instruction state tracking
and data type profiling.

> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/ut=
il/annotate-arch/annotate-x86.c
> index e38a4e7a54d55..03c32032cde0c 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c

[ ... ]

> @@ -960,6 +970,30 @@ static void extract_op_location_x86(const struct arc=
h *arch,
>  			op_loc->offset =3D strtol(s + 1, &p, 0);
>  			if (p && p !=3D s + 1)
>  				op_loc->imm =3D true;
> +		} else if ((*s =3D=3D '-' || strstarts(s, "0x")) &&
> +			   !ins__is_call(&dl->ins) && !ins__is_jump(&dl->ins) &&
> +			   strncmp(dl->ins.name, "loop", 4)) {
> +			bool neg =3D *s =3D=3D '-';
> +			bool movabs =3D !strncmp(dl->ins.name, "movabs", 6);
> +			u64 offset =3D strtoull(s + neg, NULL, 0);
> +			bool exact;
> +
> +			if (neg)
> +				offset =3D -offset;
> +			/*
> +			 * The offset is an int: a disp32 fits it as a u32 or,
> +			 * sign extended, as an int, which is how the LLVM
> +			 * disassembler prints one that does not fit an int.
> +			 * A movabs takes a full 64-bit address, keep only the
> +			 * values the sign extension gives back exactly.
> +			 */
> +			exact =3D (s64)(int)offset =3D=3D (s64)offset;
> +			if (offset !=3D 0 && (movabs ? exact :
> +					    (offset <=3D UINT_MAX || exact))) {
> +				/* An absolute address: 32-bit code, or a 64-bit disp32 */
> +				op_loc->mem_ref =3D true;
> +				op_loc->offset =3D offset;
> +			}
>  		}
>  	}
>  }

[Severity: Medium]
Can extract_op_location_x86() ever reach this movabs check on real
disassembly when x86__instructions[] has no entry for "movabs"?

Because ins__find() fails to match "movabs" or "movabsq",
disasm_line__init_ins() never runs mov__parse() to split dl->ops.raw into
dl->ops.source.raw and dl->ops.target.raw.  annotate_get_insn_location()
then passes a NULL op_str to extract_op_location_x86(), which returns early
without resolving the operand.  The new test in annotate-ops.c passes only
because check_operand() populates dl.ops.source.raw directly instead of
going through disasm_line__init_ins().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D3
