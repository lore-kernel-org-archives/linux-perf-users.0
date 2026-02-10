Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402CA12D1F1;
	Tue, 10 Feb 2026 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703900; cv=none; b=SSYdTYutlaThihkYuGpJkX8f8H5h+tKWFvYSwaOk50qXkWGJKF0l3odTVLbg7xYCB2B2Pnlic6KB8y5iqP9Ixy7dHaqZYkxpCj17Ycjo6glsFauA/ewP3BJRI8YO+xIoG7vvWd415earWOMnc/huIvqTa/hzxGVeVwvN9KN1MXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703900; c=relaxed/simple;
	bh=TH21pTIy0OQlcC3gJRvJbTa0T8eg2UYMBbqx4LZ2s0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buLxIrAIP3z8OD70RloVe+EYXsuxmdmhRipjqguDKBJy9GXVX21bI3v1+x3gOBirByB3kHE7sVcXnC6Jyay1nEbJAmehOUCwaMBTndYECAvEFBb2wFmK1cqnfGYbh1kJ/c4IO7jNTf1EzOy21ela1yugBOHm8U+ecaeGRcx+hxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgGEouDQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgGEouDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770703899; x=1802239899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TH21pTIy0OQlcC3gJRvJbTa0T8eg2UYMBbqx4LZ2s0w=;
  b=GgGEouDQPpEZRciuy/nRfz9nWtJbZhrre35VQEyX0IX+fEEYNJ0zAju6
   cKVGGrJkQ9+dl9M3XSTenQ0t/QuqnLo702dOBkkTHiVHmV8veP5DsA8Ow
   uwnZaKYqReOiheeya/b1pgolQWr3pfhqk2cYdTkDc8G1s5WK9uuhbDF7M
   1ygz2P14fna2QRtHzAADyeDMyH4jwcttedIxjYpCZII3g/UQeQbrN+tcX
   k6o+ciumcZJmz4suENp1SmLt0j/LX7tcoriLzRs3dmvyBKG5EcxolD+lg
   ZQhxEWWmc2ZZ9h0QaFrIo0qBevgNq1GJ0uELfb7s8so8Yv3TOfigIHvfh
   w==;
X-CSE-ConnectionGUID: HFc9YGfuTJixPS5LORMCeA==
X-CSE-MsgGUID: 2b2c/CEXRjqIw1gafBHb/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71894314"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71894314"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 22:11:38 -0800
X-CSE-ConnectionGUID: eybREgHEQB6GvS/gwcoqjQ==
X-CSE-MsgGUID: 2X0Of6dxQd6tRF+KL0Y73A==
X-ExtLoop1: 1
Received: from qianm-mobl2.ccr.corp.intel.com (HELO [10.238.1.184]) ([10.238.1.184])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 22:11:35 -0800
Message-ID: <2665ea94-1606-471e-a78d-ec7d7702067e@linux.intel.com>
Date: Tue, 10 Feb 2026 14:11:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 4/4] perf regs: Enable dumping of SIMD registers
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com>
 <20260209083514.2225115-5-dapeng1.mi@linux.intel.com>
 <CAP-5=fUvqHOopAkXgbmPjdjUKuAkJ1NFQoArQvoyW0YKYB_y3w@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fUvqHOopAkXgbmPjdjUKuAkJ1NFQoArQvoyW0YKYB_y3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/10/2026 7:02 AM, Ian Rogers wrote:
> On Mon, Feb 9, 2026 at 12:39 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> This patch adds support for dumping SIMD registers using the new
>> PERF_SAMPLE_REGS_ABI_SIMD ABI.
> The parsing support is also added, so I think it should be "parsing
> and dumping" here and in the message subject.

Sure.


