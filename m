Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0932772D
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108118; cv=pass; b=t+A4l/sHUOuIRaKjgZvUOHutr9LFR3OGH+jUkdB1NxLloj5ho5zUtaGHGYvvrOaVTWp65I/rA1VpToAJMcEHVG+mtTJqgqqlI9arGjD6i7wnf9U8gnJOVtOgjFmcV+pQayKzXPJHe8VzZ0lNePrmcCzjz/D0vhiKW9Bv4Bsw8WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108118; c=relaxed/simple;
	bh=gjnpPfDWtPsrjfqc4r27mzyW7gHD5L3a2nC47nghFBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHB3dprYXhgit/HQu5jMghvN+K2osMQf97AP6gBgPQCB2dJs74KKXgkZDZevd/ziZhrhA3g9R9tsvGESz+6EfCiEqKoYnzgSL2WnMDVioI+2vxwv7bq9jclchm6Wu8kZtshslkcJQgtFYDFxpyTfYtZp/YEXyT5tWPDtS8R0oF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDBIV78c; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDBIV78c"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf22c18ad3so111105ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 09:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781108115; cv=none;
        d=google.com; s=arc-20240605;
        b=WVdnTRST9adWDLvp9USVXzyt3pyj8Z+mpzjBh17a1qDcoq0LE+C/JbUe6hqBwWJlBx
         7k2iXWSUIoP8Qc0GqqJgwFQBiL6c34MorChmVbkGZVZFLLk9dsjONPV0KVApLQDJq3NF
         sGJTdibETa8VB7czQBx1VX/ezmR/xG6tEks/hF+KMpry03ktirjEiwbfmHCWvFA1Dwuc
         Ms0NcBXiyNtxnQPwZRIOaU3UuyWHAlo4T48TrwrTwzprqor+GB3+xsUgynaZLlUufklY
         bz8RakScY/MMxkzQ9pagoB5Uxx46lyXTqXj7aTLrvz3wrD1zCy++kgsAVkUjbRQ4SWtX
         7sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pwxGy/l82+vqTuiPpuRfUTQ1dmPJTqm9jD5gV1KEs7I=;
        fh=uvCYUQIooTbRKhAZGP8E2GqNFdD2+rV3pG4EoKQZqvU=;
        b=TWmyMg+U6bqob1dXypdpDrBZnHX1f4PljrXpu64ASeYfA/zsCKA+v0ckAuZILDZEsb
         Muj979da2rVsNU9BSbcKBVGePe0YY7wbtK9dFEZTiFFHvo4bG/vnRQNM0QX/e8BUJ+sw
         aRVVXsLYN1MNs8MzEFinArC9EJly3zLBIYxVYhyogFkS2y5kLTqxYBqooZU0UP5xxWNT
         sXIaSZFBlpeysAdq884L0IV3mjNI7AEZ7foqOqmK8lMIgYSrBMSxvnLsnOKBnGPV8usy
         3bBYMXDcw8A+Kj6g5CUgmmiIQCJfQXTBZCuFSyY6KS08YVRMgiGKhbX9Hi7yNfCNoOB+
         7StQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108115; x=1781712915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwxGy/l82+vqTuiPpuRfUTQ1dmPJTqm9jD5gV1KEs7I=;
        b=MDBIV78c3BzdCUOyySJbGSgQwJpFi3u4hoRqek/ewqkYVjK8QLe+SVemsf2/yqo4XC
         YQuY/l0lV2nBMxjIx26FT3E7aR2TyIBaUWvFzSmZ3AJ9UL7qunVBTKKHgI9JNfvNFmGD
         MveF13530o+RuNBbSJGNI8v7y+w+cLhao//aoXiV4jGw1G5NbfeJA/Fmdg4r1DDmA4XG
         FuYoNdqplFwkCR8u+H6s0dTIUIVnndmkiWlBvMR45nl3yeFa1UH/yuwLQ3FB8zE3eg3l
         r5BHK/GYtaXSdYujEbmd1t0CLjkk7jmgTnqw1l8c027z/R4JyCmzDXBG4a1WEX/HAGhi
         XOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108115; x=1781712915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pwxGy/l82+vqTuiPpuRfUTQ1dmPJTqm9jD5gV1KEs7I=;
        b=i03QyzIIAqGyTAlkvKhsIMq7mLrGqR0kQZhfZniqWqy+LFjLddci6JBP5meygW4sWK
         F6MsWaXqnoj4sQ3I6+fWxMKTXArwuQFe6LJ4NAfHV5DM9XYRGRAp4sZ+ioTgrkkDM4OJ
         kKzvaXelxHcsYB58dRaAfOvgiD4F2Zc8YJqqpuHB1JMtBmGTAL1chTDPUlo8shxk5jCP
         zOnxEzHOmsHGu0MNqqJkksOVonZtLy40aR8HTC/f6W+HrzEYkVKCPY0BL7WpWwqVfaSp
         mnfCPPXnbRx7CwOQYUj+lxSA/MMuaIofgV28pTqgjw8O9/Q6/PzZDbt13GF7zBTqpY4Z
         JIUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EP2UExk91AYMkPBgkLfLlzU+vIK3KUutCKnnJJPnZ5+CFW1W2Qe4ExhzzAhnhysFUTyjIE9HhGPu0YIR0RaIu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fmelTMFxVzRxmwRwWFySB4yc1azW7Qnr6NeDFR0iNARy7zNo
	5RXLSv3AaxV/KKkApi2FooQu2cIoUvKEB9ZdjHPtQWQleDSdId+ifMWBeV6GZvsxPH8Wc7u0fWJ
	rPjuj46exE3yk62D35MqZVNYil99G/WyVV4ilUkIy
