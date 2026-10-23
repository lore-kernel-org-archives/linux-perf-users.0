Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772398;
	b=nWuSiyWKng1zeFK4yAtJEs9rF6gt9IS6spxu4pCkcauvQD8ZRLlVTouEJCAuMfWFSaij
	 XBSBteaTFOi+qSJPPuQ/MtwjpjIdOgA8GNCWldADuFrmXSnntlzAtTyrbKlZhCag2zeZH
	 emXxRHBrNYvmcc8iO1ZqWea9f9O401sDOTF1/5FnKY/2yoV9GMjzndhGgwH2P7uaM3xzz
	 VrlDZyo7xKd6WoS4JaqVZ+fDexFsNq7PmKAKERYeU47iVAN6FMGOd+C0K+MCciaotqOxR
	 Rn7hbR5pRWg6I6IufIcKyau5zRdKgiA0dZgGTfiyOEoBEdgNISx7uqrVswVKAPHPruA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772398;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JwF30sKeSWshZnOg+Mo+E0Jy9f5TcKQZda9OIaG5oAU=;
	b=Z0vQ+UU/eDrrQW/CcgzStQ40o0ajFbCReQqrG9zIM4MQPylhsGbGtwMZJfUPfNnn0NUU
	 wSlZ5LL+MdswLgiOtN70NnYE1BpPnrhilQZy/IXu08JT8qE5Y+YRBif+7ATx0dOmrd6mZ
	 84kymllU2k4W1F6gk0LvGqS5E0rUo676cclU8v/NMWNu/A3vN1/LA0Tywjsh8mV4V04h4
	 M4f5ybgZIlMdl1V+sDrBw+3TSxufrfoZxx5hhapHAMEweXcxavc1s2q1tse2coA9uHj1p
	 LXdSxu5Teta9tmKtq8dT+CqS9rKKKRtM51x83+EwzL2LoIcmRKLiZWsemg+9e01vXkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HUJ+ki0y;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5D2606A31B;
	Fri, 23 Oct 2026 16:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED5D2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HUJ+ki0y
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CC641BA8;
	Fri, 23 Oct 2026 09:19:54 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C44E53F673;
	Fri, 23 Oct 2026 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792772397; bh=JwF30sKeSWshZnOg+Mo+E0Jy9f5TcKQZda9OIaG5oAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUJ+ki0y1DGTe3OAQuJWJM7Be/JlxrwSwrDWEo/lnY3LUCkHXwU9DunS8JugvmJoz
	 H4r/fxAPAo2G96uuXVflHOBIxQUoDQUzqG51ln/bag0OUtY1Dxb7ti0Gr5uqaZGPKw
	 gZZYuWN4fhw/qodXgpUlRnlxCVK/ufzytY45s0jM=
Date: Fri, 23 Oct 2026 17:19:54 +0100
From: Leo Yan <leo.yan@arm.com>
To: "Johnny.Fan" <johnny.fan@cixtech.com>
Cc: will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org, suzuki.poulose@arm.com,
	mike.leach@arm.com, james.clark@linaro.org, maz@kernel.org,
	jeremy.linton@arm.com, cix-kernel-upstream@cixtech.com,
	bob.zhang@cixtech.com, jie.fu@cixtech.com,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v2] perf: arm_spe: Support heterogeneous ACPI systems
Message-ID: <20261023161954.GL26205@e132581.arm.com>
References: <20261021020322.3015121-1-johnny.fan@cixtech.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021020322.3015121-1-johnny.fan@cixtech.com>

On Wed, Oct 21, 2026 at 10:03:22AM +0800, Johnny.Fan wrote:

> These synthetic devices have no fwnode, so the firmware-described
> IRQ affinity cannot tell which CPUs implement the feature. Pass the
> CPU mask as platform data and have the drivers prefer it over the
> IRQ affinity when present.

Could the MADT-derived CPU masks be exposed through
platform_get_irq_affinity(), so SPE and TRBE can continue using the
common interface without fetching ACPI-specific data?

TBC, I don't know ACPI or GIC. I just thought it might be a neat
approach.

> Apply the same treatment to TRBE, which shares this registration
> code. TRBE must also pass a stable copy of the mask to
> request_percpu_irq_affinity(), since supported_cpus is pruned as
> CPUs are probed.

I wouldn't expect any changes to the SPE or TRBE drivers if
platform_get_irq_affinity() can return the correct CPU mask.

Thanks,
Leo
