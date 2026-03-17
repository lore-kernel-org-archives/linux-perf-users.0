Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E3B20ED
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774500; cv=none; b=mJlg2uimi0iDFunNfAHkjplZEVH8WGV8FSx1qc88etaabAzPN8eSIOuWBaAco0dW/pgTt63GUA/vrXyzI+BwPjH4VLBrmFvj2XuNWmAqPY7UA1mwpEHIE+dZu86nPcbUyoujEau4wDxfB9etKB+3HgEoqBn4qYNNwqT40j3AXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774500; c=relaxed/simple;
	bh=MQuZ8zNAhnuVz5iAfvFkte71HHNzFPcNkkRHPFWG8SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jczBvQOCXOgNkiPpcrqtBxUcqWt6kBDII+AKPBu5zsT+3SSlvjDWYbqGECg0y5M7OiYWLAE6owZc+xvaYrpbqOTyM7ChzxoaySYnRfAahvnW5EslHNgADoqts3PpHZ2aX06/krlaGiyZL2x57ngykePto/kIrIVcD5kGPlicvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118031477;
	Tue, 17 Mar 2026 12:08:12 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDC793F778;
	Tue, 17 Mar 2026 12:08:17 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:08:15 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] tools build: Link static libs for libopenssl feature
Message-ID: <20260317190815.GL8048@e132581.arm.com>
References: <20260317-tools_fix_build_libopenssl-v2-1-9362c14f04b8@arm.com>
 <CAP-5=fXopOUKZ=Hf1s5CZrb0CmH+W9XQa38JW9Bv+GXdYrcHnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXopOUKZ=Hf1s5CZrb0CmH+W9XQa38JW9Bv+GXdYrcHnQ@mail.gmail.com>

On Tue, Mar 17, 2026 at 08:52:23AM -0700, Ian Rogers wrote:
> On Tue, Mar 17, 2026 at 1:50 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > The perf static build reports that the BPF skeleton is disabled due to
> > the missing libopenssl feature.
> >
> > Explicitly linking the libraries fixes the static build failure.
> >
> > Fixes: 7678523109d1 ("tools/build: Add a feature test for libopenssl")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/build/feature/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 1fbcb3ce74d2173072748a417fc63bd9a5b13888..18a9abf6bfc43e86ecf58b96e0374a0e3c613bb0 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -384,7 +384,7 @@ $(OUTPUT)test-libpfm4.bin:
> >         $(BUILD) -lpfm
> >
> >  $(OUTPUT)test-libopenssl.bin:
> > -       $(BUILD) -lssl
> > +       $(BUILD) -lssl -lcrypto -lz -lzstd
> 
> I wonder it would be better to do something like test-gtk2.bin so that
> if openssl wasn't compiled with libz and libzstd things don't fail:
> ```
> $(OUTPUT)test-gtk2.bin:
>        $(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0
> 2>/dev/null) -Wno-deprecated-declarations
> ```
> so:
> ```
> $(OUTPUT)test-openssl.bin:
>        $(BUILD) $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
> ```
> Since "-lssl" is a dependency of BUILD_ALL, that will probably also
> need updating.

Thanks for suggestion, I have sent out v3.

Just record for another issue:

I was not able to build test-all.bin successfully with static linking
until explicitly added -lexpat.  Seems some Python extension libraries
depends on libexpat, but python3-config doesn't include this dependency.

This would be a wider issue - as this is not limited to feature build,
we also need to fix perf's build as well?   I might look into details
when have free time.

Thanks,
Leo
