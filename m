Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482B61A9FBD;
	Mon, 29 Sep 2025 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134459; cv=none; b=fc3bQ2z/6o/44BM7UKCnCdCJPWHSCKF4zqkuGMxif2tHC/bCnuDgOzO6tAQiWUB9Rts6xzCbcJsvxwOzBE4RmqR1HAxre46F/tIO7yiBkCaWvsQqVaAZQg2mQeaywNTNuUs2WBpCFI+KHLCHXR1BoJ8z3mPDxndIl0t0socQicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134459; c=relaxed/simple;
	bh=T2N3glIBjumNRWS6PjkZx9wzyh91X6PQffMsE+XQCVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLayHhXN7SXj31ufAGxbrkkX62w0dam05NbNddGvwrjF1m4/8J5q33fTybtzQS214xnqI+oxTq8EcjBB+/qLP/p+Zpd15gb2PicPnubtswRjRC/J7rvfFWFtlnZwmc7UOJxF6S+ZqmCbIYfDevmogb+WgvJ9EghLVDyiKzpna50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46CD4150C;
	Mon, 29 Sep 2025 01:27:28 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7DBD3F66E;
	Mon, 29 Sep 2025 01:27:35 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:27:33 +0100
From: Leo Yan <leo.yan@arm.com>
To: Shivank Garg <shivankg@amd.com>, linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
	yangyicong@hisilicon.com, bp@alien8.de, mingo@kernel.org,
	xin@zytor.com, yosry.ahmed@linux.dev
Subject: Re: [PATCH] tools headers: Sync x86 cpufeatures and arm64 cputype
 headers
Message-ID: <20250929082733.GH7985@e132581.arm.com>
References: <20250929061644.19188-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929061644.19188-2-shivankg@amd.com>

Hi Shivank,

[ + James, perf-user ML ]

On Mon, Sep 29, 2025 at 06:16:45AM +0000, Shivank Garg wrote:
> To pick up the changes in this cset:
> 
> commit 2f8f173413f1 ("x86/vmscape: Add conditional IBPB mitigation")
> commit a508cec6e521 ("x86/vmscape: Enumerate VMSCAPE bug")
> commit c8c2647e69be ("arm64: Make  _midr_in_range_list() an exported function")
> commit e3121298c7fc ("arm64: Modify _midr_range() functions to read MIDR/REVIDR internally")
> 
> This addresses these perf build warnings:
> tools/perf$ ./check-headers.sh
> Warning: Kernel ABI header differences:
>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Please drop arm64 related syncing, otherwise, it will break perf
building.

At the meantime, James is working on refactoring cpu type definitions
for Arm64, we expect to avoid syncing cputype.h.

Thanks,
Leo
