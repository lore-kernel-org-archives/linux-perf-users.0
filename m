Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9B2914
	for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747909511; cv=none; b=ja1hh+vJKQF1c89zIglcWlzN98UZsmsACp1kl0keYwQXRAe9Qc/uF5Qv4ejj2hpe2L6vVVhlHZy6KOoA/e4WAkhrJlPLqZx5/EQXq+DGUNVuD1EICUUotM42qaiG5cp/hOL3M0QZXI1QXcuta+OxR1ukInyfrQO5YBamtyPF118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747909511; c=relaxed/simple;
	bh=9/1p2IYCyp75jiiPs5nQsnCdxcy917exhcMFmdMkG1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hddrEJic6BLFmas7XHmc7lVf6waDjvNbZWUHj1JFKk+ktEMUMjCstQgdsOar/Qvu6gCQM6SQldAT7LhLbAvtJ6Jd81NuYL2dmtxpMU4CuUO5CDvIIw1XHwqo2CLcia9AgZoNk0nZ4Xy/ATGi4CaEDIyMSsEmhl97NVYZiHtgljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5pHahLA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5pHahLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34090C4CEED;
	Thu, 22 May 2025 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747909510;
	bh=9/1p2IYCyp75jiiPs5nQsnCdxcy917exhcMFmdMkG1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5pHahLAzrgZmTpWA+9e1ow/jOZ3FUjPLlUNAjwA6b6hjUsHVCmWvxwxn3mZb//Wt
	 Ibb0h/ZAsMwTve4dV/icFCCuVv5+jbBId4JUJuKyAKhZRNBkax3mczqR0XAQ9pAyN2
	 aftx0NiehHi7eI2hBWbedRj4sNkFnUOtt7WncIr879LRma9KvDSDDiM7zpW6cDYUZM
	 Har/FUTJ0VbshKv5GPL8EKklUWu9mMEHc9SgKw92uPJag0R3SFYDcyXNTTWocHaGTX
	 zx74Pk7RFQqPwwiHgzTyHSLfHMCyn7TFSZ4/tqAb4cdGLwWofsV+sgb52Y2Clys73Q
	 DmhmfoGwPhOXA==
Date: Thu, 22 May 2025 11:25:03 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com, acme@kernel.org, namhyung@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	jolsa@kernel.org, john.g.garry@oracle.com, james.clark@linaro.org,
	leo.yan@linux.dev, irogers@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com, hejunhao3@huawei.com,
	linuxarm@huawei.com, wangyushan12@huawei.com, caijingtao@huawei.com,
	xueshan2@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH v2 1/3] arm64: cputype: Add cputype definition for HIP12
Message-ID: <20250522102503.GB21627@willie-the-truck>
References: <20250425033845.57671-1-yangyicong@huawei.com>
 <20250425033845.57671-2-yangyicong@huawei.com>
 <557c852c-3c21-130f-c096-2d09052e04ef@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <557c852c-3c21-130f-c096-2d09052e04ef@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, May 22, 2025 at 05:13:25PM +0800, Yicong Yang wrote:
> would you mind taking this kernel change? we'll add this in the userspace tools' cputype.h and this
> patch is aimed to synchronize the update in the kernel.

Sure, I'll grab it now...

Will
