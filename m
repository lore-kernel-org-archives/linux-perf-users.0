Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59612AD2D;
	Fri, 13 Dec 2024 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057251; cv=none; b=Ykow9JHyU+sgvnk47OXmHTxUVt7+1NlbOP4x2RSnu9eGEHJPK1oggRUnNI64hE+atqf1rkuMe6xh3X1Udq8gDYBnqyF0ZbKRQTOxz1whYfjYPQtM54gzdbIEuiahKekCEJXVDL4HdBmD+zEkA1oRjp94e7gsbb6V7aHNSyNksG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057251; c=relaxed/simple;
	bh=csky96G/e5d4RnwXyw/QgCwTZBXJuKNz+kM3LsSvtMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZpzj9D7V1JjffMNCz7PtI734stU/tvQxxmfeoi7Koj9NwPPbJBcAnh1zdaz/Z1tQbiWTs3xAq7QUz0lxVLxUil5sqw4mjwiYyudlXRWZ4vwnOzlQA1k6X7f/MO/ZGTNBN4vjQnjhEUQ7xY5wvjk5K69het2ZMdEhXls8Gf5CSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqOl7i4B; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqOl7i4B"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eff5ad69a1so11451237b3.3;
        Thu, 12 Dec 2024 18:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734057248; x=1734662048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUdkxCkBlXWcr1taN4cGOUiY7CXBAq4tEtnO+m3r5l4=;
        b=cqOl7i4Bmz9MQ3VD6uY3M3gl916NmzOpAGIjBUjKBgdwiWCfeWOb3xCM4TFZKh3eAf
         AYSkcqvUAViBCcJrf7W6W4KoqmOx1BVH70AE3hxIfp+HMYgxVVFImhhyIM29z5ux9XB8
         EXuKKP6cJSJwDtLAqxK56gp7P4oD00lHO6V32mVD6BY3EqmQFO+BYs2HRsYQz40KUz16
         V+/uN/xD03CogkCqsXZzefvp8Lq23D+dlqoMN6jP6YXhehoQcoqSm3on9/05rWUAM8Er
         Iw6HZrezFhdKCsKZP8Rgb+q9kYJzttHEhLrut/YkHHND+ZD7x9z9zdOLGU+WStoarRrs
         fMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734057248; x=1734662048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUdkxCkBlXWcr1taN4cGOUiY7CXBAq4tEtnO+m3r5l4=;
        b=o+RFXCFnOsHzgsFVv0J+oTokuOnjinp1IkK6A3TDQ+TQfIYdIByXtLWEvi7qTzpwUp
         9SvpN0rCNu/SqGtChfpx+272EIx3G/1N2grNXWTGdOfDfsyW+5j+zdSyRgIsV/ybrWS/
         GMOSuzL+XFzYcOR/SIVDtwvvpbt0esZ1N0doY7fqMy+GzXe/uIx3AY54Qw1xy8/6IIrN
         +AxP2Dld+lKic7NL6fR4k8v5YHc1t3HNEL6bWZvrddTvhhjHhOTmuNJIRDDGlSPek9LI
         yn9ob8ashkpxd2F0DWQMnQrzz+1DOsJWXJYlu1b/v42xG3mRwd8VgAVm1B0dSPS7rr4A
         q7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVkLXfWAWx2UfpIGfPERjPp2K5pIpP22769r9sCJCyrkYu7fZ+RMMjP9AbJpGil4VvniDrJpC73npeEQd0=@vger.kernel.org, AJvYcCWdJRxDTF7jLkYt0oDusZE+28bEX3nFwKvODnzIXx4Zt0cKjDJBb9G7VwXfdlFGA2auaZP1scrmekzvAGgTE0s/ew==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8sQCYvyoXcfVviCJ75TtL3l9ofbYiLFGx36QFzclGhdccQQ9
	/pi82GLkZENVoA/G/8LY/fzPvPUWMxdJzOmYu6yDbuJkLpPPT2EtUkfc3tJ2TTxKRBRhmGCgZ42
	ys5j4m/gMWQVpZIU8/XtAAV3YOd0=
