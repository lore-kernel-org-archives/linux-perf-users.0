Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD21400E1A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594129; cv=pass; b=rv4w6hSfa14SaLS4/ipd2lxmYcKePP6n9ihlJlAG9S1lbsSiuozPdnNoOZjkfnU3igSC2Rnkd+ttfm/xk6gKnHj63ed9YBBg4Df0Z1nQnlh1Qh4izcQRI0udjXEqrDb08Z7Pn/MQAHWsrI278VHG+TxK2bNH/5oo/fzp8RTwo2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594129; c=relaxed/simple;
	bh=YUwR06KfijzotDDs96mSCjSDQR/KCAc0RJETt0Acpao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqnqCxTi9CTOfvS3M/eCHONNURsx7YRUeq30gfFmNmkviyfJ7sQovrAyZKffRNDreYJ0ukmfvUT52TQytw7Io55dLpxCv6fTg+VIp1KG1qXGwYYeDKWvA5pwWrtvsmPsVbX5Uydq3+Zl3MgILXkvlzZcs2gjncJEX0OGsIjBDTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdRe0I/s; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdRe0I/s"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so63941cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 14:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789594123; cv=none;
        d=google.com; s=arc-20260327;
        b=eC9Dl2RzWhEk/s8/lbvVd0oAv8ENLYWlrh+YKWEVCk/Ut0yB0rteFWT5GOVyHjsUmD
         w2LLSF1otndGEXNcOpVhfnRDXjwgL2miPEqaUKewkVrw2XnMySB1o8MUP6CCUnf4yiwU
         1ALjVFb8ayocOLdiJ81oY/3m3BSXHR5WMZGFJUTYZFsV5zNOf40UadFFf9UIkCpTl9qm
         wtJfv9y1kMX0t2XOwJepe90QVNuv7OTNv3DtW6hDC5fwUeBv8CaDKFX4lLUqRwAAeuAB
         FT/1eFcWsq/oriVo9EjFSwuxA5+MgQAIG541ebuRJJMcoYowWSLDYNe4hffq6tM3+N5o
         hjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s72Aiwd08tLSHVEGhBE66Mgj5SoSLoZ3jc05S1MlJso=;
        fh=gX/TDjz5r2+xhAK4fqLk1FSaew7cNskmAXu9urTdCrs=;
        b=JGKp+iV4a4Js6nA3V4I3pPRBJ4vzKSI+aKnudbRWLdPht6sXswLS6F5iImUS9PgPRq
         rD4MBeaoWnd8DYfjtPpLubJxKKBCE5S2lsRF13rNG6i+NoklYHCs6JY8gDkgXVWwhpOp
         nct+ctLyu7xJvPqK2qnQiR/tzhfIEbJvyBygLfS0S/F2mplyIXxm1TrZJf2Tw+L9LfS1
         jJSNJ8PQixmCfG+fbssVzdigpPLm7mtDr+aKrvsFQLxT8P7bbmewafvBvg6uNa5HLEQc
         7aRbq/NYt4D8wOMFmFly/01fo+s3Lqukv2XFPamSQI3Jy3PbJJEFtK3CyOwnp2+Nt3ze
         p9VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789594123; x=1790198923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s72Aiwd08tLSHVEGhBE66Mgj5SoSLoZ3jc05S1MlJso=;
        b=KdRe0I/s7Qw1mvMvJxaMV9OmHNH6EsEyzQw8hcW77ezuLWd5SvDN1YrR+TTm9E5oU0
         ZrhelBhlcpeUjTZsue11FnRNwa1wK/KEsqZay0bZvfHCbCIfWgEM78CVRvbn0/OjFSqm
         sVviqRSCwOU3Dho/+kdvvQYQeavYpxXasK8v2MaWCahj6nUYtibchYDgQe7TU03D64Wy
         3JUdhQLa2HXgeCc9w1JnLBRkc0Dxf+W0ZzClG39fU4n6oJSqY1jP5XjVfznOjJKKFnMB
         iFp21sCcH60LuuTk6bt9YHSpmN8nwbl2L16vKGlwJ/iAGnBP8UunyUITxOxTEBZnTeRD
         4xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594123; x=1790198923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s72Aiwd08tLSHVEGhBE66Mgj5SoSLoZ3jc05S1MlJso=;
        b=E6ERMHDw3hsfauty6MwZVTUWekQoyUDjnJ5rA5hLLJc2+fZeSzCxPLSjCTOt9wKilg
         fOf7IYjpI1c3VNj+FgAzxwQCQ4v9ydv68++BxEWsGRT1xr0EgYU4lXhBZeWNA2VARv6x
         nGaAx1BWlCXJudHxsTP/k0WCgRCfgl2hMEVgHd6p6NW7aYu3jSLOEBIVZ1sM13+thjvf
         lhD87wqQgAGO+/YYDANnMpJcqeQfeByp8647rRsdVYjNKT0umumftbrkT1r9b711dqTV
         4AUzpAOGFIQcAtRtlBpZOnoSoqHVoJ1/oDW3W4+QYWG8doauekentIOUwe23PfGvqiKI
         8vlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyS1wZHbkjNfAYUxD5JJy1kLfJ5iaYHk0y1q+Dffe82dSVMdD97uUk6Ng2j3bXmaDRUE5nWMDmrhSiwFyg/TOG@vger.kernel.org
