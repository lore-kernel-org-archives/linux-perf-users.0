Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DE38A70C
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975550; cv=pass; b=HK+CbIpxxrd6/tgGY7xHcBXaXSMmn/Qcn8R7MJ0xQiqSsKaow9okXbwsx8wvmGZ6Re13+OzpVnW9pMkltD2bs5RaogrdkQ2D43uRMkvly1Nq92TRbSB/JVx9GgxSQ04AA4qcvat+ricExSA19Hqb3wncZHnZzOF/tTRUw6I/dFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975550; c=relaxed/simple;
	bh=A+l2uOZiE885Clf82D9m4D6h5QCktWdZ0NdknyEO3+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MRxUz0fzsP0q6ixpfbqo36hoUx6EaWr3yCO4E7LwLdS2HvjVlV5cmvJMvkUHtRXONtu4z1xUxFri3zTDqOYpgPYd4QqX9hLMD+2iyJ90qPeLyOK99hyTvutW8NEj+7XAAplp1FthFIQWvSbqAlgSgwesJYpj2ZkGr4Ei+rvIvzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbjWuaBO; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbjWuaBO"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6cso126665ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 10:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788975548; cv=none;
        d=google.com; s=arc-20260327;
        b=eG43tX9tPSLPF+1WXr7huXGlZ9T3Yb9ho5gHL6TP/I9padGYGf2kikVmLGrGvoahAF
         UQc3rAPiSUUhI4AQ627Od9gJB+ikGjihHmrH2sOZIyiriAwCMyfU1luwO0z+sIVLZ0pb
         2SpnB6SlYAlGSC7F8Dy/tg51XZIpoiwvxZMi0GlgvplidrlA+fQBQ3O9CFAMYdmYhDBD
         bUqCp0+tPonaUmvG84cQZtg8RAjf/qWo0ynQZeH8kVn4LD5h7ud3wy86FBKM0etwc7IT
         9V9eqesLmFnU+qBh5t+6y5vrT4BQWFAhvXM9M64Oj9bD15amP8AONM+OjllxW6ZTqvTV
         O4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xqefN0TJHS4Mu2A0Sq3q9XaWe1ustzTMoTSehI/18YQ=;
        fh=zfQAAW9xaZ+En18t+U0PNxi16P6fbhaUzqqNXwwF19A=;
        b=hlOIbOSdYZwkgQQKXM88HQK7AHBd/jfa21JAXWIcGBBOztT//x7QrpZwVA0kKLeXTp
         lLfX0QTUQLM8GuzL+CvsrzNyJihNZc2wfY4MrMkipEpbryDdSGo4X5fenWwh1hU6jgLz
         oHMr5ibYJ3DmynFL6/vPNc8qIcHYbmL33G6blowKVzwlQfZaTNf5EQg0046TUfb/4dtR
         6FGgRixdMVVljCbQY5Au1nXnIJt+Q2ILZiZTJzv8REyzMU/1HyZl8MuBVnHFanlay/zI
         TJHUNXQ8Qj0XQIZvqpE+d6tRbcHEeD/tbuwOLxwiDkDeG9kicrpp62BMT88Kv08JO6vK
         Lc+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788975548; x=1789580348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqefN0TJHS4Mu2A0Sq3q9XaWe1ustzTMoTSehI/18YQ=;
        b=LbjWuaBO7qtWjIKKI6L617vWI7gGb+EoEgwCeKm5H+EpUxqgLfTMhHebpQc2k0vg5T
         TuPSjAunwNY80/9LrPRZ0k6lkRBHYH45KCJdfvt1p7Run0C2+t943BtcfgK0nBsb+tME
         7MSds8ruk09H2TEfG3Si4skozoBJ7R7/mnRuhsv+AdubJQgppOrYIkACZRA5tC7sojnn
         P8hVSTWnSOhdjLFR6ztQffyXyx3wGi1Ed8Pxuja4zeCrc6IklWtaaeL086kSHppsvLDE
         Xu79zYPGTmveal6sJ1WIM6VWp1nouloaDMIdrxmnjphRg7uOpGeRZBWWpFASmIjQPGCo
         AijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788975548; x=1789580348;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xqefN0TJHS4Mu2A0Sq3q9XaWe1ustzTMoTSehI/18YQ=;
        b=i0iZ6ROhClU/j0/14w0mmrF4YnPWRfJoV78WkkSgt+lZ00JQovih4plLfZ2JKe0FCJ
         5A1qC3v4jKTssXLdcSoT8nc0UQo3DrUq5DghwGOz9gtQJcni7xQi+ahf5UHBq6hBu14N
         VmkQAfBmlEGbgKEl+/UK2uIJc4jOcc4MROHO2g+/qNDdS1YbQweW3rVu6+iTSzo6Ac4W
         Ec6LylRpaUJ9wRo0HI8vpdu8QwWPrWAmvD8TCHdAMbILDU7y0rl0Xm/M/lfy1J0jmwLd
         8IynUi2ErBCzDR/TzHzz3ZBiOd+Fs1SJEyI1ws0U3iwQthnIK5CS+cVWDm9i4NGe/S3k
         BVIw==
X-Forwarded-Encrypted: i=1; AKwUvByxXED5wtrEunJm/AQtV9pVinFm1/QamCkmJ2M9FW7Jo7e9Gx15YG7Edd/0iAxghn8WX1SZO+IuQE40BcFLzPUG@vger.kernel.org
X-Gm-Message-State: AFuF++k48M+JYnbKKQyA3X35p+eEvXZIX0wHDViQb3SDwaRdIARnFLDV
	20s9LWq4nbVa8jkOIJmhQ+PD39QqZlattK/7JZGwFgKdsEE2dE0YEVlKvqmbf8HO3MZYOJ5FXqM
	H3y2jO35TMDnBdEzkDfNjBfk8blORMpTK+496iIPp
