Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDC128812;
	Fri, 21 Jun 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991192; cv=none; b=P/fDdI5D2E5CzctB+7ZCw4ZInpGS+5iFXGUBHzlVyBbcOEH4vFHJjd0ZO5bGDWdxWm3z4xScVoftCX77HkTo8XRd6d+AHkL1UtEN8NOPAyj1p3S0P7rNdPo30fyoaK2IcvmnGe7IqFLZDSsNZRxdKNIGuYO9i+nsynAc0fXApAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991192; c=relaxed/simple;
	bh=5VRvJRsLhxyImQgvICYSbl5XZTyKkvy3XVaQTzwx/SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEBg/U0+OQTaFd9WpS+d1a0VbGKAnj5slsBRZPlPX8DyMIe0stwkC4j6Fwcn/6KMIzvW4C/t3ti8bve7YdTssHttOCcGqNyC/FFgKMISZOvbjqU+ja+UfmwK6otFWCykQcobscKOHHolMy574jYhnXP77sRpy0woRkAQ5AqmRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=is+THI1y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="is+THI1y"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2416E40E01F9;
	Fri, 21 Jun 2024 17:33:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yfj0BQ_yC9uh; Fri, 21 Jun 2024 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718991183; bh=Rhva3/MPW5AdxxQuixV5zRlTNA/U0pgCD1iJBw3vFIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=is+THI1yaShkfTTz+5TA+uIIdjaB22NopFKAtePkMzH83YipmOrD6kZ79HplRhUjW
	 B9B4LyXFRb5LcbX5GB3yX76pCLFkXbrg4T5PNx7l/1omt0uD1jslQFYyaRlFYWWkzy
	 IMS0OfON1Sb1NUqgN0XWyziAnm6hiBskG2Va9H+XrM54FEKGiXA0wkSGVPaT1aIenQ
	 2jSqdeW61CHbuN3Uf8gtM2wGSkIJV1RLbuUI9wPmBTwZwgf9U8aYMMWgfZke07onqf
	 gAi1HWSmPe24fjglExG8/Inr6m8DZ4Jn396RwH0lyls5+FnuQd09vzky82SQMjeK2L
	 4BQAIHw9cxILg+DHvdtZZEZH4Z16A7YuHyz50nniakFqRPj4ehG6a8i8ULD2RDAC3L
	 w010BPBi3qqU5QDTb9jNoSKD+WUExx8QB/mmR2KHiFLYFDZgISEXkPArHO0lgS9t1P
	 6dR+u+uNhnf7mKWmrxQp+0rLdNwJ1qfvNHUsrOMF3YoR9KXYixFWDTqZhW/cROGyXK
	 VgpVryr4ffKid2rGOfarsj1KCQDph7b5FT4vCwWTUXZVSAgixQ8CYOUDYvxNY6YyWe
	 be1AdcDaRYDoZWZQDQMTF7hfkLk+NzkR1tyccEEtpC3i3jwqle1UkT7xm5pJMMuXTl
	 Vt9KCrcWglQrv3aJbObkPmaM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD60640E01D6;
	Fri, 21 Jun 2024 17:32:50 +0000 (UTC)
Date: Fri, 21 Jun 2024 19:32:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
	namhyung@kernel.org
Subject: Re: [PATCH v2 1/3] x86/cpufeatures: Add {required,disabled} feature
 configs
Message-ID: <20240621173245.GKZnW5PVnf4ota5pL4@fat_crate.local>
References: <20240616085743.1100704-1-xin@zytor.com>
 <20240616085743.1100704-2-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240616085743.1100704-2-xin@zytor.com>

On Sun, Jun 16, 2024 at 01:57:41AM -0700, Xin Li (Intel) wrote:
> diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
> new file mode 100644
> index 000000000000..5ed24e45df87
> --- /dev/null
> +++ b/arch/x86/Kconfig.cpufeatures
> @@ -0,0 +1,197 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# x86 feature bits (see arch/x86/include/asm/cpufeatures.h) that are
> +# either REQUIRED to be enabled, or DISABLED (always ignored) for this
> +# particular compile-time configuration.  The tests for these features
> +# are turned into compile-time constants via the generated
> +# <asm/featuremasks.h>.
> +#
> +# The naming of these variables *must* match asm/cpufeatures.h, e.g.,
> +#     X86_FEATURE_ALWAYS <==> X86_REQUIRED_FEATURE_ALWAYS
> +#     X86_FEATURE_FRED   <==> X86_DISABLED_FEATURE_FRED
> +#
> +# And these REQUIRED and DISABLED config options are manipulated in an
> +# AWK script as the following example:
> +#
> +#                          +----------------------+
> +#                          |    X86_FRED = y ?    |
> +#                          +----------------------+
> +#                              /             \
> +#                           Y /               \ N
> +#  +-------------------------------------+   +-------------------------------+
> +#  | X86_DISABLED_FEATURE_FRED undefined |   | X86_DISABLED_FEATURE_FRED = y |
> +#  +-------------------------------------+   +-------------------------------+
> +#                                                        |
> +#                                                        |
> +#     +-------------------------------------------+      |
> +#     | X86_FEATURE_FRED: feature word 12, bit 17 | ---->|
> +#     +-------------------------------------------+      |
> +#                                                        |
> +#                                                        |
> +#                                     +-------------------------------+
> +#                                     | set bit 17 of DISABLED_MASK12 |
> +#                                     +-------------------------------+
> +#

Look ma, a picture. :-)

But yeah, this is better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
