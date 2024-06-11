Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D41411ED
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Jun 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138011; cv=none; b=mJFktmxOZPd+xquJomTdF73fykjQuUcPrvBdQJCw9TapKToqI1bu9bcDjahkSsSuAOVYoIsbYD311afsNLIchF4Y1APnE0HXJyHlKxitVpslqcuqJnkdxZZ1e4KXliy+z1k2h9Vw+xkejHLfqC/jqKIJ200lqUVEYaX5tRw9sGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138011; c=relaxed/simple;
	bh=XC4w7FqUQ2wQZKdU5omXsL3G30oQ0DhgQCJ4Jv1zZ0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuQsB139FgR6w5pfPzQd4X72sb4UPmLIjhC8+otX36VXb7l9749bN/clshvYGcnIIYf3Cs3qtpeT7rW0++k/1ig64z4tdlpcOufdNcZ/0mpZysFlviTk4RMOAWCi4+BXrHxYsGASoMduhp691wXhcs1lZPbIRrNaSpiUOewH+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3XQxoy0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3XQxoy0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so734a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jun 2024 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718138008; x=1718742808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1oMY5Ka+Igm5IVLZ0jHXnRZ7u2UNpiSxg2NGEZJXKY=;
        b=C3XQxoy0X3wzvzMtLynriEWutEal5Ejs5qOIs/UNKdTUtMWAtt0qvfTF36hx+DWBVS
         DmfMdjB3mlP8LAf35YMQm6MMhsXTSYyynwMOMmpB9JWyPsux+KG8Td+/ddehDnq9GLyP
         +5I+Dz5z7PFQTY1EkicLZiBPBQfwya6ENmIYqJzoEa7HLeKk5qToa6SSLI6UMgrNK63v
         oxi5HH0HcebF/8/3SzF9qRn3GcBktSBpi1aCgoL4up6loBpt6Je8bLP1i9roTxmQzRmk
         ztboi13Zpx+qSGkR6m27/BfIiGP0JfsJMAqRpVojSR8aFbLXXnQmbR9u4uUID7z2E07p
         b7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138008; x=1718742808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1oMY5Ka+Igm5IVLZ0jHXnRZ7u2UNpiSxg2NGEZJXKY=;
        b=LSTp3QX3GY+efcjJ2Qy9d1JfnceDuHEPMBtrwV7LiwnzaLcHX7GB1K/W5uROlDi+xY
         aoTMnotgtSYalIuQigwP/ncm5noWAiahtolncKPoY6/6NZXZH/FHDWL04Uhdq868cX6T
         h3STTBouEub6JKqCF5gKNUlCoInnUb7Tw7ibR+SDIYvc7KgxdlPkYcNVNMlV500C840t
         wJI1QboHONO4lGx6B9reOXquFmR443uTLMMwdNqwCymhkaHLROqrR6AIc1G0dJ8SmaMU
         UT6NZ3SUz3xKVr9rEsBPtKxcnO27jFdRNDtqLuk13e22b4lN9vaXUdJ2VjzxhU0Zj4lU
         JqmA==
X-Forwarded-Encrypted: i=1; AJvYcCV7nZ0yiUDCDbV+4M5jkPnN2LR3ntsgOQm0ggWUNvpnoUwiXus91yuNkTpFkznmBn069TTRh+PQMyFfZGahhS0gjxsTM1bRbSSqkfDQTbYmOQ==
X-Gm-Message-State: AOJu0YzSd8cedoZpv+GauIzPz4vAyur1GlsYgVOBiJfi90oiVfmJxfD3
	GOkdIQmUYbBTcpdGh3x0J3GGJBjYTOeNaVmWkwbvyQoCOhKZRtsfPUcVH6LkHHRcNooN5ro8c45
	asip1AYbONv0ikzmqG08W+vhtVezv1fJeL4U=
