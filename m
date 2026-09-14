Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF641A4FB;
	Mon, 14 Sep 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378700; cv=none; b=s2gvuYeg6X5K194SXVTWkVEojuZF1jCF8slENqNoUaCFYdM9JEpqR3RUiknl4Vv2W3sAtvKVos9+HRw+okE5EFjJMn0SsgC0b3jYCvKVL7XQjwjLpAw87pvoXgf4sx+xgpdQMw0WXFvveWe2rVc2wdMz23/AzDUIMDEtSQE4XoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378700; c=relaxed/simple;
	bh=uQOJMH40CVLUV1hXjgP11aPr7evPi31yvF2ifDXCmjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=opCQE1BXKf63iAy+2TZxAW9lS2RjbqYf8DDiVL9yDi+0oCaR0PDUP2F0Ng5jUzDzEfp/0/x2GuRfj7bt+p9aVOKCjAwrXes/pDSVyn+Gw0iBmVv8YkN8z/0AtAdD661GAcU/bZllW+o4wpE0YJFyiH/xFayKCPsxsQPdufj0hY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYRXHyhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYRXHyhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567501F000FF;
	Mon, 14 Sep 2026 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378698;
	bh=FSMjnLb38MHEr8wnKpoMmwICKgNTqcxvrY/mmT0dtB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XYRXHyhXRlS4DNlkWv0ljVDJA4yjil8cplWsTFB96i7yZVqRfzXl1iJ0xHdRDlm/T
	 Ixtd/uGeWRY5BbYGxgiaHO9QthvTz72BLp/dqSbF2aHMHAh4QBsJWZ5nFOHZJyKEku
	 bqVYdCH5AapGWTnMuzEHXW/k/7UxjwvHCAKbIfUm8ex2jfQ5sHWRkD7Tl0D9BJZB80
	 q0/LQ0fM//Zt0+mQ2Fh2KyHU3vaNmOMirHTRB/5LqEXmSkv/34r6La3cPb6Aj3Cgc6
	 cOGWx3PKmyALn3zGnvhVofC3I6S6ai1Hc7nuEOpz8DOMY5Oecw87lnXFkzi3TTbQ2V
	 EPafk/9oQIjVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/7] riscv: Kconfig: enable HAVE_RELIABLE_STACKTRACE
 and HAVE_LIVEPATCH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260914092648.51254-7-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20260914092648.51254-7-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:38:17 +0000
Message-Id: <20260914093818.567501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> Now that the metadata frame records, the kunwind state machine and
> arch_stack_walk_reliable() are all in place, advertise the capability
> to the rest of the kernel:
>=20
>   * select HAVE_RELIABLE_STACKTRACE under FRAME_POINTER && 64BIT, so
>     only the configurations with the tested metadata records and
>     FP-based reliable walker enable it.
>   * select HAVE_LIVEPATCH under the same condition and source
>     kernel/livepatch/Kconfig so the livepatch menu is reachable from
>     the RISC-V configuration.
>=20
> The 64BIT dependency is conservative scoping rather than a hard
> technical requirement: the metadata frame record, kunwind state machine
> and arch_stack_walk_reliable() also build on RV32, and the IRQ-stack
> frame-record adjustment fixes a latent RV32 issue. However, the syscall
> livepatch selftest and module relocation path have only been exercised
> on RV64 QEMU virt so far. The 64BIT gate can be relaxed in a follow-up
> once RV32 has equivalent coverage.
>=20
> This is split out from the unwinder change so the policy decision and
> the implementation can be reviewed and reverted independently.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092648.5125=
4-1-xueshuai@linux.alibaba.com?part=3D6