X-Gm-Gg: Acq92OGbbRcS2Ozr4D4z7BJEy0IHK5limvAQ94N23jHh1mv56NJksFaE0w2rIiJdpRd
	zFMUmwXRgttGf3nw5IE/2EJp6x3BvucR1X4CC8BrKEqAjc6TyVt7NpiXV6anBQS0o5Rf/rgnyO+
	BSiZktHguZelj/zsHNcCZCPglX5c2Axndd/eDXWsi+LX/cWWFxj5DUKa6js7T6ZqPXdbu7NoX0N
	ngWZgBwGfc5l8hSt49u6vddB5IdB1/dA+7BSDn62+pUK+9ExaCq6zuWOnIOvrHVLuGMbSIBsytM
	J/HqzIQjSTddG0+BtZvEVxB0Wa3JrIUXndrmDqJQjp9gGJIO
X-Received: by 2002:a17:902:e543:b0:2bf:2e8c:db96 with SMTP id
 d9443c01a7336-2c2d93f71ecmr319295ad.5.1781108114329; Wed, 10 Jun 2026
 09:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607213700.3563842-1-irogers@google.com> <20260608054841.3856224-1-irogers@google.com>
 <20260608054841.3856224-6-irogers@google.com> <7e5d283f-2df7-42c0-8997-88d3359cd7a8@linaro.org>
