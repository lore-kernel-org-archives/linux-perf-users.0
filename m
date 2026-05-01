Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA137756B
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673881; cv=pass; b=Vqxpxepihn0n3qW5bxgy0tGa3qYdfdS2ZNsxlhOF6pxbHzdQCsy3GyPPqH0XDRosRe8puCb/jpZzmNLF4NkfaWbk7aKiZ2Y9lPyDQ2Pnqs/EridY5hXo602R7gOLF25Y4TBH/4ehzIutk7kswbK/f1Int4hhaeAdSCmcJ/sZboE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673881; c=relaxed/simple;
	bh=SyQTueKS1s92WEIPgKe7uGVmk+RyfqQtSZZ3LZy45vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sk+glqnIk59neXy6Fb4Wr9OxBYafRmRL2cidHX1J9E1Wir+pki5zXBcCQnaewxcNjlAVs7vjrWeGWjG2y6+xoQ/6YDTr7GthhiJymqKaUwTfVrGAyrliYRN1tXaZ5IJ62bGa1v0BwxA22tZtQ+RyjDbnX6hYpvoyog7SNSyDFVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYeRd6M5; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYeRd6M5"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12de530cbf1so3929789c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 15:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777673879; cv=none;
        d=google.com; s=arc-20240605;
        b=XmWsk0r08B6c1AuvgXtwOr7PeYK2pO1StoJwcipmlKJ0E/Y2iJuOmsMdugvYPxBcFY
         /y+lIQq8f3hPWNFEthPEZD5m+ywUcluwayTCIP1TbNm5SPd/rruWzsutalN6fT3T/Q41
         eUcjBFOcZF9Aiu9paKjvDJ+j5RvhXMz8Fuk1jHtNUUw0SDLdggCkwPSeWYwN4OcZlw6h
         fR5Jd3jh7Dnp6X2KiVxPXzrJ/34UrBYY58IciZKV0gr6wlWin/lTMq9RkCI9TgNQXyXI
         R+bgFA0K4SqaGfv8pWL7tN3z3NKmx2ll+qG64PvGzSu7SmNV+n1zw/eD+tgMLq3f2YWD
         zjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CNjpxeMt6tlz2f2bjEaIXAlTN1cc+Tg2rM0LIJtBj/g=;
        fh=KMsIvAN49Q5YIOg5/ji9KAOUv0xJRB/298qtw4ac02E=;
        b=g1KBnr/DsSarm7kYSK7C0sNaGay4wlsnRL51AUAazqqbNH4CGysRcauOqQcpshih6I
         7rLEAONXLyDQq5jDFrsM7g7MuBlkzfSao24yta0GobtrjU3o/GweoQBP2rZUxqZLmXzL
         4yKvTTfLuOfAtrzWfKQv4GfFkgYFiFyq5+HVm00IqqMWZ3x9EQpb/x31SaSeXOyOxUi2
         WprIkqMkXykTyh1phmYVnn+Wf0h51mduvjAlrrWRkkIgL97riznW/DIqKZ7rXHf9CEPL
         F1QjE/oZx9xerfeCD6wdwcE3rqrjCVZVtuFGriEiuKC4zhj+wO+Oqi4uDf6CzTyA+1Xx
         n3Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777673879; x=1778278679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNjpxeMt6tlz2f2bjEaIXAlTN1cc+Tg2rM0LIJtBj/g=;
        b=VYeRd6M56G6UceqzRJA0/rcPOFjuLB7tL7ZmNQyNwvDS/xEtagkD9ODocB8LMKj7Sr
         HPua2xM7kpIJx35UngEbDXcRF1Cl2HLWMxZEeSmk3SyFedYLpE9Vs3shCGjhGh2jA3ey
         HQ6L5ZQl3TVc9X03RyOUvXnP2v4iN6kSsQQCUFzYOB3/n0QF0nmFBKifu2fxkOn3hTZt
         LVLCHaBHQKMXg9uZFcqkTvwVhXm6QcxpI4WLtPFH2vPzsZkZU003ojrgvHI8LRzfFKrR
         l05hOdBg42U+Zq0D2B2efJX5bP49JSRPfbhv2CnOvzLE7xY98gABOaLFpncRhY6LkqRN
         fhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673879; x=1778278679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CNjpxeMt6tlz2f2bjEaIXAlTN1cc+Tg2rM0LIJtBj/g=;
        b=RhvOXqqQtV+hm7/f+tbodx4DNGLFYZPQx3mB4aUIBJ5MK1GRpejSuSXYxNgSmBmHCc
         wXrioIgp6yovmoE8tyDGqTvnhK7uh12YEOpHUbWcIzHINLNY65Nh4P+DlzFjBNzkjIz7
         a+K+Ju1+oNzcj/Bj3qoOBBSG5osbWxqQHLqoUiGuieY2kUkgdg8HY9Ot5+U+mswQ/RKI
         Fpnt3Xus+u3hB/jipxI9ntZ30uzGhm8C1C89dhRrTNMzouwLb5eT/9qtAY7h4o3UiEzj
         fzuDOoPRui7yHTDwTrZShF7badb/9wx4N//XPX6wboY0fDTXEwO5CyVVz3b1Ft8ZfYt6
         2Cmw==
