Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A271DC9AA;
	Fri, 14 Feb 2025 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570341; cv=none; b=c9eUTdWuRCzOjViIlrZwX6bJP+y2HWoZr59NCQiNrxqEH2SkaudasAvRtRDx2d2B8Gappeilo9x6oBdHVCf5jhGHiodgBNq1x32BLlsFWOGRfasXWugHmV+wvXVr9HivPKp/VEnFiSRZcczzCCW3FdFkNYlv1k3YuvbOjaX0FCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570341; c=relaxed/simple;
	bh=XtAVajuShpD01Nym5/So0au3KETv9QP80ZVu+BZYuWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOwuMWP96P66Y1A8zu2DmzjK0/Q+xIalgefNI1ZhZrmCv9XMehC+pGPqXqpRMi/SYXQ3KKUeub4i1w6542AhNSKibhFi+D6UAFiNwMRyRaTR+/4o/ePaYmgn3vkVXNn2uyZIqj/jI/OoE8TjeUatp4nkukKFGpETNL69JH64q44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BbPd5alr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BbPd5alr"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D56EE40E0191;
	Fri, 14 Feb 2025 21:58:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GBEeTekC8cxO; Fri, 14 Feb 2025 21:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739570331; bh=+WAz4sQFpwYRfwTN18cezX4rjFczEliSO8kZeynTs2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbPd5alr0lTQ/a/j6Yw5sXL0BnV8CIg/mwmO3+AWIlMQW7VcPM/1IFIplNDflsbY/
	 1NGEnQKfimND7peVuHegY7nUGSJtWeVHKOMLiSYqama/RHyJRMQPE+GlwsNyh4pgMB
	 A0QT4Xb1pJTRQw9zrRVToAQCjCYtzVtoBC84TYQgrXYciojxIoDVZpo2tZc34ZIoVa
	 SIPFsH2ZaAcPQCI2RjcuH/1IGliD3EyR3N9BaGPKR2bgoEJJgFdL9tt5Uxk5oPUoxm
	 RRPzDLojjYHpsqsyZpU1s6QA23V2B/eXdxcAtPocBtm1sdqlwBjucurQZsLY3H9UBJ
	 RqQHmF06nkMzle1OJNm9x7cX4ZHBOB81fYa2+TXexGfyBk3w/OtRt0mrgqZyu7xnxI
	 b9Id/AufiG0M7EBNgRGaGKRpbEgkvkYZ3kKPalGKYUEIe4p11DTH2wQWwyvMvVvBpL
	 JGWN5fAVW7efah5r+PR6MGnBg4PZ9RV6f4GEU+7SvwNafVWfU3SGY76Oj4gDfojy4+
	 8G5uuEIShQ0dDb2+bfoGJVElvy3y4mbUSp0Hq5Dc4J/7bWJ+IwCximwxQU8y1PONiJ
	 uyYQOa1Ix8fuAjrguQ7dzpzr8NwL1JZwWozjac9NKtenusRGoLvOKrqG8PKBO5fkNw
	 TXL75c29yt48U96Wc60pGbRE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B02AC40E00C9;
	Fri, 14 Feb 2025 21:58:33 +0000 (UTC)
Date: Fri, 14 Feb 2025 22:58:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, will@kernel.org,
	peterz@infradead.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
	brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: Re: [PATCH v5 1/5] x86/cpufeatures: Add {required,disabled} feature
 configs
Message-ID: <20250214215823.GEZ6-8f5wt--IWggtl@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250106070727.3211006-2-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106070727.3211006-2-xin@zytor.com>

On Sun, Jan 05, 2025 at 11:07:23PM -0800, Xin Li (Intel) wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Required and disabled feature masks completely rely on build configs,
> i.e., once a build config is fixed, so are the feature masks. To prepare
> for auto-generating a header with required and disabled feature masks
> based on a build config, add feature Kconfig items:
>   - X86_REQUIRED_FEATURE_x
>   - X86_DISABLED_FEATURE_x
> each of which may be set to "y" if and only if its preconditions from
> current build config are met.
> 
> X86_CMPXCHG64 and X86_CMOV are required features, thus rename them to
> X86_REQUIRED_FEATURE_CX8 and X86_REQUIRED_FEATURE_CMOV.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
> 
> Changes since v1:
> * Keep the X86_{REQUIRED,DISABLED}_FEATURE_ prefixes solely in
>   arch/x86/Kconfig.cpufeatures (Borislav Petkov).

But that isn't the case yet, right?

There are changes in the code like this now:

 #include <asm/nospec-branch.h>
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_REQUIRED_FEATURE_CX8
 extern void cmpxchg8b_emu(void);

 which means, I need to know whether I need to use a REQUIRED feature flag or
 a normal feature flag, i.e., CONFIG_X86_CMPXCHG64.

 Btw, why are you renaming CMPXCHG64 to CX8?

 So what would be a lot nicer is if you did this in Kconfig.cpufeatures:

+ config X86_REQUIRED_FEATURE_CMPXCHG64
	select X86_CMPXCHG64
+	def_bool y
+	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7

and then use CONFIG_X86_CMPXCHG64 everywhere.

So that the rest of the code doesn't have to know whether those features are
REQUIRED or DISABLED but just features and only the internal machinery does
those additional defines.

Makes sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
