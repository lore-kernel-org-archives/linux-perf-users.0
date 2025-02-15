Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C1BE49;
	Sat, 15 Feb 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739629858; cv=none; b=gIh4phmvj4fjkxrEWO9UA66Rc3dJiV7Nd+bAvXiSlWGBReefQlG1UE62Y7BA3n88Shs4HB2pWbKAT2hpCz8/N7wNRMdetpPc18HykYw+B8EdzEblnZhj7p7E270LzJXyyQeDTAFjPZVQvEEQnjI4iRgzonbkMhrn1ImLMDjHsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739629858; c=relaxed/simple;
	bh=2Pq3X2/BumatMW2v2WEP6qvHetHwUpgiGj7OLV7bJH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEjAreeLN5s5PCI2ep40CybeOHegwGbJQ1Hijd8Q2CJjTHNKwJQvbzbENU4sZLQF5XyFQDBBcSubO2OvyxPp6JQGngZoJ+MPzWbp3uMCGcq1+dv9geqAxaX2ZqwRFq8bW17VGed7hvHJlhpuiJiso48dfagPICB/ig1VRmYLZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=THUv7Vi2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="THUv7Vi2"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6262340E016A;
	Sat, 15 Feb 2025 14:30:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4pvE9Dq-zGWu; Sat, 15 Feb 2025 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739629850; bh=M3sTokvYXMWUeUVbNMXEizkjzlba+5HMP+NDUy/BhgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THUv7Vi2x9ClnMKug0B2xqc5WuQ2vdOGtVGaYtKd13FlwBBz3YEQjZrkt0nOPsLIU
	 MZRD5z/y+pii9z5pHjeis9OANUMwpxr50lEj/R6euuf33tywdLLzOl8G5Qd6aVebCA
	 6V9tX7kwwvvRnvRD+lRbYnYsaJuqw8+YOxGd9uIHsswRmOH7OyqaHf2P8Kdxg8Wqs4
	 dWnJ82Ne8i533HNurKFiwJAcYmrZP6jR3popWZjAp7xd9NWpwBX+d/rCR0d4kdq0Wn
	 p/3RTaizbbRxuczNI8MeV5WirPYGMBGDVV7hDEAvdKXdRo0vGLf3o9E23rojXfM0SW
	 lV7ObhvTrkxR584nICp3t5q4sOHd81GddDcdFDoBKVefK5Ag9vSiYib4EL+hHMQyhC
	 o7XkLT3HEYIfBAELi5bqEa/AmVJWXtsuB297LoCwXPuMpcmkXrA4w1g3Id2a8N0v9T
	 CCgC5CW2XxcTys2CMz4bZyzdjnUlLFhJzfQKatFoaDbnl2KkUEQ22P+1MgnV6/hZ41
	 zAP0f6eX/G4Mbu33akIP1aEypWRy1NlnTnQvrgSdMvV+OObIM6L5fmNZ+ViytAX43f
	 nPc8pYr8zqMMG4Cb4kO+fguDu1wCRF3OHKrLZTDHWPnzScuK77sSLInAhohh6sBknM
	 iLuYn94wOqX+7YMqLMyMEFU4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7737E40E0028;
	Sat, 15 Feb 2025 14:30:33 +0000 (UTC)
Date: Sat, 15 Feb 2025 15:30:32 +0100
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
Message-ID: <20250215143032.GDZ7ClCJzyDkuvQSJp@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250106070727.3211006-2-xin@zytor.com>
 <20250214215823.GEZ6-8f5wt--IWggtl@fat_crate.local>
 <469D0BEE-76D6-4417-B5B0-0054D3F96784@zytor.com>
 <20250215142017.GCZ7CioRHgpm6a-eIZ@fat_crate.local>
 <3B96E82B-7AA8-40FF-9401-829D408AA790@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3B96E82B-7AA8-40FF-9401-829D408AA790@zytor.com>

On Sat, Feb 15, 2025 at 06:27:04AM -0800, H. Peter Anvin wrote:
> The point was that that is the *only* use of this particular flag, I believe.

Now you've confused me :-\. Perhaps elaborate a bit more what do you mean...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
