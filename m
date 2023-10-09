Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3438BB2
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqFHNkgB"
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5BF9F
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 09:22:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5032a508e74so7015e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696868561; x=1697473361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eN5/tm1CszkBi5CACTQEAKrzQx6IrUZ94+b5uVmgWK4=;
        b=SqFHNkgBeXgHIPfic/jFE9FbmCdCJAfN6Pu/ohiAyuUxawDFacdlBWr+QIqyyWIqKA
         0QLYo7Fba0H0+mpiTOZ7iTHGkv/MWa3kJUK6lataBEzSMMrkB22FG8SySqzXmf7QV6Gp
         2nMd/JtsK0ec18dlLahHRubzzs/I6Mwysh73lZAgnD7INV3AVdAISwt3gYSkMb6uBdgP
         2BkeKA6tWbKQ6wi74Nl/xRBzatJqUmiM29DKD3uAfw+tg3pX8NBm9dpRUX4JDdCL82co
         AhONIhI5py9UaAb8XaxI5R6TEbEUNKCTayCHNMPyDGgVtrDQOOvytryN9WlUXpPBKnOu
         6nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868561; x=1697473361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eN5/tm1CszkBi5CACTQEAKrzQx6IrUZ94+b5uVmgWK4=;
        b=cGBnth1Vkue+Pa7XRyEO7+RurT5LuLo48TM8fIXQp0QPOWqKIlTN1l6mRVCi4CRZry
         fQdQcMqv+gl4qkiKYMlVsYDfiplihCg9w2yiyXHrfNXy5MIwCZL9ZHaXVWKhzLHOjRlP
         MYP1yDd3oseVitFBlfnEa5A5PtXYWLpv7Vk+vvReo3bers9hPBCHvLBmLhRsGeGTxD3b
         QuGeCx2iG9nj6mJiN5QurrJnPtypswpgwj/XmKj1fq0REfvU4P3hwYLJ9Y9pufR+0JiH
         QL08tSet2Kb3zSar/sn2d4gT8o0MhiKI09yt+zKf9uzwnGRTTxuaIKUj3BNnbqpFH1nG
         yUsA==
X-Gm-Message-State: AOJu0Yxs38y9JQSyAxGQR0iuclQAvwGmDssGtIq5Lgtc0i5nfLD4rLfa
	lcVl0RYxB8OwjczGow6swmrSTmm8j2mUeKXRfpaZLg==
X-Google-Smtp-Source: AGHT+IGlKH3BqD0VkM33kCF3I8vg5a06QPB7mGu7SImCtuxjTB4hlaPZKhR3ELfvaLAqTH1s1pn+eL8Fum0ZXA7kbmQ=
X-Received: by 2002:ac2:558c:0:b0:502:cdb6:f316 with SMTP id
 v12-20020ac2558c000000b00502cdb6f316mr227512lfg.3.1696868560649; Mon, 09 Oct
 2023 09:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-7-irogers@google.com>
 <CAM9d7cjB_Sm4xnXexDqq_Q4jmOrwhxBjQbAhr-UTmb_4CPLONw@mail.gmail.com>
In-Reply-To: <CAM9d7cjB_Sm4xnXexDqq_Q4jmOrwhxBjQbAhr-UTmb_4CPLONw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Oct 2023 09:22:29 -0700
Message-ID: <CAP-5=fUEFcMpAS1q+M7RNdREy4gHaJmD8N5aVXowm5gyEJ_hnQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] perf buildid-cache: Fix use of uninitialized value
To: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 11:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > The buildid filename is first determined and then from this the
> > buildid read. If getting the filename fails then the buildid will be
> > used for a later memcmp uninitialized. Detected by clang-tidy.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-buildid-cache.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-bu=
ildid-cache.c
> > index cd381693658b..e2a40f1d9225 100644
> > --- a/tools/perf/builtin-buildid-cache.c
> > +++ b/tools/perf/builtin-buildid-cache.c
> > @@ -277,8 +277,10 @@ static bool dso__missing_buildid_cache(struct dso =
*dso, int parm __maybe_unused)
> >         char filename[PATH_MAX];
> >         struct build_id bid;
> >
> > -       if (dso__build_id_filename(dso, filename, sizeof(filename), fal=
se) &&
> > -           filename__read_build_id(filename, &bid) =3D=3D -1) {
> > +       if (!dso__build_id_filename(dso, filename, sizeof(filename), fa=
lse))
> > +               return true;
>
> This won't print anything and ignore the file which changes
> the existing behavior.  But if it fails to read the build-id, I
> don't think there is not much we can do with it.  IIUC the
> original intention of -M/--missing option is to list files that
> have a build-id but it's not in the build-id cache.  So maybe
> it's ok to silently ignore it.

If getting the build id filename fails then 'bid' is uninitialized and
I don't think there is an expected behavior for what a memcmp on
uninitialized memory should do - we may hope that it fails and get the
pr_warning in the existing code, but that warning depends on reading
the filename too. This was the smallest change to not change behavior
but to avoid the undefined behavior (bugs) in the code. It could be a
signal the code needs to be worked on more.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +
> > +       if (filename__read_build_id(filename, &bid) =3D=3D -1) {
> >                 if (errno =3D=3D ENOENT)
> >                         return false;
> >
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
