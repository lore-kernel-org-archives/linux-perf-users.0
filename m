Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56C5476C1
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874600; cv=none; b=NX3rSnsZcQAyVC8CAep99yThcYXRQAleJlJythWwAqOxnEqHgWqnOg2VXWYVbppHTqRZijz0fkPS4Al0sKPJti8oOTBU4Ew6+lmhTOYmr6PUR+dCuyj/CgRtl31a9CRDYm9wDOYg9Cr0PChKSINZe7w/F54eNq8R0JtLwg8F3bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874600; c=relaxed/simple;
	bh=5uSyfX+ju8po771DAcqzDrlbdRg2v0eIn2Wf+QX+15M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iLroeQz6uWtgvdKv79aihHKO5lG2lL4IHMrYvpkvFHNqzynzabIWPsWp433wv5+mSqIE4ChEJYgXCsUAZcpA7s3mrCWguH+Gai1pbWiaMlKi83t6kBkLcvo10SGsySIReHvu91KB4RSdfZI8TgJNVquKM874MC/yQk3jr0bHypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMXeyKrg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMXeyKrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666091F00A3A;
	Tue,  8 Sep 2026 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788874593;
	bh=prq1c4kup3qwTGN9vAgXugekpQQmk70X4jZw39y5kHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WMXeyKrg8KpeLzwjleuvPG4w4VuV2nLAL3mmYrvnBDUBMls+fFWnT2Jjfglys3iHO
	 cnxvgrk3pmc5xW9NykOJa06gzkDgq7JF5VRuooO8kRKCZVlTFnpLy11QE3Vp0JPRDI
	 u7DUmYOA/5xi0qmxSe5z1VSxNhqRmV+SDUVMq96R5eFzvvovoZFryeRtZJkBkckVNg
	 sznhcyNvzSEKiknvVi44QfcTWrbpA7iXYtjYqm4fvcGpdVReorOR9EXOH9ST7MSt8E
	 7zyyqW/NdSN5L+23Z0QkNySl4T2ryoAgA9jts7s8VaHzV10kWEg05fTmy/Uo4dgWkB
	 E/0Bh3E4Mn8MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/26] perf annotate-arm64: Support stack variable
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ddc32af9368f031ed716cf86b50a8bce79e87796.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <ddc32af9368f031ed716cf86b50a8bce79e87796.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:36:27 +0000
Message-Id: <20260908133633.666091F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Invalid register comparison causes unparsed operands to be false=
ly treated as stack variables.
--

commit 7ef0e34126bb69c05756eba7378c5775c6ea2fd3
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support stack variable tracking

This commit extends update_insn_state_arm64 to track data types stored on t=
he
stack. It handles stack loads and stores, introducing
propagate_store_reg_state to follow data types between registers and memory.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 9d43e2c2041cd..d520975c59363 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -542,12 +544,57 @@ static int propagate_load_reg_state(struct type_sta=
te *state,

[ ... ]

> +	if (dloc->fb_cfa) {
> +		u64 ip =3D dloc->ms->sym->start + dl->al.offset;
> +		u64 pc =3D map__rip_2objdump(dloc->ms->map, ip);
> +
> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
> +			fbreg =3D -1;
> +	}
> +
>  retry:
>  	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offse=
t))
>  		return -1;
> =20
>  	reg_offset +=3D mem_offset;
> =20
> +	/* Check stack variables with offset */
> +	if (sreg =3D=3D fbreg || sreg =3D=3D state->stack_reg) {

[Severity: Medium]
When an unparsed or unsupported base register leaves sreg as -1, and fbreg =
is
also -1, does this condition evaluate to true? Could this cause unparsed
source operands to be incorrectly treated as stack loads?

[ ... ]

> +static void propagate_store_reg_state(struct type_state *state,
> +				      struct data_loc_info *dloc,
> +				      struct disasm_line *dl, int sreg,
> +				      struct annotated_op_loc *dst,
> +				      int mem_offset)
> +{

[ ... ]

> +	if (dloc->fb_cfa) {
> +		u64 ip =3D dloc->ms->sym->start + dl->al.offset;
> +		u64 pc =3D map__rip_2objdump(dloc->ms->map, ip);
> +
> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
> +			fbreg =3D -1;
> +	}
> +
> +	/* Check stack variables with offset */
> +	if (dreg =3D=3D fbreg || dreg =3D=3D state->stack_reg) {

[Severity: Medium]
Similarly to the load case, if the base register extraction leaves dreg as =
-1
and fbreg is also -1, does this check evaluate to true? Will this erroneous=
ly
treat unparsed target operands as stack stores, potentially corrupting the
stack type state tracking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D21
