Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235203AFD08
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203597; cv=pass; b=PukOLJYYP+Gl860WwhvglyhzKaVIzVYoMqwVbXURbYEBp91fy3+iJHxI+oOrrCyuuTKYQTfRF6wbzRrAyDn8LdCNXva1686HB7f9+NlMSNEz+QkpEZ6GDkENOMRPA9aYJmanrAffrE3qRJ/3AxdKYz0VRhgpyeRbjbhEBY16yno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203597; c=relaxed/simple;
	bh=/p2fqSnG+A3lNRM5kuYsjWJBWwp+PN6tLkZ0LbeLkcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahalNu0SddSPZ2q1Rr6OjjPMqK1/mBInIzQzKZ73cIpVR6r37/iTYFbbLfUhYyqLn70I/PJXKTHAco8gJLRdTdBLX3gfpf76+B2T/OGIaKZmQ5+QDywMmZ2RRUbhXek28R0J2nPyp1RMylO7TZ4PykR+dV4+cnvY727nSsUi5aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ut3yFVOx; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ut3yFVOx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba180a022dso1225ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779203595; cv=none;
        d=google.com; s=arc-20240605;
        b=lHDLAbtZKchaGPGCk30wPZUjbtreA4dzfqhfWGCQ9Chv0AS23XXHEfWoXM1NLchWOM
         +xIQPExYUHOmdqaD64VNiVbWM+GWPqGTXW9DejV7mkOQCC4jTrKUSxZgJQN8TTNbBXcL
         XrsmwLWNOAs4fZ8jmORUclFX9SE5MkYYUDJq6ZlQVlermtbAKccS9Yi29TX3bhemVkEk
         vKVMiU0FIhWuvGfd0qaMFQfQuhjneorLxHkbC7KXHQvE46xwhWfkjALvxVySbQls/BnL
         IyqAH+9/clrWMnOEW3IgBEErEG6LFWpJf7h1Q/Y+piqLksUO+tf9xnBthnGioBz9A78g
         FwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhiD4R8AoCi+9dmAZE6/ehuwBQ9Po674oyIxWJtzeGs=;
        fh=UTYTaWGHESjq6y+O7afVfUd5alD7hs+iiAkthq9j0Gw=;
        b=ETNmiw4qhaqwWzNL95iR27E2h3AG1zKhUT6qJJnz+wbxIVNxkJ5Et6TvRFvsaWEWUC
         02lh5lICyFUCsenN5l7LnojZuxMvtpRb0vsvhXaIhc4JWatTebJFmilRUhfm6OxDdSfR
         IIZzhlHX0XRVvEDKRIBQMUcjqy1JLejAPQpHkVA1v7sqTfQPur03t+jk5qs/1y7oIKQq
         R5L0vJCRVsc1xLU8AqmCUbFvaHlIEq8Ng6Wmq2vTUlsTJvXVsMPOolvYDwBP3kqNK+2K
         MTAPQd3FCN7vrlHYMVj0vDzxWp3R0t/uvTi/KBxfZybuiCCLTHflVgfxbn2fFQ/Fk3Ds
         XwzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203595; x=1779808395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhiD4R8AoCi+9dmAZE6/ehuwBQ9Po674oyIxWJtzeGs=;
        b=Ut3yFVOxjaTTGE97ROq9qzcN2nehrFtcW1VfvW3g+amSCLLuv+wHcZXgDWFq26d/0D
         YUmAtYIk3w1G3Ne4UW+tl13AI4Rku4zTlKfYYTzlNy4tQHjZkIUaZ3Va0yIvznHRxEYM
         zmvwddJXWt6KsPTjkUEjlEZAGAXrRohAUX3tY9+1MB0V0khNJd0fTbg2ToECC17KDFFM
         MwVtQqK79IUdUCBbXvQCECkg0bQuO+wmzpRnrWpucnOZVAaEySXsiyMKYuBlkHhs57Vy
         xsesH7K6VlLY5vlqV/CoYRdAb9g3uy06uqqTWc+JT4i521rY4cbYuMiBxSEyAl+8yPGX
         wheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203595; x=1779808395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhiD4R8AoCi+9dmAZE6/ehuwBQ9Po674oyIxWJtzeGs=;
        b=D7/cJEd+2nLwyQIHuFoPC9XcBxfsLAKMtIMGjQ84RXpeCNpWndmY4kpfjVe1MZurBO
         S7zk4JDSCaQP2ChT5A21OVLQgbNioKciDZxHbRpLoXTBMlq04gwBDtBrS7twEdcWG+GD
         9noVFWo2DkIMTSmhLWUWntPU951zCsnJujLH9XSfVco0l13qpkWfDjK1+GBz2pY1lYCQ
         Dt08Eu+/f5kmoLw+e03N1KRrRgamV8oPdu4jJw9A3AimtEEXjzOONR6ltbGpAyeymicq
         XdYOwinL3AkG6abZOxbUdGJy0D6kPITpY56mDiQ+mUzaoxOkSGTXIhj1V6tGSflvVN31
         wPZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wdH7dJ1e/sshUW1ShC2NLuIfhTlzRfJCRsnUqBzToiLAtTfRhjxFjRwzoAqOWk7KkNJB18ZVX/hu4BDcSdvMP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uDbfq6sCQhq/oSy4UWLbH+AcAAR0kDaVi68PnPc3sBHB5H9p
	w5mILdVR0LSIATWCuuWODaRxjo+yd8pLADIkIQ0jsaCAilNRdnJqKxpwzp4kvv9chwV8AZXNSqP
	aiciy9JZKaC2/mSI6kbanueJ01pusFI5UwWhEpLwM
