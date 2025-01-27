Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFDB78F58;
	Mon, 27 Jan 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993056; cv=none; b=t1dmt1YDDQt5Qq7z3R99AWBtBAA8atKGHAA8NaPfEl3FshtsxeyDQGJmfEhiSqP1UOYKRpaY+mUSBWKHa1VyLtKI7jwm+ZfQwDuxurub9VW1x2Gy8U3C8E5xjHXTcuxsqpYMNOKhO5mvJeqxDNHOnvJxTt+b6RiaNKkpD7L+vfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993056; c=relaxed/simple;
	bh=bBQnAom/BR3cXhG3yhuACYHFHHeUXaOSi22DwBCdLPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkgCJfqZo1EHcdMMjlaa1jvzc0eBZm+LRuvWrU3BUoHLntW/AYSADwHsnPUNbEcr5Cw7WJsGr1uislFNppsXqbHtb0CS2bi6skZzD0oMAxs2/iB5YOnNQny4YGzt8xGfxZ8GS3UJ5h1dDfBWKrTaNlnn5cQ60LVTBVm/DcSXqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNECgE3u; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNECgE3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737993053; x=1769529053;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bBQnAom/BR3cXhG3yhuACYHFHHeUXaOSi22DwBCdLPo=;
  b=eNECgE3u1Fe6zUaTuDnMJ2Vpy3LqPV7sNhnBfsoRHiGXpGdiqH2t+atk
   JOcg9J9r+2r6GDbWm6nbROUjXV5Pv7kHD8URfHLI67J1jcSmiC9ketscL
   nLJeQVnmBnDJYzlWETG1oyZAjbf9WVpiMupaS5bxeZVNurQqg8AEFBYg/
   3y3gf5TLk6x7c142K71gUxJCpvQuG6piSMANrlDOXLC4uLg0V3FOEVCE9
   DfW6y6wdfzbI3SNKt/7+aPdT5bg1UA5LAezwciOMjLlQueyQwQpepdYLQ
   N63NnemMprwW5XA7/Cp7RCK1Mp70bnDwidl13jEvv5z8vb3WiwDLe9172
   w==;
X-CSE-ConnectionGUID: DvSAFaHWSmu9TKzsUt8yDw==
X-CSE-MsgGUID: TmDSpV8UShOrTqkpAIab6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="55998999"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="55998999"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:50:50 -0800
X-CSE-ConnectionGUID: q6Jh0qokS9Wt2FI18ZjoKw==
X-CSE-MsgGUID: Vnls9BeVTCG5mwRxfhL0cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108585375"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:50:40 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1693B20B5713;
	Mon, 27 Jan 2025 07:50:39 -0800 (PST)
Message-ID: <ffedeac7-bb47-4fab-a0b4-23c75d133e44@linux.intel.com>
Date: Mon, 27 Jan 2025 10:50:38 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] perf tools: Support to capture more vector
 registers (common part)
To: Ian Rogers <irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-19-dapeng1.mi@linux.intel.com>
 <CAP-5=fUjn8Xuhe-OQTdMXaqtqfemrbT7rAiy5KbORbKGJr6gaw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUjn8Xuhe-OQTdMXaqtqfemrbT7rAiy5KbORbKGJr6gaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-01-23 11:42 a.m., Ian Rogers wrote:
> On Wed, Jan 22, 2025 at 10:21 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>>
>> Intel architectural PEBS supports to capture more vector registers like
>> OPMASK/YMM/ZMM registers besides already supported XMM registers.
>>
>> arch-PEBS vector registers (VCER) capturing on perf core/pmu driver
>> (Intel) has been supported by previous patches. This patch adds perf
>> tool's part support. In detail, add support for the new
>> sample_regs_intr_ext register selector in perf_event_attr. This 32 bytes
>> bitmap is used to select the new register group OPMASK, YMMH, ZMMH and
>> ZMM in VECR. Update perf regs to introduce the new registers.
>>
>> This single patch only introduces the common support, x86/intel specific
>> support would be added in next patch.
> 
> Could you break down what the individual changes are? I see quite a
> few, some in printing, some with functions like arch__intr_reg_mask.
> I'm sure the changes are well motivated but there is little detail in
> the commit message. Perhaps there is some chance to separate each
> change into its own patch. By detail I mean something like, "change
> arch__intr_reg_mask to taking a pointer so that REG_MASK and array
> initialization is possible."
> 
> It is a shame arch__intr_reg_mask doesn't match arch__user_reg_mask
> following this change. Perhaps update them both for the sake of
> consistency.

