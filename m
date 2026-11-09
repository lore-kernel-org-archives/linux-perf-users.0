Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209127;
	b=dm0uqkGjgTAS+04nLXCktaDdT5fzPsWIpm8qXsf3qUUsYOdnlW5QMRAT0m4vqRP0m4Zm
	 PNoi9M1IGW16A1E/r5g1E/B4ghAvF1niSY+pvcH79+iQvUTFCBdQVdVp2WD92enKWOBMG
	 fRHyh+5MxZ0mjaXjsmfOivFN5AZOKmt2W3diqz6gYQ+HXU0kxn6D4M1Eg/W/SlrHGP2xj
	 3KlAE95/PIQkQqjZLQYec3Ill8FeVg9GfTfMCD/ctWZ2sa/QyZH7e0ryknGkrweTsMWpL
	 dFdyF+i6+8cAHLFi/jDM7eVQrkxOnSc/7F6FLoaJJyLRR1sOG7Ipajmm4fvCV7xnbIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=m2+HhGSoLvri6g/jgXlGvQXUh65ejG4bbvdXJ+M0m3A=;
	b=c3+lbdHNk3CMml8cop7KviHXEI+q4StX4p44ZhLFBlS5jsQ+cFrT+/KP5MJ5nLMljtDk
	 1IUojziEroj0BSd2034fqyvRU14TQZtjVOhwLyLIzYEvyiZAqxSn2sKZi81FQk5aDmY2/
	 gfKYxkdGhU+qj2gIuEYfT3++7HMLdpoolAVOLPZqywL6Lnze2rbqNxIHUxxSz8Fdahxkf
	 IloVtAEM4OXVw5SY3VFacBgcu4cGZu+oO3rOo7Pa6HQpgYwsUxb6/wozSbM8QdBhrzgXT
	 0kD5kkw4K0ShvcgAbWbvMBdZi4Fs3vKuMsSIb0iLFtMURMBTk+nUeJK/sKvtcviqIcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khUdSO28;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E8606A323
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 07:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B20E8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khUdSO28
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed06b725fdso3794335ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Nov 2026 23:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794209125; x=1794813925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m2+HhGSoLvri6g/jgXlGvQXUh65ejG4bbvdXJ+M0m3A=;
        b=khUdSO281XpsB78bgJl/LaN7lDl87BekWETEOMsubR/TYBOFGvQI/jhdGJECEqF4lQ
         KkUTqF5F4XZuaRq34YFzBM5b6Ijr5zxN9kX5MWiCU/sVzL3rh2crtnLrIjg4SJxyWRdm
         zMBpczu0UVJsiYJYA9R98Q/lgyOgv138DpvoIvmZkNswJgl/eGvjk0vLplbqG+4cMFMb
         DLDhDR8XTWKVcfU/JgI29bylnvfrMs1GVlLIzHZLngjQwmEzFYSB9y4sC0t/XmeXyI8R
         Iadd2Xm1hFWFDXPu3PDZipNiV6eSM3vTdtNLvUCy5sXzfJHK9/y2Hr4PAeaD7WDew3h1
         UwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794209125; x=1794813925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2+HhGSoLvri6g/jgXlGvQXUh65ejG4bbvdXJ+M0m3A=;
        b=ScVEslHYkMt3/t+3rdb1BPlJlaWriISoS/zUYMLML4kFNBh9WLSo+iViWmVkDAwlB7
         MVkpMF55+7b0xDSshffQ1+Li3Wq3SPwjZz5q6VMg96OYIffqjrlCN2mwAgzoQozGUeEF
         iVtewuKLUrMTJTn7JEE0ZJ1dgfZrr9RYWSOThs3xLc3AbmVCOzzdjAv/iWjvIxPd7b24
         lE3dSPTkffTLcmAWBAfBUoGF26f2BdEocy4pK9Ira/XVAp6wYicypuMW2CDfcvzWRXfI
         tBGJxYgK7zgK5IpR7OSaZalmHip2pBmRESUWlQK/KZ2DXHr2TPR9NZwLEeQE0ofUpKLN
         vLhw==