X-Gm-Gg: Acq92OGIq3s+I0rmVHIyUlDm7vpidDapuUd1riD+Wf4J1ZwpXchWU2mdXfd3QpE6dtY
	QF0O380IrhMnDojAaRXDu75IXnyekVRyN+oKB0DX1tJITykd3PDBMm3I4o0PVuNIpCT8JZYNSqR
	iamTNORzG0f6hmrM3ra1/fZ+WPkzXfXhGHEHBgxaBPjt/Rv2p6tKXvFT6fUFQYM4cBxN3LBbxyG
	qbh8CTIxI4medFsytG8SIJhA9FHmbZPnZ6dxcMSr89a6zNOTIAdyx4qK5pYn4Wt3SPz43wR1ixi
	+J3dnw4zV5MjXC6K9fMOQcdGgIEkPNX+PDw+p8spV5hSOg0f
X-Received: by 2002:a17:902:ce85:b0:2a9:5ef5:399b with SMTP id
 d9443c01a7336-2bdb32bcb70mr6298275ad.19.1779203594833; Tue, 19 May 2026
 08:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519015108.3094513-1-irogers@google.com> <20260519050150.3144907-1-irogers@google.com>
 <20260519050150.3144907-3-irogers@google.com> <agv7MMF7AEc_mdCN@z2>
In-Reply-To: <agv7MMF7AEc_mdCN@z2>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 08:13:02 -0700
X-Gm-Features: AVHnY4K94uG-IlnsYNQr9DWLu3fiSms8oDBtJZiuPJSp1KJjdA9x72-S4Npi_4M
Message-ID: <CAP-5=fW14n=Po5fOv7nOTUoz2_W0uxU34h5V4uGX2agKqiLT9A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf test: Add stat metrics --for-each-cgroup test
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	skanev@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 10:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, May 18, 2026 at 10:01:50PM -0700, Ian Rogers wrote:
> > Add a new shell test `stat_metrics_cgrp.sh` to verify metric reporting
> > with `--for-each-cgroup`, both with and without `--bpf-counters`.
> >
> > The test:
> > - Checks if system-wide monitoring is supported (skips if not).
> > - Finds cgroups to test.
> > - Runs `perf stat` with `insn_per_cycle` metric and verifies that the
> >   metric is reported for each cgroup and does not contain invalid
> >   values (like `nan` or `nested`) or empty values when counts are
> >   present.
> > - Tests both standard mode and BPF counters mode (if supported).
> >
> > Assisted-by: Antigravity:gemini-3-flash
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/stat_metrics_cgrp.sh | 174 ++++++++++++++++++++
> >  1 file changed, 174 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh
> >
> > diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/t=
ests/shell/stat_metrics_cgrp.sh
> > new file mode 100755
> > index 000000000000..b413849193a0
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
> > @@ -0,0 +1,174 @@
> > +#!/bin/bash
> > +# perf stat metrics --for-each-cgroup test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +
> > +test_cgroups=3D
> > +
> > +log_verbose() {
> > +     echo "$1"
> > +}
>
> Why is this function used?

