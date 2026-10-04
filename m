Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50E41B8CD;
	Sun,  4 Oct 2026 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151789; cv=none; b=owRSklCobGceAutohJ/XwMGfbGAgDO0cRINL1RZ6Sl+JbV+VddjiYHlu1PNqZzuddXPiPkr+z4IB/UOstiT53RzDkHP+18cSi8ZNL3heN8mmTK58x81IBnp/9w5NZorUeZ2KyF8ExV4LKu9luM7YjQDm9nUzY7+fsdx/3oBDWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151789; c=relaxed/simple;
	bh=z+YiW3wkpUZIaph7rj58DXrc5RBoRuQj4IA1F0Oxw3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fb0xey5+ZtuK1wqD75nDSJuMmNWmy3GV0x14KoZjM+z/aZs5lA9OmFhdmwmcT5S35Muba91chz3CtLkBH7Asz1aNU8xR2keE3R3QZzmIcK3crrrkHD9TMKUV5vj8fWpMJLZLDKU21Jk2g9d9gf53fgOt8UImx58Wvv9awLsMpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQIGghcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQIGghcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72441F00898;
	Sun,  4 Oct 2026 22:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151787;
	bh=vkNIQLMpC1d0MEJXAzW0sGVZFQPX3e0T6cZ2nuvw/Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UQIGghcmZ2XPSAGpdOETkygsDHVBwLjNJemPo2BdKKHMrkSfXA4i1U/OV7ph006pu
	 OmjvWTkoIaMe2wZpusrKJqhvzM9aQEuNrmAilDXVne69UwK+TsUSz7gQ69EO80a70r
	 0ZoMis4oCoJMWnV7SPg8PEOIdkmsyJCL6712k52yosu8Ks8EYDxP+knNn7NvkUc5cx
	 WMBo2BDjbXmXwVNAN1UZGvCuvdp8q5noKk9BSPvHeTHOoZMAtSxxePeeVPjZOD/pYA
	 AmQolxiJyhmzvOHZm24BVO1yM9g679NErgZebCyhy3sXNSErPsAX+w0V3XVq4d/Hzr
	 aGm7Dkn/VvVAQ==
From: Will Deacon <will@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Ruoyu Wang <ruoyuw560@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/dwc_pcie: Fix PCI device reference leak in probe
Date: Sun,  4 Oct 2026 23:09:19 +0100
Message-ID: <179113437863.1501714.3722625240012640399.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260820135611.3901886-1-ruoyuw560@gmail.com>
References: <20260820135611.3901886-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Aug 2026 21:56:11 +0800, Ruoyu Wang wrote:
> pci_get_domain_bus_and_slot() returns a referenced PCI device. When the
> subsequent RAS DES capability lookup fails, dwc_pcie_pmu_probe() returns
> -ENODEV without releasing that reference. Repeated failed probes can
> therefore keep the PCI device allocated after removal.
> 
> Declare the looked-up device with __free(pci_dev_put), so the temporary
> reference is released on every return path. Keeping the reference scoped
> to the whole probe also covers all later uses of the device during
> initialization.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/1] perf/dwc_pcie: Fix PCI device reference leak in probe
      https://git.kernel.org/arm64/c/3a4067658363

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
