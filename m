Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1371DE4C2;
	Fri, 15 Aug 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267063; cv=none; b=XX+HftHUiIYqyNhca9OVW3cfI52yIXkHmkpR7hpIs8P5Ky/OXxbZ7gfK5YDcpsY23+9qxabddtlUyX447AxM+w+jgAstxm4O7ov/gdR0VzBbauDZOEuc3WBHeQeCA6rDmX5E9e85VL2zfmVbxWX7+w4lCqVToTX9Sea3KDutxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267063; c=relaxed/simple;
	bh=21kBuVipaIFn4RGQka+pAPB+NDgFp3XSRK2uNhuU0yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjVh64oxITkr+72ammumA7UonmD5V6nBXqE0ZZb3w70uDoHVanjy7cZR4F4li42LHd6pdjgK4ZGAjbeX6hzUW3LI1TEXaeRh0B5uHu8sXDnTb4eE2OX9BQE7XHoI1SfGyUPahE/phglvwi0w2ZoK/KYWRDplQwBitq01FUwuJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCFDC4CEEB;
	Fri, 15 Aug 2025 14:10:58 +0000 (UTC)
Date: Fri, 15 Aug 2025 15:10:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	linux-trace-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org,
	oleg@redhat.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH v5 5/7] arm64: uprobes: Add GCS support to uretprobes
Message-ID: <aJ8_8HO37UjH1U0d@arm.com>
References: <20250811141010.741989-6-jeremy.linton@arm.com>
 <202508131334.FfoZQ27h-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508131334.FfoZQ27h-lkp@intel.com>

On Wed, Aug 13, 2025 at 02:12:30PM +0800, kernel test robot wrote:
> Hi Jeremy,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on perf-tools-next/perf-tools-next tip/perf/core perf-tools/perf-tools linus/master v6.17-rc1 next-20250812]
> [cannot apply to acme/perf/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/arm64-probes-Break-ret-out-from-bl-blr/20250811-221529
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20250811141010.741989-6-jeremy.linton%40arm.com
> patch subject: [PATCH v5 5/7] arm64: uprobes: Add GCS support to uretprobes
> config: arm64-randconfig-r111-20250813 (https://download.01.org/0day-ci/archive/20250813/202508131334.FfoZQ27h-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.4.0
> reproduce: (https://download.01.org/0day-ci/archive/20250813/202508131334.FfoZQ27h-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508131334.FfoZQ27h-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm64/kernel/probes/uprobes.c: In function 'arch_uretprobe_hijack_return_addr':
> >> arch/arm64/kernel/probes/uprobes.c:171:33: error: implicit declaration of function 'get_user_gcs'; did you mean 'put_user_gcs'? [-Werror=implicit-function-declaration]
>      171 |                 gcs_ret_vaddr = get_user_gcs((unsigned long __user *)gcspr, &err);
>          |                                 ^~~~~~~~~~~~
>          |                                 put_user_gcs
>    cc1: some warnings being treated as errors

I guess that's explained by patch 3 not being updated.

-- 
Catalin
