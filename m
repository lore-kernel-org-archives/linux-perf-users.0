Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F92EB5D7;
	Fri, 27 Jun 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751047059; cv=none; b=dyhoKr662fE0h2G55KcZE+LK/diJFi8zg/OaXWyrwELcHtUKFvt9TbRNUnT4VQco4UszhiNGpfhFtoMlWLlqLkg2/1CIk66bVpk1Bfu577LXeYn4xjkVqAXGBUlmiW2Wt/AWzwimY4MqIMkDlr5DFEQFtOZGPFO/QfWX7LQodnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751047059; c=relaxed/simple;
	bh=lO/D+8l/3CtfDrZf5ur943JGKj+bthfoO2Ff354hWFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paXGcOcDEtfmQPvqwViUY9Jb+NVOEaoU5UYpxq1aj+9+kXZOm0jbaBaXYAy9FFW5JhmeSrgduAmdBCjsOsUE+CiRNTxn9EwVDJ+u0O89OAJQHf26MCIBQfVD7SKcfUExmnuam/ZcEit03UV33q/kWDeU6wXKgZzzARj2txFRri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951701655;
	Fri, 27 Jun 2025 10:57:18 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B10163F58B;
	Fri, 27 Jun 2025 10:57:33 -0700 (PDT)
Message-ID: <39117e6a-ebb6-4c92-a19c-2033c4e590cd@arm.com>
Date: Fri, 27 Jun 2025 18:57:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: reduce stack usage in arm_cmn_probe()
To: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250620115149.132845-1-arnd@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250620115149.132845-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/06/2025 12:51 pm, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function has a rather large stack usage, which triggers the
> warning limit with clang if I reduce the default to 1280 bytes:
> 
> drivers/perf/arm-cmn.c:2541:12: error: stack frame size (1312) exceeds limit (1280) in 'arm_cmn_probe' [-Werror,-Wframe-larger-than]
> 
> This is a combination of two problems:
> 
>   - The arm_cmn_discover() function has some large local variables and
>     gets inlined here by clang (but not gcc)
> 
>   - The (struct pmu) assignment adds an extra copy of the pmu structure
>     on the stack and does a memcpy() from that
> 
> Address the first one here by marking arm_cmn_discover() as noinline_for_stack,
> making clang behave more like gcc here. This gets it under the warning
> limit, though the total stack usage does not actually get reduced.

At that point, though, it seems like we may as well just disable the 
warning :/

Fortunately it's not actually that hard to improve matters here, so I've 
just sent that patch:

https://lore.kernel.org/r/e7dd41bf0f1b098e2e4b01ef91318a4b272abff8.1751046159.git.robin.murphy@arm.com/T/#u

> It would be nice to also change the way struct pmu is initialized, but I
> see that this is done consistently for all pmu drivers. Ideally the function
> pointers should be moved into a 'static const' structure per driver as this
> is done in most other subsystems.

Beware that perf_pmu_register() does some further dynamic assignment of 
callbacks based on what the driver provided, so it's not necessarily 
straightforward to change in struct pmu itself. However, FWIW I have 
recently been playing with some ideas for reducing the amount of PMU 
registration boilerplate, and indeed one of them is to have a 
driver-level static template passed to a registration helper, which 
would at least make it easy to avoid the full by-value copies everywhere.

Thanks,
Robin.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/perf/arm-cmn.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 031d45d0fe3d..430c89760391 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2243,7 +2243,8 @@ static enum cmn_node_type arm_cmn_subtype(enum cmn_node_type type)
>   	}
>   }
>   
> -static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> +static noinline_for_stack int arm_cmn_discover(struct arm_cmn *cmn,
> +					       unsigned int rgn_offset)
>   {
>   	void __iomem *cfg_region;
>   	struct arm_cmn_node cfg, *dn;
