Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710718C011
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135130; cv=none; b=KcX5sFBkaqZVJlXNpIseURU2yvQ9sHEZC6x4ROjQOmAAR/pm8fv5YkQVmYWzm9Iv6T8Red+UKGRTjSo+BT888uvTtrd02JNm1K3FK6x9zkEh9Q+Pk2DPARz0+IOxd53eIVNSq0EDjr6P8+5fCaHSPwotDMUAb9WNN9OemWDujao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135130; c=relaxed/simple;
	bh=3mNzLrJuCJ4nEvrWE0L6saeRIW+UtLs5NfIYl8Hns28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAVWs36DuGzUHwafW+j0wDAbjBvC/tNDQTTiRFFT9Nr4gH1DAy2h9l2YJ+D5Eys8HwfEOZTluY5M8T42MSY90rA/Wrbuds1+z1ZaNlzb1ojumn0fugZuy7NXB8kCJCBb+dumQ1lXlCklIY/9qNFNFIGdlBQ5dvYeWfpmpgB/EsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bOgqjlQC; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOgqjlQC"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3076262bfc6so66002561fa.3
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 23:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738135126; x=1738739926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3e2MO8Rz8owtaJOJNzv6lZIzbNuh/ecpBDqYHZDfl4=;
        b=bOgqjlQCy/Hwd/0qC4MVPMN9Loae6Et0GOoQxm6/oKYXpUPc7iNdU13mrr8RzDC7/D
         SCEACibraXSCCZFjh8PFrM7MFrSU/RrwcyXclGY6jAjIyPLxb3YwC75Z6zOlXqaLFRQQ
         p105Xge0eWugLqhp/qW7dSaDTm5jyMFJmIFTPG9SF07TDaFlbl0auYia5aUpS9dz7FaF
         Cs2MkhbMXF5ZsKo9O2395zySN+HI8FW35d0HMuvx2VYSV3nUc0JO1ONcv3LXnyyeTSAG
         0+nHyxMg7Bdn6XSMY+lgoGxn0xeFXq63OfJek2+cLo9fg61noVIaONEyzsqtCjNlpjPl
         5blQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738135126; x=1738739926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3e2MO8Rz8owtaJOJNzv6lZIzbNuh/ecpBDqYHZDfl4=;
        b=aBLYwJitEkb+8WyGljqm/FyT6xMPI9GO2janIQhSKiJDueOT9RZSIV5EF30fSCqJTP
         EaAJJjC9CDFE+FvDZzxNyjDAyfU45DQ6c38DwLVyBfxwLSFsZnF15+8q4Q9DZL8Ih18K
         dRgo1/ExKFya3tBAh1M8XoF16sn41nJh3EgVSlFLKlpquxxIBzqOecG2/iXbxYMiRCye
         rph2tPYFS55KzWw6zVsuk+if9OK7AuZW8Hn2sHpBpiVfHEA9qLXoLlXDrzg8kj40pXS/
         AzddzCqchnN+FP6kzvRPRLF6QBYKyU3MjsS+QPzoevhpcenyxUgKXsjsv0xuGmSMt/LZ
         PVCw==
X-Forwarded-Encrypted: i=1; AJvYcCVmxbnEFqDUpxcIxFcp60k0H+mty/2cEadtQ5jLBabp4E9Mrj/d5pPmdXKyfvJwZXUPo84y/SvnCnBpxSl7BnS0@vger.kernel.org
X-Gm-Message-State: AOJu0YwMtGq/89Ibje/PIm2A5h3TjuUBvNyUcsK6E4nddxULE4D5RY8I
	7LmZHDkXnIZCjf19XrfjYhSWBCtsGYlGpWminstN6i6kHKyu6eyWRlfNHfQgZYzbh57IzArB/cy
	BTU3PgwCW09Oh2iqp7xpw+3zOlL8jiHa2dD6a+xjBXEURLxurg4bj
X-Gm-Gg: ASbGncttr1J/YwfPdc159HS46BmJh8xafL9Eat+CAj0/6dEhJgs8n2t89Gkcl7bnXJ5
	3gQZTNffGaPvFTTOm4SQy3ZGc11Gmn9V5HLW8sKapyXQZ6anMJCM/jAnywIOKJI/fjTmGXMKGjk
	1STL39r0JLGm7fbgvxL0cGe2yFkG/nKg==
X-Google-Smtp-Source: AGHT+IE9ZolzZBCdkoWu+wwyvpwbxJe/pY9P873KQ7/YgrfL/oPKFcYuqTRgyMQ3NHsc6McjhlZN4CB0dJX3Tv41vuc=
X-Received: by 2002:a05:651c:516:b0:302:34d6:f047 with SMTP id
 38308e7fff4ca-3079681ee1dmr6235301fa.5.1738135125440; Tue, 28 Jan 2025
 23:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737971364.git.dvyukov@google.com> <3e52ed435e0ce98e1108b172fdcadc4749a25c98.1737971364.git.dvyukov@google.com>
 <Z5mxzGdXJ27O4x-Y@google.com>
