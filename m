Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D025399018;
	Sun,  4 Oct 2026 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134158; cv=none; b=YgGitF8GfVZEU1wNKNU/PehPhsk/515rlUUZG3JlU6HZB6prMXZw3vWpNN3Q0HDQP1+i/uJ7e7wZpvW9hCbIF2LTJrOPr70MeFCbeTGZsgY6vYXbSZr5zgy+na4AnZv0iNJhjD/BPqhiWZnBTTuOYSNqW0bLtcTf9UtyZgafPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134158; c=relaxed/simple;
	bh=t8EKA+hYBmzHtG8cAgjEMHB0gidmWJ7+Wq242q9e4wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTEVG2nO24drK3e1LMl9gFuwqWhkkauRQQZV3OfjUOER2qNZgomrly5RyYbtdFa7XFzE6aJM1p7Q+KVWn7S6mGv+cjyvFoQ96nd5lOQbpYMbZWX+4E0Pv68RhqdtTVTTZfABRV36HphZDt4Jtv5GcWXYyIP9nFwSDL3WQvJPtho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCsCQuXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCsCQuXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EE31F000FF;
	Sun,  4 Oct 2026 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791134156;
	bh=0PBvAPhxoqixZMAgWbqzLZ2cN/fsVRLlvnaVCIYg7+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JCsCQuXBRXIj8RKKQWr2Q9R9dkQd5k1hjTPOYJyNcAKf9cVGT3p3jk0gLw5w5LzuG
	 isgaiDysJSByo6st6nSQLA4H6vCo4UCPfl44oVa1YuoN8qs+e+A7RrLlCHJrgVOBM7
	 FQkosE1qCEtizW5BenCmADomxGBZf0nCQ7/n2iuQv69dwvDUNebAufWR08WSeVd2Y0
	 Dlh0piCsUiRE3ot9iqFuZR1UgCg0sNq20dhJA+MCdkXpjQaDgXEPjEH31nIhYJ7Adi
	 YanMT3TTW0m9H9WuNfvosJErw9UtHmLTQ5NMS3ElxymohuJIa2asoUArEkhH8s2rFy
	 VR6+LD4z9ga5Q==
Date: Sun, 4 Oct 2026 18:15:51 +0100
From: Will Deacon <will@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf/dwc_pcie: Fix lockdep warnings in device and
 event setup
Message-ID: <asKJx59SN-NX-ho8@willie-the-truck>
References: <20260811131714.12779-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811131714.12779-1-zhangzhanpeng.jasper@bytedance.com>

On Tue, Aug 11, 2026 at 09:17:12PM +0800, Zhanpeng Zhang wrote:
> The DWC PCIe PMU driver creates a synthetic platform device for each Root
> Port from its PCI bus notifier. If a PCI host bridge is registered during
> late init, platform device registration enters the platform bus notifier
> chain while the PCI bus notifier lock remains held, and lockdep reports
> possible recursive locking. Patch 1 moves platform device reconciliation
> out of the notifier callback.
> 
> The event initialization path has a separate locking issue. It walks a new
> group leader's sibling list even though perf does not hold the event context
> lock required by for_each_sibling_event(). Patch 2 skips those walks for
> group leaders while preserving validation for group members.
> 
> The series was tested on a RISC-V system with CONFIG_KASAN,
> CONFIG_PROVE_LOCKING, CONFIG_DEBUG_LOCK_ALLOC and CONFIG_LOCKDEP enabled.
> Late PCI discovery and a system-wide DWC PCIe PMU perf stat complete without
> lockdep reports, and the kernel remains untainted.
> 
> Zhanpeng Zhang (2):
>   perf/dwc_pcie: Avoid nested bus notifier locking
>   perf/dwc_pcie: Skip sibling walks for new group leaders
> 
>  drivers/perf/dwc_pcie_pmu.c | 161 +++++++++++++++++++++++++++---------
>  1 file changed, 122 insertions(+), 39 deletions(-)

This doesn't seem to apply. Please can you send an updated version?

Will
