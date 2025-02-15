Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D914F98;
	Sat, 15 Feb 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739629667; cv=none; b=K0xhrlZLjCg2vGcrauc0Timnu2Jlz6ViODg43Qt0wUrcWFdUoUx66WqgUcTFrceE0QgEs0zwVQyDrY3xnzcGVFS/uMYIEq/N/db5Ius7WPGUa6V4qnCmP0fvKora5/4hZteM0PpemJhHEZS5/gke6oGol0b+vBWb7e2mbQaFUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739629667; c=relaxed/simple;
	bh=EDhHIvCfRXx2B2AUFH0IhXnEtgvUgeS2M27ttKC8lTk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ADWiXxvXAGxBciAxhDuATXoEpi8yiu5Ie1ZxFMLvEpOvnJtwQPHNZ5o2Y+7mu5tgiY1XnTqrLqP2ju5WOtYtV3Drq+mR/81c39Bqxcl/e+Em92JuOet1434sxuYFu9+Pd/s2SbDbxalsAj0QpI9zXMxVTZXLy9KBkWZLgz8cFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FEK3+EIe; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FEK3+EIe"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51FER5xd148073
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 15 Feb 2025 06:27:05 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51FER5xd148073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025011701; t=1739629626;
	bh=qxn+30dyi7ZczjFrixbDNX5zYUxOGDIJz5uTjCv8Vhc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FEK3+EIeIVuZSk9G44lSifvEYkMmw7VSqyMrmshkTRqWPSHL8rfoWmmHkS0Uzmih7
	 mQINh3LK7f9zENX78mHRvIxb9QettIBMRUt1/VUBEh21S4jqkKv6AayNTr6znMVm88
	 HmHki8I91g3qrtBQJ01rYiQudRHY0uewCrK4JILtLpgUTZY6R39WKjtqCcWnBKFOYJ
	 1MJqhtszIGMDi2usrg2pVTQkfJ8rEttqzKqQPDq4WyQvaDIl9DDBujImHtDrjxGoSb
	 YIxw7U/4MN3ArOapSf1W3z2merHw77HwcZcynunLwWnNNHawJQwm7Ws22H/gt5C990
	 jDExTTZRs0rvw==
Date: Sat, 15 Feb 2025 06:27:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, will@kernel.org,
        peterz@infradead.org, yury.norov@gmail.com, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/5=5D_x86/cpufeatures=3A_A?=
 =?US-ASCII?Q?dd_=7Brequired=2Cdisabled=7D_feature_configs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250215142017.GCZ7CioRHgpm6a-eIZ@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com> <20250106070727.3211006-2-xin@zytor.com> <20250214215823.GEZ6-8f5wt--IWggtl@fat_crate.local> <469D0BEE-76D6-4417-B5B0-0054D3F96784@zytor.com> <20250215142017.GCZ7CioRHgpm6a-eIZ@fat_crate.local>
Message-ID: <3B96E82B-7AA8-40FF-9401-829D408AA790@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 15, 2025 6:20:17 AM PST, Borislav Petkov <bp@alien8=2Ede> wrote=
:
>On Sat, Feb 15, 2025 at 02:12:35AM -0800, H=2E Peter Anvin wrote:
>> CX8 is the name of the CPUID flag, for better or worse=2E=20
>
>Right, so a separate patch:
>
>git grep X86_CMPXCHG64
>arch/x86/Kconfig:135:   select ARCH_USE_CMPXCHG_LOCKREF         if X86_CM=
PXCHG64
>arch/x86/Kconfig=2Ecpu:369:config X86_CMPXCHG64
>arch/x86/Kconfig=2Ecpu:383:       default "5" if X86_32 && X86_CMPXCHG64
>arch/x86/include/asm/asm-prototypes=2Eh:19:#ifndef CONFIG_X86_CMPXCHG64
>arch/x86/include/asm/atomic64_32=2Eh:51:#ifdef CONFIG_X86_CMPXCHG64
>arch/x86/include/asm/cmpxchg_32=2Eh:72:#ifdef CONFIG_X86_CMPXCHG64
>arch/x86/include/asm/required-features=2Eh:26:#ifdef CONFIG_X86_CMPXCHG64
>arch/x86/lib/Makefile:59:ifneq ($(CONFIG_X86_CMPXCHG64),y)
>arch/x86/lib/cmpxchg8b_emu=2ES:10:#ifndef CONFIG_X86_CMPXCHG64
>lib/atomic64_test=2Ec:257:#elif defined(CONFIG_X86_CMPXCHG64)
>tools/arch/x86/include/asm/required-features=2Eh:26:#ifdef CONFIG_X86_CMP=
XCHG64
>
>should be easy=2E
>
>> It seems to me to be a bit silly to have dummy symbols that mean litera=
lly
>> the same thing, but =2E=2E=2E
>
>Why if they're confined and encapsulated in a single file:
>arch/x86/Kconfig=2Ecpufeatures ?
>
>Rest of the kernel doesn't need to know whether a feature is required or =
not,
>right?
>

The point was that that is the *only* use of this particular flag, I belie=
ve=2E