X-Forwarded-Encrypted: i=1; AL+hErHG/b6G4CQQggdZRtQcOGOf8QBgm0IOYB7eiknIMEM4NjxGvkLzeU0mCc4JRV4cqhvFpLvl9H9I1A6VY6pm3hQJ@vger.kernel.org
X-Gm-Message-State: APuU4Z9T0GH+SLDhunfn7j7vwl0eN3CkmP/znRHvwQ0ID3CrELS1X3XZ
	/lFrd4lZL9AiEZQnJ2QetISJ/H12NukOmjr7281gB1r05+vbUeU59joG
X-Gm-Gg: AYBFou0G7dE7w5RhAonOOPUXb5VdFKAmjKKQy1hLgrfPAxRJ9YeEzZsVygTUkprW3WE
	O7LXotH207jnrpC5bmdND/jxlwrteIIWqVE2MOB65uqzjd+liGBSpx/ZyfIvu5n3x+7v2590Ujq
	XmY+BAaxCRY5mUW4goyRQzvpk0BRWXMLmCPYKOrnkyeJQATPfBtpXZBqF/YqH12UQemulyc9mUC
	tveo084HbymPklD/D/CXhKyBxoRJzNQxAZf+jv3i9pgsOVrsFT6tD7d/hxjQPYvgy3Qjus0eKJg
	+ygETm5KgZ1ll90i5wpu2ZLOJQg7Q0MeQDh3M3+4JAF/JqbARz+//xwEzJeEAUHGbpyVDocayb6
	WgOfyko+Z07g2KdrIYqpQyMoqe8PyLSnZRh/H7yUBaFb5N8fuGIKc0LNkeBqCpe4WqiA39NZfva
	q4fFJSXHoAEFrSIXKxQ4cZTNyuKkcirOI6SOUk1Gfz3DfevFJ0pDMz/HWs9LAksUl/nyC2wA/+6
	0A4P5iVtDMSuY5onq0becutqrpsgONrxAOf9ULeQynUIdSV7GztkjKucpsnJVx8XJaE5XcFigY+
	1dBP2qMEwyufDcp85NsN9/1/BNoBsyrU00diyY8q2OHpTPKy
X-Received: by 2002:a17:902:f70f:b0:2e9:528c:b9ea with SMTP id d9443c01a7336-2ed8373fe40mr22868395ad.11.1794209124729;
        Sun, 08 Nov 2026 23:25:24 -0800 (PST)
Received: from localhost ([2001:19f0:8000:3bef:5400:6ff:fef9:667])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed815e7416sm8144945ad.17.2026.11.08.23.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:25:24 -0800 (PST)
Date: Mon, 9 Nov 2026 15:25:06 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "GUO Ren (XuanTie)" <guoren@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, Chen Pei <cp0613@linux.alibaba.com>
Subject: Re: [PATCH v3] perf vendor events riscv: Add C-SKY C930 JSON file
Message-ID: <avF0-Rp6w1g3ZN9M@inochi.infowork>
References: <20261105-csky_c930_pmu-v3-1-3f33e6b3d259@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-csky_c930_pmu-v3-1-3f33e6b3d259@kernel.org>

On Thu, Nov 05, 2026 at 06:31:20AM +0000, GUO Ren (XuanTie) wrote:
> From: Chen Pei <cp0613@linux.alibaba.com>
> 
> Add PMU event descriptions for the C-SKY C930 core so perf can list and
> select its hardware events by name instead of requiring raw event codes.
> The events cover core counters, branch prediction, instruction fetch,
> integer execution, load/store operations, vector and floating-point
> execution, caches and TLBs.
> 
> Add a mapfile.csv entry matching mvendorid 0x5b7 and marchid
> 0x8000000009201600, allowing any mimpid, to select the C930 event table.
> 
> For example:
> 
> perf stat -e cache.l1d.rd.miss,tlb.l1d.miss ./workload
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>

LGTM.

Reviewed-by: Inochi Amaot <inochiama@gmail.com>

Regards,
Inochi