In-Reply-To: <7e5d283f-2df7-42c0-8997-88d3359cd7a8@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jun 2026 09:15:02 -0700
X-Gm-Features: AVVi8Cd5ifZwsvAQt8qtT1Uz_TM2R2oaMhImiqNTE_8aClB4n3DaJYM6lThtlYs
Message-ID: <CAP-5=fXvqFVRMZvHcHFO04TUf-o9Z4i1jHa0Tgw_qXf4Av+dmw@mail.gmail.com>
Subject: Re: [PATCH v19 5/5] perf test: Add inject ASLR test
To: James Clark <james.clark@linaro.org>
Cc: adrian.hunter@intel.com, gmx@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 6:26=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 08/06/2026 6:48 am, Ian Rogers wrote:
> > Add a new shell test  to verify the feature. The test covers:
> > - Basic address remapping for user space samples.
> > - Pipe mode coverage for piped into.
> > - Callchain address remapping.
> > - Consistency of output before and after injection.
> > - Pipe mode report consistency.
> > - Dropping of samples that leak ASLR info (physical addresses).
> > - Kernel address remapping (utilizing a dedicated kernel-intensive VFS
> >    dd workload to guarantee continuous timer interrupts sampling flow
> >    inside kernel privilege states).
> > - Kernel report consistency with address normalization.
> >
> > The test suite is hardened with global 'set -o pipefail' assertions
> > to catch pipeline failures, stream-consuming awk processors to handle
> > SIGPIPE signals, and a dedicated pipe output scenario validating raw
> > 'perf inject -o -' stdout streams.
> >
> > Note on kernel DSO normalization in the test script:
> > The test script deliberately normalizes all kernel DSOs to a generic
> > [kernel] tag before diffing, as obfuscating physical kernel addresses
> > forces perf report to occasionally shift samples between individual
> > modules and [kernel.kallsyms] due to the lack of valid host module
> > boundary maps.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Assisted-by: Antigravity:gemini-3.1-pro
>
> Hi Ian,
>
> All the tests pass for me now on x86, and the previous Arm failures are
> fixed. But I still have the slowness issue  on Arm (takes almost an hour
> to complete) and one new test failure.
>
> I narrowed the slowness issue down to check_invariants(). If I compile
> without DEBUG=3D1 then it's the same speed as x86. Here's the stack where
> it spends all of its time:
>
>    maps__split_kallsyms() at util/symbol.c:1105
>    __dso__load_kallsyms() at util/symbol.c:1649
>    dso__load_kallsyms() at util/symbol.c:1655
>    dso__load_kernel_sym() at util/symbol.c:2244
>    dso__load() at util/symbol.c:1840
>    map__load() at util/map.c:351
>    thread__find_map() at util/event.c:744
>    machine__resolve()at util/event.c:818
>    process_sample_event() at builtin-script.c:2695
>    evlist__deliver_sample() at util/session.c:1807
>    machines__deliver_event() at util/session.c:1995
>    perf_session__deliver_event() at util/session.c:2226
>    ordered_events__deliver_event() at util/session.c:134
>    do_flush() at util/ordered-events.c:245
>    __ordered_events__flush()at util/ordered-events.c:324
>    ordered_events__flush() at util/ordered-events.c:342
>    __perf_session__process_events() at util/session.c:3578
>    perf_session__process_events() at util/session.c:3745
>    __cmd_script() at builtin-script.c:3255
>    cmd_script() at builtin-script.c:4603
>    run_builtin() at perf.c:348
>    handle_internal_command() at perf.c:398
>    run_argv() at perf.c:442
>    main() at perf.c:549
>
> The other issue is that test_kernel_report_aslr() fails.
> report_kernel1.clean looks like:
>
>        66.72%  dd       [kernel.kallsyms]  [k] chacha_permute
>       7.75%  dd       [kernel.kallsyms]  [k] chacha_block_generic
>       6.14%  dd       [kernel.kallsyms]  [k] _copy_to_iter
>       3.88%  dd       [kernel.kallsyms]  [k] lock_acquire
>       2.91%  dd       [kernel.kallsyms]  [k] lock_release
>       2.75%  dd       [kernel.kallsyms]  [k] rcu_is_watching
>       2.58%  dd       [kernel.kallsyms]  [k] __arch_copy_to_user
>       2.26%  dd       [kernel.kallsyms]  [k] __might_resched
>       1.94%  dd       [kernel.kallsyms]  [k] get_random_bytes_user
>       1.29%  dd       [kernel.kallsyms]  [k] __might_fault
>       0.81%  dd       [kernel.kallsyms]  [k] debug_lockdep_rcu_enabled
>       0.48%  dd       [kernel.kallsyms]  [k] __might_sleep
>       0.16%  dd       [kernel.kallsyms]  [k] kmem_cache_free
>       0.16%  dd       [kernel.kallsyms]  [k] seqcount_lockdep_reader_acce=
ss
>       0.16%  dd       [kernel.kallsyms]  [k] set_pte_range
>
> But report_kernel2.clean is maybe 10x longer and doesn't have any symbols=
:
>
>       8.08%  dd       [unknown]          [k] 0xffff8000108416ec
>       2.75%  dd       [unknown]          [k] 0xffff80001084170c
>       1.94%  dd       [unknown]          [k] 0xffff800010176360
>       1.94%  dd       [unknown]          [k] 0xffff80001084156c
>       1.45%  dd       [unknown]          [k] 0xffff8000101be4bc
>       ...
>
> I think this could be related to why it gets stuck in
> maps__split_kallsyms() doing check_invariants(). I'm not sure if I can
> do anything to help debug, or if it's working for you on Arm so we can
> compare our setups?

So my focus has been making this solid on x86 and I hadn't been
testing on ARM. Kernel symbolization is always a pain. Perhaps for now
we should just skip the ASLR testing on ARM, and fix it in follow-up
patches.

Thanks,
Ian

