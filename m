Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF232417D1;
	Fri, 10 Jul 2026 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727952; cv=none; b=rgTVw1RI/Zf8Sm/QYh6pbIZ2DenLAxdQe8shwn6qlKoPl5m1md6HYEHlJWZoafAujMKlHYoygnLqdqMAq5dgzwDUvz1Mv9XXzpDSGQbNoF3D8FjTFDu9bFRBzrWcZTel14Hz5RRL7k9z8wzZI1i+I45glBYsatZUO4iH6xLD4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727952; c=relaxed/simple;
	bh=WHYYwucTe11dB45s1sZVCa8gttZiZkJRY1wP09y7f90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNVhfqUKA9tC+0nP5/BsTOHarqPcOG9wfcvD0SluIhRJ8Vb1nbhAl58qFpI3jN9k4l1TKm4MNXYFamv439IAVipFcbwc3bMDiVB/w92d4rEc366VAz0MJ+jqOkRIad3oaOJlk2SRyK2PfkkaWCnDt70K7DcyGdFYOiw1iGN031g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pcm+9C2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pcm+9C2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DED1F000E9;
	Fri, 10 Jul 2026 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783727950;
	bh=cvw17waFqhDuQD5ugBaIHJjyIhxrCUcXQ68EElDLgTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pcm+9C2HHrP+VOD8fHipCvwwb1q2+A2l2hKimALC/Ky0yyodztKMB1A9bdlzPgbZF
	 /Y/bJZb0mNUN90DuFqyyV16BGyY+ooCTmHzSG5Myq3gXgOPfMRr93GVmkyyK6joHpy
	 gqQAonSKgn/2JOFMDUBNcrUkclM85+76p0URjJQzrEptcBcy7zutnE7x24xLMKQPVp
	 /Fe/qAw43mRX0xSz4b34tSPv2FSaQbhv5jHx2/39xX2+H6vjIhHhNtXELOVhMKx4UZ
	 GXejZFsVws9Qw3V2d8twBasQIP0VPQD1hxQjhGTEZgc+m/QTVYlxQP8D6pdiyk8Dgt
	 x2cIBPadSqUGg==
Date: Fri, 10 Jul 2026 16:59:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 4/4] perf test: Update test for --for-each-cgroup
 option
Message-ID: <alGHTR25xLliMEUJ@google.com>
References: <20260710234143.1934263-1-namhyung@kernel.org>
 <20260710234143.1934263-4-namhyung@kernel.org>
 <20260710235200.CD3001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710235200.CD3001F000E9@smtp.kernel.org>

On Fri, Jul 10, 2026 at 11:52:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The `check_evlist_expand()` test fails to exercise the bug it intends to verify because it specifies `-e cpu-clock`.
> - [Medium] Bash pipeline semantics mask `perf stat` command failures, potentially causing false test passes.
> --
> 
> --- Patch [4]: [PATCH v2 4/4] perf test: Update test for --for-each-cgroup option ---
> commit b42b21fdf494fb61acde3f563ac29e9b49df9327
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf test: Update test for --for-each-cgroup option
> 
> This commit updates the stat_bpf_counters_cgrp.sh test to simply check the
> number of output lines with and without the --for-each-cgroup option.
> 
> > diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> > index ff2e06c408bc6..17b17b112169c 100755
> > --- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> > +++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> [ ... ]
> > @@ -58,9 +58,24 @@ check_system_wide_counted()
> >  	fi
> >  }
> >  
> > +# Missing flags in evlist__clone() resulted in different output.
> > +# Just check the number of output lines for simple verification.
> > +check_evlist_expand()
> > +{
> > +	normal_output=$(perf stat -a -e cpu-clock -x, true 2>&1 | wc -l)
> > +	expand_output=$(perf stat -a -e cpu-clock -x, --bpf-counters --for-each-cgroup / true 2>&1 | wc -l)
> 
> [Severity: Medium]
> Will this actually test the bug with evlist__clone() missing flags?
> 
> By specifying -e cpu-clock, the loading of default events is disabled,
> meaning default_metricgroup and default_show_events are false. This prevents
> the duplication bug from occurring during evsel__clone(), rendering the test
> ineffective at catching the regression it was meant to verify.

Oops, that's right.  It should have this on top.

Thanks,
Namhyung


diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index 17b17b112169c8ba..febe3af0644157f3 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -62,8 +62,8 @@ check_system_wide_counted()
 # Just check the number of output lines for simple verification.
 check_evlist_expand()
 {
-       normal_output=$(perf stat -a -e cpu-clock -x, true 2>&1 | wc -l)
-       expand_output=$(perf stat -a -e cpu-clock -x, --bpf-counters --for-each-cgroup / true 2>&1 | wc -l)
+       normal_output=$(perf stat -a -x, true 2>&1 | wc -l)
+       expand_output=$(perf stat -a -x, --bpf-counters --for-each-cgroup / true 2>&1 | wc -l)
        if [ "${normal_output}" != "${expand_output}" ]; then
                if [ "${verbose}" = "1" ]; then
                        echo "Normal output has ${normal_output} lines, but it now has ${expand_output}"

