Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D93CD8D3
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851362; cv=pass; b=bUb9F6mU5MuDQ5yK82zYkt+r8AgzgIOp4CtlkCP3m/9clFxPS/Orz6sni1EpdlRTkCxRnQ75jmMRYTi+Ji12LukAC80cC/qLm/It1/M1fL2gxOu8ZZ41ZmBQVZMAoStqWfuU9kkUmzRsXF7a9sINFQMN6MD9EawIgQ7Hy/RKdXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851362; c=relaxed/simple;
	bh=CGgxIxmXNw55BQSjzk0SdpCcRauEqFfgu6PDtbvAlT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbX7QFBXHRMcmBU6sORAPR9wNc4aBbqnIUx5OWK78Dx51hBNtpjUxRviMDJ56r8xTi0VYim4LS4MWERehgPqxrFvOfXY3RggfePA3igUr6QEAYNCUdlpjRlGMN76jSKnczPqGnU+PzWYVA4Y6xWx3Qi3D+YFCzo+EMxgknqPim0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNaigJFT; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNaigJFT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aeab6ff148so104315ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 09:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773851356; cv=none;
        d=google.com; s=arc-20240605;
        b=Qh86Z0cu/60ZZSNe6adCkQMZh3lEM1AeWLU/aQg9mwee7/ZZ2WuH9id4dhbnjyNqrV
         Z5Hixv64G0bne01wy/JOqE5wrRcAi3aq5bbIXLhbFOQSE79heghvWwOqh4sePe+Sx50z
         7kocjYHZ+pnRfygaEoO67pOT+b0WkTRQ3p02Qa4nAB/Rw+9ujMd2EQhQo04pCrNwhw7C
         rCmLcKsTsBAu2WEsajPKd6yXLFMHNBv5hFvIItYaiQMlTOw7AJiqp/VwAm3lIHmQzxIc
         H/ReDjyLTXJPtDK5mlV/BToRJuNKqbaaocRc2w0lW9VhOAZvHlbRpGqf5D9+F8kLCd3m
         KMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pcnFhfYoFXBBKtYjtjHUJaJIA0VnBP/0Xwihg0OjT8Y=;
        fh=z20jT+18dJI6+8KGZ/4hvkgaknFGEUSr5KrIP3sxjt8=;
        b=Q3tXJa8AWov4f8TwQmIhxXn9sVptKliJ7CjEQ57EAAZCzFQAQWQZ/MP8oaLMAaAPDE
         OmK92aof4gIgiJDT1htUtLQ1MdiSt1OcizvWsKopewtj2mS6o/I9sfnYQPHAwdhzPvih
         ryerHuN8nEinsCPTZolcEJUtPcUBXfM4UGWOVBoh0d6oIrqjxpD/LRMkA3usHjXTU1y2
         LHbVzaG8mNVtwXV+At2VZaztROZ1FlgDTn7cTDcJT/8TXjsCQ1CUwzZOb1dehgTJf8vW
         G7i2o4qeIgTdn3JdSc18ocPa2COvOEtVCQjIhiRTwff5lKcksVIauUcl/qdo48WV7d2U
         AgYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773851356; x=1774456156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcnFhfYoFXBBKtYjtjHUJaJIA0VnBP/0Xwihg0OjT8Y=;
        b=SNaigJFTPn6J/8lUuLSXfYs/ep+YmSz0JEte3M9CkGJgpH5DtQG7V8Z4iIExvUbSvb
         UwPQWSssjOC7CxRTD509TGBQyxFNz0Qs5JvoNlDcsX5qIxAQahKVY3U/a8UqKd0TnrCp
         sj8IwXamAY1T34BI6q+lQLfWZH/AZlEUwjWos4m6C5VwdCNzTjiwLfrqHNFRhTTGx6IG
         J1N+LOg32zC2dGEhG/O3LXcBCRmvFli6/uLECimYut2ymHEXfRJSj+lophC/e6NWjlEQ
         ks/SW6rdNRdF8rhO4UAdVEIE14FOX20875kSsIn1+qOWwAoGC68biVqTeJSEUHjpTJyI
         MKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851356; x=1774456156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcnFhfYoFXBBKtYjtjHUJaJIA0VnBP/0Xwihg0OjT8Y=;
        b=Z0nXknmK5T4epGMdI8aUXGvKnFZK6ORjYzBDaWLi5rWeuiO5t3g69/MAj368XeGwsp
         E70O56neMQ0SNT18lWdUxIKCFWcQfwhre/nTrqaJJjeovSF+q3uXjXNtAfXfJNamZlnm
         XNqKKp7W3VorkRUIEWFP56eYQhAd8MtfT8S3UHV5ZIaBC4AT1ZC54ZFLEl8cSxbvJzUP
         p3T9mf/bfC3FvQG60s53PlcXc9YOqFLOAzxVloeEfJCgQBqGl4bI8k8vqcHsjf0wDv7o
         YiQOlbhXfi43rIxItZjpGRUm83QiOKWGx0mFJ6eUBywd8kfqVSGPbLa0yl/JiarX+6Oq
         QWjA==
X-Forwarded-Encrypted: i=1; AJvYcCVXQPtI3QDjXC92jftQ8hHf3Q9Wk2Y/ST+m1Bb+a5ggrmeZ1GPeXSOkJyBAPFPOxSY3wvQDlmQB7/YWMDhLMCO7@vger.kernel.org
X-Gm-Message-State: AOJu0YwZPDFHdMOTBRiXhQaVJaV6uz1i8e74pJpKkliqGryNOr1VqnEQ
	wzr7Umu68oilBJj61fGsW8SppluFAr/iuHPVehmIQyHSPBuNkM8qmFuXhnor4bT4UXa9G264xSF
	KjFIEnOVMcf+dtsB7TExBen6+phprw85+bv3zk/tk
