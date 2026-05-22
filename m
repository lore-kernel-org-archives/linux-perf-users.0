Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE7395ACF
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435312; cv=none; b=Xe6ib31oGH5qMEPZ1Obap2FmENGmx1Gi2TRhgeiuAFukMfpk+tTvxwfYd3vo4sNtVWIl4aZZrAmeLVFsq21n696G0+l14fXwbw5liBFQWFdYwnEZyN5eIxA3kxuTpPma/ZJQb+TfYGUq3mvfkRLf6LcLqxgbNUJiwlLa5qzaxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435312; c=relaxed/simple;
	bh=SIHXBgHHeroaBK52GtTBjWdx8OwPcxAb6VpMS7m+F4s=;
	h=Date:From:Message-Id:To:References:Subject:Mime-Version:
	 In-Reply-To:Content-Type:Cc; b=dxibmx1d/xieUZQS6eA44O66//M05s+suZ6feVQP9YEV604L7emUmM1yHLXlbmDDkfxAKXDgleNhvTFiiQfl1H5htP5cOaWC4mPoqVxZ6Attv5y6j1ZJHGI6FYVq4dVK2iC9EFdqvbS9wMCvhFHQ0DdEJwYt9GTm8cqatcj9X5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I4TX4AUI; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I4TX4AUI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779435301; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=BNC4+o1bcI6naEaif0TT6Pjmo0ef3YJGd+e8D4TRBKs=;
 b=I4TX4AUIwZ92slLXoIUNms6K0+yvo3T/z4D3nIE4e7wVtgf71pjb2Kek6rMvLpVhRWq1zF
 Uo0r726xyGgiO2CTvgXXbb9BSCJ/sOWJjoTwacFvqqoFZt80sLz1W2v6sgJEABB8nkMHkN
 jlUZzHRlpyBUbARBgoyA4LEifR3ceFTDMTjyx+1lX4J2YiQUMne3BCzRRvrzo11rGpMsGy
 eYGwjvlWQzk0WzEhVAUhw/iQbvYZKoBPxQw5J0rkuoyeU2IsTYxXWZg25Z3EWgZxJH+09O
 6/Ftu/z1rJFMdg8zpb0UBH4/CAwQlkMZnisQx9K2R/P7ZElb5e3JZV6MhMqzRQ==
Date: Fri, 22 May 2026 15:34:40 +0800
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a100723+897073+vger.kernel.org+qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <e44b58a5-a8bf-4421-a0a3-b879ead5b62b@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
To: "Ian Rogers" <irogers@google.com>
References: <20260506073820.2419087-1-qirui.001@bytedance.com> <20260507071103.2772577-1-qirui.001@bytedance.com> <CAP-5=fVsEVn6AkMEuL8oGW-1uqKL-8TtjgF0_aniwjVCxymv4g@mail.gmail.com>
Subject: Re: [PATCH v3] perf: Add is_mapping_symbol() helper for kernel mapping symbol filtering
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <CAP-5=fVsEVn6AkMEuL8oGW-1uqKL-8TtjgF0_aniwjVCxymv4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Peter Zijlstra" <peterz@infradead.org>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>, 
	"Mark Rutland" <mark.rutland@arm.com>, 
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, 
	"Adrian Hunter" <adrian.hunter@intel.com>, 
	"James Clark" <james.clark@linaro.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>