At some point I'd like verbose flags to be passed to tests to cut down
on output. A suitable series would be the test improvements in:
https://lore.kernel.org/linux-perf-users/20260513230450.529380-1-irogers@go=
ogle.com/

> > +
> > +is_numeric_and_non_zero() {
> > +     local val=3D"$1"
> > +     if [[ "${val}" =3D~ ^[0-9]+$ ]] && [ "${val}" -gt 0 ]
> > +     then
> > +             return 0 # True
> > +     fi
> > +     return 1 # False
> > +}
> > +
> > +# skip if system-wide is not supported
> > +check_system_wide()
> > +{
> > +     log_verbose "Checking system-wide..."
> > +     if ! perf stat -a --metrics=3Dinsn_per_cycle sleep 0.01 > /dev/nu=
ll 2>&1
> > +     then
> > +             log_verbose "Skipping: system-wide monitoring not support=
ed"
> > +             exit 2
> > +     fi
> > +}
> > +
> > +# find two cgroups to measure
> > +find_cgroups()
> > +{
> > +     log_verbose "Finding cgroups..."
> > +     # try usual systemd slices first
> > +     if [ -d /sys/fs/cgroup/system.slice ] && [ -d /sys/fs/cgroup/user=
.slice ]
> > +     then
> > +             test_cgroups=3D"system.slice,user.slice"
> > +             log_verbose "Found cgroups: ${test_cgroups}"
> > +             return
> > +     fi
> > +
> > +     # try root and self cgroups
> > +     find_cgroups_self_cgrp=3D$(grep perf_event /proc/self/cgroup | cu=
t -d: -f3)
> > +     if [ -z "${find_cgroups_self_cgrp}" ]
> > +     then
> > +             # cgroup v2 doesn't specify perf_event
> > +             find_cgroups_self_cgrp=3D$(grep ^0: /proc/self/cgroup | c=
ut -d: -f3)
> > +     fi
> > +
> > +     if [ -z "${find_cgroups_self_cgrp}" ]
> > +     then
> > +             test_cgroups=3D"/"
> > +     else
> > +             test_cgroups=3D"/,${find_cgroups_self_cgrp}"
> > +     fi
> > +     log_verbose "Found cgroups: ${test_cgroups}"
> > +}
> > +
> > +# Check if metric is reported for each cgroup
> > +# $1: extra options (e.g. --bpf-counters)
> > +check_metric_reported()
> > +{
> > +     local opts=3D"$1"
> > +     local output
> > +
> > +     log_verbose "Running check_metric_reported with opts '${opts}'...=
"
> > +     # Run perf stat
> > +     if ! output=3D$(perf stat -a ${opts} \
> > +                     --metrics=3Dinsn_per_cycle \
> > +                     --for-each-cgroup "${test_cgroups}" \
> > +                     -x, sleep 0.1 2>&1)
> > +     then
> > +             echo "FAIL: perf stat failed with exit code $?"
> > +             echo "Output: ${output}"
> > +             exit 1
> > +     fi
> > +
> > +     log_verbose "perf stat output:"
> > +     log_verbose "${output}"
> > +
> > +     # Split test_cgroups by comma
> > +     IFS=3D',' read -r -a cgrps <<< "${test_cgroups}"
> > +
> > +     for cgrp in "${cgrps[@]}"; do
> > +             # Find metric lines for this cgroup
> > +             # We use exact cgroup match with surrounding commas
> > +             local cgrp_lines
> > +             cgrp_lines=3D$(echo "${output}" | grep -F ",${cgrp}," | g=
rep "insn_per_cycle" || true)
> > +
> > +             if [ -z "${cgrp_lines}" ]
> > +             then
> > +                     echo "FAIL: No metric lines found for cgroup '${c=
grp}'"
> > +                     exit 1
> > +             fi
> > +
> > +             # Parse each metric line
> > +             while read -r line; do
> > +                     [ -z "${line}" ] && continue
> > +
> > +                     local cycles_val
> > +                     cycles_val=3D$(echo "${line}" | cut -d, -f1)
> > +
> > +                     local event_name
> > +                     event_name=3D$(echo "${line}" | cut -d, -f3)
> > +
> > +                     # Find corresponding instructions event line
> > +                     local inst_event_name
> > +                     inst_event_name=3D"${event_name/cpu-cycles/instru=
ctions}"
> > +                     inst_event_name=3D"${inst_event_name/cycles/instr=
uctions}"
> > +
> > +                     local inst_line
> > +                     inst_line=3D$(echo "${output}" | \
> > +                             grep -F ",${cgrp}," | \
> > +                             grep -F "${inst_event_name}" || true)
> > +
> > +                     local inst_val
> > +                     inst_val=3D$(echo "${inst_line}" | cut -d, -f1)
> > +
> > +                     log_verbose "Cgroup '${cgrp}': event '${event_nam=
e}' \
> > +val '${cycles_val}', inst event '${inst_event_name}' val '${inst_val}'=
"
>
> Why not make log_verbose() take multiple arguments and align them
> properly?  Maybe you can just use 'echo'?  The same goes to the below
> lines.

