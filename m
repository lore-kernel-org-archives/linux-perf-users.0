Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100F33B6E3
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367464; cv=none; b=BKX8Z+K9rfv/QV4gP+k7joET2bM7NUIaQptF3z1zX7MTZwNElTX3rjZplI0wrpLDnEe6yzrpBo4Qo+UMf+ClL2APLsPkcsjNUTZZie/0GtTYc3CE3kCWviuH+GikjBvPmU72Mb+aO/A0q34bX7wm1vmFfdPq1ax0D3WR1z9CwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367464; c=relaxed/simple;
	bh=HozBJwZkc8Vb1OoxAsY/vIO/p61xnEU3DCV7jyVBGGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG1Sd4kMr79sC/QEwibXyJTURaaghCNMbuPBJviIsltuR+dK88DqOrkdZ43qp07rEZsjjXEJuM36f8c3KMlCCS1w3QmgyMO1AnPzWrxgLnbqVHCgGjOENNRPC5uiHsLh9zELZI0o5x8s+6f7wrkGWYGHBnmwu0RY98B3lek1I/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOnQ7Nv9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOnQ7Nv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780367462; x=1811903462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HozBJwZkc8Vb1OoxAsY/vIO/p61xnEU3DCV7jyVBGGk=;
  b=ZOnQ7Nv9XYav2FnoQMVdFSE52QkcYwBOYJCx8aitCAcB7iDNFvlvSgHu
   BiroY1cIsLY092G0DCzECI7M4B6vS9C13/vFRLmt4AxoA+UNUOvVw1aYV
   KXvC2tViPX9kx73n/vJoor9zntb4f/KNDwV2iUzkKmVFsHAGIM6wMFMFf
   TqbltNv9/r0PcB5cNrMSTQa6D1m4JHkhYk9rbgnk9yemiV3LB+DLBmM1h
   FXOSJObFtqH0GjMg1l6gEo/SiLqc4nhnn6Wu0upvlt6P21zZP3yjmAZMG
   tWUZjcTUavCSwxBXGttX25XQ4Uto7dvBHcOeY7LyidY0Dkgs7IHLCqNX3
   Q==;
X-CSE-ConnectionGUID: gG30ArnWR8GOyTKsxMp8Wg==
X-CSE-MsgGUID: vbRNIV/XQ/is6W6PsP1T/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81036262"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81036262"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 19:31:02 -0700
X-CSE-ConnectionGUID: rDj0cvM2SbqixuxqqOllDQ==
X-CSE-MsgGUID: itq8/B/XS9KdrrheLnvOtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="242717873"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 19:31:01 -0700
Message-ID: <4da67df6-fdd0-4508-a7e1-01c9556fc781@linux.intel.com>
Date: Tue, 2 Jun 2026 10:30:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 1/5] perf headers: Sync perf_event.h/perf_regs.h with
 the kernel headers
To: Ian Rogers <irogers@google.com>, sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529082451.591783-2-dapeng1.mi@linux.intel.com>
 <20260529092345.A3A8F1F00893@smtp.kernel.org>
 <CAP-5=fWHFnmR+gX1+-iE5aT6GBCkRrRGahC92_nhbzy4tNA+dQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWHFnmR+gX1+-iE5aT6GBCkRrRGahC92_nhbzy4tNA+dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/30/2026 12:59 AM, Ian Rogers wrote:
> On Fri, May 29, 2026 at 2:26 AM <sashiko-bot@kernel.org> wrote:
>> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>>
>> New issues:
>> - [High] The newly introduced variable-length SIMD payload in `PERF_SAMPLE_REGS_USER` and `PERF_SAMPLE_REGS_INTR` breaks sample parsing, leading to severe data corruption for subsequent fields.
>> - [High] The newly added SIMD configuration and reserved fields in `struct perf_event_attr` are not byte-swapped in `perf_event__attr_swap()`.
>>
>> Pre-existing issues:
>> - [Critical] An integer underflow in `read_attr` when processing the `size` field of a `perf_event_attr` structure leads to a massive stack-based buffer overflow.
>> - [Critical] In `read_event_desc`, a lack of minimum size validation on the `sz` variable leads to out-of-bounds heap memory corruption during byte-swapping.
>> --
>>
>> commit 40d194b08491e7774620de12bd78192095f031fd
>> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> perf headers: Sync perf_event.h/perf_regs.h with the kernel headers
>>
>> This patch syncs the UAPI header changes to support SIMD, eGPRs, and SSP
>> sampling into the corresponding perf tool UAPI headers. It also adds a
>> sanity check for the newly introduced __reserved_4 field in
>> perf_attr_check().
>>
>>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>>> index fd10aa8d697f2..c49fc76292f79 100644
>>> --- a/tools/include/uapi/linux/perf_event.h
>>> +++ b/tools/include/uapi/linux/perf_event.h
>> [ ... ]
>>> @@ -547,6 +549,29 @@ struct perf_event_attr {
>>>
>>>       __u64   config3; /* extension of config2 */
>>>       __u64   config4; /* extension of config3 */
>>> +
>>> +     /*
>>> +      * Defines the sampling SIMD/PRED(predicate) registers bitmap and
>>> +      * qwords (8 bytes) length.
>>> +      *
>>> +      * sample_simd_regs_enabled != 0 indicates there are SIMD/PRED
>>> +      * registers to be sampled, the SIMD/PRED registers bitmap and
>>> +      * qwords length are represented in
>>> +      * sample_simd_{vec|pred}_reg_{intr|user} and
>>> +      * sample_simd_{vec|pred}_reg_qwords fields separately.
>>> +      *
>>> +      * sample_simd_regs_enabled == 0 indicates no SIMD/PRED registers
>>> +      * are sampled.
>>> +      */
>>> +     __u16   sample_simd_regs_enabled;
>>> +     __u16   sample_simd_pred_reg_qwords;
>>> +     __u16   sample_simd_vec_reg_qwords;
>>> +     __u16   __reserved_4;
>>> +
>>> +     __u32   sample_simd_pred_reg_intr;
>>> +     __u32   sample_simd_pred_reg_user;
>>> +     __u64   sample_simd_vec_reg_intr;
>>> +     __u64   sample_simd_vec_reg_user;
>>>  };
>> [Severity: High]
>> Are these newly added fields missing byte-swapping logic in
>> perf_event__attr_swap()?
>>
>> When perf reads a cross-endian perf.data file, if these fields are not added
>> to perf_event__attr_swap() in tools/perf/util/session.c, they will remain in
>> their original byte order.
>>
>> Later, when evsel__parse_sample() relies on fields like attr_nr_vectors and
>> attr_vec_qwords to validate SIMD data bounds, could incorrect values bypass
>> validation or cause out-of-bounds read faults?
> This is a correct bug catch by Sashiko. We need to byte swap the
> perf_event_attr fields when reading them from a perf.data file on,
> say, an s390. Could you add this to perf_event_attr_swap?

