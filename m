Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB23C5DC4
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231903; cv=pass; b=GmPmym2XTCC2yqKzvuFe9xNFTEpWXPXTm19kLqLayC92YYHFZ+Ye6brxBli6dCf/ZeoryU/TEF3fLVOl3Br4S078xHX7V68vSuZh65ME2JXUpkeknihMsIxlunIVSdG8nrUodKnDh1Ig1JvR00T7Y90Zxh5TMY6C0zodyZJOSqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231903; c=relaxed/simple;
	bh=nI1iEGPoPDhrBGtUeSsTwShs2u+PpmiWdlssb+sfvwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZNh4tszQs3dpzJ0QBupGISsVCpOxYBGrB47YIeDJBzEfC26mnvmVRzry6gbEV+QKoY5HqGCasLBwJ9SEAHw+lkZVkx5OcDwlZxD4c9Xpcyy1QvP15f1wMNDbaW6a6DrvVonMD+ZnmsqcA6/EzcXRjKtbAd4RWvUj6J7pwrmk/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgp2ZYL2; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgp2ZYL2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0b260d309so63985ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 08:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775231901; cv=none;
        d=google.com; s=arc-20240605;
        b=QFPztPKqaI2el0YirnylONX5/J7uSaRtfwNdyBINwjXWWL9ml2sle88icm/+U0nX/3
         FLPwoTf7ZuhbVSoJBG92YY1WDZUkGUyGvTFCRbVMQGV84+BAn2AU+V8Y5jqXRSipkhQO
         lC2jn06jmyYPivNQUAMjbiDx3IHswg+DOLN3ALSX3mSJHTIWwFqRGs6bd3laItLFgqZS
         aar1EgKz3wC+cZ2IXBu7NsBt+61S7Pt7r6/pRzotmFP+ja4heGxqK/9axUdOMuLdvRHX
         tzP1DRqJA/Vn4JIiBJ/PjrsbXVYYhLmKJoux+O+Mt6iPwbSVbqSfNPEqr4cJVZUwHGa4
         rmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QTgAsrFsFs8UUmicUB8apvQD/a/IXWye6P5XWGjlyVI=;
        fh=zUX9/20HfRvDvacw9XnhVVYmGYE0dCdY1BjIGRv7rP0=;
        b=DGVnZLkPczB1mSnQq/q/exBtXZHMRCMLPfVUyMQg9DxpYWlT/qvWETahwdFeXgY0RP
         STWJRgomldFPgCHARtQaswbcqdso8bv2wD/wxnP04WR3HC/UmcuAlx1GWeHaa6Z//dMl
         KLXqjKRTTz5OXLV7LHKX+LYUgu8Go2ZW+v3MBUpJ7Tgp769qxP3fjbByuAVKk9eqjwK7
         tRB/aGVM03T2He3lUTMLED9NGM2ZYoNr0iygTh4JwY8NumRPLvxgNEqs3yMhsQfYWU5Z
         EvYzdR6PQsQM2EpSKnpgElMpuyM5tHwIYjbvCdzRZw+k/q63/3S+zYfSZiXVKctzEGDi
         JA1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775231901; x=1775836701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTgAsrFsFs8UUmicUB8apvQD/a/IXWye6P5XWGjlyVI=;
        b=bgp2ZYL2XaL8jS+dZb7O74sTtTkZhFgcZ76ETWRzhFKqufgN0vhpuVt8pPQ/8QOrfe
         j/FdmpekHrV+Hb5cTd6uxVhzz3iRocQV0VQNvNVTNeyrjQVPWEja2QWYtynNz/v+WMwC
         eWVwvBMRP8VIh0E3M3tCFEDVGmG7KZ7XEdPKvaXvdaqRzv/Y5ldpi39urI+LnrS2WVRL
         9BLG+h8shEA6RDBzrk/dvbscmdflTzq1Soi5hoR58FcP4Ht2iEaz4sEMTUBhYqr+cGdD
         DbGvrSELvEmvuOnX+v03dJk8mEx0blSa0HZl0GLjEOiUOznVaAESTOG0Kw4H0uJqXJsh
         4Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775231901; x=1775836701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QTgAsrFsFs8UUmicUB8apvQD/a/IXWye6P5XWGjlyVI=;
        b=hkfYuOxsiQ0/atAMiJxBFlNZAWDBgJGP67ETPZpv7wks/k+BbaS3D+N39jKhaWlzur
         w950ZvrFutIZB3Ys3eWZpFPgrfSFewHX5Tiw9e9XcHouuSScpkQzNdavRGu0r6HhZzi4
         MPyLCiynjR979+wZ7ThpjtGzRUc1Yp0JShFEc1smdaZqXollO5foExUUUuOa6o+PXTVj
         tO0AvEt7Eesh4xbvHDn3eWx7x3xySPHRamT2lpfLZlTW0NODjEf8n7di/VR7F6GJRFk5
         JEpc+GuiodeQj5smDBJK7t78nOgnXPffqFnIhz2NC6gpx4Hq5rgs0IgYW/FtZfhsS/fF
         6/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1CN4f24zveWNiCVMUMDldZOTuufZ7y0PwIkhfz3u5yi/5pyCsjoV4Srp0e0TTIfsElHw1bXxb6cEAigMh1icP@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRM2AXT8WnU2PRh+PPIRV9WwuGa601xKPRTB7ATz9/zmKSwCY
	eEDzS9GTWRq3N4LoLpk/F/B+TTLETmhfJ/OziaZFOQ8E3n2Ag47MmMHmSpk5IVhZYaI9evbWFdX
	F4gB4A9fEsnCYKI3sxG6bkfCuntWEiyaaz7ZHTUzA
