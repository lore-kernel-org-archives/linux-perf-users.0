Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239BD520;
	Wed, 16 Oct 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100091; cv=none; b=KQkf/xYPA2o46ji/22SppbqbsT77slQGOgXKegvkCnwbkjrA+zd+XyH09mo/NuxihaaJHJtoFhbC0X9kFB8PVILXdFF7ogqbXKab8SsCEspt0Rqx9K/K6FHFiuIfBdyEJek983Yl4NjZ89zn+Gc5Ihhh9nltvGem6tSukFr3umk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100091; c=relaxed/simple;
	bh=cbKceK9RKKYDjCR5a/tMdY+Ui4JEm2VDrKb40ItW1NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJwl6tPbm6u2R7TXAJX+Vg7lNnwN4SJNLf+Y6b699wxDIu7ESyQEBgQU0Eg4QmfhkiwoooKJfBl++J4+ePGUj/meKBsyCypRLupmFHaKBXNo6Qz2DGW01sseilE5uaLInUNKvGGd+BtanOKyGy7zNcsfiCqn/u8ykkQ4icQxFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8s6zelf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8s6zelf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367CBC4CEC5;
	Wed, 16 Oct 2024 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729100090;
	bh=cbKceK9RKKYDjCR5a/tMdY+Ui4JEm2VDrKb40ItW1NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8s6zelfAtzbWxwmKiGlkbvvc2y/mqCvnf/631J1t4hR8amTZ4lCliopP/e7PB2X/
	 YFy0U7JNPI9cPtBHb6rQuv/nOPt0ntgedIPN8SDN4m9wVGlmCBGuW3Akk4vc3W6NXi
	 LCiUE2EJqZgn0x9DKJJGUNb9WUNRnmXFJpUDrCEkbN/b7KSyJ0E9vJbqJZKfH96NoI
	 J3oH0JN7Py6pKFz9R2Gr4fEDouGkBC+G9YerfDkXoJsS+CelvEVvv6pxKJfbR90M6U
	 YMEn8KeztYUhgwOh5xrAdbkglxmCfI2DVAs4TamkTuA/4/EgDo1CdQiW07ULUCaMQa
	 yFXSYr56ooUsQ==
Date: Wed, 16 Oct 2024 10:34:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, hbathini@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V2 1/2] tools/perf/pmu-events/powerpc: Add support for
 compat events in json
Message-ID: <Zw_5OLkwefdGOnA3@google.com>
References: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>

Hello Athira,

On Thu, Oct 10, 2024 at 08:21:06PM +0530, Athira Rajeev wrote:
> perf list picks the events supported for specific platform
> from pmu-events/arch/powerpc/<platform>. Example power10 events
> are in pmu-events/arch/powerpc/power10, power9 events are part
> of pmu-events/arch/powerpc/power9. The decision of which
> platform to pick is determined based on PVR value in powerpc.
> The PVR value is matched from pmu-events/arch/powerpc/mapfile.csv
> 
> Example:
> 
> Format:
>         PVR,Version,JSON/file/pathname,Type
> 
> 0x004[bcd][[:xdigit:]]{4},1,power8,core
> 0x0066[[:xdigit:]]{4},1,power8,core
> 0x004e[[:xdigit:]]{4},1,power9,core
> 0x0080[[:xdigit:]]{4},1,power10,core
> 0x0082[[:xdigit:]]{4},1,power10,core
> 
> The code gets the PVR from system using get_cpuid_str function
> in arch/powerpc/util/headers.c ( from SPRN_PVR ) and compares
> with value from mapfile.csv
> 
> In case of compat mode, say when partition is booted in a power9
> mode when the system is a power10, add an entry to pick the
> ISA architected events from "pmu-events/arch/powerpc/compat".
> Add json file generic-events.json which will contain these
> events which is supported in compat mode.
> 
> Suggested-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Is this the latest version?

Thanks,
Namhyung

