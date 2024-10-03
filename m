Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE3BE46
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Oct 2024 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917040; cv=none; b=OK5FEknKrfE+yEXA9PbV+yy+wzdz0II9mNziXHJ6wuKPyPD8kaLgDoICo2bapDNJa80dFIGEYcmaxV0JcJfNHvNkIev1AP8CJMsP9XgS2rU66FxpHBqv3VygK8T+2dla2U6I0SqahyLbU8ZwWZICpwNLKwRJ+S/6e/KhEVxkTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917040; c=relaxed/simple;
	bh=s3iRuWwOgs+Srvkadird9HGJaS6D5KVuQ+qqizag/4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2piMQoUgY7RhTE+U5zhjg1mjxV7rW+Oqjp3R5JQ0pT+DQCzONv+jzADk65jmunhXXp37acl+Wx4MmTcOjducSRC+IXPM0UgnlPL7JSwXCL+o9f4Kzc+Z5c0Od6gIWMgMv5oKhomMcWD5uK6vfYAtWzWEtQlnzz1wG6dsUi035I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jt5qNLG1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jt5qNLG1"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4581cec6079so127471cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Oct 2024 17:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727917037; x=1728521837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANXmoLN1XfUZ7NwwxdIIk7pwwoVnVYkzkVOhLe1c/iw=;
        b=Jt5qNLG1ayY2BBd2mjKEX3MDn68LncHbe6p59RjnCIoO4cRFN4x/WRy/ytZNaNltwK
         csnoIRytzLd7wfZSzsACIpxmmHgqrNFn7fZSBU3JdWT68BbXfvxycgwo8X/+1sa82Asz
         wQXtSxn5dSxV8WWdKEE+TaphmtN9i1Kp3c3iSdN1RQN+Tcl6/HzoLq6mSip6E5wNWWyd
         coYoAKpktqzypgAvLICXmJqRO8auMRlJKSv4NGJkGS0m+G4Q8pCH9Rq6WqTlCfXNfwOl
         aTRxA1r6+BKUKzXV7n3C1CwyW/IONS8R3Ux08WEKnwBTEm+NnhRKWUi+jjwRIZXsZaN+
         hQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727917037; x=1728521837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANXmoLN1XfUZ7NwwxdIIk7pwwoVnVYkzkVOhLe1c/iw=;
        b=fFonpHhTUVbrYbFdOaf3zXsqa44dSexjVCu6yOD0bw73WAjvInNBljcsaYbiC5ObSW
         4XumjdGGd9IJSyYwQzz6QWgd+H6/YsKv8ek5iEljsnjcq70sboqIvppTVQKm759Dug1I
         VLZmcJy0ifppVQA0qKYE46xsjAJ06dCWXnxR8x38GT4jxWQrd4dLC5IZhvBr/SGgsXQR
         GKP/nmoGfyJ7QQHI5FfgVC+3eeFquSONpIlC9qJwvccz79RvllsmhGRuPeZxuVNlp+sT
         b/sqI2nfLylzmZuH46zz8Ji70M3gYxHc/WY3cLowfUSjectwho3LgEm/8l9fFyBd0NfE
         HKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjgvSUu7XQ1k+lTpvUHd82Ep7d7GxWCSGT3Oxnm+ct0SMsLqspJMCe+m55DE3yMvBH9HeMMVa4U2MLiRV8P372@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeol4sGZysxtRoCJe5TaXGae5sYzPLx1kkPbfwvAaf91GLcv55
	h3a4UTUtNr84Ynp74ZQ9qWmyenELhQ3lQZCNBzN78O7pO3TEYm0kDf6lXSz3Bk93dcZgl25mvtt
	pcFQS6b5NiXJeAZc2Aue64tUvn+S5CI+e4coV
X-Google-Smtp-Source: AGHT+IGX3u/6eYc5RZL3XEYxz5kTciKsC+sGmiql7sxjQSsmsxEvmLJoyqZ1xq3VKZMHX02okJ3u+zN+RIEd9qCAuLE=
X-Received: by 2002:a05:622a:7892:b0:456:7740:c874 with SMTP id
 d75a77b69052e-45d8f871157mr891271cf.1.1727917037409; Wed, 02 Oct 2024
 17:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com> <Zv3ek7aBkQo0Z9To@google.com>
In-Reply-To: <Zv3ek7aBkQo0Z9To@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Oct 2024 17:57:04 -0700
Message-ID: <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
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

On Wed, Oct 2, 2024 at 5:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Oct 01, 2024 at 03:32:04PM -0700, Ian Rogers wrote:
> > On Tue, Oct 1, 2024 at 2:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:
> > >
> > > > Changes:
> > > > v5 -> v6:
> > > >   * no function change.
> > > >   * rebase patchset to latest code of perf-tool-next tree.
> > > >   * Add Kan's reviewed-by tag.
> > > >
> > > > History:
> > > >   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi=
@linux.intel.com/
> > > >   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.m=
i@linux.intel.com/
> > > >   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.m=
i@linux.intel.com/
> > > >   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.m=
i@linux.intel.com/
> > > >
> > > > [...]
> > >
> > > Applied to perf-tools-next, thanks!
> >
> > I disagreed with an early patch set and the issue wasn't resolved. Spec=
ifically:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3D3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
> > ```
> >   /* Followed by topdown events. */
> >   if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> >   return -1;
> > - if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> > + /*
> > + * Move topdown events forward only when topdown events
> > + * are not in same group with previous event.
> > + */
> > + if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> > +     lhs->core.leader !=3D rhs->core.leader)
> >   return 1;
> > ```
> > Is a broken comparator as the lhs then rhs behavior varies from the
> > rhs then lhs behavior. The qsort implementation can randomly order the
> > events.
> > Please drop/revert.
>
> Can you please provide an example when it's broken?  I'm not sure how it
> can produce new errors, but it seems to fix a specific problem.  Do you
> have a new test failure after this change?

It may work with a particular sort routine in a particular library
today, the issue is that if the sort routine were say changed from:

if (cmp(a, b) < 0)

to:

if (cmp(b, a) > 0)

the sort would vary with this change even though such a change in the
sorting code is a no-op. It is fundamental algorithms that this code
is broken, I'm not going to spend the time finding a list of
instructions and a sort routine to demonstrate this.

Thanks,
Ian