> > ---
> >   tools/perf/tests/shell/inject_aslr.sh | 525 +++++++++++++++++++++++++=
+
> >   1 file changed, 525 insertions(+)
> >   create mode 100755 tools/perf/tests/shell/inject_aslr.sh
> >
> > diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/s=
hell/inject_aslr.sh
> > new file mode 100755
> > index 000000000000..4af21ed2ce9a
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/inject_aslr.sh
> > @@ -0,0 +1,525 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# perf inject --aslr test
> > +
> > +set -e
> > +set -o pipefail
> > +
> > +shelldir=3D$(dirname "$0")
> > +# shellcheck source=3Dlib/perf_has_symbol.sh
> > +. "${shelldir}"/lib/perf_has_symbol.sh
> > +
> > +sym=3D"noploop"
> > +
> > +skip_test_missing_symbol ${sym}
> > +
> > +# Create global temp directory
> > +temp_dir=3D$(mktemp -d /tmp/perf-test-aslr.XXXXXXXXXX)
> > +
> > +prog=3D"perf test -w noploop"
> > +[ "$(uname -m)" =3D "s390x" ] && prog=3D"$prog 3"
> > +err=3D0
> > +kprog=3D"dd if=3D/dev/urandom of=3D/dev/null bs=3D1M count=3D50"
> > +
> > +cleanup() {
> > +  local exit_code=3D${1:-$?}
> > +  trap - EXIT TERM INT
> > +  if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
> > +    echo "Test failed! Preserving temp directory: ${temp_dir}"
> > +    return
> > +  fi
> > +  # Check if temp_dir is set and looks sane before removing
> > +  if [[ "${temp_dir}" =3D~ ^/tmp/perf-test-aslr\. ]]; then
> > +    rm -rf "${temp_dir}"
> > +  fi
> > +}
> > +
> > +trap_cleanup() {
> > +  local exit_code=3D$?
> > +  echo "Unexpected signal in ${FUNCNAME[1]}"
> > +  cleanup ${exit_code}
> > +  exit ${exit_code}
> > +}
> > +trap trap_cleanup EXIT TERM INT
> > +
> > +get_noploop_addr() {
> > +  local file=3D$1
> > +  perf script -i "$file" | awk '
> > +    BEGIN { found=3D0 }
> > +    {
> > +      for (i=3D1; i<=3DNF; i++) {
> > +        if ($i ~ /noploop\+/) {
> > +          if (!found) {
> > +            print $(i-1)
> > +            found=3D1
> > +          }
> > +        }
> > +      }
> > +    }'
> > +}
> > +
> > +test_basic_aslr() {
> > +  echo "Test basic ASLR remapping"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.basic.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.basic.XXXXXX")
> > +
> > +  perf record -e task-clock:u -o "${data}" ${prog}
> > +  perf inject -v --aslr -i "${data}" -o "${data2}"
> > +
> > +  orig_addr=3D$(get_noploop_addr "${data}")
> > +  new_addr=3D$(get_noploop_addr "${data2}")
> > +
> > +  echo "Basic ASLR: orig_addr=3D$orig_addr, new_addr=3D$new_addr"
> > +
> > +  if [ -z "$orig_addr" ]; then
> > +    echo "Basic ASLR test [Failed - no noploop samples in original fil=
e]"
> > +    err=3D1
> > +  elif [ -z "$new_addr" ]; then
> > +    echo "Basic ASLR test [Failed - could not find remapped address]"
> > +    err=3D1
> > +  elif [ "$orig_addr" =3D "$new_addr" ]; then
> > +    echo "Basic ASLR test [Failed - addresses are not remapped]"
> > +    err=3D1
> > +  else
> > +    echo "Basic ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_pipe_aslr() {
> > +  echo "Test pipe mode ASLR remapping"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.pipe.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.pipe.XXXXXX")
> > +
> > +  # Use tee to save the original pipe data for comparison
> > +  perf record -e task-clock:u -o - ${prog} | tee "${data}" | perf inje=
ct --aslr -o "${data2}"
> > +
> > +  orig_addr=3D$(get_noploop_addr "${data}")
> > +  new_addr=3D$(get_noploop_addr "${data2}")
> > +
> > +  echo "Pipe ASLR: orig_addr=3D$orig_addr, new_addr=3D$new_addr"
> > +
> > +  if [ -z "$orig_addr" ]; then
> > +    echo "Pipe ASLR test [Failed - no noploop samples in original file=
]"
> > +    err=3D1
> > +  elif [ -z "$new_addr" ]; then
> > +    echo "Pipe ASLR test [Failed - could not find remapped address]"
> > +    err=3D1
> > +  elif [ "$orig_addr" =3D "$new_addr" ]; then
> > +    echo "Pipe ASLR test [Failed - addresses are not remapped]"
> > +    err=3D1
> > +  else
> > +    echo "Pipe ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_callchain_aslr() {
> > +  echo "Test Callchain ASLR remapping"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.callchain.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.callchain.XXXXXX")
> > +
> > +  perf record -g -e task-clock:u -o "${data}" ${prog}
> > +  perf inject --aslr -i "${data}" -o "${data2}"
> > +
> > +  orig_addr=3D$(get_noploop_addr "${data}")
> > +  new_addr=3D$(get_noploop_addr "${data2}")
> > +
> > +  echo "Callchain ASLR: orig_addr=3D$orig_addr, new_addr=3D$new_addr"
> > +
> > +  if [ -z "$orig_addr" ]; then
> > +    echo "Callchain ASLR test [Failed - no noploop samples in original=
 file]"
