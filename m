Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494AE495AF0
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589268; cv=none; b=B+vCRaVHmYI85EftFWe2nsWRkJTkf75XkE1bsUqheZDN3B9mVPOAP/xsxlzs+3PMa61UHTaQukWmJC/snmU6rB4fFpJjRTcZmjE1/LQpaWu4VKCoxfcDKG4uT/nZicgYIW0vSZA0FOfKCWH1qciWNflf7M13j6mYkMRGwPcjUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589268; c=relaxed/simple;
	bh=E+FyaS8G6MYxK5IkaU3A2c2SGWiz6+EspdGEvaMZYSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rY4bGGLDI47H3WPf0XkNlayQ4uHxBHLYBV8ru4hIlmPSlFe3lXEKRWWLq+5pO5+HDZHA4soZt0JXc+3r8/NrUsJAbfe6RQ717po9DSygeqtndczV9cSm5yIjvOEmoTh8nfyVuIZ/NWhN4Ojn7nQqLHftalzMmrLXmNJ/yTcn8Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2JMRfQt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2JMRfQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C035A1F000FF;
	Mon, 28 Sep 2026 09:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790589266;
	bh=qjhHoasv+erHeat6DqiuH3eqmvgyssDSdN49uhrkzYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I2JMRfQtLXW8YHolji5O+SvrnfmEuG/RBV1ZZE2w3bLvcwv7o6k7Fbfrrt4iM6RXS
	 7kMBSUuZD3WD4oYotnhbrdgKBSw30MEDd6mUuWNkaAG/I3k9hA2XWO3VHsPBFDNrpv
	 m84WWe/Ad8CJaHwbta57+iM6FE6EQojIes1RTw62Ap7tzVTwPDAmdrPcEZBPNNVGkC
	 WLaUAgxvKeYkaBwKZbJeaHK5wGczmuW8KHQeCGyIJjQcK3nJGlQzucsgxKe2ooEo7X
	 be/rwwJoujosol00VzbEoXAXK4SQrCBHX9BgOMjwMzk6RHQRpRtWWB/+5bCdf3qOcY
	 BiB8PbYc0vDsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf riscv: Implement rdtsc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928094739.2605-2-cp0613@linux.alibaba.com>
References: <20260928094739.2605-1-cp0613@linux.alibaba.com>
 <20260928094739.2605-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:54:26 +0000
Message-Id: <20260928095426.C035A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf riscv: uninitialized upper 32 bits in rdtsc() on RV32
--

commit fa857133aeb89c2c952b09a7575fc1ec0de78663
Author: Chen Pei <cp0613@linux.alibaba.com>

perf riscv: Implement rdtsc()

There is no riscv implementation of rdtsc(), so perf links against the
weak stub in util/tsc.c and every caller reads a constant 0.
This commit implements rdtsc() over the time CSR with rdtime, which is a
TSC equivalent on riscv.

> diff --git a/tools/perf/arch/riscv/util/tsc.c b/tools/perf/arch/riscv/uti=
l/tsc.c
> new file mode 100644
> index 0000000000000..7cc4710ac38c3
> --- /dev/null
> +++ b/tools/perf/arch/riscv/util/tsc.c
> @@ -0,0 +1,19 @@
[ ... ]
> +u64 rdtsc(void)
> +{
> +	u64 val;
> +
> +	/*
> +	 * The time CSR ticks at a constant frequency and is the same counter
> +	 * the kernel feeds into the user page conversion fields through
> +	 * sched_clock(), so it is a TSC equivalent here.
> +	 */
> +	asm volatile("rdtime %0" : "=3Dr" (val));

[Severity: Medium]
On 32-bit RISC-V (RV32), does this leave the upper 32 bits of val
uninitialized?

The rdtime instruction on RV32 is a pseudo-instruction that reads only the
lower 32 bits of the time CSR. Because the target variable val is a 64-bit
integer (u64), the compiler maps it to a register pair on RV32.

However, the inline assembly constraint "=3Dr" only writes to the first 32-=
bit
register, leaving the upper 32 bits completely uninitialized and containing
garbage. This could corrupt perf timestamp calculations when running on an
RV32 system.

Proper 64-bit CSR reading on RV32 requires a loop reading both the time and
timeh CSRs.

> +
> +	return val;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928094739.2605=
-1-cp0613@linux.alibaba.com?part=3D1
