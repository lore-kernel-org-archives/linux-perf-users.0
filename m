Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C944F566;
	Sun,  4 Oct 2026 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124943; cv=none; b=pwnYQ6kFBl2qM2sKF4ygXAkbwrbl2s5yVbiBJTYDQ89Ehf/eh8VzaUCGiZ6WdTFqtnw8QUQgUGccmRNXoouP39uALUI4Wa/dD/IxI42yEZvgKmUIT7xWUporyBEG6HBJ1aGvqHYAjAxg+YwkPVjycqR1Z2ah0eZECh3zwrq0pn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124943; c=relaxed/simple;
	bh=861B7KisRoEnuGgKSaFG2Bl1xQ2wZwsWM3a/yivOowY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0YTIxKK1RvVJkQvIOpjhT0ziZTLn2tjKuhhfq/1WT5iKcYbVld5e1uiRDg8jcHvWsj7BHsJScHDCIjI4kMeEdxVsoXXkArdYkzxOlKWHgCyBD4vzHtpW1Upcw9BhBarQUu/DSqr0jkNrJl5+Gk/p3IF9+0G7NGTN+4QyuXbpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3HqrvE4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3HqrvE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC4F1F000FF;
	Sun,  4 Oct 2026 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791124937;
	bh=jxrMNZZf0uYmFShF93RemPPEWrIzfT8gXRg7Jp/sqWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H3HqrvE4zEtzmEYvRqiUgJpInpC2o0qkiz5pGtNOBwR38g1jGRdJFSNEfxsZhXsA4
	 PbbF4Y8ilbs8RXzz60z7hTAb2taXmRtPC5wilbEeUBqmlko0vI/fbbdixDWrQJRFU+
	 Fu1VJbs2XTmnNOFCVczLT42yNaEm8IDoAdDLDT06w86EYgpUk0owc6VlSNBTRoG5Ey
	 4Is1aUVnxezmyvCwww9FNLlr/FmKLUGRkmFnQgKP+rAs1vjaYdaCF2ddNbdseCaSk2
	 yQQUrEI6aYp5eWkd6oFlDZFIkt1KWP0lju0LtxxMXNq1RMCNFrZ5iQ11nDBQv6TJV6
	 f+eMexcB8PEZA==
Date: Sun, 4 Oct 2026 15:42:13 +0100
From: Will Deacon <will@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ
 lookup
Message-ID: <asJlxV06xzDIgqW4@willie-the-truck>
References: <20260811041934.7609-1-phucduc.bui@gmail.com>
 <ar_fLAeFU4rmrwiH@willie-the-truck>
 <CAABR9nGqwTGcrr6bKsV5+0GYwkQoP0s_Tu6aTJrhJJW_ZRqFYg@mail.gmail.com>
 <asCyI2_CNSoDJy1w@willie-the-truck>
 <CAABR9nH3pkFB-htyrD-Z+iBBcYoVX4Z-hFa_binWCXg9_cHU6A@mail.gmail.com>
 <asISGdljsG86gUwb@willie-the-truck>
 <CAABR9nFMR+D0j5kYR+HwLBOHG4WF7PUDrqjE4Bt0-VTUacxmBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABR9nFMR+D0j5kYR+HwLBOHG4WF7PUDrqjE4Bt0-VTUacxmBg@mail.gmail.com>

On Sun, Oct 04, 2026 at 08:49:07PM +0700, Bui Duc Phuc wrote:
> > Sorry, but how is failing the probe possibly better than continuing without
> > the optional interrupt? Add a diagnostic if you like, but aborting the probe
> > feels completely unnecessary to me.
> >
> 
> My understanding is that the driver is designed to be generic and
> support various hardware configurations, some with this resource (IRQ,
> GPIO, clock, ...) and some without.
> 
> If a configuration describes the resource, it means the board is
> designed to use it. For that hardware the "optional" nature of the
> driver no longer applies, so if we fail to get the resource the error
> should be returned.
> 
> A log alone is easy to miss, and the root cause still has to be found
> and fixed later anyway. Failing the probe makes the problem visible
> right away, when the board is being brought up.

If you're doing bring-up, you should probably pay attention to the logs.
If you're trying to use the device, you probably don't care about the
interrupt.

Will
