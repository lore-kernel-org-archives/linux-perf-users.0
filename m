Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804E32B990;
	Tue, 10 Feb 2026 05:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770701741; cv=none; b=KbM2ispZpzDZwc9LgztmynBcFNjlvnSaxlRjx8NHiO3EX08CwmFwTVIIif2yZLVCkizupF4YsuH9uuMqecwDh9QprBK9rvfrEME1aRA1xU7UQdUMl2UY5fvISJ32XYeoMW8sj5jNBwny84266MVaHYIt7dwFUidDQ69/UrD6nI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770701741; c=relaxed/simple;
	bh=4p3aSTcJ4dkmZR8g34s0yrlHoTY3Vpck8u/G2FY+IPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3kExJ2zVLVaha7k3pxtDfISRZbF0UZv5OmzzsSU2oXGqobd4PcqbT0XDlzxdUpjPQxDq8HmcWwkLAF3wn5b6imNzo+8+nmRPVkVqzYLXb6zi65xAMmdHhUXjhUQC8SAcBtXxHCu0hEEtG77cddceaaeWQ2X0PSNLjgSYJtPmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnbSwWhK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnbSwWhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770701739; x=1802237739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4p3aSTcJ4dkmZR8g34s0yrlHoTY3Vpck8u/G2FY+IPk=;
  b=CnbSwWhKem7DBOlmoN0xSwPUpD4//cf81SkcQvQmeb8KVHbm4WKtzZPJ
   nUg3lnxF8uYLvmas5dXrtUUxFD6jj2RjyrchqiVzuxi+BKRZH/2oDUKYI
   bFwgzQJQGb3AP1yMy1ebJ6Qj1QXxdQGZXoJW1Z5qo5PAHT1kysY7wbwpo
   ++c7qbEqHaLH/3kQneJdn0xv95LbceSVz4W7bqYMvr2qq/TsETCaJlH9A
   nbwKEmQmxkiXnQq+loneaV2dnKTyyvhsng+mG+VTQvIhqUXrVRiogCx+o
   XjYnuv2IO8PWXy7X3PaJ1TNISnrdZ3QBa3d6ajQFh2+GZNyJq4URsVYHF
   w==;
X-CSE-ConnectionGUID: dUm+QCuPRtSvFvKTExJkvg==
X-CSE-MsgGUID: bPGV8Aa8QqqzOUBPtxa4cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="82552018"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="82552018"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 21:35:39 -0800
X-CSE-ConnectionGUID: s9EoHimySSykhF8dAAxpFA==
X-CSE-MsgGUID: Ytg1355rTn+72u5g+kELQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211841313"
Received: from qianm-mobl2.ccr.corp.intel.com (HELO [10.238.1.184]) ([10.238.1.184])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 21:35:35 -0800
Message-ID: <5583dc24-714f-4005-bd01-3e98cc66bca0@linux.intel.com>
Date: Tue, 10 Feb 2026 13:35:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 2/4] perf regs: Support x86 eGPRs/SSP sampling
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com>
 <20260209083514.2225115-3-dapeng1.mi@linux.intel.com>
 <CAP-5=fV+NzS0-dd3a5aaKWCbPQfu2h0isvCWc_R65QgV=9mKOw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fV+NzS0-dd3a5aaKWCbPQfu2h0isvCWc_R65QgV=9mKOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/10/2026 6:36 AM, Ian Rogers wrote:
> On Mon, Feb 9, 2026 at 12:39 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> This patch adds support for sampling x86 extended GP registers (R16-R31)
>> and the shadow stack pointer (SSP) register.
>>
>> The original XMM registers space in sample_regs_user/sample_regs_intr is
>> reclaimed to represent the eGPRs and SSP when SIMD registers sampling is
>> supported with the new SIMD sampling fields in the perf_event_attr
>> structure. This necessitates a way to distinguish which register layout
>> is used for the sample_regs_user/sample_regs_intr bitmap.
>>
>> To address this, a new "abi" argument is added to the helpers
>> perf_intr_reg_mask(), perf_user_reg_mask(), and perf_reg_name(). When
>> "abi & PERF_SAMPLE_REGS_ABI_SIMD" is true, it indicates the eGPRs and SSP
>> layout is represented; otherwise, the legacy XMM registers are
>> represented.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/builtin-script.c                   |   2 +-
>>  tools/perf/util/evsel.c                       |   6 +-
>>  tools/perf/util/parse-regs-options.c          |  17 ++-
>>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 120 +++++++++++++++---
>>  tools/perf/util/perf_regs.c                   |  14 +-
>>  tools/perf/util/perf_regs.h                   |  10 +-
>>  .../scripting-engines/trace-event-python.c    |   2 +-
>>  tools/perf/util/session.c                     |   9 +-
>>  8 files changed, 139 insertions(+), 41 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 14c6f6c3c4f2..ffe51f895666 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -730,7 +730,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
>>         for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>>                 u64 val = regs->regs[i++];
>>                 printed += fprintf(fp, "%5s:0x%"PRIx64" ",
>> -                                  perf_reg_name(r, e_machine, e_flags),
>> +                                  perf_reg_name(r, e_machine, e_flags, regs->abi),
> It is tempting for clarity to add the ABI to perf_reg_name as the first patch.
>
>>                                    val);
>>         }
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index f59228c1a39e..b7fb3f936ae3 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1049,19 +1049,21 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>>         }
>>
>>         if (param->record_mode == CALLCHAIN_DWARF) {
>> +               int abi;
>> +
>>                 if (!function) {
>>                         uint16_t e_machine = evsel__e_machine(evsel, /*e_flags=*/NULL);
>>
>>                         evsel__set_sample_bit(evsel, REGS_USER);
>>                         evsel__set_sample_bit(evsel, STACK_USER);
>>                         if (opts->sample_user_regs &&
>> -                           DWARF_MINIMAL_REGS(e_machine) != perf_user_reg_mask(EM_HOST)) {
>> +                           DWARF_MINIMAL_REGS(e_machine) != perf_user_reg_mask(EM_HOST, &abi)) {
>>                                 attr->sample_regs_user |= DWARF_MINIMAL_REGS(e_machine);
>>                                 pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
>>                                            "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
>>                                            "so the minimal registers set (IP, SP) is explicitly forced.\n");
>>                         } else {
>> -                               attr->sample_regs_user |= perf_user_reg_mask(EM_HOST);
>> +                               attr->sample_regs_user |= perf_user_reg_mask(EM_HOST, &abi);
>>                         }
>>                         attr->sample_stack_user = param->dump_size;
>>                         attr->exclude_callchain_user = 1;
>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>> index c93c2f0c8105..518327883b18 100644
>> --- a/tools/perf/util/parse-regs-options.c
>> +++ b/tools/perf/util/parse-regs-options.c
>> @@ -10,7 +10,8 @@
>>  #include "util/perf_regs.h"
>>  #include "util/parse-regs-options.h"
>>
>> -static void list_perf_regs(FILE *fp, uint64_t mask)
>> +static void
>> +list_perf_regs(FILE *fp, uint64_t mask, int abi)
>>  {
>>         const char *last_name = NULL;
>>
>> @@ -21,7 +22,7 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
>>                 if (((1ULL << reg) & mask) == 0)
>>                         continue;
>>
>> -               name = perf_reg_name(reg, EM_HOST, EF_HOST);
>> +               name = perf_reg_name(reg, EM_HOST, EF_HOST, abi);
>>                 if (name && (!last_name || strcmp(last_name, name)))
>>                         fprintf(fp, "%s%s", reg > 0 ? " " : "", name);
>>                 last_name = name;
>> @@ -29,7 +30,8 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
>>         fputc('\n', fp);
>>  }
>>
>> -static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mask)
>> +static uint64_t
>> +name_to_perf_reg_mask(const char *to_match, uint64_t mask, int abi)
>>  {
>>         uint64_t reg_mask = 0;
>>
>> @@ -39,7 +41,7 @@ static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mask)
>>                 if (((1ULL << reg) & mask) == 0)
>>                         continue;
>>
>> -               name = perf_reg_name(reg, EM_HOST, EF_HOST);
>> +               name = perf_reg_name(reg, EM_HOST, EF_HOST, abi);
>>                 if (!name)
>>                         continue;
>>
>> @@ -56,6 +58,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>         char *s, *os = NULL, *p;
>>         int ret = -1;
>>         uint64_t mask;
>> +       int abi;
>>
>>         if (unset)
>>                 return 0;
>> @@ -66,7 +69,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>         if (*mode)
>>                 return -1;
>>
>> -       mask = intr ? perf_intr_reg_mask(EM_HOST) : perf_user_reg_mask(EM_HOST);
>> +       mask = intr ? perf_intr_reg_mask(EM_HOST, &abi) : perf_user_reg_mask(EM_HOST, &abi);
>>
>>         /* str may be NULL in case no arg is passed to -I */
>>         if (!str) {
>> @@ -87,11 +90,11 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>>                         *p = '\0';
>>
>>                 if (!strcmp(s, "?")) {
>> -                       list_perf_regs(stderr, mask);
>> +                       list_perf_regs(stderr, mask, abi);
>>                         goto error;
>>                 }
>>
>> -               reg_mask = name_to_perf_reg_mask(s, mask);
>> +               reg_mask = name_to_perf_reg_mask(s, mask, abi);
>>                 if (reg_mask == 0) {
>>                         ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
>>                                 s, intr ? "-I" : "--user-regs=");
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> index b6d20522b4e8..3e9241a11a95 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> @@ -235,26 +235,26 @@ int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op)
>>         return SDT_ARG_VALID;
>>  }
>>
>> -uint64_t __perf_reg_mask_x86(bool intr)
>> +static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, bool has_simd_regs)
>>  {
>>         struct perf_event_attr attr = {
>> -               .type                   = PERF_TYPE_HARDWARE,
>> -               .config                 = PERF_COUNT_HW_CPU_CYCLES,
>> -               .sample_type            = PERF_SAMPLE_REGS_INTR,
>> -               .sample_regs_intr       = PERF_REG_EXTENDED_MASK,
>> -               .precise_ip             = 1,
>> -               .disabled               = 1,
>> -               .exclude_kernel         = 1,
>> +               .type                           = PERF_TYPE_HARDWARE,
>> +               .config                         = PERF_COUNT_HW_CPU_CYCLES,
>> +               .sample_type                    = sample_type,
>> +               .precise_ip                     = 1,
>> +               .disabled                       = 1,
>> +               .exclude_kernel                 = 1,
>> +               .sample_simd_regs_enabled       = has_simd_regs,
>>         };
>>         int fd;
>> -
>> -       if (!intr)
>> -               return PERF_REGS_MASK;
>> -
>>         /*
>>          * In an unnamed union, init it here to build on older gcc versions
>>          */
>>         attr.sample_period = 1;
>> +       if (sample_type == PERF_SAMPLE_REGS_INTR)
>> +               attr.sample_regs_intr = mask;
>> +       else
>> +               attr.sample_regs_user = mask;
>>
>>         if (perf_pmus__num_core_pmus() > 1) {
>>                 struct perf_pmu *pmu = NULL;
>> @@ -276,13 +276,34 @@ uint64_t __perf_reg_mask_x86(bool intr)
>>                                  /*group_fd=*/-1, /*flags=*/0);
>>         if (fd != -1) {
>>                 close(fd);
>> -               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
>> +               return mask;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +uint64_t __perf_reg_mask_x86(bool intr, int *abi)
>> +{
>> +       u64 sample_type = intr ? PERF_SAMPLE_REGS_INTR : PERF_SAMPLE_REGS_USER;
>> +       uint64_t mask = PERF_REGS_MASK;
>> +
>> +       *abi = 0;
>> +       mask |= __arch__reg_mask(sample_type,
>> +                                GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16),
>> +                                true);
>> +       mask |= __arch__reg_mask(sample_type, BIT_ULL(PERF_REG_X86_SSP), true);
>> +
>> +       if (mask != PERF_REGS_MASK) {
>> +               *abi |= PERF_SAMPLE_REGS_ABI_SIMD;
>> +       } else {
>> +               mask |= __arch__reg_mask(sample_type, PERF_REG_EXTENDED_MASK,
>> +                                        false);
>>         }
>>
>> -       return PERF_REGS_MASK;
>> +       return mask;
>>  }
>>
>> -const char *__perf_reg_name_x86(int id)
>> +static const char *__arch_reg_gpr_name(int id)
>>  {
>>         switch (id) {
>>         case PERF_REG_X86_AX:
>> @@ -333,7 +354,60 @@ const char *__perf_reg_name_x86(int id)
>>                 return "R14";
>>         case PERF_REG_X86_R15:
>>                 return "R15";
>> +       default:
>> +               return NULL;
>> +       }
>> +
>> +       return NULL;
>> +}
>>
>> +static const char *__arch_reg_egpr_name(int id)
>> +{
>> +       switch (id) {
>> +       case PERF_REG_X86_R16:
>> +               return "R16";
>> +       case PERF_REG_X86_R17:
>> +               return "R17";
>> +       case PERF_REG_X86_R18:
>> +               return "R18";
>> +       case PERF_REG_X86_R19:
>> +               return "R19";
>> +       case PERF_REG_X86_R20:
>> +               return "R20";
>> +       case PERF_REG_X86_R21:
>> +               return "R21";
>> +       case PERF_REG_X86_R22:
>> +               return "R22";
>> +       case PERF_REG_X86_R23:
>> +               return "R23";
>> +       case PERF_REG_X86_R24:
>> +               return "R24";
>> +       case PERF_REG_X86_R25:
>> +               return "R25";
>> +       case PERF_REG_X86_R26:
>> +               return "R26";
>> +       case PERF_REG_X86_R27:
>> +               return "R27";
>> +       case PERF_REG_X86_R28:
>> +               return "R28";
>> +       case PERF_REG_X86_R29:
>> +               return "R29";
>> +       case PERF_REG_X86_R30:
>> +               return "R30";
>> +       case PERF_REG_X86_R31:
>> +               return "R31";
>> +       case PERF_REG_X86_SSP:
>> +               return "SSP";
>> +       default:
>> +               return NULL;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static const char *__arch_reg_xmm_name(int id)
>> +{
>> +       switch (id) {
>>  #define XMM(x) \
>>         case PERF_REG_X86_XMM ## x:     \
>>         case PERF_REG_X86_XMM ## x + 1: \
>> @@ -362,6 +436,22 @@ const char *__perf_reg_name_x86(int id)
>>         return NULL;
>>  }
>>
>> +const char *__perf_reg_name_x86(int id, int abi)
>> +{
>> +       const char *name;
>> +
>> +       name = __arch_reg_gpr_name(id);
>> +       if (name)
>> +               return name;
>> +
>> +       if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +               name = __arch_reg_egpr_name(id);
>> +       else
>> +               name = __arch_reg_xmm_name(id);
>> +
>> +       return name;
>> +}
>> +
>>  uint64_t __perf_reg_ip_x86(void)
>>  {
>>         return PERF_REG_X86_IP;
>> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
>> index 5b8f34beb24e..bdd2eef13bc3 100644
>> --- a/tools/perf/util/perf_regs.c
>> +++ b/tools/perf/util/perf_regs.c
>> @@ -32,10 +32,11 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op)
>>         return ret;
>>  }
>>
>> -uint64_t perf_intr_reg_mask(uint16_t e_machine)
>> +uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi)
> I wonder if abi is the right out argument name here. Before the SIMD
> change the ABI meant either 32 or 64-bit. So we could imagine if it
> were 32-bit then registers R8 to R15 wouldn't be in the mask for x86.
> Perhaps just a "bool *" for sample_simd_regs_enabled.

Hmm, I ever concerned to add a "bool *simd_enabled" argument as well, but
it looks a little bit weird and abrupt since other architectures may never
need to use this argument. Instead, "abi" is neutral argument and it may be
needed by other architectures in the future.


>
> Everything else looks good. Thanks for the weak function clean up,
> this code is much more generic and better than before. I know it
> wasn't trivial to do, but I appreciate it!

Thanks a lot for your meticulous reviewing as well. :)


>
> Thanks,
> Ian
>
>>  {
>>         uint64_t mask = 0;
>>
>> +       *abi = 0;
>>         switch (e_machine) {
>>         case EM_ARM:
>>                 mask = __perf_reg_mask_arm(/*intr=*/true);
>> @@ -64,7 +65,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
>>                 break;
>>         case EM_386:
>>         case EM_X86_64:
>> -               mask = __perf_reg_mask_x86(/*intr=*/true);
>> +               mask = __perf_reg_mask_x86(/*intr=*/true, abi);
>>                 break;
>>         default:
>>                 pr_debug("Unknown ELF machine %d, interrupt sampling register mask will be empty.\n",
>> @@ -75,10 +76,11 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
>>         return mask;
>>  }
>>
>> -uint64_t perf_user_reg_mask(uint16_t e_machine)
>> +uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi)
>>  {
>>         uint64_t mask = 0;
>>
>> +       *abi = 0;
>>         switch (e_machine) {
>>         case EM_ARM:
>>                 mask = __perf_reg_mask_arm(/*intr=*/false);
>> @@ -107,7 +109,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
>>                 break;
>>         case EM_386:
>>         case EM_X86_64:
>> -               mask = __perf_reg_mask_x86(/*intr=*/false);
>> +               mask = __perf_reg_mask_x86(/*intr=*/false, abi);
>>                 break;
>>         default:
>>                 pr_debug("Unknown ELF machine %d, user sampling register mask will be empty.\n",
>> @@ -118,7 +120,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
>>         return mask;
>>  }
>>
>> -const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
>> +const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, int abi)
>>  {
>>         const char *reg_name = NULL;
>>
>> @@ -150,7 +152,7 @@ const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
>>                 break;
>>         case EM_386:
>>         case EM_X86_64:
>> -               reg_name = __perf_reg_name_x86(id);
>> +               reg_name = __perf_reg_name_x86(id, abi);
>>                 break;
>>         default:
>>                 break;
>> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
>> index 7c04700bf837..c9501ca8045d 100644
>> --- a/tools/perf/util/perf_regs.h
>> +++ b/tools/perf/util/perf_regs.h
>> @@ -13,10 +13,10 @@ enum {
>>  };
>>
>>  int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op);
>> -uint64_t perf_intr_reg_mask(uint16_t e_machine);
>> -uint64_t perf_user_reg_mask(uint16_t e_machine);
>> +uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi);
>> +uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi);
>>
>> -const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags);
>> +const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, int abi);
>>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>>  uint64_t perf_arch_reg_ip(uint16_t e_machine);
>>  uint64_t perf_arch_reg_sp(uint16_t e_machine);
>> @@ -64,8 +64,8 @@ uint64_t __perf_reg_ip_s390(void);
>>  uint64_t __perf_reg_sp_s390(void);
>>
>>  int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
>> -uint64_t __perf_reg_mask_x86(bool intr);
>> -const char *__perf_reg_name_x86(int id);
>> +uint64_t __perf_reg_mask_x86(bool intr, int *abi);
>> +const char *__perf_reg_name_x86(int id, int abi);
>>  uint64_t __perf_reg_ip_x86(void);
>>  uint64_t __perf_reg_sp_x86(void);
>>
>> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
>> index 2b0df7bd9a46..4cc5b96898e6 100644
>> --- a/tools/perf/util/scripting-engines/trace-event-python.c
>> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
>> @@ -733,7 +733,7 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
>>
>>                 printed += scnprintf(bf + printed, size - printed,
>>                                      "%5s:0x%" PRIx64 " ",
>> -                                    perf_reg_name(r, e_machine, e_flags), val);
>> +                                    perf_reg_name(r, e_machine, e_flags, regs->abi), val);
>>         }
>>  }
>>
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 4b465abfa36c..7cf7bf86205d 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -959,15 +959,16 @@ static void branch_stack__printf(struct perf_sample *sample,
>>         }
>>  }
>>
>> -static void regs_dump__printf(u64 mask, u64 *regs, uint16_t e_machine, uint32_t e_flags)
>> +static void regs_dump__printf(u64 mask, struct regs_dump *regs,
>> +                             uint16_t e_machine, uint32_t e_flags)
>>  {
>>         unsigned rid, i = 0;
>>
>>         for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
>> -               u64 val = regs[i++];
>> +               u64 val = regs->regs[i++];
>>
>>                 printf(".... %-5s 0x%016" PRIx64 "\n",
>> -                      perf_reg_name(rid, e_machine, e_flags), val);
>> +                      perf_reg_name(rid, e_machine, e_flags, regs->abi), val);
>>         }
>>  }
>>
>> @@ -995,7 +996,7 @@ static void regs__printf(const char *type, struct regs_dump *regs,
>>                mask,
>>                regs_dump_abi(regs));
>>
>> -       regs_dump__printf(mask, regs->regs, e_machine, e_flags);
>> +       regs_dump__printf(mask, regs, e_machine, e_flags);
>>  }
>>
>>  static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
>> --
>> 2.34.1
>>
