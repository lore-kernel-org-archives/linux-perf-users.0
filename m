Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13647F60
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716920082; cv=none; b=M9Gi1AG6KcMGkzLrdCKCPYcrPprODlNjdup0l8/Vsk5yMCXaAvWtO0QzOhiBX604GJYAmUCdSqtTH0xhkCq6Yso4zjer+t5zP/mB9kWRP9KEeLL3CVe8KlyuBgxT7nXXbLxG+YTRNPEYzG7tz7jZ1Vr7vcX1QxYWDL2QVAsvXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716920082; c=relaxed/simple;
	bh=K3iCFz/v9WjrF9qKA4yUfwwSjKz74d9lCEw05TqLfcw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hu2ZPC73WeqB5EqfG6+fCmd9WNZRmXp0GrpEKIY+nupGnuBtgP3/VAQGwvy3mtoSsiAsdZtfTU1tMMKcV+0SiiJq0ECKNExcfI7NCJO93FSgZiGeFuMdpbRCjhcfTLXvzJa6z1sa7KcmaApCQk+TT3oFk8yugb/E3MtXe2sueD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnI/eFJ6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnI/eFJ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716920080; x=1748456080;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=K3iCFz/v9WjrF9qKA4yUfwwSjKz74d9lCEw05TqLfcw=;
  b=fnI/eFJ6OtxEAEycO9igunPd4/JiCVl+lyecPe6dDUVmPbk8XcHqPHYY
   srEPbYbz9pBSeySfwqTqXSvjWkDCnVzLhzYNs/oA8wMyAxBlo2bND6zng
   YGQsH0jZ1EET6sr7UTpxkP1NGC9IkNxY4wWKAzpqRHmnU7c543ZYAFPJk
   xepZTFNeCfDw00crw5UFPp7he2rBvRnrpl+Fam+067Ff7gmDDY98dZbGp
   RVV88VZuh42N1UPwICr7vz9ov4kPWLMEGqE3Q07I3N8w4XzNRZpqPBcKu
   5haFvmVgslLO9wVQCOftegJOgWR7bDGGxToxyLIrQO7SzNrkVRrjaHnFL
   Q==;
X-CSE-ConnectionGUID: BRF26u9MS1uaCFO/FwaCsQ==
X-CSE-MsgGUID: 19IzDI0GRs2mr/OahzDHFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13510587"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13510587"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:14:39 -0700
X-CSE-ConnectionGUID: efSPYIXnSAiRTuRJuuBjlQ==
X-CSE-MsgGUID: 36miuOqsSTm6gADMl50Ieg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72598703"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:14:37 -0700
Message-ID: <cb1bdaab-d324-44d8-a14e-dc48e19503fa@intel.com>
Date: Tue, 28 May 2024 21:14:31 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] perf intel pt: Add new JMPABS instruction to the
 Intel PT instruction decoder
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
References: <20240502105853.5338-1-adrian.hunter@intel.com>
 <20240502105853.5338-10-adrian.hunter@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240502105853.5338-10-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/05/24 13:58, Adrian Hunter wrote:
> JMPABS is 64-bit absolute direct jump instruction, encoded with a mandatory
> REX2 prefix. JMPABS is designed to be used in the procedure linkage table
> (PLT) to replace indirect jumps, because it has better performance. In that
> case the jump target will be amended at run time. To enable Intel PT to
> follow the code, a TIP packet is always emitted when JMPABS is traced under
> Intel PT.
> 
> Refer to the Intel Advanced Performance Extensions (Intel APX) Architecture
> Specification for details.
> 
> Decode JMPABS as an indirect jump, because it has an associated TIP packet
> the same as an indirect jump and the control flow should follow the TIP
> packet payload, and not assume it is the same as the on-file object code
> JMPABS target address.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Patches 1-8 are in perf-tools-next now, so this and patch 10
could be applied.

> ---
>  tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> index c5d57027ec23..4407130d91f8 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> @@ -92,6 +92,15 @@ static void intel_pt_insn_decoder(struct insn *insn,
>  		op = INTEL_PT_OP_JCC;
>  		branch = INTEL_PT_BR_CONDITIONAL;
>  		break;
> +	case 0xa1:
> +		if (insn_is_rex2(insn)) { /* jmpabs */
> +			intel_pt_insn->op = INTEL_PT_OP_JMP;
> +			/* jmpabs causes a TIP packet like an indirect branch */
> +			intel_pt_insn->branch = INTEL_PT_BR_INDIRECT;
> +			intel_pt_insn->length = insn->length;
> +			return;
> +		}
> +		break;
>  	case 0xc2: /* near ret */
>  	case 0xc3: /* near ret */
>  	case 0xca: /* far ret */

