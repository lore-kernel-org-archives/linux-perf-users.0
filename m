Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170C264606;
	Mon, 24 Feb 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418074; cv=none; b=c828D8thjj+PyUs0wd5yrZsNA2uIZ1jEdDU6whOao64yF7/52G0PMnnSQlPX18joVO1i/6w3VaiMlWYVT4ZoMr8YuxX4qyoO423h/o8znwjPrKtVNJ0DdIX+YB/Dr/C9xUQrH9A3qDqbfIhxLmEW+q2RfHlM0YdTc0zXBWU+fFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418074; c=relaxed/simple;
	bh=/WTgdLJ7Cr+Q0c3p5v9SDBHCHd2RmbcFR1TyVPCZpRQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fHP4HWxfb/ySNO+/xB0T9A6BXht4fZk8sL/CYZZTMyzGRmw1cKiE7CWjnkJHjh6Ufasqw5ASInqLAQC7/s+0uimPOWBWngO1zdHmZnGtQCVwOVs0zaSy4167TXGqA0DgVn1g7PlpbPAHWTIrHPr7bSfSBYH1JRqCf7KqpN6xMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=un9lnUoZ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="un9lnUoZ"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51OHRBSm808450
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 24 Feb 2025 09:27:11 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51OHRBSm808450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740418032;
	bh=y+1kq2YEKF7R69yKWojIPrUsOYg3qwUYhBs10WXq4gU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=un9lnUoZC/dhT580RAcggjP9vJkSTZUx9/wSbHI+NNp1dzP02U18wyT8ws5sh2tFQ
	 pvDmmBsSSvkhBh6GcIjzuWkuS6Vavgy2u43ssul0cRaTQ6H1HpfVVsufvNQRbf6orC
	 /yMOFi130bMKTold3B75eI7gpTp/BGewlkwZx+RwATA7onvvJf9Np9zu3HocRD711S
	 P69pLyhVpF4bvdDCDlqWssB9C6VugJcHhydn4n6iqLYhVCLem+rIR39FtXYkeM9KaN
	 Yn12PJgbslD2fKQXhzvjPYh4tWR5grP7Cd+4z6fo5nYMkhmzGz04zyJ+1GyX1Lv0/G
	 xr4uLVDVd9Sbg==
Date: Mon, 24 Feb 2025 09:27:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Borislav Petkov <bp@alien8.de>
CC: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, will@kernel.org, peterz@infradead.org,
        yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com,
        nik.borisov@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_5/5=5D_x86/cpufeatures=3A_Add_the_CPU?=
 =?US-ASCII?Q?_feature_bit_for_MSR_immediate_form_instructions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <52bf4850-b66c-4692-8827-8995793607c3@zytor.com>
References: <20250106070727.3211006-1-xin@zytor.com> <20250106070727.3211006-6-xin@zytor.com> <20250222163001.GUZ7n7iRc88PTMQi9_@fat_crate.local> <52bf4850-b66c-4692-8827-8995793607c3@zytor.com>
Message-ID: <9A1B8A9F-64DF-4059-A064-E2AAC66204BF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 23, 2025 11:30:21 PM PST, Xin Li <xin@zytor=2Ecom> wrote:
>On 2/22/2025 8:30 AM, Borislav Petkov wrote:
>> On Sun, Jan 05, 2025 at 11:07:27PM -0800, Xin Li (Intel) wrote:
>>> The immediate form of MSR access instructions are primarily motivated =
by
>>> performance, not code size: by having the MSR number in an immediate, =
it
>>> is available *much* earlier in the pipeline, which allows the hardware
>>> much more leeway about how a particular MSR is handled=2E
>>>=20
>>> Add a new CPU feature word for CPUID=2E7=2E1=2EECX and then the CPU fe=
ature bit
>>> for MSR immediate form=2E
>>=20
>> Nope, scattered=2Ec=2E
>
>Oh, neat=2E
>
>>> @@ -476,6 +476,9 @@
>>>   #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogen=
eous Core Topology */
>>>   #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Class=
ification */
>>>   +/* Intel-defined CPU features, CPUID level 0x00000007:1 (ECX), word=
 22 */
>>> +#define X86_FEATURE_MSR_IMM		(22*32+ 5) /* "msr_imm" MSR immediate fo=
rm instructions */
>>=20
>> Also no "msr_imm": Documentation/arch/x86/cpuinfo=2Erst
>
>My bad=2E
>
>>=20
>> In any case, this patch doesn't belong in this set=2E
>>=20
>
>Right=2E
>
>I tried to show that we don't need to make the following changes due to
>NCAPINTS increased to 23 if this patch is based on this patch set=2E
>
>But if this feature is added through scattered=2Ec, NCAPINTS is not even
>changed=2E=2E=2E
>
>Thanks!
>    Xin
>
>---
>diff --git a/arch/x86/include/asm/cpufeature=2Eh b/arch/x86/include/asm/c=
pufeature=2Eh
>index de1ad09fe8d7=2E=2E051d006cc0c6 100644
>--- a/arch/x86/include/asm/cpufeature=2Eh
>+++ b/arch/x86/include/asm/cpufeature=2Eh
>@@ -95,7 +96,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
>           CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||    \
>           CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||    \
>           REQUIRED_MASK_CHECK                                    ||    \
>-          BUILD_BUG_ON_ZERO(NCAPINTS !=3D 22))
>+          BUILD_BUG_ON_ZERO(NCAPINTS !=3D 23))
>
> #define DISABLED_MASK_BIT_SET(feature_bit)                             \
>         ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||    \
>@@ -121,7 +122,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
>           CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||    \
>           CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||    \
>           DISABLED_MASK_CHECK                                    ||    \
>-          BUILD_BUG_ON_ZERO(NCAPINTS !=3D 22))
>+          BUILD_BUG_ON_ZERO(NCAPINTS !=3D 23))
>
> #define cpu_has(c, bit)         \
>        (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :  \
>diff --git a/arch/x86/include/asm/disabled-features=2Eh b/arch/x86/includ=
e/asm/disabled-features=2Eh
>index c492bdc97b05=2E=2Ec6a1f962185c 100644
>--- a/arch/x86/include/asm/disabled-features=2Eh
>+++ b/arch/x86/include/asm/disabled-features=2Eh
>@@ -156,6 +156,6 @@
> #define DISABLED_MASK19        (DISABLE_SEV_SNP)
> #define DISABLED_MASK20        0
> #define DISABLED_MASK21        0
>-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS !=3D 22)
>+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS !=3D 23)
>
> #endif /* _ASM_X86_DISABLED_FEATURES_H */
>diff --git a/arch/x86/include/asm/required-features=2Eh b/arch/x86/includ=
e/asm/required-features=2Eh
>index e9187ddd3d1f=2E=2Ea346db1d078c 100644
>--- a/arch/x86/include/asm/required-features=2Eh
>+++ b/arch/x86/include/asm/required-features=2Eh
>@@ -100,6 +100,6 @@
> #define REQUIRED_MASK19        0
> #define REQUIRED_MASK20        0
> #define REQUIRED_MASK21        0
>-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS !=3D 22)
>+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS !=3D 23)
>
> #endif /* _ASM_X86_REQUIRED_FEATURES_H */
>
>

That being said, this is the next word that will end up being populated so=
=2E=2E=2E

(On the other hand, only four bits were ever assigned to the Transmeta CPU=
ID word; the rest of the bits in that word could be reclaimed, if not the w=
hole word=2E)