Yes, it sounds cleaner. The same size but different mask. It may waste
some space but it should be OK.

> 
> Out of scope here, I wonder in general how we can get this code out of
> the arch directory? For example, it would be nice if we have say an
> arm perf command running on qemu-user on an x86 that we perhaps want
> to do the appropriate reg_mask for x86.

Different ARCH has a different pt_regs. It seems hard to general a
generic reg list.

Thanks,
Kan
> 
> Thanks,
> Ian
> 
>> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/include/uapi/linux/perf_event.h      | 13 +++++++++
>>  tools/perf/arch/arm/util/perf_regs.c       |  5 +---
>>  tools/perf/arch/arm64/util/perf_regs.c     |  5 +---
>>  tools/perf/arch/csky/util/perf_regs.c      |  5 +---
>>  tools/perf/arch/loongarch/util/perf_regs.c |  5 +---
>>  tools/perf/arch/mips/util/perf_regs.c      |  5 +---
>>  tools/perf/arch/powerpc/util/perf_regs.c   |  9 ++++---
>>  tools/perf/arch/riscv/util/perf_regs.c     |  5 +---
>>  tools/perf/arch/s390/util/perf_regs.c      |  5 +---
>>  tools/perf/arch/x86/util/perf_regs.c       |  9 ++++---
>>  tools/perf/builtin-script.c                | 19 ++++++++++---
>>  tools/perf/util/evsel.c                    | 14 +++++++---
>>  tools/perf/util/parse-regs-options.c       | 23 +++++++++-------
>>  tools/perf/util/perf_regs.c                |  5 ----
>>  tools/perf/util/perf_regs.h                | 18 +++++++++++--
>>  tools/perf/util/record.h                   |  2 +-
>>  tools/perf/util/sample.h                   |  6 ++++-
>>  tools/perf/util/session.c                  | 31 +++++++++++++---------
>>  tools/perf/util/synthetic-events.c         |  7 +++--
>>  19 files changed, 116 insertions(+), 75 deletions(-)
>>
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index 4842c36fdf80..02d8f55f6247 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -379,6 +379,13 @@ enum perf_event_read_format {
>>  #define PERF_ATTR_SIZE_VER6    120     /* add: aux_sample_size */
>>  #define PERF_ATTR_SIZE_VER7    128     /* add: sig_data */
>>  #define PERF_ATTR_SIZE_VER8    136     /* add: config3 */
>> +#define PERF_ATTR_SIZE_VER9    168     /* add: sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE] */
>> +
>> +#define PERF_EXT_REGS_ARRAY_SIZE       4
>> +#define PERF_NUM_EXT_REGS              (PERF_EXT_REGS_ARRAY_SIZE * 64)
>> +
>> +#define PERF_NUM_INTR_REGS             (PERF_EXT_REGS_ARRAY_SIZE + 1)
>> +#define PERF_NUM_INTR_REGS_SIZE                ((PERF_NUM_INTR_REGS) * 64)
>>
>>  /*
>>   * Hardware event_id to monitor via a performance monitoring event:
>> @@ -522,6 +529,12 @@ struct perf_event_attr {
>>         __u64   sig_data;
>>
>>         __u64   config3; /* extension of config2 */
>> +
>> +       /*
>> +        * Extension sets of regs to dump for each sample.
>> +        * See asm/perf_regs.h for details.
>> +        */
>> +       __u64   sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE];
>>  };
>>
>>  /*
>> diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
>> index f94a0210c7b7..3a3c2779efd4 100644
>> --- a/tools/perf/arch/arm/util/perf_regs.c
>> +++ b/tools/perf/arch/arm/util/perf_regs.c
>> @@ -6,10 +6,7 @@ static const struct sample_reg sample_reg_masks[] = {
>>         SMPL_REG_END
>>  };
>>
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> +void arch__intr_reg_mask(unsigned long *mask) {}
>>
>>  uint64_t arch__user_reg_mask(void)
>>  {
>> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
>> index 09308665e28a..754bb8423733 100644
>> --- a/tools/perf/arch/arm64/util/perf_regs.c
>> +++ b/tools/perf/arch/arm64/util/perf_regs.c
>> @@ -140,10 +140,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>>         return SDT_ARG_VALID;
>>  }
>>
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> +void arch__intr_reg_mask(unsigned long *mask) {}
>>
>>  uint64_t arch__user_reg_mask(void)
>>  {
>> diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
>> index 6b1665f41180..9d132150ecb6 100644
>> --- a/tools/perf/arch/csky/util/perf_regs.c
>> +++ b/tools/perf/arch/csky/util/perf_regs.c
>> @@ -6,10 +6,7 @@ static const struct sample_reg sample_reg_masks[] = {
>>         SMPL_REG_END
>>  };
>>
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> +void arch__intr_reg_mask(unsigned long *mask) {}
>>
>>  uint64_t arch__user_reg_mask(void)
>>  {
>> diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
>> index f94a0210c7b7..3a3c2779efd4 100644
>> --- a/tools/perf/arch/loongarch/util/perf_regs.c
>> +++ b/tools/perf/arch/loongarch/util/perf_regs.c
>> @@ -6,10 +6,7 @@ static const struct sample_reg sample_reg_masks[] = {
>>         SMPL_REG_END
>>  };
>>
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> +void arch__intr_reg_mask(unsigned long *mask) {}
>>
>>  uint64_t arch__user_reg_mask(void)
>>  {
>> diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
>> index 6b1665f41180..9d132150ecb6 100644
>> --- a/tools/perf/arch/mips/util/perf_regs.c
>> +++ b/tools/perf/arch/mips/util/perf_regs.c
>> @@ -6,10 +6,7 @@ static const struct sample_reg sample_reg_masks[] = {
>>         SMPL_REG_END
>>  };
>>
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> +void arch__intr_reg_mask(unsigned long *mask) {}
>>
>>  uint64_t arch__user_reg_mask(void)
>>  {
>> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
>> index e8e6e6fc6f17..08ab9ed692fb 100644
>> --- a/tools/perf/arch/powerpc/util/perf_regs.c
>> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
>> @@ -186,7 +186,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>>         return SDT_ARG_VALID;
>>  }
>>
>> -uint64_t arch__intr_reg_mask(void)
>> +void arch__intr_reg_mask(unsigned long *mask)
>>  {
>>         struct perf_event_attr attr = {
>>                 .type                   = PERF_TYPE_HARDWARE,
>> @@ -198,7 +198,9 @@ uint64_t arch__intr_reg_mask(void)
>>         };
>>         int fd;
>>         u32 version;
>> -       u64 extended_mask = 0, mask = PERF_REGS_MASK;
>> +       u64 extended_mask = 0;
>> +
>> +       *(u64 *)mask = PERF_REGS_MASK;
>>
>>         /*
>>          * Get the PVR value to set the extended
>> @@ -223,9 +225,8 @@ uint64_t arch__intr_reg_mask(void)
>>         fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>>         if (fd != -1) {
>>                 close(fd);
>> -               mask |= extended_mask;
>> +               *(u64 *)mask |= extended_mask;
>>         }
>> -       return mask;
>>  }
>>
>>  uint64_t arch__user_reg_mask(void)
>> diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
>> index 6b1665f41180..9d132150ecb6 100644
>> --- a/tools/perf/arch/riscv/util/perf_regs.c
>> +++ b/tools/perf/arch/riscv/util/perf_regs.c
>> @@ -6,10 +6,7 @@ static const struct sample_reg sample_reg_masks[] = {
>>         SMPL_REG_END
>>  };
>>
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> +void arch__intr_reg_mask(unsigned long *mask) {}
>>
>>  uint64_t arch__user_reg_mask(void)
>>  {
>> diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
>> index 6b1665f41180..9d132150ecb6 100644
>> --- a/tools/perf/arch/s390/util/perf_regs.c
>> +++ b/tools/perf/arch/s390/util/perf_regs.c
>> @@ -6,10 +6,7 @@ static const struct sample_reg sample_reg_masks[] = {
>>         SMPL_REG_END
>>  };
>>
>> -uint64_t arch__intr_reg_mask(void)
>> -{
>> -       return PERF_REGS_MASK;
>> -}
>> +void arch__intr_reg_mask(unsigned long *mask) {}
>>
>>  uint64_t arch__user_reg_mask(void)
>>  {
>> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
>> index 9f492568f3b4..52f08498d005 100644
>> --- a/tools/perf/arch/x86/util/perf_regs.c
>> +++ b/tools/perf/arch/x86/util/perf_regs.c
>> @@ -283,7 +283,7 @@ const struct sample_reg *arch__sample_reg_masks(void)
>>         return sample_reg_masks;
>>  }
>>
>> -uint64_t arch__intr_reg_mask(void)
>> +void arch__intr_reg_mask(unsigned long *mask)
>>  {
>>         struct perf_event_attr attr = {
>>                 .type                   = PERF_TYPE_HARDWARE,
>> @@ -295,6 +295,9 @@ uint64_t arch__intr_reg_mask(void)
>>                 .exclude_kernel         = 1,
>>         };
>>         int fd;
>> +
>> +       *(u64 *)mask = PERF_REGS_MASK;
>> +
>>         /*
>>          * In an unnamed union, init it here to build on older gcc versions
>>          */
>> @@ -320,10 +323,8 @@ uint64_t arch__intr_reg_mask(void)
>>         fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>>         if (fd != -1) {
>>                 close(fd);
>> -               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
>> +               *(u64 *)mask |= PERF_REG_EXTENDED_MASK;
>>         }
>> -
>> -       return PERF_REGS_MASK;
>>  }
>>
>>  uint64_t arch__user_reg_mask(void)
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 9e47905f75a6..66d3923e4040 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -704,10 +704,11 @@ static int perf_session__check_output_opt(struct perf_session *session)
>>  }
>>
>>  static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, const char *arch,
>> -                                    FILE *fp)
>> +                               unsigned long *mask_ext, FILE *fp)
>>  {
>>         unsigned i = 0, r;
>>         int printed = 0;
>> +       u64 val;
>>
>>         if (!regs || !regs->regs)
>>                 return 0;
>> @@ -715,7 +716,15 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask, cons
>>         printed += fprintf(fp, " ABI:%" PRIu64 " ", regs->abi);
>>
>>         for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>> -               u64 val = regs->regs[i++];
>> +               val = regs->regs[i++];
>> +               printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r, arch), val);
>> +       }
>> +
>> +       if (!mask_ext)
>> +               return printed;
>> +
>> +       for_each_set_bit(r, mask_ext, PERF_NUM_EXT_REGS) {
>> +               val = regs->regs[i++];
>>                 printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r, arch), val);
>>         }
>>
>> @@ -776,14 +785,16 @@ static int perf_sample__fprintf_iregs(struct perf_sample *sample,
>>                                       struct perf_event_attr *attr, const char *arch, FILE *fp)
>>  {
>>         return perf_sample__fprintf_regs(&sample->intr_regs,
>> -                                        attr->sample_regs_intr, arch, fp);
>> +                                        attr->sample_regs_intr, arch,
>> +                                        (unsigned long *)attr->sample_regs_intr_ext,
>> +                                        fp);
>>  }
>>
>>  static int perf_sample__fprintf_uregs(struct perf_sample *sample,
>>                                       struct perf_event_attr *attr, const char *arch, FILE *fp)
>>  {
>>         return perf_sample__fprintf_regs(&sample->user_regs,
>> -                                        attr->sample_regs_user, arch, fp);
>> +                                        attr->sample_regs_user, arch, NULL, fp);
>>  }
>>
>>  static int perf_sample__fprintf_start(struct perf_script *script,
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index f745723d486b..297b960ac446 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1314,9 +1314,11 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>>         if (callchain && callchain->enabled && !evsel->no_aux_samples)
>>                 evsel__config_callchain(evsel, opts, callchain);
>>
>> -       if (opts->sample_intr_regs && !evsel->no_aux_samples &&
>> -           !evsel__is_dummy_event(evsel)) {
>> -               attr->sample_regs_intr = opts->sample_intr_regs;
>> +       if (bitmap_weight(opts->sample_intr_regs, PERF_NUM_INTR_REGS_SIZE) &&
>> +                       !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
>> +               attr->sample_regs_intr = opts->sample_intr_regs[0];
>> +               memcpy(attr->sample_regs_intr_ext, &opts->sample_intr_regs[1],
>> +                               PERF_NUM_EXT_REGS / 8);
>>                 evsel__set_sample_bit(evsel, REGS_INTR);
>>         }
>>
>> @@ -3097,10 +3099,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>
>>                 if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
>>                         u64 mask = evsel->core.attr.sample_regs_intr;
>> +                       unsigned long *mask_ext =
>> +                               (unsigned long *)evsel->core.attr.sample_regs_intr_ext;
>> +                       u64 *intr_regs_mask;
>>
>>                         sz = hweight64(mask) * sizeof(u64);
>> +                       sz += bitmap_weight(mask_ext, PERF_NUM_EXT_REGS) * sizeof(u64);
>>                         OVERFLOW_CHECK(array, sz, max_size);
>>                         data->intr_regs.mask = mask;
>> +                       intr_regs_mask = (u64 *)&data->intr_regs.mask_ext;
>> +                       memcpy(&intr_regs_mask[1], mask_ext, PERF_NUM_EXT_REGS);
>>                         data->intr_regs.regs = (u64 *)array;
>>                         array = (void *)array + sz;
>>                 }
>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>> index cda1c620968e..666c2a172ef2 100644
>> --- a/tools/perf/util/parse-regs-options.c
>> +++ b/tools/perf/util/parse-regs-options.c
>> @@ -12,11 +12,13 @@
>>  static int
>>  __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>  {
>> +       unsigned int size = intr ? PERF_NUM_INTR_REGS * 64 : 64;
>>         uint64_t *mode = (uint64_t *)opt->value;
>>         const struct sample_reg *r = NULL;
>>         char *s, *os = NULL, *p;
>>         int ret = -1;
>> -       uint64_t mask;
>> +       DECLARE_BITMAP(mask, size);
>> +       DECLARE_BITMAP(mask_tmp, size);
>>
>>         if (unset)
>>                 return 0;
>> @@ -24,13 +26,14 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>         /*
>>          * cannot set it twice
>>          */
>> -       if (*mode)
>> +       if (bitmap_weight((unsigned long *)mode, size))
>>                 return -1;
>>
>> +       bitmap_zero(mask, size);
>>         if (intr)
>> -               mask = arch__intr_reg_mask();
>> +               arch__intr_reg_mask(mask);
>>         else
>> -               mask = arch__user_reg_mask();
>> +               *(uint64_t *)mask = arch__user_reg_mask();
>>
>>         /* str may be NULL in case no arg is passed to -I */
>>         if (str) {
>> @@ -47,7 +50,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>                         if (!strcmp(s, "?")) {
>>                                 fprintf(stderr, "available registers: ");
>>                                 for (r = arch__sample_reg_masks(); r->name; r++) {
>> -                                       if (r->mask & mask)
>> +                                       bitmap_and(mask_tmp, mask, r->mask_ext, size);
>> +                                       if (bitmap_weight(mask_tmp, size))
>>                                                 fprintf(stderr, "%s ", r->name);
>>                                 }
>>                                 fputc('\n', stderr);
>> @@ -55,7 +59,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>                                 goto error;
>>                         }
>>                         for (r = arch__sample_reg_masks(); r->name; r++) {
>> -                               if ((r->mask & mask) && !strcasecmp(s, r->name))
>> +                               bitmap_and(mask_tmp, mask, r->mask_ext, size);
>> +                               if (bitmap_weight(mask_tmp, size) && !strcasecmp(s, r->name))
>>                                         break;
>>                         }
>>                         if (!r || !r->name) {
>> @@ -64,7 +69,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>                                 goto error;
>>                         }
>>
>> -                       *mode |= r->mask;
>> +                       bitmap_or((unsigned long *)mode, (unsigned long *)mode, r->mask_ext, size);
>>
>>                         if (!p)
>>                                 break;
>> @@ -75,8 +80,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>         ret = 0;
>>
>>         /* default to all possible regs */
>> -       if (*mode == 0)
>> -               *mode = mask;
>> +       if (!bitmap_weight((unsigned long *)mode, size))
>> +               bitmap_or((unsigned long *)mode, (unsigned long *)mode, mask, size);
>>  error:
>>         free(os);
>>         return ret;
>> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
>> index 44b90bbf2d07..b36eafc10e84 100644
>> --- a/tools/perf/util/perf_regs.c
>> +++ b/tools/perf/util/perf_regs.c
>> @@ -11,11 +11,6 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
>>         return SDT_ARG_SKIP;
>>  }
>>
>> -uint64_t __weak arch__intr_reg_mask(void)
>> -{
>> -       return 0;
>> -}
>> -
>>  uint64_t __weak arch__user_reg_mask(void)
>>  {
>>         return 0;
>> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
>> index f2d0736d65cc..5018b8d040ee 100644
>> --- a/tools/perf/util/perf_regs.h
>> +++ b/tools/perf/util/perf_regs.h
>> @@ -4,18 +4,32 @@
>>
>>  #include <linux/types.h>
>>  #include <linux/compiler.h>
>> +#include <linux/bitmap.h>
>> +#include <linux/perf_event.h>
>> +#include "util/record.h"
>>
>>  struct regs_dump;
>>
>>  struct sample_reg {
>>         const char *name;
>> -       uint64_t mask;
>> +       union {
>> +               uint64_t mask;
>> +               DECLARE_BITMAP(mask_ext, PERF_NUM_INTR_REGS * 64);
>> +       };
>>  };
>>
>>  #define SMPL_REG_MASK(b) (1ULL << (b))
>>  #define SMPL_REG(n, b) { .name = #n, .mask = SMPL_REG_MASK(b) }
>>  #define SMPL_REG2_MASK(b) (3ULL << (b))
>>  #define SMPL_REG2(n, b) { .name = #n, .mask = SMPL_REG2_MASK(b) }
>> +#define SMPL_REG_EXT(n, b)     \
>> +       { .name = #n, .mask_ext[b / __BITS_PER_LONG] = 0x1ULL << (b % __BITS_PER_LONG) }
>> +#define SMPL_REG2_EXT(n, b)    \
>> +       { .name = #n, .mask_ext[b / __BITS_PER_LONG] = 0x3ULL << (b % __BITS_PER_LONG) }
>> +#define SMPL_REG4_EXT(n, b)    \
>> +       { .name = #n, .mask_ext[b / __BITS_PER_LONG] = 0xfULL << (b % __BITS_PER_LONG) }
>> +#define SMPL_REG8_EXT(n, b)    \
>> +       { .name = #n, .mask_ext[b / __BITS_PER_LONG] = 0xffULL << (b % __BITS_PER_LONG) }
>>  #define SMPL_REG_END { .name = NULL }
>>
>>  enum {
>> @@ -24,7 +38,7 @@ enum {
>>  };
>>
>>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
>> -uint64_t arch__intr_reg_mask(void);
>> +void arch__intr_reg_mask(unsigned long *mask);
>>  uint64_t arch__user_reg_mask(void);
>>  const struct sample_reg *arch__sample_reg_masks(void);
>>
>> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
>> index a6566134e09e..16e44a640e57 100644
>> --- a/tools/perf/util/record.h
>> +++ b/tools/perf/util/record.h
>> @@ -57,7 +57,7 @@ struct record_opts {
>>         unsigned int  auxtrace_mmap_pages;
>>         unsigned int  user_freq;
>>         u64           branch_stack;
>> -       u64           sample_intr_regs;
>> +       u64           sample_intr_regs[PERF_NUM_INTR_REGS];
>>         u64           sample_user_regs;
>>         u64           default_interval;
>>         u64           user_interval;
>> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
>> index 70b2c3135555..98c9c4260de6 100644
>> --- a/tools/perf/util/sample.h
>> +++ b/tools/perf/util/sample.h
>> @@ -4,13 +4,17 @@
>>
>>  #include <linux/perf_event.h>
>>  #include <linux/types.h>
>> +#include <linux/bitmap.h>
>>
>>  /* number of register is bound by the number of bits in regs_dump::mask (64) */
>>  #define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
>>
>>  struct regs_dump {
>>         u64 abi;
>> -       u64 mask;
>> +       union {
>> +               u64 mask;
>> +               DECLARE_BITMAP(mask_ext, PERF_NUM_INTR_REGS * 64);
>> +       };
>>         u64 *regs;
>>
>>         /* Cached values/mask filled by first register access. */
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 507e6cba9545..995f5c2963bc 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -909,12 +909,13 @@ static void branch_stack__printf(struct perf_sample *sample,
>>         }
>>  }
>>
>> -static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
>> +static void regs_dump__printf(bool intr, struct regs_dump *regs, const char *arch)
>>  {
>> +       unsigned int size = intr ? PERF_NUM_INTR_REGS * 64 : 64;
>>         unsigned rid, i = 0;
>>
>> -       for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
>> -               u64 val = regs[i++];
>> +       for_each_set_bit(rid, regs->mask_ext, size) {
>> +               u64 val = regs->regs[i++];
>>
>>                 printf(".... %-5s 0x%016" PRIx64 "\n",
>>                        perf_reg_name(rid, arch), val);
>> @@ -935,16 +936,22 @@ static inline const char *regs_dump_abi(struct regs_dump *d)
>>         return regs_abi[d->abi];
>>  }
>>
>> -static void regs__printf(const char *type, struct regs_dump *regs, const char *arch)
>> +static void regs__printf(bool intr, struct regs_dump *regs, const char *arch)
>>  {
>> -       u64 mask = regs->mask;
>> +       if (intr) {
>> +               u64 *mask = (u64 *)&regs->mask_ext;
>>
>> -       printf("... %s regs: mask 0x%" PRIx64 " ABI %s\n",
>> -              type,
>> -              mask,
>> -              regs_dump_abi(regs));
>> +               printf("... intr regs: mask 0x");
>> +               for (int i = 0; i < PERF_NUM_INTR_REGS; i++)
>> +                       printf("%" PRIx64 "", mask[i]);
>> +               printf(" ABI %s\n", regs_dump_abi(regs));
>> +       } else {
>> +               printf("... user regs: mask 0x%" PRIx64 " ABI %s\n",
>> +                      regs->mask,
>> +                      regs_dump_abi(regs));
>> +       }
>>
>> -       regs_dump__printf(mask, regs->regs, arch);
>> +       regs_dump__printf(intr, regs, arch);
>>  }
>>
>>  static void regs_user__printf(struct perf_sample *sample, const char *arch)
>> @@ -952,7 +959,7 @@ static void regs_user__printf(struct perf_sample *sample, const char *arch)
>>         struct regs_dump *user_regs = &sample->user_regs;
>>
>>         if (user_regs->regs)
>> -               regs__printf("user", user_regs, arch);
>> +               regs__printf(false, user_regs, arch);
>>  }
>>
>>  static void regs_intr__printf(struct perf_sample *sample, const char *arch)
>> @@ -960,7 +967,7 @@ static void regs_intr__printf(struct perf_sample *sample, const char *arch)
>>         struct regs_dump *intr_regs = &sample->intr_regs;
>>
>>         if (intr_regs->regs)
>> -               regs__printf("intr", intr_regs, arch);
>> +               regs__printf(true, intr_regs, arch);
>>  }
>>
>>  static void stack_user__printf(struct stack_dump *dump)
>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>> index a58444c4aed1..35c5d58aa45f 100644
>> --- a/tools/perf/util/synthetic-events.c
>> +++ b/tools/perf/util/synthetic-events.c
>> @@ -1538,7 +1538,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>>         if (type & PERF_SAMPLE_REGS_INTR) {
>>                 if (sample->intr_regs.abi) {
>>                         result += sizeof(u64);
>> -                       sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
>> +                       sz = bitmap_weight(sample->intr_regs.mask_ext,
>> +                                          PERF_NUM_INTR_REGS * 64) *
>> +                            sizeof(u64);
>>                         result += sz;
>>                 } else {
>>                         result += sizeof(u64);
>> @@ -1741,7 +1743,8 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
>>         if (type & PERF_SAMPLE_REGS_INTR) {
>>                 if (sample->intr_regs.abi) {
>>                         *array++ = sample->intr_regs.abi;
>> -                       sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
>> +                       sz = bitmap_weight(sample->intr_regs.mask_ext,
>> +                                          PERF_NUM_INTR_REGS * 64) * sizeof(u64);
>>                         memcpy(array, sample->intr_regs.regs, sz);
>>                         array = (void *)array + sz;
>>                 } else {
>> --
>> 2.40.1
>>
> 

