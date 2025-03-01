Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36897156861;
	Sat,  1 Mar 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740812733; cv=none; b=KTrcACHQ6/lkPjErfo0hEolxIDGev91XEPU/5OEwamzLnXrSlXQRO6/W++YZ4oozpx0NkpoW5AQ4OZWo+m47Wgx3y1ArpCBch3A93hmm9HT+nODQLVURly2KLEVRS02Mxs7i02ctFuw/CY2UEGAjGD/GUnsjVe+4ef92WRFAot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740812733; c=relaxed/simple;
	bh=yuV32O2uacAQPpFXxHdzerV8Z0lORjwgQUBONgdPDh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmKm4r3DlfuLUO8s1ajOMxkZNtsLb4JXqe1OWUpyaPDSCYD+7TTgQv45Hmmf1XItYVrQ+6lmBfIrSOTz6TrpkVy1PU7e3Fbk/7FK/OwZTVp4mcI6/wWRqTxLOuo18biewazUT4iDLv4hBIW6u6gmIxU5hDujtMy8lJVLH/buVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl0VyKZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl0VyKZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F14C4CEDD;
	Sat,  1 Mar 2025 07:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740812732;
	bh=yuV32O2uacAQPpFXxHdzerV8Z0lORjwgQUBONgdPDh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vl0VyKZWz3vG3O12uSfoyp3OypG0rM+HcoZ7wkh5vZUgctgR/LBcFWq75Fyjt+wXL
	 b+gNN5AWEZi0xN9VEpKICCwUPda0JkzOGFisFMDupjrCV/7n6dDbKyEQ3q43aJiLiO
	 v4j6yJTq2OfVQEH/0bEt7+9O7anvmoUEcUnld4+/BT3yn7u3s/j4eBeh+DGSNP9uiC
	 W/9OF3DJSngzizuIHc73DvTCsxJOO00TKBi6BJ+IJbqbqwmUQUpPwbdhPURghXbNsP
	 5BJmoe+UD+A6LkXDt2hyPwuzYEvZokhESPx1kOiuu/Dw/BN4sY7Yk1UKXMyvOYUGJv
	 GqbMRFqu0X2Bw==
From: Will Deacon <will@kernel.org>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunhui Cui <cuiyunhui@bytedance.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 0/2] Fix dwc_pcie pmu driver issues
Date: Sat,  1 Mar 2025 07:05:23 +0000
Message-Id: <174080955779.3218826.2678564312238293449.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250220121716.50324-1-cuiyunhui@bytedance.com>
References: <20250220121716.50324-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 20:17:14 +0800, Yunhui Cui wrote:
> v1:
> Only sent the patch titled "fix duplicate pci_dev devices".
> 
> v2:
> 1. New patch: "fix the incorrect reference count".
> 2. The "fix duplicate pci_dev devices" change is made in two places:
> One is to remove the modification of the PMU name. The other is to change
> "for_each_pci_dev" to "pci_get_domain_bus_and_slot".
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] perf/dwc_pcie: fix some unreleased resources
      https://git.kernel.org/will/c/6eb1e8ef586a
[2/2] perf/dwc_pcie: fix duplicate pci_dev devices
      https://git.kernel.org/will/c/7f35b429802a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