> > +    err=3D1
> > +  elif [ -z "$new_addr" ]; then
> > +    echo "Callchain ASLR test [Failed - could not find remapped addres=
s]"
> > +    err=3D1
> > +  elif [ "$orig_addr" =3D "$new_addr" ]; then
> > +    echo "Callchain ASLR test [Failed - addresses are not remapped]"
> > +    err=3D1
> > +  else
> > +    # Extract callchain addresses (indented lines starting with hex ad=
dresses)
> > +    orig_callchain=3D$(perf script -i "${data}" | awk '/^[[:space:]]+[=
0-9a-f]+/ {print $1}')
> > +    new_callchain=3D$(perf script -i "${data2}" | awk '/^[[:space:]]+[=
0-9a-f]+/ {print $1}')
> > +
> > +    if [ -z "$orig_callchain" ]; then
> > +      echo "Callchain ASLR test [Failed - no callchain samples in orig=
inal file]"
> > +      err=3D1
> > +    elif [ -z "$new_callchain" ]; then
> > +      echo "Callchain ASLR test [Failed - callchain data was dropped]"
> > +      err=3D1
> > +    elif [ "$orig_callchain" =3D "$new_callchain" ]; then
> > +      echo "Callchain ASLR test [Failed - callchain addresses were not=
 remapped]"
> > +      err=3D1
> > +    else
> > +      echo "Callchain ASLR test [Success]"
> > +    fi
> > +  fi
> > +}
> > +
> > +test_report_aslr() {
> > +  echo "Test perf report consistency"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.report.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.report.XXXXXX")
> > +  local data_clean
> > +  data_clean=3D$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> > +
> > +  perf record -e task-clock:u -o "${data}" ${prog}
> > +  # Use -b to inject build-ids and force ordered events processing in =
both
> > +  perf inject -b -i "${data}" -o "${data_clean}"
> > +  perf inject -v -b --aslr -i "${data}" -o "${data2}"
> > +
> > +  local report1=3D"${temp_dir}/report1_basic"
> > +  local report2=3D"${temp_dir}/report2_basic"
> > +  local report1_clean=3D"${temp_dir}/report1_basic.clean"
> > +  local report2_clean=3D"${temp_dir}/report2_basic.clean"
> > +  local diff_file=3D"${temp_dir}/diff_basic"
> > +
> > +  perf report -i "${data_clean}" --stdio > "${report1}"
> > +  perf report -i "${data2}" --stdio > "${report2}"
> > +
> > +  # Strip headers and compare lines with percentages
> > +  grep '%' "${report1}" | grep -v '^#' | \
> > +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report1_c=
lean}" || true
> > +  grep '%' "${report2}" | grep -v '^#' | \
> > +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report2_c=
lean}" || true
> > +
> > +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" ||=
 true
> > +
> > +  if [ ! -s "${report1_clean}" ]; then
> > +    echo "Report ASLR test [Failed - no samples captured]"
> > +    err=3D1
> > +  elif [ -s "${diff_file}" ]; then
> > +    echo "Report ASLR test [Failed - reports differ]"
> > +    echo "Showing first 20 lines of diff:"
> > +    head -n 20 "${diff_file}"
> > +    err=3D1
> > +  else
> > +    echo "Report ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_pipe_report_aslr() {
> > +  echo "Test pipe mode perf report consistency"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.pipe_report.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.pipe_report.XXXXXX")
> > +  local data_clean
> > +  data_clean=3D$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> > +
> > +  # Use tee to save the original pipe data, then process it with injec=
t -b
> > +  perf record -e task-clock:u -o - ${prog} | \
> > +    tee "${data}" | \
> > +    perf inject -b --aslr -o "${data2}"
> > +  perf inject -b -i "${data}" -o "${data_clean}"
> > +
> > +  local report1=3D"${temp_dir}/report1_pipe"
> > +  local report2=3D"${temp_dir}/report2_pipe"
> > +  local report1_clean=3D"${temp_dir}/report1_pipe.clean"
> > +  local report2_clean=3D"${temp_dir}/report2_pipe.clean"
> > +  local diff_file=3D"${temp_dir}/diff_pipe"
> > +
> > +  perf report -i "${data_clean}" --stdio > "${report1}"
> > +  perf report -i "${data2}" --stdio > "${report2}"
> > +
> > +  # Strip headers and compare lines with percentages
> > +  grep '%' "${report1}" | grep -v '^#' | \
> > +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report1_c=
lean}" || true
> > +  grep '%' "${report2}" | grep -v '^#' | \
> > +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report2_c=
lean}" || true
> > +
> > +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" ||=
 true