> ---
> XuanTie is the RISC-V processor brand of C-SKY Microsystems Co., Ltd.
> [2]. JEDEC JEP106AB lists C-SKY Microsystems Co., Ltd. as the manufacturer
> associated with ID 0x5b7 [3]. Accordingly, use C-SKY in the patch title
> and csky/ as the vendor directory.
> 
> This revision is limited to the PMU event descriptions from v2 3/4.
> perf selects the event table by matching mvendorid, marchid and mimpid,
> so the DT binding additions are not required for this patch. The
> derived metrics patch is also omitted from this revision.
> 
> Changes in v3:
>  - Repost only the PMU event patch. Omit the DT binding patches
>    (v2 1/4 and 2/4) and the derived metrics patch (v2 4/4).
>  - Rename the vendor directory from xuantie/ to csky/ and update the
>    mapfile.csv entry accordingly.
>  - Change the patch title to "Add C-SKY C930 PMU events".
>  - Drop the topdown.* events, uop.spec, uop.ret, ieu.de.inst_cnt,
>    ieu.rn.inst_cnt and vfpu_ex1_rep.
> 
> Changes in v2:
> v2: https://lore.kernel.org/linux-riscv/20251121063439.2545-1-cp0613@linux.alibaba.com/
>  - Vendor name update.
> 
> Previous versions:
> v1: https://lore.kernel.org/linux-riscv/20250910121121.7203-1-cp0613@linux.alibaba.com/
> 
> References:
> [1] https://www.xrvm.com/product/xuantie/C930
> [2] https://www.xrvm.com/declaration
> [3] https://www.jedec.org/standards-documents/docs/jep-106ab
> ---
>  .../pmu-events/arch/riscv/csky/c930/basic.json     |  82 ++++++++++
>  .../perf/pmu-events/arch/riscv/csky/c930/ieu.json  |  47 ++++++
>  .../perf/pmu-events/arch/riscv/csky/c930/ifu.json  |  62 ++++++++
>  .../perf/pmu-events/arch/riscv/csky/c930/l2c.json  |  62 ++++++++
>  .../perf/pmu-events/arch/riscv/csky/c930/lsu.json  | 137 +++++++++++++++++
>  .../perf/pmu-events/arch/riscv/csky/c930/vfpu.json | 167 +++++++++++++++++++++
>  tools/perf/pmu-events/arch/riscv/mapfile.csv       |   1 +
>  7 files changed, 558 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/riscv/csky/c930/basic.json b/tools/perf/pmu-events/arch/riscv/csky/c930/basic.json
> new file mode 100644
> index 000000000000..a65b90a682ab
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/csky/c930/basic.json
> @@ -0,0 +1,82 @@
> +[
> +    {
> +        "EventName": "cycles.hart",
> +        "EventCode": "0x00000001",
> +        "BriefDescription": "CPU cycles, incremented on every CPU clock cycle"
> +    },
> +    {
> +        "EventName": "inst.ret",
> +        "EventCode": "0x00000002",
> +        "BriefDescription": "Instruction architecturally executed"
> +    },
> +    {
> +        "EventName": "inst.brjmp.spec",
> +        "EventCode": "0x00000003",
> +        "BriefDescription": "Control transfer instructions"
> +    },
> +    {
> +        "EventName": "inst.mispred.brjmp.spec",
> +        "EventCode": "0x00000004",
> +        "BriefDescription": "Control transfer instructions that mispredicted"
> +    },
> +    {
> +        "EventName": "cache.l1i.rd.access",
> +        "EventCode": "0x00000005",
> +        "BriefDescription": "Instruction Cache accesses"
> +    },
> +    {
> +        "EventName": "cache.l1i.rd.miss",
> +        "EventCode": "0x00000006",
> +        "BriefDescription": "Instruction Cache misses"
> +    },
> +    {
> +        "EventName": "cache.l1d.rd.access",
> +        "EventCode": "0x00000007",
> +        "BriefDescription": "Data Cache load accesses"
> +    },
> +    {
> +        "EventName": "cache.l1d.rd.miss",
> +        "EventCode": "0x00000008",
> +        "BriefDescription": "Data Cache load misses"
> +    },
> +    {
> +        "EventName": "tlb.l1i.access",
> +        "EventCode": "0x00000009",
> +        "BriefDescription": "Instruction TLB accesses"
> +    },
> +    {
> +        "EventName": "tlb.l1i.miss",
> +        "EventCode": "0x0000000a",
> +        "BriefDescription": "Instruction TLB misses"
> +    },
> +    {
> +        "EventName": "tlb.l1d.access",
> +        "EventCode": "0x0000000b",
> +        "BriefDescription": "Data TLB accesses"
> +    },
> +    {
> +        "EventName": "tlb.l1d.miss",
> +        "EventCode": "0x0000000c",
> +        "BriefDescription": "Data TLB misses"
> +    },
> +    {
> +        "EventName": "tlb.pf.access",
> +        "EventCode": "0x0000000d",
> +        "BriefDescription": "Prefetch TLB accesses"
> +    },
> +    {
> +        "EventName": "tlb.pf.miss",
> +        "EventCode": "0x0000000e",
> +        "BriefDescription": "Prefetch TLB misses"
> +    },
> +    {
> +        "EventName": "cache.l2.access",
> +        "EventCode": "0x0000000f",
> +        "BriefDescription": "L2 accesses"
> +    },
> +    {
> +        "EventName": "cache.l2.miss",
> +        "EventCode": "0x00000010",
> +        "BriefDescription": "L2 misses"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/csky/c930/ieu.json b/tools/perf/pmu-events/arch/riscv/csky/c930/ieu.json
> new file mode 100644
> index 000000000000..7ee0c8e43411
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/csky/c930/ieu.json
> @@ -0,0 +1,47 @@
> +[
> +    {
> +        "EventName": "inst.int.alu.spec",
> +        "EventCode": "0x00000045",
> +        "BriefDescription": "Completed ALU instructions"
> +    },
> +    {
> +        "EventName": "inst.int.mul.spec",
> +        "EventCode": "0x00000046",
> +        "BriefDescription": "Completed MULT instructions"
> +    },
> +    {
> +        "EventName": "inst.int.div.spec",
> +        "EventCode": "0x00000047",
> +        "BriefDescription": "Completed DIV instructions"
> +    },
> +    {
> +        "EventName": "inst.int.csr.spec",
> +        "EventCode": "0x00000048",
> +        "BriefDescription": "Completed CSR instructions"
> +    },
> +    {
> +        "EventName": "ieu.is.siq.stall",
> +        "EventCode": "0x000000c0",
> +        "BriefDescription": "Stall cycles in SX pipe"
> +    },
> +    {
> +        "EventName": "ieu.is.miq.stall",
> +        "EventCode": "0x000000c1",
> +        "BriefDescription": "Stall cycles in MX pipe"
> +    },
> +    {
> +        "EventName": "ieu.is.biq.stall",
> +        "EventCode": "0x000000c2",
> +        "BriefDescription": "Stall cycles in BR pipe"
> +    },
> +    {
> +        "EventName": "ieu.is.lsiq.stall",
> +        "EventCode": "0x000000c3",
> +        "BriefDescription": "Stall cycles in LS pipe"
> +    },
> +    {
> +        "EventName": "ieu.is.vfpq.stall",
> +        "EventCode": "0x000000c4",
> +        "BriefDescription": "Stall cycles in VF pipe"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/csky/c930/ifu.json b/tools/perf/pmu-events/arch/riscv/csky/c930/ifu.json
> new file mode 100644
> index 000000000000..a8fedd95659a
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/csky/c930/ifu.json
> @@ -0,0 +1,62 @@
> +[
> +    {
> +        "EventName": "inst.mispred.branch",
> +        "EventCode": "0x00000018",
> +        "BriefDescription": "Conditional branches that mispredicted"
> +    },
> +    {
> +        "EventName": "inst.mispred.uncond_branch",
> +        "EventCode": "0x00000019",
> +        "BriefDescription": "Direct jumps that mispredicted"
> +    },
> +    {
> +        "EventName": "inst.mispred.ind",
> +        "EventCode": "0x0000001a",
> +        "BriefDescription": "Indirect jumps that mispredicted"
> +    },
> +    {
> +        "EventName": "inst.mispred.ret",
> +        "EventCode": "0x0000001b",
> +        "BriefDescription": "Function return instructions that mispredicted"
> +    },
> +    {
> +        "EventName": "inst.brjmp.branch.spec",
> +        "EventCode": "0x0000001c",
> +        "BriefDescription": "Conditional branch instructions that speculatively executed"
> +    },
> +    {
> +        "EventName": "inst.brjmp.uncond_branch.spec",
> +        "EventCode": "0x0000001d",
> +        "BriefDescription": "Direct jumps that speculatively executed"
> +    },
> +    {
> +        "EventName": "inst.brjmp.ind.spec",
> +        "EventCode": "0x0000001e",
> +        "BriefDescription": "Indirect jumps that speculatively executed"
> +    },
> +    {
> +        "EventName": "inst.brjmp.ret.spec",
> +        "EventCode": "0x0000001f",
> +        "BriefDescription": "Function return instructions that speculatively executed"
> +    },
> +    {
> +        "EventName": "inst.brjmp.branch.tk",
> +        "EventCode": "0x00000020",
> +        "BriefDescription": "Branch instructions that resolved to be taken"
> +    },
> +    {
> +        "EventName": "cache.l1i.rd.miss.latency",
> +        "EventCode": "0x000000b8",
> +        "BriefDescription": "Cycles where frontend issues no instructions due to L1 instruction cache miss"
> +    },
> +    {
> +        "EventName": "tlb.l1i.miss.latency",
> +        "EventCode": "0x000000b9",
> +        "BriefDescription": "Cycles where frontend issues no instructions due to instruction TLB miss"
> +    },
> +    {
> +        "EventName": "inst.mispred.brjmp.latency",
> +        "EventCode": "0x000000ba",
> +        "BriefDescription": "Cycles where frontend issues no instructions due to branch redirect"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/csky/c930/l2c.json b/tools/perf/pmu-events/arch/riscv/csky/c930/l2c.json
> new file mode 100644
> index 000000000000..4a8698cf5637
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/csky/c930/l2c.json
> @@ -0,0 +1,62 @@
> +[
> +    {
> +        "EventName": "cache.l2.wb",
> +        "EventCode": "0x000000a2",
> +        "BriefDescription": "L2 Cache write-backs"
> +    },
> +    {
> +        "EventName": "cache.l2.rd",
> +        "EventCode": "0x000000a3",
> +        "BriefDescription": "L2 Cache reads"
> +    },
> +    {
> +        "EventName": "cache.l2.wr",
> +        "EventCode": "0x000000a4",
> +        "BriefDescription": "L2 Cache writes"
> +    },
> +    {
> +        "EventName": "cache.l2.refill.rd",
> +        "EventCode": "0x000000a5",
> +        "BriefDescription": "L2 Cache refills caused by read"
> +    },
> +    {
> +        "EventName": "cache.l2.refill.wr",
> +        "EventCode": "0x000000a6",
> +        "BriefDescription": "L2 Cache refills caused by write"
> +    },
> +    {
> +        "EventName": "cache.l2.wb.victim",
> +        "EventCode": "0x000000a7",
> +        "BriefDescription": "L2 Cache write-backs caused by cache replacements"
> +    },
> +    {
> +        "EventName": "cache.l2.wb.clean",
> +        "EventCode": "0x000000a8",
> +        "BriefDescription": "L2 Cache write-backs caused by CMO or external snoops"
> +    },
> +    {
> +        "EventName": "cache.l2.inval",
> +        "EventCode": "0x000000a9",
> +        "BriefDescription": "L2 Cache invalidations (by CMO or external snoops included)"
> +    },
> +    {
> +        "EventName": "cache.l2.refill.inst",
> +        "EventCode": "0x000000aa",
> +        "BriefDescription": "L2 Cache refills caused by instruction cache load miss"
> +    },
> +    {
> +        "EventName": "bus.access",
> +        "EventCode": "0x000000ab",
> +        "BriefDescription": "All requests sent to the bus"
> +    },
> +    {
> +        "EventName": "bus.rd.access",
> +        "EventCode": "0x000000ac",
> +        "BriefDescription": "All read requests sent to the bus (prefetch included)"
> +    },
> +    {
> +        "EventName": "bus.wr.access",
> +        "EventCode": "0x000000ad",
> +        "BriefDescription": "All write requests sent to the bus (eviction by the current core included, but eviction by external snoops not included)"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/csky/c930/lsu.json b/tools/perf/pmu-events/arch/riscv/csky/c930/lsu.json
> new file mode 100644
> index 000000000000..eb8d2351dff1
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/csky/c930/lsu.json
> @@ -0,0 +1,137 @@
> +[
> +    {
> +        "EventName": "inst.load.unalign",
> +        "EventCode": "0x00000083",
> +        "BriefDescription": "Unaligned load instructions"
> +    },
> +    {
> +        "EventName": "inst.store.unalign",
> +        "EventCode": "0x00000084",
> +        "BriefDescription": "Unaligned cross-page store instructions"
> +    },
> +    {
> +        "EventName": "cache.l1d.wr.access",
> +        "EventCode": "0x0000008a",
> +        "BriefDescription": "Data Cache store accesses"
> +    },
> +    {
> +        "EventName": "cache.l1d.wr.miss",
> +        "EventCode": "0x0000008b",
> +        "BriefDescription": "Data Cache store misses"
> +    },
> +    {
> +        "EventName": "cache.l1d.refill.inner",
> +        "EventCode": "0x0000008c",
> +        "BriefDescription": "Data Cache misses with L2C hit"
> +    },
> +    {
> +        "EventName": "cache.l1d.refill.outer",
> +        "EventCode": "0x0000008d",
> +        "BriefDescription": "Data Cache misses with L2C miss"
> +    },
> +    {
> +        "EventName": "cache.l1d.wb",
> +        "EventCode": "0x0000008e",
> +        "BriefDescription": "Data Cache dirty cache line evictions"
> +    },
> +    {
> +        "EventName": "cache.l1d.wb.victim",
> +        "EventCode": "0x0000008f",
> +        "BriefDescription": "Data Cache dirty cache line evictions caused by new cache line refilling"
> +    },
> +    {
> +        "EventName": "cache.l1d.wb.clean",
> +        "EventCode": "0x00000090",
> +        "BriefDescription": "Data Cache dirty cache line evictions caused by CMO from another CPU or snoop from another CPU"
> +    },
> +    {
> +        "EventName": "cache.l1d.inval",
> +        "EventCode": "0x00000091",
> +        "BriefDescription": "Data Cache invalidations caused by CMO or snoops"
> +    },
> +    {
> +        "EventName": "inst.ldst.load.spec",
> +        "EventCode": "0x00000092",
> +        "BriefDescription": "Completed load instructions (prefetch not included)"
> +    },
> +    {
> +        "EventName": "inst.ldst.store.spec",
> +        "EventCode": "0x00000093",
> +        "BriefDescription": "Completed store instructions (CMO not included)"
> +    },
> +    {
> +        "EventName": "inst.ldst.lr.spec",
> +        "EventCode": "0x00000094",
> +        "BriefDescription": "Completed lr instructions"
> +    },
> +    {
> +        "EventName": "inst.ldst.sc",
> +        "EventCode": "0x00000095",
> +        "BriefDescription": "Completed sc instructions"
> +    },
> +    {
> +        "EventName": "inst.ldst.sc.pass",
> +        "EventCode": "0x00000096",
> +        "BriefDescription": "Completed sc instructions that pass"
> +    },
> +    {
> +        "EventName": "inst.ldst.sc.fail",
> +        "EventCode": "0x00000097",
> +        "BriefDescription": "Completed sc instructions that fail"
> +    },
> +    {
> +        "EventName": "inst.ldst.amo",
> +        "EventCode": "0x00000098",
> +        "BriefDescription": "Completed AMO instructions"
> +    },
> +    {
> +        "EventName": "inst.ldst.load_acquire.spec",
> +        "EventCode": "0x00000099",
> +        "BriefDescription": "Completed load acquire instructions"
> +    },
> +    {
> +        "EventName": "inst.ldst.store_release.spec",
> +        "EventCode": "0x0000009a",
> +        "BriefDescription": "Completed store release instructions"
> +    },
> +    {
> +        "EventName": "inst.ldst.fence",
> +        "EventCode": "0x0000009b",
> +        "BriefDescription": "Completed fence instructions"
> +    },
> +    {
> +        "EventName": "inst.ldst.fencei",
> +        "EventCode": "0x0000009c",
> +        "BriefDescription": "Completed fencei instructions"
> +    },
> +    {
> +        "EventName": "inst.ldst.dvm_sync",
> +        "EventCode": "0x0000009d",
> +        "BriefDescription": "Completed dvm sync instructions"
> +    },
> +    {
> +        "EventName": "inst.ldst.vec_load.spec",
> +        "EventCode": "0x0000009e",
> +        "BriefDescription": "Completed vector load uops"
> +    },
> +    {
> +        "EventName": "inst.ldst.vec_store.spec",
> +        "EventCode": "0x0000009f",
> +        "BriefDescription": "Completed vector store uops"
> +    },
> +    {
> +        "EventName": "inst.ldst.float_load.spec",
> +        "EventCode": "0x000000a0",
> +        "BriefDescription": "Completed floating-point load uops"
> +    },
> +    {
> +        "EventName": "inst.ldst.float_store.spec",
> +        "EventCode": "0x000000a1",
> +        "BriefDescription": "Completed floating-point store uops"
> +    },
> +    {
> +        "EventName": "inst.ldst.spec",
> +        "EventCode": "0x000000b3",
> +        "BriefDescription": "Completed instructions executed by LSU"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/csky/c930/vfpu.json b/tools/perf/pmu-events/arch/riscv/csky/c930/vfpu.json
> new file mode 100644
> index 000000000000..e60dea102862
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/csky/c930/vfpu.json
> @@ -0,0 +1,167 @@
> +[
> +    {
> +        "EventName": "inst.sca.fp.arith.spec",
> +        "EventCode": "0x0000005b",
> +        "BriefDescription": "Completed scalar floating-point instructions"
> +    },
> +    {
> +        "EventName": "inst.fp.arith.half.spec",
> +        "EventCode": "0x0000005c",
> +        "BriefDescription": "Completed half-precision floating-point instructions (both scalar and vector included)"
> +    },
> +    {
> +        "EventName": "inst.fp.arith.single.spec",
> +        "EventCode": "0x0000005d",
> +        "BriefDescription": "Completed single-precision floating-point instructions (both scalar and vector included)"
> +    },
> +    {
> +        "EventName": "inst.fp.arith.double.spec",
> +        "EventCode": "0x0000005e",
> +        "BriefDescription": "Completed double-precision floating-point instructions (both scalar and vector included)"
> +    },
> +    {
> +        "EventName": "inst.rvv.arith.spec",
> +        "EventCode": "0x0000005f",
> +        "BriefDescription": "Completed vector arithmetic instructions"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.spec",
> +        "EventCode": "0x00000060",
> +        "BriefDescription": "Completed vector arithmetic uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.fp.spec",
> +        "EventCode": "0x00000061",
> +        "BriefDescription": "Completed vector arithmetic floating-point uops"
> +    },
> +    {
> +        "EventName": "inst.rvv.arith.fp.spec",
> +        "EventCode": "0x00000062",
> +        "BriefDescription": "Completed vector arithmetic floating-point instructions"
> +    },
> +    {
> +        "EventName": "uop.sca.fp.arith.bf.spec",
> +        "EventCode": "0x00000063",
> +        "BriefDescription": "Completed scalar bf floating-point uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vint8.spec",
> +        "EventCode": "0x00000064",
> +        "BriefDescription": "Completed INT8 vector uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vint16.spec",
> +        "EventCode": "0x00000065",
> +        "BriefDescription": "Completed INT16 vector uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vint32.spec",
> +        "EventCode": "0x00000066",
> +        "BriefDescription": "Completed INT32 vector uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vint64.spec",
> +        "EventCode": "0x00000067",
> +        "BriefDescription": "Completed INT64 vector uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.fix_point.spec",
> +        "EventCode": "0x00000068",
> +        "BriefDescription": "Completed fixed-point vector uops"
> +    },
> +    {
> +        "EventName": "uop.fp.arith.fdiv.spec",
> +        "EventCode": "0x00000069",
> +        "BriefDescription": "Completed floating-point division uops (both scalar and vector included)"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.idiv.spec",
> +        "EventCode": "0x0000006a",
> +        "BriefDescription": "Completed vector integer division uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.zvkn.spec",
> +        "EventCode": "0x0000006b",
> +        "BriefDescription": "Completed zvkn-type uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.zvks.spec",
> +        "EventCode": "0x0000006c",
> +        "BriefDescription": "Completed zvks-type uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vmulu64.spec",
> +        "EventCode": "0x0000006d",
> +        "BriefDescription": "Completed UINT64 vector multiply uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vmulu.spec",
> +        "EventCode": "0x0000006e",
> +        "BriefDescription": "Completed UNIT vector multiply uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vdot.spec",
> +        "EventCode": "0x0000006f",
> +        "BriefDescription": "Completed vdot uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vfmul.spec",
> +        "EventCode": "0x00000070",
> +        "BriefDescription": "Completed vector floating-point multiply uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vfadd.spec",
> +        "EventCode": "0x00000071",
> +        "BriefDescription": "Completed vector floating-point add uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.perm.spec",
> +        "EventCode": "0x00000072",
> +        "BriefDescription": "Completed vector permutation uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.redu.spec",
> +        "EventCode": "0x00000073",
> +        "BriefDescription": "Completed vector integer reduction uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.fred.spec",
> +        "EventCode": "0x00000074",
> +        "BriefDescription": "Completed vector floating-point reduction uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.mask.spec",
> +        "EventCode": "0x00000075",
> +        "BriefDescription": "Completed vector arithmetic masked uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.vlmax.spec",
> +        "EventCode": "0x00000076",
> +        "BriefDescription": "Completed vlmax uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.agnostic.spec",
> +        "EventCode": "0x00000077",
> +        "BriefDescription": "Completed vector arithmetic uops with agnostic strategy"
> +    },
> +    {
> +        "EventName": "uop.rvv.arith.idiv_direct.spec",
> +        "EventCode": "0x00000078",
> +        "BriefDescription": "Completed vector integer division uops that produce special result"
> +    },
> +    {
> +        "EventName": "uop.rvv.vadd.spec",
> +        "EventCode": "0x000000ae",
> +        "BriefDescription": "Completed vector integer add uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.vmacc.spec",
> +        "EventCode": "0x000000af",
> +        "BriefDescription": "Completed vector integer multiply-add uops"
> +    },
> +    {
> +        "EventName": "uop.rvv.vfmacc.spec",
> +        "EventCode": "0x000000b0",
> +        "BriefDescription": "Completed vector floating-point multiply-add uops"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> index 87cfb0e0849f..372833e0a78e 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -21,6 +21,7 @@
>  0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
>  0x5b7-0x0-0x0,v1,thead/c900-legacy,core
>  0x5b7-0x80000000090c0d00-0x2047000,v1,thead/c900-legacy,core
> +0x5b7-0x8000000009201600-0x[[:xdigit:]]+,v1,csky/c930,core
>  0x602-0x3-0x0,v1,openhwgroup/cva6,core
>  0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
>  0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
> 
> ---
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> change-id: 20261105-csky_c930_pmu-0eed57291f30
> 
> Best regards,
> --  
> GUO Ren (XuanTie) <guoren@kernel.org>
> 
