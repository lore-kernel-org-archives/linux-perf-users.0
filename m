Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043F1B532F;
	Sat, 15 Feb 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739629250; cv=none; b=F3sQdMrHD8RCFXz/XgeCjKxJ9Hl7Si0wS42AC8SELCiQQU7fI8+UXgdsruxa3yS9rKwvvcEO0r5nNsy5/NqwaXsUwHyaYxJLVNrGd85KQcjDQxlnCRu+5RU8k+EzbTw3pz1qRfhMHEFhitXl/+H3oa5dA0MY5V0KRyoJr/bvcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739629250; c=relaxed/simple;
	bh=9uSRy5YwtCFQyHZsA76qYd3sx/h0OTyVxLvPXfU/XOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OftCMaZae3t6/JlwyTcwjlUOPkHyb45VcFmpk53B6SFJinr2VU8OvzxOUFHsXoCwKlnVjHI9jXu3oLfpzlyrU8bNjuCuEwry8+8wrMSiWcbxSZVnPnwDl0FGFxSSQCdMUqMx/c+xlnqzOsWQQjq2LgYLHi1Id1YXlL6q+h1BmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HjhlUc1D; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HjhlUc1D"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C42840E01A1;
	Sat, 15 Feb 2025 14:20:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fLWYrGP1x5ap; Sat, 15 Feb 2025 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739629241; bh=FvtP+96Hz/CW7VSStEV/oT/LfP9o+DeYiDp94whDh+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjhlUc1D2YERb3dMUSBRQO819si1b5MIvcs4vJ2Tl5qDX+8KsmehZDaz2DLl/AO0W
	 bPBatnNAh16BZgOvCLe2SozMkoaX6xc4Sese+9/rRqm6ADg9YE1HEpOkZ5QJDUrNdr
	 OWsHAuR8koEqE12mTTIEuz+hO95eRlyo/vcVVvgvzut5k4C1yeUSFZ/68lCwh0EpfO
	 hpyGYIHdmzLvFJCaGUUXphDPJiCzBW0nqY87jFQAFSn2KtS4c+2gjtUdu/DfszFZU9
	 rt8dSxZXaI0IYIJEDcmmcn1JBhdazos4UafnVml1CKsTyeoYKDW9AIoNgb7ICRxFIa
	 QEj/j3rkz4G5bzW1D61602jqbbB1PQHh6jiM1sP5YoAAvauTInF0dup7Gaf01peqQE
	 sTBjs+rpzgxlDM3JPm1Gw/QhvEUHNwB4tX2LsCfR6B2TOVWC+aWjlHrZcGXi/6/7+G
	 2SUEprPliy8n/E47nGrjAC7XmBoAbadqfcGXR/fKcieikAea9mhPx4aqXm1Bkp1iff
	 Uj+9dPHeuIZZtpZtZyUqjUkFI7jYDisblFnXgB/qjfkmlfK+uui37tfKm2Z9i1+qh6
	 mhXMtedZmzxGv4m3P4xWEanTFVVNIioiikReWPOPUxqtN8+f6z/Fd4seCHF0QJbVVW
	 RP7RFzgIx/cQtHmIQdWnN5EI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 179E140E016A;
	Sat, 15 Feb 2025 14:20:24 +0000 (UTC)
Date: Sat, 15 Feb 2025 15:20:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
	brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: Re: [PATCH v5 1/5] x86/cpufeatures: Add {required,disabled} feature
 configs
Message-ID: <20250215142017.GCZ7CioRHgpm6a-eIZ@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250106070727.3211006-2-xin@zytor.com>
 <20250214215823.GEZ6-8f5wt--IWggtl@fat_crate.local>
 <469D0BEE-76D6-4417-B5B0-0054D3F96784@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <469D0BEE-76D6-4417-B5B0-0054D3F96784@zytor.com>

On Sat, Feb 15, 2025 at 02:12:35AM -0800, H. Peter Anvin wrote:
> CX8 is the name of the CPUID flag, for better or worse. 

Right, so a separate patch:

git grep X86_CMPXCHG64
arch/x86/Kconfig:135:   select ARCH_USE_CMPXCHG_LOCKREF         if X86_CMPXCHG64
arch/x86/Kconfig.cpu:369:config X86_CMPXCHG64
arch/x86/Kconfig.cpu:383:       default "5" if X86_32 && X86_CMPXCHG64
arch/x86/include/asm/asm-prototypes.h:19:#ifndef CONFIG_X86_CMPXCHG64
arch/x86/include/asm/atomic64_32.h:51:#ifdef CONFIG_X86_CMPXCHG64
arch/x86/include/asm/cmpxchg_32.h:72:#ifdef CONFIG_X86_CMPXCHG64
arch/x86/include/asm/required-features.h:26:#ifdef CONFIG_X86_CMPXCHG64
arch/x86/lib/Makefile:59:ifneq ($(CONFIG_X86_CMPXCHG64),y)
arch/x86/lib/cmpxchg8b_emu.S:10:#ifndef CONFIG_X86_CMPXCHG64
lib/atomic64_test.c:257:#elif defined(CONFIG_X86_CMPXCHG64)
tools/arch/x86/include/asm/required-features.h:26:#ifdef CONFIG_X86_CMPXCHG64

should be easy.

> It seems to me to be a bit silly to have dummy symbols that mean literally
> the same thing, but ...

Why if they're confined and encapsulated in a single file:
arch/x86/Kconfig.cpufeatures ?

Rest of the kernel doesn't need to know whether a feature is required or not,
right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
