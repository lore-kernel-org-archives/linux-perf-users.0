Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022470;
	b=H4MqqivR3vNCxH/4HrYSzzK4bWbE0wA+SCqrzCs9peVAcYdmFqraBIpoM2LhxshJB4uQ
	 T3WPt4Wkerfk0dp1ex2wzWBZsO4p4y37GEpnwJ/WWBW0i3WRhf4X1tiJNOVfK+/0WFqyB
	 PjxnKZEvfPUf6H1ICOFhkn4APgjoJ4cYpW4++lwsXadBWuXVDH+PNrsbrK2mwv5BUiuEE
	 N0GBjzoAjw0KpExWb0iDP8xuSwQvRLHe8LC446EuiSLQE4mPIn8Tm7xHW4pNw9iNBKDJ1
	 RXvnTeapmvae8QKiWywRLAvTJPGNcgBmDYLUbV9sDWB0AdvEnRiHC66LE/w7uHzwVAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022470;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=7B+xkWqUWFTQSiPsnjUgEF1KPiSAU/FfUqGVycOFzGY=;
	b=QIUnus9YR/olrxqRixcqiFOcWODa7FCU1ZMlct+TlGGsLV8YpNCT5nR6tH1SMf43lW7l
	 A0g8GrOXQ56an592rUhhMiwmiVwyebyFIy0miP2BBcJGiljWl1/1SWiyfbPU57R+nYvW3
	 sCMTDWhZTSZ0KdoMv0+UeX2YFCkHgms5tpd/uJeDb8jpAb965u/InfAa4SrNBcfi0A55z
	 cmvus0muI0EhrMFMfnanFtlft+hMSUGZci/R1MF68TcXDtke/xNHa3CMWjfLNx5fHVUEb
	 pziz+HiI2vosb7D/tudl2FPHmmIAW6LgCMhPxpMlVeQq7NzxByXGBIdGrflCo7FFjBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=justus-bergermann.de;
	spf=pass smtp.mailfrom=justus-bergermann.de;
	dkim=pass header.d=justus-bergermann.de header.i=mail@justus-bergermann.de header.a=rsa-sha256 header.s=s1-ionos header.b=IdXqblqu;
	arc=none smtp.remote-ip=212.227.126.135
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2A606A332
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 17:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADD2A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justus-bergermann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justus-bergermann.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=justus-bergermann.de header.i=mail@justus-bergermann.de header.a=rsa-sha256 header.s=s1-ionos header.b=IdXqblqu
DKIM2-Signature:  i=1; m=1; t=1795022466;
 mf=PG1haWxAanVzdHVzLWJlcmdlcm1hbm4uZGU+;
 rt=PGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnPg==;
 d=justus-bergermann.de;
 s=s1-ionos:rsa-sha256:2DBdR1zIb4nEYcCFn18Yenpra+9d
   r+jNH2VicFO9SYoi0YwA9gpX2VkrEi8D4j5oHIBUafmcodU/QJbpujtEOfi+7RkGCEjd98kSDYv
   ZbbLcVlvGnhY7wXqLoAuzm1KssouM3dn4fXXLs4FiaChWFHM2NZHvgh4uvKdiRddV/1Mnzv+gjd
   edYSHa0iJB9zDY4DRrQK+AmqdzqDCo3bAUbptlYuGucKAwNji2RUTS5A/fOzDeoikONYpj0XQXV
   hfShUwXPF4iEbNjJn5t66gcjE4c1iix/Gt/t4WSpyePKvrrTAeoZhLPVtWwxgX5QfwG5pmmlOVK
   kYSaNWZHZQqJDQ==;
Message-Instance:  m=1;
 h=sha256:
   wBljeB7psofb49jwdgQYy98WcKWQDAQhgU1LReJh+90=:
   PwLCmuxZwDOZ98g584pAvopaqCcLrgu5qNtU7O1giUc=,
  sha512:
   PP0vVJJ8ZYRef/HaplAw2heYwG7pWo4r998Xv40y8ExX0HZGITkFcdDMzsqUdO/tec8sZQOvUF6ksFWPPjifPQ==:
   4oRdx7PNZN8nqJvEgnj0hHIHHXDcTwm57gNojc7VJhrtSjAMYN/ZpYgzpYKrbUqIGriGvIvbTgdJG+G6Zo08QA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=justus-bergermann.de; s=s1-ionos; t=1795022411; x=1795627211;
	i=mail@justus-bergermann.de;
	bh=7B+xkWqUWFTQSiPsnjUgEF1KPiSAU/FfUqGVycOFzGY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IdXqblqutsJwD3S54y8zJHXvG4rEAlA6bcTNEv2t8cScYVzIbNckpWWnj1fytHB9
	 XyI21sSSThZWh6rBf/ejTExqO+rb8AgokKWvTxReT2wayYrvqxlXTluDU4dkF8imj
	 gmbpwfaXOCMFAs8tFkXmC064qaamVRKswZCKYmHLTkCmrQABdOVj6p767bgR1kYVi
	 LM9sDgt/NkLjWHK2mfG/IfFgIL6tlIm4quVE2HvdLNSS/HZk3ZM36iYxiigOY4ClJ
	 JS70rfXBlwNmSYlxwvGOyJo2xQpzWr4ar9ZMv45s5TxUiKrHavxVUMpIEjiW+fmmH
	 l5ZPIFISiCJyCuG9jw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1N6JtR-1wN3zP35Oj-00rWOi; Wed, 18
 Nov 2026 18:20:10 +0100
