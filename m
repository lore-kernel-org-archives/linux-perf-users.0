Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7755408C
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873750; cv=none; b=IfwULc18XS0Wz8CXjoSZNl62myaTHMEeGwdbM4r8NlQ2CyskIQ2COSCV7Bdv20VB5jLwB8wQ0UJHpSb75oa3UgbBGsNDm3G4zvJAX/CLqN6+mHaXYEgINvyC4bdnnMMkh/8wtdSI6SYCJ/2ECc+yeXheBaPqGG4W+4o1Lqa6AlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873750; c=relaxed/simple;
	bh=lEyPUrh8eXfeC6bk2qyIAfU63zkP6w2+NEMGabgkrPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RnuYmJ/JNw750cP4qmXTCCOAAkQRnsQTWILx69ISrRuq1G7G/wIo/OMAwuaebYZWuSg50c7rTPc4MSH4kpwt7Td/lN96W7A4fOBXtIcNjrLDLpfIh8srxwvjFOqpCBLatPvMlUT04ymGzzVJ319daH+9ITYI68stKiAKwGIxOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAwBoOUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAwBoOUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D9F1F00A3F;
	Tue,  8 Sep 2026 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873742;
	bh=B3sk6mNFL/wQUE5dvf8NeQL3voo86Tu67wBb/fpzNXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lAwBoOUUhad2F8upi6E7OAG97Bwh69daQVo8cyM0ybCbTXNbZsSnXHQSyDl15fOIr
	 QpnmVhaKQRzHZ/qI4Ce+kxmkNUZdE+jXUPlWQUjgJIBPNXQN2Rv3J+gKeHdSpx6Bh1
	 4TWskim7gkAwR7z70rEMGQpe0qv4QvmJyX5sLIIRldPGL7TWwx9U2BIXqYNHkLHXO+
	 cohzMQN8BGHOdwnoi/ejsrwo8yBUAA1BDZ+1SkIXm5Oo23WvP47W2nAYSXRdguQfRY
	 oC3JosBUTkjLiEmXoMoIkwI7dweeEoeg5+2huLVn8wzOOJXtBe6vgUArbrDZNF5nXP
	 Esp7JQhIeCHeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/26] perf annotate-data: Add arch_get_reg_offset
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <e2d2dc36b2d8f600b339cf66880b10e611dbf9ab.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <e2d2dc36b2d8f600b339cf66880b10e611dbf9ab.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:22:22 +0000
Message-Id: <20260908132222.90D9F1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly computed effective `offset` from `arch_get_reg_offset`=
 is not propagated to `dloc->type_offset` before querying stack variables, =
breaking stack type tracking for indexed addressing modes on ARM64.
- [Low] The debug logging variable `offset_sign` is not reset across loop i=
terations, causing positive offsets to be printed as negative.
--

commit 090fc5d342fd0b37d2080a84b8472453f678a2e5
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-data: Add arch_get_reg_offset helper

Adds a helper to compute the effective offset from a base register
for instruction operands. Currently handles arm64 addressing modes
and falls back to the instruction's raw offset for other architectures.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index c51b20a7af9b6..754c0efe2077e 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
[ ... ]
> @@ -1132,18 +1200,26 @@ static enum type_match_result check_matching_type=
(struct type_state *state,
>  	Dwarf_Word size;
>  	u32 insn_offset =3D dl->al.offset;
>  	int reg =3D dloc->op->reg1;
> -	int offset =3D dloc->op->offset;
> +	int offset;
>  	const char *offset_sign =3D "";
>  	bool retry =3D true;
> =20
> -	if (offset < 0) {
> -		offset =3D -offset;
> -		offset_sign =3D "-";
> +again:
> +	if (arch_get_reg_offset(dloc->arch, dloc->op, reg, state, false, &offse=
t)) {
> +		/*
> +		 * Fall back to the instruction's offset. This prevents the
> +		 * register type of the instruction from being completely lost.
> +		 * Compared to dropping this type inference entirely, providing
> +		 * a rough type hint is likely more useful.
> +		 */
> +		offset =3D dloc->op->offset;
>  	}
> =20
> -again:
> +	if (offset < 0)
> +		offset_sign =3D "-";

[Severity: Low]
Does this code leave offset_sign set to "-" across loop iterations?

If check_matching_type() triggers a retry (goto again) after processing a
negative offset, and the new offset for the retry is positive, offset_sign
will still point to "-" instead of being cleared.

[Severity: Medium]
Since this code now dynamically computes offset using arch_get_reg_offset(),
is it necessary to update dloc->type_offset with this newly computed value?

Later in this function, during stack variable lookups, the code relies on
dloc->type_offset:

tools/perf/util/annotate-data.c:check_matching_type() {
    ...
    check_non_register:
        if (reg =3D=3D dloc->fbreg || reg =3D=3D state->stack_reg) {
            ...
            stack =3D find_stack_state(state, dloc->type_offset);
    ...
}

And similarly for CFA stack lookups:

tools/perf/util/annotate-data.c:check_matching_type() {
    ...
        stack =3D find_stack_state(state, dloc->type_offset - fboff);
    ...
}

If dloc->type_offset isn't updated to reflect the true effective offset
calculated by arch_get_reg_offset(), will find_stack_state() end up
using a stale or incorrect offset (e.g. 0 instead of the index offset) for
stack-based array accesses on ARM64?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D14