X-Gm-Gg: AeBDiesRB5lriJMt6Ssxwhkh3DjYPigRKyPtQ+SrmJTNeiMJnGUZg0ocJMuqkA0toth
	ccKkFL7mHCycYlCIuqJqyDJcmeVdbezWgbLvV6UHXQuL3bWRYIagxGl7rLWm8vX+rcyhezvheDt
	sNQMnKmzIK+hcBRvu0SvIrj2KHcmnaAL1NviwRJvcgM7trZsVadNGuiZrBG8GBuhLmJfMxWe8ch
	jcGqrYETU05qTvVvNPtcJ8BxnSDi2t/31PDTNa6qB6qfJid4H/APj6WQ/84sTGH3keEYzCvXWH0
	ipKXNx+j
X-Received: by 2002:a17:902:d584:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2b282f49b59mr2451425ad.16.1775231900710; Fri, 03 Apr 2026
 08:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402215727.980993-1-irogers@google.com> <CABFUUZHVg6XQeVBrv8R22M-LNoJUoNEQQ3K_wA-TpTKT-Mr4Hw@mail.gmail.com>
In-Reply-To: <CABFUUZHVg6XQeVBrv8R22M-LNoJUoNEQQ3K_wA-TpTKT-Mr4Hw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Apr 2026 08:58:09 -0700
X-Gm-Features: AQROBzAYe8ExiGqlU-TQ_5Ya_l_UNn7S3fy3_HzKDMFBPNiXN-zc1_TT-NJAxs0
Message-ID: <CAP-5=fVbwwP6QBO+GrFoSVFxX1GM9rTJFqUwMVdsona_Gt6rug@mail.gmail.com>
Subject: Re: [PATCH v1] perf cgroup: Update metric leader in evlist__expand_cgroup
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:33=E2=80=AFPM sun jian <sun.jian.kdev@gmail.com> =
wrote:
>
> On Fri, Apr 3, 2026 at 5:58=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > When the evlist is expanded the metric leader wasn't being updated. As
> > the original evsel is deleted this creates a use-after-free in
> > stat-shadow's prepare_metric. This was detected running the "perf stat
> > --bpf-counters --for-each-cgroup test" with sanitizers.
> >
> > The change itself puts the copied evsel into the priv field (known
> > unused because of evsel__clone use) and then in a second pass over the
> > list updates the copied values using the priv pointer.
> >
> > Fixes: d1c5a0e86a4e ("perf stat: Add --for-each-cgroup option")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/cgroup.c | 34 +++++++++++++++++++++++++++-------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index 040eb75f0804..1e0fef283826 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -417,7 +417,6 @@ static bool has_pattern_string(const char *str)
> >  int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool=
 open_cgroup)
