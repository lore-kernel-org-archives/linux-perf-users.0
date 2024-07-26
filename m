Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46D17E9;
	Fri, 26 Jul 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002936; cv=none; b=hD0wD7b6UMKjt1gh9yV/0AoZFAGQX20RfHgc708z8W4noGKOgdCmIbIKVRW851lqVnZzwVx9IgnyXeEZGkqpKaS76ZAsZQ93svG2cb5yPcYgH6u8QPQPvVqHWsvKawepQqd3fv7u/6iz66zareDxMkPM3T/N52LkdbGbyspTFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002936; c=relaxed/simple;
	bh=DniVSvs2EQarAaQhXsat423CggEHBH8c/V0HDSY9H2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzjqTgIFE2wXJ5ITqNTiQXwUlLDHy3UiJM5AXAICRVGPndGQfjmJBPCfmjJ6mfoWiphZVoJJzNquLXFwwJdGwnsPfXah79Wc+1PaOYGhJ88IfUwf4XM6/LuLvt4hvV3uwo/RarOgGkRnxQYAhaAGVeqHoF1zofYy8GSu8FbAC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVAjqh3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVAjqh3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E1FC32782;
	Fri, 26 Jul 2024 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722002935;
	bh=DniVSvs2EQarAaQhXsat423CggEHBH8c/V0HDSY9H2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVAjqh3PNdscJcN0OvKtzOOXeZw9OgwPemDolAj3VVS2L06SDAfHPJs4CB2Lvlhge
	 oefyqVEJDRScC8DWQE+4Y6LpG32GZwAIfkRS5edR5MhJ1EX0V4k4Zvo2Gu8TVOFNpW
	 RwM8QJKlzE5Lgba8cv5juKUVEHcRzKyDYCLPIYlREDV5dzR2WmL0my65dFWt+9jUI7
	 NMrThY5xLKhvu7uXWxy9W99n/9Y7E3wicEktr4xIupHAi6UQjJGWXevfCXT1Y1Sp3a
	 mOrU0M8RDdrk1vC4sjpszksXPx25xrfWQx6PUVccBV2k1aOvhLkutaSvV2WxJnumkj
	 3qeilc8YniCKg==
Date: Fri, 26 Jul 2024 11:08:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, namhyung@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH] perf vendor events power10: Update JSON/events
Message-ID: <ZqOt9G9e-AIN6hY-@x1>
References: <20240723052154.96202-1-kjain@linux.ibm.com>
 <CAP-5=fWsQbA-h=_Y_q7z1E7GjCkHE3w-9h-OXu4jLBM3Fag6ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWsQbA-h=_Y_q7z1E7GjCkHE3w-9h-OXu4jLBM3Fag6ag@mail.gmail.com>

On Tue, Jul 23, 2024 at 09:02:23AM -0700, Ian Rogers wrote:
> On Mon, Jul 22, 2024 at 10:27 PM Kajol Jain <kjain@linux.ibm.com> wrote:
> >
> > Update JSON/events for power10 platform with additional events.
> > Also move PM_VECTOR_LD_CMPL event from others.json to
> > frontend.json file.
> >
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to tmp.perf-tools-next,

- Arnaldo
 
