Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA618472795
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789816929; cv=none; b=slVjd2ZSuEMxCnLSefCQc0nAjL5Oe0lIERgziK6g9/q9OYKJMinR6W91aV/TmAE0yUDAerF6A+YEIIdnER168i+e5Dpf9OMir2g+LmnVl6JU0htNFmJaVrVNe0cRzOPQT1uHHyfC6v5RwHm9ebSR64I/YvCK7IcYhgKM3asIWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789816929; c=relaxed/simple;
	bh=ucpcsslWSw4Rqua/Odyo/0Q/Z/wQbJ3pqDM6ggXQ4x0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BPTWdeEGQWkjhhhhgoJ+GYHHUKzwRaOc7uKnOuSsaCqjsqNaN4h8h7PrG3pIDgCHmyk2nE3UHIxEAbT5HXbzy9dKmUpaPq4WcP5xZoK2ytcW36M3g5YmrHk0HN2DqsaT84tnQmxUrw2O2LRSlU/4GPpJGA6quC+BDI3JWnUpfHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL6LXLKk; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL6LXLKk"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c7bab8eso809438241.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789816927; x=1790421727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QSJeSrhF1tcmW9wo5jI4mV3Y/sRaw5/ZnIpU/nX8+0o=;
        b=lL6LXLKkgOzdb1RSKoI5e0jT6mYqqp6gFhpatxvaToHGDPRhlsDQNN0BdmvIvGNIi+
         VgPtsGO0fLtOFvKS6zYmr52pgfxj4rKQf4Lk2zDyg7x5mIPVreTRuc4D0vvdgUC37vHh
         vLr6rsribm5Ui1mpnjOV2THMLz5F5/iyo+kAb6DnZuR5+AeUX4RwH0mEgjCKy9lTtPdO
         9xx0kwf0+tTQq1bocse705t6RQSmavIfpqIhvoHzVFQNR7gaztw4SvGbvNf3xyL7qXPe
         SPC6DWCz6zYVZH9O64O6QDp5Tj0maWSUSGu7YU6O61+Nn9vldGQF88QBd3Z6ie5VbKQa
         H1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789816927; x=1790421727;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSJeSrhF1tcmW9wo5jI4mV3Y/sRaw5/ZnIpU/nX8+0o=;
        b=T1sx1wLLAeWLUbnBCikNJf2S1iGwzDMBtHlUm3adRaXbBLxw4htxzVszI/JBteAZzy
         S83jvRya61o58p3LgR40Gt2ggG5xXkTNlXL20PKXx6BU9DKrtj8oDIxUEVcJ65OtXmEd
         FrnL2LjfgfdwS9dY9pMPZxX6pXda/J6i0X63SwuKP6IeMXSlAIObQXIrsWNZmU+UzvRi
         Dw+gK6oXEe/OI2OH91ypO2osI+MEU+qCOorfGlb+JZPRXnDR++gqefPnHqdrXq5C2Q8e
         pYfWQnv/dsukusD1w81/EoldnNB0v/vRKuYkckDLANr09EnfCsjHfip8llot6TcKjlZA
         EcZg==
X-Forwarded-Encrypted: i=1; AKwUvBz9lio5Yea9gAq/KvV/1H8YrYrGRiDOty7TGeBnxqIlONQ5Gjyyusv0YOeqpM8Ddn9tZDawqYKe1nX3P00ZJo7M@vger.kernel.org
X-Gm-Message-State: AFuF++lMvK+gri+k3F3BRnr8+1VeXoNGf9Zhx4wY5dY2VTzasemf4xXs
	viEIEhHqlOFU14qFXGwKn8gojcLSI5u6dw7dTtWXLh+2shC6ztIuikKg
