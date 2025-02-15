Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77EE56C;
	Sat, 15 Feb 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630694; cv=none; b=lbZf/1z0ukG6UbdZ1lWPqtgH5TWEMJyTYHGla1z2pS4SleI8mLcZYwlZwqMwIFRdcE56bgwcGci9CG9IRs101Nmup1Ib79pUZhvgDHtcl802pFFPQx+hhNQoFCcZ+L4nyGpwRcHjdnWM0enMpt/l4tvFn/R/twz70ad/S/A/xlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630694; c=relaxed/simple;
	bh=svlFGVVhjKFB9Em7Mi6H1dBmzJpragRWaSONCrliaqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAXEnUxtxq+v7iftyOGj4Vul7+RQsZ86jSEmobkIDPlDFEwNCpxOV39pBKmOqxwSJgCj3KRUYdMmQvtmOczDNEp3QRzcUtqJD9C+l/SQ3zOOXmQwbwTpKj0k1I8qo5QGRpQn/u8+IAPMzfU4jIjmUgOh4e1JPzrMchWvTwLsIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AGUjcw6V; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AGUjcw6V"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EB71140E0028;
	Sat, 15 Feb 2025 14:44:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QS2pJyruZGmj; Sat, 15 Feb 2025 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739630686; bh=rM+HUZmv9x/yWQiAsCsjATK0g5p2KbrCDJ2KzSzNRQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGUjcw6VXaJ2SLEIEbLUF6NSxJgkPp0HVhWW+opFWjUhrvD2+m0psE461dXOyRg2A
	 b1urVVjrx/Zppe7+m0vzeWr3aI/uWDsej4CUcK6z389gnCalxrlZAqNpFZtmN4sp00
	 mLKoqeb5TybelVBV+NZ6d0N/XkEk/3NhEo/sZQvCgPcZG32nWt9kbpL63tGVMbLpQK
	 0dSDBMsvN8wHD0KMO00Iba37/pBbCD/CYnQpE8I26xS10JF7cS3XYXRqCO6fwD4Acm
	 qy1bpEINL+cRu88wXjXdOEpgTqmU9swgURbtnjhl5gmkrQG3LbO5BXgo4xejxH6PIk
	 j/t/tkDQcruCdk/YSLP2mA5DgAPo5qtqjy4pHF5zHTpNf66Qz0VMGigub/C9wtAycx
	 6rDI0jlkB90lCumUvylgR0asBosM9xrGEuRuUg2zruesNeZtUR7UMHAIefafKmeVEI
	 SciC7fVw2TeMqke/eyxrlhcIJAYZBmbpPVCISpqYgVJQnoe8aZSjw7D9wIIcbiysdi
	 Tb3avrdsxTvunn02Dk9KMwnx0aHU5c+XORl5i1zmeIa3/HjJgM9YgZOrU05OBufO03
	 ugoSPruoYhCitwghdxLRTUM0t0VhTgp+UrUrLAxC1gnF2E/Hz5NKDU/4aGsxAGv3El
	 3CtD+VuMkdpVC5ChFs2nBhsk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCE4E40E016A;
	Sat, 15 Feb 2025 14:44:28 +0000 (UTC)
Date: Sat, 15 Feb 2025 15:44:23 +0100
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
Message-ID: <20250215144423.GEZ7CoR2O3FOKQgfVH@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
 <20250106070727.3211006-2-xin@zytor.com>
 <20250214215823.GEZ6-8f5wt--IWggtl@fat_crate.local>
 <469D0BEE-76D6-4417-B5B0-0054D3F96784@zytor.com>
 <20250215142017.GCZ7CioRHgpm6a-eIZ@fat_crate.local>
 <3B96E82B-7AA8-40FF-9401-829D408AA790@zytor.com>
 <20250215143032.GDZ7ClCJzyDkuvQSJp@fat_crate.local>
 <6187A454-B995-45A3-8356-ED7CBB4E478F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6187A454-B995-45A3-8356-ED7CBB4E478F@zytor.com>

On Sat, Feb 15, 2025 at 06:35:52AM -0800, H. Peter Anvin wrote:
> A bunch of flags in Kconfig.cpu have exactly the meaning of "this CPU is
> guaranteed to have this feature."

... and we won't add new ones which are required any time soon so we might as
well make the required ones really be called "REQUIRED" and have those defines
basically self-document themselves...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
