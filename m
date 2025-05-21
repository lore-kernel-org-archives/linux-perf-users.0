Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F217C21B;
	Wed, 21 May 2025 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838823; cv=none; b=PSHlW9UGdbdu8/mCqKYx3Hd7okOJyC2Tg2DHsoWFXQ1Pzx5aQrqhb9fhnWHHTk5XX6PBl8dolnJakTvxUQ8ILD0WI4BCKPc9BSd495eMl2V0TbseFQd9RbhHbgbzwpuImDz2KtATJbSl6CWee/jr0bIhGOkEvejyiK7AoswhcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838823; c=relaxed/simple;
	bh=wceNbE82aRL6dk03/moFFtc9ICxSDqGxhtj33U1LJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPVivgDiYpCb8MJFMB3P1LpdWqpzRFUTdcxG6JcmzVeTmQAx/AxtgjDoYjAPKYVOdbqrHroD4De/vV1Effaz2sLe5XOwIH+A8MLpFz/48Yjuq4vaMdjomhtjVplkIrap8EKJq8TApVozrE+PndKv6y54chX2fu6QS9iMhrH/r88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrxpGQCs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrxpGQCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113A7C4CEE7;
	Wed, 21 May 2025 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747838822;
	bh=wceNbE82aRL6dk03/moFFtc9ICxSDqGxhtj33U1LJrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrxpGQCsGMnpB2mqtmJiF7sv9/AHwyeh/WLP3Y+vBM55w4kNrNF27219aktHe4Gch
	 njN5n7+XC5OnYOlkpDuBcRD9avDlxb6uD66rwiy58Udd5PvQQ4dHRdDjLJb3VUQozU
	 obsnwM0M0nQHsMZ08cmEbTkY6nbioNoY6V/tKvSxaGhMf85l+3VgcRXCLS6uU6m3A1
	 BYiaXmAICImJRnXekKiC8t4HX00Ie+3kt/myk+TN2k1B9z1VUgf6VcgctKMOUn8B+S
	 pvJCqOW1Ov8TumjHufNDGN4PVdm2bHUE9BDSIDBGhi9HhvL38N7cTemHkofFYiVDBW
	 n+UwWlTGtKFzQ==
Date: Wed, 21 May 2025 11:46:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com
Subject: Re: [PATCH v3 7/7] perf python: Add counting.py as example for
 counting perf events
Message-ID: <aC3nY4jVQ9ufeXqn@x1>
References: <20250519195148.1708988-1-irogers@google.com>
 <20250519195148.1708988-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519195148.1708988-8-irogers@google.com>

On Mon, May 19, 2025 at 12:51:44PM -0700, Ian Rogers wrote:
> From: Gautam Menghani <gautam@linux.ibm.com>
> 
> Add counting.py - a python version of counting.c to demonstrate
> measuring and reading of counts for given perf events.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested and applied:

Committer testing:

Build perf and make the generated python binding somewhere you can point
to to avoid using the one in the distro python3-perf (fedora, may be
different in other distros):

  $ make -k O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin

Copy /tmp/build/perf-tools-next/python/perf.cpython-313-x86_64-linux-gnu.so to
somewhere outside this toolbox container and then use it with root:

  # export PYTHONPATH=/root/python/
  # ls -la /root/python/
  total 10640
  drwxr-xr-x. 1 root root       72 May 21 11:40 .
  dr-xr-x---. 1 root root      574 May 21 11:40 ..
  -rwxr-xr-x. 1 acme acme 10894360 May 21 11:40 perf.cpython-313-x86_64-linux-gnu.so
  # tools/perf/python/counting.py | head -5
  For evsel(software/cpu-clock/) val: 2930946 enable: 2932479 run: 2932479
  For evsel(software/cpu-clock/) val: 2924975 enable: 2926267 run: 2926267
  For evsel(software/cpu-clock/) val: 2921017 enable: 2922430 run: 2922430
  For evsel(software/cpu-clock/) val: 2914966 enable: 2916549 run: 2916549
  For evsel(software/cpu-clock/) val: 2910027 enable: 2911589 run: 2911589
  #

It would be nice to have something that compares the output for some
envent obtained from both 'perf stat' and using these new python
counting classes, but that can be done later.

Applied to perf-tools-next,

- Arnaldo

> ---
> Ian modified from v2 to make the API take a CPU and thread then
> compute from these the appropriate indices. This was discussed as the
> preferred API with Arnaldo:
> https://lore.kernel.org/linux-perf-users/20250512055748.479786-1-gautam@linux.ibm.com/
> The use of a thread_map and cpu_map was also removed to make the code
> cleaner, instead the cpus and threads of the parsed evsel are
> used. Support for command line events is also added. The indent is
> reduced from 8 to 4 to match the preferred python PEP8 indent.
> ---
>  tools/perf/python/counting.py | 36 +++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100755 tools/perf/python/counting.py
> 
> diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.py
> new file mode 100755
> index 000000000000..02121d2bb11d
> --- /dev/null
> +++ b/tools/perf/python/counting.py
> @@ -0,0 +1,36 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# -*- python -*-
> +# -*- coding: utf-8 -*-
> +
> +import argparse
> +import perf
> +
> +def main(event: str):
> +    evlist = perf.parse_events(event)
> +
> +    for evsel in evlist:
> +        evsel.read_format = perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING
> +
> +    evlist.open()
> +    evlist.enable()
> +
> +    count = 100000
> +    while count > 0:
> +        count -= 1
> +
> +    evlist.disable()
> +
> +    for evsel in evlist:
> +        for cpu in evsel.cpus():
> +            for thread in evsel.threads():
> +                counts = evsel.read(cpu, thread)
> +                print(f"For {evsel} val: {counts.val} enable: {counts.ena} run: {counts.run}")
> +
> +    evlist.close()
> +
> +if __name__ == '__main__':
> +    ap = argparse.ArgumentParser()
> +    ap.add_argument('-e', '--event', help="Events to open", default="cpu-clock,task-clock")
> +    args = ap.parse_args()
> +    main(args.event)
> -- 
> 2.49.0.1101.gccaa498523-goog
> 