This fixes checkpatch warnings on line length and the odd alignment
avoids spaces appearing in the output.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> > +                     # Only enforce metric check if both cycles and
> > +                     # instructions have non-zero numeric counts
> > +                     if is_numeric_and_non_zero "${cycles_val}" && \
> > +                        is_numeric_and_non_zero "${inst_val}"
> > +                     then
> > +                             log_verbose "Enforcing metric check for c=
group '${cgrp}' \
> > +event '${event_name}'"
> > +                             # Check for nan or nested in the metric v=
alue (7th field)
> > +                             # Actually we can just check the whole li=
ne for simplicity
> > +                             if echo "${line}" | grep -q -i -E ",nan,|=
,nested,"
> > +                             then
> > +                                     echo "FAIL: Invalid metric value =
(nan/nested) \
> > +for cgroup '${cgrp}'"
> > +                                     echo "Line: ${line}"
> > +                                     exit 1
> > +                             fi
> > +                             # Check for empty metric value (2 consecu=
tive
> > +                             # commas before the unit)
> > +                             if echo "${line}" | grep -q -E ",,[[:spac=
e:]]*[^,]*insn_per_cycle"
> > +                             then
> > +                                     echo "FAIL: Empty metric value fo=
r cgroup '${cgrp}'"
> > +                                     echo "Line: ${line}"
> > +                                     exit 1
> > +                             fi
> > +                     else
> > +                             log_verbose "Skipping metric check for cg=
roup '${cgrp}' \
> > +event '${event_name}' (idle or not counted)"
> > +                     fi
> > +             done <<< "${cgrp_lines}"
> > +     done
> > +     log_verbose "check_metric_reported passed for opts '${opts}'"
> > +}
> > +
> > +check_system_wide
> > +find_cgroups
> > +
> > +# Test 1: Without BPF counters
> > +check_metric_reported ""
> > +
> > +# Test 2: With BPF counters (if supported)
> > +log_verbose "Checking BPF support..."
> > +if perf stat -a --bpf-counters --for-each-cgroup / true > /dev/null 2>=
&1
> > +then
> > +     log_verbose "BPF supported, running Test 2..."
> > +     check_metric_reported "--bpf-counters"
> > +else
> > +     log_verbose "BPF not supported, skipping Test 2"
> > +fi
> > +
> > +exit 0
> > --
> > 2.54.0.631.ge1b05301d1-goog
> >
