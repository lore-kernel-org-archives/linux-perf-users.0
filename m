Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D823B14C2;
	Thu, 17 Sep 2026 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687728; cv=none; b=GoRbcedZUuTI78tPCwEFjuQlsoUndnzl/RZrb0kNdePMYUFdi3TCriNnjfd8yjpKaHoWWAkmp/DRlRGUNbCFvqP1/L1McY5sCAicnd2Q9LAktvH/rDRziWZl5luus80kqYO0Rmt43pSfyxoYjRuFST+eSIdIXwU634wH34fxDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687728; c=relaxed/simple;
	bh=7Xu7RLyyWLVDVN6CUHUexX6pQncntCqOCS4sg1XdxZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bSrx9N9YoN1rg01DO9VW+obx++DWgvj381YMLnV94OxE0eKrsfh/zr1f91aq0vjS7JG1yuCbVm36b0NnaLVRndFpbf/UMszuPsyIfYJu+ss6Q40SfjnsAfmaEtjl7pyskP7xml3YzkXUjwgl3ZtMzKqOQKFEm3A60lvb8aftt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpsKttpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpsKttpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27481F000FF;
	Thu, 17 Sep 2026 23:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687726;
	bh=BxD7BerHgNrCW7iJv4zjvHbBBMK5Bp53kL7N0fuzTvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZpsKttpakCBjzQ8/Tj4uv80TFIDnq1DT1uqgAp3Nk4r+LnYCiPFoMlaXWiwB5uaz0
	 QaaJFJSE74XDcD2zHyanySKN4EdMXz6YaZofKgQaV9N55n7hPsAfAqLmCaDaTO26Dt
	 7nEgkpaI+JHsVU6SupzXQ/1wItdrqxCgxk/puvJKdTpXdHMf/a7Uu5hdyRlXQUZxqw
	 kTi5QksVsLhytx9e8snrqkoWiZ13rOEU94B4ciE24+vOehlMNRosi8LXbzoABlBHlI
	 KK9Y+U5WuxEigDB95sSlXvln6CMJBTerINkF78u4DlW4PzLqbU5EJkASFTc6NNr0W+
	 ZOuS1fXK46YsA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/11] ptwrite uprobes: Add kernel self tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260917230127.924985-12-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-12-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:28:46 +0000
Message-Id: <20260917232846.C27481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] kselftests/uprobes: test unconditionally skips due to undefined =
FLT_V variable
- [Medium] kselftests/uprobes: unaligned_nopfn site does not cross 8-byte b=
oundary, invalidating test
- [Low] kselftests/uprobes: 64-bit inline assembly causes build failure on =
32-bit x86
--

commit af4e3ff18548d1ab18ec7d6c2b846c7b5c15b34e
Author: Andi Kleen <ak@kernel.org>
Subject: ptwrite uprobes: Add kernel self tests

This commit adds selftests for PTWRITE uprobes to exercise instruction
punning, multinop patching, and probe lifecycle on x86 architectures.

> diff --git a/tools/testing/selftests/uprobes/Makefile b/tools/testing/sel=
ftests/uprobes/Makefile
> new file mode 100644
> index 0000000000000..ee97442f8c9dc
> --- /dev/null
> +++ b/tools/testing/selftests/uprobes/Makefile
> @@ -0,0 +1,14 @@
[ ... ]
> +TEST_PROGS :=3D run_ptw.sh
> +
> +ifneq ($(filter x86 x86_64,$(ARCH)),)
> +TEST_GEN_FILES :=3D ptw_probe
> +else

[Severity: Low]
Will this fail to build on 32-bit x86 architectures? The Makefile enables t=
est
compilation for the x86 architecture filter, which includes 32-bit builds.
However, ptw_probe.c uses strict 64-bit inline assembly like movabs, %rax,
and %rsp. When compiled with a 32-bit toolchain, won't the assembler reject
these instructions?

> diff --git a/tools/testing/selftests/uprobes/ptw_probe.c b/tools/testing/=
selftests/uprobes/ptw_probe.c
> new file mode 100644
> index 0000000000000..b232fbd4d2aa0
> --- /dev/null
> +++ b/tools/testing/selftests/uprobes/ptw_probe.c
> @@ -0,0 +1,156 @@
[ ... ]
> +static __attribute__((noipa)) uint64_t
> +unaligned_nopfn(uint64_t a)
> +{
> +	asm volatile(".p2align 3, 0x90\n\t"
> +		     "nop\n\t"
> +		     ".globl nopfn_unaligned_site\n\t"
> +		     "nopfn_unaligned_site:\n\t"
> +		     "nop\n\tnop\n\tnop\n\tnop\n\tnop" ::: "memory");
> +	return a * 13 + 5;
> +}

[Severity: Medium]
Does this actually create an unaligned sequence that crosses an 8-byte
boundary?

The assembly code aligns to 8 bytes with .p2align 3 and adds a 1-byte nop,
placing the start of the 5-byte target sequence at offset 1. Since offsets 1
through 5 fit perfectly within a single 8-byte word, the kernel's atomic
patch path can handle it safely.

Won't the kernel accept this probe instead of rejecting it, causing test 11=
 in
run_ptw.sh to incorrectly report a failure when it expects the kernel to
reject the probe?

> diff --git a/tools/testing/selftests/uprobes/run_ptw.sh b/tools/testing/s=
elftests/uprobes/run_ptw.sh
> new file mode 100755
> index 0000000000000..a16b7adeabb74
> --- /dev/null
> +++ b/tools/testing/selftests/uprobes/run_ptw.sh
> @@ -0,0 +1,219 @@
[ ... ]
> +PUN_V=3D$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <punfn>:/{print $1;exit}'=
 | tr -d ':')
> +JCC_V=3D$(objdump -d "$BIN" |
> +	awk '/^[0-9a-f]+ <jcc8>:/ {f=3D1; next} f&&/jne/{print $1; exit}' |
> +	tr -d ':')
> +NOP_V=3D$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <nopfn_site>:/{print $1;e=
xit}' | tr -d ':')
> +NOP5_V=3D$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <nop5>:/{print $1;exit}'=
 | tr -d ':')
> +UNOP_V=3D$(objdump -d "$BIN" |
> +	awk '/^[0-9a-f]+ <nopfn_unaligned_site>:/{print $1;exit}' | tr -d ':')
> +RZ_V=3D$(objdump -d "$BIN" | awk '/^[0-9a-f]+ <rz_probe_site>:/{print $1=
;exit}' | tr -d ':')
> +if [ -z "$PUN_V" ] || [ -z "$JCC_V" ] || [ -z "$FLT_V" ] ||
> +   [ -z "$NOP_V" ] || [ -z "$NOP5_V" ] || [ -z "$UNOP_V" ] ||
> +   [ -z "$RZ_V" ]; then
> +	echo "1..0 # SKIP unable to resolve ptw_probe symbols"
> +	exit 0
> +fi

[Severity: Medium]
Is the FLT_V variable supposed to be defined or populated before this check?

The script tests for the existence of an undefined variable FLT_V, which
causes this condition to always evaluate to true. Doesn't this mean the ent=
ire
ptwrite uprobe selftest unconditionally skips execution and reports
'unable to resolve ptw_probe symbols' on every run, resulting in no test
coverage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D11
