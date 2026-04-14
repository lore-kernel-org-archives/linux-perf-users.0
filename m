Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B22472B6;
	Tue, 14 Apr 2026 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149232; cv=none; b=XSFcEr+rUrwKAmY3z9HLichO91uM6oWFNJ3M9iv66/XFlmo8WxyiD7vd5/3RpQK25R0c0C5ZV681OzlwFT0Nc38MYrHmsQlKRJkJWhrNAaueGWfEDYiTAqspHRuJjD1i3dXowOrWkxhbf+LHtvHEyXOSUfUYl5HXDviSuhEGOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149232; c=relaxed/simple;
	bh=N5DCDhmnbzPdPldZuGutjm0yIfpUxBb3KiiBiuLAWyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7V5aM03rfzDt/POnLS2Uyhu2S/Lb6mWGhTbaYQhw5LmqD2aMHmdvGvmxQHUne4/Ee2xZ8+0pW67O6CFxRgTchO7eYFi6DpSqydo4QoONEo8BpYDHzdKOSEIPc3xX7GlwbsA7qXFIdiocjuHlh5razCpUPDR4hS+D4gTmctOnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvPjg6JQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvPjg6JQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC99EC19425;
	Tue, 14 Apr 2026 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776149232;
	bh=N5DCDhmnbzPdPldZuGutjm0yIfpUxBb3KiiBiuLAWyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvPjg6JQHGgkdYUHXWuyEjkOSLMevEcaZ9MP3w+fOmrxofb+yokOH0eeU8tfOe122
	 RHT7mNTAX+OhENJ+6/4RnAespbRO1gtTYTG1LATu3uTp3WfFD3SKq06WlDcvR8WdjW
	 sU+eBkPhM0w8R8YmZs0g23pdGrcQqXU3w+vHGWecVKVwzdiIGhDhyd+bd+JGdV1KS1
	 V914boZZj7OuRaYMNAQv+pACoyVUMgIS1P58mWPzkntufTW7KjyY5JxuvQOXQHEseZ
	 Qe4IWHMHFX6Eq7pVh9GbjME2D595hUKBxORaHzl4VGYAVKatzzIhgzcnHn0koyyaGT
	 dMB+6EQNX3kSA==
Date: Mon, 13 Apr 2026 23:47:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: hev <r@hev.cc>
Cc: jiny L <leeavianna3@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH] perf loongarch: Fix build failure with
 CONFIG_LIBDW_DWARF_UNWIND
Message-ID: <ad3i7q62HSEYT1up@google.com>
References: <20260414005152.10550-1-r@hev.cc>
 <CANVb8WZXZj1Yqd7foqHBLSHjO73r0Kg62bMbrb--aE8wR3G2hg@mail.gmail.com>
 <CAHirt9jA3G5kRjJbmosttEDkvZhKfx3U6oa63JZOnpEx4Cqb2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHirt9jA3G5kRjJbmosttEDkvZhKfx3U6oa63JZOnpEx4Cqb2g@mail.gmail.com>

On Tue, Apr 14, 2026 at 09:18:18AM +0800, hev wrote:
> On Tue, Apr 14, 2026 at 9:13 AM jiny L <leeavianna3@gmail.com> wrote:
> >
> >
> >
> > On Mon, Apr 13, 2026 at 5:52 PM WANG Rui <r@hev.cc> wrote:
> >>
> >> Building perf for LoongArch fails when CONFIG_LIBDW_DWARF_UNWIND is
> >> enabled because unwind-libdw.o is still referenced in
> >> arch/loongarch/util/Build.
> >>
> >> Fixes: e62fae9d9e8 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
> >> Signed-off-by: WANG Rui <r@hev.cc>
> >> ---
> >>  tools/perf/arch/loongarch/util/Build | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
> >> index 3ad73d0289f3..8d91e78d31c9 100644
> >> --- a/tools/perf/arch/loongarch/util/Build
> >> +++ b/tools/perf/arch/loongarch/util/Build
> >> @@ -1,4 +1,3 @@
> >>  perf-util-y += header.o
> >>
> >>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> >> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> >> --
> >> 2.53.0
> >>
> >>
> >
> > I happened to have the same build issue on linux 7.0 and I found there is already a patch fixing this  https://lore.kernel.org/lkml/20260413024805.1316480-3-irogers@google.com/
> 
> Thanks for the reference.
> Rui

As the Ian's series is still under review, I'd pick this one instead.

Thanks,
Namhyung

