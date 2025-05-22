Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719128853B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911011; cv=none; b=MG/nSeW8EHBdOwx5A1QeQTpkV0+RMM8/aU1wq5gkYkT6TxQqJLZyoR4GgIG/Z/lbUobFk4dHWY1pTu2P98Hv2WS4/C1GB+s5d2hCatlHpU2JhdxjSGX+wydz15lYowXPUGFwd90b8Cf5u/o44yrX8IAXGMRTzE9piGiXjZ9iuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911011; c=relaxed/simple;
	bh=qhsSI+ekPMsr0DhO2nXOmwnTSG0GciE3JfpDPbW4qA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UP77JBQ+8hBN7yslN9h3wDtZljb0hJjA4e0o/UGFtldgowjdj5HZdHsuh5mcu2JdO1S+sTCyzYzdbppduzqcxhcimVonSYpnnce/Y511Ig4qsasNVVRPVK0CWjdKTmTOquEI4p1L82bBDF1iD8hlnmQV7/jdVPgepPCVQYlWVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyNheFDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyNheFDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FD5C4CEE4;
	Thu, 22 May 2025 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747911010;
	bh=qhsSI+ekPMsr0DhO2nXOmwnTSG0GciE3JfpDPbW4qA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MyNheFDnDu635ErWGrvREjr2F29g+TmkXtpzSMSxFQuKEg9pdKY32QoPUD4Bptpzd
	 UZSYOL/0Gei8+ZPxFCK5wMTAmvtRI2NJAG7GUD0UQPvMgjaFO2No7az4WSj/0l27Qs
	 kLytIIa8RdL3VlVPNTT4aVzpE1WJqIwtryaJ6M0hwGtwJHQX525pH1rpMu7DZ36mBn
	 V94a8dMgs40bIgbEmGHV6Q4n+NEur8JdrCaPZY3rICCpfc9xBUj3X1O+084MTFOi3T
	 3ZvsT7GQ2WQJJXzhnH5eDgl12lrg53/o/TEKxAB91NP+op9N0ua+oibh4rebAUquSU
	 uL2r1H5PlGeQQ==
From: Will Deacon <will@kernel.org>
To: acme@kernel.org,
	namhyung@kernel.org,
	catalin.marinas@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	john.g.garry@oracle.com,
	james.clark@linaro.org,
	leo.yan@linux.dev,
	irogers@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jonathan.cameron@huawei.com,
	hejunhao3@huawei.com,
	linuxarm@huawei.com,
	wangyushan12@huawei.com,
	caijingtao@huawei.com,
	xueshan2@huawei.com,
	prime.zeng@hisilicon.com,
	yangyicong@hisilicon.com
Subject: Re: [PATCH v2 0/3] Add support for SPE Data Source packet on HiSilicon HIP12
Date: Thu, 22 May 2025 11:50:03 +0100
Message-Id: <174790933967.1291842.14160046478134585349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250425033845.57671-1-yangyicong@huawei.com>
References: <20250425033845.57671-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 25 Apr 2025 11:38:42 +0800, Yicong Yang wrote:
> Add support for Data Source packet on HIP12. Support counting L2 HITM for c2c
> statistic since it was missing.
> 
> Change since v2:
> - split the kernel/userspace changes into different patch
> - revise some mem_snoop decoding according to the discussion
> - count missing L2 HITM for c2c statistic
> Link: https://lore.kernel.org/linux-perf-users/20250408122809.37884-1-yangyicong@huawei.com/
> 
> [...]

Applied cputype change to arm64 (for-next/cpufeature), thanks!

[1/3] arm64: cputype: Add cputype definition for HIP12
      https://git.kernel.org/arm64/c/226ff35039d0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
