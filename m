Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9F13C81B;
	Sat, 22 Feb 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241838; cv=none; b=erjNHKbPdVos6SsZh/MCE5EEeL78Fu5XKYO1Xux8kd3c8uGHajAhRCthdKt6ujgV7+P/c0Nq5JJgpNXzwGBpP9C9x3DTM6Kgel+4v/EDPyb/qpcDlNs4NJL7bV7mJg4zwQ3ss8qKVVzmYWdH3YYIrYAQ5ZVCZJs9p0P7RzQb4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241838; c=relaxed/simple;
	bh=TAgYvz4shjowE9LUaXwmfu6VLlUHFIppKrAy2sqc/g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8g8YD4Elcn4eEZsyYNSMGN9JeOg4cyUN5yIqAfQajNCA1bI+mOr6999ZIMcG0KGPK/WfP1xP155/Ib8QP5uYnpmA3KOXAAnLN6VYkgMghzODaQI/j+upBoL7lpKPEr4Zpt3MpIXTe9iOLa4aQxMjEkQQgRgK2Q+PZLF9EM7PiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hx7NJJgY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hx7NJJgY"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EB66A40E0177;
	Sat, 22 Feb 2025 16:30:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id inoskxphGDnD; Sat, 22 Feb 2025 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740241828; bh=GdarmdPYfhonxFe3eVsstixOM9edVzaHcDHd3EvNNVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hx7NJJgY74w3Yljy5RVXfBe9WIWZvtVAXM2saN2/A1odl5GsyR7DrmTj47+jNteJY
	 nUUvoRw5BGY3ro/CUdojMu76zw4aTzcg2yIlM/CnyC2Rzh9RotNmVSKFnjdbBGnF7l
	 vfGM030nM2HKT/muJ4wz6ynW8DTVsMWNtPsnkabDJyWzMUECPbJrheQKGiyQEBNM0A
	 yqmR4iIdOP4JcEM+Zv58h3lGf55BdiyxDF9Cm6mU8/rQ6DQzi4aQzZh6p7vdgKCGUO
	 Z0Mvp5NKD6roBJfTD++UmQj7bun218DcjwIo6vm/yVlrzuydN4sdW3WjLPzhzVxALW
	 nWCCDtfUk6dnv+H2WOcdmqdJbBbrDMP9szCg3bJTaVGw9utmTh5b7y45Ym73IbdfJh
	 TUywyY8XClcO/qgxBjEOCH1EcuO2qhacEphb+PbSiIytNj8AjLDkGi+iwBmHRZYbWi
	 VJRpt4HdZHzzJVN4K3B9RhMFHM8/0nA4bC6b15JHC4Mbd/FE3952lEI6CsPdyL+AQP
	 Jx6dorcQfOlUiOWywjfsyYorXWe2C1+264SeKeir0zH566Ae0ao/9fmKBpK0UpxFbB
	 g363BrXjAYZfl/FU9NdtjXCoFDJ3Gi29FwwbQFXoUgNU9ovCIhkGFDdkpWeFZQNbcW
	 cb4lqgDyh1wCucKf15Rwui9c=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A55E340E0176;
	Sat, 22 Feb 2025 16:30:11 +0000 (UTC)
Date: Sat, 22 Feb 2025 17:30:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, will@kernel.org,
	peterz@infradead.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
	brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: Re: [PATCH v5 5/5] x86/cpufeatures: Add the CPU feature bit for MSR
 immediate form instructions
Message-ID: <20250222163001.GUZ7n7iRc88PTMQi9_@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250106070727.3211006-6-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106070727.3211006-6-xin@zytor.com>

On Sun, Jan 05, 2025 at 11:07:27PM -0800, Xin Li (Intel) wrote:
> The immediate form of MSR access instructions are primarily motivated by
> performance, not code size: by having the MSR number in an immediate, it
> is available *much* earlier in the pipeline, which allows the hardware
> much more leeway about how a particular MSR is handled.
> 
> Add a new CPU feature word for CPUID.7.1.ECX and then the CPU feature bit
> for MSR immediate form.

Nope, scattered.c.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d5985e8eef29..59aa04915032 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -5,7 +5,7 @@
>  /*
>   * Defines x86 CPU feature bits
>   */
> -#define NCAPINTS			22	   /* N 32-bit words worth of info */
> +#define NCAPINTS			23	   /* N 32-bit words worth of info */
>  #define NBUGINTS			2	   /* N 32-bit bug flags */
>  
>  /*
> @@ -476,6 +476,9 @@
>  #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
>  #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
>  
> +/* Intel-defined CPU features, CPUID level 0x00000007:1 (ECX), word 22 */
> +#define X86_FEATURE_MSR_IMM		(22*32+ 5) /* "msr_imm" MSR immediate form instructions */

Also no "msr_imm": Documentation/arch/x86/cpuinfo.rst

In any case, this patch doesn't belong in this set.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
