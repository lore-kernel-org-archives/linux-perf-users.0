Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78AC1C3BEB;
	Wed, 25 Mar 2026 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774404516; cv=none; b=efXD1EwI5wCo93DdeL1PEbhaIjMqTxqUPoK5BrrGEpG8tpYTFbFoER7UszIQHp+fdDR2kxVsov2m+wP40qAEPPcoIgS8Tt08Ek5qWXgwxf/NkIWtPDhSzSCg9lTESsMiM+U1BQ8R2upgUWVBnSkpjXxuJKq8jVmV8loWN35Nres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774404516; c=relaxed/simple;
	bh=4EUYecgYLPVHZBjjYvILHhVUwDz4ef1gdCG3iBcHuMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOwoD2cDllLZlV4MSqNeqG5JkELQ3JpullrFvu7CT0IqIgUqKTzmzlfVBm/CTzCnyfaUiPuZf+Xb7QGtsm+MX8wZOxLr99UP5HeVRVJha7/U7g5K1xdJvcbFJbrJx7jVwTXbbpW4QD/O5WFpVYoBu+cnUsMeAgG7oURPHXvWHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEEpAMbL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEEpAMbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774404514; x=1805940514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4EUYecgYLPVHZBjjYvILHhVUwDz4ef1gdCG3iBcHuMQ=;
  b=JEEpAMbL3VgjNKVlmYsh05fbr1QVtxT7r4ZaheSJWT+RigCG8J9jGggL
   I8o2on/2q3dSEGqjgxZYcFNn/Av0LX8EKZigIF/9nKI5Z2D5Hu7OULDrg
   WJ9d0GQETIEnJ4Pz2W0y3/fT2phzvt6w+v2OIBKwTdWngw0tlVhrdrGel
   MhmlSNLAjrINHdQou67teOQers5uK80kZvmWa63bK5u0Ss81vl43wcPz1
   x3dMW/VBfOb1uQuHQx/iMs6TBmadtfQDocIVGW44ZGV078bkZnYoxx74r
   q8Htqs35S3lYikUJ4I5DP1oR9H8M4jafSF39gu4RPF9mw85Bf1g49hlDG
   w==;
X-CSE-ConnectionGUID: ZZtydkBnTuOHKTI65FpOyA==
X-CSE-MsgGUID: SN26S+TrQlquZWKif5fdtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="93009909"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="93009909"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 19:08:33 -0700
X-CSE-ConnectionGUID: YbjaG2/+TJS3b8nK6ooEiA==
X-CSE-MsgGUID: u/rdxMQnRPqS+sRZ5jdXNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="220119679"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 19:08:28 -0700
Message-ID: <47eccc41-947b-4a9a-8b55-cc5ddf60fb7e@linux.intel.com>
Date: Wed, 25 Mar 2026 10:08:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 2/4] perf regs: Support x86 eGPRs/SSP sampling
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260324005706.3778057-1-dapeng1.mi@linux.intel.com>
 <20260324005706.3778057-3-dapeng1.mi@linux.intel.com>
 <CAP-5=fX65DzJF+rq0T-58hNZsjYovW60PSBWsmF42kMxPhrv4g@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fX65DzJF+rq0T-58hNZsjYovW60PSBWsmF42kMxPhrv4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/24/2026 10:49 AM, Ian Rogers wrote:
> On Mon, Mar 23, 2026 at 6:01 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
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
>>
>> V7: Limit dwarf minimal regs to legacy GPRs (excluding APX eGPRs).
> So, R16 to R31 won't be set up? This sounds worrying because a
> function, like a leaf function, might use these registers as a frame
> pointer with -fomit-frame-pointer when the code includes uses
> functions like alloca.

No,  perf_user_reg_mask()/perf_intr_reg_mask() would still return R16~R31
mask if they are supported except the input argument "abi" is set to -1.

