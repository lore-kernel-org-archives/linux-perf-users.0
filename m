Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377041D9359;
	Tue, 26 Nov 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641165; cv=none; b=l7CTdj9EUMcviaU4ndBX7rbG2dqY1a1RHJi6+y4vIoTp1dYP6x7vXZLYtJacinXaXodmDHVbs4lKDPxxUCWSpq4psCef5s8wd8d/MWjlwI7nLsJgrchs0onDYbSeV6lDOGNQWRwUc1xqsQuUWrxCFZ3h5lvgzSJwld668hOTgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641165; c=relaxed/simple;
	bh=NRDBa0+SeI0FL7eFylhvko+OWTwv/c97DOoTCW1x5NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5rCZnixxHFpbNa8BEsK8Jk6fuBq3X+bGzkwPkvks0FP7bkuoiS7YU+wTb5cYsJYgxc5JcIPf1ZKYuIuBT6ESt2oC/ajYcDNFYghTU0/LAmTu3HqqxM4M/JnN0CAFbvVQnCwPzI6RUkAhM7WRp/Oe3Rgg4On+ZVP5raDahSh3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN20c86l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN20c86l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C71C4CECF;
	Tue, 26 Nov 2024 17:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641165;
	bh=NRDBa0+SeI0FL7eFylhvko+OWTwv/c97DOoTCW1x5NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hN20c86lFJhb1jralK10hAtIrLT13Jv5VckYLcvs2YzxZGhx3PbiiQ4fl7G25cdWv
	 pMqc5WZfnfYMRiaF+PO/yowO2X1iYC9v2zEp19lHZwx6wYM1Es1tOlC83qp3+DI/DM
	 sBLEdbY8cmwUjIeZsWe/kAGvS6h59UarwgJm6FMkrUnm6le6F1b+hbsWjIgZW82Qt0
	 Zi3vwG/jQ+IhDTG/M4W/y1VVQnsziCFp1mwjLR9dUGY9vyqgVkdJZ7nAR+ZX9UogYq
	 MsufxjH+Cue0hyxNZCZUYFEPh8RVOn2ohkY+ZEpZCO4bVaxF08Qum4T67WqlKMPZep
	 6AH7m0BxHLGMQ==
Date: Tue, 26 Nov 2024 14:12:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf trace: Add tests for BTF general augmentation
Message-ID: <Z0YBiu9XdstHmjWr@x1>
References: <20241123005512.342079-1-howardchu95@gmail.com>
 <20241123005512.342079-2-howardchu95@gmail.com>
 <Z0X8KJd5LYrgUJUh@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0X8KJd5LYrgUJUh@x1>

On Tue, Nov 26, 2024 at 01:49:44PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Nov 22, 2024 at 04:55:10PM -0800, Howard Chu wrote:
> > Currently, we only have perf trace augmentation tests for enum
> > arguments. This patch adds tests for more general syscall arguments,
> > such as struct pointers, strings, and buffers.
> 
> scripts/checkpatch.pl has some warnings here I think we can address
> easily, some not so much, like the SPDX that we need to add logic to
> 'perf test' to noticed its the SPDX and skip it, looking at the next
> line for the test description.
> 
> 
> The long lines we can just make them multiple lines with the first ones
> ending in \

And while testing it with -vv:

root@number:~# perf test -vv btf
110: perf trace BTF general tests:
--- start ---
test child forked, pid 242944
Testing perf trace's string augmentation
grep: warning: stray \ before /
Testing perf trace's buffer augmentation
grep: warning: stray \ before /
Testing perf trace's struct augmentation
grep: warning: stray \ before /
---- end(0) ----
110: perf trace BTF general tests                                    : Ok
root@number:~#

The long lines can be solved like:

