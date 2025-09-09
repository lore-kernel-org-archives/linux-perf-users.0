Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976B31B82F;
	Tue,  9 Sep 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413077; cv=none; b=MtqkQ6IqJZ4IQ1wD2yHzgbYfjoZqqAGtSh+uClEjDIfEYsUXjKgQrk7Q4xLwe0WBLTDGh94NkuHxfNjsXsajt1PrhrZf+mDkgEdyDlLvUjLszWFXdC/WcAlTjr7nx8HBhIEjzjAjggmK1K5RW4qmtvWmRrmiII5xspHnJbXapfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413077; c=relaxed/simple;
	bh=4m9UbFVRCBXCbwTLbj8mtgXioZ0oJzyPdVJCjmncO4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxX3WfTMoLDOM1nXWuIs+sVRkZuHymvoCXyx1E6su3OxusoA4HLWx0+jFGO1dN4vYWf+K0rCKUMDFlsITDPhX8U5BdFpQPF37z7BEs1JbCRUy3mvnvg79qEvmBTpJO7Wcmvs+rlJPu4E2jIolJPosjBSsCzA3iWtkST3Y+SnW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 21AB7340E21;
	Tue, 09 Sep 2025 10:17:52 +0000 (UTC)
Date: Tue, 9 Sep 2025 12:17:48 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Sam James <sam@gentoo.org>
Cc: Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	dlan@gentoo.org, James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
Message-ID: <aL_-zBB2qgbT0bN1@gentoo.org>
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
 <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
 <87o6rqkste.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6rqkste.fsf@gentoo.org>

On Thu, Sep 04, 2025 at 06:53:33PM +0100, Sam James wrote:
> Ian Rogers <irogers@google.com> writes:
> 
> > On Wed, Sep 3, 2025 at 8:15 AM James Clark <james.clark@linaro.org> wrote:
> >>
> >> read_build_id() now has a blocking argument, but libbfd uses fopen()
> >> internally which doesn't support O_NONBLOCK. Fix the build by adding the
> >> argument and ignoring it:
> >>
> >>   util/symbol-elf.c:964:8: error: too many arguments to function ‘read_build_id’
> >>     964 |  err = read_build_id(filename, bid, block);
> >>
> >> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__read_build_id")
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >
> > Libbfd should go away:
> > https://lore.kernel.org/lkml/20250823003216.733941-14-irogers@google.com/
> > but I can imagine that currently this is hit in a build test - sorry
> > for missing that and thanks for the fix!
> >
> > We should probably honor the blocking argument (use fdopen) as the
> > probe perf tests will invoke perf record system wide with data pages
> > and predictably hang on this for files like mmap-ed in sound devices.
> > That said, maybe this hanging will serve as an indication not to use
> > the deprecated libbfd code. From the sounds of things this will break
> > gentoo :-(
> > https://lore.kernel.org/lkml/87ldnacz33.fsf@gentoo.org/
> 
> Just want to say I haven't forgot about this, I need to find a moment to
> compare the bfd and nonbfd builds to see if everything works OK
> now. Will try do that in the next few days.
> 
> The disassembler/objdump use was definitely the biggest problem so if
> support for binutils is here to say there, that puts my mind at ease.
> 
> Has Andi mentioned what issue he had? amadio/dlan, can you weigh in as well?

I don't have much to add. If no functionality is lost by building with BUILD_NONDISTRO=0,
then we can disable it for 6.17 and later, since it's deprecated in any case.

Best regards,
-Guilherme

> 
> >
> > Thanks,
> > Ian
> >
> >> ---
> >>  tools/perf/util/symbol-elf.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> >> index 033c79231a54..e0d6ff7d0acf 100644
> >> --- a/tools/perf/util/symbol-elf.c
> >> +++ b/tools/perf/util/symbol-elf.c
> >> @@ -873,7 +873,8 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
> >>
> >>  #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
> >>
> >> -static int read_build_id(const char *filename, struct build_id *bid)
> >> +static int read_build_id(const char *filename, struct build_id *bid,
> >> +                        bool block __maybe_unused)
> >>  {
> >>         size_t size = sizeof(bid->data);
> >>         int err = -1;
> >>
> >> --
> >> 2.34.1
> >>
