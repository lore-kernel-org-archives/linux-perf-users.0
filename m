Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363919F43A
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314671; cv=none; b=HKFkf36DXIsH3DYCoPgYwNi3Uw9aFBQhjdwPdaBL62hwQodYTBFPZiA6xbXhA1asHZG1bwb1hOIw5yuhiEBZk9Ei7NFuX2xgVLM427heP+3aW5Zjsg683MlNOgODOyQy85S8jsXG8x8Xqg5GK9NP3t6sF5XGJbHLHlKy+Tz0nT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314671; c=relaxed/simple;
	bh=+fa8DsdkVEv2EwfFN1t5sni/y+6veh77iQj6yymkA8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4kmsEmgbmqHQDMfB1racEwvDQTJUOeMDmSnldVWxlpEBBCQ9MoFCt47qCuu2kj816BcJV8COReu7FiSAo5z0R9ThLcw9oD//xcW6lwzj/iDgYu5WkiSWILizuajRaVMF2to8vXRiGGjvAwTzizudu0H1i4+gmW3LT4pFCS5dTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKuiv4fq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKuiv4fq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D34C4CEDD;
	Tue, 18 Mar 2025 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742314670;
	bh=+fa8DsdkVEv2EwfFN1t5sni/y+6veh77iQj6yymkA8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKuiv4fqNVq8iSizhXj59I6aunnpkEoeQzB6FQxsxzyV68p0P/5FlST6roMo6um2g
	 ZaqgOZ61tv2fpOwxMiTpqxIG7pZF6KvXpEijVZtqvsCFe84fC3mExU4ZN0Gt/zR2BY
	 UWdGqBcfKODPmCxO1mu9MEf1Qrm9ve2Kjwv2b56FIHTMsOVdiHLZzdsslcnLZsC8dn
	 JPD7eUJ+/MAPez89CCF1g6TdJjl8a6lsmyEY8IVPp/ZNpf4s8KWr3Vg5kWjcWIPTt8
	 tS7JoD8BiLkm2N6A7D7wccy5YHvDjOTby3QQkH+ctda4BlTUj+9x7OxBqYgRmgxsfc
	 3zsYLSsdA+2wQ==
Date: Tue, 18 Mar 2025 16:17:46 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH Resend] perf/arm-cmn: Remove CMN-600 DTC domain special
 case
Message-ID: <20250318161744.GB13981@willie-the-truck>
References: <67985e39f53b56385d79a4f1264cf7f9cacedb58.1742308248.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67985e39f53b56385d79a4f1264cf7f9cacedb58.1742308248.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Robin,

On Tue, Mar 18, 2025 at 02:32:10PM +0000, Robin Murphy wrote:
> The special case for trying to infer the DTC domain for DTC-adjacent
> nodes on CMN-600 is fragile and buggy - currently resulting in subtly
> messed up DTC counter allocation - and the theoretical benefit it
> offers to a tiny minority of use-cases arguably doesn't outweigh the
> inconsistency it offers to others anyway. Just get rid of it.
> 
> Fixes: ab33c66fd8f1 ("perf/arm-cmn: Enable per-DTC counter allocation")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 7 -------
>  1 file changed, 7 deletions(-)

You've got "Resend" in the subject, but I can't seem to find the original
posting :/

Please can you point me at it? I just want to make sure that I'm not
missing patches, as you're unlikely to be the only person affected if
that is the case.

Cheers,

Will
