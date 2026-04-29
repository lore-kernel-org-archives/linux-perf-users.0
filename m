Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD8225A38
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430285; cv=none; b=ORbR3rVeHVMzguwC6/eEVdAECxZ+uhrbKEIzPZIJrPYI9AmggCYpPI+A9p7aqEx0Mtg+lkVwPoc1XaRsZJ66Cxv4DomS/Ec2ywBX/ufdJLme9ElX6dxlJMKWnC8Vku8lSGSL6rpypsrTbmmx7W4UMfe4X4dYCQSKZq9aZSytw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430285; c=relaxed/simple;
	bh=ZPBUg/FAp+3Daq6qEngpkvUdBK6w+RmqQUT80Xi6rc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eydBGfvl2VUKqae/Plx5uZqbAom9t2MKoFMQEbhMfYMOVeih0BkGSRugUhtVj9A2KEWl70vr+dnHZ4kSVu4orLGFVqiEduofTUuRwLDFWht1H+xVuUY3EhCUmWQW2HfU319DWks9UrMy4aKq/cu9UIPCrvG691ozpebc0cR2vxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ocn+EHYN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ocn+EHYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B72DC2BCB7;
	Wed, 29 Apr 2026 02:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777430284;
	bh=ZPBUg/FAp+3Daq6qEngpkvUdBK6w+RmqQUT80Xi6rc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ocn+EHYNqDga3ak75SiocILeW3BJXDVal1MC/0RTVtw19181wlLuvRsREF8NthPgo
	 I2eGfWcB9lhReJis4W240H4uIFSl1NNh4JBOAs+ey0WXVpbdR94VVgo+jVB0J/7m5x
	 yiOoDZzdfKRyDMTa1ECStG7yCijXFCcEwse0Um94XpyrQ34vB9kVgPuJx6YYhxecDV
	 NLaIYFCzQDm8GnaGVJ/oSvYrTMvdSlG1ZAKM4M8K71DO1W32bZ46CKNu99fPJTOp70
	 BlQx5DcvvCdtRbdszl10gbYPPDpYFIOlnsBFb1nddWVIhKzwQqoOoaclZ1RvE6e6PV
	 zoz0LJY2OuCXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] DO NOT MERGE: arm64: perf: Add skip_vmio parameter
 to control device memory callchain guard
Reply-To: sashiko@lists.linux.dev
To: "Fredrik Markstrom" <fredrik.markstrom@est.tech>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260428-master-with-pfix-v3-v1-2-c384d3e53092@est.tech>
References: <20260428-master-with-pfix-v3-v1-2-c384d3e53092@est.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 02:38:03 +0000
Message-Id: <20260429023804.7B72DC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The patch embeds a test-only backdoor into core architectural code=
, exposing a system-wide Denial of Service (DoS) vulnerability.
- [High] The device memory guard is vulnerable to a Time-of-Check to Time-o=
f-Use (TOCTOU) race condition that can lead to an unprivileged Denial of Se=
rvice.
- [Medium] The `skip_vmio` parameter uses `module_param()` instead of `modu=
le_param_unsafe()`, failing to taint the kernel when system integrity is co=
mpromised.
--

commit 7350d20819d5cd55953c6253c2ca394a596ece60
Author: Fredrik Markstrom <fredrik.markstrom@est.tech>

DO NOT MERGE: arm64: perf: Add skip_vmio parameter to control device memory=
 callchain guard

This commit introduces a skip_vmio module parameter to bypass the device
memory guard during user callchain unwinding. It allows administrators to
disable the protection dynamically for testing external abort paths.

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 6426a307b8f8..ebe909012e4e 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c

[ ... ]

> @@ -112,6 +113,10 @@ static bool addr_is_device_mem(unsigned long addr)
>  #endif
>  }
> =20
> +static bool skip_vmio =3D true;
> +module_param(skip_vmio, bool, 0644);
> +MODULE_PARM_DESC(skip_vmio, "Skip device memory during user callchain un=
winding");

Does introducing this parameter expose the system to an unprivileged denial
of service?=20

If an administrator disables this guard for testing, it globally removes the
device memory protection. An unprivileged user profiling their process could
then point their frame pointer into a mapped device memory region, triggeri=
ng
a synchronous external abort and kernel panic.=20

Test mechanisms that deliberately enable hardware panics are typically
restricted to isolated testing modules or conditionally compiled out of
production kernels.

Also, since disabling this guard deliberately introduces a known crash
vector, should this use module_param_unsafe() instead of module_param()?

Using the unsafe variant would taint the kernel, ensuring that subsequent
crash dumps clearly indicate the kernel was running in a compromised state
rather than experiencing a genuine hardware failure.

>  enum kunwind_source {
>  	KUNWIND_SOURCE_UNKNOWN,

[ ... ]

> @@ -616,7 +621,7 @@ unwind_user_frame(struct frame_tail __user *tail, voi=
d *cookie,
>  	if (!access_ok(tail, sizeof(buftail)))
>  		return NULL;
> =20
> -	if (addr_is_device_mem((unsigned long)tail))
> +	if (READ_ONCE(skip_vmio) && addr_is_device_mem((unsigned long)tail))
>  		return NULL;
> =20
>  	pagefault_disable();

This is an existing issue with the guard being modified here, but is there a
time-of-check to time-of-use race condition between the lockless check and
the memory read?

Because addr_is_device_mem() performs a lockless page table walk, a
concurrent thread could potentially remap the target virtual address to
device memory in the window before the memory is accessed:

Thread 1                               Thread 2
addr_is_device_mem(tail)
// returns false
                                       mmap(tail, ..., MAP_SHARED, fd, 0)
                                       // remaps to device memory
pagefault_disable()
__copy_from_user_inatomic(...)
// triggers synchronous external abort

Could this allow an attacker to bypass the guard and force an illegal device
memory read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-master-wit=
h-pfix-v3-v1-0-c384d3e53092@est.tech?part=3D2
