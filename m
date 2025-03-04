Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AC1FFC4C;
	Tue,  4 Mar 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084187; cv=none; b=WZL3vqPFPzTTpoEiuy/q/M/AAdxAB1DHmrmKhN6F46eh34HoaAunYUG1KNGjRXaua1vn3fZq2pud+Ll52SPhFNBs5c4oJAn2bcKU26Ca2LUhJOH9OVykAQQISPABK7pdrsCHNM5T64OwWrb6H3EuANNK4TJpXyXRhDv3sRkY+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084187; c=relaxed/simple;
	bh=pI0HJfwpbAZaW1922lZNHz2lBW0wLacOGRUyghQ1l8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0ETrgZGjt3ejxlk5Z4etOpntsgWluLtcZL89E2P6GZzhP/ihfnRa2tndjk1c5b8KSK/ALwSZDVZth0eYh9JECiobDTJTNsEtk/sPFlghw0uIZIZlwzaWSE6PyqpwIABJt2GED5VcT7tH4PuYAiFDQf9fYHxnakCpvSpro4u0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UILNwCCN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UILNwCCN"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E98C840E0216;
	Tue,  4 Mar 2025 10:29:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CAE7udcNv7Us; Tue,  4 Mar 2025 10:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741084175; bh=qp7g7t4g+xuD39/na+PShGGbLo7cwlzyR6sGXzc71sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UILNwCCNd9Yu8FvBz86+UZarp09ZZcfFagyUDl/8edLiIlpQlmRUqRzgIoha8fKDl
	 lvbJlwoFqHAJZZHzxppxwaFEnmGdX0gZHKkTX1dmxGWHusbqPcYXK29pN2wpINDXq4
	 ApIFUwU7Xa5LOewX0pUFeYpmyFyudevUAMz2E/X1esTrV5VVRY6OONZpkJVnGgKrLf
	 avQm7q9gdu7tq1AB1YuHXZ0ztYX6sqrE3bq87zIOCd3o6wetGbLAZgH8B7sCaakdz7
	 IMbLU3QIYYjEIRE347rkaF26V/QyRn4zLlm+fRfdoBQFAeXVNSKNKcxLIq+2Qit9LM
	 ZCOygS2slQyojNuY7ZQ13ArM9jRSKg7avhD5aRvHFLYfzPTfebKBLjnkSsH+EFNlAN
	 llE/629/EtehYezxEgbjkPlha13VZJc2uniFpuy0Q+fIMfwwj6Ybns/O20HwFZK1Tt
	 kGpYy/wpq0z984cHsxS4hnTrSjKeQHNnWkLK2ARC5FtkSuWD0hL9r11RgM8EEC0haC
	 caQGFKc8CZe4mWiJVOHPNktH+rH+ioZV2SSoSBMciAZaWv9UnMiRGyGK/tc2InFYok
	 l1VPnIH8/FGbLELfwxqvUEbpbJ0BMO5sLPrSansDNSCwhG7m0A4DwoTIwnWjeMszkY
	 afdelxI8J/2GjQcI5LYe56kY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEE3540E0214;
	Tue,  4 Mar 2025 10:29:16 +0000 (UTC)
Date: Tue, 4 Mar 2025 11:29:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin@zytor.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Aithal, Srikanth" <sraithal@amd.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, will@kernel.org, peterz@infradead.org,
	yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
	namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com,
	nik.borisov@suse.com
Subject: Re: [PATCH v6 3/5] x86/cpufeatures: Generate a feature mask header
 based on build config
Message-ID: <20250304102910.GAZ8bV9hXqVb5tA9rs@fat_crate.local>
References: <20250228082338.73859-1-xin@zytor.com>
 <20250228082338.73859-4-xin@zytor.com>
 <7c3b4623-45ea-4340-ac47-334071c1d15f@amd.com>
 <D03DAFD2-5EC9-4D16-BA66-FDA4B51F45DD@zytor.com>
 <20250303132505.GEZ8WtsXqFpuMOpDjT@fat_crate.local>
 <8e4e1723-321a-4e8e-bbac-e2e5d8b08bfc@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e4e1723-321a-4e8e-bbac-e2e5d8b08bfc@zytor.com>

On Tue, Mar 04, 2025 at 02:18:51AM -0800, Xin Li wrote:
> It seems that 'archprepare' works, however I'm not sure if it's the best
> choice.  Any suggestion?

Why do you even need featuremasks_hdr as a prereq?

I still don't get the dependency there.

In any case, you'd have to redo your patches - we've zapped them from tip.

> Want me to add it btw?

Yes pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