> >  {
> >         struct evlist *orig_list, *tmp_list;
> > -       struct evsel *pos, *evsel, *leader;
> >         struct rblist orig_metric_events;
> >         struct cgroup *cgrp =3D NULL;
> >         struct cgroup_name *cn;
> > @@ -452,6 +451,7 @@ int evlist__expand_cgroup(struct evlist *evlist, co=
nst char *str, bool open_cgro
> >                 goto out_err;
> >
> >         list_for_each_entry(cn, &cgroup_list, list) {
> > +               struct evsel *pos;
> >                 char *name;
> >
> >                 if (!cn->used)
> > @@ -467,21 +467,41 @@ int evlist__expand_cgroup(struct evlist *evlist, =
const char *str, bool open_cgro
> >                 if (cgrp =3D=3D NULL)
> >                         continue;
> >
> > -               leader =3D NULL;
> > +               /* copy the list and set to the new cgroup. */
> >                 evlist__for_each_entry(orig_list, pos) {
> > -                       evsel =3D evsel__clone(/*dest=3D*/NULL, pos);
> > +                       struct evsel *evsel =3D evsel__clone(/*dest=3D*=
/NULL, pos);
> > +
> >                         if (evsel =3D=3D NULL)
> >                                 goto out_err;
> >
> > +                       /* stash the copy during the copying. */
> > +                       pos->priv =3D &evsel->core;
> >                         cgroup__put(evsel->cgrp);
> >                         evsel->cgrp =3D cgroup__get(cgrp);
> >
> > -                       if (evsel__is_group_leader(pos))
> > -                               leader =3D evsel;
> > -                       evsel__set_leader(evsel, leader);
> > -
> >                         evlist__add(tmp_list, evsel);
> >                 }
> > +               /* update leader information using stashed pointer to c=
opy. */
> > +               evlist__for_each_entry(orig_list, pos) {
> > +                       struct evsel *evsel =3D pos->priv;
> nit: since pos->priv stores &evsel->core above, could we use container_of=
() here
> as well? Or just stash evsel directly into priv?

You're right, the perf_evsel vs the evsel is out-of-sync here (and
this was missed by Sashiko). I'll fix in v2.

Thanks,
Ian

> > +
> > +                       if (evsel__leader(pos))
> > +                               evsel->core.leader =3D evsel__leader(po=
s)->priv;
> > +
> > +                       if (pos->metric_leader) {
> > +                               evsel->metric_leader =3D
> > +                                       container_of(pos->metric_leader=
->priv, struct evsel, core);
> > +                       }
> > +                       if (pos->first_wildcard_match) {
> > +                               evsel->first_wildcard_match =3D
> > +                                       container_of(pos->first_wildcar=
d_match->priv,
> > +                                                    struct evsel, core=
);
> > +                       }
> > +               }
> > +               /* the stashed copy is no longer used. */
> > +               evlist__for_each_entry(orig_list, pos)
> > +                       pos->priv =3D NULL;
> > +
> >                 /* cgroup__new() has a refcount, release it here */
> >                 cgroup__put(cgrp);
> >                 nr_cgroups++;
> > --
> > 2.53.0.1213.gd9a14994de-goog
> >
> >
> This patch makes sense to me, apart from the nit above.
>
> Acked-by: Sun Jian <sun.jian.kdev@gmail.com>