X-Gm-Gg: ATEYQzxBKHHMsidFTUqS9iU5R+lQsuEbz+Rslt+h9AKWRKH2pwdqM2QBvySEi+1+MlY
	MAXGHoGDUGkmtl/h4CcN+Fq2zgxh//HOGEKoXwPqXcm8pIIgdXK+0q9fgMw5CgjjbtztGZKZ3n5
	Sht6Htd25mEIizLQpm16cKInux6APPFivTdEUB3AZ7/3TApfhQO+34eqGB9tazHUyOznz7mEcJm
	ye0K71ycADVNprS612jzBaiHESBjmlA0zepPFlVP+yIZbSGmLgmLZ3SaK1tQXJCa5Z00QQ9qEWj
	nIvpMIfZ
X-Received: by 2002:a17:902:cf0f:b0:2b0:5683:1cf with SMTP id
 d9443c01a7336-2b06f851110mr2736005ad.13.1773851355100; Wed, 18 Mar 2026
 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUO8azimnOV2Ogb93nZ3eXnaLdGo6b+3wPVf0tMz29JqQ@mail.gmail.com>
 <20260317175642.161647-1-irogers@google.com> <d2396ba9-1859-49d2-b8de-94e87241a6f2@linux.ibm.com>
In-Reply-To: <d2396ba9-1859-49d2-b8de-94e87241a6f2@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 09:29:03 -0700
X-Gm-Features: AaiRm535Ic6_pS6RQwsVfgPObwsbrDdKOU3_lStKlZ7TQDGaHTJQxbIRI75Sv-g
Message-ID: <CAP-5=fWCf1TFMW8epW8moOcUbMuzRjrG1r38SWFevH35mqR0+w@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] perf evsel fallback changes, better s390 defaults
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 1:20=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 3/17/26 18:56, Ian Rogers wrote:
> > Discussion with Thomas Richter in:
> > https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm=
.com/
> > showed that the evsel__fallback wasn't working for s390. These patches
> > avoid the problematic frame pointer callchain on s390 and fix
> > evsel__fallback from a range of problems when falling back to a
> > software event. I simulated failures when developing the patches but
> > they are untested other than that.
> >
> > v6: Sashiko noted that target wasn't fully set up when creating the
> >     default evlist in `perf top`, so move it earlier. Fix const char*
> >     casting issues in __parse_callchain_report_opt. Make '-g' not
> >     override the .perfconfig setting again.
> > https://sashiko.dev/#/patchset/20260317055334.760347-1-irogers%40google=
.com
> >
> > v5: Fix the value for the top option to match that of record. Tidy the
> >     callchain parsing option callbacks. Based on AI review feedback:
> > https://sashiko.dev/#/patchset/20260317030601.567422-1-irogers%40google=
.com
> > https://lore.kernel.org/lkml/20260317055334.760347-1-irogers@google.com=
/
> >
> > v4: Changing the callchain parameter at configuration time means other
> >     options aren't set the same as they would for `--call-graph
> >     dwarf`, for example the stack size. Switch to setting the
> >     callchain option on s390 to parameter parse time. For '-g' use
> >     '--call-graph dwarf' for s390. Other --call-graph options are
> >     parsed as normal, but a warning is generated when setting
> >     `--call-graph fp` for s390. Also fix that sample IDs aren't wanted
> >     when there is only 1 event in the evlist.
> > https://lore.kernel.org/lkml/20260317030601.567422-1-irogers@google.com=
/
> >
> > v3: Incorporate feedback about event and callchain behavior for s390:
> > https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.co=
m/
> > https://lore.kernel.org/lkml/20260313202811.2599195-1-irogers@google.co=
m/
> >
> > v2: try exclude_callchain_user for s390 rather than fully disabling
> >     the callchain. Fix a missed clearing of is_pmu_core if the
> >     software event fallback.
> > https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.co=
m/
> >
> > v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@googl=
e.com/
> >
> > Ian Rogers (5):
> >   perf evsel: Improve falling back from cycles
> >   perf target: Constify simple check functions
> >   perf evsel: Constify option arguments to config functions
> >   perf callchain: Refactor callchain option parsing
> >   perf evlist: Improve default event for s390
> >
> >  tools/perf/builtin-record.c      | 66 +++++++----------------------
> >  tools/perf/builtin-top.c         | 67 ++++++++++++++++-------------
> >  tools/perf/builtin-trace.c       |  9 +++-
> >  tools/perf/tests/event_update.c  |  4 +-
> >  tools/perf/tests/expand-cgroup.c |  4 +-
> >  tools/perf/tests/perf-record.c   |  7 ++-
> >  tools/perf/tests/topology.c      |  4 +-
> >  tools/perf/util/callchain.c      | 73 ++++++++++++++++++++++++++------
> >  tools/perf/util/callchain.h      | 12 ++----
> >  tools/perf/util/evlist.c         | 32 +++++++++-----
> >  tools/perf/util/evlist.h         |  2 +-
> >  tools/perf/util/evsel.c          | 70 +++++++++++++++++++-----------
> >  tools/perf/util/evsel.h          | 10 +++--
> >  tools/perf/util/target.h         | 12 +++---
> >  14 files changed, 217 insertions(+), 155 deletions(-)
> >
>
> Ian, thanks a lot. I tested it using the same sequences as for v5.
>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas! There's a Sashiko review that moving the target
initialization for `perf top` will cause issues, I'll do a v7 with
your tags. That change shouldn't impact any testing.
https://sashiko.dev/#/patchset/20260317175642.161647-1-irogers%40google.com

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
