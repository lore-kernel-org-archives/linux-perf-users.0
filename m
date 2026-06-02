Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641631F9B7
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 05:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378729; cv=none; b=rBlWyUdy+vJXloFwN66dyhPfWCyLkf0J0hUORnWmCRe2gWboL254xdAf17mOUOZAWWy4a3nxB3bSkh9+OECDSI4EibAMEI09sZPsLmsKwoPqMsi15QvYMiUqMetcqx64rWXRjBalWIH9XRHx7AJEmZXHC5QY4apY0Sqg0wgV3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378729; c=relaxed/simple;
	bh=ZjBSuvsWrRxKYsz78alVEBulc+oz9koe1eo7Mu2VT1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4pRLLLJdOzqMMPYi3BN7BFpPK5vr3UvvRDF9Qn9CKsrcB2wTWOJ4eCRrrrOXPwVx53SpnBgSbDmGmcJo99JajHxw1UebZye3hu9JuxBVPmNG8SEW1HbBoVSAZwLbf6IfsrtuYtAhw2CZIrjYyRj0XGX7yNBhSO0onWeBjfkabU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKaACMNe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKaACMNe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780378727; x=1811914727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZjBSuvsWrRxKYsz78alVEBulc+oz9koe1eo7Mu2VT1I=;
  b=MKaACMNefeAXOYDsQsJ21jTGqTf5B2HIOmaX+VORM3ULMKdHuXL7sqpW
   a3jeKHQkltygHAKR0nvrUlQi+1lfTBUBRhhPquvAD2Zu2+qhPSV8mnX9w
   Se5yugiIS5iyzHFw8KOn+fQeyt0GLUBUHvW2TMiXs9sJlqrBfnpkA8tXV
   0DBGc46fOtlGlSRWLcRq0mFuvPlJn3CMT5gp4zFqICBeqXvRDXaXkYiRm
   nh+lV78teDDf4+ZcR99Z0t4BYyOZEzHb2+HmGDBmDSDx2FKOyfRlMZu8u
   LG1bYFH67kBTIq9roTBlOdNOaaZO3zKFkQVYMe/YvF9F3cbUOYJiy6thg
   Q==;
X-CSE-ConnectionGUID: 9C3JRonkTiuEE8qp//iQRw==
X-CSE-MsgGUID: JgJ50mdOR/iPFsFT8Pf+Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80186209"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="80186209"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:38:46 -0700
X-CSE-ConnectionGUID: /cS8R5SMT4m7tAQrlPvQsg==
X-CSE-MsgGUID: ZvXcOdFRQkCNWI3YSvAxYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="239636760"
Received: from unknown (HELO [10.238.1.64]) ([10.238.1.64])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:38:45 -0700
Message-ID: <41b14d9b-3db9-4b73-a56c-9e06753257f7@linux.intel.com>
Date: Tue, 2 Jun 2026 13:38:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 3/5] perf regs: Support x86 SIMD registers sampling
To: Ian Rogers <irogers@google.com>, sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529082451.591783-4-dapeng1.mi@linux.intel.com>
 <20260529104532.CE9D11F00893@smtp.kernel.org>
 <CAP-5=fV0wY_B22Zma06JjWaMSWnChwFwk28c1uMfEGBBWA5-Xg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fV0wY_B22Zma06JjWaMSWnChwFwk28c1uMfEGBBWA5-Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/30/2026 1:41 AM, Ian Rogers wrote:
