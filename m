Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193311EF1A;
	Wed, 12 Jun 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199254; cv=none; b=qLNWhIKrEzNKXhjpSe7HVrb+TEbM7TTtEfGWCmHS1jfUwFenXP17UBkXDlJj9QGfHtULKrTzu9gD9kI0fhi/rtvUPGc6tkwxPthhjcX9kA0zYSyRo7H+YpVJTw35whdQmJoI82RMW0LvrjOTCD+DIVr2gXnkB6Q/3Hy0clXUUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199254; c=relaxed/simple;
	bh=Au1llInZEepgsoZGLTYtmExSMQ5QuJqm+PY9oVjCw+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u95dUEd/l7UCk6W4LaGi5KJTrX3Qp7DirWHY2XDijyyFRVzCuHZCZiTVDFgRe0bZqhPAS0kaljALlAvuAborUBeYH97vH9jPPsZBhy2Oj6bixzTryMpxr6MpTZsun2KcqdoTt/RwmgTreo+8uUcuVcAeQMU/a9Gis+qqP7KgbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H5aPaIHr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H5aPaIHr"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BBC1140E016C;
	Wed, 12 Jun 2024 13:34:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Xl_z8xHFyKYs; Wed, 12 Jun 2024 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718199240; bh=eZyz57k7uXkPLYoNDXQ8VYUt/BHQFaQ55nFSMPTlOKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5aPaIHrEs/h1N/W9HuKXunwlA8nftqhlS9pE7BeeYgvKWZIC1ERtsbPfpYmkxKJk
	 hntYNF7sGBh4JIO33lut5KX2ZJhA8xNm9SfUzoY7f3gTCbuaGamF8AlGlROVMXlrnT
	 N/mGsCLozt7uFuJxl0YPSzpWY4IkfnjZbBjw75M5gB7utSK/Tc7bo8zN0xFSLLy2Bu
	 L0N46CPQPq3agsmw24N6PaqK1wFSIXQjIInIkpctMegS6F0dKzg0pxmQM6MKQhOQLX
	 5VLxd9Us/YmzkNFBH1MO1GaCRUZh3eCzZgzLKciZDVNHOyeyVrwpFDEGl7xgcoI1CX
	 NdMT/6cqngYCNCCvq8/dd3kv1Ay4OCXaMPAsBtYbLuwF3Z18iDaQ/7ugJkD1mgkR6n
	 6W9/SDV+I2P+4/Yld6p8/hg2fN61g/TVhLsXbJX70UsJTgLk3g3faymyLvCSgWhu+S
	 G5OYMz0y9cuj71ZFdn5+1RwoXk82QclBnY80rfbb6c7Lfb6nE4y1F82F/ivDoL0p9V
	 uu5w6mCHxknEm0DpHgOjqH8TA4+08R/C9oRodD1LSkT97TwIK3pWu4Hkj1PxzmdUAW
	 bcFdZqQkvwANszCIOZpt+3y2vV/r5rGQNCbl8VZ3hQx6E4FJQNTZucm35leZia5wUT
	 2kxYEsyATkKtl7k9RMzunPxo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25EBC40E0031;
	Wed, 12 Jun 2024 13:33:47 +0000 (UTC)
Date: Wed, 12 Jun 2024 15:33:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
	namhyung@kernel.org
Subject: Re: [RESEND v1 1/3] x86/cpufeatures: Add {required,disabled} feature
 configs
Message-ID: <20240612133340.GBZmmjtD40dzhsWVyg@fat_crate.local>
References: <20240509205340.275568-1-xin@zytor.com>
 <20240509205340.275568-2-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240509205340.275568-2-xin@zytor.com>

On Thu, May 09, 2024 at 01:53:38PM -0700, Xin Li (Intel) wrote:
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 2a7279d80460..719302d37053 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -358,6 +358,10 @@ config X86_P6_NOP
>  	depends on X86_64
>  	depends on (MCORE2 || MPENTIUM4 || MPSC)
>  
> +config X86_REQUIRED_FEATURE_NOPL

Can we keep the X86_{REQUIRED,DISABLED}_ prefixes solely in
arch/x86/Kconfig.cpufeatures and not spill them out into the rest of the tree?

This way there will be no confusion between X86_FEATURE_, X86_REQUIRED_FEATURE_,
X86_DISABLED_FEATURE_ and so on, and which one I am supposed to use where...

> diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
> new file mode 100644
> index 000000000000..326a8410ff06
> --- /dev/null
> +++ b/arch/x86/Kconfig.cpufeatures
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# x86 feature bits (see arch/x86/include/asm/cpufeatures.h) that are
> +# either REQUIRED to be enabled, or DISABLED (always ignored) for this
> +# particular compile-time configuration.  The tests for these features
> +# are turned into compile-time constants via the generated
> +# <asm/featuremasks.h>.
> +#
> +# The naming of these variables *must* match asm/cpufeatures.h.

I presume they must match X86_FEATURE_<name>?

And REQUIRED and DISABLED is manipulated in by the script?

I guess I'll see later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
