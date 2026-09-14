Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3FA3A9622;
	Mon, 14 Sep 2026 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378342; cv=none; b=mDwPvHIKq9qkD5Hrcj8aJ9YT1YPyyhoChhFr5Gn5E1JyQWxGqwvHeil4v8rgobGZk17mPlPQnraqIwRt6PJG+866FpeLYZHTe2tsw8FBEe5HIN+glFWPla2rdujQ48igEQ3/VqTR/S5b1apA8XsRXzGep3z6HimmMc6sK425j1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378342; c=relaxed/simple;
	bh=PHRsYV+s4N355b7HUhiKJo0Uqt3vXIL4p9t1EazFwOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k4lKLDx+JyK2D+6q9orL0zThFF1mnCKPIqg4DY2WetZ9NJCF8zOnm+B+zsxAA4C+tCbsW5DnuBlzZZWH6GS3y31cgacXCX6YREIT70z/dp6zgqbvwXeExEcPVOf7biVLN34TLKU/kokk2aAmDmM2kQjRNTosNaSt7wiqgIVAEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDpdTPSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDpdTPSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8701F00893;
	Mon, 14 Sep 2026 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378341;
	bh=PHRsYV+s4N355b7HUhiKJo0Uqt3vXIL4p9t1EazFwOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PDpdTPSl+Q41OM0qIqxWXVU2ky1Zh7VdzYaaBS7KHMkoNaa0Y1Go95i7SPkaVw/89
	 TXWCntVwdwue8DiJPO24InHC7E5fe8KibkKnywBzY280F/afekyoFcJqF3XWtRWBO9
	 dYSpha+3jedZkQys8HQkDoFsJX00HKKZ0Ke8p+v1H4t0x5oUqSKvKGQAurWHoyRgwT
	 8n8+ExNS+F0citMzJ1BeigpgyWCNRmA2e48aZzSg15qm/RWq0Am/LhLYUQYHZi0qOL
	 emjBVEjvNxQCX7wzvrWivQPtxWcOqpAkCJQwfT6650FF4x6tLc/sm0aveeIlIm8ayA
	 4QlMoIqJpTDOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/7] riscv: ftrace: always preserve s0 in dynamic
 ftrace register frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260914092648.51254-4-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20260914092648.51254-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:32:20 +0000
Message-Id: <20260914093220.BE8701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> struct __arch_ftrace_regs declares s0 unconditionally, and both
> ftrace_regs_get_frame_pointer() and ftrace_partial_regs() read it
> unconditionally. But the SAVE_ABI_REGS / RESTORE_ABI_REGS macros in
> mcount-dyn.S only stored s0 under HAVE_FUNCTION_GRAPH_FP_TEST
> (CONFIG_FUNCTION_GRAPH_TRACER && CONFIG_FRAME_POINTER). With
> CONFIG_FRAME_POINTER=3Dn the slot held whatever was on the stack before,
> so any callback going through ftrace_partial_regs() saw a garbage
> regs->s0. RISC-V kernels default to FRAME_POINTER=3Dy, which is why this
> has not bitten in practice.
>=20
> Save and restore s0 unconditionally in the dynamic ftrace ABI register
> frame. This fixes the latent garbage-s0 case, brings the dynamic ftrace
> path in line with the static _mcount path (mcount.S SAVE_ABI_STATE
> already saves s0 unconditionally), and matches the frame layout already
> documented in the comment above SAVE_ABI_REGS. It is also a prerequisite
> for the upcoming reliable unwinder, which reads
> ftrace_regs_get_frame_pointer(fregs) directly.
>=20
> The cost is one extra REG_S/REG_L pair per traced call, negligible
> compared to the overall ftrace cost; the existing FREGS_SIZE_ON_STACK
> already reserved the slot, so no extra stack space is used.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092648.5125=
4-1-xueshuai@linux.alibaba.com?part=3D3