X-Gm-Gg: AYBFou16uTzHq7PXbqYAzIY3EbOuGm9sVZuinrjSrOkibWplgTGz9wG9k2/c9DS5XjX
	9DpsYUzexvrJ6JG7oHe9TH13+miIPYiblBeu0ii+pZByKSo6aNHAS759DFG9UmKGSbrlqlP6YWo
	kYbDBffeyITGjFTw7eCW6O5gdGjbbuzrM1wOXLUdpaSnw4hi2MgB2A8S4WcZ9YFpoBju2w5t+ol
	WpbmVGhw5xDI3CFhvQF6QBBgBzkI54xFaOTz1c9/Nks9+cXnuDlLD+6TY3sLKsj7+iiynBSq72j
	PIjGbFduFBgHPS131wHQ/bMMW7/w1vhX7s30VRwqpKsS1j3e/AMF6FqiCg5NTTmr5+35kk7m4jQ
	RPVs5Z1ZL8OgCLUpIT97sU/2YCME4DYpZEoVLZyJubIko10J5Hd/L8MAQXbWSK1XzoQUH82TqPu
	2atHP9ka5xsETOEDCABYVQB5HFB5/GeK7sohLbFhZdJjnpXeMqTwQu/IwFBcrWFzJo8nUhPTQXr
	f5zJ8xh6fCkJ9I=
X-Received: by 2002:a05:6102:6891:b0:7a5:391c:37ac with SMTP id ada2fe7eead31-7a55b439f6amr2911038137.10.1789816926624;
        Sat, 19 Sep 2026 04:22:06 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:ccb6:6ef1:bb98:1fe2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-984d558c062sm2358513241.13.2026.09.19.04.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 04:22:05 -0700 (PDT)
Date: Sat, 19 Sep 2026 08:22:01 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>, Tengda Wu <wutengda@huaweicloud.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
CC: james.clark@linaro.org, xueshuai@linux.alibaba.com,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 00/26] perf arm64: Support data type profiling
User-Agent: Thunderbird for Android
In-Reply-To: <aq41dlDILyJlw-77@z2>
References: <cover.1789521520.git.wutengda@huaweicloud.com> <aq41dlDILyJlw-77@z2>
Message-ID: <EC6E525E-387A-493A-B720-80E6FB38B05B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 19, 2026 4:10:46 AM GMT-03:00, Namhyung Kim <namhyung@kernel=
=2Eorg> wrote:
>Hello,
>
>On Wed, Sep 16, 2026 at 01:29:14AM +0000, Tengda Wu wrote:
>> This patch series implements data type profiling support for arm64,
>> enabling 'perf annotate --data-type' to resolve memory locations and
>> variable types on arm64 platforms=2E
>>=20
>> The main changes since v5 include:
>> v5: https://lore=2Ekernel=2Eorg/all/cover=2E1788872630=2Egit=2Ewutengda=
@huaweicloud=2Ecom/
>>=20
>> * __get_dwarf_regnum_arm64 optimization: compute directly based on char=
acter
>>   judgment, avoiding strtol calls=2E (Ian Rogers)
>>=20
>> * extract_op_location_arm64 issue fix: support parsing instructions suc=
h as
>>   'cmp x0, x1, lsl #3'=2E
>>=20
>> * Instruction tracking part, fixing issues pointed out by Sashiko, incl=
uding:
>>   - adding TSR_KIND_POINTER handling for ldr=2E
>>   - premature returns in add and ldr causing percpu handling to be skip=
ped=2E
>>   - adding a reg !=3D -1 check for stack type propagation, etc=2E
>>=20
>> Patch organization
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> The series is organized as follows:
>>=20
>> 1=2E Fix disassembly mismatches (Patches 01-02)
>>    Current perf annotate supports three disassembly backends: llvm,
>>    capstone, and objdump=2E On arm64, inconsistencies between the outpu=
t
>>    of these backends (specifically llvm/capstone vs=2E objdump) often
>>    prevent the tracker from correctly identifying registers and offsets=
=2E
>>    These patches resolve these mismatches, ensuring consistent instruct=
ion
>>    parsing across all supported backends=2E
>>=20
>> 2=2E Infrastructure for arm64 operand parsing (Patches 03-09)
>>    These patches establish the necessary infrastructure for arm64-speci=
fic
>>    operand handling=2E This includes implementing new callbacks and dat=
a
>>    structures to manage arm64's unique addressing modes and register se=
ts=2E
>>    This foundation is essential for the subsequent type-tracking logic=
=2E
>>=20
>> 3=2E ARM SPE event handling (Patches 10-11)
>>    Patch 10 automatically deduplicates overlapping ARM SPE events (e=2E=
g=2E,
>>    l1d-miss, tlb-access) in 'perf annotate' by retaining only the
>>    "instructions" event when data type profiling is enabled=2E Patch 11
>>    defaults  the synthesized event period to 1 for ARM SPE to fix zero
>>    'Percent' values in annotate output=2E
>
>Thanks for working on this!
>
>I think it's ready to merge up to this point=2E=20

