Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FC1624C4;
	Tue, 25 Feb 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507384; cv=none; b=NnXJHCgCfgyrNzQPBWvQcMVfJNNm29SANb2rKq7BXoR918xcYJ2BBpEgAgLiUtmkrHBc9ELRhjdPqnAsuxPqEsouhHectrkv4hRPUwGb7xToqkDWdPXMRxejvAPk4N6pB7XNJd9DhZ8Vlzm0eO7dVKmlS/PywLmdT7LAOPSF2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507384; c=relaxed/simple;
	bh=EiM+IRqJW37+Q370Ais7KQH+KPwU0Yt/UC2yATI+0r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyzrzqgDT+7+wNkwzEWUnd7UiqReuhuiRpDG78sIvRvvbgEuM/lafqHChgKeDP7zShN53awhjd9iUslRjEbheqWmVRItSHm781XvRyY2NQIru7dnr+mvbroHM7cu7+2uv4+r9Mw70rEvnQ91UotFyGr+v+14+o+3We6iTpvBvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KkT/l/wK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KkT/l/wK"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8EBAE40E01A3;
	Tue, 25 Feb 2025 18:16:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bM9mfa9lxQvN; Tue, 25 Feb 2025 18:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740507375; bh=b28LyVDR+RzbOR0w9OJbLaVHwswLfwBFg0oHpDNuZU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkT/l/wK93/Jh+5E8h0q280qRFXiSSbt3lCVDxE+e+KDqu2brKSN6ckOIk8uE33PG
	 X+vpz99VGIsXqdu/fDHo5BCID9ke8MdR0T5Xf/sBnLHOpu481c0iyyuwoTCG8K/Cf1
	 /anYXjEd+IsGvW/4/x+oM70F42MvdWxpvSAu1h55wdbjb6XBwxtk5Fam3z2DY5TlJ5
	 dOPHVxavdPxb/D0YL9Rtc5G1hVGSDtMnIaOZHLoorTrO/o9f+MPZktoDxE+dWLIP75
	 TE2scOSFfFVVcjTUcsAEQLCmPiq2zRyP3CfwIZCWBcfExorB5ijK4qVAfFA/W/1GT5
	 JI4rpqWCnLsoZG92ieShWP14kaD6gZz6AYSafYRfZLgocNTkl08e1JFRLmMyLwugiQ
	 nKD6ejkHY1mA7vze9SIjzJIAyXPi9kln/XCPrCoinu/Ht9VvgxxFp5WpScAGFcN1x7
	 3LRZWGqmXcLkho7iKPpjcJvpCxc7RpGxGpGuHQEbkIOt6y/AQOfjE8D2jBA5/Kt0qW
	 bKVdiZA3tlnLQWV9uG0ViwbmwcjRT84ab24iUuo6TomZboTfNzvp/JWqQQ4Qf602Dl
	 vYdNuXJI0mtdlmZ5h/2SzxyPXyE6sWy9Z3Y3th/D3kBJGU/nQJLVcIIhi+ROP0u4ZP
	 7AIN/YSAPoEjeM2UNcZFNF0Q=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7AE7740E01AE;
	Tue, 25 Feb 2025 18:15:58 +0000 (UTC)
Date: Tue, 25 Feb 2025 19:15:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, will@kernel.org, peterz@infradead.org,
	yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
	namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v5 0/5] x86/cpufeatures: Automatically generate required
 and disabled feature masks
Message-ID: <20250225181551.GDZ74I1we9xqM_oj-b@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local>
 <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com>
 <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local>
 <8973bfd4-d8b2-4dd7-ae1a-3f685dff769f@suse.com>
 <20250225180051.GCZ74FU-PrcosEHZb1@fat_crate.local>
 <A8B4322F-F298-406F-8F84-9151FD3CEA5F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A8B4322F-F298-406F-8F84-9151FD3CEA5F@zytor.com>

On Tue, Feb 25, 2025 at 10:10:03AM -0800, H. Peter Anvin wrote:
> Yeah we had that debate back and forth. Although I personally feel that any
> sensible build host would have or be able to have Perl, the consensus
> opinion seems to be that if it can be done with POSIX standard tools or
> host-side C it should be unless there is a very strong justification to the
> contrary. 

Right, Xin, please make sure you put this rationale in the commit message so
that people can read it.

> I guess at some point that will add host-side Rust, which will be fun since
> that adds the whole Rust user space runtime.

There's that too. And that'll be even more fun. I can't wait for the
compiler-specific workarounds. We're having a lot of fun with two C compilers
already but who says we can't have more?!

/facepalm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
