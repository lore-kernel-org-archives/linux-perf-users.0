Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60D37F01A
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021231; cv=pass; b=a4V7sQ4UxlJg8lxaEYmzUeoi7mcLtCOaYMqUIilz04qhIqcnpwjltCbU037XyH6X5xpXhoHgdfFfR6mzlKi7iJXaJivMUfvFrV+WNCCQCooOrKPJLIIEIr5xpNtj755TOzb1g+R9Sb7AVsaKN8yNWlUhVDXUAI1oC1g9ndDzOCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021231; c=relaxed/simple;
	bh=1wnoy63B2VL0SHBCVKvO4QLIX9E+RjaofzkoxMzs8NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZSnO8s2SxZ7nKN9yeGNYmQAxgEyGoBXZlQkGUZsOKJz0xRqx1Q5a94KxBxwlcQuZmsTF6+KkEkRZXuKkXJnbT8ou9BLWTcMsWvLeTHU8iMhgOo4JylGGjWg2/AByiMx0wmOd3CghEok74u503XEdAdp53zte/KGWnf5cmzajBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oxkp8STI; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oxkp8STI"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0b260d309so144375ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775021229; cv=none;
        d=google.com; s=arc-20240605;
        b=jJ5/mrXcHGyiHo7tLIEue573jBG2jw560LP9N19HXKk0S5vKukpUMWIL1qKc2eXIZY
         HUnDVsOS/9X9HwT+zNflM815BlluAtsCD9XR9eFzkH0OTW+CcXpVj40moF3nyWzp33wT
         Ty1uujm5M6rIfGFDty18NUiarm4KmTwN63WXbuWMw+Xq2ripHWrV0JtJbG10RIXK3E6y
         Wc6QZS8LbkljcV/GIVyVXr8cdFKuVQG5pP5izq5eSLdiSVnAPWoTFUJTbPLMCD5JKlzC
         yUaU2wovyOZYCmz1Yk2pEKIy22nVVmnP0BwO89sUVmdBG/P100+B4L0RPNhx4Gu2vnlc
         mwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YlCdWnUwvZJIBeYoXBgvonQDIs/JeEZkqnufy3wIVO8=;
        fh=O+W//Dhug5Oojg011mBWF4gxacpsKX/vDUKebcBwRR8=;
        b=fpSagxx7ealopyzCsWQPiqnc+5uaeeVDPWaIWg/qlZ9FKSbnHBpeZ5eUkG3GXYmPJQ
         Q76HAjmn2omA3MgTO4d72g7Ash00Nxeo2PWzLCQf7nWp0wWzimczGZztgRDohLDBvbLi
         ZBy182204IdOQjOnQH3UnjmwTzO38hxCKP4YE/7SNksxjBkaDCrycCAwgwk5jspq8Fl0
         PdMewhTAsMqBDsDDBgTS2K+fOHjyQ4y4dwrN8FLdl5MUn2AWYcMcyrZ8DpHFT03FhSx/
         Ajqga+UW0ST6FocvPycvcQQGgksip0ySQhg/c34rPm8hU8wUI/0CxfomMW/6bPObgfwn
         3UiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775021229; x=1775626029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlCdWnUwvZJIBeYoXBgvonQDIs/JeEZkqnufy3wIVO8=;
        b=Oxkp8STIB2hUBjy8nzajKxNTSLFW6Tw2M8Ly2ccmatLMbMIP21avu3HQgxHCpLPQ67
         gnJCL2RtupUbGq0Og4lWWLhRaswUBiRNEOh4gnyDT2BpjtKK172jQ17z4AAyH7PbP9nn
         Ag1v4fqEq8huzrZiQ5/QxRL7ywj/lLMWWzeNhJVrfkZbhZ6ljNTpZLgPmkbZWWeTGdcM
         idhyXQ6++yxTBVUNUnQ4ks1ezitHnNLBXlq4GCyyvBRtefVSDRpI4kf/mrl596TjTKRj
         8mnVd+l/SgXssdq9Y99g+6Fz5lAOowB7hhPcIEGMZ2T7nzM55Rb3bFdz4nUoEoLPMAl/
         kakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021229; x=1775626029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YlCdWnUwvZJIBeYoXBgvonQDIs/JeEZkqnufy3wIVO8=;
        b=HL4XqViMZy823izmr5gVxDwPCo9eTLO4WlqeSQtyDKVlvaDMovqhjobCTQVJA4SzTr
         Hszj4UoAZHCdH4G56ZHpZgnSmcfwH5E7xkVgB1Tsn1cCyVTnD04o6o2fvfZUpbNykB0D
         JvWx6sCyrnlRU/xTCOJlZjj1eKfnq5cwwECDjDY8HrZ0t5Snhy7qiE2JOUyXkAraOH57
         60cRmxbVQ8YUOtV34azj7H/KtxV1wNV2GkZUy5OrNZeFC5uZz9ZC4/T/ZpIewNmrgLLQ
         j/xivFZ0Bggp6SpATxJfqGOd/qyKepXsF9r6qNT+P7OWbvyCf/MI3g6v1+mYTJq86NEj
         uIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwLx5CkAAT8MYIfSnXCOs5HLwCckfdCuNlFBGSpVDd+hS/ClHC0NiZP2byfy/sQh7Ue3q305dQjC9dQpuJklYp@vger.kernel.org
