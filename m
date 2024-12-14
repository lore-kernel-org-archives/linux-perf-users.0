Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693EE17543;
	Sat, 14 Dec 2024 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137556; cv=none; b=s8iqxkSoOcTv5ulUcto9CQ2aoYXzRzkJv+tBLG/uodgFxBg2yVIeo3Ona1MnoivGNRZl8hrYsJ7YHuPPgOLH7fUWhqcfWNa7Z1viLDPq4mkZR3TZSvWMUkHjx7IazpMnVANHIyxB4iIVsr6zvKXAc8RnbeMMSoVH9pqpVnlzQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137556; c=relaxed/simple;
	bh=KZ7SjeiKFlvvHyLFimY9QiRSfaYZW3YrSUMEZoOpL9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/nuPfrBud0vSzExYZ3lVefwQcokNYWAc/LURsMfN5EeEUj9v6MHHV6G94uyXtFEwZdy78BpqXWVflYx6L7Y2G25z1/FW0qI6LufXhkLXYmHsCVEF8iYX74MLk02ntB9sSySRTNkHZLWnwZ43YGkDReJxT2RvtwHsMd2AT8/1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIlzleAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIlzleAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47784C4CED0;
	Sat, 14 Dec 2024 00:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734137556;
	bh=KZ7SjeiKFlvvHyLFimY9QiRSfaYZW3YrSUMEZoOpL9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIlzleAT6hqSSnm9fXV1eu5UkKH5ctTkJD5H78IHYLV9t6JLpwz693mC8/+D9xCmb
	 seD0u0OUROACIjwBql9qjwwWQsizcAl9Q1gszbzVO52OVBmNL7jhpDApIwvzy8ORp0
	 6RRr5JBHC0sJuOHMS9eM4zRo7fOyz1fuEXjiNObnSRZ+GEXLBtwtt4CaXtwns8Alxw
	 vQexsUX26+F0qJ+vpQI6JAyw8TkkprM+gA8dAWcu1VG2opmUSCjFdMWxE4/IaRFl2g
	 wvtZcB1iz3s1G1DNOyYaohq/WQkEb+xdXU+8FJOWboZDyycQ11ujZ1Kpdi18J5qFgO
	 n2s6lnT61K3rw==
Date: Fri, 13 Dec 2024 16:52:33 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/8] Various fixes around undefined behavior
Message-ID: <Z1zW0abggo8KcYBw@google.com>
References: <20241213210425.526512-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213210425.526512-1-irogers@google.com>

On Fri, Dec 13, 2024 at 01:04:17PM -0800, Ian Rogers wrote:
> Fix various undefined behavior issues, improve tests to make them
> easier to diagnose and add assertions so that problems don't recur.
> 
> Ian Rogers (8):
>   perf disasm: Avoid undefined behavior in incrementing NULL
>   perf test trace_btf_enum: Skip if permissions are insufficient
>   tools headers: Update offsetof and container_of
>   perf evsel: Avoid container_of on a NULL leader
>   tools headers: Add non-NULL assert to container_of
>   perf maps: Avoid UB passing NULL to bsearch
>   perf test shell lock_contention: Extra debug diagnostics
>   libperf event: Ensure tracing data is multiple of 8 sized

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/include/linux/kernel.h              | 16 ++++++++++------
>  tools/lib/perf/include/perf/event.h       |  1 +
>  tools/perf/tests/shell/lock_contention.sh |  9 +++++++--
>  tools/perf/tests/shell/trace_btf_enum.sh  | 11 +++++++++++
>  tools/perf/util/disasm.c                  |  7 +++++--
>  tools/perf/util/evsel.c                   |  2 ++
>  tools/perf/util/maps.c                    |  9 ++++++---
>  7 files changed, 42 insertions(+), 13 deletions(-)
> 
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