On 5/7/26 11:23 PM, Ian Rogers wrote:
> On Thu, May 7, 2026 at 12:11=E2=80=AFAM Rui Qi <qirui.001@bytedance.com> =
wrote:
>>
>> The perf tool currently has ad-hoc logic to filter out ELF mapping
>> symbols scattered across multiple files. ARM, AArch64 and RISC-V each
>> have their own inline checks in dso__load_sym_internal(), and kallsym
>> processing has yet another check for ARM module symbols.
>>
>> This is fragile: adding support for a new architecture or adjusting
>> which prefixes are considered mapping symbols requires touching
>> multiple places, and it is easy for the checks to diverge. It also
>> does not match the kernel's own is_mapping_symbol() logic, which
>> additionally covers x86 local symbols (".L*" and "L0*").
>>
>> Introduce a single is_mapping_symbol() inline helper in symbol.h and
>> convert all kernel symbol handling to use it. The helper covers the
>> existing "$" prefix used by ARM, AArch64 and RISC-V, and also adds
>> the x86 local symbol prefixes so that perf stays consistent with
>> the kernel.
>>
>> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
>> ---
>> Changes in v3:
>>   - Add is_mapping_symbol() check for kernel modules in dso__load_sym_in=
ternal()
>>   - Add is_mapping_symbol() check in machine__process_ksymbol_unregister=
()
>>
>> Link (v2): https://lore.kernel.org/all/20260506073820.2419087-1-qirui.00=
1@bytedance.com/
>>
>> Changes in v2:
>>   - Only apply is_mapping_symbol() filtering to kernel symbols (kallsyms
>>     and ksymbol events), not to user-space symbols from ELF files,
>>     BFD libraries, or perf map files.  This avoids incorrectly
>>     discarding valid user-space function names that start with '$',
>>     which is a legal character in identifiers for many languages
>>     (e.g., Java, Scala) and compilers (GCC).
>>   - Move the mapping symbol check in machine__process_ksymbol_register()
>>     to the beginning of the function, before any map/dso allocation
>>     or insertion, to avoid leaving empty maps in the kernel map tree.
>>
>> Link (v1): https://lore.kernel.org/all/20260504090609.1801880-1-qirui.00=
1@bytedance.com/
>> ---
>>  tools/perf/util/machine.c    | 12 +++++++++++-
>>  tools/perf/util/symbol-elf.c |  8 ++++++++
>>  tools/perf/util/symbol.c     |  4 ++--
>>  tools/perf/util/symbol.h     | 15 +++++++++++++++
>>  4 files changed, 36 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index e76f8c86e62a..4e33ba06111d 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -729,9 +729,15 @@ static int machine__process_ksymbol_register(struct=
 machine *machine,
>>  {
>>         struct symbol *sym;
>>         struct dso *dso =3D NULL;
>> -       struct map *map =3D maps__find(machine__kernel_maps(machine), ev=
ent->ksymbol.addr);
>> +       struct map *map;
>>         int err =3D 0;
>>
>> +       /* Ignore mapping symbols in ksymbol events - check early before=
 any state mutation */
>> +       if (is_mapping_symbol(event->ksymbol.name))
>> +               return 0;
>> +
>> +       map =3D maps__find(machine__kernel_maps(machine), event->ksymbol=
.addr);
>> +
>>         if (!map) {
>>                 dso =3D dso__new(event->ksymbol.name);
>>
>> @@ -790,6 +796,10 @@ static int machine__process_ksymbol_unregister(stru=
ct machine *machine,
>>         struct symbol *sym;
>>         struct map *map;
>>
>> +       /* Ignore mapping symbols in ksymbol events */
>> +       if (is_mapping_symbol(event->ksymbol.name))
>> +               return 0;
>> +
>>         map =3D maps__find(machine__kernel_maps(machine), event->ksymbol=
.addr);
>>         if (!map)
>>                 return 0;
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index 7afa8a117139..6b12508ea58d 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -1607,6 +1607,14 @@ dso__load_sym_internal(struct dso *dso, struct ma=
p *map, struct symsrc *syms_ss,
>>                                 continue;
>>                 }
>>
>> +               /*
>> +                * For kernel modules, also reject x86 local symbols (.L=
* and L0*)
>> +                * to match the kernel's is_mapping_symbol() logic and k=
allsyms
>> +                * parsing behavior.
>> +                */
>> +               if (kmodule && is_mapping_symbol(elf_name))
>> +                       continue;
>> +
>>                 if (runtime_ss->opdsec && sym.st_shndx =3D=3D runtime_ss=
->opdidx) {
>>                         u32 offset =3D sym.st_value - syms_ss->opdshdr.s=
h_addr;
>>                         u64 *opd =3D opddata->d_buf + offset;
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index fcaeeddbbb6b..af03b16c17c6 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -770,8 +770,8 @@ static int map__process_kallsym_symbol(void *arg, co=
nst char *name,
>>         if (!symbol_type__filter(type))
>>                 return 0;
>>
>> -       /* Ignore local symbols for ARM modules */
>> -       if (name[0] =3D=3D '$')
>> +       /* Ignore mapping symbols in kallsyms */
>> +       if (is_mapping_symbol(name))
>>                 return 0;
>>
>>         /*
>> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
>> index bd6eb90c8668..27fa1b43e6f1 100644
>> --- a/tools/perf/util/symbol.h
>> +++ b/tools/perf/util/symbol.h
>> @@ -28,6 +28,21 @@ struct maps;
>>  struct option;
>>  struct build_id;
>>
>> +/*
>> + * Ignore kernel mapping symbols, matching kernel is_mapping_symbol() l=
ogic.
>> + * This checks for '$' prefix (used by ARM, AArch64, RISC-V) and
>> + * x86 local symbol prefixes (.L* and L0*).
>> + * Only use this for kernel symbols (kallsyms, ksymbol events).
>> + */
>> +static inline bool is_mapping_symbol(const char *str)
>=20
> Is there a good reference for what is meant by "mapping symbol" ?
> Would "local symbol" be more appropriate for x86? On ARM it seems the
> term is well defined:
> https://developer.arm.com/documentation/dui0803/a/Accessing-and-managing-=
symbols-with-armlink/About-mapping-symbols

Good point. The term "mapping symbol" is indeed well-defined for ARM [1]
and RISC-V [2] =E2=80=94 both psabi specifications use "$" prefix symbols t=
o
mark boundaries between code and data regions, and both explicitly call
them "mapping symbols".

However, the ".L*" and "L0*" patterns on x86 are local labels, not
mapping symbols in the same sense. Grouping them under "mapping symbol"
is imprecise.

That said, this naming comes from the existing is_mapping_symbol() in
include/linux/module_symbol.h, which predates this patch. I just
mirrored the kernel-side function into tools/ with an expanded comment.
The terminology question applies to the kernel-side function as well.

I think the comment in my patch should at least not conflate the two.
How about something like:

  /*
   * Ignore symbols that should be skipped in kallsyms output.
   * Matches kernel is_mapping_symbol() logic in module_symbol.h.
   *
   * '$' prefix: ARM/RISC-V mapping symbols ($a, $t, $d, $x, etc.)
   *   See ARM ABI [1] and RISC-V psabi [2].
   * '.L*' and 'L0*': x86 local labels (not mapping symbols per se,
   *   but filtered the same way by the kernel).
   */

A separate cleanup to rename is_mapping_symbol() to something more
accurate (e.g. is_ignorable_symbol()) across the kernel could be done
later, but that's outside the scope of this bugfix.

[1]
https://developer.arm.com/documentation/dui0803/a/Accessing-and-managing-sy=
mbols-with-armlink/About-mapping-symbols
[2]
https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-elf.=
adoc#mapping-symbol


> I'm wondering if we can make this more intention-revealing. I'm
> wondering also if we should make the check dependent on the e_machine,
> so perhaps:
> ```
> static inline is_ignored_kernel_symbol(const char *name, uint16_t e_machi=
ne)
> {
>   if (e_machine =3D=3D EM_386 || e_machine =3D=3D EM_X86_64) {
>     /* Local symbols on x86 may start .L or L0. */
>    return(str[0] =3D=3D '.' && str[1] =3D=3D 'L')  || (str[0] =3D=3D 'L' =
&& str[1] =3D=3D '0';
>   }
>   /* All other machine types. Assume symbols starting $ are mapping
> symbols used to denote transitions between different sections of data
> and code. */
>   return str[0] =3D=3D '$';
> }
> ```
> I think you can use something like `dso__e_machine` at all call sites
> to get the ELF machine type for the binary or kernel, but maybe this
> is overkill.
>=20
> Thanks,
> Ian
>=20

Yes, it's overkill.

The current unconditional checks don't produce false positives across
architectures:

Checking .L / L0 on ARM: ARM assemblers never generate these symbols, so
the check never matches -- it's a no-op.
Checking $ on x86: x86 ELF symbols essentially never start with $, same
story.
The function is functionally correct as-is. Checking for a pattern that
doesn't exist in a given architecture is harmless.

The cost of introducing e_machine is real:

API break: every callsite (kernel/module/kallsyms.c,
scripts/mod/modpost.h) must now pass in architecture info.
e_machine retrieval is non-trivial: the kernel side and modpost side get
ELF headers through different paths, each needing separate adaptation.
Test matrix explosion: one codepath serving all architectures becomes
per-architecture branches, each needing independent verification.
The one thing worth fixing is the function name. is_mapping_symbol
is genuinely misleading -- .L/L0 are local labels, not mapping
symbols. But fixing the name doesn't require an e_machine parameter.
A simple rename to is_ignored_symbol would do.

>> +{
>> +       if (str[0] =3D=3D '.' && str[1] =3D=3D 'L')
>> +               return true;
>> +       if (str[0] =3D=3D 'L' && str[1] =3D=3D '0')
>> +               return true;
>> +       return str[0] =3D=3D '$';
>> +}
>> +
>>  /*
>>   * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
>>   * for newer versions we can use mmap to reduce memory usage:
>> --
>> 2.20.1
