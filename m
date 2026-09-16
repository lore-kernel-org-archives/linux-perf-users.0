Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE272D7DE7
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789532272; cv=pass; b=hUocRNZVFYmOE5H8RleMAf8kqFaq6hK68DKP98q/D7olp9t+En5q1RNhROBu2XwOpTSBuKIDhTpBZYuIVh45YhW9ZdcfTb/FTmVALMwbStgcqs9i/M47Pq8XpF0UnRa1r0tVWZS04T1Eyi4b3Q85eyqXmCzGhz5hDK0vXakLOmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789532272; c=relaxed/simple;
	bh=IQehdHkyL2SeQVRHkZCoKzPrsdF4TNYPKHuNeYxMvN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkRm7/Icx08k5EDmp2Gniyi+oWb03UyffTP8q10vkjaLsSNdl5mW5iugW+F3dJU7h6s1yjSF+cDXOtF5Bu/kcqPS6TD6ZxlggLp46+B9HBJvoHJrNQoKF0fjEcNrnAehq2DIy/xof3LoU0oD5uHNpQ5Lgo+L0SssHSenX1xrMOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RonXJWev; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RonXJWev"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so104841cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 21:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789532268; cv=none;
        d=google.com; s=arc-20260327;
        b=qYHL+5KZVSw1nSKFVT/Irwvx18LxcCVFTSeu95oJH+A6y3CgtaIg8j9fJoQ2OTMw2g
         PSU2n2Unv0l9gaKsRxPrws4hWrcBXQqqJoN7hUrLv6KwyRbyOrtQYuEdI7IYwxoKoIaM
         yLEKgXOhX5Cm7cgmI1D6t5Ls39bWf6cPhpMbnCJj0eSkJhqh2kxc+4iUAXQEnK0BVZwZ
         /PAq7Mik4b+pZtN+RmAawJIE5m3qadRmoMX15A+eSU8ris9apap8Hz5szf9GaKU+luYD
         EV1jy1Czk8mRK+4fnvZZ0rfCVTaTZ2fTMBeBgqwp36yyNRqo7jvq8E2xyntB0rtmokLI
         E5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rM5pAs9orlrFCBQo0Nddj0mJaULDltKyBL+9eKhYSa0=;
        fh=f37j9SP2VPvy3LoDLt+B+wO1eWBgxZXpw1XYNJy+VR8=;
        b=kBEnert+IhiOGo6HVNN2yWGZ6EHvgTsXI3asFTN0z0zBOq5vjham7ch9M+7qZZLafg
         d6jvzt0JysBawjLyQU8yTa8cMcJZgZW30rZ43VwIXaJ3ihEn7aMc4L76CdaIB0pmdbgG
         yD3xcKFEblWj/PnBpdavid4cDr6Fx2Njy8hW87n1/N1Y3sHQh6M3F1haIW0GhM5fxJAd
         /CQiSrviGSR+zY3TkZ/0OGbNqkZWVR2ZXyFT0Try6WYNQdUAkClWS9UYm84AlboGzECt
         c3Yh3byMfgThYdyRauG4dpF6Osq0RadbFRtfR8Nabqn+PCrSXe0ktsNcuwGdYXcfjIUs
         YHag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789532268; x=1790137068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rM5pAs9orlrFCBQo0Nddj0mJaULDltKyBL+9eKhYSa0=;
        b=RonXJWevvLYJYUHD60KYH0PTVW3zeRzDENy/NjMR+mtdXHOPzdvstWOsA8cr+kBxtY
         Sxto5j8MOOtFZ7D15iZvdD3nbFQeBGiPO3IAHHazRH5lZxvxB7QtygJiSnbwXYDVdwsH
         2asJs7mzwAyfdQ4tSa/M2//0cB2OVYWjqWfynpH5OiPzTQdtd6AjPaKp6J9Skj43Lw47
         ujOKulEZVqS2gN4S9D3ZyjAujUklhKE/oXR6hYAC0YEy6STCCvUkEc0sX7WIuAtTr0oJ
         BU88/baOd7OHlCc8qEeSML3zrbJgSRdYcLz6tndH0kCdFv8TmkgJB96gw1Es8ISCMIgD
         JOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789532268; x=1790137068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rM5pAs9orlrFCBQo0Nddj0mJaULDltKyBL+9eKhYSa0=;
        b=spV5wfJyz6WKGcSI7mu2TFZP1m7MajhkPP8sqs4QltJuFLoH0wd/si26E3y3TX6Qdk
         xY3Kr+9TT9KJ1eCco8MFWKabCmveqISODqSZRM+e67VsGOaQK+hsnZx5V9+GXza3o38J
         p0p5U35sOBUGXudNycLH/jSEqtVVEezUW+GWCANLKqc4bcKvMcKkOG/Y5U8booPybCV1
         xXEIh+0K6XpHwpgGOEI/IpUd5XzdjjcWY7TGQNsKFxg/WU5/jK46VKKZYoIgWO07dTqq
         IQchuboOrW3tXv2WzNMLmHrBbOzp+1hB96hVpiBH5xsbBBq3oCSF50WeWVCuoA5SpMtv
         bSbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPxBxntxdpoPogRu9isfnUjeSgRqGAGUYMlxxZ9msU/tjvw1yVKZ2jRULJo3C+Jtrr15+GkfSaCh0ujNwgMjPj@vger.kernel.org
