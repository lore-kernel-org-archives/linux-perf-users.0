Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A516728E;
	Tue, 30 Jul 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365945; cv=none; b=fTdxbgtEHhNV24r2lbzUy1ZuFdKTltZa0Ak9+PmpSCFFAmRZzzoUtRBayamLIo9A+DnTuwi8RzDSujX8nTDJii8VPzcXUKe6/JP7snEtc/wwgmwMGkho3eGSMlZP4s3kTnpqmlZrDA2vSSH8sT/kYmhxFt2IIBEuORHFNIckhws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365945; c=relaxed/simple;
	bh=w7CbFebxpPXnvhUVwaRjArHkS+3Pz4GvZtHP5aAly54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7gfk7rYe6DSSBInsB6eCIrqW4w04S7W0XjuICUsCKknupnUt4SLbrPF53BwLGxVWebfHB4mitkMHKW/jCxWFEow11/kfqQZXuez9fu8UVUza3PTRaNjXN4GMyR6zmZceARMsIAl2y3tAhAKzZdl4t25XjauL2F4ROSowGLtAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6VfZOpd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6VfZOpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12312C4AF0E;
	Tue, 30 Jul 2024 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365945;
	bh=w7CbFebxpPXnvhUVwaRjArHkS+3Pz4GvZtHP5aAly54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6VfZOpdmbf7QGHjwQCP3Jpv8AZ9xxpMB15d27HvsKr2Gdy731IKAEDrSesz3pThL
	 RsqwqRhQRFjgtT5eWB1vXpmnVE21PfOkRXf/UP6/g+/yHd9NciGT1kB5/wvKBghzvm
	 eRSEnGdM492sp3h0cLGihLYS/dAIHHheAEt4o6nW9KLBOOmyBYntLnMm6bo+Fcmm5L
	 Lw0ynB2SgpWdWd3md5hMoAsL1el1a/BZ1+jHOX0iBdImbHInJH2zK/DRgIHxiJDN+Q
	 yBZrarBRt0XPmkgFuOyN4+87LH/73VU6HmiQq41sUbI9CjnRYneltjWIcbZDNP//tn
	 aTaRyM5j+Y1qg==
Date: Tue, 30 Jul 2024 15:59:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux@treblig.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test pmu: Remove unused test_pmus
Message-ID: <Zqk39lppymxijGvP@x1>
References: <20240727175919.1041468-1-linux@treblig.org>
 <CAP-5=fW+VbDaFV+YQCMMKYzrraMLLuVqb=BChL0o=-D5Y=4N_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW+VbDaFV+YQCMMKYzrraMLLuVqb=BChL0o=-D5Y=4N_w@mail.gmail.com>

On Mon, Jul 29, 2024 at 07:52:53AM -0700, Ian Rogers wrote:
> On Sat, Jul 27, 2024 at 10:59 AM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > Commit aa1551f299ba ("perf test pmu: Refactor format test and exposed
> > test APIs") added the 'test_pmus' list, but didn't use it.
> > (It seems to put them on the other_pmus list?)
> >
> > Remove it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Strange that the compiler doesn't warn about unused stuff like this,
> we get unused variables within a function and unused static
> functions...
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to tmp.perf-tools-next,

- Arnaldo
 
> Possibly:
> Fixes: aa1551f299ba ("perf test pmu: Refactor format test and exposed
> test APIs")
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/pmu.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> > index 40132655ccd1..0b2f04a55d7b 100644
> > --- a/tools/perf/tests/pmu.c
> > +++ b/tools/perf/tests/pmu.c
> > @@ -18,9 +18,6 @@
> >  #include <sys/stat.h>
> >  #include <sys/types.h>
> >
> > -/* Fake PMUs created in temp directory. */
> > -static LIST_HEAD(test_pmus);
> > -
> >  /* Cleanup test PMU directory. */
> >  static int test_pmu_put(const char *dir, struct perf_pmu *pmu)
> >  {
> > --
> > 2.45.2
> >
