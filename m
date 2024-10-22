Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920991BD4FD
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617681; cv=none; b=ZltXJ59tAHiB0YQZZ7Jk7SRATYduJ6xkjqRF/rwsziLHvuhqQ4Ib+LZE51Ol7AUOk5PDCcj+hSbeFvy8ektMmlvimXaUzITWFsBRGjRsj042a/lVpTHuHWpOTxO3QwrE+V5ITgtfwNjaV5vcFt4b1dQOhNAjHWO7WiKjTeNjSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617681; c=relaxed/simple;
	bh=b1CGs5gpBNBkiTDp2Q1qyoLrLUaK244tosMToWA6kRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUc6Q4XFT6RXsci8lq1V1lXjm+0oTYgkfDS5d6mof3J32R0DSM/YzXLQXb120f2kqc3YNEpwdc3YJ/BhXrQaLRsQycO6/YBYzMj0uiz19Z8G824/Fp6I9UIupRhn5Z4ZSupCuYodaYmok1LgBVJu2dc+d6TMvgeq1EPSzRw5sjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxjpZ8VZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxjpZ8VZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca03687fdso14585ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729617679; x=1730222479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZM6LcuJUHveMyLMVTScG2H/Hgd1xFmDZWDJH7F3T90=;
        b=QxjpZ8VZ8zuOOfzNt3XlufbVHbyarZLMVnUOehiazHgWmW/kjQ9w7PaKKKxlhIVuHb
         kpyttd/mI2wHl4DZMXW/yED3XXB1OsWST5BsQMjaslzuE54rmoztmw5Nux0xQK7ox5pN
         gzvYydYF3Le32Fq4N/Rk0QA9n3TKBT8Ugp148vJ2kpDZgCIkCuRSO+blBUKt2g69SiM7
         XlEU5bY6+grCpJOLYKpFp4nt7Qp6eJGKR2MXLb/T+DlGInrToEQ4hIm3KNy56YLy8YkN
         Hb6ANq+1HRJoWf85riS/Fx6E9S4E6qTIqG8mwRnTg8YD7HLvK6CtGcOVXfUOb20+E5Tb
         1LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617679; x=1730222479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZM6LcuJUHveMyLMVTScG2H/Hgd1xFmDZWDJH7F3T90=;
        b=DoSn+Btg7+/M8IsczBIEKMXYRcTC1XbHQvdOsVq08HzhGMshE6pT8xiOgoxwhhP3Kd
         ktsKDkhLZPlaABELueKhq0aVCO95EpdKzHRhpzvwdOkja3usK80SjNr0I4FK75ITN6R2
         OnrS+TIDvGq0C27It2DBNhnRKshKbHDuum8Ed8mco9n3Z0sP7sG9FPfsQIMY/uDRgLHy
         RBc+CMmgymo2iheGJGsgxOPlQtv2ZC1mt2dsnowd4gV/Bwmck9BQyBGq1zFzcPLNEKfx
         PXZ7H5neIJKXsEe6NWgHbYQ6tNbvHUGGCHkuYGCz/265PlgsnBejzaiuhEgAAEKYfhQy
         4VXg==
X-Forwarded-Encrypted: i=1; AJvYcCVXQLEOo0LqQkDNL8i+Z5toSVj+TuMz5xis7yBwp6kOOmxk5CH9Mk+JxRrBxDSHNaKi5YJQPFlacw53temZCpuw@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIiVtgo8wYDxGiABv1sgYdE0m2mauQxCPHKsdKHsWK8+ezCge
	sf2RowysSzsciHqgkSn/QKVsWru/T/IkQGHf6ejJHrIyDeMnOgm1AJN8pl5/Y89N/vWnzQVBK0R
	zDjmjULr81wbNLksVJe7c5FxlAs/JWDrI4F93
X-Google-Smtp-Source: AGHT+IHS9uM8Xo1yuRSba82XgJ86Gi1EmrgIM4rxPyqQKJRmoDr44vwEofb9Y65MfBbw6NLyhZffbqJpvx8ZTBHl3x4=
X-Received: by 2002:a17:902:ea0e:b0:20c:bb35:dafe with SMTP id
 d9443c01a7336-20f80c9f411mr31535ad.0.1729617678531; Tue, 22 Oct 2024 10:21:18
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com> <20241016042415.7552-8-irogers@google.com>
 <Zxc-bFLNAh7nrVQC@google.com>
In-Reply-To: <Zxc-bFLNAh7nrVQC@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Oct 2024 10:21:06 -0700
Message-ID: <CAP-5=fVNwx7D4N42hDeBQMopCuoW-Q4BUch6am8X_jJDeFDy7w@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] perf stat: Move stat_config into config.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Oct 15, 2024 at 09:24:06PM -0700, Ian Rogers wrote:
> > stat_config is accessed by config.c via helper functions, but declared
> > in builtin-stat. Move to util/config.c so that stub functions aren't
> > needed in python.c which doesn't link against the builtin files.
> >
> > To avoid name conflicts change builtin-script to use the same
> > stat_config as builtin-stat. Rename local variables in tests to avoid
> > shadow declaration warnings.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
[snip]
> > diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> > index 00adf872bf00..9712466c51e2 100644
> > --- a/tools/perf/util/path.c
> > +++ b/tools/perf/util/path.c
> > @@ -68,6 +68,16 @@ bool is_directory(const char *base_path, const struc=
t dirent *dent)
> >       return S_ISDIR(st.st_mode);
> >  }
> >
> > +bool is_directory_at(int dir_fd, const char *path)
> > +{
> > +     struct stat st;
> > +
> > +     if (fstatat(dir_fd, path, &st, /*flags=3D*/0))
> > +             return false;
> > +
> > +     return S_ISDIR(st.st_mode);
> > +}
> > +
>
> It looks like an unrelated change.

Yep. Should have been part of the previous (patch 6) change.

Thanks,
Ian