You mean patches 1-11?=20

- Arnaldo

 The instruction tracking
>part needs more review=2E  I'll do that later but it'd be nice if ARM
>folks and Shuai could review it too=2E
>
>Thanks,
>Namhyung
>
>>=20
>> 4=2E Core instruction tracking (Patches 12-26)
>>    These patches implement the core logic for type tracking on arm64,
>>    covering several key types of instructions, including:
>>    * Memory Access: ldr/str variants (including stack-based access)=2E
>>    * Arithmetic & Data Processing: mov, add, and adrp=2E
>>    * Special Access: System register access (mrs) and per-cpu variable
>>      tracking=2E
>>=20
>> The implementation draws inspiration from the existing x86 logic while
>> adapting it to the nuances of the AArch64 ISA [2][3]=2E With these chan=
ges,
>> perf annotate can successfully resolve memory locations and register ty=
pes,
>> providing basic support for data type profiling on arm64 platforms=2E
>>=20
>> Example Result
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> # perf mem record -a -K -- sleep 1
>> # perf annotate --data-type --stdio --type-stat
>> Annotate data type stats:
>> total 1138, ok 852 (74=2E9%), bad 286 (25=2E1%)
>> -----------------------------------------------------------
>>          6 : no_sym
>>         42 : no_var
>>        230 : no_typeinfo
>>          8 : bad_offset
>>        213 : insn_track
>>=20
>> Annotate type: 'struct page' in [kernel=2Ekallsyms] (66948 samples):
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>  Percent     offset       size  field
>>   100=2E00          0       0x40  struct page      {
>>     9=2E01          0        0x8      long unsigned int   flags;
>>    57=2E99        0x8       0x28      union        {
>>    57=2E99        0x8       0x28          struct   {
>>    33=2E00        0x8       0x10              union        {
>>    33=2E00        0x8       0x10                  struct list_head     =
   lru {
>>    33=2E00        0x8        0x8                      struct list_head*=
   next;
>>     0=2E00       0x10        0x8                      struct list_head*=
   prev;
>>                                                 };
>>    33=2E00        0x8       0x10                  struct   {
>>    33=2E00        0x8        0x8                      void*       __fil=
ler;
>>     0=2E00       0x10        0x4                      unsigned int     =
   mlock_count;
>>    =2E=2E=2E
>>=20
>> Each patch's type profiling results are as follows:
>>=20
>> Patch | Feature                    | no_sym | no_var | no_typeinfo | ba=
d_offset | insn_track | ok(%)
>> ------+----------------------------+--------+--------+-------------+---=
---------+------------+------
>> 0011  | base (default spe period)  | 6      | 493    | -           | - =
         | -          | 56=2E2%
>> 0013  | enable insn tracking       | 6      | 42     | 437         | 2 =
         | 12         | 57=2E2%
>> 0016  | support 'load' insn        | 6      | 42     | 398         | 1 =
         | 52         | 60=2E7%
>> 0017  | support 'store' insn       | 6      | 42     | 398         | 1 =
         | 52         | 60=2E7%
>> 0021  | support stack variable     | 6      | 42     | 391         | 1 =
         | 59         | 61=2E3%
>> 0022  | support 'mov' insn         | 6      | 42     | 372         | 3 =
         | 76         | 62=2E8%
>> 0023  | support 'add' insn         | 6      | 42     | 318         | 7 =
         | 126        | 67=2E2%
>> 0024  | support 'adrp' insn        | 6      | 42     | 238         | 8 =
         | 205        | 74=2E2%
>> 0025  | support per-cpu variable   | 6      | 42     | 233         | 8 =
         | 210        | 74=2E6%
>> 0026  | support 'mrs' insn         | 6      | 42     | 230         | 8 =
         | 213        | 74=2E9%
>>=20
>> Limitations
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * SIMD/FP & SVE Vector Support:
>>   Data type profiling currently focuses on General-Purpose (GP) registe=
r
>>   operations=2E Vector/SIMD registers (v0-v31, d0-d31, q0-q31) and Scal=
able
>>   Vector Extension (SVE/SME) instructions are not tracked yet=2E
>>=20
>> * Regular Instructions Only:
>>   Only regular instructions are currently supported=2E Instructions fol=
lowing
>>   special rules or non-standard patterns are not supported yet=2E For e=
xample,
>>   load/store tracking only matches standard variants (ldr/ldur/ldar/ldp=
 and
>>   str/stur/stlr/stp) with straightforward semantics; exclusive loads/st=
ores
>>   (ldxr, stxr, etc=2E) and acquire/exclusive combination variants are e=
xcluded=2E
>>=20
>> * Compiler Prologue/Epilogue Code:
>>   As shown by the previous test results, approximately 14% of the faile=
d
>>   type profiling results originate from compiler-generated prologue or
>>   epilogue code (e=2Eg=2E, ldp  x19, x20, [sp, #16])=2E These instructi=
ons manage
>>   callee-saved registers across function boundaries, propagating type
>>   context through these operations requires inter-procedural (cross-fun=
ction)
>>   instruction analysis, which is currently unsupported by the local bac=
kward
>>   instruction tracker=2E
>>=20
>> Testing
>> =3D=3D=3D=3D=3D=3D=3D
>>=20
>> Tested on arm64 (all passed):
>>=20
>>   # perf test -v "perf data type profiling tests"
>>   81: perf data type profiling tests                                   =
                               : Ok
>>=20
>>   =3D=3D=3D Test Summary =3D=3D=3D
>>   Passed main tests : 1
>>   Passed subtests   : 0
>>   Skipped tests     : 0
>>   Failed tests      : 0
>>=20
>> Tested on x86=2E The profiling results show no change before/after appl=
ying
>> this patch series:
>>=20
>>   before : total 880, ok 711 (80=2E8%), bad 169 (19=2E2%)
>>   after  : total 880, ok 711 (80=2E8%), bad 169 (19=2E2%)
>>=20
>> Changelog
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>> v5 -> v6:
>>   - v5: https://lore=2Ekernel=2Eorg/all/cover=2E1788872630=2Egit=2Ewute=
ngda@huaweicloud=2Ecom/
>>   - Fix a potential UAF issue with capstone sym_name=2E
>>   - Optimize __get_dwarf_regnum_arm64 to compute directly based on char=
acter
>>     judgment, avoiding strtol calls=2E (Ian Rogers)
>>   - Fix an issue in extract_op_location_arm64 when parsing instructions=
 such as
>>     'cmp x0, x1, lsl #3'=2E
>>   - Fix several minor issues in instruction tracking=2E (Sashiko)
>> v4 -> v5:
>>   - v4: https://lore=2Ekernel=2Eorg/all/20260808122400=2E2961238-1-wute=
ngda@huaweicloud=2Ecom/
>>   - Introduce arch_get_reg_offset() to uniformly handle reg offset=2E
>>   - Add support for parsing extension type and shift amount in arm64 in=
structions=2E
>>   - Refine which instructions to track or skip=2E (Shuai Xue)
>>   - Rename dont_overlap to default_single_event_per_ip and use it in
>>     itrace_synth_opts__set_default()=2E (Adrian Hunter)
>>   - Introduce delete_stack_state() to clean up obsolete stack state=2E =
(Shuai Xue)
>>   - Normalize arch__dwarf_regnum() error return values=2E (Shuai Xue)
>>   - Drop canary support due to unresolved bugs=2E
>>   - Fix various minor issues, such as name memory leaks and header incl=
udes=2E
>> v3 -> v4:
>>   - v3: https://lore=2Ekernel=2Eorg/all/20260701035355=2E752944-1-wuten=
gda@huaweicloud=2Ecom/
>>   - Fix Capstone compilation failure=2E
>>   - Stop adding new pcrel_adrp_addr in LLVM; reuse pcrel_load_addr inst=
ead=2E
>>   - Fix parsing issue in arm64_mov__parse=2E
>>   - Add PC-relative load instruction parsing logic to arm64_ldst__parse=
,
>>     and introduce rstrip_space_and_comment to strip comments=2E
>>   - Remove wzr/xzr register parsing (not planning to handle this yet)=
=2E
>>   - Add post-index addressing mode parsing for the '[base], reg' format=
=2E
>>   - Update built-in implementation of --itrace=3Di1i to deduplicate ear=
ly
>>     during arm_spe_process_auxtrace_info=2E
>>   - Restrict the "default period to 1" behavior to ARM SPE, instead of
>>     applying it to all architectures=2E
>>   - Add register type tracking for function call instructions=2E
>>   - Add dual-register type tracking for load pair and store pair instru=
ctions=2E
>>   - Correct stack variable offset calculations=2E
>>   - Add type invalidation upon retry failure=2E
>>   - Reuse imm_value instead of introducing addr for 'adrp' instruction =
tracking=2E
>>   - Fix potential stale type resolution errors caused by TSR_KIND_GLOBA=
L_ADDR
>>     and TSR_KIND_CONST during stack passing=2E
>>   - Fix a strbuf memory leak during 'mrs' instruction tracking=2E
>>   - Fix stale dieoff issue when debug info changes=2E
>>   - Simplify add type propagation: only propagate offset/imm updates, l=
eave
>>     type parsing to chk=2E
>> v2 -> v3:
>>   - v2: https://lore=2Ekernel=2Eorg/all/20260403094800=2E1418825-1-wute=
ngda@huaweicloud=2Ecom/
>>   - Instead of always parsing the left operand as src and the right ope=
rand as
>>     dst, set them based on the actual instruction definition=2E (Namhyu=
ng Kim)
>>   - Fix refcount leak in print_capstone_detail()=2E
>>   - Remove useless '<' check when parsing 'addr <symbol>' in arm64_mov_=
_parse()=2E
>>   - Add example comments in arm64_ldst__parse()=2E
>>   - Split arch__dwarf_regnum() changes into a separate commit=2E
>>   - Rename annotated_addr_mode enum: INSN_ADDR_* -> PERF_ADDR_MODE_*=2E
>>   - Set caller-saved registers in init_type_state()=2E
>>   - For instructions with addressing mode, always goto adjust_reg_index=
_state()
>>     at the end to update the src register state=2E
>>   - Handle TSR_KIND_CONST registers for 'mov' and 'add' instructions=2E
>>   - Invalidate dst register for all other unsupported instructions=2E
>>   - Verify type DIE is task_struct pointer before caching globally=2E
>>   - Enable --itrace=3Di1i by default for ARM SPE data type profiling in=
 'perf annotate'
>>     to avoid overlapping event counting for the same instruction=2E (Ja=
mes Clark)
>>   - Fix global variable type resolving error in check_matching_type()=
=2E (James Clark)
>>   - Address review comments from sashiko [1]:
>>     - Fix unconditional call to arch->extract_op_location()
>>     - Handle multi_regs correctly
>>     - Fix invalid register state in error path
>>     - Other misc fixes
>> v1 -> v2:
>>   - v1: https://lore=2Ekernel=2Eorg/all/20250314162137=2E528204-1-lihua=
fei1@huawei=2Ecom/
>>   - Fix inconsistencies in arm64 instruction output across llvm, capsto=
ne,
>>     and objdump disassembly backends=2E
>>   - Support arm64-specific addressing modes and operand formats=2E (Leo=
 Yan)
>>   - Extend instruction tracking to support mov and add instructions,
>>     along with per-cpu and stack variables=2E
>>   - Include real-world examples in commit messages to demonstrate
>>     practical effects=2E (Namhyung Kim)
>>   - Improve type-tracking success rate (type stat) from 64=2E2% to 82=
=2E1%=2E
>>=20
>> Please let me know if you have any feedback=2E
>>=20
>> Thanks,
>> Tengda
>>=20
>> [1] https://sashiko=2Edev/#/patchset/20260403094800=2E1418825-1-wutengd=
a%40huaweicloud=2Ecom
>> [2] https://developer=2Earm=2Ecom/documentation/102374/0103
>> [3] https://github=2Ecom/flynd/asmsheets/releases/tag/v8
>>=20
>>=20
>> Tengda Wu (26):
>>   perf capstone: Symbolize address operands to match objdump on arm64
>>   perf llvm: Fix arm64 adrp instruction disassembly mismatch with
>>     objdump
>>   perf annotate-arm64: Generalize arm64_mov__parse to support more
>>     instructions
>>   perf annotate-arm64: Handle load and store instructions
>>   perf annotate: Normalize arch__dwarf_regnum() error return values
>>   perf annotate: Introduce extract_op_location callback for
>>     arch-specific parsing
>>   perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
>>   perf annotate: Adapt arch__dwarf_regnum() for arm64
>>   perf annotate-arm64: Implement extract_op_location() callback
>>   perf annotate: Default to --itrace=3Di1i for data type profiling
>>   perf arm-spe: Set default synthesized event period to 1
>>   perf annotate-data: Extract invalidate_reg_state() as a common helper
>>   perf annotate-arm64: Enable instruction tracking support
>>   perf annotate-data: Add arch_get_reg_offset helper
>>   perf annotate-arm64: Track return type after call instructions
>>   perf annotate-arm64: Support load instruction tracking
>>   perf annotate-arm64: Support store instruction tracking
>>   perf annotate-data: Expand type_state_reg imm_value to u64
>>   perf annotate-data: Track imm_value for stack variables
>>   perf annotate-x86: Delete stale stack state on store of untracked
>>     register
>>   perf annotate-arm64: Support stack variable tracking
>>   perf annotate-arm64: Support 'mov' instruction tracking
>>   perf annotate-arm64: Support 'add' instruction tracking
>>   perf annotate-arm64: Support 'adrp' instruction to track global
>>     variables
>>   perf annotate-arm64: Support per-cpu variable access tracking
>>   perf annotate-arm64: Support 'mrs' instruction to track 'current'
>>     pointer
>>=20
>>  tools/perf/builtin-annotate=2Ec                 |    8 +
>>  =2E=2E=2E/perf/util/annotate-arch/annotate-arm64=2Ec  | 1211 +++++++++=
+++++++-
>>  =2E=2E=2E/util/annotate-arch/annotate-powerpc=2Ec     |    9 +
>>  tools/perf/util/annotate-arch/annotate-x86=2Ec  |  117 +-
>>  tools/perf/util/annotate-data=2Ec               |  205 ++-
>>  tools/perf/util/annotate-data=2Eh               |   14 +-
>>  tools/perf/util/annotate=2Ec                    |  108 +-
>>  tools/perf/util/annotate=2Eh                    |   63 +
>>  tools/perf/util/arm-spe=2Ec                     |   16 +-
>>  tools/perf/util/auxtrace=2Ec                    |   12 +-
>>  tools/perf/util/auxtrace=2Eh                    |    7 +-
>>  tools/perf/util/capstone=2Ec                    |  186 ++-
>>  tools/perf/util/cs-etm=2Ec                      |    2 +-
>>  tools/perf/util/disasm=2Ec                      |    5 +
>>  tools/perf/util/disasm=2Eh                      |    5 +
>>  =2E=2E=2E/util/dwarf-regs-arch/dwarf-regs-arm64=2Ec   |   25 +
>>  tools/perf/util/dwarf-regs=2Ec                  |    2 +-
>>  tools/perf/util/include/dwarf-regs=2Eh          |    1 +
>>  tools/perf/util/intel-bts=2Ec                   |    2 +-
>>  tools/perf/util/intel-pt=2Ec                    |    3 +-
>>  tools/perf/util/llvm=2Ec                        |   52 +-
>>  21 files changed, 1831 insertions(+), 222 deletions(-)
>>=20
>>=20
>> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
>> --=20
>> 2=2E34=2E1
>>=20

- Arnaldo 
