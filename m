Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BE38385;
	Tue, 25 Feb 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506482; cv=none; b=Fw7IP8FBGP3nYMSi24UNwTlvvc7Mz6F4J/Az359PQkGenXfnbO8zdRgM629LeJerJT9nmyTYHYhejrqqv2FX4WBOvXT58qaKcRjpSUdstH3n69Nget97zAKqhSLdB0qrH+YbqUMKJ7B4EPOvx3A1sm9AnDzH8zasqSVCr206tgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506482; c=relaxed/simple;
	bh=OaUA5KG7GJsiLn/eX1jGar3uO3VKFszWeLehSmVHy4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2IRxo+lXvpDpRyYMY1x7Da6yOqnHSpM1iziTwSpD9rl+1OCeaUrJkfYHGXUPhvBV9FET+zWiwjmlHe2QCKAsRfckUGo5FlMrbKtwESGs7elLPAXUGmtS57H3jZH4PmzZ5qrM2l8yfYxikrGFqXlBtsrw5dnfSyg3zh+sYLluYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ONTjA/tD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ONTjA/tD"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 46AF540E01AE;
	Tue, 25 Feb 2025 18:01:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aGpFAGBqRbPm; Tue, 25 Feb 2025 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740506473; bh=kPJ+m0qviqj+7KaVjxLrm03uugK9+y0F+hSfBBTxARk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONTjA/tD1lmTgd8BFl0JvFTr/SJJbZe3lSBv/alcgsQFlCGPBCUEdfS+0+qAWPmUI
	 d7bvinqoSWlXJO23l6JayKRYjxrFLNO249GmLLa23gCtWh9xd3KuiyukFVVpgzblDG
	 3pQq0G9uLowKV9K8o1aQI3EoN0HxaH+GjT6T14qTnB5cTh+pG+FgIK358FbVRR0LWt
	 hCfn8GuXjR1+7vesTuo98CD4CRVsUJ8W7Xh1+qRYzU+KQZq7qn5AU7OASyfQpTrG3F
	 x1NIIXuq3LpC393nF5Z3aGGRosaZkM6Vk6NCSfBx6SGv/Uyt2ZSnOyObiNO5UL4wHK
	 pnVZEmj8WNFKCPYk34NyaS2C2gw4rHc+wSHbanxSaOIzKj7aJzAlA6pHDiaacEue1z
	 q5DpbaCgln5+rrBXEnhFU3T8Vjke5ImG7OEmCJyFcm4wzqT9Cw+HVHmx36+O5szX2+
	 TsqlCtN8sil8dmvxChF+8HZ2fSc1NaoK8WxcX+TwI3YaspdzL/qkxNQJVvHlk24K7L
	 lPMJebnhC8NPhhvZfMOWP2Y8gVyY5Nvj48bLell9fDOYhQQt09AZMHix4n69H+q8w2
	 W2YKNcls5fdFt0CzuofkGJbjVvTrVikINSxAuCbXbssYWmT3Q+vdiR/zBzc/60dzIQ
	 IAOz34ljBa0P/uijUuewS5Y0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 367DD40E01AD;
	Tue, 25 Feb 2025 18:00:56 +0000 (UTC)
Date: Tue, 25 Feb 2025 19:00:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, will@kernel.org, peterz@infradead.org,
	yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
	namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v5 0/5] x86/cpufeatures: Automatically generate required
 and disabled feature masks
Message-ID: <20250225180051.GCZ74FU-PrcosEHZb1@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local>
 <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com>
 <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local>
 <8973bfd4-d8b2-4dd7-ae1a-3f685dff769f@suse.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8973bfd4-d8b2-4dd7-ae1a-3f685dff769f@suse.com>

On Tue, Feb 25, 2025 at 07:54:50PM +0200, Nikolay Borisov wrote:
> But don't we use perl even now:
> 
> $ find . -iname *.pl | wc -l
> 55

You're searching wrong:

$ git grep -w perl arch/x86/
arch/x86/crypto/poly1305-x86_64-cryptogams.pl:1:#!/usr/bin/env perl
$

That's some crypto-special thing.

This'll force it on *everything*.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
