Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116F4409138;
	Tue, 19 May 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210600; cv=none; b=FKENegV0qokI12LQ6UdKZ1WQu25Lb050ddbxlxssnCn7cIQ2rxzKu1VBnPyYa5f7HrM+X9uHXGyxSu8LDCwLhdjExCLS92zueXl8LgUeVPqtCh5Bix0cGthF0Y3Ijuc4syaD48s8YsqgIU++ewRZ2luE3I6jR9spWOiRumSKJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210600; c=relaxed/simple;
	bh=cH48j899rggXYmFrBm7pWOUFwboYW9R5LuW0RM4NZyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AitvS/Ad+GS0dT9JYy4tUqA4BnXpGiM7MORvcGP8Pcv+R4bzDePrNbspD3QWVKgF1u1SO3R3hamIe/g5sAX65u+THo/ocNzAOWuzsR1nU4jmO9IVoX5Bv6NAwTmjQsiM1XnXhgqqH1PkrD578dBNodKz01NJZP+jKDXv3lDH8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AebZikOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AebZikOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB50C2BCB3;
	Tue, 19 May 2026 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779210599;
	bh=cH48j899rggXYmFrBm7pWOUFwboYW9R5LuW0RM4NZyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AebZikOYAbyK22aXpr+l8hAXEaMTuj2kQSmnQNE7rrYdlTzJSg+BD1U/1rYxOhBqu
	 NZThEdridCV64KBdc5HlPkvTKfHz+fnd7UBnuupi5oaE9KO912Na8QebCmhcmvxfET
	 bQ+8RYEROTx0smEz2nbYxdKpQ/CD54UKQqOypKW2LFIyGlOpeElZxmXw0Yr7J4vcYP
	 2mzfjtOYPp3SsEbqmwDXi3AnALGRychX6cAoOlitoaXOhZNk1E9bOoTaZTX3O5xVyx
	 6E6nPFOmntBUWpN2CjDD3P6U2FeIYkV82qGKE6XBOHBm23Bj1lFn46vK8rowke4kFF
	 OtJgLLMqDOciw==
Date: Tue, 19 May 2026 10:09:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, skanev@google.com
Subject: Re: [PATCH v3 2/2] perf test: Add stat metrics --for-each-cgroup test
Message-ID: <agyZZdFQqedToej1@google.com>
References: <20260519015108.3094513-1-irogers@google.com>
 <20260519050150.3144907-1-irogers@google.com>
 <20260519050150.3144907-3-irogers@google.com>
 <agv7MMF7AEc_mdCN@z2>
 <CAP-5=fW14n=Po5fOv7nOTUoz2_W0uxU34h5V4uGX2agKqiLT9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW14n=Po5fOv7nOTUoz2_W0uxU34h5V4uGX2agKqiLT9A@mail.gmail.com>

On Tue, May 19, 2026 at 08:13:02AM -0700, Ian Rogers wrote:
> On Mon, May 18, 2026 at 10:54 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, May 18, 2026 at 10:01:50PM -0700, Ian Rogers wrote:
> > > Add a new shell test `stat_metrics_cgrp.sh` to verify metric reporting
> > > with `--for-each-cgroup`, both with and without `--bpf-counters`.
> > >
> > > The test:
> > > - Checks if system-wide monitoring is supported (skips if not).
> > > - Finds cgroups to test.
> > > - Runs `perf stat` with `insn_per_cycle` metric and verifies that the
> > >   metric is reported for each cgroup and does not contain invalid
> > >   values (like `nan` or `nested`) or empty values when counts are
> > >   present.
> > > - Tests both standard mode and BPF counters mode (if supported).
> > >
> > > Assisted-by: Antigravity:gemini-3-flash
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/shell/stat_metrics_cgrp.sh | 174 ++++++++++++++++++++
> > >  1 file changed, 174 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh
> > >
> > > diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
> > > new file mode 100755
> > > index 000000000000..b413849193a0
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
> > > @@ -0,0 +1,174 @@
> > > +#!/bin/bash
> > > +# perf stat metrics --for-each-cgroup test
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +set -e
> > > +
> > > +test_cgroups=
> > > +
> > > +log_verbose() {
> > > +     echo "$1"
> > > +}
> >
> > Why is this function used?
> 
> At some point I'd like verbose flags to be passed to tests to cut down
> on output. A suitable series would be the test improvements in:
> https://lore.kernel.org/linux-perf-users/20260513230450.529380-1-irogers@google.com/