X-Gm-Message-State: AFuF++knbsNSDWKao2HbRTZwsIiigURarZXQoaXsMdP4WXWjM7Fu0/o5
	QXkeu1G2ltLPoBUiOKBiZlmt+omccoQj5HzuDUmOH73y8ZhzNyhdJGoqX9MejvgXMW1P4u1LjMt
	o5KY+DrPfS6z54119S2w0Lwf791JalVYsJbGnmQSQ
X-Gm-Gg: AYBFou0tvpwHnyj9ZUXs+sWz/Su+/u9yML3j8LaKmnSFLikej0+VbqVg19gsIm3RI8X
	GrZWDSWnuqgBhElAXfBWhDynyluTdsmxfFvjqmRGh9Fn1tsbUl1fiqfcGJpZ86D05xsCoHZqx/g
	Q1F2hpLgP4okx6mrvJRHf6jcEAa65FqZU/uEK7v5rjhuFceA4YzbZqVn6gMpADhWuTXoiBl7XNg
	D3msEX+iD66M16NOKBwKPWgr46XH5JlBTRs/pUvr62URC7r4W5ianjz/OXobGAISG3Yd1e5dEr6
	IKiGdtxNItMfnYfsX0dxnDbkp0t2K/emZhLJh0OMqXSWPgoZYFsX8qMb8sT6tqmAgF7Nee+10K3
	TmilHT0fPrQ==
X-Received: by 2002:a05:622a:997:b0:531:2284:4b09 with SMTP id
 d75a77b69052e-5328f60023bmr2133181cf.11.1789594122555; Wed, 16 Sep 2026
 14:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916114740.48230-1-acme@kernel.org> <20260916114740.48230-3-acme@kernel.org>
 <CAP-5=fWr46YKripkCvFHO23k+0SUHfGgYBTDc_qp=ev_Fucc1Q@mail.gmail.com> <aqrnssk8iekDb2jC@x2>
In-Reply-To: <aqrnssk8iekDb2jC@x2>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Sep 2026 14:28:30 -0700
X-Gm-Features: AcwNN1VlErUUCeTqU18K1NPc5Ae8LzseiEP1ZUqNOgwz4nBBaWsYZxwihdQXnOs
Message-ID: <CAP-5=fX4oNH6zU_jzc9Dmi0oTFXHLhoUC51YHrADVsaHH9xn3g@mail.gmail.com>
Subject: Re: [PATCH 02/12] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:02=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Sep 16, 2026 at 10:59:31AM -0700, Ian Rogers wrote:
> > On Wed, Sep 16, 2026 at 4:48=E2=80=AFAM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > >
> > > perf already uses debuginfod to fetch source files when annotating
> > > (via probe-finder.c) and 'perf probe' has open_from_debuginfod(),
> > > which queries debuginfo keyed by build ID when a module's debuginfo
> > > isn't found locally, largely the same thing this adds; eventually
> > > that one could be moved over to the new helper.  For the analysis
> > > tools there was no way to obtain the debuginfo for a DSO in a
> > > profile when it isn't available locally under the name the DSO was
> > > opened with, for instance the vmlinux for the kernel a profile was
> > > recorded on when processing it on another machine, or after the
> > > kernel and its debuginfo package got upgraded in between.
> > >
> > > Add debuginfo__find_build_id(), that uses the debuginfod client to
> > > locate a debuginfo file keyed by the build ID, checking its local
> > > cache first and then querying the servers in DEBUGINFOD_URLS, and
> > > debuginfo__new_build_id(), that opens the DWARF in the file it finds.
>
> > When do we have a build ID but not a DSO? The current intent is that
>
> Trying to parse this: Before we had a PERF_RECORD_MMAP with a dso name
> that we, at the end, when enabled, would look for a build-id to add to
> the perf.data headers, now we get both in the PERF_RECORD_MMAP3, right?

