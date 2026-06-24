Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10E2C08BC;
	Wed, 24 Jun 2026 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260860; cv=none; b=BlvgnzEQsdrek0JEfUNzt4CYsOWpaQT7ZxXQSmUQaZERuACGPYUOdcghoK61wOlOBQ4Hzd/Rx0srJSg9rYz3hx9WakQuzAhAWuibhV0jg7n4q7AKoT5eMpsQcUEi3jLHD7piYWH3JNMRHANkod/8m+xbIoxkh5+Ry9fyg7kJoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260860; c=relaxed/simple;
	bh=2Po75taLKV14QW/RT44tZZnecUk6YX/SZI0MVlZfXe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkEB19Z+hW3SGvD/zgVTKgRTH4rgJF17l7le3Fem9AxvlM1I/2feE2RBod+yv7uSDHvt9wtlWcSvP+IBBI7OMEo1vrC8KI9+TfYyWXk0VlrEEHBOwJPB78r3HNYDzgv1LRD4ukDlI56LyzctulaiX8oHTP3DONZLcQaeYOoRR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBO+zXCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBO+zXCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559931F000E9;
	Wed, 24 Jun 2026 00:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782260859;
	bh=UdA9y5Bcte3OWHHB2BZWdFc5YTgj1AH+bbSLVJFsi0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BBO+zXCTmRoh00P0MzH6Q/F1HGIU9w7u6FWRHKlIr5kqF4nzOcgDm4nLmwMQZeg+z
	 xe6dJyNuUGzjI2VBeTfg/ZqN1IG1wfk3KYxrO+Jxram2LN+Tzbh2JdPTug/4Gm7ZeJ
	 l1fXw2EUnDu5wqo+zB83EEWMqcB/WUJeHdEygpcdbiFc0IlVk5qlVyHWGzTDqSbejp
	 TR0iNpbwfdBGX+QEN4yPvITitB5tBsi/OVAzOro5wEzBEWjE9s9ajODNWGK/o7pVGj
	 Cf5/0uHQwR3R2ZGAuVOJdAkm+0R0VS8VVZ0fJKaLqiZMD1tHQOJVUXs2+s/giiRaVc
	 bDw0tKPdfwc7A==
Date: Tue, 23 Jun 2026 17:27:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf bench bpf: Add missing .gitignore file
Message-ID: <ajskevFfXGkVt-si@google.com>
References: <ajsfSkRm0T7J2eF3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajsfSkRm0T7J2eF3@x1>

On Tue, Jun 23, 2026 at 09:05:30PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi Linus,
> 
> 	I'll have this in the next pull req if you prefer not to merge
> now,
> 
> - Arnaldo
> 
> ---
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> In 713eeb2279402758 ("perf build: Move BPF skeleton generation out of
> Makefile.perf") the bpf_skel used with 'perf bench uprobe' was moved
> from tools/perf/util/bpf_skel/ to tools/perf/bench/bpf_skel.
> 
> Copy tools/perf/util/bpf_skel/.gitignore to that new directory so that
> files generated during build get ignored by git.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Fixes: 713eeb2279402758 ("perf build: Move BPF skeleton generation out of Makefile.perf")
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/bench/bpf_skel/.gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 tools/perf/bench/bpf_skel/.gitignore
> 
> diff --git a/tools/perf/bench/bpf_skel/.gitignore b/tools/perf/bench/bpf_skel/.gitignore
> new file mode 100644
> index 0000000000000000..cd01455e1b53c3d9
> --- /dev/null
> +++ b/tools/perf/bench/bpf_skel/.gitignore
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +.tmp
> +*.skel.h
> +vmlinux.h

I think it's enough to add '*.skel.h' only as other files are still
under util/bpf_skel.  But having others would not be harmful.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

