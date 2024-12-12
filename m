Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036D223C7B;
	Thu, 12 Dec 2024 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028348; cv=none; b=BwHcrmSmpYTwtpr9UUu2g02BvZhRqXw19nTjepkCDsE0oZ+dOMIFgSW2kQ2Y82hmF7MhEWFzDPUd9kjLS3NX59jBwdDxS9ihQ3drpWXcMwrC8BuWPDtVDCLt4Jo2hpGF0w+pvx4i77fR0DBqAnWsDawSJ182x+kxItrrgAoGf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028348; c=relaxed/simple;
	bh=ig4WqdW5KLmQUNZb+Hu3NK8OKMDRHpZtu68KawFzYkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KooR5ciLQwRGT6csl30ggCAm9IPvdiGmGfRj1JGF1SyfYfI22svRuEF7TmkAtsXZ5S/K+o6WZ5BNNDh9o7zwjpqz6gOZXBaZTpu33VEyRDzIG+EzWPqDRHQ1AOEzbTzxaFbE2NR38C8Mz+ql8V62AHhDhrdX4kFGIQozh025/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfsNFsWl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfsNFsWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D55CC4CECE;
	Thu, 12 Dec 2024 18:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028346;
	bh=ig4WqdW5KLmQUNZb+Hu3NK8OKMDRHpZtu68KawFzYkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfsNFsWlS+7McBj052JWuRkaVnirKI4rdiTgUy23O1PBVj12pYIMdUjk1OXir7KLU
	 5OQIFe6zriuhNJOzo4TTf3obsBdbd+xVNKHXhd/j7dL06FGAOA1S0Ca3ARLZeLmMJg
	 uNdTFfLfG/k9Eth5K/S1eyg5WlnuEGUvTsBe0gmr9MaA6i9zf48/pGXJRV5y15sbfT
	 6uPDH1dwq6pEELcnXNGYbjxF0KG9b5z4CKAcjALisMqQGxp7jzZSQBZFpaYVjAW4ft
	 5QnMF0Qpx/xCMbRI/TuGRJNZFuQ4qRUVo0Le0i1baa5NrGufhCszPr5bsbGc6KVwyZ
	 TZ9gP3+4AVuWA==
Date: Thu, 12 Dec 2024 15:32:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/2] tools build feature: Don't set feature-libcap=1 if
 libcap-devel isn't available
Message-ID: <Z1ssN_Ktym-1tvZ6@x1>
References: <20241211224509.797827-1-acme@kernel.org>
 <20241211224509.797827-3-acme@kernel.org>
 <CAP-5=fWqBrw1SuY8ue2X_xOv=yStPANM9NGUBkeo+_s2O=bKTA@mail.gmail.com>
 <c63063b3-b2cc-43af-b026-98c992e9bbf3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c63063b3-b2cc-43af-b026-98c992e9bbf3@kernel.org>

On Thu, Dec 12, 2024 at 10:16:38AM +0000, Quentin Monnet wrote:
> 2024-12-11 20:25 UTC-0800 ~ Ian Rogers <irogers@google.com>
> > On Wed, Dec 11, 2024 at 2:45 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> >>
> >> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>
> >> libcap isn't tested in the tools/build/feature/test-all.c fast path
> >> feature detection process, so don't set it as available if test-all
> >> manages to build.
> >>
> >> There are other users of this feature detection mechanism, and they
> >> explicitely ask for libcap to be tested, so are not affected by this
> >> patch, for instance, with this patch in place:
> >>
> >>   $ make -C tools/bpf/bpftool/ clean
> >>   <SNIP>
> >>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
> >>   ⬢ [acme@toolbox perf-tools-next]$ make -C tools/bpf/bpftool/
> >>   make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
> >>
> >>   Auto-detecting system features:
> >>   ...                         clang-bpf-co-re: [ on  ]
> >>   ...                                    llvm: [ on  ]
> >>   ...                                  libcap: [ on  ]
> >>   ...                                  libbfd: [ on  ]
> >>   ...                             libelf-zstd: [ on  ]
> >>   <SNIP>
> >>     LINK    bpftool
> >>   make: Leaving directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
> >>   $
> >>   $ sudo rpm -e libcap-devel
> >>   $ make -C tools/bpf/bpftool/
> >>   <SNIP>
> >>   make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
> >>
> >>   Auto-detecting system features:
> >>   ...                         clang-bpf-co-re: [ on  ]
> >>   ...                                    llvm: [ on  ]
> >>   ...                                  libcap: [ OFF ]
> >>   ...                                  libbfd: [ on  ]
> >>   ...                             libelf-zstd: [ on  ]
> >>
> >>   $
> >>
> >> Cc: Adrian Hunter <adrian.hunter@intel.com>
> >> Cc: Ian Rogers <irogers@google.com>
> >> Cc: James Clark <james.clark@linaro.org>
> >> Cc: Jiri Olsa <jolsa@kernel.org>
> >> Cc: Kan Liang <kan.liang@linux.intel.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: Quentin Monnet <qmo@kernel.org>
> >> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> 
> Acked-by: Quentin Monnet <qmo@kernel.org>
> 
> Thanks Arnaldo for checking the bpftool build :)

Thanks! Added to the cset.

- Arnaldo
