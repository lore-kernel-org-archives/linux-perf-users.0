Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E346C4AC
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589057; cv=pass; b=Pr6eIxpHwYGLSaTdb8Cj/kxKyvxbmPDORWNiuQy3A2bgnazZtoi8mRRlgM69QEphhuObLJNpiS3SstZQDw5BfN/qnCx3owj50nqqPj+k1KQI/pW/w3GwU0+R98ayvXO5kBGCy1MnT7LGButBLo0dcPW4E2KI2PtkvvfG/7gMrxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589057; c=relaxed/simple;
	bh=dYu9SBdDrcnxf73R+BtKZ0OVoKbKLSarMfHvw3XyWtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDQ/NuyBviMe/G++tOYUhUK0KdkYG7jvrmRSRQE5y5tVNjHK833Y40QqsXLoh6A3JogYNaqNqKwvrKPp71H8mGkfMFPPkluql+2OfWk83V9Or5LozaAERJFdZ4vHo99PtFC94v9FjqujS/MddhZrmja649gdG0J3ASt2qTr0Ol4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EY/VYjxc; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EY/VYjxc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdf36f63dso189105ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 09:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787589055; cv=none;
        d=google.com; s=arc-20260327;
        b=BUhB0/pcxF/qXoRgKHpjQ9HzZSoUTxPg0edrrUf0f9GV8G0Zt/mvlfP/8fuvYNTVl5
         TcFYNU17skSuGBcv3y1e9LD5hWiClOFoZlKkGH8HYaxwEQRcSfwZORaRQmitCOnhexAS
         6Np/Oe/WzmmpTQ1bILyKRbpdqqzh8SghHlGXYBDM1CjIeExQyCLfk+I2nHX22dNV4iu3
         QtamyH8OIm3T+eXzKlm2uhbfg/ayHb7yEoKv5UpMb9tsamyEUxD2Kj7Y9+foiP3Tybn7
         pgJg6pzAY3+/Pjt8FenSudDPvDYU+nXdSFiSY1W2mgDUt//jH1LZrov6aIAyw5FmCB0r
         33Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8sIn5dDA2ALRE5s4ggYKNqu9r9+1brBE+BSFW226aQ=;
        fh=yBHsqrVVtmccdpkst1+arEE8mtXeXQA/Y+iNLaz7Dig=;
        b=UBni/EIqDFppxQ3qy4yrhGHOXHYcG5TyGkkH3ceFs6IrrgUYwsY2FjBdgCN3fO9YJe
         PlxQ1kvhL+G++mbVJRpgmzmDqwoTR6NiYBtfYfP57pXEsmratFVP5Z6VMXerDaDWkwnR
         Yb9Bus4VM5wzSGUOWuERLflAKVJhrLybzHXIZVSlN2DunHDd3JhuVYh9mDso9DN0CqaG
         LrjWhe+4EvRQWTakkOsRFAlYsYg8evJ0NJ6Wbmd8YAvL5miY5Ip2M5l10sBruPhr4dnm
         uJxRcdfVoYefbzyrVP78kdhbCgcyhlKJr1x4TmvguF5aX23jRDGcn0Bi33/O0sVdx76d
         Ys/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787589055; x=1788193855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g8sIn5dDA2ALRE5s4ggYKNqu9r9+1brBE+BSFW226aQ=;
        b=EY/VYjxcSVMpdE1n1goeg9IL9KjwIM0bnBqbQ0ia8AmhvnkAKFH8U6NOpy+biClnuC
         4XFlKO15pVmL3iZvEg8FX+H7SmE8BTEfhdggXPW05yrI8QuagPKeRRoKXHZscxAWPyhE
         QFhOtpI4BOWDJkncjAmM02mkyhZdANB7BzD3tdg9poAcPDPmcvHeXJ0/icSt9tJuOPro
         vfGrSmo6lJn+6ovNQVobGfL3z/d6I3RQ8fViMs3u4p4CSabXOX7m1oF4PCaAhJ0q1QlG
         tyzxvmToSyja9iXuwDccou1Dhe8CK1b3rLxkDMDcigDmyLGekVToMu2qf2UOVKi3ELD6
         tnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787589055; x=1788193855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8sIn5dDA2ALRE5s4ggYKNqu9r9+1brBE+BSFW226aQ=;
        b=QBmLwuK1+gwzjyPaeYKSCvT/p1GqL6o97NSziyUuP7k+rPCvu7kKR0GllJzQR1Rfkh
         J5vdDgRbU5w8X4xiQvZ+OxlYrgIlCgaC3KcbYCdvWmYw3IoOjzrNvX+RBxVdbd6frXsO
         uOw9d6S+qeKmhL3bY+BLjVV2XgZVhODy4qZrThSCLfqX+qwES6wzzg9ua63RoEYvqPDS
         z59zWInEZhiE2tof30YpLpr+e2Ki959LuHkuitfDiKKbgrsYV+XKsDRd6DG1F9AL4Y83
         SXQbo5HRar/c2yI/hPZtkdRCzY9rdCHNf7t46dEW3J4CKfpidPU+lzwQlv48KAwlfn/S
         WQng==