X-Google-Smtp-Source: AGHT+IEJZSZPp5uDEJF66yku2G52k7zoY/A/fEWKARj7DqwB4Q9rt6zOLddjPGDLpteJ63WCdIVY0NriCA360ZVJwkE=
X-Received: by 2002:aa7:cd17:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57ca7fd71e8mr38069a12.6.1718138008253; Tue, 11 Jun 2024
 13:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515193610.2350456-1-yabinc@google.com> <CAM9d7cjmJHC91Q-_V7trfW-LtQVbraSHzm--iDiBi7LgNwD2DA@mail.gmail.com>
 <CALJ9ZPML-QNcsJfo6tBMfmJzb=wF1qQsMFTbNvtRwH-++J1a2g@mail.gmail.com>
In-Reply-To: <CALJ9ZPML-QNcsJfo6tBMfmJzb=wF1qQsMFTbNvtRwH-++J1a2g@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Tue, 11 Jun 2024 13:33:15 -0700
Message-ID: <CALJ9ZPNkO=_OKPDwdSY9tJw+AETaAVC2m-1UcWScZ0TaFmHRkw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] perf/core: Check sample_type in sample data saving
 helper functions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 10:59=E2=80=AFAM Yabin Cui <yabinc@google.com> wrot=
e:
>
> On Wed, May 22, 2024 at 9:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > On Wed, May 15, 2024 at 12:36=E2=80=AFPM Yabin Cui <yabinc@google.com> =
wrote:
> > >
> > > Hello,
> > >
> > > We use helper functions to save raw data, callchain and branch stack =
in
> > > perf_sample_data. These functions update perf_sample_data->dyn_size w=
ithout
> > > checking event->attr.sample_type, which may result in unused space
> > > allocated in sample records. To prevent this from happening, this pat=
chset
> > > enforces checking sample_type of an event in these helper functions.
> > >
> > > Thanks,
> > > Yabin
> > >
> > >
> > > Changes since v1:
> > >  - Check event->attr.sample_type & PERF_SAMPLE_RAW before
> > >    calling perf_sample_save_raw_data().
> > >  - Subject has been changed to reflect the change of solution.
> > >
> > > Changes since v2:
> > >  - Move sample_type check into perf_sample_save_raw_data().
> > >  - (New patch) Move sample_type check into perf_sample_save_callchain=
().
> > >  - (New patch) Move sample_type check into perf_sample_save_brstack()=
.
> > >
> > > Changes since v3:
> > >  - Fix -Werror=3Dimplicit-function-declaration by moving has_branch_s=
tack().
> > >
> > > Changes since v4:
> > >  - Give a warning if data->sample_flags is already set when calling t=
he
> > >    helper functions.
> > >
> > > Original commit message from v1:
> > >   perf/core: Trim dyn_size if raw data is absent
> > >
> > > Original commit message from v2/v3:
> > >   perf/core: Save raw sample data conditionally based on sample type
> > >
> > >
> > > Yabin Cui (3):
> > >   perf/core: Save raw sample data conditionally based on sample type
> > >   perf/core: Check sample_type in perf_sample_save_callchain
> > >   perf/core: Check sample_type in perf_sample_save_brstack
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
> >
>
> Hi performance events subsystem maintainers,
>
> The v5 patches were modified based on Peter's comments on the v4
> patches. I'd be grateful if you could take a look when you have a
> moment.
> Thank you for your time and consideration.
>
> Thanks,
> Yabin
>

Hi, friendly ping again for review?

> > >
> > >  arch/s390/kernel/perf_cpum_cf.c    |  2 +-
> > >  arch/s390/kernel/perf_pai_crypto.c |  2 +-
> > >  arch/s390/kernel/perf_pai_ext.c    |  2 +-
> > >  arch/x86/events/amd/core.c         |  3 +--
> > >  arch/x86/events/amd/ibs.c          |  5 ++---
> > >  arch/x86/events/core.c             |  3 +--
> > >  arch/x86/events/intel/ds.c         |  9 +++-----
> > >  include/linux/perf_event.h         | 26 +++++++++++++++++-----
> > >  kernel/events/core.c               | 35 +++++++++++++++-------------=
--
> > >  kernel/trace/bpf_trace.c           | 11 +++++-----
> > >  10 files changed, 55 insertions(+), 43 deletions(-)
> > >
> > > --
> > > 2.45.0.rc1.225.g2a3ae87e7f-goog
> > >