I believe the dso_id allows look up of a DSO before having its name.

> > dso__debuginfo hide these complexities. We currently don't purge DSOs
>
> From the cache, right, and that is a problem, we need to do that LRU you
> mention, to not have a ever growing cache.

Yeah, I think we can periodically scan the machine's DSOs, and if the
reference count is one and some LRU metric is met, we can drop the
reference count to 0 and remove it from the DSOs array. Since the
debuginfo is owned by the DSO, it gets cleaned up as well.

> There is a recent patch from someone at Uber about another aspect of
> this, the symtabs loaded in memory for resolving symbols are not in any
> way constrained, we go on loading, not purging, hope that patch gets
> resubmitted addressing the sashiko reviews that were acknowledged.

I've missed that one, but it sounds good.

> > and the first call to dso__debuginfo should trigger loading with the
> > DSO owning the debuginfo. With this change we now have a duplication
> > of DSO's data, keyed by build ID and mapping directly to the
> > debuginfo. I can't see a performance or efficiency gain and we could
> > potentially implement some kind of LRU mechanism for DSOs, which would
> > benefit memory usage for things like perf top.
>
> > > The debuginfod client fails when DEBUGINFOD_URLS isn't set even when
> > > what it wants is in its local cache, and the distro setup scripts tha=
t
> > > populate it from /etc/debuginfod don't reach cron jobs, systemd servi=
ces
> > > and other environments that don't source the profile scripts, so also
> > > set it from the .urls files in /etc/debuginfod when not set.
>
> > I found the explanation above hard to follow. Are we setting an
> > environment variable because debuginfod isn't respecting its /etc
> > setup?
>
> IIRC what I saw was the debuginfod client not finding things in the
> cache when that DEBUGINFO_URLS variable wasn't set, so setting it
> doesn't mean to ask for downloads necessarily, but to use what is
> already cached locally.

Perhaps we need to get this fixed in libdebuginfod. Or should the
local connection to debuginfod automatically scan the /etc directory.
It sounds like an elfutils bug that we may need to work around, but we
should probably also raise the issue with elfutils.

> > > That has
> > > to happen before any thread that can call getenv() is started, as
> > > setenv() is not thread safe, and there are getenv()s outside the fetc=
h
> > > lock: libdebuginfod reads DEBUGINFOD_URLS in every debuginfod_begin()=
,
> > > which perf also does in build-id.c, probe-event.c and probe-finder.c,
> > > so do it from symbol__init(), on the single-threaded setup, and not
> > > lazily from the fetch path.
> > >
> > > Querying servers, possibly third party ones, sends off-box the build
> > > IDs of the binaries being analysed and a fetch can take a while, so
> > > this is opt-out: on by default, off with --no-debuginfod, with
> > > core.debuginfod=3Dfalse, per tool with report.debuginfod and
> > > top.debuginfod, and, since users that set buildid.dir to /dev/null
> > > (e.g. Linus) or otherwise turn the local build-id cache off clearly
> > > don't want fetched files stored on the box, off too in that case.
>
> > > The opt-outs also cover libdwfl's own debuginfod client, that reads
> > > DEBUGINFOD_URLS in every query: when debuginfod is off, be it with
> > > --no-debuginfod, core.debuginfod=3Dfalse or by disabling the build-id
> > > cache, the variable is set to the empty string, that the client treat=
s
> > > as an opt-out and fails the query without even looking at its cache,
> > > instead of being exported from /etc/debuginfod.  Tools that manage
> > > DEBUGINFOD_URLS themselves, such as 'perf record --debuginfod', keep
> > > doing so.
>
> > Libdwfl is part of elfutils and so is debuginfod. Is it possible to
> > share clients?
>
> We need to stop using ~/.debug/ and move to have the cache where elfutils
> libraries have it.

+1

> Transitioning should just use ~/.debug if available but saving copies of
> local DSOs like perf does in the elfutils cache directory.
>
> <SNIP>
>
> > > +static bool build_id__equal(const struct build_id *a, const struct b=
uild_id *b)
> > > +{
> > > +       return a->size =3D=3D b->size && memcmp(a->data, b->data, a->=
size) =3D=3D 0;
> > > +}
> >
> > This is probably worth moving to the build-id.[ch] file. I see similar
> > logic in places like __dso_id__cmp,  dso__missing_buildid_cache in
> > builitin-buildid-cache.c and sort__dcacheline_cmp. dso__build_id_equal
> > has some special backward compatibility checks.
>
> Agreed, will do.
>
> - Arnaldo
