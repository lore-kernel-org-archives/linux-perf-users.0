Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221283101C4;
	Mon, 22 Dec 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766395341; cv=none; b=P9Bwze8a1IAFOUfoD83cGRV++rfJd0Yr+5JmccyAcvVy5x5E1zIRrL/YhPACmHEQJuNswRfIK2SNR+jaOQcZfWc4nSMkCwkIop1v8yM8NOXRrl/Tgwr3O/d+BvMQqBuO69Aln8aiiMZKi/pel+iqQZmPxU/QWA8LVcjRzXPq/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766395341; c=relaxed/simple;
	bh=cmW9coGQludHJvVj5aK0VjtyIQmqK5DRgXo8fU/KMRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJNFkn1EN2E10aiNoBe8NWSgCwAcUCO8/bS4lOvZ0kfeqp6MstoFR1b6iLh0ZTORj+0Heau28KCGxMbMm1WXNlbUIGXyTPGlJVxTlxD9c5CMU1dJQ+I0qovb+q+w41FnLFqh3/p0SyCcv87g8qF7vPWDp1YCov6WNxsuj4EwmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4428497;
	Mon, 22 Dec 2025 01:22:10 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FD183F5A1;
	Mon, 22 Dec 2025 01:22:17 -0800 (PST)
Date: Mon, 22 Dec 2025 09:22:15 +0000
From: Leo Yan <leo.yan@arm.com>
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: acme@redhat.com, james.clark@arm.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com, jolsa@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-tegra@vger.kernel.org,
	vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com,
	ywan@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com
Subject: Re: [PATCH 0/2] arm64: Support NVIDIA Olympus for Perf Arm SPE
Message-ID: <20251222092215.GE9788@e132581.arm.com>
References: <20251219231325.2742580-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219231325.2742580-1-bwicaksono@nvidia.com>

On Fri, Dec 19, 2025 at 11:13:23PM +0000, Besar Wicaksono wrote:
> This series support NVIDIA Olympus CPU in Perf Arm SPE.
> The first patch syncs the kernel header to the tools header.

Yes, I saw the kernel change has been merged.  For the series:

Reviewed-by: Leo Yan <leo.yan@arm.com>

> The second patch adds NVIDIA Olympus into perf's Neoverse SPE data source list.
> 
> Besar Wicaksono (2):
>   tools headers arm64: Add NVIDIA Olympus part
>   perf arm-spe: Add NVIDIA Olympus to neoverse list
> 
>  tools/arch/arm64/include/asm/cputype.h | 2 ++
>  tools/perf/util/arm-spe.c              | 1 +
>  2 files changed, 3 insertions(+)
> 
> -- 
> 2.43.0
> 
