Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C243B0591;
	Fri, 31 Jul 2026 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540446; cv=none; b=RKaq2sx0IDw2BGOaJTJgGj+lRrIMYi16NTZwnecGvi1hMQVKz63R2tAnayrbo00F16g9627oSz7PmBhIa0p5cCIIqi3q6WJOk+8pp7NkRTVERSkoE4SDrI0B+NdhUbGKR/lfd2m7u7YwnL4ea0Nqd/+84IHbj/SklSZIvGXgD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540446; c=relaxed/simple;
	bh=GemiZ9XDod/miOeKQpiZJYr9RUBzSNsYSGGI0di9EIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKY4VjQaUTPovzYICiSf956sTi3O9Wa0u2kUfP4llXobhdHj1D30YZhmWVfoxeCxQktN4xKrf+9MQWJfMBXQZ8mR6a84jtoRvHvJDFK8uSuLaTHhX4W+YyCyhWFGy2SM79eqeCKgnldv2qlCzNwlD7ktccXaFCVltkzD+CfhJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYpBYJ5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYpBYJ5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AB41F00AC4;
	Fri, 31 Jul 2026 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785540444;
	bh=Y+YfNuViyyiz2CVxj4nqxh41+cIC5EUIxwhP1pZwiiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bYpBYJ5MSRlAcUihs9rZN4P4rD7EfK9h5re4PIsdd4iAifKeaB9vEhO7ZZAqQY5Md
	 QIhBKvIQuecoXUlprsI59MzaoeGmUsF+J0wS54ZeggK7b9C0//rhNaFcVc6fQ1IH3N
	 KQLc+GTGtj8uvjCiAwhJrs0tR8S8HhDpbiauQYr/v62Q8/+b0znuCJjifNvhSGirak
	 lrfUnzV7J4ZCAaOFLFrICywXg74om5KqsahApNNx/iHHZn2eBftQZyPvyo3N7HK7u1
	 DocVL0Hk9SmQwvIQkILR2Q2eIlJgjwOO9HyP6P+Sh1V7JsFZbRmfzfr12gFdOUteWx
	 yhtMXRn0cIs4Q==
Date: Fri, 31 Jul 2026 16:27:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES 0/5 v1] perf tools auxtrace hardening series
Message-ID: <am0vWwqDMib_NF6q@google.com>
References: <20260727161705.64807-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727161705.64807-1-acme@kernel.org>

Hi Adrian,

On Mon, Jul 27, 2026 at 01:17:00PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Please consider applying,
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (5):
>   perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
>   perf auxtrace: Fix queue grow overflow and old array leak
>   perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
>   perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
>   perf arm-spe: Reject zero nr_cpu in metadata to prevent division by zero

Can you please review this series?

Thanks,
Namhyung

> 
>  tools/perf/util/arm-spe.c      |  4 ++++
>  tools/perf/util/auxtrace.c     | 15 ++++++++++-----
>  tools/perf/util/intel-bts.c    |  2 +-
>  tools/perf/util/intel-pt.c     |  2 +-
>  tools/perf/util/thread-stack.c |  2 +-
>  5 files changed, 17 insertions(+), 8 deletions(-)
> 
> -- 
> 2.55.0
> 
