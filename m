Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775041A0B08
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Oct 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970939; cv=none; b=H7UjWMfzYQLCkuai3R9OqKhz7Ti1ZNJPFOzLziJOY6EawTgYJrIq4qIX0Pvj1NDTdEWJACjrpj0LliWLlPyJk2+6CZbQ2oG3lC923kCNTh3+AGLLSDS84UEdXSV+7uU1p01tMdvazntkaZU63I7MfATJbh+3CerOD+ouuD2EjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970939; c=relaxed/simple;
	bh=SGahG/N1tq3/KnUlmQU7K3AWP4zOimXJG8LWQWjPAaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AysetLWHINxeC80i+4KRfUEhDHIraYbmZkpk5ddKOpR/38+dW0vnNOORbGB8zobUv6VLRzHEOEzSHFDK50Bi081dnlBadwbQWUQNtxSVEdR0qfM7WrE1l6CswfkQaTgDoOHuz7xY338OF+My68IsF/GKo09tuup0dDKooP0COAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4OC5Nlc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4OC5Nlc"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b3d1a77bbso207405ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Oct 2024 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727970937; x=1728575737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ex1JXu3L4eyD86pN7yBS2jVqd+Gvp1J6AL4cOr5DbI=;
        b=u4OC5NlcIUyWDxlV886t+A0ynJvKbSvTMELylbrZFXG/2mphfkgV90sx00bUX3imsR
         vP7ggn7Bggyc/nK8i2VrigKt16q/FIRsRl/2fwCuMFSji6ko0IZMyYN+R7TMGqaN9uTo
         1uPybVYslwOIIEkUVrjTonyMzFR0om2X27OLlonE6WlAFtNDZeS/9e15rEdwvUQM8x+Q
         6j+dHsv7dRXgriYDkXIx+m1Ttc16in1nn5J3giM5e782EuE4WyCfVcgq94avBWLHsFw6
         XPGLjqia9TgyRRIHfe3X5goq0D3+WBdDGqzYPS2EYt9dkLwgnV72wE4fdXe+yIu93Sqa
         LRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970937; x=1728575737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ex1JXu3L4eyD86pN7yBS2jVqd+Gvp1J6AL4cOr5DbI=;
        b=ICIBUDOurPYQPfxuksAh2e82DZC6wS3qIHG4R3NFlEwe/zTjGHN5cU/NR+ZWBdcJEP
         qk3n4POQ2WHSeZNFhQMqe4MzGEdUxKCo3WaWMJ5lGo0W/m1JcbVKNAk05sOHC5M5KsUf
         jvNUzOKqpvogh8hoFOLBRxNDWpbAfz2W9mgyfH/xSiRfKtvCgKa0H0pE2XCQDSH9a8Fh
         bLZKJ2GPLlo7WHyEKIjXP3Ya7euS41ooYZZGkahfVc55+06qZESLjJIPpAgBM2Hynpo+
         1BrOEu9mtAHZeMlLU86bTPFem/sLaR4RFemj+txQLPbYwg6y8ysECAkEZWs5E8PKIL8l
         JqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxyx12vutfb7dDtyqxcMfSGzRUs95wNNEc3nlLSGdwVqb5JTL4jL3KtOuV9QqV1/bQin/2IBpA6uLSkm7l45GW@vger.kernel.org
X-Gm-Message-State: AOJu0YyemS7rDe15UBYeITbqrnq6isyBAGc/XJlKHuQtqDfKmEqLhguG
	0jZbceBB+WWYLyf1YuHRBhs/zxLfzy39dRd6QCa5ZP2tek3npY1A+on43dFYOpv8BKxMP/loyvh
	yMRhUOgVroP1sqCD1Q4oJCLRd8j4okFIbhwLb
X-Google-Smtp-Source: AGHT+IHmXJ421FemXvg9O8j9jAPdOHczFjwD9cz65O2le4Kil6FrN//n+oDFI/frJDIuvlooV0jGwgxdDbOuZfgBOng=
X-Received: by 2002:a17:903:120a:b0:206:ad19:c0fa with SMTP id
 d9443c01a7336-20be3a7e80dmr3221295ad.0.1727970936336; Thu, 03 Oct 2024
 08:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com> <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
