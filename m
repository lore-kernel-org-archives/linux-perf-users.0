Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F5184A
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228948; cv=none; b=OiUwBnImS8hdfTPDzO/DxnIryAkPMYssQ3chA4nVuGHILg/qBHymDiW0gqfKe3RVuz/C8VsqPBSllnaMmkc0KYjcTUnmjJc2fTyaiBGZ400TR2paxCrbfBb/zynkBITllIWwIgr0cQFUrrIdBjk1apiI5N1L0EC/8Zo0fVsA/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228948; c=relaxed/simple;
	bh=dZHbXeTfuzvGt3PLcZqcV2fZCkuXX4yVPG73fdzzojE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IcM/psDxG8D5HFSTpCvhrWD4kU+SVauotDC3c6NvCx6MFjWyQfk/1oQ1A417iR2JgPzWH/zS5fB8myhXhpxceD5YI3sZHASVsQGDDF/M0tf0fb1E4je8SHe03Bl+neWrfXUx2BMgBhOocJn2I9hwqDb3rSB+eL9w2s1R20R0tkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR1zZM9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR1zZM9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404961F000FF;
	Thu, 24 Sep 2026 05:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228946;
	bh=kunBZljpQsZ+TdGy+3veCSiNZdeiCQSeCcHO+R29A6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TR1zZM9e6iUd1eVw9Np+iYalFcSPB1a7oACPhNzpIgynjNrpub+sitOOTHwg3SAN4
	 QXjL14Ki22njmUYd+FQHcHDBRMIRCYS7pkdq+UtW70KE2SRtqM17wLQSie+lB6kVye
	 sZk3e2A/EVF2CBv8HHe0YkxReOqB8ihcikOQMeLNg5l5usVnHDMLVxf37g8f2OLa/y
	 MmKrVyEhtGC9QnCMAYOHju4Q0TpYbLQXfBM63gVSyQWUPxBYvOhtWNUTrlogxFlx+D
	 4/Yg5iZin89PMJkzDvxOuQj9sEqgTCGcXstoluVP/G3XLxulPxpVaLZFqyqjp1OGaT
	 +pjOnF3/yThKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 15/21] perf vendor events intel: Update novalake
 events from 1.00 to 1.04
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-16-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:49:05 +0000
Message-Id: <20260924054906.404961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: UMask omission in novalake events causes EventCode aliasing
--

commit 1470a977cdc98c6d093466522a50ce1b48974108
Author: Ian Rogers <irogers@google.com>

perf vendor events intel: Update novalake events from 1.00 to 1.04

This commit updates the novalake PMU events from version 1.00 to 1.04.
It synchronizes the event lists with the latest intel perfmon updates
and updates the format encoding for the off module response MSRs.

Link: https://github.com/intel/perfmon/commit/50afd00f84fb8c7bfa26a993a9689=
82c1573e6d1
Link: https://github.com/intel/perfmon/commit/b576c542b68d377fa00ef4674715e=
a87a37c309c
Link: https://lore.kernel.org/linux-perf-users/20260923015517.2665398-1-dap=
eng1.mi@linux.intel.com/

> diff --git a/tools/perf/pmu-events/arch/x86/novalake/floating-point.json =
b/tools/perf/pmu-events/arch/x86/novalake/floating-point.json
> index 471a90f3670c4..2dda2225d0043 100644
> --- a/tools/perf/pmu-events/arch/x86/novalake/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/novalake/floating-point.json

[ ... ]

> @@ -181,6 +181,22 @@
>          "UMask": "0x1",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "FP_ARITH_INST_RETIRED.SCALAR_HALF",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc8",
> +        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_HALF",
> +        "SampleAfterValue": "100003",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Number of all Scalar Half-Precision FP arit=
hmetic instructions(1) retired - regular and complex.",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc8",
> +        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_HALF_WCOMPLEX",
> +        "SampleAfterValue": "100003",
> +        "Unit": "cpu_core"
> +    },

[Severity: Medium]
Is the UMask intentionally omitted for FP_ARITH_INST_RETIRED.SCALAR_HALF_WC=
OMPLEX?

When the UMask is omitted, the perf tool JSON converter defaults to UMask 0=
x00.
Because FP_ARITH_INST_RETIRED.SCALAR_HALF also shares EventCode 0xc8 and
lacks a UMask, these become indistinguishable aliases for mutually exclusive
events.

Could this cause incorrect PMU programming and inaccurate measurements?

[ ... ]

> +    {
> +        "BriefDescription": "Counts the number of retired packed 128 bit=
 or 256 bit double precision floating point arithmetic operations.",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc8",
> +        "EventName": "FP_ARITH_RETIRED.PACKED_DP",
> +        "SampleAfterValue": "1000003",
> +        "Unit": "cpu_atom"
> +    },

[Severity: Medium]
Similarly, FP_ARITH_RETIRED.PACKED_DP shares EventCode 0xc8 without a UMask.

This defaults to UMask 0x00, which will alias with PACKED_SP and other even=
ts
that share this EventCode.

Does this need a distinct UMask to prevent profiling collisions?

> diff --git a/tools/perf/pmu-events/arch/x86/novalake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/novalake/pipeline.json
> index 998dd4cbc66a7..65a8a3058f81d 100644
> --- a/tools/perf/pmu-events/arch/x86/novalake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/novalake/pipeline.json

[ ... ]

> @@ -146,6 +196,15 @@
>          "UMask": "0x2",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of far branch instruction=
s retired, includes far jump, far call and return, and interrupt call and r=
eturn.",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
> +        "PublicDescription": "Counts the number of far branch instructio=
ns retired, includes far jump, far call and return, and interrupt call and =
return. Available PDIST counters: 0,1",
> +        "SampleAfterValue": "1000003",
> +        "Unit": "cpu_atom"
> +    },

[Severity: Medium]
Does BR_INST_RETIRED.FAR_BRANCH require a specific UMask?

It currently lacks one, defaulting to UMask 0x00 for cpu_atom. This will
collide with the preexisting ALL_BRANCHES event that also defaults to
UMask 0x00, leading to inaccurate performance measurements.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D15