X-Forwarded-Encrypted: i=1; AHgh+RoVIGtkLk047VQUXw/fXRYYM1t8isQcAg/zeE0lUCDrZLfkm+l3+voebsVKqyHtb/A5zXe8MG9nuJdow/0qdAEh@vger.kernel.org
X-Gm-Message-State: AFuF++k/vfiSg/W8iyMj4hWUTmS9Y81A3t9OUTlhdYueTZR++qzPzbg2
	S1nJ9h5lNeI2kaJNxDEcpVNcvDL/7gwAQqYu6Ra5YbCUgAbWbcBvuVvtE1q0wjYCedJMQ5DryqB
	7UlrVQvmKGP7gVHh9oqXsCzKU9bc3kuiJ5K7Q5vuL
X-Gm-Gg: AR+sD13YGD70jp0aabc8XVIa03oFhnba45tKPL7rFcKMJhaBvmxujIOsU8M1wf5mJfU
	X5y5nmJexwVwPislsIBJfrnnpwv55yzOZCFXprwsCUkO0g3sByrf8PV4N7jQpBUZlnaqtDsTnt+
	B7khA1gqnRE8KqeiSB4EeV1criRDGCOP9+wEw1Q5ojGrMp2ohrP75ITcWgyQbrT3hZwFC6I2oGh
	IxQQwzLeTzw15R2zyP9Bjf8FQs7kgO0T/OP2aPUeAyDXUbbncauHNK85C9czY3+qCOw4/CubGnx
	cXK4goUMZcYQmYlp0r2xsukL6GJRSl5NVUVEXWV8t1IdvNc/GPs=
X-Received: by 2002:a17:903:3c24:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2d673aa8408mr10888335ad.1.1787589054124; Mon, 24 Aug 2026
 09:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824133122.751733-1-atomlin@atomlin.com>
In-Reply-To: <20260824133122.751733-1-atomlin@atomlin.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Aug 2026 09:30:41 -0700
X-Gm-Features: AcwNN1VjtTWsTSfQwbcZ-B1SviZO868xDRDMm8bpYRC0kwmCpfMtovrDmL94PMU
Message-ID: <CAP-5=fVnDY11NF5ziaQ3SQgUJq-WGmcX9GPWriN9a9sPYnC3gw@mail.gmail.com>
Subject: Re: [PATCH perf-tools-next v6 0/5] perf trace: Symbolise kernel
 virtual addresses and function pointers
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	steve@abita.co, rishil1999@outlook.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:31=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> When inspecting kernel execution flows using perf trace (e.g., when
> monitoring workqueues, delayed work items, timer callbacks, etc.),
> tracepoint payload arguments containing raw kernel virtual addresses are
> currently rendered as hexadecimal values (e.g., 0xffffffff81234567).
>
> This requires manual symbol lookups against /proc/kallsyms or vmlinux to
> identify the underlying kernel function being executed.
>
> This patch series enhances perf trace by introducing kernel virtual addre=
ss
> and function pointer symbolisation using perf's native symbol engine
> (i.e., machine__find_kernel_symbol()).
>
>     Before:
>       workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function:=
 0xffffffffa8046b50)
>
>     After:
>       workqueue:workqueue_execute_end(work: 0xffff8ac2c420f270, function:=
 wb_update_bandwidth_workfn)