Sure. Would fix it in next version.


>
>> [ ... ]
>>> @@ -1020,7 +1045,15 @@ enum perf_event_type {
>>>        *      } && PERF_SAMPLE_BRANCH_STACK
>>>        *
>>>        *      { u64                   abi; # enum perf_sample_regs_abi
>>> -      *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>>> +      *        u64                   regs[weight(mask)];
>>> +      *        struct {
>>> +      *              u64 nr_vectors;         # 0 ... weight(sample_simd_vec_reg_user)
>>> +      *              u64 vector_qwords;      # 0 ... sample_simd_vec_reg_qwords
>>> +      *              u64 nr_pred;            # 0 ... weight(sample_simd_pred_reg_user)
>>> +      *              u64 pred_qwords;        # 0 ... sample_simd_pred_reg_qwords
>>> +      *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>>> +      *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>>> +      *      } && PERF_SAMPLE_REGS_USER
>> [Severity: High]
>> Does appending this dynamic-length SIMD structure to PERF_SAMPLE_REGS_USER
>> break sample parsing for older perf tools?
>>
>> Older parsers do not know about the PERF_SAMPLE_REGS_ABI_SIMD bit. When
>> parsing the sample payload, they will only advance the array pointer by
>> hweight64(attr.sample_regs_user) * sizeof(u64) bytes, failing to skip the new
>> SIMD header and data.
>>
>> Could this cause subsequent fields like PERF_SAMPLE_STACK_USER to read the
>> SIMD data as their own, resulting in parsing desynchronization and data
>> corruption?
>>
>> Should a new bit be added to enum perf_event_sample_format instead?
> No, PERF_SAMPLE_REGS_ABI_SIMD can only occur if
> sample_simd_regs_enabled is present in the perf_event_attr and this is
> essentially the same.
>
>> [ ... ]
>>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>>> index f30e48eb3fc32..e8e4e00d6b4d0 100644
>>> --- a/tools/perf/util/header.c
>>> +++ b/tools/perf/util/header.c
>> [Severity: Critical]
>> This isn't a bug introduced by this patch, but is there an integer underflow
>> in read_attr() when processing the size field of the perf_event_attr structure?
>>
>> The function reads the first 64 bytes and extracts attr->size into sz. It
>> checks if sz == 0 or sz > our_sz, but fails to verify if sz < PERF_ATTR_SIZE_VER0.
>> If a perf.data file supplies a size between 1 and 63, could the calculation
>> left = sz - PERF_ATTR_SIZE_VER0 underflow the unsigned size_t variable left,
>> producing a huge positive value?
>>
>> The subsequent readn(fd, ptr, left) attempts to read this massive amount of
>> data into f_attr, which is allocated on the stack in
>> perf_session__read_header(), potentially resulting in a stack buffer overflow.
> Thankfully, I believe Arnaldo is looking into these pre-existing
> validation issues. See:
> https://lore.kernel.org/linux-perf-users/20260526211806.1193848-1-acme@kernel.org/

Got it. Thanks.


>
> Thanks,
> Ian
>
>> [Severity: Critical]
>> This is a pre-existing issue, but does read_event_desc() lack minimum size
>> validation on the sz variable before byte-swapping?
>>
>> The function reads a 32-bit sz from the file, allocates a heap buffer, and
>> calls perf_event__attr_swap(buf). Inside this function, the code
>> unconditionally reads and byte-swaps the first 8 bytes.
>>
>> If sz is between 1 and 7, attr->size reads out-of-bounds heap memory. Because
>> bswap_safe() uses this uncontrolled attr->size to determine which subsequent
>> fields to swap, could it proceed to byte-swap up to 176 bytes of heap memory
>> past the small allocation, leading to heap memory corruption?
>>
>>> @@ -2091,7 +2091,8 @@ static void free_event_desc(struct evsel *events)
>>>
>>>  static bool perf_attr_check(struct perf_event_attr *attr)
>>>  {
>>> -     if (attr->__reserved_1 || attr->__reserved_2 || attr->__reserved_3) {
>>> +     if (attr->__reserved_1 || attr->__reserved_2 ||
>>> +         attr->__reserved_3 || attr->__reserved_4) {
>>>               pr_warning("Reserved bits are set unexpectedly. "
>>>                          "Please update perf tool.\n");
>>>               return false;
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260529082451.591783-1-dapeng1.mi@linux.intel.com?part=1
>>