X-Gm-Message-State: AFuF++k1GAS5ZwOuAFcrhxe1bKNVrwhGGv17/F5V+auEjmjBsunRPKya
	m0bNeWFtrpVXBRBiF4ml5aRMHa6Bla9E7dTCJoSsDreij+JCduwQL6yspRUFWvzINNzyeId2Eeh
	CPqQD7ZCHZUIKs9TNoVvg9N6Iag2/HAOKc3Y3ONy/
X-Gm-Gg: AYBFou1DyOJG961wKf4XPPiiCSl9w7Ssrg6GQhl+fNpZyTs/RH0AgKqWVYLY97gxaDj
	bkum+Nx36oSt5bLKeN+tH7vohqLxynOY2DEoLHKH6g9cIj/Do8GGk93Zieqy9YEQCk50uCXLBjt
	MKfOdX5wrlNdvnK784RZ0XZeSwQHPKrMBLrnrqEDDwOdqWy02I4HEj6rvHVGn4P/5LjxL8V16tN
	hxLoblGwvsVCxB4BhDm5rUZrmqZCkbn1UzVeE4X8EmnfJohpWCg8lz494SGGfxsuHgdEX5rF0D6
	97A6a0IpYYxDaXoU9Hlx7SWIGXXwai8X+xfuv0mqMloHUfvqQjfV98A=
X-Received: by 2002:ac8:5903:0:b0:532:858d:e791 with SMTP id
 d75a77b69052e-532858e038dmr244731cf.8.1789532267532; Tue, 15 Sep 2026
 21:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789521520.git.wutengda@huaweicloud.com>
In-Reply-To: <cover.1789521520.git.wutengda@huaweicloud.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 21:17:36 -0700
X-Gm-Features: AcwNN1UBOqnm7uGALpF8O0JvEmzfX10JjjET4-lZJhC-M7u1aw4qFOMhjJTr5RY
Message-ID: <CAP-5=fWUXwr3asB4HYdDdHCGV8wx+VMC8Xq-BRipU6175Roo7Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/26] perf arm64: Support data type profiling
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org, xueshuai@linux.alibaba.com, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev, 
	Li Huafei <lihuafei1@huawei.com>, Kim Phillips <kim.phillips@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Bill Wendling <morbo@google.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Zecheng Li <zli94@ncsu.edu>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 6:30=E2=80=AFPM Tengda Wu <wutengda@huaweicloud.com=
