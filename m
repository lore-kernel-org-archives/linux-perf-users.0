Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8DD43CEEF;
	Fri, 31 Jul 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511677; cv=none; b=DJoxXdfNGVLxU9rMa42NLRm2+Nq7TlNTOXs+wmYiikMcuTuNMgLBinr/y+GPlCsOy7OjKpZWWK51e/dKJf5dJF0Pfi6/QxCkvO+TTb8/R1wsVkwm/Rps+uj6Qo4UTqCShu1LPLDWqk211WMOGKj5NKXDoOqKLHUidWq6QTukBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511677; c=relaxed/simple;
	bh=WOrILL/qcC+g2TnqPE3qt8ATp+07jRtQXLcKLB2umr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/UIKaP84MqB1aMBNHs4ZQk14ZxNW+dIOBuVtnKfoJ+TMvqB+AX9zqraFHgexprmM93hgwo8jQuqjIT5/EJwxFDKmKEKZrvhNcfgEe2lJfnRr4OGcs6KgQdbBUZgl64pq7V01rG1MIj1n6Gaw0LY4+/iLBFQRJyhhLGEatcI7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/G2Psrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/G2Psrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4BA1F000E9;
	Fri, 31 Jul 2026 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785511675;
	bh=JT8xi+LYfJ/lkhRCzd7X6UxWwkgghhtU4W+AfhVJTFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R/G2PsrwbLj5UBqI6fxnplbccH2TfJ3is2/eG1W2dpWNhFJNrcccWcQabCsK66mV9
	 RN5yQ/LdtVmoE883tZpRN1KmoqjLEgwoQ4yJRMnlxyJM1XwSECwPcjqdMYc7QHduXx
	 9FyFTxmLWomYtFbP/JtxpCvKYJ7EoeOiBb5ocYZOfWb09k9/6LGUese17ekddwMeJK
	 cqnYzYdIHKPrloDtidEOgIeLHDKF8McnAUiu4rugXFJErzOXq7f6kPfpUtjPUHensW
	 GJdsYRC8ogNosBpHJd3//l25n1/wdVcefDC7TueCXNtrmYZNC9BfNUzHK0SUN1+42n
	 9NQaaNuhsLlKw==
Date: Fri, 31 Jul 2026 16:27:50 +0100
From: Will Deacon <will@kernel.org>
To: Ben Horgan <ben.horgan@arm.com>
Cc: Geethasowjanya Akula <gakula@marvell.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/3] perf: marvell: Add MPAM partid
 filtering to CN10K TAD PMU
Message-ID: <amy-9oBsRnQd_Qtr@google.com>
References: <20260618153610.13649-1-gakula@marvell.com>
 <20260618153610.13649-2-gakula@marvell.com>
 <6b15d3fc-4b4e-4c6c-a96d-5817d7114d02@arm.com>
 <CH0PR18MB43394668EAEBD367DB4D4990CDEB2@CH0PR18MB4339.namprd18.prod.outlook.com>
 <44cd4364-37ac-4a54-a7b2-256fbad10446@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44cd4364-37ac-4a54-a7b2-256fbad10446@arm.com>

On Fri, Jun 26, 2026 at 09:57:44AM +0100, Ben Horgan wrote:
> >> Where is the user expected to get the PARTID from? The MPAM driver
> >> considers the PARTID as an internal only value.
> >> …
> >> Perhaps some helpers along the lines of:
> >> int resctrl_mount_generation(void)
> >> …
> > Thank you for the detailed feedback — the concern you raise is valid, particularly when 
> > viewed from the perspective of resctrl-managed deployments.
> > 
> > However, to clarify the intent of this patch: the exposure of partid in the TAD PMU is deliberately
> > a low-level, hardware-facing interface, and is not intended to integrate with or mirror the
> > abstractions provided by resctrl. It is mainly meant for platform bring-up and low-level
> > performance/debug users, who already have explicit knowledge of the MPAM configuration,
> > typically provisioned by firmware or other privileged software layers (e.g. EL3/EL2).
> > In such environments, PARTIDs are known out-of-band, so the expectation is that the
> > user supplying partid is already aware of the MPAM IDs programmed on the system.
> 
> When this was proposed before, [1], there was feedback asking to
> document how to get the PARTID.

Yes, please can you update the documentation to cover this? I'm not
necessarily asking for a programmatic way to do it, but even something
like a reference to a document or a firmware table would be useful for
people trying to use the driver to profile their workload. Otherwise,
it's just an opaque id :/

There are also some comments from Sashiko to consider:

https://sashiko.dev/#/patchset/20260618153610.13649-1-gakula@marvell.com?part=1

Thanks,

Will
