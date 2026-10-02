Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC643D3D00;
	Fri,  2 Oct 2026 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945012; cv=none; b=MP1EQ14kkSlufS12xA+aWZoiK1G0bQfmAq0kPaDEFQwjtahlrsW5eBP6FevXUONBgOzr3MESntp0c7iJJOMi4Ly+FR+S/iayXaI7MZed9Efu64Sre6KuH32j2PUpPGOLu2vAFv2C9z86GkU09brp6UV3nUqBeV/gMA9rgscnMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945012; c=relaxed/simple;
	bh=zJcziKd1NK/JZ2DEGOXXA3DuNYQ4d2g5B9pjgV5Cuf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7ewwtOFfsGntWTXoMrxBeM62KomEK9S813tkUB7SLBUwBLpsiOLC9jo2O1YUatuL0F1L0qmdPuGC71KXp/io/f0HtRORj2n7sKZ2jyr+1NK4/2vC26wPZ4NV7DMe9ZeqZR2gJICDTii1PbgLCmNmDQhG1mD/0CdJQfa5TsgSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCtr2o36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCtr2o36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726981F000FF;
	Fri,  2 Oct 2026 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945011;
	bh=cRJpN84UVix6BcTqUJ5o6iEEWxr1NuZClp/FPA6fygI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TCtr2o36F1O/MpLu8S3DVZvnMEXNteH1EF159izrvp2NbFmzHYg/yyMwMCVGnDPCk
	 qvwN0+PMOWC97aXUjmVOOWsr10Jr46yrcaBEcGol3Ky11scrHfRRnkMGdyTXjmD6ik
	 RzLd8OYLXhBIqDBEC9ujOKGRv9KWtgQPpOA0yzNJJJOru709QUBP7XTw5qK1yhn+Ro
	 6bCvCbwjms+nzquCZXMHQQZEUcvM66224A424lehzwFH2brMyWpWPPWH7knLk1UL9b
	 /5L8tRsoV2wbh15rD+hc8Ij9SQ9a61teJdCWW1pPSHs909dGbK+SFztY9ArfH0EkJI
	 lnuXt+pa9xdOA==
Date: Fri, 2 Oct 2026 13:43:24 +0100
From: Will Deacon <will@kernel.org>
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Kohei Enju <enju.kohei@fujitsu.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
Message-ID: <ar-m7DUSMhe0euXC@willie-the-truck>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-2-4aec0b0cbe34@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-monaka-fix-for-upstream-v1-2-4aec0b0cbe34@fujitsu.com>

On Fri, Oct 02, 2026 at 07:26:50PM +0900, Tomohiro Misono wrote:
> FUJITSU-MONAKA Erratum E#030001 affects FUJITSU-MONAKA CPU
> when using 64k page size.
> 
> On affected FUJITSU-MONAKA CPUs, range-based TLBI operations
> targeting a VA or IPA may fail to invalidate TLB entries when
> addr[34:29] == all 1 && addr[28:0] == 0 for 512MB mappings.
> The affected instructions are:
>   RVA[L]E{1,2,3}*, RVAA[L]E1*, and RIPAS2[L]E1*.
> 
> Work around the erratum by issuing additional non-range
> TLBI instructions corresponding to the affected VA or IPA
> range-based TLBI operations.

Why don't we just avoid using range invalidation on these parts instead?

Will