>
> Patch 1 fixes a pre-existing error handling issue in btf_struct_scnprintf=
()
> where negative error return codes from btf_dump__dump_type_data() bypasse=
d
> the error check and erroneously advanced the augmented arguments buffer.
>
> Patch 2 introduces the syscall_arg__scnprintf_ksym() (SCA_KSYM) beautifie=
r,
> which resolves virtual addresses via machine__find_kernel_symbol(),
> formatting them as symbol_name+offset (or "NULL", with a graceful
> hexadecimal fallback upon lookup failure).
>
> Patch 3 updates event format initialisation in
> syscall_arg_fmt__init_array() to automatically assign SCA_KSYM to non-arr=
ay
> tracepoint fields typed as function pointers (such as typedefs ending in
> "_func_t" or "_fn", or function prototypes matching "(*)"). It also
> registers common function pointer, callback, and callsite field names
> (e.g., "action", "call_site", "callback", "caller", "caller_ip",
> "callsite", "cb", "fn", "func", "function", "handler", "location") in
> syscall_arg_fmts__by_name[]. To prevent misclassifying enums or 32-bit
> integers on 32-bit architectures, helper guards (field_is_ptr_sized(),
> field_is_enum(), and field_is_plain_int()) ensure SCA_KSYM is strictly
> assigned to pointer-sized fields and 64-bit scalars while allowing enums =
to
> fall through to BTF pretty-printing. It also removes the legacy
> trace__field_is_ip() hex override in trace__fprintf_tp_fields().
>
> Patch 4 extends BTF pretty-printing in trace__btf_scnprintf() with
> btf_is_func_ptr() to automatically traverse BTF type hierarchies (includi=
ng
> nested typedefs and qualifiers) and route kernel function pointer argumen=
ts
> to SCA_KSYM when BTF metadata is available. It strictly enforces a single
> pointer indirection limit and validates type signatures against extra
> pointer asterisks to prevent multi-level pointers from being
> mis-symbolised.
>
> Patch 5 adds an automated regression test script, trace_ksym_beautifier.s=
h,
> to verify kernel symbol beautification across both virtual address fields
> and function pointer fields.
>
> Changes since v5:
>
>  - Introduced patch to correct error-checking in btf_struct_scnprintf() t=
o
>    prevent erroneously advancing arg->augmented.args on negative error
>    returns
>
>  - Added helper functions field_is_enum(), field_is_plain_int(), and
>    field_is_ptr_sized() in Patch 3 to guard SCA_KSYM assignment from
>    colliding with 4-byte enum or integer fields on 32-bit architectures
>    while supporting 64-bit scalar addresses (e.g., u64 caller_ip)
>
>  - Updated btf_is_func_ptr() in Patch 4 to enforce a strict single-pointe=
r
>    limit (nr_ptrs =3D=3D 1) with early termination on multi-level pointer=
s,
>    and added a type-string pointer check in trace__btf_scnprintf() to rej=
ect
>    function pointer typedefs with extra pointer indirections
>
>  - Removed test_ksym_btf() from trace_ksym_beautifier.sh in Patch 5,
>    refocusing the test on verifying SCA_KSYM symbolisation across both
>    virtual address and function pointer fields
>
>  - Link to v5: https://lore.kernel.org/lkml/20260822213558.704018-1-atoml=
in@atomlin.com/
>
> Changes since v4:
>
>  - Added a non-array guard (!(field->flags & TEP_FIELD_IS_ARRAY)) to the
>    type-signature heuristic in syscall_arg_fmt__init_array(), preventing
>    array fields matching "(*)", "_func_t", or "_fn" from erroneously
>    receiving SCA_KSYM
>
>  - Replaced host sizeof(void *) check with tep_get_long_size() to support
>    cross-architecture analysis of 32-bit trace data on 64-bit hosts
>
>  - Added deterministic workloads to trace_ksym_beautifier.sh to prevent
>    indefinite hangs on quiescent systems
>
>  - Replaced csd:csd_function_entry in test_ksym_btf() with
>    timer:hrtimer_start to ensure test reliability on both SMP and
>    uniprocessor (CONFIG_SMP=3Dn) systems
>
>  - Link to v4: https://lore.kernel.org/lkml/20260821204930.679027-1-atoml=
in@atomlin.com/
>
> Changes since v3:
>
>  - Added "caller_ip" to syscall_arg_fmts__by_name[] in alphabetical order
>    to symbolise instruction pointer fields
>
>  - Guarded SCA_KSYM auto-assignment in syscall_arg_fmt__init_array() to
>    only match actual pointer fields or pointer-sized non-array scalars,
>    allowing unmatched fields to fall through to subsequent type checks
>
>  - Fixed btf_struct_scnprintf() to only dump struct data for augmented
>    input parameters, preventing un-augmented output pointers from dumping
>    empty "{}" instead of falling back to hexadecimal pointer addresses.
>    Also ensured btf_dump is properly freed on error exits
>
>  - Updated test_ksym_btf() to trace csd:csd_function_entry with --force-b=
tf
>    instead of call_site, directly verifying function pointer symbolisatio=
n
>
>  - Link to v3: https://lore.kernel.org/lkml/20260820211100.649142-1-atoml=
in@atomlin.com/
>
> Changes since v2:
>
>  - Populated syscall_arg_fmts__by_name[] with common function pointer,
>    callback, handler, and callsite field names ("action", "call_site",
>    "callback", "caller", "callsite", "cb", "fn", "func", "function",
>    "handler", "location")
>
>  - Checked syscall_arg_fmt__find_by_name() prior to generic pointer
>    fallbacks in syscall_arg_fmt__init_array(), and dropped the inline
>    64-bit size check to ensure 32-bit and cross-platform compatibility
>
>  - Removed legacy trace__field_is_ip() in trace__fprintf_tp_fields() to
>    allow "call_site" and "caller_ip" to be beautified with SCA_KSYM rathe=
r
>    than being forced to raw hexadecimal
>
>  - Simplified btf_is_func_ptr() to remove the internal pointer requiremen=
t,
>    correctly identifying bare prototype typedefs as function pointers
>
>  - Prevented pointer enums (e.g., "enum foo *") from being misclassified
>    and formatted as scalar enum values in
>    syscall_arg_fmt__cache_btf_type(), trace__btf_scnprintf(), and
>    syscall_arg__strtoul_btf_type()
>
>  - Added negative caching (btf_type_cached) to struct syscall_arg_fmt to
>    avoid repeated BTF searches on every event for unresolvable or primiti=
ve
>    types
>
>  - Widened btf_enum_scnprintf() to accept unsigned long val, eliminating
>    narrowing truncation of 64-bit values to 32-bit signed integers
>
>  - Fixed trace_ksym_beautifier.sh:
>     - Quoted "$0" to support directory paths containing spaces
>     - Captured output in memory to eliminate temporary file leaks on earl=
y
>       skip
>     - Hardened regex validation to require valid C symbol identifiers and
>       reject raw hexadecimal addresses
>     - Used '%s' format specifiers in printf to prevent format string
>       injection
>
>  - Link to v2: https://lore.kernel.org/lkml/20260816205921.576365-1-atoml=
in@atomlin.com/
>
> Changes since v1:
>
>  - Fixed reference leak of struct map in syscall_arg__scnprintf_ksym() by
>    calling map__put() prior to returning Removed unreachable and erroneou=
s
>    entries ("action", "callsite", "call_site", "fn", "function", "work")
>    from syscall_arg_fmts__by_name[]
>
>  - Restricted name-based SCA_KSYM auto-assignment in
>    syscall_arg_fmt__init_array() to pointer or 64-bit address fields,
>    preventing misclassification of non-pointer integer fields
>
>  - Updated btf_is_func_ptr() to fully unwrap typedefs and type modifiers
>    below pointer targets
>
>  - Fixed BTF type name matching in syscall_arg_fmt__cache_btf_type() to
>    handle leading modifiers and strip trailing pointer asterisks before
>    lookup
>
>  - Synchronised arg->val with val in trace__btf_scnprintf() and widened v=
al
>    to unsigned long, fixing erroneous "NULL" output
>
>  - Added shell test script,
>    tools/perf/tests/shell/trace_ksym_beautifier.sh, to verify kernel symb=
ol
>    beautification for both default kallsyms and BTF routing
>
>  - Link to v1: https://lore.kernel.org/lkml/20260815233651.527936-1-atoml=
in@atomlin.com/
>
> Aaron Tomlin (5):
>   perf trace: Fix error checking in btf_struct_scnprintf()
>   perf trace: Introduce kernel symbol beautifier for virtual addresses
>   perf trace: Auto-assign kernel symbol beautifier to function pointer
>     fields
>   perf trace: Enhance BTF type formatting to symbolise kernel function
>     pointers
>   perf tests: Add shell test for kernel symbol beautifier

For the series:

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/builtin-trace.c                    | 250 +++++++++++++-----
>  .../perf/tests/shell/trace_ksym_beautifier.sh |  38 +++
>  tools/perf/trace/beauty/beauty.h              |   3 +
>  3 files changed, 232 insertions(+), 59 deletions(-)
>  create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh
>
> --
> 2.55.0
>