> > +
> > +  if [ ! -s "${report1_clean}" ]; then
> > +    echo "Pipe Report ASLR test [Failed - no samples captured]"
> > +    err=3D1
> > +  elif [ -s "${diff_file}" ]; then
> > +    echo "Pipe Report ASLR test [Failed - reports differ]"
> > +    echo "Showing first 20 lines of diff:"
> > +    head -n 20 "${diff_file}"
> > +    err=3D1
> > +  else
> > +    echo "Pipe Report ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_pipe_out_report_aslr() {
> > +  echo "Test pipe output mode perf report consistency"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.pipe_out_report.XXXXXX")
> > +  local data_clean
> > +  data_clean=3D$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> > +
> > +  perf record -e task-clock:u -o "${data}" ${prog}
> > +  perf inject -b -i "${data}" -o "${data_clean}"
> > +
> > +  local report1=3D"${temp_dir}/report1_pipe_out"
> > +  local report2=3D"${temp_dir}/report2_pipe_out"
> > +  local report1_clean=3D"${temp_dir}/report1_pipe_out.clean"
> > +  local report2_clean=3D"${temp_dir}/report2_pipe_out.clean"
> > +  local diff_file=3D"${temp_dir}/diff_pipe_out"
> > +
> > +  perf report -i "${data_clean}" --stdio > "${report1}"
> > +  perf inject -b --aslr -i "${data}" -o - | perf report -i - --stdio >=
 "${report2}"
> > +
> > +  # Strip headers and compare lines with percentages
> > +  grep '%' "${report1}" | grep -v '^#' | \
> > +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report1_c=
lean}" || true
> > +  grep '%' "${report2}" | grep -v '^#' | \
> > +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | sort > "${report2_c=
lean}" || true
> > +
> > +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" ||=
 true
