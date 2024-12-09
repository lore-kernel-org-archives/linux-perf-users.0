Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE0137776;
	Mon,  9 Dec 2024 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780835; cv=none; b=rnMl0VBdPXUsdGmU+uTsZ+Wk4Q8KN9fFXuOIGft7Xiz8IDfCN2Ls/ygbfigA08VjiBPi8gHLfEwAAg1I0TzWB0XUPxrw1Ph5eUXVAE1RL6Mr4bhYDpHxOscSOg0nFT9E3Bc0I6Y10S/Xb1/6KXxCCPgvbVrk6Z+5Hv/S7TJDKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780835; c=relaxed/simple;
	bh=Yg4CXnabRinKXFQMCrnq4d2YSEjrZ6y3cOfMDGDCluI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0fc1FwSCbSWiq2Kix7nY0L+rzOeoeOUTZQoffFEol3BU+dt8rbzM87Oh55mlGGh3nl5OiB4DlnGjpwYG5aUZhB2xSTAIsHTdGUfJ+sO8oLYZXmBKckwAOYM0pZaM9rZ66yvdHdmBCVq4NwrAZ3CqcvE+VOPjqJKmFAwvaSjz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724d23df764so4502181b3a.1;
        Mon, 09 Dec 2024 13:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733780833; x=1734385633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXa++zGGJYL4a455JdGSAiaIAFv5ZyUE5oWPMgnQn9Y=;
        b=ku0TxS4gnMl+TTNq3xwLCgtzSNlHheh9AQa/nqaFO+OgsU28UNS7Ls3xlTnYcr5kz1
         B6MVLRfu43ncIOIvEa9BuxHSkw9Ibil+V7dNBNs7PaDm59SiN20xhd6BhGzxscGu788E
         NROkM6s5LUQQ+SEr/wXC5kwJsMWQ7RHKD48LxUhBsuXzeo54ZRGamMi94/lUdFguDU6T
         3wfONW+6Rq3rNOj9qO0+iQU09hWHKkseTZRZzqw82EKTgzX7R2QBm5/TwzTFM/No8OWx
         +vqs+mpbN/kzCY0j+xMyhgfG9u3f2HR512qoK0li2kf4r8nm5TC8H1sGj8hc90aw9I1G
         RfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyoledLndrTzIgb6LgxLjbhmHDZkRxoe9HQEp3ho4uWw1o6LNnof5eVAd6HcuxZc+ITY9m0cJbDBDT2y64AjF0kw==@vger.kernel.org, AJvYcCWgVaUk9Mj8IeUBZa5ayG7UDtqqKndzJTdrBWRUmfc7AEwREVdhA7s+Qw2O47WvkdZr6UN6pJZn2lyhD70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjavoSjPKvyyXgaBE/mMznAWrVzFd7i/RzsmKVtXeZ1JW1L1/E
	89vI5zNh8UDRwXVsDixVrm70tBIT1fkhD7RzMI81Sq1InOP/0tHXexy8oRcwmv2R8HMAud4IGCT
	ZwC2wDLMXMjfGjOeWnY3Q0PysDtU=
X-Gm-Gg: ASbGncucKkzPP8/7/P0MtfuDlqulQAHkX2OW3YYhX+RMeIzMsOCPlzLZ+wIPsiOBvNq
	Yf79aCaQSVFaWl5DGlTWpkCoXCmet5IIY4w==
X-Google-Smtp-Source: AGHT+IF4s5D7rUHtCf1IZfrvjwowlVkpuV5qAFrOsdMjeGXuibRhic//imibsY9i1uj0cNJ6AnBD8vHfnRW5f1j2LJk=
X-Received: by 2002:a05:6a00:2e87:b0:725:b347:c3cd with SMTP id
 d2e1a72fcca58-725b8118dbfmr18029933b3a.9.1733780832855; Mon, 09 Dec 2024
 13:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206042306.1055913-1-irogers@google.com> <20241206042306.1055913-2-irogers@google.com>
 <Z1deN2EUjwsRokn9@x1>
In-Reply-To: <Z1deN2EUjwsRokn9@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 9 Dec 2024 13:47:01 -0800
Message-ID: <CAM9d7chdJyXyCw0MTj=AkF9GL4U6scMtO2a2GMwAAFGUW8kL=Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test hwmon_pmu: Fix event file location
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:16=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Thu, Dec 05, 2024 at 08:23:06PM -0800, Ian Rogers wrote:
> > The temp directory is made and a known fake hwmon PMU created within
> > it. Prior to this fix the events were being incorrectly written to the
> > temp directory rather than the fake PMU directory. This didn't impact
> > the test as the directory fd matched the wrong location, but it
> > doesn't mirror what a hwmon PMU would actually look like.
>
> With these two files the 'perf test 11' for hwmon is successfully
> completed on my system where I previously reported failures.
>
> Thanks, applied,