The reason that only returns the basic GPRs in the case "abi = -1" is to
avoid the these eGPRs are added into sample_user_regs in below code. 

```

if (opts->sample_user_regs &&
                DWARF_MINIMAL_REGS(e_machine) !=
perf_user_reg_mask(EM_HOST, &abi)) {
                attr->sample_regs_user |= DWARF_MINIMAL_REGS(e_machine);
                pr_warning("WARNING: The use of --call-graph=dwarf may
require all the user registers, "
                       "specifying a subset with --user-regs may render
DWARF unwinding unreliable, "
                       "so the minimal registers set (IP, SP) is explicitly
forced.\n");
            } else {
                abi = -1;
                attr->sample_regs_user |= perf_user_reg_mask(EM_HOST, &abi);
            }

```

Users may leverage the "cpu-clock" or "task-clock" to sample the dwarf
call-stack but doesn't explicitly set the sample_regs_user. In this case,
if the returned mask from perf_user_reg_mask() contains the R16-R31 mask,
it would cause the event creation failure since "cpu-clock" or "task-clock"
doesn't support to sample R16-R31 registers yet (This would cause the
addr2line test fails).


>
> So not having vector register support potentially breaks things like
> LLVM's spill2reg, which aims to avoid using the stack and prefers
> vector registers:
> https://discourse.llvm.org/t/rfc-spill2reg-selectively-replace-spills-to-stack-with-spills-to-vector-registers/59630
> I think the dwarf minimal registers need extending to cover SIMD
> registers, specifically those outside the mask, but this isn't
> supported currently. For now, however, it would be useful to at least
> warn when we receive a request (via the dwarf information in a binary)
> for a register that we're choosing not to include in the sample set,
> otherwise they could look like a spurious unwind errors.

Just take some time to investigate the status of libdw supporting APX/SIMD
regs, but I didn't find there is the support for APX/SIMD regs in the
latest libdw (https://sourceware.org/git/elfutils.git). Not sure if I miss
something. If wrong, Please correct me.

So suppose we have to defer the supporting of APX/SIMD regs supporting
until libdw supports it?

Sure. I would add messages to warn APX/SIMD regs are not supported if libdw
tries to request it.


>
>>  tools/perf/builtin-script.c                   |   2 +-
>>  tools/perf/util/evsel.c                       |   7 +-
>>  tools/perf/util/parse-regs-options.c          |  17 ++-
>>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 124 +++++++++++++++---
>>  tools/perf/util/perf_regs.c                   |  12 +-
>>  tools/perf/util/perf_regs.h                   |  10 +-
>>  .../scripting-engines/trace-event-python.c    |   2 +-
>>  tools/perf/util/session.c                     |   9 +-
>>  8 files changed, 142 insertions(+), 41 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index b80c406d1fc1..714528732e02 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -730,7 +730,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
>>         for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>>                 u64 val = regs->regs[i++];
>>                 printed += fprintf(fp, "%5s:0x%"PRIx64" ",
>> -                                  perf_reg_name(r, e_machine, e_flags),
>> +                                  perf_reg_name(r, e_machine, e_flags, regs->abi),
>>                                    val);
>>         }
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 5a294595a677..f565ef2eb476 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1054,19 +1054,22 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
>>         }
>>
>>         if (param->record_mode == CALLCHAIN_DWARF) {
>> +               int abi = -1; /* -1 indicates only basic GPRs are needed. */
> Should the abi come from checking
> evsel->core.attr.sample_simd_regs_enabled and other related values?

Actually no. It's has nothing to do with
evsel->core.attr.sample_simd_regs_enabled or something else. We only want
to get the basic supported GPRs here as previously explained.


>
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
>> +                               abi = -1;
> This assignment is redundant.

It's intended. Since "abi" is a input and output argument. The "abi" could
be overwritten by the above perf_user_reg_mask(), so here set to "-1" again.


>
>> +                               attr->sample_regs_user |= perf_user_reg_mask(EM_HOST, &abi);
>>                         }
>>                         attr->sample_stack_user = param->dump_size;
>>                         attr->exclude_callchain_user = 1;
>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>> index c93c2f0c8105..6cf865bfc2f7 100644
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
>> +       int abi = 0;
> 0 here is PERF_SAMPLE_REGS_ABI_NONE, perhaps we can use the perf_env
> that has kernel_is_64_bit to set the ABI to at least
> PERF_SAMPLE_REGS_ABI_32 or PERF_SAMPLE_REGS_ABI_64. How will the SIMD
> registers outside of the register mask be encoded?

