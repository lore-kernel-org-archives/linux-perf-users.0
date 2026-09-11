Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD81475352
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130002; cv=none; b=TpurtXBWZ8LXk7mtH8HQ7JQknsN2OOVqcV/905E+kahAC52RiIe4ljpHnqDGH7ixUvYzPmrBB4WKNMpfhYETp/Xhy1Ur82yCp5O8vMdxEwLJYNPVYpIRAsh5jBn8k/E+ngg4NYiUgdsWu9OFGs2nQmdT29EOiyQkvHd/VppU+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130002; c=relaxed/simple;
	bh=bPP3mWycDfqTADK0aubKDlQPiMj/LHu9b0foOLhTMGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pO53Ij/tQXpRCu9hjsGu/wS3D2S1InsG5rMqRrLePoVoE+BLNINmk3hrP2SeYO3virg4yvjcneJxgGaMrLLBBEWRbjdzfitAaHuWGK5B3Lt/0elXjqJs7Q82PVAiZlAsQMmHg+oja1uS0vo4SWMTpapmsBVyRmxgSrv8nwFdtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc+2dM7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc+2dM7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9111F00893;
	Fri, 11 Sep 2026 12:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129997;
	bh=hnBTuFXzYIhdSxvbCL/EU14LBCmvJOO1L1V5qZBnbJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gc+2dM7VlsFoE+B4JSPhUg+20X7aL40zzqlrE0LPUQXZUUcQ4s+ckXIOMSHBSrTM7
	 612KojpZIQsCXOAcLvlDsHfMH9KZmaZbWxoU/MA1T3izefWwlOBqyx8wRfLHOlNY2h
	 naCQ0nFPThdQdUryO+tbJSqA+PxMrp1lHQSmHNVtlfILHVShzmFXhFw6MvuiE21ItD
	 LCSbf4IWaNObxe8u8wKuiW+qPPauzPRY65jpASF4pITxFBX9nuzNqeEp9V5CHqTyDN
	 94IchgX8YkUTfQT582fNhcGRL305Thv5t9dyYBwIXa5na0bQ6KH5Nb1H9DrduGl6zp
	 57KhvrZ6yXFng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 9/9] selftests/riscv: add perf user-stack SSE copy
 regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911121456.33223-10-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
 <20260911121456.33223-10-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:33:16 +0000
Message-Id: <20260911123317.5A9111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On RISC-V, PMU overflow interrupts can be delivered through the SBI
> Supervisor Software Events (SSE) mechanism. A perf event that samples
> the raw user stack (PERF_SAMPLE_STACK_USER, as perf record
> --call-graph dwarf does) then copies a chunk of the interrupted task's
> user stack from an NMI-like context. If that copy is allowed to take a
> nested page fault it can corrupt the interrupted task's kernel state and
> hang or crash the machine under load; this is what
> riscv_perf_out_copy_user() and the nofault page-fault change fix.
>=20
> The existing SSE selftest module exercises the framework (register,
> enable, inject, complete, priorities, stress) but never drives the perf
> user-stack copy that motivated the no-fault path. Add a userspace test
> that closes that gap:
>=20
>   - Open a sampling hardware PMU event with PERF_SAMPLE_STACK_USER over a
>     deep, partially non-resident user stack, drain the ring buffer, and
>     verify every SAMPLE record is well formed and never reports more
>     dumped bytes than were requested. This checks that a non-resident
>     page truncates the dump cleanly instead of faulting or overrunning.
>   - Drive a multi-CPU unix-socket + deep-recursion workload under
>     high-frequency DWARF sampling; the pass criterion is simply that the
>     machine survives, since the original bug took it down.
>=20
> The test reports SKIP when hardware PMU sampling is unavailable or
> perf_event_paranoid forbids it, so it is safe to run unprivileged or in
> constrained environments. It is placed under the RISC-V SSE selftests
> because SSE delivery is the RISC-V-specific condition it protects, and
> is wired into the sse subtarget Makefile alongside the module runner.
>=20
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911121456.3322=
3-1-zhangzhanpeng.jasper@bytedance.com?part=3D9