X-Gm-Gg: ASbGncsr1xExboDXWriN10RBDUZClXKST9oks1Axp13LYp34Gc203I3QxIJOE003jTd
	AOgIXe8OVHzmoKHnU7kgpfSVWk3RJCS6qsu2v
X-Google-Smtp-Source: AGHT+IEso/WnptFEYR4b3oIC8fjQMOHHFGXj917N91YZdM8qGwJukwTHO6MjTSyim297TqbxFP62J0+7S6e8puVpqHw=
X-Received: by 2002:a05:690c:6605:b0:6e2:12e5:35a2 with SMTP id
 00721157ae682-6f279ad6d71mr8085177b3.4.1734057248543; Thu, 12 Dec 2024
 18:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212232717.232507-1-howardchu95@gmail.com>
 <20241212232717.232507-10-howardchu95@gmail.com> <Z1uUz6sU90IQQAyp@google.com>
In-Reply-To: <Z1uUz6sU90IQQAyp@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 12 Dec 2024 18:33:58 -0800
Message-ID: <CAH0uvohK2sc7Em0+Ka=oEQcmsP5KQj-x=VYTUYYt1Vr3qD-d9w@mail.gmail.com>
Subject: Re: [PATCH v13 09/10] perf record --off-cpu: Add --off-cpu-thresh option
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Thu, Dec 12, 2024 at 5:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Dec 12, 2024 at 03:27:16PM -0800, Howard Chu wrote:
> > Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
> > the unit is milliseconds. Default value is 500ms.
> >
> > Example:
> >
> >   perf record --off-cpu --off-cpu-thresh 824
> >
> > The example above collects off-cpu samples where the off-cpu time is
> > longer than 824ms
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20241108204137.2444151-2-howardchu95@gm=
ail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/Documentation/perf-record.txt |  9 ++++++++
> >  tools/perf/builtin-record.c              | 26 ++++++++++++++++++++++++
> >  tools/perf/util/bpf_off_cpu.c            |  3 +++
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c   |  2 +-
> >  tools/perf/util/off_cpu.h                |  1 +
> >  tools/perf/util/record.h                 |  1 +
> >  6 files changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docu=
mentation/perf-record.txt
> > index 242223240a08..f3ac4c739d5f 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -829,6 +829,15 @@ filtered through the mask provided by -C option.
> >       only, as of now.  So the applications built without the frame
> >       pointer might see bogus addresses.
> >
> > +     off-cpu profiling consists two types of samples: direct samples, =
which
> > +     share the same behavior as regular samples, and the accumulated
> > +     samples, stored in BPF stack trace map, presented after all the r=
egular
> > +     samples.
> > +
> > +--off-cpu-thresh::
> > +     Once a task's off-cpu time reaches this threshold (in millisecond=
s), it
> > +     generates a direct off-cpu sample. The default is 500ms.
> > +
> >  --setup-filter=3D<action>::
> >       Prepare BPF filter to be used by regular users.  The action shoul=
d be
> >       either "pin" or "unpin".  The filter can be used after it's pinne=
d.
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 0b637cea4850..62183a6857f2 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3147,6 +3147,28 @@ static int record__parse_mmap_pages(const struct=
 option *opt,
> >       return ret;
> >  }
> >
> > +static int record__parse_off_cpu_thresh(const struct option *opt,
> > +                                     const char *str,
> > +                                     int unset __maybe_unused)
> > +{
> > +     struct record_opts *opts =3D opt->value;
> > +     char *endptr;
> > +     u64 off_cpu_thresh_ms; // converted to us for potential future im=
provements
>
> I'm not sure about the future, but we now have the option in msec and
> convert it to usec, and finally BPF uses nsec.  Is the usec conversion
> really needed?  Maybe we can just use nsec internally.

Actually got the same idea lol. I will change it to nsec.

Thanks,
Howard
