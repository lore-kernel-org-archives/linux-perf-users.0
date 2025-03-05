Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8BB2E3373;
	Wed,  5 Mar 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212330; cv=none; b=m/M6dDhiORfs0NL5wRKwh+Aj/Cygb7VvQ/gy0myDfqPmhg6XvubJBYSSwiZDTqYVmDWakkmGLFSVKvHAdotB+WM4JvNVHWp91bsQ/clITVjoZ31cJUxPHwD1MI6LduzKl4n97EEh953IhF4vTRpuAfei5CbjENwustkoPTmzWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212330; c=relaxed/simple;
	bh=nk43jRPG4HxwxrAkYuKCP1/1fzhaDbT3IZUJjsXXCcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6oG3RmbszLWUPL0kYE29RmSDJ14KBB6N07xQyN4yO5De1QPBqJREBTECoSNuoK6OuHGkXYWfRMDTIaU+PfibyLSaqRQKSItLG5FoGGXNvfter1m5T3O1UUh4GnJpb6tX5m6+xQcmQaf//mnY2uYcFQHnqSbjt243vKLWGFI2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Yl/sheQb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yl/sheQb"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C4C4F40E01AD;
	Wed,  5 Mar 2025 22:05:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eUD_dT-Va6G2; Wed,  5 Mar 2025 22:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741212320; bh=L2EtB9RnMQVBdYp1blmWqfC0w4I+Gww5BLhuAn1P51w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yl/sheQb2ZeX2YdAUJvfmKzpa1KyJxSAB+UCLdCBl9zcdg2IABVpiFAuZSYnXqNsc
	 sIbzg9loTXOwJa5zztnq9QljHkHCgtIciIZu1kVNLX5hfezZCX1Es2S+p12kHeq2rh
	 2lgNWk9Jwan2Dy4xpfTDjUxvnuGbNgE8HCSzI2XdnD0YhgcEBIOj8wny7b4Cxntu7/
	 Xvy2Y5PmKn36Ldkn00QBpj2SPGBk7MCV9rZuXdX0Vsc90n34xNcXH171w7mukTtz/D
	 hUp+R7Bkq4ul6E/+VhsVqasaGt9sBCXDiKnk10B2+obdts3YmGtFwqiEMiqZdq/OcN
	 Rk1+wEFGvmqtT+YLNishhoW14xWqH0e2eZ/N2MHFatrG5hAcabvFqLbtd3mnWcCENF
	 /mMcRxpATcebetlz7+lO8pkz+uSdJ3iVnzBoo9CfdzLLCYq7NDPW7h8O5exYegnu7o
	 C9lqm3VuRgLFFCauWTePnCePjVsVhCWQntQNuyafUwYICV474eLiX627YX6rextdJf
	 PvOt9Ka8/JljIvSNNt91RiH+CYZIalAuqqCBF9aX5R7ZPE34jglVPmGILPkFn+WLQz
	 hfWVlTrFGCxh+TgqJVvNsOYpP/sQKDPJfw6nT8GWIaHQoxo+8a2ZbcviC/EJjYYkhf
	 6+WerqCLRG6ZE/IudCQfUm2M=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7F9740E01A5;
	Wed,  5 Mar 2025 22:05:01 +0000 (UTC)
Date: Wed, 5 Mar 2025 23:04:55 +0100
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
Message-ID: <20250305220455.GOZ8jKh4bGqplm2UhF@fat_crate.local>
References: <20250228082338.73859-1-xin@zytor.com>
 <20250228082338.73859-4-xin@zytor.com>
 <7c3b4623-45ea-4340-ac47-334071c1d15f@amd.com>
 <D03DAFD2-5EC9-4D16-BA66-FDA4B51F45DD@zytor.com>
 <20250303132505.GEZ8WtsXqFpuMOpDjT@fat_crate.local>
 <8e4e1723-321a-4e8e-bbac-e2e5d8b08bfc@zytor.com>
 <20250304102910.GAZ8bV9hXqVb5tA9rs@fat_crate.local>
 <81677e85-ff7f-4986-8e0a-6bf54a63ba49@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81677e85-ff7f-4986-8e0a-6bf54a63ba49@zytor.com>

On Tue, Mar 04, 2025 at 11:30:43PM -0800, Xin Li wrote:
> > Why do you even need featuremasks_hdr as a prereq?
> 
> I'm not sure I'm calling it a prereq; 

That's what this is called:

https://www.gnu.org/software/make/manual/html_node/Rule-Introduction.html

A prerequisite to a target, latter being "archheaders" in this case.

> Sorry for the build noise.  Ofc they should be zapped.
> 
> BTW, I'm asking if this build check could be added to Intel-LKP.

Good idea.

> However it needs to change Makefile in the root directory, which is not
> maintained in tip, so I will send a separate patch to KERNEL BUILD
> maintainers and list.  Make sense?

Ditto.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
