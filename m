Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB24A29;
	Tue, 25 Feb 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443307; cv=none; b=YrY3v5MPssOA37JU5Tr98ubHDkedbsYxzxP24fs6WuwCtNpwfBtlHl9F+bSg++jqSfx8EQCOR81WgRDzib/bJT3scfn6RAN0EfBByyN2pfSgBkmtWCzwEIFeUjszB8OodJ9BLEP23RsyDb0rDIyujdCjW6Qv15kL2ia/x917SRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443307; c=relaxed/simple;
	bh=jRQO0x5Wge0oFL5+IAL8Oe+jEynipFuBkzm4aFHOChE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSPELRGV+jzsFDid0GeQ0m+rsLXZiH3IoIDlpzYlbxKrzAb+Z5CFJkoOQaF93RRCpoRXo5gs4mKdGsFCFBFRS10L80yKHCgWjH+Efbl8cmXKviFDn6h8aIeZfdgdwcdPSVwGEtUehM/WTlEBCqaBpDPBt3TP+sxRN9fv9UvOevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nytC0etr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nytC0etr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E42C4CED6;
	Tue, 25 Feb 2025 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740443306;
	bh=jRQO0x5Wge0oFL5+IAL8Oe+jEynipFuBkzm4aFHOChE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nytC0etrnBx3zMchtu1S77Pn4hbu01QBWAMJ3thZlAH0QmQZMwbgXKDfMbttNKOjT
	 nxiVsSxHtlyXAN30oli3yZvUzXvE3LCZXa1vBvlQTJVU9XYUwuGlOoQrF4vV+dlu5s
	 xFCE4x1Hp2X5CII3+5ZlIU49zi/j6j5cvh1wT9JtCiAnU3Xq2ZziitqimrUJo/BXdW
	 JkZg+2IkxoXAodofFexidM4yljDziwlZN3Wc1C4g/yZtmziUbiVGhLFJMxsFMjbxFS
	 TzTzH7Amy5yoSaPRZmzaRVG3kKPCAjxhOjx1zn8+ZuY4xi5Yx6me9pl7xBLtMWjG2d
	 BVR6BVHDioHUw==
Date: Mon, 24 Feb 2025 16:28:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>,
	Jesper Juhl <jesperjuhl76@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Subject: Re: [PATCH v3 0/8] Add io_dir to avoid memory overhead from opendir
Message-ID: <Z70OqFzD2JcbhFtL@google.com>
References: <20250222061015.303622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222061015.303622-1-irogers@google.com>

Hi Ian,

On Fri, Feb 21, 2025 at 10:10:05PM -0800, Ian Rogers wrote:
> glibc's opendir allocates a minimum of 32kb, when called recursively
> for a directory tree the memory consumption can add up - nearly 300kb
> during perf start-up when processing modules. Add a stack allocated
> variant of readdir sized a little more than 1kb

It's still small and hard to verify.  I've run the following command
before and after the change but didn't see a difference.

  $ sudo time -f %Mk ./perf record -a true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.757 MB perf.data (563 samples) ]
  74724k

According to man time(1), %M is for max RSS.

Thanks,
Namhyung

> 
> v3: Rebase on top of Krzysztof Łopatowski's work. Add additional
>     defines for SYS_getdents64 on all other architectures if its
>     definition is missing. Add a patch to further reduce the
>     stack/memory usage in machine__set_modules_path_dir by appending
>     to a buffer rather than creating a copy.
> v2: Remove the feature test and always use a perf supplied getdents64
>     to workaround an Alpine Linux issue in v1:
>     https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/
>     As suggested by Krzysztof Łopatowski
>     <krzysztof.m.lopatowski@gmail.com> who also pointed to the perf
>     trace performance improvements in start-up time eliminating stat
>     calls can achieve:
>     https://lore.kernel.org/lkml/20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com/
>     Convert parse-events and hwmon_pmu to use io_dir.
> v1: This was previously part of the memory saving change set:
>     https://lore.kernel.org/lkml/20231127220902.1315692-1-irogers@google.com/
>     It is separated here and a feature check and syscall workaround
>     for missing getdents64 added.
> 
> Ian Rogers (8):
>   tools lib api: Add io_dir an allocation free readdir alternative
>   perf maps: Switch modules tree walk to io_dir__readdir
>   perf pmu: Switch to io_dir__readdir
>   perf header: Switch mem topology to io_dir__readdir
>   perf events: Remove scandir in thread synthesis
>   perf parse-events: Switch tracepoints to io_dir__readdir
>   perf hwmon_pmu: Switch event discovery to io_dir__readdir
>   perf machine: Reuse module path buffer
> 
>  tools/lib/api/Makefile             |   2 +-
>  tools/lib/api/io_dir.h             | 104 +++++++++++++++++++++++++++++
>  tools/perf/util/header.c           |  31 ++++-----
>  tools/perf/util/hwmon_pmu.c        |  42 +++++-------
>  tools/perf/util/machine.c          |  57 ++++++++--------
>  tools/perf/util/parse-events.c     |  32 +++++----
>  tools/perf/util/pmu.c              |  46 ++++++-------
>  tools/perf/util/pmus.c             |  30 +++------
>  tools/perf/util/synthetic-events.c |  22 +++---
>  9 files changed, 229 insertions(+), 137 deletions(-)
>  create mode 100644 tools/lib/api/io_dir.h
> 
> -- 
> 2.48.1.658.g4767266eb4-goog
> 
