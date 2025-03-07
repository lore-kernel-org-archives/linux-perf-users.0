Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A52517B4;
	Fri,  7 Mar 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375149; cv=none; b=R5q7jUy1dOnl8MGcqUnYYBND7cg33U+cuI4ID1MOORcEsWg7oOSB5UxwZOslFaDdlQLwGFvsK8GY/vqYHWVy3XVmHU9m2Ck01ZICDdPeipWDNedetTlPpfvyoDww2FAsuyZri6CAjEGHSv8w+JAisRGy+bIxBTvFMcW+P/5CrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375149; c=relaxed/simple;
	bh=3o4gKXJDIHgmAvWpcDkkYgG9LXNWEgidJjvzU10kvm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRI/xYuvAALGDYMq5uf2+YlfLd2eG039j8uxDjSyRKNIKkJWm1NCOG1+UYDGugavp/wtbDwu4IKl/PhILFXjA8fsfjqdlCgLCDMnQx6kVXmRo8FV6HXLzj0sqv5+n2YF7qcxV+BljClViabOEM0/3Fafm9YkwhrA03F8G4VZegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lz/gbSs8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lz/gbSs8"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6B72E40E015D;
	Fri,  7 Mar 2025 19:19:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zvYFGKxcmHP9; Fri,  7 Mar 2025 19:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741375139; bh=JNCKMRJVqSwAHC0eoKKiW3t/AjtW80g4cyMSaZyXr7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lz/gbSs8i/be7YUZvbfZrizPx/0fB3D1JN1GguQu/qZ7PBchjwhJk2U+4gfZXWN0O
	 3phFen6jb0118eiFdR4J5rKYbSshtIO5LwQ6Hr5gkrQpoy1/O5/iLFVkE4iMudyK3x
	 deotLNimnpqCcoj24Qwxg+EkUTsmbrP+r5/aYYalLqK7fys1G4ifmE9A7Exq6XU8y0
	 RspaCvlSTMIeBVQxs9FGIVm3bdgMp+c9zudViFHHOORqVkU/5d/nncpgDTYIHYIqJh
	 bvsn5NFASR81fVQ7b7NHn/Q3IQEHUBAaZayfRuJO6YbSOEo+0tajNO2wqPDuKqY6mz
	 JOWavsoDIU2IQ1SXIKJZRmw681t9h4/6dphx8YssCYUUFhhMQ/N//6uYNj+udQ8xb/
	 gfTt9vxdZsfXJclVsX1z5ED+64MrogUFVobkIlZjmZqJdwD+lLd+Okycv0bIZRtorJ
	 apjD/IeWSejDKHBxd+g6Smu42MAOWdD93stnkrQJAyNM8AgxCvS4HFByYMwVMaA8Xn
	 D7Qvdwz/QyU3YvI87YO0OljR8RCAi2k4/NuEx3y/8PnDTZj4cCvIB9MO2kYIGJOI7k
	 GVrg0PJ6Rc4ioJ7jAredqpHdre32KEWpPJgm63O58AxPXtSDeK4TVfXJe4vp+eBRsT
	 6VVL1qdrxZ5uD+KN8dkMm6ow=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6C0B40E016E;
	Fri,  7 Mar 2025 19:18:39 +0000 (UTC)
Date: Fri, 7 Mar 2025 20:18:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, will@kernel.org,
	peterz@infradead.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
	brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com,
	sraithal@amd.com, philip.li@intel.com
Subject: Re: [PATCH v7 0/4] x86/cpufeatures: Automatically generate required
 and disabled feature masks
Message-ID: <20250307191832.GAZ8tGiKty2K-cl1LC@fat_crate.local>
References: <20250305184725.3341760-1-xin@zytor.com>
 <4b44eaec-2c45-4a68-80c5-6a8c0905b1ab@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b44eaec-2c45-4a68-80c5-6a8c0905b1ab@zytor.com>

On Fri, Mar 07, 2025 at 10:28:56AM -0800, Xin Li wrote:
> I guess I don't have to rebase on the latest tip/master and resend it?

No, you don't need to do anything for now. The patch tetris pleasure is all
mine. I'll ask you to test once stuff is ready.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