X-Gm-Gg: AYBFou0r1W/lPKsdLgwQMXOukc44LL6xask2KJQxFoBnqUXOyHBoLPQeqqoAM9N3uHJ
	Ne0y64GxuaLgIfqcqlYkK8HIvWrsQFOfK8xG5GhgakC9GmT62IeRIxGr9Cs/ApnJfxpCPY9mNXt
	9Ef/qbicoW6r9GxDf52MxuomvlRuMxdI+2jlpZCfIPdrcHkHCl26haUB2s+YarmmL3wM45m2XOr
	dPmSU3yCjrrfC1fvOgtiFwp++8tIhMinz0Q75O2XNIqiINB3NcIInqesEMIOC5W0FTevFOhTKtf
	EbjbY6d72ZAcqRE9MLVcyiOF+jTXkmlmsMnW6vqjKWl3u3NVFG57X7u4CMlDmxIFSqrGY9EyfZA
	NT9CsP1JKyg==
X-Received: by 2002:a17:903:1b70:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2dbddbd688amr10170995ad.12.1788975547398; Wed, 09 Sep 2026
 10:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903045603.3611902-1-irogers@google.com> <20260909161041.1745638-1-irogers@google.com>
 <20260909162119.3C3B51F000FF@smtp.kernel.org>
In-Reply-To: <20260909162119.3C3B51F000FF@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Sep 2026 10:38:54 -0700
X-Gm-Features: AcwNN1VtpUq2iwGbfwZhfTfb7fEQ3-fUN2GBSLGLAPrq-5DAFa1B67Ny4mHwpMU
Message-ID: <CAP-5=fXUU266PHEhYJDXRJZv_XkGiRvGTR94fR+QEzFVKs=neg@mail.gmail.com>
Subject: Re: [PATCH v3] perf tests: Improvements to build-test performance
To: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 9:21=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The parallelization of the `out` target causes destructive rac=
es between `FEATURES_DUMP_FILE` and `FEATURES_DUMP_FILE_STATIC` within the =
shared source tree.
> --
>
> commit 8a5611d5732e412e746570eca199bea2894c319b
> Author: Ian Rogers <irogers@google.com>
>
> perf tests: Improvements to build-test performance
>
> This patch replaces hardcoded 'make' calls with '$(MAKE)' in the perf tes=
ts
> Makefile to ensure proper GNU Make jobserver file descriptor inheritance.=
 It
> also removes 'unexport MAKEFLAGS' in favor of native GNU Make conditional=
s
> for parallelism. Finally, it optimizes the 'out' target by wrapping the t=
arget
> list in a parallel sub-make call.
>
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index d2c2f526e1db0..4a865e58f2bea 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> [ ... ]
> > @@ -383,20 +391,22 @@ all: $(run) $(run_O) tarpkg make_kernelsrc make_k=
ernelsrc_tools
> >       @echo OK
> >       @rm -f $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
> >
> > -out: $(run_O)
> > +out:
> > +     $(call clean)
> > +     @$(MAKE) -f tests/make $(run_O) PARALLEL_OPT=3D O_CLEAN=3D0 $(if =
$(findstring jobserver,$(MAKEFLAGS))$(findstring -j,$(MAKEFLAGS)),,$(if $(c=
ores),-j$(cores)))
>
> [Severity: Medium]
> When the out target invokes this parallel sub-make for all run_O targets,=
 does
> this expose the feature dump dependencies to concurrent evaluation?
>
> >       @echo OK
> >       @rm -f $(FEATURES_DUMP_FILE) $(FEATURES_DUMP_FILE_STATIC)
> >
> >  ifeq ($(REUSE_FEATURES_DUMP),1)
> >  $(FEATURES_DUMP_FILE):
> >       $(call clean)
> > -     @cmd=3D"cd $(PERF) && make FEATURE_DUMP_COPY=3D$@ $(O_OPT) featur=
e-dump"; \
> > +     @cmd=3D"cd $(PERF) && $(MAKE) FEATURE_DUMP_COPY=3D$@ $(O_OPT) fea=
ture-dump"; \
> >       echo "- $@: $$cmd" && echo $$cmd && \
> >       ( eval $$cmd ) > /dev/null 2>&1
> >
> >  $(FEATURES_DUMP_FILE_STATIC):
> >       $(call clean)
> > -     @cmd=3D"cd $(PERF) && make FEATURE_DUMP_COPY=3D$@ $(O_OPT) LDFLAG=
S=3D'-static' feature-dump"; \
> > +     @cmd=3D"cd $(PERF) && $(MAKE) FEATURE_DUMP_COPY=3D$@ $(O_OPT) LDF=
LAGS=3D'-static' feature-dump"; \
>
> [Severity: Medium]
> Will these feature dump recipes race destructively?
>
> Since some run_O targets like make_static_O depend on
> FEATURES_DUMP_FILE_STATIC while others depend on FEATURES_DUMP_FILE,
> evaluating them concurrently means both unconditionally invoke make clean=
 and
> make feature-dump inside the shared source tree.
>
> Could this cause them to wipe out each other's intermediate artifacts dur=
ing
> make build-test out-of-tree builds?

As make_static isn't part of the "run" variable set of tests it won't
be part of run_O created by the foreach loop. make_static is only ever
run sequentially and so there can't be concurrent evaluation of
FEATURES_DUMP_FILE_STATIC.

Thanks,
Ian