> > +
> > +  if [ ! -s "${report1_clean}" ]; then
> > +    echo "Pipe Output Report ASLR test [Failed - no samples captured]"
> > +    err=3D1
> > +  elif [ -s "${diff_file}" ]; then
> > +    echo "Pipe Output Report ASLR test [Failed - reports differ]"
> > +    echo "Showing first 20 lines of diff:"
> > +    head -n 20 "${diff_file}"
> > +    err=3D1
> > +  else
> > +    echo "Pipe Output Report ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_dropped_samples() {
> > +  echo "Test dropped samples (phys-data)"
> > +  local data
> > +  data=3D$(mktemp "${temp_dir}/perf.data.dropped.XXXXXX")
> > +  local data2
> > +  data2=3D$(mktemp "${temp_dir}/perf.data2.dropped.XXXXXX")
> > +
> > +  # Check if --phys-data is supported by recording a short run
> > +  if ! perf record -e task-clock:u --phys-data -o "${data}" -- sleep 0=
.1 > /dev/null 2>&1; then
> > +    echo "Skipping dropped samples test as --phys-data is not supporte=
d"
> > +    return
> > +  fi
> > +
> > +  perf record -e task-clock:u --phys-data -o "${data}" ${prog}
> > +  perf inject --aslr -i "${data}" -o "${data2}"
> > +
> > +  # Verify that the original file actually contained samples!
> > +  orig_samples=3D$(perf script -i "${data}" | wc -l)
> > +  if [ "$orig_samples" -eq 0 ]; then
> > +    echo "Dropped samples test [Failed - no samples in original file]"
> > +    err=3D1
> > +  else
> > +    # Verify that samples are dropped.
> > +    samples_count=3D$(perf script -i "${data2}" | wc -l)
> > +
> > +    if [ "$samples_count" -gt 0 ]; then
> > +      echo "Dropped samples test [Failed - samples were not dropped]"
> > +      err=3D1
> > +    else
> > +      echo "Dropped samples test [Success]"
> > +    fi
> > +  fi
> > +}
> > +
> > +test_kernel_aslr() {
> > +  echo "Test kernel ASLR remapping"
> > +  local kdata
> > +  kdata=3D$(mktemp "${temp_dir}/perf.data.kernel.XXXXXX")
> > +  local kdata2
> > +  kdata2=3D$(mktemp "${temp_dir}/perf.data2.kernel.XXXXXX")
> > +  local log_file
> > +  log_file=3D$(mktemp "${temp_dir}/kernel_record.log.XXXXXX")
> > +
> > +  # Try to record kernel samples
> > +  if ! perf record -e task-clock:k -o "${kdata}" ${kprog} > "${log_fil=
e}" 2>&1; then
> > +    echo "Skipping kernel ASLR test as recording failed (maybe no perm=
issions)"
> > +    return
> > +  fi
> > +
> > +  # Check for warning about kernel map restriction
> > +  if grep -q "Couldn't record kernel reference relocation symbol" "${l=
og_file}"; then
> > +    echo "Skipping kernel ASLR test as kernel map could not be recorde=
d (permissions restricted)"
> > +    return
> > +  fi
> > +
> > +  perf inject -v --aslr -i "${kdata}" -o "${kdata2}"
> > +
> > +  # Check if kernel addresses are remapped.
> > +  # Find the field that ends with :k: (the event name) and take the ne=
xt field!
> > +  orig_addr=3D$(perf script -i "${kdata}" | awk '
> > +    BEGIN { found=3D0 }
> > +    {
> > +      for (i=3D1; i<NF; i++) {
> > +        if ($i ~ /:[k]+:?$/) {
> > +          if (!found) {
> > +            print $(i+1)
> > +            found=3D1
> > +          }
> > +        }
> > +      }
> > +    }')
> > +  new_addr=3D$(perf script -i "${kdata2}" | awk '
> > +    BEGIN { found=3D0 }
> > +    {
> > +      for (i=3D1; i<NF; i++) {
> > +        if ($i ~ /:[k]+:?$/) {
> > +          if (!found) {
> > +            print $(i+1)
> > +            found=3D1
> > +          }
> > +        }
> > +      }
> > +    }')
> > +
> > +  echo "Kernel ASLR: orig_addr=3D$orig_addr, new_addr=3D$new_addr"
> > +
> > +  if [ -z "$orig_addr" ]; then
> > +    echo "Kernel ASLR test [Failed - no kernel samples in original fil=
e]"
> > +    err=3D1
> > +  elif [ -z "$new_addr" ]; then
> > +    echo "Kernel ASLR test [Failed - could not find remapped address]"
> > +    err=3D1
> > +  elif [ "$orig_addr" =3D "$new_addr" ]; then
> > +    echo "Kernel ASLR test [Failed - addresses are not remapped]"
> > +    err=3D1
> > +  else
> > +    echo "Kernel ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_kernel_report_aslr() {
> > +  echo "Test kernel perf report consistency"
> > +  local kdata
> > +  kdata=3D$(mktemp "${temp_dir}/perf.data.kernel_report.XXXXXX")
> > +  local kdata2
> > +  kdata2=3D$(mktemp "${temp_dir}/perf.data2.kernel_report.XXXXXX")
> > +  local data_clean
> > +  data_clean=3D$(mktemp "${temp_dir}/perf.data.clean.XXXXXX")
> > +  local log_file
> > +  log_file=3D$(mktemp "${temp_dir}/kernel_report_record.log.XXXXXX")
> > +
> > +  # Try to record kernel samples
> > +  if ! perf record -e task-clock:k -o "${kdata}" ${kprog} > "${log_fil=
e}" 2>&1; then
> > +    echo "Skipping kernel report test as recording failed (maybe no pe=
rmissions)"
> > +    return
> > +  fi
> > +
> > +  # Check for warning about kernel map restriction
> > +  if grep -q "Couldn't record kernel reference relocation symbol" "${l=
og_file}"; then
> > +    echo "Skipping kernel report test as kernel map could not be recor=
ded (permissions restricted)"
> > +    return
> > +  fi
> > +
> > +  # Use -b to inject build-ids and force ordered events processing in =
both
> > +  perf inject -b -i "${kdata}" -o "${data_clean}"
> > +  perf inject -v -b --aslr -i "${kdata}" -o "${kdata2}"
> > +
> > +  local report1=3D"${temp_dir}/report_kernel1"
> > +  local report2=3D"${temp_dir}/report_kernel2"
> > +  local report1_clean=3D"${temp_dir}/report_kernel1.clean"
> > +  local report2_clean=3D"${temp_dir}/report_kernel2.clean"
> > +
> > +  perf report -i "${data_clean}" --stdio > "${report1}"
> > +  perf report -i "${kdata2}" --stdio > "${report2}"
> > +
> > +  # Strip headers and compare lines with percentages
> > +  grep '%' "${report1}" | grep -v '^#' > "${report1_clean}" || true
> > +  grep '%' "${report2}" | grep -v '^#' > "${report2_clean}" || true
> > +
> > +  # Normalize kernel DSOs and addresses in clean reports
> > +  # This allows kernel modules to be either a module or kernel.kallsym=
s
> > +  local report1_norm=3D"${temp_dir}/report_kernel1.norm"
> > +  local report2_norm=3D"${temp_dir}/report_kernel2.norm"
> > +  local diff_file=3D"${temp_dir}/diff_kernel"
> > +
> > +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report1_clean}" | \
> > +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]",=
 $0); print}' | \
> > +    sort > "${report1_norm}" || true
> > +  grep -v -E '0x[0-9a-f]{8,}|0000000000000000' "${report2_clean}" | \
> > +    awk '{gsub(/\[[a-zA-Z0-9_.-]{2,}\](\.[a-zA-Z0-9_]+)?/, "[kernel]",=
 $0); print}' | \
> > +    sort > "${report2_norm}" || true
> > +
> > +  diff -u -w "${report1_norm}" "${report2_norm}" > "${diff_file}" || t=
rue
> > +
> > +  if [ ! -s "${report1_norm}" ]; then
> > +    echo "Kernel Report ASLR test [Failed - no samples captured]"
> > +    err=3D1
> > +  elif [ -s "${diff_file}" ]; then
> > +    echo "Kernel Report ASLR test [Failed - reports differ]"
> > +    echo "Showing first 20 lines of diff:"
> > +    head -n 20 "${diff_file}"
> > +    err=3D1
> > +  else
> > +    echo "Kernel Report ASLR test [Success]"
> > +  fi
> > +}
> > +
> > +test_regs_stripping() {
> > +  echo "Test user register stripping"
> > +  local rdata=3D"${temp_dir}/perf.data.regs"
> > +  local rdata2=3D"${temp_dir}/perf.data.regs.injected"
> > +  local rdata_clean=3D"${temp_dir}/perf.data.regs.clean"
> > +
> > +  if ! perf record -e cycles:u --user-regs -o "${rdata}" ${prog} > /de=
v/null 2>&1; then
> > +    echo "Skipping user registers test as recording failed (unsupporte=
d flag/platform)"
> > +    return
> > +  fi
> > +
> > +  perf inject -b -i "${rdata}" -o "${rdata_clean}"
> > +  perf inject -v -b --aslr -i "${rdata}" -o "${rdata2}"
> > +
> > +  local report1=3D"${temp_dir}/report_regs1"
> > +  local report2=3D"${temp_dir}/report_regs2"
> > +  local report1_clean=3D"${temp_dir}/report_regs1.clean"
> > +  local report2_clean=3D"${temp_dir}/report_regs2.clean"
> > +  local diff_file=3D"${temp_dir}/diff_regs"
> > +
> > +  perf report -i "${rdata_clean}" --stdio > "${report1}" 2>/dev/null |=
| true
> > +  perf report -i "${rdata2}" --stdio > "${report2}" 2>/dev/null || tru=
e
> > +
> > +  grep '%' "${report1}" | grep -v '^#' | \
> > +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | \
> > +    sort > "${report1_clean}" || true
> > +  grep '%' "${report2}" | grep -v '^#' | \
> > +    grep -v -E '0x[0-9a-f]{8,}|0000000000000000' | \
> > +    sort > "${report2_clean}" || true
> > +
> > +  diff -u -w "${report1_clean}" "${report2_clean}" > "${diff_file}" ||=
 true
