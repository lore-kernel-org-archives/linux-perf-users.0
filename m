Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCF3D25C2;
	Mon,  1 Jun 2026 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326449; cv=none; b=kX3GfDKfoOK1RnfSuRiEUIOWzPLLo+zrjqyRn9hp2s2S8O2r65VhI+sv5h3xlAaDzUvfJjy2vQMGJ3ePnsIZHylt90FLMhZezUlNK16b9ST5K4S6zdQB0CW8Oj/OGHyAyduaK2jx3v0/nw/BW/5WaIvOeS89oofY/P6dyZ9AtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326449; c=relaxed/simple;
	bh=6aSmQBQrT0yCwbfLZvRvivDWc5N/EECOQXClydgUcL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNmYYpWCYpdKirJIadFgQYfjDgHn1n+gUFMWVajbP3ETS7qCnJcV+T6Z+Tg3HCYeN9Zw605s40TtZJCmzl46gTQAb+ntsmmxrJ9G2odg7Q2VT0QLA67efRZ04MlWjNwwoghrsCci2A40oClUJ8lgC/HpRJRK97PH/jZoPTELE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/31by74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/31by74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223881F00893;
	Mon,  1 Jun 2026 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780326448;
	bh=gcTAWBNvqdXkfD29QAq7nzgqHlhaPiOnHfi0IMSEWoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h/31by74JtvqeAok898sE7u6ct+ZlsreTncTkVXMC192uEKtrrmLDOH3MlL58iI25
	 NLSB2FsjFiygFgzdH0E4B8dPVp+KS2JutTKb0PG7mIxGKNn474CUF8k11MOL95Ioo2
	 8nSkqQ6MY9X4Jx6VcGF66QomhmKEk8sQ0xN+6JaeTFsmdMuFEcx+m5TLjuEDYnbOrV
	 ShfxIpbl6/GuwefkbBR3GFGxwNF3x5MB7Vv+SS0WoD+6zYCEJ++ZkfJvELIcEzoc4u
	 1+8VXRIuKzskEZm5T71AleovmqkMsCXMLNtYo/awfJG8B+v63NcGw4e83nQdxAEINz
	 nvJqNqzIZeARw==
Date: Mon, 1 Jun 2026 16:07:23 +0100
From: Will Deacon <will@kernel.org>
To: Saurav Sachidanand <sauravsc@amazon.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	aghayev@amazon.com, juew@amazon.com
Subject: Re: [PATCH 1/4] perf: nvidia_t410_cmem_latency: fix cpuhp state leak
 on init failure
Message-ID: <ah2gKxlr8mBSSg9f@willie-the-truck>
References: <20260514010629.76558-1-sauravsc@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514010629.76558-1-sauravsc@amazon.com>

Hi Saurav,

On Thu, May 14, 2026 at 01:06:26AM +0000, Saurav Sachidanand wrote:
> If platform_driver_register() fails, the cpuhp multi-state registered
> by cpuhp_setup_state_multi() is never cleaned up. Add
> cpuhp_remove_multi_state() on the error path, mirroring the cleanup
> in cmem_lat_pmu_exit().
> 
> Fixes: 429b7638b2df ("perf: add NVIDIA Tegra410 CPU Memory Latency PMU")
> Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
> ---
>  drivers/perf/nvidia_t410_cmem_latency_pmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Do you plan to respin this series, taking into account the comments from
Besar and Sashiko? If you do, please include a cover letter next time as
well.

Cheers,

Will