>
>> Currently, the XMM, YMM, ZMM, OPMASK, eGPRs, and SSP registers on x86
>> platforms are supported with the PERF_SAMPLE_REGS_ABI_SIMD ABI.
>>
>> An example of the output is displayed below.
>>
>> Example:
>>
>>  $perf record -e cycles:p -IXMM,YMM,OPMASK,SSP ./test
>>  $perf report -D
>>  ... ...
>>  237538985992962 0x454d0 [0x480]: PERF_RECORD_SAMPLE(IP, 0x1):
>>  179370/179370: 0xffffffff969627fc period: 124999 addr: 0
>>  ... intr regs: mask 0x20000000000 ABI 64-bit
>>  .... SSP   0x0000000000000000
>>  ... SIMD ABI nr_vectors 32 vector_qwords 4 nr_pred 8 pred_qwords 1
>>  .... YMM  [0] 0x0000000000004000
>>  .... YMM  [0] 0x000055e828695270
>>  .... YMM  [0] 0x0000000000000000
>>  .... YMM  [0] 0x0000000000000000
>>  .... YMM  [1] 0x000055e8286990e0
>>  .... YMM  [1] 0x000055e828698dd0
>>  .... YMM  [1] 0x0000000000000000
>>  .... YMM  [1] 0x0000000000000000
>>  ... ...
>>  .... YMM  [31] 0x0000000000000000
>>  .... YMM  [31] 0x0000000000000000
>>  .... YMM  [31] 0x0000000000000000
>>  .... YMM  [31] 0x0000000000000000
>>  .... OPMASK[0] 0x0000000000100221
>>  .... OPMASK[1] 0x0000000000000020
>>  .... OPMASK[2] 0x000000007fffffff
>>  .... OPMASK[3] 0x0000000000000000
>>  .... OPMASK[4] 0x0000000000000000
>>  .... OPMASK[5] 0x0000000000000000
>>  .... OPMASK[6] 0x0000000000000000
>>  .... OPMASK[7] 0x0000000000000000
>>  ... ...
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/util/evsel.c   | 20 ++++++++++
>>  tools/perf/util/sample.h  | 10 +++++
>>  tools/perf/util/session.c | 77 +++++++++++++++++++++++++++++++++++----
>>  3 files changed, 99 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index a86d2434a4ad..2e1d50a72762 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -3514,6 +3514,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>                         regs->mask = mask;
>>                         regs->regs = (u64 *)array;
>>                         array = (void *)array + sz;
>> +
>> +                       if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
>> +                               regs->config = *(u64 *)array;
>> +                               array = (void *)array + sizeof(u64);
>> +                               regs->data = (u64 *)array;
> It could be nice to add asserts for the comments:
> ```
>         *              u16 nr_vectors;         # 0 ...
> weight(sample_simd_vec_reg_user)
>         *              u16 vector_qwords;      # 0 ...
> sample_simd_vec_reg_qwords
>         *              u16 nr_pred;            # 0 ...
> weight(sample_simd_pred_reg_user)
>         *              u16 pred_qwords;        # 0 ...
> sample_simd_pred_reg_qwords
>         *              u64 data[nr_vectors * vector_qwords + nr_pred *
> pred_qwords];
> ```
> ie:
> ```
> assert(regs->nr_vectors <= hweight64(
> evsel->core.attr.sample_simd_vec_reg_user));
> assert(regs->vector_qwords <= evsel->core.attr.sample_simd_vec_reg_qwords);
> assert(regs->nr_vectors <= hweight64(
> evsel->core.attr.sample_simd_pred_reg_user));
> assert(regs->vector_qwords <= evsel->core.attr.sample_simd_pred_reg_qwords);

Good idea. Would do.


> ```
>
>> +                               sz = (regs->nr_vectors * regs->vector_qwords +
>> +                                     regs->nr_pred * regs->pred_qwords) * sizeof(u64);
>> +                               OVERFLOW_CHECK(array, sz, max_size);
>> +                               array = (void *)array + sz;
>> +                       }
>>                 }
>>         }
>>
>> @@ -3571,6 +3581,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>                         regs->mask = mask;
>>                         regs->regs = (u64 *)array;
>>                         array = (void *)array + sz;
>> +
>> +                       if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
>> +                               regs->config = *(u64 *)array;
>> +                               array = (void *)array + sizeof(u64);
>> +                               regs->data = (u64 *)array;
> As above but for intr:
> ```
> assert(regs->nr_vectors <= hweight64(
> evsel->core.attr.sample_simd_vec_reg_intr));
> assert(regs->vector_qwords <= evsel->core.attr.sample_simd_vec_reg_qwords);
> assert(regs->nr_vectors <= hweight64(
> evsel->core.attr.sample_simd_pred_reg_intr));
> assert(regs->vector_qwords <= evsel->core.attr.sample_simd_pred_reg_qwords);
> ```

Sure.


