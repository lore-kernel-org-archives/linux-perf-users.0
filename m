Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D21474B8;
	Thu, 17 Apr 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896040; cv=none; b=jWNx+zcJYY3bGa833O9NcTChracgfHHmrNIa8bpxb4weEFZbY5K5RErvgGCFC3EQZ1gXOFedw2aX1Sds5PYvqRKQ+WhbBf/hkin3Gjg4GXTVG4mK2tVPpoyvylREJjZg3Aj3R3aTfpny5/QFX20BPsA+C44gVOC99R4hNOms66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896040; c=relaxed/simple;
	bh=n/8uGpNsdYKNqMW7uwcOgz9sLAMdb7HkWpu8m8iysi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmVx9SyaOqUq/iui+yAv9zeZ2wc2eWHeBZhAsAPRzpfAs3ucbTAptQGbyOYbIB+G52Wr2iMj3x8ykscNAvf1vNhJjbcqaKA3Rz9XAkudj1mvDj948wRXUOUdVd+7YQw97EvWQxFWFLEhzsMB3o1b8D0fONc4I7mSPG279BuaGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7ppWavk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7ppWavk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153EAC4CEEA;
	Thu, 17 Apr 2025 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744896040;
	bh=n/8uGpNsdYKNqMW7uwcOgz9sLAMdb7HkWpu8m8iysi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7ppWavk6lr4JAY5bawvUBCnzuQcrTunyBN/tnKILpTtYSccMY0mTT9vFvhNRTrRu
	 wzs8yoWkHFf58L/OJARbE2FnbdpoXe5ngV8TYcbTVK1JUjJp46ONdw9qkYKnWE8Pb0
	 2fY90QaG1heFMmwZ1Qb23/FLufKI8jX3E4Wp1CVyZBGpEblySKuzw3roxIzDnQsVcY
	 twKsp6njYzsOfv/YidoyE82JDAsKqpWySPCRe1whhrwR7B9LqkzLMFZkjLx6nN1RHQ
	 SmcLOF1qP6trPHywxG3HOQWlbiKs3ZlZK3uWc4iNl7cdn0aj+Fhmi2a9c49JNkKsam
	 rTialmrbSX3pA==
Date: Thu, 17 Apr 2025 14:20:34 +0100
From: Will Deacon <will@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>, robin.murphy@arm.com
Cc: Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	"open list:AMLOGIC DDR PMU DRIVER" <linux-amlogic@lists.infradead.org>,
	"moderated list:ARM PMU PROFILING AND DEBUGGING" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM PMU PROFILING AND DEBUGGING" <linux-perf-users@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf/amlogic: Replace smp_processor_id() with
 raw_smp_processor_id() in meson_ddr_pmu_create()
Message-ID: <20250417132033.GA12863@willie-the-truck>
References: <20250407063206.5211-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407063206.5211-1-linux.amoon@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 07, 2025 at 12:02:03PM +0530, Anand Moon wrote:
> The Amlogic DDR PMU driver meson_ddr_pmu_create() function incorrectly uses
> smp_processor_id(), which assumes disabled preemption. This leads to kernel
> warnings during module loading because meson_ddr_pmu_create() can be called
> in a preemptible context.
> 
> Following kernel warning and stack trace:
> [   31.745138] [   T2289] BUG: using smp_processor_id() in preemptible [00000000] code: (udev-worker)/2289
> [   31.745154] [   T2289] caller is debug_smp_processor_id+0x28/0x38
> [   31.745172] [   T2289] CPU: 4 UID: 0 PID: 2289 Comm: (udev-worker) Tainted: GW 6.14.0-0-MANJARO-ARM #1 59519addcbca6ba8de735e151fd7b9e97aac7ff0
> [   31.745181] [   T2289] Tainted: [W]=WARN
> [   31.745183] [   T2289] Hardware name: Hardkernel ODROID-N2Plus (DT)
> [   31.745188] [   T2289] Call trace:
> [   31.745191] [   T2289]  show_stack+0x28/0x40 (C)
> [   31.745199] [   T2289]  dump_stack_lvl+0x4c/0x198
> [   31.745205] [   T2289]  dump_stack+0x20/0x50
> [   31.745209] [   T2289]  check_preemption_disabled+0xec/0xf0
> [   31.745213] [   T2289]  debug_smp_processor_id+0x28/0x38
> [   31.745216] [   T2289]  meson_ddr_pmu_create+0x200/0x560 [meson_ddr_pmu_g12 8095101c49676ad138d9961e3eddaee10acca7bd]
> [   31.745237] [   T2289]  g12_ddr_pmu_probe+0x20/0x38 [meson_ddr_pmu_g12 8095101c49676ad138d9961e3eddaee10acca7bd]
> [   31.745246] [   T2289]  platform_probe+0x98/0xe0
> [   31.745254] [   T2289]  really_probe+0x144/0x3f8
> [   31.745258] [   T2289]  __driver_probe_device+0xb8/0x180
> [   31.745261] [   T2289]  driver_probe_device+0x54/0x268
> [   31.745264] [   T2289]  __driver_attach+0x11c/0x288
> [   31.745267] [   T2289]  bus_for_each_dev+0xfc/0x160
> [   31.745274] [   T2289]  driver_attach+0x34/0x50
> [   31.745277] [   T2289]  bus_add_driver+0x160/0x2b0
> [   31.745281] [   T2289]  driver_register+0x78/0x120
> [   31.745285] [   T2289]  __platform_driver_register+0x30/0x48
> [   31.745288] [   T2289]  init_module+0x30/0xfe0 [meson_ddr_pmu_g12 8095101c49676ad138d9961e3eddaee10acca7bd]
> [   31.745298] [   T2289]  do_one_initcall+0x11c/0x438
> [   31.745303] [   T2289]  do_init_module+0x68/0x228
> [   31.745311] [   T2289]  load_module+0x118c/0x13a8
> [   31.745315] [   T2289]  __arm64_sys_finit_module+0x274/0x390
> [   31.745320] [   T2289]  invoke_syscall+0x74/0x108
> [   31.745326] [   T2289]  el0_svc_common+0x90/0xf8
> [   31.745330] [   T2289]  do_el0_svc+0x2c/0x48
> [   31.745333] [   T2289]  el0_svc+0x60/0x150
> [   31.745337] [   T2289]  el0t_64_sync_handler+0x80/0x118
> [   31.745341] [   T2289]  el0t_64_sync+0x1b8/0x1c0
> 
> Changes replaces smp_processor_id() with raw_smp_processor_id() to
> ensure safe CPU ID retrieval in preemptible contexts.
> 
> Cc: Jiucheng Xu <jiucheng.xu@amlogic.com>
> Fixes: 2016e2113d35 ("perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver")
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/perf/amlogic/meson_ddr_pmu_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> index 07446d784a1a..c1e755c356a3 100644
> --- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
> +++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
> @@ -511,7 +511,7 @@ int meson_ddr_pmu_create(struct platform_device *pdev)
>  
>  	fmt_attr_fill(pmu->info.hw_info->fmt_attr);
>  
> -	pmu->cpu = smp_processor_id();
> +	pmu->cpu = raw_smp_processor_id();
>  
>  	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME);
>  	if (!name)


Bah, this follows what the other drivers are doing but I continue to
dislike the races we have between CPU hotplug and perf PMU registration.

Robin -- did you have a crack at fixing that or did I dream it?

Will
