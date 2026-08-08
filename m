Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E23EDAC1
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194669; cv=none; b=mlBKeM7mQi1XPqRO0Xe9VmSio/HomrTBctDpk6Vb6/Bz49coR93eXRtRzUxbgm1rU3qroOwXPlXgiQ1KqNdtKSIl5MN9W1Lh18WJyrKH5tmZdeX2qBWpFEY1adzJa9f532DgGvxv7Zc2eDre8qjAKlYDXljSYaKQskhzNd2nURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194669; c=relaxed/simple;
	bh=S1V4W8UCbFdFUvFEMW9C7hxp3Od6giamRQe2LJ8eXss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hX6UtFcGnrDKGmEuCK+S0Pnq1f1rqYlmggpN0UDfyTXH/vg346aMdYi7t3gyZs9rS9cB1MwdI8yeshPL5rEESgr76YRGe9/W6a+WZANtPxXTDrDwHwArHL0kTAD60wq9FfLkBIa7B1SD/DMZxIDk1bUqiOrBPKnLAwKgAEnF7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmua7rmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmua7rmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778F91F000E9;
	Sat,  8 Aug 2026 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194665;
	bh=MnkUsCm5xXB91h868L+wryJ+BG8n2RkTWPpj7WfQKfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hmua7rmDwAo+ieKqQ2u6PChyM8U1C3At2kq/HZUcsp1475q43mZ/BxVu9i5earYGY
	 NPxuLx3bcIFXTBaJ9x+IEDVu21Wb3LYsqb886o7MdAYq//7LFPdNuI8H40YnRvCoG8
	 PJTynsReR82T3ZbmymnF0TF2oeZ3AEHEK2Vz2JX7rnJMtr5U4K/wOw19j5ud1lr1gp
	 C8idBwlvfMbLMh2tF7wZkN9gvzlWgZ//Yd3prDpdAbX1s8L5Jav/S9bgfs8CTCnBK/
	 So2yPdpublp5ApnruoWldhtbdR64OXe5Vw0rxkGhqIpWE4/tofSofZkNTKYt1D2MRY
	 evGjlXJM8iuZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/23] perf annotate-arm64: Support store instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-16-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-16-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:11:04 +0000
Message-Id: <20260808131105.778F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] For post-index addressing modes using a register offset (e.g., `=
ldr x0, [x1], x2` or `str x1, [x0], x2`), the base register's type state is=
 incorrectly preserved instead of being invalidated.
--

--- Patch [15]: [PATCH v4 15/23] perf annotate-arm64: Support store instruc=
tion tracking ---
commit 5069bd6d8cc957f98ba504ae076e8ee35699d61a
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support store instruction tracking

This commit extends the arm64 update_insn_state() function to handle
store (STR) instructions. It ignores the transfer itself since it won't
change the type, but calls adjust_reg_index_state() to handle addressing
modes for the destination register.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -575,6 +575,17 @@ static void update_insn_state_arm64(struct type_stat=
e *state,
>  	/* Memory to register transfers */
>  	if (!strncmp(dl->ins.name, "ld", 2))
>  		update_load_insn_state(state, dl, src, dst);
> +	/* Register to memory transfers */
> +	else if (!strncmp(dl->ins.name, "st", 2)) {
> +		/*
> +		 * Ignore transfers since it'd set a value in a struct
> +		 * and won't change the type.
> +		 *
> +		 * Needs to update the pre-index and post-index addressing
> +		 * modes for the destination register.
> +		 */
> +		adjust_reg_index_state(state, dst, "str", insn_offset);

[Severity: Medium]
When using post-index addressing modes with a register offset (e.g.,=20
"str x1, [x0], x2"), does adjust_reg_index_state() correctly invalidate=20
the base register's state?

Looking at adjust_reg_index_state() in the same file, when op_loc->multi_re=
gs=20
is true (indicating a dynamic register offset), op_loc->offset is 0:

tools/perf/util/annotate-arch/annotate-arm64.c:adjust_reg_index_state() {
    ...
	tsr->offset =3D op_loc->offset + tsr->offset;
    ...
}

Since op_loc->offset is 0 in this case, this seems to retain the old static
offset instead of clearing the state via invalidate_reg_state().

Can this cause incorrect struct field attribution in the perf annotate=20
--data-type output for subsequent accesses using the modified base register?

> +	}
>  }
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D15
