Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7925745B;
	Wed, 19 Feb 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002052; cv=none; b=YGBWfV11RUcbk2/DqUofNBJeo/h0/wgv5JBdom5oq09mY9bxtlS6rrP0TD/SMFpl3O+q6Gv1/6s+xXWHuR+oIQ75PePyhcijRetZT9nHNuBkr4iR1frDiF0na0oLwh5/yTyd68h9WPW9EixMLAAlW0Wnh6nZByJJQTe24OV8gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002052; c=relaxed/simple;
	bh=kyMwcNXN8YDzje5Qw7hFShfVLdsBWRKu6y0nbvuD0t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOJkW4z+rXQMNKPYGOcogVYFU3hvPD2dgAv7O/4Fvqvn+NB32hVS70mZ58npeix/PT2OC0MuZynJizZvRFwamnlNxoy7Q4FlKfrvN9a93Ta0hRRart2ooukoInX00j/IGReDa8j/t1DUv9Dtcgj4Ie88L7waaKWsPpmV090WqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPVIrJ/n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPVIrJ/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D38C4CED1;
	Wed, 19 Feb 2025 21:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740002051;
	bh=kyMwcNXN8YDzje5Qw7hFShfVLdsBWRKu6y0nbvuD0t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPVIrJ/nLuVCPSjzrSNllgcZHE8N1cC/lrnmSAt7Y1Nc+VVn6N1zxy8QNAHIksvML
	 kq7WlSXrkkUxQzSOJGB5Ht/BKBr8SwY9LcoTK4dHgvsOked0XooXXr7ADbxSXLYzsE
	 iZAhJanZOKW93mk7MoMVkB0dooFIIqQcmNjIcIQEpljODmuI96/TuHY9gm2WPy9rY7
	 nKh0pfcs4OqixLsyRyMmQqoFD29sLSFDqAPExeHYKqvXR8NFWM4/AigkQJyZxm8ev5
	 MNbnXCMl83xV7Jo7NkY+cYLxDqUGtnAdYJvYWJalwUCyQof7hmC8VzWAgwgxeskfZD
	 ifLEI+pqPnNiw==
Date: Wed, 19 Feb 2025 13:54:09 -0800
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
	Veronika Molnarova <vmolnaro@redhat.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Subject: Re: [PATCH v2 0/7] Add io_dir to avoid memory overhead from opendir
Message-ID: <Z7ZTAR5cN3mqEq8L@google.com>
References: <20250207232452.994822-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207232452.994822-1-irogers@google.com>

On Fri, Feb 07, 2025 at 03:24:41PM -0800, Ian Rogers wrote:
> glibc's opendir allocates a minimum of 32kb, when called recursively
> for a directory tree the memory consumption can add up - nearly 300kb
> during perf start-up when processing modules. Add a stack allocated
> variant of readdir sized a little more than 1kb
> 
> v2: Remove the feature test and always use a perf supplied getdents64
>     to workaround an Alpine Linux issue in v1:
>     https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/
>     As suggested by Krzysztof Łopatowski
>     <krzysztof.m.lopatowski@gmail.com> who also pointed to the perf
>     trace performance improvements in start-up time eliminating stat
>     calls can achieve:
>     https://lore.kernel.org/lkml/20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com/

Let me pick up Krzysztof's patch first.

Thanks,
Namhyung


>     Convert parse-events and hwmon_pmu to use io_dir.
> v1: This was previously part of the memory saving change set:
>     https://lore.kernel.org/lkml/20231127220902.1315692-1-irogers@google.com/
>     It is separated here and a feature check and syscall workaround
>     for missing getdents64 added.
> 
> Ian Rogers (7):
>   tools lib api: Add io_dir an allocation free readdir alternative
>   perf maps: Switch modules tree walk to io_dir__readdir
>   perf pmu: Switch to io_dir__readdir
>   perf header: Switch mem topology to io_dir__readdir
>   perf events: Remove scandir in thread synthesis
>   perf parse-events: Switch tracepoints to io_dir__readdir
>   perf hwmon_pmu: Switch event discovery to io_dir__readdir
> 
>  tools/lib/api/Makefile             |  2 +-
>  tools/lib/api/io_dir.h             | 91 ++++++++++++++++++++++++++++++
>  tools/perf/util/header.c           | 31 +++++-----
>  tools/perf/util/hwmon_pmu.c        | 42 ++++++--------
>  tools/perf/util/machine.c          | 19 +++----
>  tools/perf/util/parse-events.c     | 32 ++++++-----
>  tools/perf/util/pmu.c              | 46 +++++++--------
>  tools/perf/util/pmus.c             | 30 ++++------
>  tools/perf/util/synthetic-events.c | 22 ++++----
>  9 files changed, 194 insertions(+), 121 deletions(-)
>  create mode 100644 tools/lib/api/io_dir.h
> 
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 