X-Gm-Message-State: AOJu0YylGt2dQn2TVTUH7Cc6woUEHBOIrGbFh0GksM1HkOz9epnn9vdp
	MK0LlvZQ9sZXmP9hz4/cSR8D4KYQYtVdUhs00jSXTuc89PKPW68Lj8+e0pz29oaOV9hHi664v9X
	4hoTE3/K3Pzp4DOkc4rDRHDFIUV4I41KNvZT+V/fq
X-Gm-Gg: ATEYQzwgpRhT7bi7NBzcDh3uZo0WvpM8ruGaRnZ7D1Tm7llyYDUEMLyPn22EFwlkC2X
	Od4QWJH1A/NPVyQOtg56yqc/OxbXSJ4FDMCR1zmq3gd7kXo5Hi1K8JKplem2hCX/XpJJZbYIuMc
	y7SN3GSSR/XdK+YpLtDSKKGnipyKjqah6Py4IU01rueeW0Ns7Z6tnWlxdWubFOs+ZjvkeSw3uPQ
	4BVLUEWT8eX35k52uPRYIBcraG5FYju1FE/vLD2o4cBB6xFAIfsYERyujEae+N3+I+yEO5Rgu1s
	gNki5+74
X-Received: by 2002:a17:902:e843:b0:2ad:ab68:f2c3 with SMTP id
 d9443c01a7336-2b26b2b3381mr1240015ad.13.1775021228427; Tue, 31 Mar 2026
 22:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com> <20260228065953.3226283-5-irogers@google.com>
 <aakhYWGgzyQma6dQ@z2>
In-Reply-To: <aakhYWGgzyQma6dQ@z2>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 22:26:57 -0700
X-Gm-Features: AQROBzA06y2uwJCRUEc9Yn74nfJ2ai0Ws5dkDicc948c9FLjBd3OJoVKRZ1jL7g
Message-ID: <CAP-5=fV0Qb4Xb2em4QvZt1v2-EEEbPAEg96W2VPeHEmdT2aWqQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] perf header: Refactor pipe mode end marker handling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 10:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 27, 2026 at 10:59:50PM -0800, Ian Rogers wrote:
> > In non-pipe/data mode the header has a 256-bit bitmap representing
> > whether a feature is enabled or not. In pipe mode features are written
> > out in perf_event__synthesize_features as PERF_RECORD_HEADER_FEATURE
> > events with a special zero sized marker for the last feature. If a new
> > feature is added the last feature marker event appears as that feature
> > from old pipe mode perf data. As the event is zero sized it will fail
> > to be processed and generally terminate perf.
> >
> > Add a last_feat variable to the header that in non-pipe/data mode is
> > just HEADER_LAST_FEATURE. In pipe mode compute the last_feat by
> > handling zero sized feature events, assuming they are the marker and
> > updating last_feat accordingly. Potentially a feature event could be
> > zero sized and so still process the feature event, just ignore the
> > error if it fails.
>
> Can we just use 256 instead of HEADER_LAST_FEATURE in the marker for
> the last feature record?  Then it can always know it's the last one and
> no need to save the last feature number in the header.  IIUC it only can
> handle features up to the current HEADER_LAST_FEATURE, right?