X-Forwarded-Encrypted: i=1; AFNElJ8DNT+VGWEMiONs9yOUDYN2vGUDZX/V6yegs6H7KLNhyuukLDFw6kj6J9ofYffmGYy9cVdErP+XKYnzdvxYZwj+@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3nM71I4BlpgPiEgQ00ArpYKo/akFyEcr7zkAn+M6muukWiPb
	DiYMPnG3kfAEO7Gp8TD5fAqlwlWshWAuM7cC6+B39zSAshu5VdHDEpcUkHm5M5unhEdG1bSdkBK
	DWFknHcC+hofzJWOr9Rq3Kxk1dRA0NQy8qy3Co7nv
X-Gm-Gg: AeBDieucjHpNwBptjTSMa6IxiV9qxnQFIDIT+vHhrYYqtHllXlOsJafaphNe1GoLjiQ
	Bs8gGoZRbe9PtQLt4hY456gORKTj/+Arzgo0lit5eynhBegb92UaUvEBR7VukuELnDuJl7ENQ9X
	CVL1Nm9GrxiT3nje5zrj0E0AKdthWWHqnCvvui/NtbV2WutHQ/LOFDEbym7ZFPz1FU0fEFehbc/
	RJ1Q3cKpmVL+RPItiuPwhwLAwf6Ye1V0iVYuPKjS7DxL2aWeo6JuvF1lz5WuZn0u+b7vbhlN3ps
	yKKO2ntS7tl/u6YFpKVzyYA9/Ks=
X-Received: by 2002:a05:7022:78f:b0:128:dedf:f56d with SMTP id
 a92af1059eb24-12dfd81a853mr464357c88.24.1777673878399; Fri, 01 May 2026
 15:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501043532.790711-1-ctshao@google.com> <afUZ2K-C4hMxcl7g@google.com>
In-Reply-To: <afUZ2K-C4hMxcl7g@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 1 May 2026 15:17:46 -0700
X-Gm-Features: AVHnY4I1frfrPm2IVlxQAIopzH9aV3e1Vcc7r3UTcvBZCBhqmy0AuxafsASXRdo
Message-ID: <CAJpZYjVKxBkO8zYtiLWooq-qrryPY7LOy0hqPdQ-Xhiv0_mjBA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Ensure event leader stays at head of evlist
 after sorting
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Fri, May 1, 2026 at 2:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Apr 30, 2026 at 09:35:10PM -0700, Chun-Tse Shao wrote:
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
> > Tested on DUT lacks uncore_iio_0, and `perf test` looks good.
>
> DUT?

Device under test, it seems like not a good fit in that sentence..
>
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>
> If this commit is from Ian, there should be Ian's sign-off before yours.

Can maintainer help me to do this while merge in or I should submit a new p=
atch?
>
> > ---
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
>
> Why 'l'?  It's not conventional and can be confusing with capital 'I'.
> Can it be just 'evsel', 'first' or 'leader'?

That makes sense, I will submit a new patch.
>
> Thanks,
> Namhyung
>
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

Thanks,
CT
