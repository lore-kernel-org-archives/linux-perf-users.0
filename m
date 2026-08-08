Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93A3E8684
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194425; cv=none; b=kagriVUHJpzCjs8InKrTow+bSPe5PXYk3kHKdTeUgBonCxx+lHYd65aNEd+7+bWYJEiu/ldihLDkAryyv479gRZbo+/KPf19R8T1bDubFQcc3A8AkQ7HgmOnVyv89vgJNO0DKFCmf75KJY0+galKNFoI1rtx3DJqFUQ+O/bpB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194425; c=relaxed/simple;
	bh=uRcBbDKx13UqfhOiBjPXHv+b+/zdiFDiLFuZZKTq29c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RLaLG7N/otv+s3weQLuZfffV8Q+ChA4r+hZNAa/z5uvlugEnr4dbrk1aclv8Uqh8qvOEAco36yAUfa42VNa1VrgrQTogEQ6pQTicALZT+psRanpoqv7qtBq9ARarYJztDOAodJRQnRnXkxgnkMyhspprbL1t50qSfANYR9Am9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB34qnT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB34qnT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF40E1F000E9;
	Sat,  8 Aug 2026 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194422;
	bh=BRSH3rgEmOG0W+/0dNOhBZjhj8XDOu+V3P63Rq84eQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lB34qnT3X6ULGd0rreq55URlyi3oHMK9Cn4U7HupdAn7vBWbYc0nNrdHqNrBEd2Tl
	 a6nfRWNG3TLRAWs8XZK4o/wAGd11MgiKFQSx5AUGgI1YRlxFlsuj2zT9gMWxfXG3IG
	 a3s9HJijUzD9/KPNsvbu6VAs9HQVxQ0/sBBhPny05az8cXppkUyo9nnKxP2Z+ISloj
	 rvuOh28QUz1Z8vUfCIIkTCQc4v2P4pe2R8Ggt+QYeGvEUMSligH3ISTn1p11WMLMRr
	 Pqe32+Ir0xxVjbLHg4VR/InVuziaQhLFQo1oZD7KD1B6yChJS4D4QfgkFn5t2ypS4o
	 NYDk4v24fCqlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/23] perf annotate-arm64: Handle load and store
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-5-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-5-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:07:00 +0000
Message-Id: <20260808130701.DF40E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] PC-relative loads can be incorrectly parsed and truncated if the=
ir associated symbol name or trailing comment contains a bracket '[' (e.g.,=
 C++ operator[]).
- [Medium] The arm64_ldst_ops struct omits a .scnprintf callback, breaking =
UI formatting for PC-relative loads and discarding resolved symbols.
--

--- Patch [4]: [PATCH v4 04/23] perf annotate-arm64: Handle load and store =
instructions ---
commit e23857fdcfc409dfdff0cd84b9fe8f31c4283050
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Handle load and store instructions

Add ldst_ops to handle load and store instructions in order to parse
the data types and offsets associated with PMU events for memory access
instructions. Matches instruction prefixes to handle arm64 variants.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 5e824fd617ee5..32752a3bc756b 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
[ ... ]
> @@ -163,6 +164,108 @@ static const struct ins_ops arm64_mov_ops =3D {
>  	.scnprintf =3D arm64_mov__scnprintf,
>  };
> =20
> +static bool arm64__insn_is_source_on_left(struct disasm_line *dl)
> +{
[ ... ]
> +static int arm64_ldst__parse(const struct arch *arch,
> +			     struct ins_operands *ops,
> +			     struct map_symbol *ms,
> +			     struct disasm_line *dl)
> +{
> +	char *s, *left, *right;
> +
> +	right =3D s =3D strchr(ops->raw, arch->objdump.memory_ref_char);
> +	if (!s) {
> +		/* Fallback to default parser for PC-relative loads. */
> +		return arm64_mov__parse(arch, ops, ms, dl);
> +	}

[Severity: Medium]
For PC-relative loads, if the associated symbol name contains a bracket '['
(such as a C++ operator[] or Objective-C method) or if there is an unstripp=
ed
comment containing a bracket, will this strchr() incorrectly match it inste=
ad
of falling back to arm64_mov__parse()?

If so, it appears the subsequent string manipulation would use this incorre=
ct
bracket position, dropping the characters in between and potentially corrup=
ting
the operands.

[ ... ]
> +	ops->source.multi_regs =3D arm64__check_multi_regs(arch, ops->source.ra=
w);
> +	ops->target.multi_regs =3D arm64__check_multi_regs(arch, ops->target.ra=
w);
> +
> +	return 0;
> +}
> +
> +static struct ins_ops arm64_ldst_ops =3D {
> +	.parse	   =3D arm64_ldst__parse,
> +};

[Severity: Medium]
Does omitting a .scnprintf callback here break UI formatting for PC-relative
loads?

Because this structure lacks .scnprintf, it will fall back to
ins__raw_scnprintf(). For PC-relative loads that successfully fall back to
arm64_mov__parse() and resolve the symbol into ops->source.name, the raw
formatter will ignore the resolved symbol and just print ops->raw. Could th=
is
result in the UI discarding the resolved symbol and displaying raw hex
addresses instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D4