I agree that would be better. The issue then becomes how to support
old perf.data files with newer perf commands? Without changing the
pipe mode file format I think we're stuck with detecting the marker as
it is.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > As perf_event__process_feature can properly handle pipe mode data,
> > migrate users to it except for report that still wants to group events
> > and stop header printing with the last feature marker. Make
> > perf_event__process_feature non-fatal in the case of a newer feature
> > than this version of perf's HEADER_LAST_FEATURE, which was the
> > behavior all users wanted.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-annotate.c       | 11 +-----
> >  tools/perf/builtin-report.c         | 27 ++++++-------
> >  tools/perf/builtin-script.c         | 11 +-----
> >  tools/perf/util/data-convert-bt.c   |  9 ++---
> >  tools/perf/util/data-convert-json.c | 12 +-----
> >  tools/perf/util/header.c            | 59 ++++++++++++++++++++++-------
> >  tools/perf/util/header.h            |  4 +-
> >  tools/perf/util/intel-tpebs.c       | 11 +-----
> >  8 files changed, 67 insertions(+), 77 deletions(-)
> >
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotat=
e.c
> > index 9c27bb30b708..cf2d2011e148 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -313,15 +313,6 @@ static int process_sample_event(const struct perf_=
tool *tool,
> >       return ret;
> >  }
> >
> > -static int process_feature_event(const struct perf_tool *tool __maybe_=
unused,
> > -                              struct perf_session *session,
> > -                              union perf_event *event)
> > -{
> > -     if (event->feat.feat_id < HEADER_LAST_FEATURE)
> > -             return perf_event__process_feature(session, event);
> > -     return 0;
> > -}
> > -
> >  static int hist_entry__stdio_annotate(struct hist_entry *he,
> >                                   struct evsel *evsel,
> >                                   struct perf_annotate *ann)
> > @@ -876,7 +867,7 @@ int cmd_annotate(int argc, const char **argv)
> >       annotate.tool.id_index  =3D perf_event__process_id_index;
> >       annotate.tool.auxtrace_info     =3D perf_event__process_auxtrace_=
info;
> >       annotate.tool.auxtrace  =3D perf_event__process_auxtrace;
> > -     annotate.tool.feature   =3D process_feature_event;
> > +     annotate.tool.feature   =3D perf_event__process_feature;
> >       annotate.tool.ordering_requires_timestamps =3D true;
> >
> >       annotate.session =3D perf_session__new(&data, &annotate.tool);
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 3b81f4b3dc49..0b9dc66723f2 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -245,25 +245,20 @@ static int process_feature_event(const struct per=
f_tool *tool,
> >                                union perf_event *event)
> >  {
> >       struct report *rep =3D container_of(tool, struct report, tool);
> > +     int ret =3D perf_event__process_feature(tool, session, event);
> >
> > -     if (event->feat.feat_id < HEADER_LAST_FEATURE)
> > -             return perf_event__process_feature(session, event);
> > +     if (ret =3D=3D 0 && event->header.size =3D=3D sizeof(struct perf_=
record_header_feature) &&
> > +         (int)event->feat.feat_id =3D=3D session->header.last_feat) {
> > +             /*
> > +              * (feat_id =3D HEADER_LAST_FEATURE) is the end marker wh=
ich means
> > +              * all features are received.
> > +              */
> > +             if (rep->header_only)
> > +                     session_done =3D 1;
> >
> > -     if (event->feat.feat_id !=3D HEADER_LAST_FEATURE) {
> > -             pr_err("failed: wrong feature ID: %" PRI_lu64 "\n",
> > -                    event->feat.feat_id);
> > -             return -1;
> > -     } else if (rep->header_only) {
> > -             session_done =3D 1;
> > +             setup_forced_leader(rep, session->evlist);
> >       }
> > -
> > -     /*
> > -      * (feat_id =3D HEADER_LAST_FEATURE) is the end marker which
> > -      * means all features are received, now we can force the
> > -      * group if needed.
> > -      */
> > -     setup_forced_leader(rep, session->evlist);
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int process_sample_event(const struct perf_tool *tool,
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 9f8b0fd27a0a..53f016156d7a 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -3943,15 +3943,6 @@ int process_cpu_map_event(const struct perf_tool=
 *tool,
> >       return set_maps(script);
> >  }
> >
> > -static int process_feature_event(const struct perf_tool *tool __maybe_=
unused,
> > -                              struct perf_session *session,
> > -                              union perf_event *event)
> > -{
> > -     if (event->feat.feat_id < HEADER_LAST_FEATURE)
> > -             return perf_event__process_feature(session, event);
> > -     return 0;
> > -}
> > -
> >  static int perf_script__process_auxtrace_info(const struct perf_tool *=
tool,
> >                                             struct perf_session *sessio=
n,
> >                                             union perf_event *event)
> > @@ -4427,7 +4418,7 @@ int cmd_script(int argc, const char **argv)
> >  #ifdef HAVE_LIBTRACEEVENT
> >       script.tool.tracing_data         =3D perf_event__process_tracing_=
data;
> >  #endif
> > -     script.tool.feature              =3D process_feature_event;
> > +     script.tool.feature              =3D perf_event__process_feature;
> >       script.tool.build_id             =3D perf_event__process_build_id=
;
> >       script.tool.id_index             =3D perf_event__process_id_index=
;
> >       script.tool.auxtrace_info        =3D perf_script__process_auxtrac=
e_info;
> > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-c=
onvert-bt.c
> > index ba1c8e48d495..665bf8eea24b 100644
> > --- a/tools/perf/util/data-convert-bt.c
> > +++ b/tools/perf/util/data-convert-bt.c
> > @@ -1412,13 +1412,10 @@ static int process_feature_event(const struct p=
erf_tool *tool,
> >       struct convert *c =3D container_of(tool, struct convert, tool);
> >       struct ctf_writer *cw =3D &c->writer;
> >       struct perf_record_header_feature *fe =3D &event->feat;
> > +     int ret =3D perf_event__process_feature(tool, session, event);
> >
> > -     if (event->feat.feat_id < HEADER_LAST_FEATURE) {
> > -             int ret =3D perf_event__process_feature(session, event);
> > -
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +     if (ret)
> > +             return ret;
> >
> >       switch (fe->feat_id) {
> >       case HEADER_HOSTNAME:
> > diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data=
-convert-json.c
> > index 6a626322476a..4b1b2f7bed25 100644
> > --- a/tools/perf/util/data-convert-json.c
> > +++ b/tools/perf/util/data-convert-json.c
> > @@ -326,16 +326,6 @@ static void output_headers(struct perf_session *se=
ssion, struct convert_json *c)
> >       output_json_format(out, false, 2, "]");
> >  }
> >
> > -static int process_feature_event(const struct perf_tool *tool __maybe_=
unused,
> > -                              struct perf_session *session,
> > -                              union perf_event *event)
> > -{
> > -     if (event->feat.feat_id < HEADER_LAST_FEATURE)
> > -             return perf_event__process_feature(session, event);
> > -
> > -     return 0;
> > -}
> > -
> >  int bt_convert__perf2json(const char *input_name, const char *output_n=
ame,
> >               struct perf_data_convert_opts *opts __maybe_unused)
> >  {
> > @@ -375,7 +365,7 @@ int bt_convert__perf2json(const char *input_name, c=
onst char *output_name,
> >       c.tool.auxtrace       =3D perf_event__process_auxtrace;
> >       c.tool.event_update   =3D perf_event__process_event_update;
> >       c.tool.attr           =3D perf_event__process_attr;
> > -     c.tool.feature        =3D process_feature_event;
> > +     c.tool.feature        =3D perf_event__process_feature;
> >       c.tool.ordering_requires_timestamps =3D true;
> >
> >       if (opts->all) {
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index fe5d21dde04f..af4b6e3e4e1f 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -3785,11 +3785,11 @@ static int perf_file_section__fprintf_info(stru=
ct perf_file_section *section,
> >       struct feat_fd ff;
> >
> >       if (lseek(fd, section->offset, SEEK_SET) =3D=3D (off_t)-1) {
> > -             pr_debug("Failed to lseek to %" PRIu64 " offset for featu=
re "
> > -                             "%d, continuing...\n", section->offset, f=
eat);
> > +             pr_debug("Failed to lseek to %" PRIu64 " offset for featu=
re %s (%d), continuing...\n",
> > +                      section->offset, header_feat__name(feat), feat);
> >               return 0;
> >       }
> > -     if (feat >=3D HEADER_LAST_FEATURE) {
> > +     if (feat >=3D ph->last_feat) {
> >               pr_warning("unknown feature %d\n", feat);
> >               return 0;
> >       }
> > @@ -3841,7 +3841,7 @@ int perf_header__fprintf_info(struct perf_session=
 *session, FILE *fp, bool full)
> >               return 0;
> >
> >       fprintf(fp, "# missing features: ");
> > -     for_each_clear_bit(bit, header->adds_features, HEADER_LAST_FEATUR=
E) {
> > +     for_each_clear_bit(bit, header->adds_features, header->last_feat)=
 {
> >               if (bit)
> >                       fprintf(fp, "%s ", feat_ops[bit].name);
> >       }
> > @@ -4171,7 +4171,7 @@ int perf_header__process_sections(struct perf_hea=
der *header, int fd,
> >       if (err < 0)
> >               goto out_free;
> >
> > -     for_each_set_bit(feat, header->adds_features, HEADER_LAST_FEATURE=
) {
> > +     for_each_set_bit(feat, header->adds_features, header->last_feat) =
{
> >               err =3D process(sec++, header, feat, fd, data);
> >               if (err < 0)
> >                       goto out_free;
> > @@ -4386,6 +4386,7 @@ int perf_file_header__read(struct perf_file_heade=
r *header,
> >       ph->data_offset  =3D header->data.offset;
> >       ph->data_size    =3D header->data.size;
> >       ph->feat_offset  =3D header->data.offset + header->data.size;
> > +     ph->last_feat    =3D HEADER_LAST_FEATURE;
> >       return 0;
> >  }
> >
> > @@ -4401,8 +4402,8 @@ static int perf_file_section__process(struct perf=
_file_section *section,
> >       };
> >
> >       if (lseek(fd, section->offset, SEEK_SET) =3D=3D (off_t)-1) {
> > -             pr_debug("Failed to lseek to %" PRIu64 " offset for featu=
re "
> > -                       "%d, continuing...\n", section->offset, feat);
> > +             pr_debug("Failed to lseek to %" PRIu64 " offset for featu=
re %s (%d), continuing...\n",
> > +                      section->offset, header_feat__name(feat), feat);
> >               return 0;
> >       }
> >
> > @@ -4435,6 +4436,8 @@ static int perf_file_header__read_pipe(struct per=
f_pipe_file_header *header,
> >       if (ph->needs_swap)
> >               header->size =3D bswap_64(header->size);
> >
> > +     /* The last feature is written out as a 0 sized event and will up=
date this value. */
> > +     ph->last_feat =3D 0;
> >       return 0;
> >  }
> >
> > @@ -4667,31 +4670,61 @@ int perf_session__read_header(struct perf_sessi=
on *session)
> >       return -ENOMEM;
> >  }
> >
> > -int perf_event__process_feature(struct perf_session *session,
> > +int perf_event__process_feature(const struct perf_tool *tool __maybe_u=
nused,
> > +                             struct perf_session *session,
> >                               union perf_event *event)
> >  {
> >       struct feat_fd ff =3D { .fd =3D 0 };
> >       struct perf_record_header_feature *fe =3D (struct perf_record_hea=
der_feature *)event;
> > +     struct perf_header *header =3D &session->header;
> >       int type =3D fe->header.type;
> > -     u64 feat =3D fe->feat_id;
> > +     int feat =3D (int)fe->feat_id;
> >       int ret =3D 0;
> >       bool print =3D dump_trace;
> > +     bool last_feature_mark =3D false;
> >
> >       if (type < 0 || type >=3D PERF_RECORD_HEADER_MAX) {
> >               pr_warning("invalid record type %d in pipe-mode\n", type)=
;
> >               return 0;
> >       }
> > -     if (feat =3D=3D HEADER_RESERVED || feat >=3D HEADER_LAST_FEATURE)=
 {
> > -             pr_warning("invalid record type %d in pipe-mode\n", type)=
;
> > +     if (feat =3D=3D HEADER_RESERVED) {
> > +             pr_warning("invalid reserved record type in pipe-mode\n")=
;
> >               return -1;
> >       }
> > +     if (feat >=3D header->last_feat) {
> > +             if (event->header.size =3D=3D sizeof(*fe)) {
> > +                     /*
> > +                      * Either an unexpected zero size feature or the
> > +                      * HEADER_LAST_FEATURE mark.
> > +                      */
> > +                     if (feat > header->last_feat)
> > +                             header->last_feat =3D min(feat, HEADER_LA=
ST_FEATURE);
> > +                     last_feature_mark =3D true;
> > +             } else {
> > +                     /*
> > +                      * A feature but beyond what is known as in
> > +                      * bounds. Assume the last feature is 1 beyond th=
is
> > +                      * feature.
> > +                      */
> > +                     session->header.last_feat =3D min(feat + 1, HEADE=
R_LAST_FEATURE);
> > +             }
> > +     }
> > +     if (feat >=3D HEADER_LAST_FEATURE) {
> > +             if (!last_feature_mark) {
> > +                     pr_warning("unknown feature %d for data file vers=
ion (%s) in this version of perf (%s)\n",
> > +                                feat, header->env.version, perf_versio=
n_string);
> > +             }
> > +             return 0;
> > +     }
> >
> >       ff.buf  =3D (void *)fe->data;
> >       ff.size =3D event->header.size - sizeof(*fe);
> > -     ff.ph =3D &session->header;
> > +     ff.ph =3D header;
> >
> >       if (feat_ops[feat].process && feat_ops[feat].process(&ff, NULL)) =
{
> > -             ret =3D -1;
> > +             // Processing failed, ignore when this is the last featur=
e mark.
> > +             if (!last_feature_mark)
> > +                     ret =3D -1;
> >               goto out;
> >       }
> >
> > diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> > index ca22030a1434..41ce663d93ff 100644
> > --- a/tools/perf/util/header.h
> > +++ b/tools/perf/util/header.h
> > @@ -109,6 +109,7 @@ struct perf_header {
> >       u64                             data_size;
> >       u64                             feat_offset;
> >       DECLARE_BITMAP(adds_features, HEADER_FEAT_BITS);
> > +     int                             last_feat;
> >       struct perf_env         env;
> >  };
> >
> > @@ -172,7 +173,8 @@ int perf_header__process_sections(struct perf_heade=
r *header, int fd,
> >
> >  int perf_header__fprintf_info(struct perf_session *s, FILE *fp, bool f=
ull);
> >
> > -int perf_event__process_feature(struct perf_session *session,
> > +int perf_event__process_feature(const struct perf_tool *tool,
> > +                             struct perf_session *session,
> >                               union perf_event *event);
> >  int perf_event__process_attr(const struct perf_tool *tool, union perf_=
event *event,
> >                            struct evlist **pevlist);
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpeb=
s.c
> > index 3c958d738ca6..f57ea6db02a0 100644
> > --- a/tools/perf/util/intel-tpebs.c
> > +++ b/tools/perf/util/intel-tpebs.c
> > @@ -217,15 +217,6 @@ static int process_sample_event(const struct perf_=
tool *tool __maybe_unused,
> >       return 0;
> >  }
> >
> > -static int process_feature_event(const struct perf_tool *tool __maybe_=
unused,
> > -                              struct perf_session *session,
> > -                              union perf_event *event)
> > -{
> > -     if (event->feat.feat_id < HEADER_LAST_FEATURE)
> > -             return perf_event__process_feature(session, event);
> > -     return 0;
> > -}
> > -
> >  static void *__sample_reader(void *arg __maybe_unused)
> >  {
> >       struct perf_session *session;
> > @@ -238,7 +229,7 @@ static void *__sample_reader(void *arg __maybe_unus=
ed)
> >
> >       perf_tool__init(&tool, /*ordered_events=3D*/false);
> >       tool.sample =3D process_sample_event;
> > -     tool.feature =3D process_feature_event;
> > +     tool.feature =3D perf_event__process_feature;
> >       tool.attr =3D perf_event__process_attr;
> >
> >       session =3D perf_session__new(&data, &tool);
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