Message-ID: <9774f3e0-1f64-43d7-a8c5-cb61d183b31b@justus-bergermann.de>
Date: Wed, 18 Nov 2026 18:20:07 +0100
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events riscv: Add PMU events JSON file for
 T-Head C908
To: Justus Bergermann <mail@justus-bergermann.de>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20261005-c908-pmu-events-v1-1-cfab33201c59@justus-bergermann.de>
Content-Language: en-US
From: Justus Bergermann <mail@justus-bergermann.de>
In-Reply-To: <20261005-c908-pmu-events-v1-1-cfab33201c59@justus-bergermann.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/8mz3ekjXVgYBowYP8dxDvQ8Mn2oeN/Tb1+03cc6uuc9UybMciS
 buLuBC4h1TK2j/n18b01erPUgeopsd/OlMyML7nEUdQkc1ytTAIJMLenm2lKezoKMwY/pGU
 iViRdI71J+QHFtwsiaEKZmMKn8bwercrxEbDkQsryCxQVkJF/mp+URwuC73lISDoC+vR3f7
 lvo01XGVilOMMsUXohdkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IgDdIsuexY8=;50L2mMXc80gASsK0WHjVlz+tSTt
 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

Hi,

I wanted to follow up on this patch. I haven't received any feedback yet=
=20
and was wondering whether there are any comments or whether it could be=20
considered for inclusion.

Thanks,
Justus