> ---
> 
>  .../arch/powerpc/compat/generic-events.json   | 117 ++++++++++++++++++
>  .../perf/pmu-events/arch/powerpc/mapfile.csv  |   1 +
>  2 files changed, 118 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/compat/generic-events.json b/tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
> new file mode 100644
> index 000000000000..6f5e8efcb098
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
> @@ -0,0 +1,117 @@
> +[
> +  {
> +    "EventCode": "0x600F4",
> +    "EventName": "PM_CYC",
> +    "BriefDescription": "Processor cycles."
> +  },
> +  {
> +    "EventCode": "0x100F2",
> +    "EventName": "PM_CYC_INST_CMPL",
> +    "BriefDescription": "1 or more ppc insts finished"
> +  },
> +  {
> +    "EventCode": "0x100f4",
> +    "EventName": "PM_FLOP_CMPL",
> +    "BriefDescription": "Floating Point Operations Finished."
> +  },
> +  {
> +    "EventCode": "0x100F6",
> +    "EventName": "PM_L1_ITLB_MISS",
> +    "BriefDescription": "Number of I-ERAT reloads."
> +  },
> +  {
> +    "EventCode": "0x100F8",
> +    "EventName": "PM_NO_INST_AVAIL",
> +    "BriefDescription": "Number of cycles the ICT has no itags assigned to this thread."
> +  },
> +  {
> +    "EventCode": "0x100fc",
> +    "EventName": "PM_LD_CMPL",
> +    "BriefDescription": "Load instruction completed."
> +  },
> +  {
> +    "EventCode": "0x200F0",
> +    "EventName": "PM_ST_CMPL",
> +    "BriefDescription": "Stores completed from S2Q (2nd-level store queue)."
> +  },
> +  {
> +    "EventCode": "0x200F2",
> +    "EventName": "PM_INST_DISP",
> +    "BriefDescription": "PowerPC instruction dispatched."
> +  },
> +  {
> +    "EventCode": "0x200F4",
> +    "EventName": "PM_RUN_CYC",
> +    "BriefDescription": "Processor cycles gated by the run latch."
> +  },
> +  {
> +    "EventCode": "0x200F6",
> +    "EventName": "PM_L1_DTLB_RELOAD",
> +    "BriefDescription": "DERAT Reloaded due to a DERAT miss."
> +  },
> +  {
> +    "EventCode": "0x200FA",
> +    "EventName": "PM_BR_TAKEN_CMPL",
> +    "BriefDescription": "Branch Taken instruction completed."
> +  },
> +  {
> +    "EventCode": "0x200FC",
> +    "EventName": "PM_L1_ICACHE_MISS",
> +    "BriefDescription": "Demand instruction cache miss."
> +  },
> +  {
> +    "EventCode": "0x200FE",
> +    "EventName": "PM_L1_RELOAD_FROM_MEM",
> +    "BriefDescription": "L1 Dcache reload from memory"
> +  },
> +  {
> +    "EventCode": "0x300F0",
> +    "EventName": "PM_ST_MISS_L1",
> +    "BriefDescription": "Store Missed L1"
> +  },
> +  {
> +    "EventCode": "0x300FC",
> +    "EventName": "PM_DTLB_MISS",
> +    "BriefDescription": "Data PTEG reload"
> +  },
> +  {
> +    "EventCode": "0x300FE",
> +    "EventName": "PM_DATA_FROM_L3MISS",
> +    "BriefDescription": "Demand LD - L3 Miss (not L2 hit and not L3 hit)"
> +  },
> +  {
> +    "EventCode": "0x400F0",
> +    "EventName": "PM_LD_MISS_L1",
> +    "BriefDescription": "L1 Dcache load miss"
> +  },
> +  {
> +    "EventCode": "0x400F2",
> +    "EventName": "PM_CYC_INST_DISP",
> +    "BriefDescription": "Cycle when instruction(s) dispatched."
> +  },
> +  {
> +    "EventCode": "0x400F6",
> +    "EventName": "PM_BR_MPRED_CMPL",
> +    "BriefDescription": "A mispredicted branch completed. Includes direction and target."
> +  },
> +  {
> +    "EventCode": "0x400FA",
> +    "EventName": "PM_RUN_INST_CMPL",
> +    "BriefDescription": "PowerPC instruction completed while the run latch is set."
> +  },
> +  {
> +    "EventCode": "0x400FC",
> +    "EventName": "PM_ITLB_MISS",
> +    "BriefDescription": "Instruction TLB reload (after a miss), all page sizes. Includes only demand misses."
> +  },
> +  {
> +    "EventCode": "0x400fe",
> +    "EventName": "PM_LD_NOT_CACHED",
> +    "BriefDescription": "Load data not cached."
> +  },
> +  {
> +    "EventCode": "0x500fa",
> +    "EventName": "PM_INST_CMPL",
> +    "BriefDescription": "Instructions."
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> index 4d5e9138d4cc..cbd3cb443784 100644
> --- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> @@ -16,3 +16,4 @@
>  0x004e[[:xdigit:]]{4},1,power9,core
>  0x0080[[:xdigit:]]{4},1,power10,core
>  0x0082[[:xdigit:]]{4},1,power10,core
> +0x00ffffff,1,compat,core
> -- 
> 2.27.0
> 
