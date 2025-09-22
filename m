Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26830E82D;
	Mon, 22 Sep 2025 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546907; cv=none; b=fHtySz6YFCbLsAMGAoexb0ePNpTW16v8w7pAX9DIF8GDINnPQ/pC/TY5MgCVKY30SXGwsGwBNfagxj+2RXE2UHvaZb11CnZy17RJh57mu6xp6uxik480agXgvUGMyqlCBeLmca7s4YgI+uizAJa+Bbj7hEBrI88vIdVbSlq7GFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546907; c=relaxed/simple;
	bh=82ttxSMSEH3ZtEUKmy8PdeINF6t2+aMiPJPzyVHU8aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ml+dl3bVGGLoXmV11hzoNko1Y1777NdbsognF0bvQWmxXVyvMs1J6rlA7PB3zBySrPHEDow5RsaxzWYaC90OGEFJya27W3b5MSaD2SNOVq7jqI2rGsfoYKqcvXpJtsLce9zcp4OaVeyhgESYDerNXFewVCjIJ3KWUz62cpGFn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0DttOC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0DttOC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2302C113D0;
	Mon, 22 Sep 2025 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758546906;
	bh=82ttxSMSEH3ZtEUKmy8PdeINF6t2+aMiPJPzyVHU8aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0DttOC3XZWhMwZfaIUvd6QJ4ILg4SOyEa+9PhjK0EvNN7OI/ZFmYgam50ND54UDO
	 +04S34jnJshMLJZkoG8zCFsaDT7xI+nWIWbMia0RBaSvw8e2FW5RiXiJCSNPNIqktw
	 XwW/LxFIV6MpDnVL6s1rqcKzWfU+SRs/Z0jU1OaCeUYW6kINoduYk+AgOF2AdX5pBz
	 NTZL+w32HCEtzoEbO6UuiCOXil716Juz06qas/Fsa8+CiQO+BgYU1A8pLtmPPWuOsC
	 zJGC9Cy1O0gOHJfR/eN2k6xUQgzVT/9C1jG66pelFi5leQcutSXc1xKQ2YX8bT40Nm
	 F/PPQu0avTQrQ==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Koichi Okuno <fj2767dz@fujitsu.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9] perf: Fujitsu: Add the Uncore PMU driver
Date: Mon, 22 Sep 2025 14:14:47 +0100
Message-Id: <175854271310.3138824.7032222735567665921.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909030259.2313226-1-fj2767dz@fujitsu.com>
References: <20250909030259.2313226-1-fj2767dz@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Sep 2025 12:02:50 +0900, Koichi Okuno wrote:
> This adds a new dynamic PMU to the Perf Events framework to program and
> control the Uncore PMUs in Fujitsu chips.
> 
> This driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
> 
> perf stat -e pci_iod0_pci0/ea-pci/ ls
> perf stat -e pci_iod0_pci0/event=0x80/ ls
> perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: Fujitsu: Add the Uncore PMU driver
      https://git.kernel.org/will/c/bad11557eed2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
