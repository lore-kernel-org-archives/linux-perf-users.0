Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5C21CC5C
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224188; cv=none; b=AfXpPJFw9wcBeSruAPacLdIU/zT9fvVg+ptvLqK1ffaNxAvS6taOhgDlz3PwEQC66z2BBLAuWpfXmk48dDnxHNTjFBoLsUI8VsHcKaMpZYKb2WysMeQM+tnXpxtERmFmVlvYfq3J96g7xPMCf1IMH9EtnfCZL70uEmFA9FnB3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224188; c=relaxed/simple;
	bh=uPsdpb/twNuZT+zxQ3MOjZ3KiU3snHeB6pUVozD/84w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrKwjbj2kRVX/lZYlNS1qbVIpzu9DyD3LZAAadAeHT3pMKbCJEyrvJ6SY5g+Npqjkb73rg7BPOhX79qxeRL1nvRUnWJ31ri9Gtc3sNjNqZvijP2Ps0QSW1zQDNySddltBgJJSpBq5nk20fT0xFdOc1qaiihFs0jvC+ju/q+3FPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBtmd5VP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBtmd5VP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEFBC4CEE3;
	Mon, 17 Mar 2025 15:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742224188;
	bh=uPsdpb/twNuZT+zxQ3MOjZ3KiU3snHeB6pUVozD/84w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBtmd5VPEO2XKEfTj89IDr671UjDx0zHvVD1wADeTiLc//vhfrb4xFLPJU1+rtUct
	 ZhfE9fv4W/Dsk5a5KLJBQ1rgOiOhbF8UCV9haXPurs7EwP7S+CaBqcXXaGjiQV2h6I
	 nAypbZwDeVKEzj7UtoG42kFWvKlHU+wd5ZX9zMQwrNCHenROKw1mZqZHLAau3OYwM8
	 eTZ1hhCBR0t4V5zZODkNrgV0kfXjv+hP6uB50XnNywWBuZuiUIBzeQqLPkC38g2mwV
	 KiMYxeBbCmOJK8H3He2hO397xzO5a9j9Xuv/5TuC1Hl2ZandtryJhJ+GbgInIQJ2zL
	 dtgBn4gXkEUFg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] perf/arm_cspmu: Fix missing io.h include
Date: Mon, 17 Mar 2025 15:09:41 +0000
Message-Id: <174222318360.167046.12264124011753277546.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <657935ca177024ad08d5ec6f85e8faf75f82cf65.1742212833.git.robin.murphy@arm.com>
References: <657935ca177024ad08d5ec6f85e8faf75f82cf65.1742212833.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Mar 2025 12:00:33 +0000, Robin Murphy wrote:
> Adding the writel() calls needs io.h, which apparently gets
> transiently included somewhere on arm64, but not elsewhere.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm_cspmu: Fix missing io.h include
      https://git.kernel.org/will/c/9651f7899cc5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