I see.

> 
> > > +
> > > +is_numeric_and_non_zero() {
> > > +     local val="$1"
> > > +     if [[ "${val}" =~ ^[0-9]+$ ]] && [ "${val}" -gt 0 ]
> > > +     then
> > > +             return 0 # True
> > > +     fi
> > > +     return 1 # False
> > > +}
> > > +
> > > +# skip if system-wide is not supported
> > > +check_system_wide()
> > > +{
> > > +     log_verbose "Checking system-wide..."
> > > +     if ! perf stat -a --metrics=insn_per_cycle sleep 0.01 > /dev/null 2>&1
> > > +     then
> > > +             log_verbose "Skipping: system-wide monitoring not supported"
> > > +             exit 2
> > > +     fi
> > > +}
> > > +
> > > +# find two cgroups to measure
> > > +find_cgroups()
> > > +{
> > > +     log_verbose "Finding cgroups..."
> > > +     # try usual systemd slices first
> > > +     if [ -d /sys/fs/cgroup/system.slice ] && [ -d /sys/fs/cgroup/user.slice ]
> > > +     then
> > > +             test_cgroups="system.slice,user.slice"
> > > +             log_verbose "Found cgroups: ${test_cgroups}"
> > > +             return
> > > +     fi
> > > +
> > > +     # try root and self cgroups
> > > +     find_cgroups_self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
> > > +     if [ -z "${find_cgroups_self_cgrp}" ]
> > > +     then
> > > +             # cgroup v2 doesn't specify perf_event
> > > +             find_cgroups_self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
> > > +     fi
> > > +
> > > +     if [ -z "${find_cgroups_self_cgrp}" ]
> > > +     then
> > > +             test_cgroups="/"
> > > +     else
> > > +             test_cgroups="/,${find_cgroups_self_cgrp}"
> > > +     fi
> > > +     log_verbose "Found cgroups: ${test_cgroups}"
> > > +}
> > > +
> > > +# Check if metric is reported for each cgroup
> > > +# $1: extra options (e.g. --bpf-counters)
> > > +check_metric_reported()
> > > +{
> > > +     local opts="$1"
> > > +     local output
> > > +
> > > +     log_verbose "Running check_metric_reported with opts '${opts}'..."
> > > +     # Run perf stat
> > > +     if ! output=$(perf stat -a ${opts} \
> > > +                     --metrics=insn_per_cycle \
> > > +                     --for-each-cgroup "${test_cgroups}" \
> > > +                     -x, sleep 0.1 2>&1)
> > > +     then
> > > +             echo "FAIL: perf stat failed with exit code $?"
> > > +             echo "Output: ${output}"
> > > +             exit 1
> > > +     fi
> > > +
> > > +     log_verbose "perf stat output:"
> > > +     log_verbose "${output}"
> > > +
> > > +     # Split test_cgroups by comma
> > > +     IFS=',' read -r -a cgrps <<< "${test_cgroups}"
> > > +
> > > +     for cgrp in "${cgrps[@]}"; do
> > > +             # Find metric lines for this cgroup
> > > +             # We use exact cgroup match with surrounding commas
> > > +             local cgrp_lines
> > > +             cgrp_lines=$(echo "${output}" | grep -F ",${cgrp}," | grep "insn_per_cycle" || true)
> > > +
> > > +             if [ -z "${cgrp_lines}" ]
> > > +             then
> > > +                     echo "FAIL: No metric lines found for cgroup '${cgrp}'"
> > > +                     exit 1
> > > +             fi
> > > +
> > > +             # Parse each metric line
> > > +             while read -r line; do
> > > +                     [ -z "${line}" ] && continue
> > > +
> > > +                     local cycles_val
> > > +                     cycles_val=$(echo "${line}" | cut -d, -f1)
> > > +
> > > +                     local event_name
> > > +                     event_name=$(echo "${line}" | cut -d, -f3)
> > > +
> > > +                     # Find corresponding instructions event line
> > > +                     local inst_event_name
> > > +                     inst_event_name="${event_name/cpu-cycles/instructions}"
> > > +                     inst_event_name="${inst_event_name/cycles/instructions}"
> > > +
> > > +                     local inst_line
> > > +                     inst_line=$(echo "${output}" | \
> > > +                             grep -F ",${cgrp}," | \
> > > +                             grep -F "${inst_event_name}" || true)
> > > +
> > > +                     local inst_val
> > > +                     inst_val=$(echo "${inst_line}" | cut -d, -f1)
> > > +
> > > +                     log_verbose "Cgroup '${cgrp}': event '${event_name}' \
> > > +val '${cycles_val}', inst event '${inst_event_name}' val '${inst_val}'"
> >
> > Why not make log_verbose() take multiple arguments and align them
> > properly?  Maybe you can just use 'echo'?  The same goes to the below
> > lines.
> 
> This fixes checkpatch warnings on line length and the odd alignment
> avoids spaces appearing in the output.

How about this?

Thanks,
Namhyung


diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
index d4226ee0ae9801cb..ecb2c053ea5158d4 100755
--- a/tools/perf/tests/shell/stat_metrics_cgrp.sh
+++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
@@ -7,7 +7,7 @@ set -e
 test_cgroups=
 
 log_verbose() {
-	echo "$1"
+	echo "$*"
 }
 
 is_numeric_and_non_zero() {
@@ -145,22 +145,22 @@ check_metric_reported()
 				cycles_val=$(echo "${cycles_line}" | cut -d, -f1)
 			fi
 
-			log_verbose "Cgroup '${cgrp}': event '${event_name}' \
-val '${cycles_val}', inst val '${inst_val}'"
+			log_verbose "Cgroup '${cgrp}': event '${event_name}'" \
+				    "val '${cycles_val}', inst val '${inst_val}'"
 
 			# Only enforce metric check if both cycles and
 			# instructions have non-zero numeric counts
 			if is_numeric_and_non_zero "${cycles_val}" && \
 			   is_numeric_and_non_zero "${inst_val}"
 			then
-				log_verbose "Enforcing metric check for cgroup '${cgrp}' \
-event '${event_name}'"
+				log_verbose "Enforcing metric check for cgroup '${cgrp}'" \
+					    "event '${event_name}'"
 				# Check for nan or nested in the metric value (7th field)
 				# Actually we can just check the whole line for simplicity
 				if echo "${line}" | grep -q -i -E ",nan,|,nested,"
 				then
-					echo "FAIL: Invalid metric value (nan/nested) \
-for cgroup '${cgrp}'"
+					echo "FAIL: Invalid metric value (nan/nested)" \
+					     "for cgroup '${cgrp}'"
 					echo "Line: ${line}"
 					exit 1
 				fi
@@ -173,8 +173,8 @@ for cgroup '${cgrp}'"
 					exit 1
 				fi
 			else
-				log_verbose "Skipping metric check for cgroup '${cgrp}' \
-event '${event_name}' (idle or not counted)"
+				log_verbose "Skipping metric check for cgroup '${cgrp}'" \
+					    "event '${event_name}' (idle or not counted)"
 			fi
 		done <<< "${cgrp_lines}"
 	done
