Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3518207A32;
	Thu, 11 Sep 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583166; cv=none; b=VM/m82d4MyYfHBpYZ1OwFJ4t2qg8Sf0qZjSuDsryDQCmd6QBW8mqx30cp1kTbL/kIY7/uMzc01cg9jM6B2QwDvSufZczn/wi8Z69yT/VRXRsWTsr72lp7zi2Vwrlo8VEgmZyjlwxP8NlOsEhhhVrNuzdtwqPbHNCLAf5+cb+IaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583166; c=relaxed/simple;
	bh=6XWm9UEcZAEjNVEeWdfrgb1ntSWKErVvbenCRbHpvf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDS/dbpmT/h7t8BydHb1adGA3lUFnyvs/4bohZL9ElCfUWnJ0S43DlKo6pB0r0DqCVuxcrBbudrp5V6xhybkhjk63zjePQaL6Ukk/xbsErnk4iyXLYezElj8lallqCPW3tuCOjZrUVU/pihmPzAErfrdUF9xLdM/ixWeycLzSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EE58153B;
	Thu, 11 Sep 2025 02:32:35 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 820E53F694;
	Thu, 11 Sep 2025 02:32:43 -0700 (PDT)
Date: Thu, 11 Sep 2025 10:32:41 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] tools headers: Remove unused arm32 asm/kvm.h copy
Message-ID: <20250911093241.GD12516@e132581.arm.com>
References: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
 <20250910-james-tools-header-cleanup-v1-2-7ae4bedc99e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-james-tools-header-cleanup-v1-2-7ae4bedc99e0@linaro.org>

On Wed, Sep 10, 2025 at 02:30:12PM +0100, James Clark wrote:
> arm32 KVM was removed in commit 541ad0150ca4 ("arm: Remove 32bit KVM
> host support"). None of the kvm selftests are compiled for arm32 and
> it's not indirectly included from anywhere either, so delete it.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
