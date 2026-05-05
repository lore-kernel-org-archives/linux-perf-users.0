Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BD48B38A
	for <linux-perf-users@vger.kernel.org>; Tue,  5 May 2026 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016140; cv=pass; b=FAs8vgTurjqwqP8NHeAhkunc+M92R0sXPrdl4Kmuda5QFLjj43DaZwEGi6ZOJmcpJk5jMaXGjIxM0HPTiUpL88iKxxe1ufRGnQFzhBsR7EQcHxb33bUMiiHLcOgBFAEmpgq9Qf0tQr+BqDO+UtnumH5TlZtEt9U+0+d0N8ftYVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016140; c=relaxed/simple;
	bh=PSYeg+7qWtRoNTDEpkKoRrlJ+aSjnm/n7bK55NBxK7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCIHyHUq3Nm1iZi9PHqseoqlUQD9ee1NS33G/kVEV06LtTASC17zZr6CZr2+0o7VIH5CXUv9kcJ4OxfqrFbsN4aYRUXbBj+pe/+GKkZlRQHrT7euCpkRUxIxbwALKfpW8bbWqlUHDRpbsqYvcsWB/XrR3SYzn4CuoMYYpUrtzi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOuB/MPL; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOuB/MPL"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12dfee30612so501163c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 14:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778016139; cv=none;
        d=google.com; s=arc-20240605;
        b=fDBariZWpIdUk7EwW/Od+hXj8y89qjgcaEpOGneTJpLZJdzR0YqRfDR0wVJPgsmGj/
         O6iYrgAXGDsMDyKpUe5JMyyFsiUc2N0T4Pin5b2g7K4OzgU8OodFW6brkNXcc3iUSdXo
         nbzhkhxr7GEJWzR/SiL5qu5tksNpX9j5xuavmUVE4UIPbeACcJX5IFxU+5uIRhgEcopc
         ahCMpLp7mAZeIUWW135PO0qA7ungfF3k/4EAr36NMJIBeAX49D3oL0KN6NfSOn1u3RFs
         p5etxX0+kL7wrjroaGjGJ1CW62Y3Z1ktBHhh/dFWeFwjyL/sk5DfPlCUR7sW8P+ZeSOH
         0lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yu87EAoBukX/KVRU7s4f6oW8P8epc6SQ3HgJixfTMSY=;
        fh=uUoS/MZSlpe3170XvblyIgr4tHORP+GKXBXYgZfe5uE=;
        b=RRmAlPZ7kfPPKAfCwUvt4QJL9DmUK1XEQXIbkhN1I9ztj7x8jeGR9aGiDMpigfC4lF
         b4PH/fKiERfhjRxLO53gsJ5PttMnnUG+HliS0o86+kU4uGwB2M9taQ1Rvmgff2TqydE+
         VspVBf4IXKE+HuDIxP6YyaqRtcDAmnN88Ii1L3h9rLGTIQqsWL/a0RZlpooIALjJ2wH7
         pk0mJDGB3eAXJiNBVXKQs+x5ocyo/MosrLbUAsXpv4rzLffbulm5vuqQXJ1x7gEf79rq
         j7teT4XkQrNqu2aewJNOiIbXJm8B8Yi7S3/Ja8rjERmhFelIitFgnsyRlWENtsXKAE3v
         VtBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016139; x=1778620939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yu87EAoBukX/KVRU7s4f6oW8P8epc6SQ3HgJixfTMSY=;
        b=QOuB/MPLdsJ95ZkTUimCHkwr0fsBzBqUo44qQRpUMXaKBnS03C+erNkEV4Du9Rw7ef
         yw+HcNq4g4MKi1FBjfhmzwBmOBVcU26rccbTWVuN4WP+bFMazRXWNb5+azjno+BylZFm
         0Rv63u7R3fTCzIBfFbXCkQFL+rXFdXIf64ytSMSZ2JyYiYnONCZUxM35wsLqHbnaJgmw
         FoITs/4jnIRnbyAS3Ow62WeQXfScc9wUDnW9xX1c7KtMvTD6PiizQe3vlsYT7YitsY3K
         Fa1/JBpru4skrKvhjBgvgIxBwK2PdTEs6xdZDF3/ZS99cUDvMI+Lw8Nw1QMSSQsl0f4w
         +tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016139; x=1778620939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yu87EAoBukX/KVRU7s4f6oW8P8epc6SQ3HgJixfTMSY=;
        b=JcnOS/z2SMOsijeIOCrA5hedRukAtho7havgp38VW2ToqVnYIhWOK20p2oKvG8AUzw
         dNHujis5l71z3VpOILNYHGvKhNUJb0r2QNAJLclD0OMoTMn6NKxVh8KYTuPI512mFZ+v
         une0OoJdG9vS5d+GIcM4F+bE2mizFZD3DNtI30kjwsNLiwqB3+Cyjav6fOdwrK8Q7aKB
         DO8G0ENgaTJj7WawkePmx2GVTz3NtZIQguRZdycTTf5TiF6GLjF8e4k35hrXUlao8NAN
         Q+4QN1hi3GqjPnKZUUr+OefAyP1wioL2CvXWy7MeRBVc7YPl/lxz7FDk+nU3swphN5WJ
         sQ1w==
