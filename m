Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34701D223E
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879484; cv=none; b=RhlalAVRDx8YHbCiP8Fyfue4HQcxezMCyBaMsKNFR/C44f+TOKAYsoTi6RbTG41ZJA7ZDedpf0LyGW+sNuCo9hMf1HKmj0xKXccKO4w8FB6sQhy82eUSeIngEYSuTINK4yuRgLd4zMHw0gBdYN+yd0tozce4Wkm7Xe3rJynCHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879484; c=relaxed/simple;
	bh=CSWmUrFZWc9onuvV22L4XOor6A90L8OZlFpH2b3CYi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWf50IEKkAhqO47ZlpSXnYjqJIjkDB7inLNeZCY+vLqVjbQ+DR4FtXmNOlKjBD8lQjvqvDiiyWXbziN/amhgBu4cbfz+VppHQ0i1jF070n05nfhBBfJ/dfL84Jix+ilIvepJgGe63C+hIQfZEIgVllr1HP1NKIgqfm4j/UcZnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bkb/49Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bkb/49Z"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b3d1a77bbso193555ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Oct 2024 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727879482; x=1728484282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM7+Zf/idW06POnNvCS7OHrrkGODD4Nf0LqSVTaa/Ok=;
        b=3bkb/49Zhd6HoAthZjrGHqAskoCFUJntRCd/w2Q0V/E4gNhJ1LavCKep5ZZe4NC1cq
         N7t1voVCKFXubl6FE85zwqLwfZktoMNUtrjHVmOz1pf1v7yV79TaWOKnqFCrTiqsEn5n
         kbe3dr5NXR2qmfbhfijjihxAOPVlQZT7p8O88ODiQIZyRejiSoYPMmRpfANKE7nWpVJk
         s/3NsWOCoQWAsW13ng4vVl/R4JGMn0AnbgpMo4gyujvDn7v0kd4ociHA4ikKPq0xmSxT
         Ybf/4S2DYZEquEX/zeGo9q0joW/T+AmJveJ1fsgxrUC2CKmRTMx6F/WGmKvIsF8IzYYr
         JKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879482; x=1728484282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM7+Zf/idW06POnNvCS7OHrrkGODD4Nf0LqSVTaa/Ok=;
        b=oYxZhMu1UEPoS0QTB5vqJidQ0yF4V2BmD8tXwnpHTDUK0OZUh1LF1AI7M039QDkU2s
         UuiqPXpNjTNLM/LlmgHRe2IH6sm1vDNMRuHokcDTBvpKHWO4SRhPR5duYG0bC0FN73N3
         sSole2i9oj9pBfQlY8fKOx4qPacWuXlkEwY4W6HT1xiGzjjSxoBHuRhi1TJYag1WS060
         W7fd4p6KsNbR5lWx7Epuc5x9QJFtEU0vDuXEl9yfpcmqF8o9gFelcxkEDHEbD7/gv2qB
         h4NXWWHwM6nlidZ0HF585l1ZIPIzt3qfGsSywvBkd09pW/vURe9RnRgxhyC6uddJ0r3z
         7r9A==
X-Forwarded-Encrypted: i=1; AJvYcCXrhE89nD2ctdATzhXyGSCHZ8H8z4wNN5D/i3c/oiLgNQVrM0AfqSxr55n0A55Y5iThzUm8k1P6R/7lF6tzkzSq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyxdrspx0GzSYJwSZRWjAgAPsBqJnq5PBpzMVs8r2XN+XJ5f9l
	PcfYsLeJ2ha0Yj5gfrQmR1OM9KqnBQmUXbOsgh1XtV0DiN7aH0guleXfA1SPvw3k5uQj98JSQl2
	qjGMnPFCWf0R9GVuXDhu/8gJQS7qeOkhVu57p
X-Google-Smtp-Source: AGHT+IEB6OZhK4KCuGoyBRzaby/YL6OjwEP+CHwoiUbLF/vZ/4e3KZ5l8jt05d/apzsvYPirD8e/y7zVG01Vpk7Xrv0=
X-Received: by 2002:a17:902:d50b:b0:206:9b0f:48f3 with SMTP id
 d9443c01a7336-20bca3931a4mr2005825ad.19.1727879481647; Wed, 02 Oct 2024
 07:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org> <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Oct 2024 07:31:10 -0700
Message-ID: <CAP-5=fX=5Ctgqr2pDodUrJpNfEcztBcRkCCTjhDEy+UeH9z1aA@mail.gmail.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:32=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Oct 1, 2024 at 2:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:
> >
> > > Changes:
> > > v5 -> v6:
> > >   * no function change.
> > >   * rebase patchset to latest code of perf-tool-next tree.
> > >   * Add Kan's reviewed-by tag.
> > >
> > > History:
> > >   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi@l=
inux.intel.com/
> > >   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@=
linux.intel.com/
> > >   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@=
linux.intel.com/
> > >   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@=
linux.intel.com/
> > >
> > > [...]
> >
> > Applied to perf-tools-next, thanks!
>
> I disagreed with an early patch set and the issue wasn't resolved. Specif=
ically:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
commit/?h=3Dperf-tools-next&id=3D3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
> ```
>   /* Followed by topdown events. */
>   if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>   return -1;
> - if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> + /*
> + * Move topdown events forward only when topdown events
> + * are not in same group with previous event.
> + */
> + if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> +     lhs->core.leader !=3D rhs->core.leader)
>   return 1;
> ```
> Is a broken comparator as the lhs then rhs behavior varies from the
> rhs then lhs behavior. The qsort implementation can randomly order the
> events.
> Please drop/revert.

Tihs is still in the tree:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/?h=3Dperf-tools-next&id=3D3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
It should be invariant that for all comparators that:
a < b =3D=3D b > a
This code breaks this property and so event sorting is broken.

Thanks,
Ian