> > +
> > +  if [ ! -s "${report1_clean}" ]; then
> > +    echo "User registers stripping test [Failed - profile trace starve=
d/empty]"
> > +    err=3D1
> > +    return
> > +  elif [ -s "${diff_file}" ]; then
> > +    echo "User registers stripping test [Failed - report parsing diffe=
rs]"
> > +    echo "Showing first 20 lines of diff:"
> > +    head -n 20 "${diff_file}"
> > +    err=3D1
> > +    return
> > +  fi
> > +
> > +  local script_dump=3D"${temp_dir}/script_regs_dump"
> > +  perf script -D -i "${rdata2}" > "${script_dump}" 2>/dev/null || true
> > +  if grep -q "user regs:" "${script_dump}"; then
> > +    echo "User registers stripping test [Failed - register dumps still=
 present]"
> > +    err=3D1
> > +  else
> > +    echo "User registers stripping test [Success]"
> > +  fi
> > +}
> > +
> > +test_basic_aslr
> > +test_pipe_aslr
> > +test_callchain_aslr
> > +test_report_aslr
> > +test_pipe_report_aslr
> > +test_pipe_out_report_aslr
> > +test_dropped_samples
> > +test_kernel_aslr
> > +test_kernel_report_aslr
> > +test_regs_stripping
> > +
> > +cleanup ${err}
> > +exit $err
>
