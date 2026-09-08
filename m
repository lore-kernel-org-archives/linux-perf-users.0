Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC629556BB8
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873837; cv=none; b=g/TAv2WTXvJfQnRpaRKnub239FF+62ZCjSXRqsmFhqqn95WWkAjTvm3Q7tAXWknTILM0+KJNDBxvEAOYmSu3czE9WkZT/LYp29UdUKklK5rfMBgIXdaWBPojDRsujGbHkEmAj63IQPQgxOeqsfLiGQyS+rtvzuwh3UlsSKbgqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873837; c=relaxed/simple;
	bh=89E74rvbF4WPjKM5K512hwWAps9KoSbCzVkjgOYsrTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCtgLi9w1hCsXde2etM2QaWVIu2m7DWaJTnwgWugtF9UG0PuzFR3eXr86hCYRwZPsj/SNzk8/8dBXVm1cFpmOxbTnrxvm7GqDBOxagxQS2g/3O2fJb2UDePliqJDx5AOUO0eLWx/N5i3kxNROLbxsyb7niv6YjO7lqP7yMsNTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgzmkscL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgzmkscL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079CC1F00A3A;
	Tue,  8 Sep 2026 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873828;
	bh=ApjFk4NjlksDHx3kibJEOpyYMwQjjtpAeMGfoIoIJY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hgzmkscLVjtEU9mhd1RgHyjf8T879HqZrcKx2AdBiYqfTORTqRU8DW1d2dqRnq2++
	 Z5gjjJ35VhXfn2pT/sBV/N6LToczcomn5X8VbmDU8PRdKCoFMQQ1gXyrdoOc/Lr0HY
	 Sbmn21oqbSk3PyOD9vowrJQEv1fWh4WfO9GVHiWI5aJFMcgT83EkbxKRpeWfMls/W6
	 0e8Sbl712e5PIU9kag2MMqSHvWvQ3EKFREq23dH67PQy7yVLTGODmVzV/8HIVd94Ht
	 m/QK8dQ2W6j5YiK3MXmbBoAwN4zul0w6OTMhqIzn2Awxoo4tUnEcvRMqCDwUiWLH7z
	 9Ni/yz4ghqCHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/26] perf annotate-arm64: Support load instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a30c739f6462865d2ce4f8a780a12ec28bac707d.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <a30c739f6462865d2ce4f8a780a12ec28bac707d.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:23:47 +0000
Message-Id: <20260908132348.079CC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unintended rollback of valid type state for the first destinatio=
n register in a multi-register load (e.g., ldp) if the second register's ty=
pe cannot be resolved.
- [Medium] Missing support for `TSR_KIND_POINTER` in `propagate_load_reg_st=
ate` causes type tracking to silently fail for variables whose addresses ar=
e held in registers.
--

commit 6913b761b417f151400c62773b3dd0ee4dcddbf2
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support load instruction tracking

Extend update_insn_state_arm64() to handle load instructions, tracking
register state changes when data is loaded from memory to registers. Introd=
uces
propagate_load_reg_state() and update_load_insn_state() to handle standard
loads and load pairs.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 9a32265265223..c239ad9473dcc 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -455,11 +455,206 @@ static bool is_readonly_branch_or_cmp(const char *=
name)

[ ... ]

> +static int propagate_load_reg_state(struct type_state *state,
> +				    struct data_loc_info *dloc,
> +				    struct disasm_line *dl, int dreg,
> +				    struct annotated_op_loc *src,
> +				    struct type_state_reg **src_states,
> +				    int mem_offset)
> +{

[ ... ]

> +	if (!src_tsr || !src_tsr->ok)
> +		return -1;
> +
> +	/* Dereference the pointer if it has one */
> +	if (src_tsr->kind =3D=3D TSR_KIND_TYPE &&
> +	    die_deref_ptr_type(&src_tsr->type,
> +			       src_tsr->offset + reg_offset, &type_die)) {

[Severity: Medium]
Will this silently fail to propagate types for pointers since it restricts
dereferencing strictly to TSR_KIND_TYPE?

If the source register state is TSR_KIND_POINTER (e.g., from an earlier add=
ress
calculation), it appears the pointer dereference will fail type propagation
here, reducing data type profiling coverage.

> +		tsr->type =3D type_die;
> +		tsr->kind =3D TSR_KIND_TYPE;
> +		tsr->offset =3D 0;
> +		tsr->ok =3D true;

[ ... ]

> +static void update_load_insn_state(struct type_state *state,
> +				   struct data_loc_info *dloc,
> +				   struct disasm_line *dl,
> +				   struct annotated_op_loc *src,
> +				   struct annotated_op_loc *dst)
> +{

[ ... ]

> +	/* Handle the first destination register */
> +	if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
> +				     src, src_states, /*mem_offset=3D*/0))
> +		goto out_err_adjust;
> +
> +	/* Handle the second destination register (if any) */
> +	if (dst->multi_regs) {
> +		int mem_offset;
> +
> +		/*
> +		 * ldpsw loads two 32-bit signed words into 64-bit registers.
> +		 * Memory spacing between elements is 4 bytes, not the register size.
> +		 */
> +		if (!strcmp(dl->ins.name, "ldpsw"))
> +			mem_offset =3D 4;
> +		else
> +			mem_offset =3D arm64__reg_size(dl->ops.target.raw);
> +
> +		if (mem_offset < 0 ||
> +		    propagate_load_reg_state(state, dloc, dl, dst->reg2,
> +					     src, src_states, mem_offset))
> +			goto out_err_adjust;
> +	}
> +
> +out_adjust:
> +	adjust_reg_index_state(state, dloc, dl, src);
> +	return;
> +
> +out_err_adjust:
> +	if (has_reg_type(state, dst->reg1))
> +		invalidate_reg_state(&state->regs[dst->reg1]);
> +	if (dst->multi_regs && has_reg_type(state, dst->reg2))
> +		invalidate_reg_state(&state->regs[dst->reg2]);
> +	goto out_adjust;
> +}

[Severity: Medium]
Does this unintentionally discard valid type state for the first destination
register if the second destination register's type cannot be resolved?

If an arm64 ldp instruction is analyzed where the first member is trackable,
but the second member cannot be resolved, this error path seems to
unconditionally invalidate the successfully resolved state of dst->reg1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D16
