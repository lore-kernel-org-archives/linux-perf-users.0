Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F3318E34A;
	Tue, 25 Feb 2025 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505799; cv=none; b=CybEA+1riQ8wCGWlvDk8Nmlg21J9yelhKpqs48JD4WG9dBIdoJ65TOG/Pw5FFNm0aM8gadx5VROHNGgbZ5NnuVSsb8K2a4Y86tb5JVbpxVONrjrHrIT3YouoNkjZn83I8RS+GbS4yI0RfH63LHCBfFBsaIJ8W32Mk9828/DhZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505799; c=relaxed/simple;
	bh=AKm94b+tNe6dqRLJYUXxcm855hBDTf/Htp6Wz/SI670=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaY7y/892GZgpTSFWOWROOADTlPBtomAO5eeLDAU4QWQWMMEH4ArVSNsBHaPfLqrDfgjPVTiUHBD7h410DWWd0w5Szi6bHPcV6ZJXlWp0y2fub4T/h9URumcUppSefvWGabMaalYwi2erNF/F8sKmQvTPtSmDK7p22uqf2sfLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P5deP9TM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P5deP9TM"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 10EC040E01A3;
	Tue, 25 Feb 2025 17:49:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oakOgA1LJNYz; Tue, 25 Feb 2025 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740505788; bh=kzEStbJ6GTTg3i28u7wgJxFbqxP1ehrM8dP2IySrncs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5deP9TMhtcWrQz9LoD+TsMyEKQVVXmvFx2djtF0jSizT9RdrFA7Zid2bbxeKovZ0
	 gJJeBe5YImw5KwkTeCW8PqZ3gKXMVaOK7PmlF8RpVpzuc/icDh7FYem6yMzZNWTbpw
	 4EsGMDZquuJkQ8McbHDMNRXDJ1HlD3mouWcLj5dHT9qkq01nT35lm/4c8v/T5LvOpG
	 4e0wrmtv+Ejsj08CLepPY7B5pdlbmv4ca2haq0bpcudBINKHdZ/HBocp8egzrC8HI0
	 KticnBFxk8/d2wKJ/zRfyneL20wIte6E1sGcvxLeit3VqZueHOUeYbLixgMqqGXpAo
	 StqBHoDgkPmmg+xdhEiK5goqG/7aMPt1+JgvlRXQLqabasgMukfhwcGYwAOK3Ku4if
	 9oUvaY5J5b2QUO+ukh0eb7Z//wwqQEoisXE1cOYUBVhWNvWcCMgLWyVzS1dN2XVMq3
	 5p9xzx/jTTjl2fHq73Ssvkfaw1bPhLPuCUYN4ACaWX1RkzVGPFFbWq/QRTULZMtkkF
	 uV5fRmtQiRNMj20ocvua5BdLahRTxq2u1aHmZXcpAy8kU3IT/pDCceo05jySy2PmV0
	 5U8Bbf+qn4/dlaBcooR8hqSY45Bv0rNTwJZvKxCcoAjRIX4sBmZOR3gtDMG8S6tDPs
	 6paz5+Y2pqs+pmi9Fg3PTVqA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8C4140E01A0;
	Tue, 25 Feb 2025 17:49:30 +0000 (UTC)
Date: Tue, 25 Feb 2025 18:49:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, will@kernel.org,
	peterz@infradead.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
	brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: Re: [PATCH v5 0/5] x86/cpufeatures: Automatically generate required
 and disabled feature masks
Message-ID: <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local>
 <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com>

On Tue, Feb 25, 2025 at 09:10:01AM -0800, Xin Li wrote:
> After looking into the build issue, we think it's better to change to perl;
> GNU awk has quite a few extended features that standard awk doesn't support,
> e.g., BEGINFILE/FPAT/...

... which will make the kernel build depend on yet another tool. I know,
I know, perl is everywhere but someone would crawl out of the woodwork
complaining that building the kernel pulls in even more stuff.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