On 05/10/2026 at 18:15, Justus Bergermann wrote:
> The XuanTie C908 cannot use the existing thead/c900-legacy event file:
> The c900-legacy mapfile entry is 0x5b7-0x0-0x0, which works because the
> c906 and c910 leave marchid and mimpid unimplemented, so both read
> as zero. The C908 implements them: a Kendryte K230 with the c908 reports
> mvendorid 0x5b7, marchid 0x8000000009140d00 and mimpid 0x50000. No entry
> matches, so perf currently resolves no vendor event names at all on this
> core.
>
> Add a thead/c908 directory describing the 165 raw events defined in
> Table 14.6 of the XuanTie C908 user manual, codes 0x01 to 0xb4, and a
> mapfile entry for the core.
>
> Signed-off-by: Justus Bergermann <mail@justus-bergermann.de>
> ---
>   tools/perf/pmu-events/arch/riscv/mapfile.csv       |   1 +
>   .../pmu-events/arch/riscv/thead/c908/cache.json    | 127 +++++
>   .../pmu-events/arch/riscv/thead/c908/firmware.json |  68 +++
>   .../arch/riscv/thead/c908/instruction.json         | 192 ++++++++
>   .../arch/riscv/thead/c908/microarch.json           | 512 +++++++++++++=
++++++++
>   5 files changed, 900 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/p=
mu-events/arch/riscv/mapfile.csv
> index 87cfb0e0849f..51d0438b9cc8 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -21,6 +21,7 @@
>   0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
>   0x5b7-0x0-0x0,v1,thead/c900-legacy,core
>   0x5b7-0x80000000090c0d00-0x2047000,v1,thead/c900-legacy,core
> +0x5b7-0x8000000009140d00-0x[[:xdigit:]]+,v1,thead/c908,core
>   0x602-0x3-0x0,v1,openhwgroup/cva6,core
>   0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
>   0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c908/cache.json b/to=
ols/perf/pmu-events/arch/riscv/thead/c908/cache.json
> new file mode 100644
> index 000000000000..052c771fbdea
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c908/cache.json
> @@ -0,0 +1,127 @@
> +[
> +  {
> +    "EventName": "L1_ICACHE_ACCESS",
> +    "EventCode": "0x00000001",
> +    "BriefDescription": "L1-icache Access"
> +  },
> +  {
> +    "EventName": "L1_ICACHE_MISS",
> +    "EventCode": "0x00000002",
> +    "BriefDescription": "L1-icache Miss"
> +  },
> +  {
> +    "EventName": "ITLB_MISS",
> +    "EventCode": "0x00000003",
> +    "BriefDescription": "iTLB Miss"
> +  },
> +  {
> +    "EventName": "JTLB_MISS",
> +    "EventCode": "0x00000005",
> +    "BriefDescription": "jTLB Miss"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_READ_ACCESS",
> +    "EventCode": "0x0000000c",
> +    "BriefDescription": "L1-dcache load access"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_READ_MISS",
> +    "EventCode": "0x0000000d",
> +    "BriefDescription": "L1-dcache load miss"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_WRITE_ACCESS",
> +    "EventCode": "0x0000000e",
> +    "BriefDescription": "L1-dcache store access"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_WRITE_MISS",
> +    "EventCode": "0x0000000f",
> +    "BriefDescription": "L1-dcache store miss"
> +  },
> +  {
> +    "EventName": "IF_REFILL_STALL",
> +    "EventCode": "0x00000051",
> +    "BriefDescription": "IF Refill Stall"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_ACCESS",
> +    "EventCode": "0x0000009b",
> +    "BriefDescription": "L1 Dcache Access"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_MISS",
> +    "EventCode": "0x0000009c",
> +    "BriefDescription": "L1 Dcache Miss"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_EXCLUSIVE_EVICTION",
> +    "EventCode": "0x0000009d",
> +    "BriefDescription": "L1 Dcache Exclusive Eviction"
> +  },
> +  {
> +    "EventName": "ICACHE_PREFETCH",
> +    "EventCode": "0x0000009e",
> +    "BriefDescription": "Icache Prefetch"
> +  },
> +  {
> +    "EventName": "DCACHE_AMR_ACTIVE",
> +    "EventCode": "0x0000009f",
> +    "BriefDescription": "Dcache Amr Active"
> +  },
> +  {
> +    "EventName": "ICACHE_PREFETCH_MISS",
> +    "EventCode": "0x000000a0",
> +    "BriefDescription": "Icache Prefetch Miss"
> +  },
> +  {
> +    "EventName": "DCACHE_REFILL_CAUSED_BY_PREFETCH",
> +    "EventCode": "0x000000a1",
> +    "BriefDescription": "Dcache Refill Caused by Prefetch"
> +  },
> +  {
> +    "EventName": "DCACHE_HIT_CAUSED_BY_PREFETCH",
> +    "EventCode": "0x000000a2",
> +    "BriefDescription": "Dcache Hit Caused by Prefetch"
> +  },
> +  {
> +    "EventName": "STORE_DTLB_MISS",
> +    "EventCode": "0x000000a3",
> +    "BriefDescription": "Store Dtlb Miss"
> +  },
> +  {
> +    "EventName": "LOAD_DTLB_MISS",
> +    "EventCode": "0x000000a4",
> +    "BriefDescription": "Load Dtlb Miss"
> +  },
> +  {
> +    "EventName": "L2_ACCESS",
> +    "EventCode": "0x000000a5",
> +    "BriefDescription": "L2 Access"
> +  },
> +  {
> +    "EventName": "L2_MISS",
> +    "EventCode": "0x000000a6",
> +    "BriefDescription": "L2 Miss"
> +  },
> +  {
> +    "EventName": "SNB_READ_CREATE_VLD",
> +    "EventCode": "0x000000a7",
> +    "BriefDescription": "Snb Read Create Vld"
> +  },
> +  {
> +    "EventName": "SNB_READ_CREATE_STALL",
> +    "EventCode": "0x000000a8",
> +    "BriefDescription": "Snb Read Create Stall"
> +  },
> +  {
> +    "EventName": "SNB_WRITE_CREATE_VLD",
> +    "EventCode": "0x000000a9",
> +    "BriefDescription": "Snb Write Create Vld"
> +  },
> +  {
> +    "EventName": "SNB_WRITE_CREATE_STALL",
> +    "EventCode": "0x000000aa",
> +    "BriefDescription": "Snb Write Create Stall"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c908/firmware.json b=
/tools/perf/pmu-events/arch/riscv/thead/c908/firmware.json
> new file mode 100644
> index 000000000000..7149caec4f80
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c908/firmware.json
> @@ -0,0 +1,68 @@
> +[
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ILLEGAL_INSN"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SET_TIMER"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c908/instruction.jso=
n b/tools/perf/pmu-events/arch/riscv/thead/c908/instruction.json
> new file mode 100644
> index 000000000000..401544f1d15e
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c908/instruction.json
> @@ -0,0 +1,192 @@
> +[
> +  {
> +    "EventName": "CONDITION_BRANCH_MISPRED",
> +    "EventCode": "0x00000006",
> +    "BriefDescription": "Condition Branch Mispred"
> +  },
> +  {
> +    "EventName": "CONDITION_BRANCH",
> +    "EventCode": "0x00000007",
> +    "BriefDescription": "Condition Branch"
> +  },
> +  {
> +    "EventName": "INDIRECT_BRANCH_MISS",
> +    "EventCode": "0x00000008",
> +    "BriefDescription": "Indirect Branch Miss"
> +  },
> +  {
> +    "EventName": "INDIRECT_BRANCH",
> +    "EventCode": "0x00000009",
> +    "BriefDescription": "Indirect Branch"
> +  },
> +  {
> +    "EventName": "INST_STORE",
> +    "EventCode": "0x0000000b",
> +    "BriefDescription": "Store Instruction"
> +  },
> +  {
> +    "EventName": "ISSUE_INSTRUCTION",
> +    "EventCode": "0x00000016",
> +    "BriefDescription": "Issue Instruction"
> +  },
> +  {
> +    "EventName": "INST_ALU",
> +    "EventCode": "0x0000001d",
> +    "BriefDescription": "ALU Instruction"
> +  },
> +  {
> +    "EventName": "INST_VECTOR",
> +    "EventCode": "0x0000001f",
> +    "BriefDescription": "Vector SIMD Instruction"
> +  },
> +  {
> +    "EventName": "INST_CSR",
> +    "EventCode": "0x00000020",
> +    "BriefDescription": "CSR Instruction"
> +  },
> +  {
> +    "EventName": "ATOMIC_INSTRUCTION",
> +    "EventCode": "0x00000021",
> +    "BriefDescription": "ATOMIC Instruction"
> +  },
> +  {
> +    "EventName": "INST_ECALL",
> +    "EventCode": "0x00000025",
> +    "BriefDescription": "Environment Call"
> +  },
> +  {
> +    "EventName": "INST_LONG_JP",
> +    "EventCode": "0x00000026",
> +    "BriefDescription": "Long Jump"
> +  },
> +  {
> +    "EventName": "INST_FP",
> +    "EventCode": "0x0000002a",
> +    "BriefDescription": "Float Point Instruction"
> +  },
> +  {
> +    "EventName": "LOAD_INSTRUCTION",
> +    "EventCode": "0x00000030",
> +    "BriefDescription": "LOAD Instruction"
> +  },
> +  {
> +    "EventName": "FUSED_INSTRUCTION",
> +    "EventCode": "0x00000031",
> +    "BriefDescription": "Fused Instruction"
> +  },
> +  {
> +    "EventName": "MULT_INSTRUCTION",
> +    "EventCode": "0x00000032",
> +    "BriefDescription": "MULT Instruction"
> +  },
> +  {
> +    "EventName": "DIV_INSTRUCTION",
> +    "EventCode": "0x00000033",
> +    "BriefDescription": "DIV Instruction"
> +  },
> +  {
> +    "EventName": "BRANCH_INSTRUCTION",
> +    "EventCode": "0x00000036",
> +    "BriefDescription": "Branch Instruction"
> +  },
> +  {
> +    "EventName": "UNCONDITION_BRANCH",
> +    "EventCode": "0x00000037",
> +    "BriefDescription": "Uncondition Branch"
> +  },
> +  {
> +    "EventName": "BRANCH_MISPRED",
> +    "EventCode": "0x00000038",
> +    "BriefDescription": "Branch Mispred"
> +  },
> +  {
> +    "EventName": "UNCONDITION_BRANCH_MISPRED",
> +    "EventCode": "0x00000039",
> +    "BriefDescription": "Uncondition Branch Mispred"
> +  },
> +  {
> +    "EventName": "TAKEN_BRANCH_MISPRED",
> +    "EventCode": "0x0000003a",
> +    "BriefDescription": "Taken Branch Mispred"
> +  },
> +  {
> +    "EventName": "TAKEN_CONDITION_BRANCH",
> +    "EventCode": "0x0000003b",
> +    "BriefDescription": "Taken Condition Branch"
> +  },
> +  {
> +    "EventName": "TAKEN_CONDITION_BRANCH_MISPRED",
> +    "EventCode": "0x0000003c",
> +    "BriefDescription": "Taken Condition Branch Mispred"
> +  },
> +  {
> +    "EventName": "UNALIGN_LOAD_INSTRUCTION",
> +    "EventCode": "0x0000003d",
> +    "BriefDescription": "Unalign LOAD Instruction"
> +  },
> +  {
> +    "EventName": "UNALIGN_STORE_INSTRUCTION",
> +    "EventCode": "0x0000003e",
> +    "BriefDescription": "Unalign STORE Instruction"
> +  },
> +  {
> +    "EventName": "LR_INSTRUCTION",
> +    "EventCode": "0x0000003f",
> +    "BriefDescription": "LR Instruction"
> +  },
> +  {
> +    "EventName": "SC_INSTRUCTION",
> +    "EventCode": "0x00000040",
> +    "BriefDescription": "SC Instruction"
> +  },
> +  {
> +    "EventName": "AMO_INSTRUCTION",
> +    "EventCode": "0x00000041",
> +    "BriefDescription": "AMO Instruction"
> +  },
> +  {
> +    "EventName": "BARRIER_INSTRUCTION",
> +    "EventCode": "0x00000042",
> +    "BriefDescription": "Barrier Instruction"
> +  },
> +  {
> +    "EventName": "FAILED_SC_INSTRUCTION",
> +    "EventCode": "0x00000043",
> +    "BriefDescription": "Failed SC Instruction"
> +  },
> +  {
> +    "EventName": "FP_DIV_INSTRUCTION",
> +    "EventCode": "0x00000045",
> +    "BriefDescription": "FP DIV Instruction"
> +  },
> +  {
> +    "EventName": "FP_LOAD_INSTRUCTION",
> +    "EventCode": "0x00000046",
> +    "BriefDescription": "FP LOAD Instruction"
> +  },
> +  {
> +    "EventName": "FP_STORE_INSTRUCTION",
> +    "EventCode": "0x00000047",
> +    "BriefDescription": "FP STORE Instruction"
> +  },
> +  {
> +    "EventName": "VECTOR_DIV_INSTRUCTION",
> +    "EventCode": "0x00000048",
> +    "BriefDescription": "Vector DIV Instruction"
> +  },
> +  {
> +    "EventName": "VECTOR_LOAD_INSTRUCTION",
> +    "EventCode": "0x00000049",
> +    "BriefDescription": "Vector LOAD Instruction"
> +  },
> +  {
> +    "EventName": "VECTOR_STORE_INSTRUCTION",
> +    "EventCode": "0x0000004a",
> +    "BriefDescription": "Vector STORE Instruction"
> +  },
> +  {
> +    "EventName": "VECTOR_MICRO_OP",
> +    "EventCode": "0x0000004b",
> +    "BriefDescription": "Vector Micro Op"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c908/microarch.json =
b/tools/perf/pmu-events/arch/riscv/thead/c908/microarch.json
> new file mode 100644
> index 000000000000..35d344e1f8f1
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c908/microarch.json
> @@ -0,0 +1,512 @@
> +[
> +  {
> +    "EventName": "IFU_BRANCH_TARGET_MISPRED",
> +    "EventCode": "0x0000001b",
> +    "BriefDescription": "IFU Branch Target Mispred"
> +  },
> +  {
> +    "EventName": "IFU_BRANCH_TARGET_INSTRUCTION",
> +    "EventCode": "0x0000001c",
> +    "BriefDescription": "IFU Branch Target Instruction"
> +  },
> +  {
> +    "EventName": "INTERRUPT_NUMBER",
> +    "EventCode": "0x00000023",
> +    "BriefDescription": "Interrupt Number"
> +  },
> +  {
> +    "EventName": "IFU_STALLED_CYCLE",
> +    "EventCode": "0x00000027",
> +    "BriefDescription": "Stalled Cycles Frontend"
> +  },
> +  {
> +    "EventName": "IDU_STALLED_CYCLE",
> +    "EventCode": "0x00000028",
> +    "BriefDescription": "Stalled Cycles Backend"
> +  },
> +  {
> +    "EventName": "SYNC_STALL",
> +    "EventCode": "0x00000029",
> +    "BriefDescription": "SYNC Stall"
> +  },
> +  {
> +    "EventName": "M_MODE_CYCLES",
> +    "EventCode": "0x0000002b",
> +    "BriefDescription": "M Mode Cycles"
> +  },
> +  {
> +    "EventName": "S_MODE_CYCLES",
> +    "EventCode": "0x0000002c",
> +    "BriefDescription": "S Mode Cycles"
> +  },
> +  {
> +    "EventName": "U_MODE_CYCLES",
> +    "EventCode": "0x0000002d",
> +    "BriefDescription": "U Mode Cycles"
> +  },
> +  {
> +    "EventName": "EXCEPTION_NUMBER",
> +    "EventCode": "0x0000002e",
> +    "BriefDescription": "Exception Number"
> +  },
> +  {
> +    "EventName": "FLUSH_NUMBER",
> +    "EventCode": "0x0000002f",
> +    "BriefDescription": "Flush Number"
> +  },
> +  {
> +    "EventName": "MULT_INNER_FORWARD",
> +    "EventCode": "0x00000034",
> +    "BriefDescription": "Mult Inner Forward"
> +  },
> +  {
> +    "EventName": "DIV_BUFFER_HIT",
> +    "EventCode": "0x00000035",
> +    "BriefDescription": "DIV Buffer Hit"
> +  },
> +  {
> +    "EventName": "BUS_BARRIER",
> +    "EventCode": "0x00000044",
> +    "BriefDescription": "Bus Barrier"
> +  },
> +  {
> +    "EventName": "ECC_INTERRUPT",
> +    "EventCode": "0x0000004c",
> +    "BriefDescription": "ECC Interrupt"
> +  },
> +  {
> +    "EventName": "ASYNC_ABORT_INTERRUPT",
> +    "EventCode": "0x0000004d",
> +    "BriefDescription": "Async Abort Interrupt"
> +  },
> +  {
> +    "EventName": "IF_STALL",
> +    "EventCode": "0x0000004e",
> +    "BriefDescription": "IF Stall"
> +  },
> +  {
> +    "EventName": "IP_STALL",
> +    "EventCode": "0x0000004f",
> +    "BriefDescription": "IP Stall"
> +  },
> +  {
> +    "EventName": "IB_STALL",
> +    "EventCode": "0x00000050",
> +    "BriefDescription": "IB Stall"
> +  },
> +  {
> +    "EventName": "IF_MMU_STALL",
> +    "EventCode": "0x00000052",
> +    "BriefDescription": "IF Mmu Stall"
> +  },
> +  {
> +    "EventName": "IB_MISPRED_STALL",
> +    "EventCode": "0x00000053",
> +    "BriefDescription": "IB Mispred Stall"
> +  },
> +  {
> +    "EventName": "IB_FIFO_STALL",
> +    "EventCode": "0x00000054",
> +    "BriefDescription": "IB Fifo Stall"
> +  },
> +  {
> +    "EventName": "IB_IND_BTB_RD_STALL",
> +    "EventCode": "0x00000055",
> +    "BriefDescription": "IB Ind Btb Rd Stall"
> +  },
> +  {
> +    "EventName": "IB_VSETVL_STALL",
> +    "EventCode": "0x00000056",
> +    "BriefDescription": "IB Vsetvl Stall"
> +  },
> +  {
> +    "EventName": "ID_STALL",
> +    "EventCode": "0x00000057",
> +    "BriefDescription": "ID Stall"
> +  },
> +  {
> +    "EventName": "RF_STALL",
> +    "EventCode": "0x00000058",
> +    "BriefDescription": "RF Stall"
> +  },
> +  {
> +    "EventName": "EU_STALL",
> +    "EventCode": "0x00000059",
> +    "BriefDescription": "EU Stall"
> +  },
> +  {
> +    "EventName": "ID_INST_PIPEDOWN",
> +    "EventCode": "0x0000005a",
> +    "BriefDescription": "ID Inst Pipedown"
> +  },
> +  {
> +    "EventName": "RF_INST_PIPEDOWN",
> +    "EventCode": "0x0000005b",
> +    "BriefDescription": "RF Inst Pipedown"
> +  },
> +  {
> +    "EventName": "ID_ONE_INST_PIPEDOWN",
> +    "EventCode": "0x0000005c",
> +    "BriefDescription": "ID One Inst Pipedown"
> +  },
> +  {
> +    "EventName": "ID_CSR_BEFORE_FENCE_STALL",
> +    "EventCode": "0x0000005d",
> +    "BriefDescription": "ID CSR Before Fence Stall"
> +  },
> +  {
> +    "EventName": "ID_VSETVL_FOF_STALL",
> +    "EventCode": "0x0000005e",
> +    "BriefDescription": "ID VSETVL Fof Stall"
> +  },
> +  {
> +    "EventName": "ID_FLUSH_STALL",
> +    "EventCode": "0x0000005f",
> +    "BriefDescription": "ID Flush Stall"
> +  },
> +  {
> +    "EventName": "ID_MISPREDICTION_STALL",
> +    "EventCode": "0x00000060",
> +    "BriefDescription": "ID Misprediction Stall"
> +  },
> +  {
> +    "EventName": "ID_IID_NOT_VLD_STALL",
> +    "EventCode": "0x00000061",
> +    "BriefDescription": "ID IID Not Vld Stall"
> +  },
> +  {
> +    "EventName": "RF_ONE_INST_PIPEDOWN",
> +    "EventCode": "0x00000062",
> +    "BriefDescription": "RF One Inst Pipedown"
> +  },
> +  {
> +    "EventName": "RF_RAW_STALL",
> +    "EventCode": "0x00000063",
> +    "BriefDescription": "RF RAW Stall"
> +  },
> +  {
> +    "EventName": "RF_WAW_STALL",
> +    "EventCode": "0x00000064",
> +    "BriefDescription": "RF WAW Stall"
> +  },
> +  {
> +    "EventName": "RF_STRUCTURE_STALL",
> +    "EventCode": "0x00000065",
> +    "BriefDescription": "RF Structure Stall"
> +  },
> +  {
> +    "EventName": "RF_CSR_AFTER_FENCE_STALL",
> +    "EventCode": "0x00000066",
> +    "BriefDescription": "RF CSR After Fence Stall"
> +  },
> +  {
> +    "EventName": "EU_IU_FULL",
> +    "EventCode": "0x00000067",
> +    "BriefDescription": "EU IU Full"
> +  },
> +  {
> +    "EventName": "EU_IU_CONTROL_FULL",
> +    "EventCode": "0x00000068",
> +    "BriefDescription": "EU IU Control Full"
> +  },
> +  {
> +    "EventName": "EU_CP0_FULL",
> +    "EventCode": "0x00000069",
> +    "BriefDescription": "EU CP0 Full"
> +  },
> +  {
> +    "EventName": "EU_LSU_LOAD_FULL",
> +    "EventCode": "0x0000006a",
> +    "BriefDescription": "EU LSU LOAD Full"
> +  },
> +  {
> +    "EventName": "EU_LSU_STORE_FULL",
> +    "EventCode": "0x0000006b",
> +    "BriefDescription": "EU LSU STORE Full"
> +  },
> +  {
> +    "EventName": "EU_VFPU_FULL",
> +    "EventCode": "0x0000006c",
> +    "BriefDescription": "EU VFPU Full"
> +  },
> +  {
> +    "EventName": "EU_BJU_FULL",
> +    "EventCode": "0x0000006d",
> +    "BriefDescription": "EU BJU Full"
> +  },
> +  {
> +    "EventName": "IU_DP_STALL_PIPE0",
> +    "EventCode": "0x0000006e",
> +    "BriefDescription": "IU Dp Stall Pipe0"
> +  },
> +  {
> +    "EventName": "IU_MULT_STALL_PIPE0",
> +    "EventCode": "0x0000006f",
> +    "BriefDescription": "IU MULT Stall Pipe0"
> +  },
> +  {
> +    "EventName": "IU_DIV_EX1_STALL_PIPE0",
> +    "EventCode": "0x00000070",
> +    "BriefDescription": "IU DIV EX1 Stall Pipe0"
> +  },
> +  {
> +    "EventName": "IU_DP_STALL_PIPE1",
> +    "EventCode": "0x00000071",
> +    "BriefDescription": "IU Dp Stall Pipe1"
> +  },
> +  {
> +    "EventName": "IU_MULT_STALL_PIPE1",
> +    "EventCode": "0x00000072",
> +    "BriefDescription": "IU MULT Stall Pipe1"
> +  },
> +  {
> +    "EventName": "IU_DIV_EX1_STALL_PIPE1",
> +    "EventCode": "0x00000073",
> +    "BriefDescription": "IU DIV EX1 Stall Pipe1"
> +  },
> +  {
> +    "EventName": "IU_DP_WB_CONFLICT_PIPE0",
> +    "EventCode": "0x00000074",
> +    "BriefDescription": "IU DP Wb Conflict Pipe0"
> +  },
> +  {
> +    "EventName": "IU_DP_WAW_STALL_PIPE0",
> +    "EventCode": "0x00000075",
> +    "BriefDescription": "IU DP WAW Stall Pipe0"
> +  },
> +  {
> +    "EventName": "IU_DP_UNCOMMIT_PIPE0",
> +    "EventCode": "0x00000076",
> +    "BriefDescription": "IU DP Uncommit Pipe0"
> +  },
> +  {
> +    "EventName": "IU_DP_WB_CONFLICT_PIPE1",
> +    "EventCode": "0x00000077",
> +    "BriefDescription": "IU DP Wb Conflict Pipe1"
> +  },
> +  {
> +    "EventName": "IU_DP_WAW_STALL_PIPE1",
> +    "EventCode": "0x00000078",
> +    "BriefDescription": "IU DP WAW Stall Pipe1"
> +  },
> +  {
> +    "EventName": "IU_DP_UNCOMMIT_PIPE1",
> +    "EventCode": "0x00000079",
> +    "BriefDescription": "IU DP Uncommit Pipe1"
> +  },
> +  {
> +    "EventName": "IU_MULT_UNCOMMIT",
> +    "EventCode": "0x0000007a",
> +    "BriefDescription": "IU MULT Uncommit"
> +  },
> +  {
> +    "EventName": "IU_MULT_WB_STALL",
> +    "EventCode": "0x0000007b",
> +    "BriefDescription": "IU MULT Wb Stall"
> +  },
> +  {
> +    "EventName": "IU_DIV_UNCOMMIT",
> +    "EventCode": "0x0000007c",
> +    "BriefDescription": "IU DIV Uncommit"
> +  },
> +  {
> +    "EventName": "IU_DIV_WB_STALL",
> +    "EventCode": "0x0000007d",
> +    "BriefDescription": "IU DIV Wb Stall"
> +  },
> +  {
> +    "EventName": "LSU_LOAD_WAW_STALL",
> +    "EventCode": "0x0000007e",
> +    "BriefDescription": "LSU LOAD WAW Stall"
> +  },
> +  {
> +    "EventName": "LSU_LOAD_COMMIT_STALL",
> +    "EventCode": "0x0000007f",
> +    "BriefDescription": "LSU LOAD Commit Stall"
> +  },
> +  {
> +    "EventName": "LSU_LOAD_RAW_STALL",
> +    "EventCode": "0x00000080",
> +    "BriefDescription": "LSU LOAD RAW Stall"
> +  },
> +  {
> +    "EventName": "LSU_STORE_COMMIT_STALL",
> +    "EventCode": "0x00000081",
> +    "BriefDescription": "LSU STORE Commit Stall"
> +  },
> +  {
> +    "EventName": "VIDU_RF_NO_PIPEDOWN",
> +    "EventCode": "0x00000082",
> +    "BriefDescription": "Vidu Rf No Pipedown"
> +  },
> +  {
> +    "EventName": "VPU_STALL_PIPE0",
> +    "EventCode": "0x00000083",
> +    "BriefDescription": "VPU Stall Pipe0"
> +  },
> +  {
> +    "EventName": "VPU_STALL_PIPE1",
> +    "EventCode": "0x00000084",
> +    "BriefDescription": "VPU Stall Pipe1"
> +  },
> +  {
> +    "EventName": "VPU_STRUCT_HAZARD_STALL_PIPE0",
> +    "EventCode": "0x00000085",
> +    "BriefDescription": "VPU Struct Hazard Stall Pipe0"
> +  },
> +  {
> +    "EventName": "VPU_UNCOMMIT_STALL_PIPE0",
> +    "EventCode": "0x00000086",
> +    "BriefDescription": "VPU Uncommit Stall Pipe0"
> +  },
> +  {
> +    "EventName": "VPU_VLSU_STALL_PIPE0",
> +    "EventCode": "0x00000087",
> +    "BriefDescription": "VPU VLSU Stall Pipe0"
> +  },
> +  {
> +    "EventName": "VPU_STRUCT_HAZARD_STALL_PIPE1",
> +    "EventCode": "0x00000088",
> +    "BriefDescription": "VPU Struct Hazard Stall Pipe1"
> +  },
> +  {
> +    "EventName": "VPU_UNCOMMIT_STALL_PIPE1",
> +    "EventCode": "0x00000089",
> +    "BriefDescription": "VPU Uncommit Stall Pipe1"
> +  },
> +  {
> +    "EventName": "VPU_VLSU_STALL_PIPE1",
> +    "EventCode": "0x0000008a",
> +    "BriefDescription": "VPU VLSU Stall Pipe1"
> +  },
> +  {
> +    "EventName": "VFPU_FDIV_VDIV_BUSY",
> +    "EventCode": "0x0000008b",
> +    "BriefDescription": "VFPU FDIV/VDIV Busy"
> +  },
> +  {
> +    "EventName": "BJU_CP0_STALL",
> +    "EventCode": "0x0000008c",
> +    "BriefDescription": "BJU CP0 Stall"
> +  },
> +  {
> +    "EventName": "BJU_IBUF_STALL",
> +    "EventCode": "0x0000008d",
> +    "BriefDescription": "BJU IBUF Stall"
> +  },
> +  {
> +    "EventName": "BJU_WB_STALL",
> +    "EventCode": "0x0000008e",
> +    "BriefDescription": "BJU Wb Stall"
> +  },
> +  {
> +    "EventName": "BJU_PIPEDOWN_STALL",
> +    "EventCode": "0x0000008f",
> +    "BriefDescription": "BJU Pipedown Stall"
> +  },
> +  {
> +    "EventName": "RTU_FLUSH",
> +    "EventCode": "0x00000090",
> +    "BriefDescription": "RTU Flush"
> +  },
> +  {
> +    "EventName": "RTU_IU_NOT_NO_OP",
> +    "EventCode": "0x00000091",
> +    "BriefDescription": "RTU IU Not No OP"
> +  },
> +  {
> +    "EventName": "RTU_BJU_NOT_NO_OP",
> +    "EventCode": "0x00000092",
> +    "BriefDescription": "RTU BJU Not No OP"
> +  },
> +  {
> +    "EventName": "RTU_LSU_NOT_NO_OP",
> +    "EventCode": "0x00000093",
> +    "BriefDescription": "RTU LSU Not No OP"
> +  },
> +  {
> +    "EventName": "RTU_CP0_NOT_NO_OP",
> +    "EventCode": "0x00000094",
> +    "BriefDescription": "RTU CP0 Not No OP"
> +  },
> +  {
> +    "EventName": "RTU_VFPU_NOT_NO_OP",
> +    "EventCode": "0x00000095",
> +    "BriefDescription": "RTU VFPU Not No OP"
> +  },
> +  {
> +    "EventName": "RTU_ONLY_IU_NOT_NO_OP",
> +    "EventCode": "0x00000096",
> +    "BriefDescription": "RTU Only IU Not No OP"
> +  },
> +  {
> +    "EventName": "RTU_ONLY_BJU_NOT_NO_OP",
> +    "EventCode": "0x00000097",
> +    "BriefDescription": "RTU Only BJU Not No OP"
> +  },
> +  {
> +    "EventName": "RTU_ONLY_LSU_NOT_NO_OP",
> +    "EventCode": "0x00000098",
> +    "BriefDescription": "RTU Only LSU Not No OP"
> +  },
> +  {
> +    "EventName": "RTU_ONLY_CP0_NOT_NO_OP",
> +    "EventCode": "0x00000099",
> +    "BriefDescription": "RTU Only CP0 Not No OP"
> +  },
> +  {
> +    "EventName": "RTU_ONLY_VFPU_NOT_NO_OP",
> +    "EventCode": "0x0000009a",
> +    "BriefDescription": "RTU Only VFPU Not No OP"
> +  },
> +  {
> +    "EventName": "IQ_FULL",
> +    "EventCode": "0x000000ab",
> +    "BriefDescription": "Iq Full"
> +  },
> +  {
> +    "EventName": "VIDU_VEC0_STALL",
> +    "EventCode": "0x000000ac",
> +    "BriefDescription": "Vidu Vec0 Stall"
> +  },
> +  {
> +    "EventName": "VIDU_VEC1_STALL",
> +    "EventCode": "0x000000ad",
> +    "BriefDescription": "Vidu Vec1 Stall"
> +  },
> +  {
> +    "EventName": "VIDU_VEC0_DEPEND_STALL",
> +    "EventCode": "0x000000ae",
> +    "BriefDescription": "Vidu Vec0 Depend Stall"
> +  },
> +  {
> +    "EventName": "VIDU_VEC0_STRUCT_HAZARD_STALL",
> +    "EventCode": "0x000000af",
> +    "BriefDescription": "Vidu Vec0 Struct Hazard Stall"
> +  },
> +  {
> +    "EventName": "VIDU_VEC1_DEPEND_STALL",
> +    "EventCode": "0x000000b0",
> +    "BriefDescription": "Vidu Vec1 Depend Stall"
> +  },
> +  {
> +    "EventName": "VIDU_VEC1_STRUCT_HAZARD_STALL",
> +    "EventCode": "0x000000b1",
> +    "BriefDescription": "Vidu Vec1 Struct Hazard Stall"
> +  },
> +  {
> +    "EventName": "VIDU_TOTAL_CYCLE",
> +    "EventCode": "0x000000b2",
> +    "BriefDescription": "Vidu Total Cycle"
> +  },
> +  {
> +    "EventName": "VIDU_VEC0_CYCLE",
> +    "EventCode": "0x000000b3",
> +    "BriefDescription": "Vidu Vec0 Cycle"
> +  },
> +  {
> +    "EventName": "VIDU_VEC1_CYCLE",
> +    "EventCode": "0x000000b4",
> +    "BriefDescription": "Vidu Vec1 Cycle"
> +  }
> +]
>
> ---
> base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
> change-id: 20261005-c908-pmu-events-59219f7d3c82
>
> Best regards,
> --
> Justus Bergermann <mail@justus-bergermann.de>