I think it can go to perf-tools.

Thanks,
Namhyung

>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/hwmon_pmu.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.=
c
> > index f8bcee9660d5..d2b066a2b557 100644
> > --- a/tools/perf/tests/hwmon_pmu.c
> > +++ b/tools/perf/tests/hwmon_pmu.c
> > @@ -65,7 +65,7 @@ static struct perf_pmu *test_pmu_get(char *dir, size_=
t sz)
> >               { "temp2_label", "test hwmon event2\n", },
> >               { "temp2_input", "50000\n", },
> >       };
> > -     int dirfd, file;
> > +     int hwmon_dirfd =3D -1, test_dirfd =3D -1, file;
> >       struct perf_pmu *hwm =3D NULL;
> >       ssize_t len;
> >
> > @@ -76,19 +76,24 @@ static struct perf_pmu *test_pmu_get(char *dir, siz=
e_t sz)
> >               dir[0] =3D '\0';
> >               return NULL;
> >       }
> > -     dirfd =3D open(dir, O_DIRECTORY);
> > -     if (dirfd < 0) {
> > +     test_dirfd =3D open(dir, O_PATH|O_DIRECTORY);
> > +     if (test_dirfd < 0) {
> >               pr_err("Failed to open test directory \"%s\"\n", dir);
> >               goto err_out;
> >       }
> >
> >       /* Create the test hwmon directory and give it a name. */
> > -     if (mkdirat(dirfd, "hwmon1234", 0755) < 0) {
> > +     if (mkdirat(test_dirfd, "hwmon1234", 0755) < 0) {
> >               pr_err("Failed to mkdir hwmon directory\n");
> >               goto err_out;
> >       }
> > -     file =3D openat(dirfd, "hwmon1234/name", O_WRONLY | O_CREAT, 0600=
);
> > -     if (!file) {
> > +     hwmon_dirfd =3D openat(test_dirfd, "hwmon1234", O_DIRECTORY);
> > +     if (hwmon_dirfd < 0) {
> > +             pr_err("Failed to open test hwmon directory \"%s/hwmon123=
4\"\n", dir);
> > +             goto err_out;
> > +     }
> > +     file =3D openat(hwmon_dirfd, "name", O_WRONLY | O_CREAT, 0600);
> > +     if (file < 0) {
> >               pr_err("Failed to open for writing file \"name\"\n");
> >               goto err_out;
> >       }
> > @@ -104,8 +109,8 @@ static struct perf_pmu *test_pmu_get(char *dir, siz=
e_t sz)
> >       for (size_t i =3D 0; i < ARRAY_SIZE(test_items); i++) {
> >               const struct test_item *item =3D &test_items[i];
> >
> > -             file =3D openat(dirfd, item->name, O_WRONLY | O_CREAT, 06=
00);
> > -             if (!file) {
> > +             file =3D openat(hwmon_dirfd, item->name, O_WRONLY | O_CRE=
AT, 0600);
> > +             if (file < 0) {
> >                       pr_err("Failed to open for writing file \"%s\"\n"=
, item->name);
> >                       goto err_out;
> >               }
> > @@ -119,16 +124,18 @@ static struct perf_pmu *test_pmu_get(char *dir, s=
ize_t sz)
> >       }
> >
> >       /* Make the PMU reading the files created above. */
> > -     hwm =3D perf_pmus__add_test_hwmon_pmu(dirfd, "hwmon1234", test_hw=
mon_name);
> > +     hwm =3D perf_pmus__add_test_hwmon_pmu(hwmon_dirfd, "hwmon1234", t=
est_hwmon_name);
> >       if (!hwm)
> >               pr_err("Test hwmon creation failed\n");
> >
> >  err_out:
> >       if (!hwm) {
> >               test_pmu_put(dir, hwm);
> > -             if (dirfd >=3D 0)
> > -                     close(dirfd);
> > +             if (hwmon_dirfd >=3D 0)
> > +                     close(hwmon_dirfd);
> >       }
> > +     if (test_dirfd >=3D 0)
> > +             close(test_dirfd);
> >       return hwm;
> >  }
> >
> > --
> > 2.47.0.338.g60cca15819-goog
