Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727053E24
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Jun 2024 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697915; cv=none; b=t4N0F8k8kG5Rw8V4nSmDHFhfSrothf5HFQsVZYqCzkNIO3GuDGKihMUB2GN+QFY3b8nNk6e+bhywwnF/7Wc91HJviY0ZG/BQwcESfnC707bCQLfV2Rmsf6acdAuM+M6SaPgaCqjsxmSdDqmoW2PxlPrO7w999LBaRf3pVpb1ABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697915; c=relaxed/simple;
	bh=PS9ahQANsDo3yDHmLJ47O67i3Ua7Jr60P3XU9zWQlas=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NhPqtUi09Dv0kq86wAmETyR+92MPg5zqeExHfdLYoGd23FY26Ozv9G1DbQy0njaZ3yIIyoLlMPZMqoXqJsUmdzjMFIXFx9z48wnkeizBAE5VqU+SNaa8vnyda3cN1xiGBzr5zo9v1Z4QzwxFQOHfIX+VRwp56tpT0DzjcP7QNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clJC/wLy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clJC/wLy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718697913; x=1750233913;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=PS9ahQANsDo3yDHmLJ47O67i3Ua7Jr60P3XU9zWQlas=;
  b=clJC/wLykZ8gdIe08TtZJQweNKdggV7ybSeM0RQJBmS2ZaPaQvSgYGon
   09hHfaciHPFebF0pTNhLRmZ95Vbj3f5rQUgE9K9TjjT+3YVbGo4Qcjvpq
   wjXLnxXTsmmml15W6brs9onYp/sVZ1o6ubyf5UP72yYcMIrw3XY84hcgN
   UJ+kZe5uuxFk2rLNHG5LL8LHT8qP0Fk+WTTnz/trQN84nMdrEioy8RFi/
   FQQ0tq1ZLJpctL2DDxvCYGtdFZM1yRDKk2x/yqxB4dcNf6Mg4nhdtGpLC
   annJYUY+R0em5eohJ9CaQwW4RcNfB4mctAD0ZvVS5AV6wEBPEL9k/y/ZI
   g==;
X-CSE-ConnectionGUID: ez2OHxFkRT2D3p7pdVjuTQ==
X-CSE-MsgGUID: QjhsZqjCSuWIJ0hwZKNmCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15703805"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15703805"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:05:12 -0700
X-CSE-ConnectionGUID: r4/mw6gnR8CIJOir+DyxWA==
X-CSE-MsgGUID: 6yoC4z80R0ukta3e74yxLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46377520"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:05:11 -0700
Message-ID: <922eb861-14bd-4953-b626-022bbcb83f28@intel.com>
Date: Tue, 18 Jun 2024 11:05:06 +0300
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
 <cb1bdaab-d324-44d8-a14e-dc48e19503fa@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <cb1bdaab-d324-44d8-a14e-dc48e19503fa@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/24 21:14, Adrian Hunter wrote:
> On 2/05/24 13:58, Adrian Hunter wrote:
>> JMPABS is 64-bit absolute direct jump instruction, encoded with a mandatory
>> REX2 prefix. JMPABS is designed to be used in the procedure linkage table
>> (PLT) to replace indirect jumps, because it has better performance. In that
>> case the jump target will be amended at run time. To enable Intel PT to
>> follow the code, a TIP packet is always emitted when JMPABS is traced under
>> Intel PT.
>>
>> Refer to the Intel Advanced Performance Extensions (Intel APX) Architecture
>> Specification for details.
>>
>> Decode JMPABS as an indirect jump, because it has an associated TIP packet
>> the same as an indirect jump and the control flow should follow the TIP
>> packet payload, and not assume it is the same as the on-file object code
>> JMPABS target address.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Patches 1-8 are in perf-tools-next now, so this and patch 10
> could be applied.

Still apply

> 
>> ---
>>  tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
>> index c5d57027ec23..4407130d91f8 100644
>> --- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
>> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
>> @@ -92,6 +92,15 @@ static void intel_pt_insn_decoder(struct insn *insn,
>>  		op = INTEL_PT_OP_JCC;
>>  		branch = INTEL_PT_BR_CONDITIONAL;
>>  		break;
>> +	case 0xa1:
>> +		if (insn_is_rex2(insn)) { /* jmpabs */
>> +			intel_pt_insn->op = INTEL_PT_OP_JMP;
>> +			/* jmpabs causes a TIP packet like an indirect branch */
>> +			intel_pt_insn->branch = INTEL_PT_BR_INDIRECT;
>> +			intel_pt_insn->length = insn->length;
>> +			return;
>> +		}
>> +		break;
>>  	case 0xc2: /* near ret */
>>  	case 0xc3: /* near ret */
>>  	case 0xca: /* far ret */
> 