X-Forwarded-Encrypted: i=1; AFNElJ9WR4fAGysAVRazH2naqeLmFVHDaY9v9aSFvRcgjrnO6cPUCsPzuMfTYt2Sqnqv/T2GVQrSOl/e6lh7FtVioOaO@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmA1RIBqaoLvDP3BJy/FOMwDaPDGWS2XrbmcGUahOOpmR6wJR
	hQkg1QHdwEXXgkyG+RzhJVQs8Xr+b8+92p2VyPwRo84bI5RNmsdQaNoxq9EOikblQ9QC5iNiHJn
	A3f0SiTzDISffQdH56p2Lktzaoyl4Xa6ayEG7mU7E
X-Gm-Gg: AeBDiet8USzPtFjJoZWV7A7ny4X5Ewr47sWpcU8GkwciwFie9bebViYKFVnPUg9QUwY
	+fFG8O5PhfUdLZffAcQx+o4LXK667J0NnX/rRcJdXmJjiIoBNfci80hqIlxPjGIQMogZPIFuL2M
	VpgDfuDdYMcdqu3ap63hWyvLs2EO/TocrSzbKGY6sRcrK5UaoK2Hn2wbwEGX+S70loOQUr17LLj
	eSZvDhUHME7X2NqLEhKqKJW/h2l5z48fMCdMZzNBLQPXGEjcdUd6Li5XK2buIJykHhvbcrsK5lc
	5cS3Y2VZEva4Zn+zK61b/d+/cG2OtCrebKSGtzWI3Yd2FPWQpqWmLCFbJx0=
X-Received: by 2002:a05:701a:c96f:b0:130:ca6f:6c3d with SMTP id
 a92af1059eb24-131853ee0d9mr576761c88.1.1778016138338; Tue, 05 May 2026
 14:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501223413.1001483-1-ctshao@google.com> <aff7gc4dJGMRnoi5@z2>
In-Reply-To: <aff7gc4dJGMRnoi5@z2>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 5 May 2026 14:22:06 -0700
X-Gm-Features: AVHnY4L57XbJl1vOBmen6deuZvloUocwqu_RvcFqZUH4Q-fa_oBf4a5RsqtMV9U
Message-ID: <CAJpZYjWF9UpB0evhNFcRTQ0AidgixTjCZYtfb25rq5bQ2W-Gzg@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: Ensure event leader stays at head of
 evlist after sorting
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My apologies, resend the patch:
lore.kernel.org/20260505211924.1961056-2-ctshao@google.com

On Sun, May 3, 2026 at 6:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, May 01, 2026 at 03:33:47PM -0700, Chun-Tse Shao wrote:
> > From: Ian Rogers <irogers@google.com>
> >
> > For evlist of a certain event/metric, the HEAD should be the event
> > leader. In some scenarios where uncore_xxx_0 does not exist, the event
> > leader is not the first element after sorting. For example, on my test
> > machine uncore_iio_0 does not exist, the event leader is uncore_iio_2.
> >
> > However, in `evlist__cmp`, it was reordered based on the PMU name, whic=
h
> > makes uncore_iio_1 the HEAD of evlist, breaking the following merge
> > logic in `evsel__merge_aliases`.
> >
> > The patch adds a loop at the end of
> > `parse_events__sort_events_and_fix_groups` to make sure the first
> > wildcard match is the earliest entry in the list, updating pointers
> > accordingly without breaking reordering detection.
> >
> > Tested on device lacks uncore_iio_0, and `perf test` looks good.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> > v2:
> >   Adding missing Signed-off-by from Ian Rogers.
> >   Renaming variable `l` to `orig_leader`.
>
> I can't see this.
>
> Thanks,
> Namhyung
>
> >
> > v1: lore.kernel.org/20260501043532.790711-1-ctshao@google.com
> >
> >  tools/perf/util/parse-events.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 1497e1f2a08c..be825617321d 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -2251,6 +2251,33 @@ static int parse_events__sort_events_and_fix_gro=
ups(struct list_head *list)
> >               }
> >               last_event_was_forced_leader =3D (force_grouped_leader =
=3D=3D pos);
> >       }
> > +
> > +     /*
> > +      * Make sure the first wildcard match is the earliest entry in th=
e list.
> > +      * Since list_sort might have reordered the aliases, the original=
 leader
> > +      * might not be at the head of the list anymore. We find the firs=
t
> > +      * alias in the sorted list and make it the new leader, and redir=
ect
> > +      * all other aliases to it.
> > +      */
> > +     list_for_each_entry(pos, list, core.node) {
> > +             struct evsel *l =3D pos->first_wildcard_match;
> > +
> > +             if (!l)
> > +                     continue;
> > +
> > +             if (l->first_wildcard_match) {
> > +                     /* Original leader was redirected to a new leader=
 */
> > +                     pos->first_wildcard_match =3D l->first_wildcard_m=
atch;
> > +             } else if (pos->core.idx < l->core.idx) {
> > +                     /*
> > +                      * We are earlier than the original leader in sor=
ted order,
> > +                      * and no earlier alias has claimed leadership ye=
t.
> > +                      */
> > +                     l->first_wildcard_match =3D pos;
> > +                     pos->first_wildcard_match =3D NULL;
> > +             }
> > +     }
> > +
> >       list_for_each_entry(pos, list, core.node) {
> >               struct evsel *pos_leader =3D evsel__leader(pos);
> >
> > --
> > 2.54.0.545.g6539524ca2-goog
> >
