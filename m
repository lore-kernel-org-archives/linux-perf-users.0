Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1F14A8B
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134773; cv=none; b=Uugijia/rujYXLIYyohGjFfdZrJZTaTZyM+R+Q1/FJn+Eyfrj+u3QWj32qrkrLcM4kejsf2p1XCQeLxVCfOGqRu4I0xgmJvjW3LjKcRaH7lHxlay0oMjtAvJUbU8QsqTvLVK2hK+c13UuCFI797KEwk2ZNm+QSDUuj+g/JOnq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134773; c=relaxed/simple;
	bh=uLNf0M3T40DPl21L1x7dk8jIaHBKUXNOYjdY8i+kSbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNPYl3WNsZwqicgTmZkyPowvIlxu3OkwzImeV1+xv+6Gxj4Ri+/BsaMm48O6kfE8VTyPNLwvOSxvDU/lBxnl+WtPyFi0X9Ffq1RCvd3XJn0LvGWHWeewQE110MzRVKX7oK4fyH7D2uhZbnw+2eg0nmmuU70V+X4xVE27ETxIhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqK1BV98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqK1BV98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD921F000FF;
	Sun,  4 Oct 2026 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791134772;
	bh=CGzjoGRngmrp9+h+OTQBYk71JiUSRMd+oUnpbtOnxvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oqK1BV984ka5jeJ6+IMsiwSccplxqz4q8U9rZaRRyw0wmYmNQ94VXGQna7T3SIzsR
	 n7jtMgv/5jLlbK+hE8qffQdJXuSzH9s5DxDS/kT4YQLLtbpc9xzXnKiy+OfzNzO0Mh
	 IjKrD1vsSmwrcDuBcS55NuW53/JLSM4aiNoy+FRz1scvhfG909BxxUlkT1s9klKsin
	 AjTCHgNerrxvl+Aa0ejb7dxfV7oR3GyGZbzL6QRTAkxHcqUnwA+pxQTa3qk1UwJBJU
	 MUSKxz2m+aIM52o2qjQGOKRcYgPCCSpYGfuqHxja5q8WP2YPvSrFo3gED+HUAhOLsN
	 EZ3SwCK/uKU1Q==
Date: Sun, 4 Oct 2026 18:26:08 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf/arm_cspmu: Add Arm system PMU
Message-ID: <asKMMAvyAbT5mGJd@willie-the-truck>
References: <84a65061841c8870375ee6b0621dd3f61651763d.1788970980.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a65061841c8870375ee6b0621dd3f61651763d.1788970980.git.robin.murphy@arm.com>

On Wed, Sep 09, 2026 at 05:23:00PM +0100, Robin Murphy wrote:
> Arm's latest Compute Subsystems and SoCs are using a common PMU block
> in various places which can mostly just be driven as a generic 64-bit
> CoreSight PMU, but does have an IMP-DEF register for additional
> filtering. The details of event and filter encodings depend on the
> particular PMU instance, so are left to the higher level Arm Telemetry
> Solution tooling.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm_cspmu/Kconfig      |  7 +++
>  drivers/perf/arm_cspmu/Makefile     |  1 +
>  drivers/perf/arm_cspmu/arm_cspmu.c  |  7 +++
>  drivers/perf/arm_cspmu/arm_cspmu.h  |  1 +
>  drivers/perf/arm_cspmu/arm_syspmu.c | 67 +++++++++++++++++++++++++++++
>  5 files changed, 83 insertions(+)
>  create mode 100644 drivers/perf/arm_cspmu/arm_syspmu.c

Sashiko failed to apply this and so did I :/

What is it based on?

Will