>> +                               sz = (regs->nr_vectors * regs->vector_qwords +
>> +                                     regs->nr_pred * regs->pred_qwords) * sizeof(u64);
>> +                               OVERFLOW_CHECK(array, sz, max_size);
>> +                               array = (void *)array + sz;
>> +                       }
>>                 }
>>         }
>>
>> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
>> index 3cce8dd202aa..b98bc58d365e 100644
>> --- a/tools/perf/util/sample.h
>> +++ b/tools/perf/util/sample.h
>> @@ -15,6 +15,16 @@ struct regs_dump {
>>         u64 abi;
>>         u64 mask;
>>         u64 *regs;
>> +       union {
>> +               u64 config;
>> +               struct {
>> +                       u16 nr_vectors;
>> +                       u16 vector_qwords;
>> +                       u16 nr_pred;
>> +                       u16 pred_qwords;
>> +               };
>> +       };
>> +       u64 *data;
> I think "data" is a bit generic here and could be confused with regs,
> perhaps "simd_data" for clarity.

Sure.


>
>>         /* Cached values/mask filled by first register access. */
>>         u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 7cf7bf86205d..fba8ef52f0a1 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -972,18 +972,77 @@ static void regs_dump__printf(u64 mask, struct regs_dump *regs,
>>         }
>>  }
>>
>> -static const char *regs_abi[] = {
>> -       [PERF_SAMPLE_REGS_ABI_NONE] = "none",
>> -       [PERF_SAMPLE_REGS_ABI_32] = "32-bit",
>> -       [PERF_SAMPLE_REGS_ABI_64] = "64-bit",
>> -};
>> +static void simd_regs_dump__printf(struct regs_dump *regs, bool intr)
>> +{
>> +       const char *name = "unknown";
>> +       int i, idx = 0;
>> +       uint16_t qwords;
>> +       int reg_c;
>> +
>> +       if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
>> +               return;
>> +
>> +       printf("... SIMD ABI nr_vectors %d vector_qwords %d nr_pred %d pred_qwords %d\n",
>> +              regs->nr_vectors, regs->vector_qwords,
>> +              regs->nr_pred, regs->pred_qwords);
>> +
>> +       for (reg_c = 0; reg_c < 64; reg_c++) {
>> +               if (intr) {
>> +                       perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
> Rather than EM_HOST here, can e_machine be an argument to the
> function? That way we can x86 SIMD registers on a non-x86 machine.
>
>> +                                                              &qwords, /*pred=*/false);
>> +               } else {
>> +                       perf_user_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
>> +                                                              &qwords, /*pred=*/false);
>> +               }
>> +               if (regs->vector_qwords == qwords) {
>> +                       name = perf_simd_reg_class_name(EM_HOST, reg_c, /*pred=*/false);
>> +                       break;
>> +               }
>> +       }
>> +
>> +       for (i = 0; i < regs->nr_vectors; i++) {
>> +               printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
>> +               printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
> Is 'i' the correct value to dump here? If the bitmap of pred or vec
> registers has gaps in it then we may dump say "YMM0" and "YMM1" for a
> bitmap of say "YMM0" and "YMM2". I think you may need to do something
> like bitmap's for_each_set_bit.

Currently the SIMD registers can only be sampled as a whole, so there
should be a hole in the registers bitmap, and I think we don't need to
worry this.

BTW, I looked the code, it seems quite hard to get the "sample_simd_xxx"
registers bitmap in this function ...



>
>> +               if (regs->vector_qwords > 2) {
>> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
>> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
>> +               }
>> +               if (regs->vector_qwords > 4) {
>> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
>> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
>> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
>> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
>> +               }
>> +       }
>> +
>> +       name = "unknown";
>> +       for (reg_c = 0; reg_c < 64; reg_c++) {
>> +               if (intr) {
>> +                       perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
>> +                                                              &qwords, /*pred=*/true);
>> +               } else {
>> +                       perf_user_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
>> +                                                              &qwords, /*pred=*/true);
>> +               }
>> +               if (regs->pred_qwords == qwords) {
>> +                       name = perf_simd_reg_class_name(EM_HOST, reg_c, /*pred=*/true);
>> +                       break;
>> +               }
>> +       }
>> +       for (i = 0; i < regs->nr_pred; i++)
>> +               printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
>> +}
>>
>>  static inline const char *regs_dump_abi(struct regs_dump *d)
>>  {
>> -       if (d->abi > PERF_SAMPLE_REGS_ABI_64)
>> -               return "unknown";
>> +       if (!d->abi)
>> +               return "none";
>> +       if (d->abi & PERF_SAMPLE_REGS_ABI_32)
>> +               return "32-bit";
>> +       else if (d->abi & PERF_SAMPLE_REGS_ABI_64)
>> +               return "64-bit";
> This isn't testing PERF_SAMPLE_REGS_ABI_SIMD and reports "32-bit" if
> both ABI_32 and ABI_64 are set, which is a little surprising. Perhaps:
> ```
> const char *regs_abi[] = {
> [PERF_SAMPLE_REGS_ABI_32] = "32-bit",
> [PERF_SAMPLE_REGS_ABI_64] = "64-bit",
> [PERF_SAMPLE_REGS_ABI_SIMD | PERF_SAMPLE_REGS_ABI_64] = "SIMD",
> }
> if (d->abi >= ARRAY_SIZE(regs_abi) || !regs_abi[d->abi])
>   return "unknown";
> return regs_abi[d->abi];

I'm not sure if we should return "SIMD" for this function when
PERF_SAMPLE_REGS_ABI_SIMD is set. The original regs_dump_abi() only returns
"32-bit" or "64 bit". If we really want to highlight the SIMD, maybe we can
return "64-bit SIMD".

Thanks.

> ```
>
> Thanks,
> Ian
>
>
>> -       return regs_abi[d->abi];
>> +       return "unknown";
>>  }
>>
>>  static void regs__printf(const char *type, struct regs_dump *regs,
>> @@ -1010,6 +1069,7 @@ static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, ui
>>
>>         if (user_regs->regs)
>>                 regs__printf("user", user_regs, e_machine, e_flags);
>> +       simd_regs_dump__printf(user_regs, /*intr=*/false);
>>  }
>>
>>  static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
>> @@ -1023,6 +1083,7 @@ static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, ui
>>
>>         if (intr_regs->regs)
>>                 regs__printf("intr", intr_regs, e_machine, e_flags);
>> +       simd_regs_dump__printf(intr_regs, /*intr=*/true);
>>  }
>>
>>  static void stack_user__printf(struct stack_dump *dump)
>> --
>> 2.34.1
>>
