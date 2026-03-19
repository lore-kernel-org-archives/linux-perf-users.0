Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A328CF77
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898780; cv=pass; b=F+xNBG04j3+n66lWIeLghE/ZctAl8iZqrOfUa7v7QO6otVvb7HAh7U65YiKUlti2YdIOd2izxgL5VjCm0JAjtxOuTmApaJiREILibQ6ksHyvBpNagxV7U2r9erkI+2Ph82bGUdvH4cbWIKzyKAJvIV78ggdVyW6jmbbzhbnV3Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898780; c=relaxed/simple;
	bh=d4dtVkzoDU7q1gZU6EzIMD9MaBklkUv/FswCZinMFrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VT2hip6XPRoVHDijE5XAA/n0VevFD39POEWVvDJDU1f2C5rp1grzf5HyQ8+WIb8dqh3obpJZTFgnZhsKRU0TF3kjwroZ/4VZsd4YPVA5gHICgJ67sTnz/YxR3Nz4TaTJOVERtPrBZiDTH9n+oC13a9gZe7aeQta3HdE6AFDrHDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hp3c5Y5S; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hp3c5Y5S"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aeab6ff148so37725ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 22:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773898779; cv=none;
        d=google.com; s=arc-20240605;
        b=IXlg7qItW8UyX5hsAVxACFjztpd8m9QjlloPGzB1b64N3ypq/csdBVQK7VqfxIQfXb
         vQ1CJVgihxbYYfK4MQa12RXvAqUuPC4jF2IsIiA2MX424v1ebMMQMx+elJHu8q8T8BLm
         3dSjT8qcCiCrZ4usT0B6TSdG5Mkaxk3X9ur7y6xP1p/teN2rCEjUT/BdVZxbODo2bIjg
         VCJkSoa/dFQo0EhS23/gfXIyyO3k0u15p108XvCAu25TUvC3M7uLQLI3eEOqiAYX+MGe
         yCfs+hd17QgGx+XU5DgAdAbbiTJoDGyu1cKLtcuE1TxUvR3j2katSL4P1vdmDYzhVt8R
         vcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=htjlOO4XkJQ4ehd0ipRSCdZaVjN/ob14rEkSLMPLvzs=;
        fh=/7kq+P/lUpjMFh6aPvsp6Sc2TjL2gFDMMRXohf4t0BQ=;
        b=SA0u8qc9W8hIfVc2Yy3U+3+ezOigKwsLUAnhOX1cx9ypzjskC9iU651bYARaVOUC+l
         mAN502PhABDP8OnSuG/PjxY1Ls+drFV8ikJgyfdmt7vdyCZ67Qr5pSCrfYA/n6vRdQF2
         273ldFKRLa1nGog7zO82lywfwTGgRnnmMOOU+FDBH9KocPiRV2LSb3SqQnkzfkzYcgOt
         4txddTF92l+GexZcWLnV3UbgJlSdSt9EcKVPyvrDCJKZzgktS+pKXfDnR3LfXMDQ9j2O
         +huDIjASSD8EzrGPPpYJP1ywwDckzNCLJactPIzbs0rT98aA4Q+cZB8LS+Cix5myN9G/
         IyJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773898779; x=1774503579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htjlOO4XkJQ4ehd0ipRSCdZaVjN/ob14rEkSLMPLvzs=;
        b=hp3c5Y5ScpvVbvrekNsYm9l0tBbxcOvIaa3TE+Ih4TIydN77Qvznwxj6mmJTDnZ4xM
         0feeNjSl596CpAlhJoZsRGdC4Cp8Fg3VPIDospK1K5OMMXt2qeFQFsu8tqF4J/7G41RT
         +W1a+eucAjt4gljmYxFpEOHo4yhRq/UhhnF28YMqrcBwHb/Io048HWSiAGP1LWIpfT2O
         lJZL9fIQ/leCIJRRAFqM2iwUqpeBfqbVvnR/VdOfWHLZzGSl2rHDVctZSNuUsZuoZRN/
         QqDIkhOrF2QJA7BTx1eFu3EG/DvKAp9OpOdDs1oGmk/jDqP/+HzhkEJiCQ3dPmrnV1+9
         dP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773898779; x=1774503579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htjlOO4XkJQ4ehd0ipRSCdZaVjN/ob14rEkSLMPLvzs=;
        b=FO1Um0UAbWZQG6HBm3rO8oOaas/6kXuv1laFWH07kkSsiEW3YHtg3KvqKxT+SdcxC5
         3L1WHynCQCu099t2jVW4rLoyqjQvzd8H3SUIzs1JQ7jZkpXzdgujXIUC1TaJnvRls/OF
         eikBL/+L6Xs2FdPdwhKYo0KmLLdMSgK01DsBmfEk/8yb0sCaqKnY4Ql+LlQtQLYMVzVa
         2h9ji7fBgfgr7n7Og1vpc4mm8RP4JDNIGJ6Azyo7b02cB0Vv3q45U9584DGFOthbxWjj
         T5WVppDU80MKWrXCOFNs62QykCtn/QrnK8UhxxZcwDmJyMZrJQVL3gAm3fMtud0tlLbu
         6XeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeAEw7gMtYV5+tQUlgXUGWYiwsNJQgKzV/u238y7cqB/muI1TYDzSPyctf3XzHqXc8m1maIjlMIBaIiuUYoAH3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2xt0UgoDSXnHFHigL++BbGAc02pWrd8ELJlon904fBnLgqq1
	oVEAgxDxM82mbqdxwKjDV6DPtlWh5SvZHOLODvewwe6tg9JiHhh9lMEGH70mqIdWt3nCwVOG+19
	9aSorbHkc28VyJ5jzVnKE9EPLqAN/LTlk8rdk2AOk
