Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14C38F25A
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080778; cv=none; b=d/7V9DkSYQBUsmrRhcKv83NllYUTyA316GV6N+pRyz04rFEeywANLfPAtVpYCnsxbchupiwTssJ32JCGZEu0kJJDGf7ZlkKELi9rbNBRnBvC9GDF0KMfGBwLab5Ou0VQ6RZnm9tDycxLS6UIlg/hzdynGBI6A8I8eW42v+Pe1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080778; c=relaxed/simple;
	bh=LO9thQjyfIMcEn3z7bB+wCpYK6IFstHK7/wOh9MNGzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nbb+/is12hlglrG1SmN2AIh5MXm3fTDToXR115Nn8yjUVBo289A4eNvKaCGbPSJ7b8bDVS6GiWjSbV6YaWmINJvH9gXJ4A2oGdsQAY54Qkkc/HYdw9a1N85YJh/zTcgvM9QQpa5Su5Kn8At8AbfZhjyO8DliilLmIBkXJsQMTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX/e2fwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX/e2fwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784251F000E9;
	Wed, 15 Jul 2026 01:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784080776;
	bh=LO9thQjyfIMcEn3z7bB+wCpYK6IFstHK7/wOh9MNGzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FX/e2fwEqMZVsK76PkP7fhvCTdSxmDoSgXaMu/sd5BNUJUfibLPa+ZK5CJEa024Zn
	 Suqvl+fIz6RyOjJLQn05fn1Atc7IDA6CRTFyB1BUU4KIEv2N4JESxP9D9q2BUvhpKj
	 o3GSBp2tCs6MGT8E6cBi0iWzNJ7DLFfQ6jaTGCafU24uBaUzA20rbhliR7IL45NGYc
	 /JvONZEkMn0pt5H2rdR+e+B2j0FFWQz+3AiPnBGIaLooDyj0Fi9y9YPsoe6S0EM0Ox
	 CAHMloYyWYjgxlq3nTo2RH3QOUfXWbIK1BVzWt61B4j+dOObdYRsPzRRHtudHXhtte
	 pMJiLXX3j9aIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] x86/hw_breakpoint: Unify breakpoint
 install/uninstall
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178407990855.95826.6451473316040346375.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
 <178407990855.95826.6451473316040346375.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:59:36 +0000
Message-Id: <20260715015936.784251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing compiler memory barrier during hardware breakpoint disable=
 allows reordering that breaks NMI safety.
--

--- Patch [6]: [PATCH v7 06/10] x86/hw_breakpoint: Unify breakpoint install=
/uninstall ---
Note: The format of this review has been altered to a free-form summary due=
 to restrictions on quoting the original patch text.

commit 16356ea39e4e8d100873d56e9298c633a58cb692
Author: Jinchao Wang <wangjinchao600@gmail.com>
x86/hw_breakpoint: Unify breakpoint install/uninstall

This patch consolidates breakpoint management to reduce code duplication and
binary size. It introduces manage_bp_slot() and setup_hwbp() to handle the
logic previously duplicated in install and uninstall functions.

File: arch/x86/kernel/hw_breakpoint.c
Function: setup_hwbp()

[Severity: High]
Could the repositioning of the barrier() in the disable path introduce a
race condition with NMI handlers?

In setup_hwbp(), when enable is false, the code writes to the per-CPU cpu_d=
r7
cache after updating the hardware DR7 register via set_debugreg(). However,
the barrier() call was placed before set_debugreg().

Since neither the native set_debugreg() nor this_cpu_write() provides a
compiler memory clobber by default, is the compiler permitted to reorder
this_cpu_write(cpu_dr7, dr7) to occur before the hardware set_debugreg()
update?

If an NMI interrupts exactly between the reordered memory write to cpu_dr7
and the hardware DR7 register update, the NMI entry code (local_db_save)
would observe cpu_dr7 as zero and skip clearing the hardware DR7 register.
If the NMI handler then touches the watched address, would this trigger an
infinite #DB exception recursion and crash the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178407983818.95826.=
12714571928538799781.stgit@devnote2?part=3D6