> On Fri, May 29, 2026 at 3:51 AM <sashiko-bot@kernel.org> wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> - [Medium] Parsing of `--intr-regs` and `--user-regs` with multiple options is order-dependent, preventing intended combination of General Purpose (GP) and SIMD registers.
>> - [Medium] Specifying only SIMD registers (e.g., `--intr-regs=xmm` without GP registers) leaves the general-purpose register mask as 0, causing the kernel to reject the event configuration with `-EINVAL`.
>> - [Low] The `sample_simd_regs_enabled` field is omitted from `perf_event_attr__fprintf()`.
>> --
>>
>> commit 03a81994cf381ee1d67a41deb452833fc73a023e
>> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> perf regs: Support x86 SIMD registers sampling
>>
>> This patch adds support for the newly introduced SIMD register sampling
>> format by adding functions to support parsing and sampling x86 SIMD/PRED
>> registers.
>>
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index 1c856a2ecc6ec..cd62af14a4f54 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>> [ ... ]
>>
>>> @@ -1594,6 +1595,16 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
>>>               evsel__set_sample_bit(evsel, REGS_INTR);
>>>       }
>>>
>>> +     if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &&
>>> +         !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
>>> +             attr->sample_simd_regs_enabled = !!opts->sample_simd_regs_enabled;
>>> +             attr->sample_simd_vec_reg_intr = opts->sample_intr_vec_regs;
>>> +             attr->sample_simd_vec_reg_qwords = opts->sample_vec_reg_qwords;
>>> +             attr->sample_simd_pred_reg_intr = opts->sample_intr_pred_regs;
>>> +             attr->sample_simd_pred_reg_qwords = opts->sample_pred_reg_qwords;
>>> +             evsel__set_sample_bit(evsel, REGS_INTR);
>>> +     }
>> [Severity: Medium]
>> Will specifying only SIMD registers (e.g., perf record --intr-regs=xmm)
>> leave the general-purpose register mask as 0?
>>
>> If opts->sample_intr_regs is 0, attr->sample_regs_intr remains 0. However,
>> setting the REGS_INTR bit here causes the kernel validation function
>> (perf_reg_validate()) to unconditionally return -EINVAL because the sample
>> type bit is set but the corresponding GP register mask is 0.
> It is an interesting corner case, we could extend this test to cover it:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/record.sh?h=perf-tools-next#n106

No, this is not a real issue. The perf_reg_validate() has been leased to
allow 0 mask bit if simd_enabled is true. So no -EINVAL would be returned,
like below,

$ sudo ./perf record -e cycles:p -Ixmm -c 10000 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.111 MB perf.data (262 samples) ]


>
>>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>>> index 70a1cc90b2c13..26d560a486c85 100644
>>> --- a/tools/perf/util/parse-regs-options.c
>>> +++ b/tools/perf/util/parse-regs-options.c
>> [ ... ]
>>
>>> @@ -53,22 +106,96 @@ name_to_perf_reg_mask(const char *to_match, uint64_t mask, int abi)
>> [ ... ]
>>
>>>       /*
>>> -      * cannot set it twice
>>> +      * Non-SIMD registers cannot be set twice.
>>> +      * SIMD registers can be set multiple times, but only the register
>>> +      * class with largest length (qwords) is sampled.
>>>        */
>>>       if (*mode)
>>>               return -1;
>> [Severity: Medium]
>> Does the order of options affect whether they are parsed successfully?
>>
>> If SIMD registers are parsed first (e.g., -I xmm), *mode is left as 0,
>> which allows a subsequent GP register option like -I ax to be parsed
>> successfully.
>>
>> However, if GP registers are parsed first (e.g., -I ax), *mode is set to
>> a non-zero value, which triggers this failure check when -I xmm is
>> evaluated. Does this prevent intended combinations of GP and SIMD registers
>> from working consistently?
> It's probably worth adding coverage for this too. In this case having
> a C unit test may make most sense.

Ok, It's indeed a corner issue. The simplest way may be remove this check.
Would fix it in next version.

Sure. Would extend current perf record test to cover the SIMD registers
sampling.


>
>>> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
>>> index 741c3d657a8b6..c6b8e53e06fd1 100644
>>> --- a/tools/perf/util/perf_event_attr_fprintf.c
>>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
>>> @@ -362,6 +362,12 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>>>       PRINT_ATTRf(aux_start_paused, p_unsigned);
>>>       PRINT_ATTRf(aux_pause, p_unsigned);
>>>       PRINT_ATTRf(aux_resume, p_unsigned);
>>> +     PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
>>> +     PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
>>> +     PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
>>> +     PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
>>> +     PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
>>> +     PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
>>>
>>>       return ret;
>>>  }
>> [Severity: Low]
>> Does this also need to print the sample_simd_regs_enabled field?
>>
>> This patch adds several new SIMD-related fields to struct perf_event_attr,
>> but sample_simd_regs_enabled is missing here. Could this prevent developers
>> from verifying whether the tool correctly enabled SIMD sampling when inspecting
>> configurations via debug commands like perf record -vvv?
> It looks like this uncovers some technical debt. I don't see config3
> or config4 being printed either :-( Could you help to address, if not
> remind me :-)

It looks like sig_data, config3 and config4 are missed to print here. I
would add a patch to print them before printing these new SIMD fields.

Thanks.


>
> Thanks,
> Ian
>
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260529082451.591783-1-dapeng1.mi@linux.intel.com?part=3
>>
