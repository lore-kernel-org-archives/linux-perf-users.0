Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE140B6F4
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194305; cv=none; b=jQ4HbaTwb0vZckyn5wPaZ/hi1v+WrZjxe7P0h6MPjvewNc4BT9tvpbfY4gYeyr54MP7wDkI12/jcuz7CKiJDzRhH1HUvDRvf5gszPOXqDOzG1+GBY5VWrgCQsQPmW0ZmxRPAn8BfNRvW/ua5PGxCjaA5kolGEdxIy3b+RKUJuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194305; c=relaxed/simple;
	bh=XvTMJfpea16MbdlQSJDYcE5vVgiQhOU4igsUP3aEoHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E171/nLLOv/2hR16wHo4ygS8twK+HwiWjaP1R6rEBEel1Eq/szwATHOuuxiyLF4qXVG3I0HAHnMXBqdYhtvTaHpQ9a8S9mlSZFuuUKaLS+cBhiZATsLPkRlBdwS2ez/XDS/7qBP92lEBzFStGeMQRYfddu0ZhUXQUYwSXSM4W8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y05Nu0tz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y05Nu0tz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA31F000E9;
	Sat,  8 Aug 2026 13:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194302;
	bh=u0kaq+iSOKAX8Um2VIgvHqVoyFaZ0cVaPOUyp7rEEdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y05Nu0tzxdEvIOZzVo9HLGOyR5T6bieX6aAUZ4itjO17HbnBKDlZKbs3Kk+SapR9b
	 FEFOaUhRH/U5/x02uDhvpG3we1iiryIa1g6EEr2+XpPI67hSx4vjZERszUNEJHNLIg
	 l43/DFBeVSA4uNMk/Fg86teeEDZ4A+Ce5FIFJn863scWE7mRuxaEBFr2O3IGDQ5/PM
	 ZPSOcLMe++fmn/u0EZR5OgXIaX3nLWplBIYRWdVkY4iFh3hT0xBHcTHhsK606Mu9/z
	 5iaWpagC4znjFPtX2NGlNA2JZMiTmjuyrBOX5ZyW6ODaLRUopgwfnGrWkwn5U7MdOO
	 W2Pizp1xBH/9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/23] perf annotate-arm64: Generalize
 arm64_mov__parse to support more instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-4-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-4-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:05:01 +0000
Message-Id: <20260808130502.02EA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arch->objdump.memory_ref_char is uninitialized (0) for ARM64, ca=
using arm64__check_multi_regs() to fail parsing memory operands and creatin=
g an out-of-bounds read risk.
--

--- Patch [3]: [PATCH v4 03/23] perf annotate-arm64: Generalize arm64_mov__=
parse to support more instructions ---
commit 0546b270cb844bdab4fcf529e313bb0ead4fc3f8
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Generalize arm64_mov__parse to support more instructio=
ns
   =20
As the default parser for arm64 instructions, arm64_mov__parse()
currently only supports parsing instructions with the 'addr <symbol>'
suffix. Other instructions are not supported, causing a lack of
source and target information for most regular instructions.
   =20
Generalize arm64_mov__parse to extend its parsing capabilities:
1. Parse 'ops->target.raw' and 'ops->source.raw' by default.
2. Utilize arm64__check_multi_regs() to identify if source and
   target contain multiple registers.
3. Maintain backward compatibility for instructions containing the
   'addr <symbol>' suffix.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 33080fdca125f..5e824fd617ee5 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> +static bool arm64__check_multi_regs(const struct arch *arch, const char =
*op)
> +{
> +	const char *p =3D op;
> +	int reg_count =3D 0;
> +
> +	while (p && *p) {
> +		p =3D skip_spaces(p);
> +		if (*p =3D=3D arch->objdump.memory_ref_char)
> +			p++;

[Severity: Medium]
Could this result in an out-of-bounds read?

Since arch->objdump.memory_ref_char is not explicitly initialized for ARM64,
it defaults to 0. If the operand string contains trailing spaces,
skip_spaces() will advance p to the null terminator.=20

This would cause the following check to match:

    if (*p =3D=3D arch->objdump.memory_ref_char) /* 0 =3D=3D 0 */
        p++;

This increments p past the null terminator, and the subsequent call to
arm64__is_reg(p) would access unallocated memory:

    static bool arm64__is_reg(const char *op)
    {
        ...
        if ((op[0] =3D=3D 'x' || op[0] =3D=3D 'w') && isdigit(op[1]))
        ...

Should memory_ref_char be initialized to '[' for ARM64 so that memory
operands are correctly parsed?

> +
> +		if (arm64__is_reg(p))
> +			reg_count++;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D3
