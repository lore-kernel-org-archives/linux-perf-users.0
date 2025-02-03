Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016502080E4
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593668; cv=none; b=JtgfImIBzUJrLgoL7uI+xG6Fvt37P0a8eFfnVK199vkzj7Oa/4A8L8NnM5JafvCfL8BLWiPikPpHawvyG5DwVinOkDzsGx6S+cH8ZGhPgBdFgatAjvV1FEEAx4z2xm/BF8vmH4Kb0Dk9XS3tHUNOJNZhrz+EvLonOrm3yT5WZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593668; c=relaxed/simple;
	bh=rWXAYlD+TzBh3XGY/ZAw9xD93eT7AYlyZhnjh2C+AeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZreQhv7hE/h+rCO0R5nxclJcrJKGkAyWotZxO8YRal2xuTIUaJpZC9MroB2pfF2ncCPvyIxBHBx+CQeMylee9rji+4XmSSdeuPd5lcYQYo8sI1scpXTttfH0DzFWuxtzqqYsOQwbOnL9KiYmOaQB69mIC8Fo4oRG7lbNV40OMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w6UBtWy0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w6UBtWy0"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-305f529a987so33881281fa.2
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 06:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593664; x=1739198464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mWTNcQUdYjTpDLebPW6Jb1fVqaJc/ojxvHYu6zZeggA=;
        b=w6UBtWy0VKYGMl/LhQw4Y9VkufkdPEz/GsSH66vj3WvTCIS9fljYdxd1Onc5ySX8hN
         EGne5uQw0wriZO/kDXun/XtSmvVFj7xlfaFaeZ+3I17P3kQNdxNJvXlR0XLo3+tEc2BN
         Vf/9hSb12HhTYD5McsjCkg6papNp2bhbP2EmalpzzpIfXBUEB9+6ezURnYmzvRKuPVrT
         iVhrndnnlqijVQXUXn2b/UBM36x+Z0ZsjyeIAIthECdKk6TAwqQ8pIQRV9O0/VkjEPl3
         CIOnFJBC+LpE6MiLNmg1tvsLkIlOBZ7WiAYlTRHwI3Gqkf7o6LC93WOZOwwldUw9LEWN
         Aphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593664; x=1739198464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWTNcQUdYjTpDLebPW6Jb1fVqaJc/ojxvHYu6zZeggA=;
        b=jKBG6LiPuI8aGs85/q7f+blHKPkpPMtQbdnduGabBkdfKwYp3eGVxgwoiPaCmiOEcc
         9W/TAUGPMrlkshLIls8X6EsSmoECOht4wv+FppvBjblleJ2919P4k8xxZE0Q+0zJaUX3
         sHvGtYkIat2/RJQvUvD6L4jJWSherLQ2tHJseGO/IyIgpFd3RtLkVjc/9015LUX4PfZp
         wnZzH1ThVylKvjILimwq9I4IoBvaNdRo2EYx47U4+ooq0daLJq5UQDeRbqHG6vNrXoYz
         JWMnTeBVTksmKXkKu9nEiCqxskyzXz7ppJBLZ62UsTgXZsFV1NXcJP66GXQqczSfSjfK
         q1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWfygAvfVxOsU5gLiYKnzXJV7FrRtgYuGLgJl4Y2MKzL41NBmO+SYr1+WAU2wledG0cEeaPFy4SJaqzb5UnSDQS@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6hSHOfkJYnsdehvYoZPmy45ZGUA3WvArSOfUFXvzYquL8SUs
	C2QqLvMtV839xsl45sqK/2QW+JhxG9GjvVgNPnITWVq2302Ev+H/FnBJgjK9stLi7xgCWUCKmay
	62EFt+Ft7RcjL7/xnXaSVMq5W3Smpae/l1B+N
X-Gm-Gg: ASbGncto8Xcmn7HbX751C4nEeKNRHytuEuU/yVF0MGLVgTxWhdLR8toGfKVkHPNIMLY
	avRga/FxXgx06MTp7FJ42k/sEhI5slGaYUiRuEwEB0J3s9iLNCp4gmXFcDEh35Ru8z+Lf7OdDVv
	gkXzHbrg+il1EWuudTjgB9CDzT
X-Google-Smtp-Source: AGHT+IEFMpl6ZcgcJrXIsSwQqE5R01vnpkBqhD4eS64Yg+k728wpZWGR9nA+Uj3tda4TUg9TM6+sB3c2ckjBoq19VXA=
X-Received: by 2002:a05:651c:2126:b0:302:1b18:2bfe with SMTP id
 38308e7fff4ca-3079694dfbdmr88941761fa.25.1738593663833; Mon, 03 Feb 2025
 06:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737971364.git.dvyukov@google.com> <3e52ed435e0ce98e1108b172fdcadc4749a25c98.1737971364.git.dvyukov@google.com>
 <Z5mxzGdXJ27O4x-Y@google.com> <CACT4Y+Z1hFt6ttPPdoDSxw-BDjBhnhxDAunHQ4do2o56Ne3BDQ@mail.gmail.com>
 <Z5sOEPVh4-WGmhc-@google.com>