+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -17,7 +17,8 @@ trap cleanup EXIT TERM INT HUP
 
 trace_test_string() {
   echo "Testing perf trace's string augmentation"
-  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ renameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${file2}\", flags: .*\) += +[0-9]+$"
+  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | \
+     grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ renameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${file2}\", flags: .*\) += +[0-9]+$"
   then
     echo "String augmentation test failed"
     err=1

And that " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ : +"

part is common to several such greps, so you could have it as:

prefix=" +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ : +"

And then use

grep -q -E "%{prefix}mv\/[0-9]+ renameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${file2}\", flags: .*\) += +[0-9]+$"

Or, since this part isn't interesting for what this test checks, BPF
augmentation, we could make it all more compact, i.e.:

From the default that is:

root@number:~# rm -f before after ; touch before ; perf trace -e renameat2 mv before after
     0.000 ( 0.037 ms): mv/243278 renameat2(olddfd: CWD, oldname: "before", newdfd: CWD, newname: "after", flags: NOREPLACE) = 0
root@number:~# 

We point perf to a temporary config file, using mktemp, then tell it to
not output the stuff we don't need while test BPF augmentation, making
the output more compact and thus the regexps in the perf test shorter.

With this we also test setting the "PERF_CONFIG" environment variable
and, 'perf config' and 'perf trace' output customization code:

root@number:~# export PERF_CONFIG=my-tmp-perf-config
root@number:~# perf config trace.show_arg_names=false
root@number:~# cat my-tmp-perf-config 
# this file is auto-generated.
[trace]
	show_arg_names = false
root@number:~# rm -f before after ; touch before ; perf trace -e renameat2 mv before after
     0.000 ( 0.032 ms): :243836/243836 renameat2(CWD, "before", CWD, "after", NOREPLACE)                     = 0
root@number:~# perf config trace.show_duration=false
root@number:~# rm -f before after ; touch before ; perf trace -e renameat2 mv before after
     0.000 mv/243871 renameat2(CWD, "before", CWD, "after", NOREPLACE)                     = 0
root@number:~# perf config trace.show_timestamp=false
root@number:~# rm -f before after ; touch before ; perf trace -e renameat2 mv before after
:243888/243888 renameat2(CWD, "before", CWD, "after", NOREPLACE)                     = 0
root@number:~# perf config trace.args_alignment=0
root@number:~# rm -f before after ; touch before ; perf trace -e renameat2 mv before after
mv/243925 renameat2(CWD, "before", CWD, "after", NOREPLACE) = 0
root@number:~# cat my-tmp-perf-config 
# this file is auto-generated.
[trace]
	show_arg_names = false
	show_duration = false
	show_timestamp = false
	args_alignment = 0
root@number:~#  
> 
> ⬢ [acme@toolbox perf-tools-next]$ rm -f 0001-* ; git format-patch --no-cover-letter HEAD~ ; scripts/checkpatch.pl 0001-*
> 0001-perf-trace-Add-tests-for-BTF-general-augmentation.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #31: 
> new file mode 100755
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 2
> #37: FILE: tools/perf/tests/shell/trace_btf_general.sh:2:
> +# perf trace BTF general tests
> 
> WARNING: Misplaced SPDX-License-Identifier tag - use line 2 instead
> #38: FILE: tools/perf/tests/shell/trace_btf_general.sh:3:
> +# SPDX-License-Identifier: GPL-2.0
> 
> WARNING: line length of 252 exceeds 100 columns
> #55: FILE: tools/perf/tests/shell/trace_btf_general.sh:20:
> +  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ renameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${file2}\", flags: .*\) += +[0-9]+$"
> 
> WARNING: line length of 203 exceeds 100 columns
> #65: FILE: tools/perf/tests/shell/trace_btf_general.sh:30:
> +  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +echo\/[0-9]+ write\(fd: [0-9]+, buf: ${buffer}.*, count: [0-9]+\) += +[0-9]+$"
> 
> WARNING: line length of 275 exceeds 100 columns
> #74: FILE: tools/perf/tests/shell/trace_btf_general.sh:39:
> +  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +sleep\/[0-9]+ clock_nanosleep\(rqtp: \(struct __kernel_timespec\)\{\.tv_sec = \(__kernel_time64_t\)1,\}, rmtp: 0x[0-9a-f]+\) += +[0-9]+$"
> 
> total: 0 errors, 6 warnings, 68 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0001-perf-trace-Add-tests-for-BTF-general-augmentation.patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> ⬢ [acme@toolbox perf-tools-next]$
> 
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/tests/shell/trace_btf_general.sh | 68 +++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
> > 
> > diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> > new file mode 100755
> > index 000000000000..7bcca81a40d8
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/trace_btf_general.sh
> > @@ -0,0 +1,68 @@
> > +#!/bin/bash
> > +# perf trace BTF general tests
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +err=0
> > +set -e
> > +
> > +. "$(dirname $0)"/lib/probe.sh
> > +skip_if_no_perf_trace || exit 2
> > +
> > +file1=$(mktemp /tmp/file1_XXXXX)
> > +file2=$(echo $file1 | sed 's/file1/file2/g')
> > +
> > +buffer="the content of the buffer"
> > +
> > +trap cleanup EXIT TERM INT HUP
> > +
> > +trace_test_string() {
> > +  echo "Testing perf trace's string augmentation"
> > +  if ! perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ renameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${file2}\", flags: .*\) += +[0-9]+$"
> > +  then
> > +    echo "String augmentation test failed"
> > +    err=1
> > +  fi
> > +}
> > +
> > +trace_test_buffer() {
> > +  echo "Testing perf trace's buffer augmentation"
> > +  # echo will insert a newline (\10) at the end of the buffer
> > +  if ! perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +echo\/[0-9]+ write\(fd: [0-9]+, buf: ${buffer}.*, count: [0-9]+\) += +[0-9]+$"
> > +  then
> > +    echo "Buffer augmentation test failed"
> > +    err=1
> > +  fi
> > +}
> > +
> > +trace_test_struct_btf() {
> > +  echo "Testing perf trace's struct augmentation"
> > +  if ! perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +sleep\/[0-9]+ clock_nanosleep\(rqtp: \(struct __kernel_timespec\)\{\.tv_sec = \(__kernel_time64_t\)1,\}, rmtp: 0x[0-9a-f]+\) += +[0-9]+$"
> > +  then
> > +    echo "BTF struct augmentation test failed"
> > +    err=1
> > +  fi
> > +}
> > +
> > +cleanup() {
> > +	rm -rf ${file1} ${file2}
> > +}
> > +
> > +trap_cleanup() {
> > +	echo "Unexpected signal in ${FUNCNAME[1]}"
> > +	cleanup
> > +	exit 1
> > +}
> > +
> > +trace_test_string
> > +
> > +if [ $err = 0 ]; then
> > +  trace_test_buffer
> > +fi
> > +
> > +if [ $err = 0 ]; then
> > +  trace_test_struct_btf
> > +fi
> > +
> > +cleanup
> > +
> > +exit $err
> > -- 
> > 2.43.0