> wrote:
>
> This patch series implements data type profiling support for arm64,
> enabling 'perf annotate --data-type' to resolve memory locations and
> variable types on arm64 platforms.
>
> The main changes since v5 include:
> v5: https://lore.kernel.org/all/cover.1788872630.git.wutengda@huaweicloud=
.com/
>
> * __get_dwarf_regnum_arm64 optimization: compute directly based on charac=
ter
>   judgment, avoiding strtol calls. (Ian Rogers)
>
> * extract_op_location_arm64 issue fix: support parsing instructions such =
as
>   'cmp x0, x1, lsl #3'.
>
> * Instruction tracking part, fixing issues pointed out by Sashiko, includ=
ing:
>   - adding TSR_KIND_POINTER handling for ldr.
>   - premature returns in add and ldr causing percpu handling to be skippe=
d.
>   - adding a reg !=3D -1 check for stack type propagation, etc.
>
> Patch organization
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The series is organized as follows:
>
> 1. Fix disassembly mismatches (Patches 01-02)
>    Current perf annotate supports three disassembly backends: llvm,
>    capstone, and objdump. On arm64, inconsistencies between the output
>    of these backends (specifically llvm/capstone vs. objdump) often
>    prevent the tracker from correctly identifying registers and offsets.
>    These patches resolve these mismatches, ensuring consistent instructio=
n
>    parsing across all supported backends.
>
> 2. Infrastructure for arm64 operand parsing (Patches 03-09)
>    These patches establish the necessary infrastructure for arm64-specifi=
c
>    operand handling. This includes implementing new callbacks and data
>    structures to manage arm64's unique addressing modes and register sets=
.
>    This foundation is essential for the subsequent type-tracking logic.
>
> 3. ARM SPE event handling (Patches 10-11)
>    Patch 10 automatically deduplicates overlapping ARM SPE events (e.g.,
>    l1d-miss, tlb-access) in 'perf annotate' by retaining only the
>    "instructions" event when data type profiling is enabled. Patch 11
>    defaults  the synthesized event period to 1 for ARM SPE to fix zero
>    'Percent' values in annotate output.
>
> 4. Core instruction tracking (Patches 12-26)
>    These patches implement the core logic for type tracking on arm64,
>    covering several key types of instructions, including:
>    * Memory Access: ldr/str variants (including stack-based access).
>    * Arithmetic & Data Processing: mov, add, and adrp.
>    * Special Access: System register access (mrs) and per-cpu variable
>      tracking.
>
> The implementation draws inspiration from the existing x86 logic while
> adapting it to the nuances of the AArch64 ISA [2][3]. With these changes,
> perf annotate can successfully resolve memory locations and register type=
s,
> providing basic support for data type profiling on arm64 platforms.
>
> Example Result
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> # perf mem record -a -K -- sleep 1
> # perf annotate --data-type --stdio --type-stat
> Annotate data type stats:
> total 1138, ok 852 (74.9%), bad 286 (25.1%)
> -----------------------------------------------------------
>          6 : no_sym
>         42 : no_var
>        230 : no_typeinfo
>          8 : bad_offset
>        213 : insn_track
>
> Annotate type: 'struct page' in [kernel.kallsyms] (66948 samples):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  Percent     offset       size  field
>   100.00          0       0x40  struct page      {
>     9.01          0        0x8      long unsigned int   flags;
>    57.99        0x8       0x28      union        {
>    57.99        0x8       0x28          struct   {
>    33.00        0x8       0x10              union        {
>    33.00        0x8       0x10                  struct list_head        l=
ru {
>    33.00        0x8        0x8                      struct list_head*   n=
ext;
>     0.00       0x10        0x8                      struct list_head*   p=
rev;
>                                                 };
>    33.00        0x8       0x10                  struct   {
>    33.00        0x8        0x8                      void*       __filler;
>     0.00       0x10        0x4                      unsigned int        m=
lock_count;
>    ...
>
> Each patch's type profiling results are as follows:
>
> Patch | Feature                    | no_sym | no_var | no_typeinfo | bad_=
offset | insn_track | ok(%)
> ------+----------------------------+--------+--------+-------------+-----=
-------+------------+------
> 0011  | base (default spe period)  | 6      | 493    | -           | -   =
       | -          | 56.2%
> 0013  | enable insn tracking       | 6      | 42     | 437         | 2   =
       | 12         | 57.2%
> 0016  | support 'load' insn        | 6      | 42     | 398         | 1   =
       | 52         | 60.7%
> 0017  | support 'store' insn       | 6      | 42     | 398         | 1   =
       | 52         | 60.7%
> 0021  | support stack variable     | 6      | 42     | 391         | 1   =
       | 59         | 61.3%
> 0022  | support 'mov' insn         | 6      | 42     | 372         | 3   =
       | 76         | 62.8%
> 0023  | support 'add' insn         | 6      | 42     | 318         | 7   =
       | 126        | 67.2%
> 0024  | support 'adrp' insn        | 6      | 42     | 238         | 8   =
       | 205        | 74.2%
> 0025  | support per-cpu variable   | 6      | 42     | 233         | 8   =
       | 210        | 74.6%
> 0026  | support 'mrs' insn         | 6      | 42     | 230         | 8   =
       | 213        | 74.9%
>
> Limitations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> * SIMD/FP & SVE Vector Support:
>   Data type profiling currently focuses on General-Purpose (GP) register
>   operations. Vector/SIMD registers (v0-v31, d0-d31, q0-q31) and Scalable
>   Vector Extension (SVE/SME) instructions are not tracked yet.
>
> * Regular Instructions Only:
>   Only regular instructions are currently supported. Instructions followi=
ng
>   special rules or non-standard patterns are not supported yet. For examp=
le,
>   load/store tracking only matches standard variants (ldr/ldur/ldar/ldp a=
nd
>   str/stur/stlr/stp) with straightforward semantics; exclusive loads/stor=
es
>   (ldxr, stxr, etc.) and acquire/exclusive combination variants are exclu=
ded.
>
> * Compiler Prologue/Epilogue Code:
>   As shown by the previous test results, approximately 14% of the failed
>   type profiling results originate from compiler-generated prologue or
>   epilogue code (e.g., ldp  x19, x20, [sp, #16]). These instructions mana=
ge
>   callee-saved registers across function boundaries, propagating type
>   context through these operations requires inter-procedural (cross-funct=
ion)
>   instruction analysis, which is currently unsupported by the local backw=
ard
>   instruction tracker.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> Tested on arm64 (all passed):
>
>   # perf test -v "perf data type profiling tests"
>   81: perf data type profiling tests                                     =
                             : Ok
>
>   =3D=3D=3D Test Summary =3D=3D=3D
>   Passed main tests : 1
>   Passed subtests   : 0
>   Skipped tests     : 0
>   Failed tests      : 0
>
> Tested on x86. The profiling results show no change before/after applying
> this patch series:
>
>   before : total 880, ok 711 (80.8%), bad 169 (19.2%)
>   after  : total 880, ok 711 (80.8%), bad 169 (19.2%)
>
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v5 -> v6:
>   - v5: https://lore.kernel.org/all/cover.1788872630.git.wutengda@huaweic=
loud.com/
>   - Fix a potential UAF issue with capstone sym_name.
>   - Optimize __get_dwarf_regnum_arm64 to compute directly based on charac=
ter
>     judgment, avoiding strtol calls. (Ian Rogers)
>   - Fix an issue in extract_op_location_arm64 when parsing instructions s=
uch as
>     'cmp x0, x1, lsl #3'.
>   - Fix several minor issues in instruction tracking. (Sashiko)
> v4 -> v5:
>   - v4: https://lore.kernel.org/all/20260808122400.2961238-1-wutengda@hua=
weicloud.com/
>   - Introduce arch_get_reg_offset() to uniformly handle reg offset.
>   - Add support for parsing extension type and shift amount in arm64 inst=
ructions.
>   - Refine which instructions to track or skip. (Shuai Xue)
>   - Rename dont_overlap to default_single_event_per_ip and use it in
>     itrace_synth_opts__set_default(). (Adrian Hunter)
>   - Introduce delete_stack_state() to clean up obsolete stack state. (Shu=
ai Xue)
>   - Normalize arch__dwarf_regnum() error return values. (Shuai Xue)
>   - Drop canary support due to unresolved bugs.
>   - Fix various minor issues, such as name memory leaks and header includ=
es.
> v3 -> v4:
>   - v3: https://lore.kernel.org/all/20260701035355.752944-1-wutengda@huaw=
eicloud.com/
>   - Fix Capstone compilation failure.
>   - Stop adding new pcrel_adrp_addr in LLVM; reuse pcrel_load_addr instea=
d.
>   - Fix parsing issue in arm64_mov__parse.
>   - Add PC-relative load instruction parsing logic to arm64_ldst__parse,
>     and introduce rstrip_space_and_comment to strip comments.
>   - Remove wzr/xzr register parsing (not planning to handle this yet).
>   - Add post-index addressing mode parsing for the '[base], reg' format.
>   - Update built-in implementation of --itrace=3Di1i to deduplicate early
>     during arm_spe_process_auxtrace_info.
>   - Restrict the "default period to 1" behavior to ARM SPE, instead of
>     applying it to all architectures.
>   - Add register type tracking for function call instructions.
>   - Add dual-register type tracking for load pair and store pair instruct=
ions.
>   - Correct stack variable offset calculations.
>   - Add type invalidation upon retry failure.
>   - Reuse imm_value instead of introducing addr for 'adrp' instruction tr=
acking.
>   - Fix potential stale type resolution errors caused by TSR_KIND_GLOBAL_=
ADDR
>     and TSR_KIND_CONST during stack passing.
>   - Fix a strbuf memory leak during 'mrs' instruction tracking.
>   - Fix stale dieoff issue when debug info changes.
>   - Simplify add type propagation: only propagate offset/imm updates, lea=
ve
>     type parsing to chk.
> v2 -> v3:
>   - v2: https://lore.kernel.org/all/20260403094800.1418825-1-wutengda@hua=
weicloud.com/
>   - Instead of always parsing the left operand as src and the right opera=
nd as
>     dst, set them based on the actual instruction definition. (Namhyung K=
im)
>   - Fix refcount leak in print_capstone_detail().
>   - Remove useless '<' check when parsing 'addr <symbol>' in arm64_mov__p=
arse().
>   - Add example comments in arm64_ldst__parse().
>   - Split arch__dwarf_regnum() changes into a separate commit.
>   - Rename annotated_addr_mode enum: INSN_ADDR_* -> PERF_ADDR_MODE_*.
>   - Set caller-saved registers in init_type_state().
>   - For instructions with addressing mode, always goto adjust_reg_index_s=
tate()
>     at the end to update the src register state.
>   - Handle TSR_KIND_CONST registers for 'mov' and 'add' instructions.
>   - Invalidate dst register for all other unsupported instructions.
>   - Verify type DIE is task_struct pointer before caching globally.
>   - Enable --itrace=3Di1i by default for ARM SPE data type profiling in '=
perf annotate'
>     to avoid overlapping event counting for the same instruction. (James =
Clark)
>   - Fix global variable type resolving error in check_matching_type(). (J=
ames Clark)
>   - Address review comments from sashiko [1]:
>     - Fix unconditional call to arch->extract_op_location()
>     - Handle multi_regs correctly
>     - Fix invalid register state in error path
>     - Other misc fixes
> v1 -> v2:
>   - v1: https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@hua=
wei.com/
>   - Fix inconsistencies in arm64 instruction output across llvm, capstone=
,
>     and objdump disassembly backends.
>   - Support arm64-specific addressing modes and operand formats. (Leo Yan=
)
>   - Extend instruction tracking to support mov and add instructions,
>     along with per-cpu and stack variables.
>   - Include real-world examples in commit messages to demonstrate
>     practical effects. (Namhyung Kim)
>   - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.
>
> Please let me know if you have any feedback.

There's a sashiko finding on patch 21 that looks like it should be
addressed. For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Tengda
>
> [1] https://sashiko.dev/#/patchset/20260403094800.1418825-1-wutengda%40hu=
aweicloud.com
> [2] https://developer.arm.com/documentation/102374/0103
> [3] https://github.com/flynd/asmsheets/releases/tag/v8
>
>
> Tengda Wu (26):
>   perf capstone: Symbolize address operands to match objdump on arm64
>   perf llvm: Fix arm64 adrp instruction disassembly mismatch with
>     objdump
>   perf annotate-arm64: Generalize arm64_mov__parse to support more
>     instructions
>   perf annotate-arm64: Handle load and store instructions
>   perf annotate: Normalize arch__dwarf_regnum() error return values
>   perf annotate: Introduce extract_op_location callback for
>     arch-specific parsing
>   perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
>   perf annotate: Adapt arch__dwarf_regnum() for arm64
>   perf annotate-arm64: Implement extract_op_location() callback
>   perf annotate: Default to --itrace=3Di1i for data type profiling
>   perf arm-spe: Set default synthesized event period to 1
>   perf annotate-data: Extract invalidate_reg_state() as a common helper
>   perf annotate-arm64: Enable instruction tracking support
>   perf annotate-data: Add arch_get_reg_offset helper
>   perf annotate-arm64: Track return type after call instructions
>   perf annotate-arm64: Support load instruction tracking
>   perf annotate-arm64: Support store instruction tracking
>   perf annotate-data: Expand type_state_reg imm_value to u64
>   perf annotate-data: Track imm_value for stack variables
>   perf annotate-x86: Delete stale stack state on store of untracked
>     register
>   perf annotate-arm64: Support stack variable tracking
>   perf annotate-arm64: Support 'mov' instruction tracking
>   perf annotate-arm64: Support 'add' instruction tracking
>   perf annotate-arm64: Support 'adrp' instruction to track global
>     variables
>   perf annotate-arm64: Support per-cpu variable access tracking
>   perf annotate-arm64: Support 'mrs' instruction to track 'current'
>     pointer
>
>  tools/perf/builtin-annotate.c                 |    8 +
>  .../perf/util/annotate-arch/annotate-arm64.c  | 1211 ++++++++++++++++-
>  .../util/annotate-arch/annotate-powerpc.c     |    9 +
>  tools/perf/util/annotate-arch/annotate-x86.c  |  117 +-
>  tools/perf/util/annotate-data.c               |  205 ++-
>  tools/perf/util/annotate-data.h               |   14 +-
>  tools/perf/util/annotate.c                    |  108 +-
>  tools/perf/util/annotate.h                    |   63 +
>  tools/perf/util/arm-spe.c                     |   16 +-
>  tools/perf/util/auxtrace.c                    |   12 +-
>  tools/perf/util/auxtrace.h                    |    7 +-
>  tools/perf/util/capstone.c                    |  186 ++-
>  tools/perf/util/cs-etm.c                      |    2 +-
>  tools/perf/util/disasm.c                      |    5 +
>  tools/perf/util/disasm.h                      |    5 +
>  .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |   25 +
>  tools/perf/util/dwarf-regs.c                  |    2 +-
>  tools/perf/util/include/dwarf-regs.h          |    1 +
>  tools/perf/util/intel-bts.c                   |    2 +-
>  tools/perf/util/intel-pt.c                    |    3 +-
>  tools/perf/util/llvm.c                        |   52 +-
>  21 files changed, 1831 insertions(+), 222 deletions(-)
>
>
> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
> --
> 2.34.1
>