In-Reply-To: <Z5sOEPVh4-WGmhc-@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 3 Feb 2025 15:40:52 +0100
X-Gm-Features: AWEUYZnB5QhHlg9oBpSHk3bt3d1zFOdL1ywgZCEzDcp3V6rE95Dh1I1lIh71sHw
Message-ID: <CACT4Y+YCxX2TV0jP58p2j3YutSCgOu1+MwXdgZk3MKVTkHQSfQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] perf report: Add parallelism sort key
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 06:28, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Jan 29, 2025 at 08:18:34AM +0100, Dmitry Vyukov wrote:
> > On Wed, 29 Jan 2025 at 05:42, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Mon, Jan 27, 2025 at 10:58:49AM +0100, Dmitry Vyukov wrote:
> > > > Show parallelism level in profiles if requested by user.
> > > >
> > > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Cc: Ian Rogers <irogers@google.com>
> > > > Cc: linux-perf-users@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > ---
> > > >  tools/perf/builtin-report.c | 11 +++++++++++
> > > >  tools/perf/util/hist.c      |  2 ++
> > > >  tools/perf/util/hist.h      |  3 +++
> > > >  tools/perf/util/session.c   | 12 ++++++++++++
> > > >  tools/perf/util/session.h   |  1 +
> > > >  tools/perf/util/sort.c      | 23 +++++++++++++++++++++++
> > > >  tools/perf/util/sort.h      |  1 +
> > > >  7 files changed, 53 insertions(+)
> > > >
> > > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > > > index 0d9bd090eda71..14d49f0625881 100644
> > > > --- a/tools/perf/builtin-report.c
> > > > +++ b/tools/perf/builtin-report.c
> > > > @@ -1720,6 +1720,17 @@ int cmd_report(int argc, const char **argv)
> > > >               symbol_conf.annotate_data_sample = true;
> > > >       }
> > > >
> > > > +     if (report.disable_order || !perf_session__has_switch_events(session)) {
> > > > +             if ((sort_order && strstr(sort_order, "parallelism")) ||
> > > > +                             (field_order && strstr(field_order, "parallelism"))) {
> > > > +                     if (report.disable_order)
> > > > +                             ui__error("Use of parallelism is incompatible with --disable-order.\n");
> > > > +                     else
> > > > +                             ui__error("Use of parallelism requires --switch-events during record.\n");
> > > > +                     return -1;
> > > > +             }
> > > > +     }
> > > > +
> > > >       if (sort_order && strstr(sort_order, "ipc")) {
> > > >               parse_options_usage(report_usage, options, "s", 1);
> > > >               goto error;
> > > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > > index 0f30f843c566d..cafd693568189 100644
> > > > --- a/tools/perf/util/hist.c
> > > > +++ b/tools/perf/util/hist.c
> > > > @@ -207,6 +207,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
> > > >
> > > >       hists__new_col_len(hists, HISTC_CGROUP, 6);
> > > >       hists__new_col_len(hists, HISTC_CGROUP_ID, 20);
> > > > +     hists__new_col_len(hists, HISTC_PARALLELISM, 11);
> > > >       hists__new_col_len(hists, HISTC_CPU, 3);
> > > >       hists__new_col_len(hists, HISTC_SOCKET, 6);
> > > >       hists__new_col_len(hists, HISTC_MEM_LOCKED, 6);
> > > > @@ -741,6 +742,7 @@ __hists__add_entry(struct hists *hists,
> > > >               .ip      = al->addr,
> > > >               .level   = al->level,
> > > >               .code_page_size = sample->code_page_size,
> > > > +             .parallelism    = al->parallelism,
> > > >               .stat = {
> > > >                       .nr_events = 1,
> > > >                       .period = sample->period,
> > > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > > index 46c8373e31465..a6e662d77dc24 100644
> > > > --- a/tools/perf/util/hist.h
> > > > +++ b/tools/perf/util/hist.h
> > > > @@ -42,6 +42,7 @@ enum hist_column {
> > > >       HISTC_CGROUP_ID,
> > > >       HISTC_CGROUP,
> > > >       HISTC_PARENT,
> > > > +     HISTC_PARALLELISM,
> > > >       HISTC_CPU,
> > > >       HISTC_SOCKET,
> > > >       HISTC_SRCLINE,
> > > > @@ -228,6 +229,7 @@ struct hist_entry {
> > > >       u64                     transaction;
> > > >       s32                     socket;
> > > >       s32                     cpu;
> > > > +     int                     parallelism;
> > >
> > > Can you make it u16 and move to around cpumode to remove paddings?
> >
> > It generally should be the same size as cpu/socket/etc. And these are
> > 32-bits throughout the codebase (the previous fields). Are there any
> > checks that MAX_NR_CPUS<64K?
>
> I don't think there's such a check.  But practically it used be 4K and
> you can add the check. :)
>
> Anyway hist_entry is getting bigger and we may need to shrink it later.
> I don't stringly insist on u16 though.  It's up to you.

Added this commit to v4:

perf hist: Shrink struct hist_entry size
https://lore.kernel.org/linux-perf-users/75dd56a2d467515dc354d8fc8d5acd841d63b565.1738592865.git.dvyukov@google.com/T/#u

It cuts 8 bytes, which I hope is enough to compensate for my 4 added bytes :)

However, it's 584 bytes, so it saves like 1%.

If hist_entry size is a problem I think the following approaches will
have more impact (not saying I want to do it as part of this series
:)):

1. Make hist_entry layout dynamic (like the kernel perf event data) to
completely exclude unused parts when they are unused.

2. Add slab allocator for hist_entry which won't round up allocation size.
E.g. if you take default TCMalloc size classes, that's 576 and then
640. So this messing with padding actually doesn't save anything. We
shave off 1%, but the actual heap block is still 10% wasted.
