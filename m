Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE1217F47;
	Tue, 12 Nov 2024 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441374; cv=none; b=Cnu9dRQIBRSoYYueKl/TccJaeOT9YQdq7EUFcVOhntnf+Jmt6cEgJyU9iEgCfa7r6Hrez5cBwNFA5BAP1v7TgUhsgaNLEzcB/3iO5Y93ht6xTxVG/z8xCGJ7js10pWQaTD1kD4bnlc2lpdhoaKuSHFTnfHsCGBM1Vhyo+Azw90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441374; c=relaxed/simple;
	bh=5g5ru0B5TVy4XXj2/HCwnGGtF/Djy83t4qR2r/ThSV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1o8780N6mALAvNu3zZ9MRksMzLlU0cGgy0iDR8xzj64h/m2Ildy8dHy800w/MzL7Liipa2Z5CrzgAou2Wu/mSgob2XVTs1pUd7SPgiD521StpYunI+j1HEmBx5T5wz+j5t3aMGyi8lc9keQc46TA0i9FfwBr/kM904EwN5409E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cjji7FbN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cjji7FbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AC0C4CECD;
	Tue, 12 Nov 2024 19:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731441373;
	bh=5g5ru0B5TVy4XXj2/HCwnGGtF/Djy83t4qR2r/ThSV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cjji7FbNWW8nHyG+3EmBLBPgFQtDZNIP5hZOLpbNssVCDWYTpXUay/FpgWWQ9OfH6
	 MPwbGvswxQ5H8fwAcZzPaIHBsw8EnktUe5oXu74ewe2wQznR8u4z0YM+HW+RODRY1Y
	 p6z0WY1c0E5Dmdqg92RryyLYB5R40B880z3tU8JJyqg74tQo+siv5C4S1zY57PBbG4
	 Q1nZ6tfMmUo1NLCVeMON663s103xNfrPI2iZ+fH/flebJiHK+JEG6bDnnNOgvywooR
	 2JbXDbR1DZb00qTwt2suHvlXreDEfUs3jlNTrms+du/CVX0cvKByssNss3Xzd9ew0N
	 zB+PghsIVHGYw==
Date: Tue, 12 Nov 2024 16:56:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com,
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <ZzOy2KjyuMD9AJ3G@x1>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <ZzOg3Xlq2jsG85XQ@x1>
 <ZzOpvzN-OTLZPyFh@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzOpvzN-OTLZPyFh@x1>

On Tue, Nov 12, 2024 at 04:17:19PM -0300, Arnaldo Carvalho de Melo wrote:
> I squashed the patch below and I'm trying to apply the other patches to do some
> minimal testing on the feature itself, but the organization of the
> patches needs some work.
 
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -61,6 +61,9 @@ static int off_cpu_config(struct evlist *evlist)
>  static void off_cpu_start(void *arg)
>  {
>  	struct evlist *evlist = arg;
> +	struct evsel *evsel;
> +	struct perf_cpu pcpu;
> +	int i;
>  
>  	/* update task filter for the given workload */
>  	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
> @@ -82,6 +85,8 @@ static void off_cpu_start(void *arg)
>  	}
>  
>  	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> +		int err;
> +
>  		err = bpf_map__update_elem(skel->maps.offcpu_output, &pcpu.cpu, sizeof(__u32),
>  					   xyarray__entry(evsel->core.fd, i, 0),
>  					   sizeof(__u32), BPF_ANY);

This is not enough, as it in the end tries to use that
skel->maps.offcpu_output that is only introduced at a later patch, it
seems, not checked yet, but explains the error below:

  LD      /tmp/build/perf-tools-next/perf-test-in.o
  AR      /tmp/build/perf-tools-next/libperf-test.a
  CC      /tmp/build/perf-tools-next/util/parse-events.o
util/bpf_off_cpu.c: In function ‘off_cpu_start’:
util/bpf_off_cpu.c:90:54: error: ‘struct <anonymous>’ has no member named ‘offcpu_output’
   90 |                 err = bpf_map__update_elem(skel->maps.offcpu_output, &pcpu.cpu, sizeof(__u32),
      |                                                      ^
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/build/perf-tools-next/util/bpf_off_cpu.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: util] Error 2
make[2]: *** [Makefile.perf:789: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
  LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
make[1]: *** [Makefile.perf:292: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbox perf-tools-next]$ 


Ok, at the end of the series it builds, and the 'perf test' entry
introduced in this series passes:

root@x1:~# perf test off
121: perf record offcpu profiling tests                              : Ok
root@x1:~# perf test -v off
121: perf record offcpu profiling tests                              : Ok
root@x1:~# perf test -vv off
121: perf record offcpu profiling tests:
--- start ---
test child forked, pid 1303134
Checking off-cpu privilege
Basic off-cpu test
Basic off-cpu test [Success]
Child task off-cpu test
Child task off-cpu test [Success]
Direct off-cpu test
Direct off-cpu test [Success]
---- end(0) ----
121: perf record offcpu profiling tests                              : Ok
root@x1:~#

But the only examples I could find so far for this feature were on the
'perf test' at the end of this series.

I think we need to have some examples in the 'perf-record' man page
showing how to use it, explaining the whole process, etc.

I'll continue testing it and trying to move things around so that it
gets bisectable and testable step by step, documenting the whole
process as I go, probably tomorrow.

The series with my fixes is at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-off-cpu77918
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-off-cpu


- Arnaldo