> > ---
> >  .../arch/powerpc/power10/frontend.json        |   5 +
> >  .../arch/powerpc/power10/others.json          | 100 +++++++++++++++++-
> >  2 files changed, 100 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> > index 5977f5e64212..53660c279286 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> > @@ -74,6 +74,11 @@
> >      "EventName": "PM_ISSUE_KILL",
> >      "BriefDescription": "Cycles in which an instruction or group of instructions were cancelled after being issued. This event increments once per occurrence, regardless of how many instructions are included in the issue group."
> >    },
> > +  {
> > +    "EventCode": "0x44054",
> > +    "EventName": "PM_VECTOR_LD_CMPL",
> > +    "BriefDescription": "Vector load instruction completed."
> > +  },
> >    {
> >      "EventCode": "0x44056",
> >      "EventName": "PM_VECTOR_ST_CMPL",
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power10/others.json b/tools/perf/pmu-events/arch/powerpc/power10/others.json
> > index fcf8a8ebe7bd..53ca610152fa 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power10/others.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power10/others.json
> 
> The "topic" of an event is taken from the filename, here the topic
> will be "others".
> 
> > @@ -94,11 +94,6 @@
> >      "EventName": "PM_L1_ICACHE_RELOADED_ALL",
> >      "BriefDescription": "Counts all instruction cache reloads includes demand, prefetch, prefetch turned into demand and demand turned into prefetch."
> >    },
> > -  {
> > -    "EventCode": "0x44054",
> > -    "EventName": "PM_VECTOR_LD_CMPL",
> > -    "BriefDescription": "Vector load instruction completed."
> > -  },
> >    {
> >      "EventCode": "0x4D05E",
> >      "EventName": "PM_BR_CMPL",
> > @@ -108,5 +103,100 @@
> >      "EventCode": "0x400F0",
> >      "EventName": "PM_LD_DEMAND_MISS_L1_FIN",
> >      "BriefDescription": "Load missed L1, counted at finish time."
> > +  },
> > +  {
> > +    "EventCode": "0x00000038BC",
> > +    "EventName": "PM_ISYNC_CMPL",
> > +    "BriefDescription": "Isync completion count per thread."
> > +  },
> > +  {
> > +    "EventCode": "0x000000C088",
> > +    "EventName": "PM_LD0_32B_FIN",
> > +    "BriefDescription": "256-bit load finished in the LD0 load execution unit."
> > +  },
> > +  {
> > +    "EventCode": "0x000000C888",
> > +    "EventName": "PM_LD1_32B_FIN",
> > +    "BriefDescription": "256-bit load finished in the LD1 load execution unit."
> > +  },
> > +  {
> > +    "EventCode": "0x000000C090",
> > +    "EventName": "PM_LD0_UNALIGNED_FIN",
> > +    "BriefDescription": "Load instructions in LD0 port that are either unaligned, or treated as unaligned and require an additional recycle through the pipeline using the load gather buffer. This typically adds about 10 cycles to the latency of the instruction. This includes loads that cross the 128 byte boundary, octword loads that are not aligned, and a special forward progress case of a load that does not hit in the L1 and crosses the 32 byte boundary and is launched NTC. Counted at finish time."
> > +  },
> > +  {
> > +    "EventCode": "0x000000C890",
> > +    "EventName": "PM_LD1_UNALIGNED_FIN",
> > +    "BriefDescription": "Load instructions in LD1 port that are either unaligned, or treated as unaligned and require an additional recycle through the pipeline using the load gather buffer. This typically adds about 10 cycles to the latency of the instruction. This includes loads that cross the 128 byte boundary, octword loads that are not aligned, and a special forward progress case of a load that does not hit in the L1 and crosses the 32 byte boundary and is launched NTC. Counted at finish time."
> > +  },
> > +  {
> > +    "EventCode": "0x000000C0A4",
> > +    "EventName": "PM_ST0_UNALIGNED_FIN",
> > +    "BriefDescription": "Store instructions in ST0 port that are either unaligned, or treated as unaligned and require an additional recycle through the pipeline. This typically adds about 10 cycles to the latency of the instruction. This only includes stores that cross the 128 byte boundary. Counted at finish time."
> > +  },
> > +  {
> > +    "EventCode": "0x000000C8A4",
> > +    "EventName": "PM_ST1_UNALIGNED_FIN",
> > +    "BriefDescription": "Store instructions in ST1 port that are either unaligned, or treated as unaligned and require an additional recycle through the pipeline. This typically adds about 10 cycles to the latency of the instruction. This only includes stores that cross the 128 byte boundary. Counted at finish time."
> > +  },
> > +  {
> > +    "EventCode": "0x000000C8B8",
> > +    "EventName": "PM_STCX_SUCCESS_CMPL",
> > +    "BriefDescription": "STCX instructions that completed successfully. Specifically, counts only when a pass status is returned from the nest."
> > +  },
> > +  {
> > +    "EventCode": "0x000000D0B4",
> > +    "EventName": "PM_DC_PREF_STRIDED_CONF",
> > +    "BriefDescription": "A demand load referenced a line in an active strided prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software."
> > +  },
> > +  {
> > +    "EventCode": "0x000000F880",
> > +    "EventName": "PM_SNOOP_TLBIE_CYC",
> > +    "BriefDescription": "Cycles in which TLBIE snoops are executed in the LSU."
> > +  },
> 
> Perhaps the topics here should be memory or translation?
> 
> > +  {
> > +    "EventCode": "0x000000F084",
> > +    "EventName": "PM_SNOOP_TLBIE_CACHE_WALK_CYC",
> > +    "BriefDescription": "TLBIE snoop cycles in which the data cache is being walked."
> > +  },
> > +  {
> > +    "EventCode": "0x000000F884",
> > +    "EventName": "PM_SNOOP_TLBIE_WAIT_ST_CYC",
> > +    "BriefDescription": "TLBIE snoop cycles in which older stores are still draining."
> > +  },
> > +  {
> > +    "EventCode": "0x000000F088",
> > +    "EventName": "PM_SNOOP_TLBIE_WAIT_LD_CYC",
> > +    "BriefDescription": "TLBIE snoop cycles in which older loads are still draining."
> > +  },
> > +  {
> > +    "EventCode": "0x000000F08C",
> > +    "EventName": "PM_SNOOP_TLBIE_WAIT_MMU_CYC",
> > +    "BriefDescription": "TLBIE snoop cycles in which the Load-Store unit is waiting for the MMU to finish invalidation."
> > +  },
> > +  {
> > +    "EventCode": "0x0000004884",
> > +    "EventName": "PM_NO_FETCH_IBUF_FULL_CYC",
> > +    "BriefDescription": "Cycles in which no instructions are fetched because there is no room in the instruction buffers."
> > +  },
> > +  {
> > +    "EventCode": "0x00000048B4",
> > +    "EventName": "PM_BR_TKN_UNCOND_FIN",
> > +    "BriefDescription": "An unconditional branch finished. All unconditional branches are taken."
> 
> I see PM_BR_TAKEN_CMPL in
> tools/perf/pmu-events/arch/powerpc/power10/frontend.json, so maybe it
> makes sense to put this event in that topic?
> 
> Thanks,
> Ian
> 
> > +  },
> > +  {
> > +    "EventCode": "0x0B0000016080",
> > +    "EventName": "PM_L2_TLBIE_SLBIE_START",
> > +    "BriefDescription": "NCU Master received a TLBIE/SLBIEG/SLBIAG operation from the core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
> > +  },
> > +  {
> > +    "EventCode": "0x0B0000016880",
> > +    "EventName": "PM_L2_TLBIE_SLBIE_DELAY",
> > +    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG command was held in a hottemp condition by the NCU Master. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_TLBIE_SLBIE_SENT to obtain the average time a TLBIE/SLBIEG/SLBIAG command was held. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
> > +  },
> > +  {
> > +    "EventCode": "0x0B0000026880",
> > +    "EventName": "PM_L2_SNP_TLBIE_SLBIE_DELAY",
> > +    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG that targets this thread's LPAR was in flight while in a hottemp condition. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_SNP_TLBIE_SLBIE_START to obtain the overall efficiency. Note: ’inflight’ means SnpTLB has been sent to core(ie doesn’t include when SnpTLB is in NCU waiting to be launched serially behind different SnpTLB). The NCU Snooper gets in a ’hottemp’ delay window when it detects it is above its TLBIE/SLBIE threshold for process SnpTLBIE/SLBIE with this core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
> >    }
> >  ]
> > --
> > 2.43.0
> >
