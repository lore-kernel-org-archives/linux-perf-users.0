Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95254706F;
	Thu, 17 Sep 2026 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687191; cv=none; b=M2PONfw7SJrxxiB2nzA5qF7ToA31L2slsGRR4FSCvbEjkbaJiJMzfjPBxyNIbsq4WF2V7VXE1or+U4pG5wxAB/Aad5qGvM8J/fE1O6EFwHpvMeBtMwZO63wNkW2qSd4LAXmBFaBl8CX+45nERAJcyY6AF3lhsbkvhinLsRXjGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687191; c=relaxed/simple;
	bh=MJEei91VacYcF7nBfvwgGFI/QDcKlgdRZJLyempPRps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uUozMwKyiSMJTyJ/XZFVhMzfwoHLoCIe0oXuGMp5zpqcVEKCOeC9x0nxQ8z/57hM+qh2cj8dMKQe7QVnWgWInoqm3ypiap6PKiXIBzC3/eXFXhAhFzBNpANnNDVs5PWHO/RBrXYcCKQihZ2cG74ggDyLXywUjBV/2T0EoyMrLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXyt9c7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXyt9c7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B541F000FF;
	Thu, 17 Sep 2026 23:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687186;
	bh=MJEei91VacYcF7nBfvwgGFI/QDcKlgdRZJLyempPRps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EXyt9c7pkD/icXXxNVZA8X8lWCvumS3TBg+kOnXHwK/2uA1OM2lv7lkxeSDccu/Br
	 IS00r6rSJt85pMMT26ioe3X3o3Ox+fZz6nbwJmgGbQ4pO3jHIPph6uOSuZVnRVxnny
	 OPhc7p90z2/p+HdzgbX1SfgiTea/S5xCEfXuLBEAebVhx890QcAFB6l+flecDwF/Qr
	 KLLrh4pPTnrNhKXXav9zCeswTGY0ywfXAtqpvzd1m9yZIUAu3+l3Plhz4wG1IWHMjY
	 QYUeTxKPGu6gAEVWxTttuzhOsz2qRi8P1oFWtuWl0e21W5HR+ukCx8Rw3nqqnKSB+5
	 oEp01wU4jwJkQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/11] ptwrite uprobes: Add infrastructure for
 ptwrite uprobes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260917230127.924985-2-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-2-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:19:45 +0000
Message-Id: <20260917231946.35B541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> uprobes currently always require entering the kernel to log anything.
> While that works well, it is rather slow.
>=20
> Modern Intel CPUs have the ptwrite instruction, which can log data to
> the Processor Trace buffer. Add support in uprobes for patching PTWRITE
> instead of kernel entries. When a user collects Processor Trace with perf
> the logged data will appear in the PT log, otherwise the instructions will
> be nops.
>=20
> PTWRITE provides much faster logging, but it is missing various
> features that the full featured probes have.
>=20
> The instrumentation is similar to optimized uprobes. Add a trampoline
> page. Replace the original instruction (5 byte nop) with a jump
> to the trampoline. The nop restriction will be relaxed in a later patch.
> The trampoline does ptwrites and then jumps back.
>=20
> Build the high-level infrastructure without any x86-64-specific
> parts (except for one data structure). Add register/unregister, basic data
> structures and high level hooks. Add weak stubs to handle the no uprobes
> or different architectures case.
>=20
> Assisted-by: omp:gpt-5.6-luna
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D1

