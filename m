Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25037492;
	Mon, 17 Jun 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657336; cv=none; b=FsaO/Spu+rSfz1I5nf1sHPHnXcVFQSySJ9hQxYx6LiYmP+wlnGOkULfQKFAmjPdRxM039fgeg9O07j54DEGAu3ISLrZ5wNnp18XHkHTLKBjuQqARzyDDVX0TkH3KccQVcSI1+e/O29VDoUQrR84rgIT0SA3fxnMfuHv4qGMGNMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657336; c=relaxed/simple;
	bh=qDU0nc5b8/2R9sgxnm0lx1HmVuNXuFgZxI+rzCtcSns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn0q548WKn+JbuYfeGkSmxNRRhC6C11ZT7MF2ndSF0MUpg3dDRW4+iOTEzz1eNPtxxI/hZoXcJAQXdocMoAKebMOfbHhLMCICDxeC3ajMNHSoVH9UGvXm7qY+ngx1t/1jpeDIxFKsjYmwQrmWQNRn/iVN8I6NBl6QmxbU2m+Enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpK/ZzVP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpK/ZzVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D48CC2BD10;
	Mon, 17 Jun 2024 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718657335;
	bh=qDU0nc5b8/2R9sgxnm0lx1HmVuNXuFgZxI+rzCtcSns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpK/ZzVPvlwnltMYnWOsPVozCHpUbpuF3W9t0d+mJHw910hP/4zBGg2b+4qNVhcLL
	 I9D99fA6dZP1qOIHkgTztTp3yXRuyfUeAuu93dKXhEyXXel58pfk288u/NkpXMdsEf
	 70eTcDn5a82r6Nq8EmmyQOYW5wJsItn2jRg+hGouXWyy3R8FF5hO1QLAEb0MmTU99Q
	 nN0SZPe9Fcyt95GJJIq6cxduEI5zphi5fJgnm/RRN9/Z1h4ZIOBwITGscgBWc2vwY+
	 s0nkMYXlouvUdzRMrVs3U6gIBA0NCDJF7PddYyCa7H1VO4eHr4CO2a0DbWFF7Jlrqp
	 Y0wbiZNrTcTdg==
Date: Mon, 17 Jun 2024 17:48:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Filter enum arguments with enum names
Message-ID: <ZnChMidAp7hxBVhI@x1>
References: <20240615062958.367524-1-howardchu95@gmail.com>
 <ZnCcliuecJABD5FN@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnCcliuecJABD5FN@x1>

On Mon, Jun 17, 2024 at 05:29:17PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, Jun 15, 2024 at 02:29:58PM +0800, Howard Chu wrote:
> > Before:
> > 
> > perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
> > No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set filter "(mode!=HRTIMER_MODE_ABS_PINNED_HARD) && (common_pid != 281988)"
> > 
> > After:
> > 
> > perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
> >      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12351248764875, softexpires: 12351248764875, mode: HRTIMER_MODE_ABS)
> 
> This one I had to apply manually after applying the other two patches:
> 
> ⬢[acme@toolbox perf-tools-next]$        git am ./20240615_howardchu95_perf_trace_filter_enum_arguments_with_enum_names.mbx
> Applying: perf trace: Filter enum arguments with enum names
> error: patch failed: tools/perf/builtin-trace.c:904
> error: tools/perf/builtin-trace.c: patch does not apply
> Patch failed at 0001 perf trace: Filter enum arguments with enum names
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> ⬢[acme@toolbox perf-tools-next]$ git am --abort
> ⬢[acme@toolbox perf-tools-next]$ patch -p1 <  ./20240615_howardchu95_perf_trace_filter_enum_arguments_with_enum_names.mbx
> patching file tools/perf/builtin-trace.c
> Hunk #1 succeeded at 894 with fuzz 2 (offset -10 lines).
> Hunk #2 succeeded at 932 (offset -10 lines).
> Hunk #3 succeeded at 1905 (offset 3 lines).
> Hunk #4 succeeded at 3832 (offset 3 lines).
> Hunk #5 succeeded at 3842 (offset 3 lines).
> Hunk #6 succeeded at 3883 (offset 3 lines).
> Hunk #7 succeeded at 3902 (offset 3 lines).
> ⬢[acme@toolbox perf-tools-next]$ 
> 
> 
> I'll push what I have to that tmp.perf-tools-next on my git repo at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

I've put it also in the perf_trace-btf_enum branch:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf_trace-btf_enum

Maybe we can then ask Namhyung to merge from that branch into
perf-tools-next/perf-tools-next.

Namhyung, wdyt? I'll do some more tests and review the code one more
time early tomorrow, but all seems to be work as expected.

The way it was submitted was a bit convoluted, I was expecting for
Howard to have the patches the way I put it in the perf_trace-btf_enum
branch, then use:

⬢[acme@toolbox perf-tools-next]$ rm -f 0*.patch
⬢[acme@toolbox perf-tools-next]$ git format-patch -n HEAD~4
0000-cover-letter.patch
0001-perf-trace-Fix-iteration-of-syscall-ids-in-syscalltb.patch
0002-perf-trace-BTF-based-enum-pretty-printing-for-syscal.patch
0003-perf-trace-Augment-non-syscall-tracepoints-with-enum.patch
0004-perf-trace-Filter-enum-arguments-with-enum-names.patch
⬢[acme@toolbox perf-tools-next]$

And then use:

git send-email --from "Howard Chu <howardchu95@gmail.com>" \
                --to "Arnaldo Carvalho de Melo <acme@kernel.org>"
                --cc "Jiri Olsa <jolsa@kernel.org>" \
                --cc "Namhyung Kim <namhyung@kernel.org>" \
                --cc "Ian Rogers <irogers@google.com>" \
                --cc "Adrian Hunter <adrian.hunter@intel.com>" \
                --cc "Kan Liang <kan.liang@linux.intel.com>" \
                --cc linux-kernel@vger.kernel.org \
                --cc linux-perf-users@vger.kernel.org \
                --no-validate \
                --smtp-debug=1 \
                --no-chain-reply-to 0*.patch

After editing 0000-cover-letter.patch to add an explanation about the
series. The version of the series would be in the Subject line for the
cover letter, etc.

Lets try to use this in the next series, concentrating now in reviewing
if what I have at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf_trace-btf_enum

Can already be merged by Namhyung on perf-tools-next/perf-tools-next.

Thanks a lot!

- Arnaldo
