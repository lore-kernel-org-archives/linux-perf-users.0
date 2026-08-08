Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D072284896
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786195078; cv=none; b=Mz1YkIr3Xkw1Y8qrI6XlbCOqE9mH8+rkIYV3KjJqvn0j7RZZGrLUYued5VkDbtg/mtjBt0skCIfKwoNshcGu4Seh+GYZVxBZIeVgQx/d++sJxgirqb9brK795Hh6BbcsestFeRjdlKoYD+N8SpdnO6iKH96u8ZnBX22lIhcGtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786195078; c=relaxed/simple;
	bh=zZZWCL3l22U4opVogw899AFjjDFmIdSAUPEk2BticNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i4zmeUFNf3o7KwsaaclmX3UEIAxiHb9w+7aZxAVEIflQ/tzFw2hPyxdXW+6PSooSdHVduQgBTOvJKcK4EiyOtUF+mb3bl0IXdV8U15YDb3IlAV63YfdtKydZFCGKrM71LUj8SZ30LTQLnOH122irRDNXSjdj3t/G+WZV8VZaPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmHp57AA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmHp57AA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223CB1F000E9;
	Sat,  8 Aug 2026 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786195077;
	bh=+L4Ywe4kxHlVqhVPA4KkPt/0RZUhUpkC8kS3owV9DyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mmHp57AACtcBYRwXtt/MntMqk/e0YC3r+xCIaiWV/0IEQuF/914ztJpMrS7XEExgP
	 yNZ5v5Tj7HZr4OP4QRAHbHRtmLxSCNzLecxZIMzW83zLnSpOS+EDFrZU3iT1UEsbiE
	 9FZbYLl913Y7UxZfUzbIyg9DiH3GLLe1JWKiVxExBz1ghJf9FFuTxIOsVTcmpwXjA+
	 RA8nusM+5CLi1SvHQ2bc9aLZFnI4KBTKMkwft5TBpKK8oku1ZhdnzCISUIzX8E1D9k
	 /+a0vbNSS9IH6M6bLtyelZO8XQSf4a7gh1tpI2v4C9QIw4KxmDovrCW5gPHOHSqIPz
	 3li/pqdHoZgjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/23] perf annotate-data: Expand type_state_reg
 imm_value to u64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-17-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-17-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:17:56 +0000
Message-Id: <20260808131757.223CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Expanding `imm_value` to `u64` fails to support 64-bit immediate=
s and introduces a critical sign-extension bug for 32-bit constants due to =
an intermediate 32-bit field.
--

--- Patch [16]: [PATCH v4 16/23] perf annotate-data: Expand type_state_reg =
imm_value to u64 ---
commit df449a8cd3aeb4d61dac5a7e48f7afaddbe8b587
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-data: Expand type_state_reg imm_value to u64

The imm_value in struct type_state_reg is promoted from u32 to u64 to
support larger immediate values. The print format specifier is adjusted
accordingly.

> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index 453e13bbe3e2c..91b83e94c51b9 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -173,7 +173,7 @@ extern struct annotated_data_stat ann_data_stat;
>   */
>  struct type_state_reg {
>  	Dwarf_Die type;
> -	u32 imm_value;
> +	u64 imm_value;

[Severity: Medium]
Does this change introduce a sign-extension issue for 32-bit constants?

The offset field in struct annotated_op_loc (like src->offset) is currently
a 32-bit signed int. When we assign imm_value =3D src->offset in
update_insn_state_x86(), a 32-bit immediate like 0xdeadbeef will now be
sign-extended into this new u64 field instead of zero-extended.

Additionally, because the intermediate offset is still an int, does this
fail to support 64-bit immediates? They would be truncated during parsing
when extract_op_location_x86() assigns op_loc->offset =3D strtol(...).

>  	/*
>  	 * The offset within the struct that the register points to.
>  	 * A value of 0 means the register points to the beginning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D16
