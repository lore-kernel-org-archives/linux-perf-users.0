Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC63D6CC5;
	Mon, 14 Sep 2026 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392214; cv=none; b=BCHW9TmFG6wIoZhuxuif4I2GH9E9tC6NPxQ9JnWl9uCSfzfMCEMB193BKau4rAvNFBFireo7qxkdFnzniwGUrUS9AfwXXsmPpzwgydOKiK2x+FoxvNLrjpNfae/JUJDztF2wX/NuvdRxZgOnLd0tCXXVn28p/syNymCQmEQCGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392214; c=relaxed/simple;
	bh=+7oOfobNcbV2/GAjl/yabSbc1UzdDQe8jxoL910NKHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MUs6ko83U/fwQOnptqNUkrQ1xuhuUpt5p7IC1ftMBXmYzw7xQFKbN2Lyw/HzbtGItN84bYe+l96uhriISLBKfHeixovDHRfWprw1IVC9P6/ohOtYNerm6C7voPsouejTrEGyY5ns253pJRF4R5LV9ERotedNHl2e2zhXDhKYRQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3mnSDRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3mnSDRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2A31F000FF;
	Mon, 14 Sep 2026 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789392213;
	bh=+7oOfobNcbV2/GAjl/yabSbc1UzdDQe8jxoL910NKHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m3mnSDRb0sMgnfuSCjAOhr5F3JFGU4pk+8puetIbOPokUKd4T4TylzxU42gHpRF2P
	 zRmMbPO4BSsI6ssrpb6Vb+p62mtQXLgw4ma1Ush1XQUwa/lcELqUiwN6s103ijMffZ
	 utTO3lgriEwVit2Rnz4BnroT5GhUtknxCCgOVqv96pZOEDXaGofbYoA2gzHJhu3ZFt
	 eTKU0Dohu4lqPvClkiELcbzY2XpK/olX3MzXpbboWzjaYXYbP4EgBNVF9n2uO2gNWL
	 r8rnnGUW8M0Yf2rawSJVjeqzqzMIYkx11po+7QTxYsw8trf3wywV3CUp0Y5WKUS/FG
	 Y3IaVAMxgbKUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 02/13] KVM: x86: Prevent host DR7 debug register
 leak into guest OS on NMI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <178939019982.94750.4441254006258061798.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939019982.94750.4441254006258061798.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:23:32 +0000
Message-Id: <20260914132333.1D2A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> When KVM enters a guest OS, host hardware breakpoints are disabled
> before running the guest. However, an NMI can occur during guest
> execution, where local_db_save() or arch_install_hw_breakpoint()
> can be invoked.
>=20
> In particular, if local_db_save() or arch_install_hw_breakpoint()
> is executed from NMI, hardware DR7 can be modified or restored with
> host breakpoint settings, leaking host breakpoints into the guest OS
> or clobbering the guest's debug registers.
>=20
> Introduce a per-CPU flag, cpu_dr_in_guest, to indicate that the CPU
> is executing in guest mode. Set this flag in vcpu_enter_guest()
> during entering the guest with disabling host breakpoints.
> If this flag is set, local_db_save() and local_db_restore() return
> immediately, and arch_install_hw_breakpoint() returns an error.
> In addition, protect cpu_dr_in_guest in within_cpu_entry() to
> prevent recursive #DB exceptions.
>=20
> Fixes: f85d40160691 ("KVM: X86: Disable hardware breakpoints unconditiona=
lly before kvm_x86->run()")
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D2