X-Gm-Gg: ATEYQzxIJH1ix8IuuzWDOHXXdYBdrNTvlyuupDtXbbJJguZo9bTx0gq/mf7Nxv3H/OZ
	Gjn4WfAmMwIUQSmE81cCBEPeVUdVS2vgVDF1kzFO0BCt/tHPEMOfOf0VqWbMxLSfUyW+klTas/r
	Yk1KkovJ6gA70nQzf+vWHp9gAblkKYMHGpVF0G9H+CKV5ysNSGpoVIqP6ezLzrcWomh5lVtaRc3
	hgwTJQLt3sE9DQQEzdUOuf+0jL4m0x+L84mSx5ZVa7KiBgePIXWaf1Mu6rppptF47ySwx+QAwQJ
	OeiAmzSq4h/UnW1yeTU=
X-Received: by 2002:a17:903:46cd:b0:2ad:6f9b:7817 with SMTP id
 d9443c01a7336-2b077e8cf17mr2042765ad.22.1773898777982; Wed, 18 Mar 2026
 22:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318175808.582009-1-irogers@google.com> <20260318234600.730340-1-irogers@google.com>
In-Reply-To: <20260318234600.730340-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 22:39:26 -0700
X-Gm-Features: AaiRm51WVkEbo2yRWjczdr_OVf_mYCmnDxfH_HvwH40cuXXVAtHg9_DcyaGADP4
Message-ID: <CAP-5=fVWNP-fpD6bCWBKNDnwcMkYwZcvkBgqGjTJJ0fFQko89g@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] perf evsel fallback changes, better s390 defaults
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 4:46=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Discussion with Thomas Richter in:
> https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.c=
om/
> showed that the evsel__fallback wasn't working for s390. These patches
> avoid the problematic frame pointer callchain on s390 and fix
> evsel__fallback from a range of problems when falling back to a
> software event. I simulated failures when developing the patches but
> they are untested other than that.

I think at this point I call it a day. Sashiko still has feedback that
could justify a v9:
https://sashiko.dev/#/patchset/20260318234600.730340-1-irogers%40google.com
Specifically:
1) software PMUs may fail if sysfs isn't mounted. This isn't a real
problem as "software" is a "well known" PMU that we create even if
sysfs isn't mounted.
2) the handling of callchain in .perfconfig files isn't right, but the
patches aren't making it any worse. I worry there could be several
more patches if I start fixing things wrong with .perfconfig.
3) the possibility to add another NULL check for safety exists, but
the code would already crash at the same point.
Apparently, the tendency of prompts to generate further refinements
instead of providing all the problems at once is a known limitation of
LLMs and the current prompting methods.