In-Reply-To: <Z5mxzGdXJ27O4x-Y@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 29 Jan 2025 08:18:34 +0100
X-Gm-Features: AWEUYZk3si7OPIPG3vSct2BiP-P6TB2OfL4JjO4fcjTzx_6D-HPuxujd40pyfdY
Message-ID: <CACT4Y+Z1hFt6ttPPdoDSxw-BDjBhnhxDAunHQ4do2o56Ne3BDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] perf report: Add parallelism sort key
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 05:42, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Mon, Jan 27, 2025 at 10:58:49AM +0100, Dmitry Vyukov wrote:
> > Show parallelism level in profiles if requested by user.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  tools/perf/builtin-report.c | 11 +++++++++++
> >  tools/perf/util/hist.c      |  2 ++
> >  tools/perf/util/hist.h      |  3 +++
> >  tools/perf/util/session.c   | 12 ++++++++++++
> >  tools/perf/util/session.h   |  1 +
> >  tools/perf/util/sort.c      | 23 +++++++++++++++++++++++
> >  tools/perf/util/sort.h      |  1 +
> >  7 files changed, 53 insertions(+)
> >
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 0d9bd090eda71..14d49f0625881 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1720,6 +1720,17 @@ int cmd_report(int argc, const char **argv)
> >               symbol_conf.annotate_data_sample = true;
> >       }
> >
> > +     if (report.disable_order || !perf_session__has_switch_events(session)) {
> > +             if ((sort_order && strstr(sort_order, "parallelism")) ||
> > +                             (field_order && strstr(field_order, "parallelism"))) {
> > +                     if (report.disable_order)
> > +                             ui__error("Use of parallelism is incompatible with --disable-order.\n");
> > +                     else
> > +                             ui__error("Use of parallelism requires --switch-events during record.\n");
> > +                     return -1;
> > +             }
> > +     }
> > +
> >       if (sort_order && strstr(sort_order, "ipc")) {
> >               parse_options_usage(report_usage, options, "s", 1);
> >               goto error;
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 0f30f843c566d..cafd693568189 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -207,6 +207,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
> >
> >       hists__new_col_len(hists, HISTC_CGROUP, 6);
> >       hists__new_col_len(hists, HISTC_CGROUP_ID, 20);
> > +     hists__new_col_len(hists, HISTC_PARALLELISM, 11);
> >       hists__new_col_len(hists, HISTC_CPU, 3);
> >       hists__new_col_len(hists, HISTC_SOCKET, 6);
> >       hists__new_col_len(hists, HISTC_MEM_LOCKED, 6);
> > @@ -741,6 +742,7 @@ __hists__add_entry(struct hists *hists,
> >               .ip      = al->addr,
> >               .level   = al->level,
> >               .code_page_size = sample->code_page_size,
> > +             .parallelism    = al->parallelism,
> >               .stat = {
> >                       .nr_events = 1,
> >                       .period = sample->period,
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 46c8373e31465..a6e662d77dc24 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -42,6 +42,7 @@ enum hist_column {
> >       HISTC_CGROUP_ID,
> >       HISTC_CGROUP,
> >       HISTC_PARENT,
> > +     HISTC_PARALLELISM,
> >       HISTC_CPU,
> >       HISTC_SOCKET,
> >       HISTC_SRCLINE,
> > @@ -228,6 +229,7 @@ struct hist_entry {
> >       u64                     transaction;
> >       s32                     socket;
> >       s32                     cpu;
> > +     int                     parallelism;
>
> Can you make it u16 and move to around cpumode to remove paddings?

It generally should be the same size as cpu/socket/etc. And these are
32-bits throughout the codebase (the previous fields). Are there any
checks that MAX_NR_CPUS<64K?


> Thanks,
> Namhyung
>
>
> >       u64                     code_page_size;
> >       u64                     weight;
> >       u64                     ins_lat;
> > @@ -580,6 +582,7 @@ bool perf_hpp__is_thread_entry(struct perf_hpp_fmt *fmt);
> >  bool perf_hpp__is_comm_entry(struct perf_hpp_fmt *fmt);
> >  bool perf_hpp__is_dso_entry(struct perf_hpp_fmt *fmt);
> >  bool perf_hpp__is_sym_entry(struct perf_hpp_fmt *fmt);
> > +bool perf_hpp__is_parallelism_entry(struct perf_hpp_fmt *fmt);
> >
> >  struct perf_hpp_fmt *perf_hpp_fmt__dup(struct perf_hpp_fmt *fmt);
