Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0E17C2;
	Sat, 22 Feb 2025 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740248001; cv=none; b=gq7PbiBEkwPdfI2aoWrcnTJoGVypuVGEtPQMeNYTqQKRHRrPX3SLRWf6pNZOee+RjsmPsmTjtnkWYNxEgvwf/4dXM+G/I0OP1HkWrg5AWd4URhBAXLTOokRiFfcuaASkpcY0ILLUVH4TLX9OKIJ3V9BSJ7cUXK/Cx+p3JGiVMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740248001; c=relaxed/simple;
	bh=cBfAjbC/LSbp4NLxXMHOLBFedlyDNlfSFFCSmC8Zpcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIqJlR5KYsKLqTc/Q63CLn3e9EAqXbTWungNxNZB2Hcav03sBBhdiyXH1YC69m/kcQpVvSfs/78jLFgj6QiNIP51kF24WsV/T9/O1PmHUnpHjj6iLCQcVw2TTvluhAffXGZ5hvJCDOtiIHjNzG+/I89AIsLx3cFjA3oEzSZIFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jtuzKDXY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jtuzKDXY"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AC58740E016E;
	Sat, 22 Feb 2025 18:13:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SLi3F0dltApR; Sat, 22 Feb 2025 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740247992; bh=7FiUqhQ/R6CBzeGJGzDnSoZWNCrWCqaOr4peWdeRyCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtuzKDXYISMlBW4GAMon1pHFTbOIxp6q/93EPX12gElN8ITA+1j62cyVabWO2/c/q
	 7O7rrijHNJuJvTnEEq/mGhh+cSyvK8AvD9KiDVBmbvUWIALx/73leofCb/J3sM+bX1
	 dke9v7QDxkfQneMXvte2DrgbcbRJGh2z4yuytaRycVBno7MqMd5kuVZLIGzdjfiLNq
	 D0B//KOZDgpcCKpRgDCB8KtKWBBINtMxA2NetysXerhhfzPuVX0WC6gyDuWjqBNmnf
	 75gY/m8o11Sf8J6QHax0WwEZ5aW+GDPRBvNiFbWnve03HgwN/TSZHn1NBXZIeahePA
	 ic/Vu9NZhVy3hCzqMVOGY+d9ironcoRlQcpXjGrEsbM9yY0PSl63qvrWyiZtLgC8Bb
	 WC0ThNCm7dHoJMEM4Bo9wV/Lx31ZMH/QaDj9nDpgubsRmtuOMIbe3o2fr9zIWnKA2S
	 i4iaRWKZEmTYXikhDO7/QjwTlcSUuOai6Nw55P+ENexrekfch+HuWN1SpAOG38uWts
	 QckMRD/edqn0T77tUBqIUfUIscNcxLM7RHVZEXCNcqU53jx9i8MdeeWfwdX1s/WHO2
	 +kZ9ZOVG7//jCzM88NlDWwToPFsrrRIOEr9DIguNh6gEuCEN+erGor1F0U4wl46Br0
	 ONFh2S7Wncttymv+0fFf/hOA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 718BF40E0176;
	Sat, 22 Feb 2025 18:12:55 +0000 (UTC)
Date: Sat, 22 Feb 2025 19:12:48 +0100
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
Message-ID: <20250222181248.GEZ7oToC31M5WDSFYq@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250106070727.3211006-6-xin@zytor.com>
 <20250222163001.GUZ7n7iRc88PTMQi9_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222163001.GUZ7n7iRc88PTMQi9_@fat_crate.local>

On Sat, Feb 22, 2025 at 05:30:01PM +0100, Borislav Petkov wrote:
> > +/* Intel-defined CPU features, CPUID level 0x00000007:1 (ECX), word 22 */
> > +#define X86_FEATURE_MSR_IMM		(22*32+ 5) /* "msr_imm" MSR immediate form instructions */
> 
> Also no "msr_imm": Documentation/arch/x86/cpuinfo.rst
> 
> In any case, this patch doesn't belong in this set.

Also, nothing's using that bit so you could simply leave out that patch
altogether.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