Thanks,
Ian

> v8: Address sashiko review that target wasn't fully initialized for
>     `perf record` with '-u'. Ensure the callchain is enabled with '-g'
>     and a .perfconfig setting. This don't impact testing so keeping
>     Thomas' tested-by tags.
> https://sashiko.dev/#/patchset/20260318175808.582009-1-irogers%40google.c=
om
>
> v7: In perf top, move the target uid handling back to after the evlist
>     is setup. A regression caught by Sashiko in:
> https://sashiko.dev/#/patchset/20260317175642.161647-1-irogers%40google.c=
om
> https://lore.kernel.org/lkml/20260318175808.582009-1-irogers@google.com/
>
> v6: Sashiko noted that target wasn't fully set up when creating the
>     default evlist in `perf top`, so move it earlier. Fix const char*
>     casting issues in __parse_callchain_report_opt. Make '-g' not
>     override the .perfconfig setting again.
> https://sashiko.dev/#/patchset/20260317055334.760347-1-irogers%40google.c=
om
> https://lore.kernel.org/lkml/20260317175642.161647-1-irogers@google.com/
>
> v5: Fix the value for the top option to match that of record. Tidy the
>     callchain parsing option callbacks. Based on AI review feedback:
> https://sashiko.dev/#/patchset/20260317030601.567422-1-irogers%40google.c=
om
> https://lore.kernel.org/lkml/20260317055334.760347-1-irogers@google.com/
>
> v4: Changing the callchain parameter at configuration time means other
>     options aren't set the same as they would for `--call-graph
>     dwarf`, for example the stack size. Switch to setting the
>     callchain option on s390 to parameter parse time. For '-g' use
>     '--call-graph dwarf' for s390. Other --call-graph options are
>     parsed as normal, but a warning is generated when setting
>     `--call-graph fp` for s390. Also fix that sample IDs aren't wanted
>     when there is only 1 event in the evlist.
> https://lore.kernel.org/lkml/20260317030601.567422-1-irogers@google.com/
>
> v3: Incorporate feedback about event and callchain behavior for s390:
> https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/
> https://lore.kernel.org/lkml/20260313202811.2599195-1-irogers@google.com/
>
> v2: try exclude_callchain_user for s390 rather than fully disabling
>     the callchain. Fix a missed clearing of is_pmu_core if the
>     software event fallback.
> https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/
>
> v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@google.=
com/
>
> Ian Rogers (5):
>   perf evsel: Improve falling back from cycles
>   perf target: Constify simple check functions
>   perf evsel: Constify option arguments to config functions
>   perf callchain: Refactor callchain option parsing
>   perf evlist: Improve default event for s390
>
>  tools/perf/builtin-record.c      | 81 ++++++++++----------------------
>  tools/perf/builtin-top.c         | 46 +++++++++++-------
>  tools/perf/builtin-trace.c       |  9 +++-
>  tools/perf/tests/event_update.c  |  4 +-
>  tools/perf/tests/expand-cgroup.c |  4 +-
>  tools/perf/tests/perf-record.c   |  7 ++-
>  tools/perf/tests/topology.c      |  4 +-
>  tools/perf/util/callchain.c      | 73 +++++++++++++++++++++++-----
>  tools/perf/util/callchain.h      | 12 ++---
>  tools/perf/util/evlist.c         | 32 ++++++++-----
>  tools/perf/util/evlist.h         |  2 +-
>  tools/perf/util/evsel.c          | 70 +++++++++++++++++----------
>  tools/perf/util/evsel.h          | 10 ++--
>  tools/perf/util/target.h         | 12 ++---
>  14 files changed, 219 insertions(+), 147 deletions(-)
>
> --
> 2.53.0.851.ga537e3e6e9-goog
>