IMO, it's unnecessary to make "abi" as input argument so complicated.
Currently only "-1" has specific meaning for the input argument, all others
would return all supported registers.

What do you mean about "the SIMD registers outside of the register mask"?
The YMM/ZMM/OPMASK registers?

After introducing the new SIMD representation fields, all SIMD registers
would be represented by these SIMD fields.


>
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
>> index b6d20522b4e8..ae26d991cdc9 100644
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
>> @@ -276,13 +276,38 @@ uint64_t __perf_reg_mask_x86(bool intr)
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
>> +       /* -1 indicates only basic GPRs are needed. */
>> +       if (*abi < 0)
>> +               return PERF_REGS_MASK;
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
>> @@ -333,7 +358,60 @@ const char *__perf_reg_name_x86(int id)
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
>> @@ -362,6 +440,22 @@ const char *__perf_reg_name_x86(int id)
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
>> index 5b8f34beb24e..afc567718bee 100644
>> --- a/tools/perf/util/perf_regs.c
>> +++ b/tools/perf/util/perf_regs.c
>> @@ -32,7 +32,7 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op)
>>         return ret;
>>  }
>>
>> -uint64_t perf_intr_reg_mask(uint16_t e_machine)
>> +uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi)
>>  {
>>         uint64_t mask = 0;
>>
>> @@ -64,7 +64,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
>>                 break;
>>         case EM_386:
>>         case EM_X86_64:
>> -               mask = __perf_reg_mask_x86(/*intr=*/true);
>> +               mask = __perf_reg_mask_x86(/*intr=*/true, abi);
>>                 break;
>>         default:
>>                 pr_debug("Unknown ELF machine %d, interrupt sampling register mask will be empty.\n",
>> @@ -75,7 +75,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
>>         return mask;
>>  }
>>
>> -uint64_t perf_user_reg_mask(uint16_t e_machine)
>> +uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi)
>>  {
>>         uint64_t mask = 0;
>>
>> @@ -107,7 +107,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
>>                 break;
>>         case EM_386:
>>         case EM_X86_64:
>> -               mask = __perf_reg_mask_x86(/*intr=*/false);
>> +               mask = __perf_reg_mask_x86(/*intr=*/false, abi);
>>                 break;
>>         default:
>>                 pr_debug("Unknown ELF machine %d, user sampling register mask will be empty.\n",
>> @@ -118,7 +118,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
>>         return mask;
>>  }
>>
>> -const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
>> +const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, int abi)
>>  {
>>         const char *reg_name = NULL;
>>
>> @@ -150,7 +150,7 @@ const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
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
> Can we add an "/*inout*/" comment for the abi argument?

Sure. good idea.


>
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
> In dwarf_regs.h is also:
> int __get_dwarf_regnum_x86_64(const char *name);
> This needs extending for r16 to r31, xmm16-xmm31, etc.

As above mentioned, it seems currently libdw still doesn't support APX/SIMD
regs. It'd better push back the support until libdw supports it. I would
add message in this function to warn and notice APX/SIMD regs are not
supported if libdw requests them.


>
> __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum);
> I think this needs an ABI argument otherwise, how to differentiate r16
> from XMM0?

Yes, would enhance this function. Thanks.


>
> Thanks,
> Ian
>
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