In-Reply-To: <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Oct 2024 08:55:22 -0700
Message-ID: <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 7:57=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-10-02 8:57 p.m., Ian Rogers wrote:
> > On Wed, Oct 2, 2024 at 5:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >>
> >> On Tue, Oct 01, 2024 at 03:32:04PM -0700, Ian Rogers wrote:
> >>> On Tue, Oct 1, 2024 at 2:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> >>>>
> >>>> On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:
> >>>>
> >>>>> Changes:
> >>>>> v5 -> v6:
> >>>>>   * no function change.
> >>>>>   * rebase patchset to latest code of perf-tool-next tree.
> >>>>>   * Add Kan's reviewed-by tag.
> >>>>>
> >>>>> History:
> >>>>>   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi=
@linux.intel.com/
> >>>>>   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.m=
i@linux.intel.com/
> >>>>>   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.m=
i@linux.intel.com/
> >>>>>   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.m=
i@linux.intel.com/
> >>>>>
> >>>>> [...]
> >>>>
> >>>> Applied to perf-tools-next, thanks!
> >>>
> >>> I disagreed with an early patch set and the issue wasn't resolved. Sp=
ecifically:
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/?h=3Dperf-tools-next&id=3D3b5edc0421e2598a0ae7f0adcd592017f37e3c=
df
> >>> ```
> >>>   /* Followed by topdown events. */
> >>>   if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> >>>   return -1;
> >>> - if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> >>> + /*
> >>> + * Move topdown events forward only when topdown events
> >>> + * are not in same group with previous event.
> >>> + */
> >>> + if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &=
&
> >>> +     lhs->core.leader !=3D rhs->core.leader)
> >>>   return 1;
> >>> ```
> >>> Is a broken comparator as the lhs then rhs behavior varies from the
> >>> rhs then lhs behavior. The qsort implementation can randomly order th=
e
> >>> events.
> >>> Please drop/revert.
> >>
> >> Can you please provide an example when it's broken?  I'm not sure how =
it
> >> can produce new errors, but it seems to fix a specific problem.  Do yo=
u
> >> have a new test failure after this change?
> >
> > It may work with a particular sort routine in a particular library
> > today, the issue is that if the sort routine were say changed from:
> >
> > if (cmp(a, b) < 0)
> >
> > to:
> >
> > if (cmp(b, a) > 0)
> >
> > the sort would vary with this change even though such a change in the
> > sorting code is a no-op. It is fundamental algorithms that this code
> > is broken, I'm not going to spend the time finding a list of
> > instructions and a sort routine to demonstrate this.
>
>
> I'm not sure I fully understand. But just want to mention that the
> change only impacts the Topdown perf metric group, which is only
> available for the ICL and later p-core. Nothing will change if no perf
> metrics topdown events are used. Very limited impact.

How is breaking every ICL and later Intel model (excluding atoms)
limited impact?

> I like the patch set is because it provides examples and tests to cover
> the possible combination of the slots event and topdown metrics events.
> So we will have a clear expectation for different combinations caused by
> the perf metrics mess.

Tests are good. I have no problem with the change, possibly it is
inefficient, except that hacking a sort comparator to not be symmetric
is broken.

> If the algorithms cannot be changed, can you please give some
> suggestions, especially for the sample read failure?

So this is symmetric:
```
if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
  return -1;
if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
  return 1;
```
That is were lhs and rhs swapped then you'd get the expected comparison ord=
er.
```
if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
lhs->core.leader !=3D rhs->core.leader)
  return -1;
if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
lhs->core.leader !=3D rhs->core.leader)
  return 1;
```
Is symmetric as well.
```
if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
  return -1;
if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
lhs->core.leader !=3D rhs->core.leader)
  return 1;
```
(what this patch does) is not symmetric as the group leader impacts
the greater-than case but not the less-than case.

It is not uncommon to see in a sort function:
```
if (cmp(a, b) <=3D 0) {
  assert(cmp(b,a) >=3D 0 && "check for unstable/broken compare functions");
```
and we could add this here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/list_sort.c?h=3Dperf-tools-next#n22
Try searching up "Comparison method violates its general contract"
which is what Java throws when its TimSort implementation detects
cases like this. If you break the comparator you can get the sort into
an infinite loop - maybe that's enough of an indication that the code
is broken and you don't need the exception. As is common in kernel
code we're missing guard rails in list_sort, were the comparator
passed to qsort then expectations on breakage are a roll of the dice.

I believe when I originally gave this feedback I didn't think the fix
was to do it in the comparator and maybe an additional pass over the
list was going to be necessary. Basically a sort needs to be a sort
and it can't kind of be a sort depending on the order of the
comparison, this is just incurring tech debt and when a sort tweak
happens everything will break. As the usual chump cleaning up this
tech debt I'd prefer it wasn't introduced.

Fwiw, I refuse to carry this change in:
https://github.com/googleprodkernel/linux-perf/commits/google_tools_master/
and if the tests break as a consequence then the appropriate thing is
to revert those too. Linus/upstream maintainers follow a different
plan and that's their business, I can't build off of this code.

It is unclear to me why we get patches that have been pointed out to
be broken rebased/resent repeatedly without the broken-ness corrected.
For example, the abuse of aggregation for metrics in perf script. At
least point to the disagreement in the commit message, call me an
idiot, and let the maintainer make an informed or uninformed choice. I
am frequently an idiot and I apologize for all those cases, to the
best of my knowledge this isn't one of them.

Thanks,
Ian
