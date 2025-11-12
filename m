Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31FF32861F
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965437; cv=none; b=IbPM2knj7cMRGkjygw/RMxj98iTRzY62fMQ6xQNGwTD7181HM/ycuaGTPz97srt+6dIW//JGyoNFbvFNr5fBy4j8qI7HpywcaEI+eAea9YPqVX/egRBhQu7iZvmBlabcxRa/4iFvaIWZ6wje9ChvJaMTaPW2QJCUMvK/NsFDltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965437; c=relaxed/simple;
	bh=y/sJC5qxtjPyc2gXXFUC3VvLNx6ICKkpfTbgbKKn72A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGnAWlvVTfGzUt9lFBfZKfaYg8zq/XTz0wlI6St0hCMoHHOrhmMeugTtD37xUN6qK8Tuz+xWsq2pwM/PuRstjUb/LkVkf7RIiVa3+YpnARWH3+mQt7fz4IcZa04xbH35J2pDjYMB57yjQ0Tb9FLPSd2fmHM9mkONJcz1uafDxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gy0HcjD9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gy0HcjD9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e13bf404so213845ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762965435; x=1763570235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/sJC5qxtjPyc2gXXFUC3VvLNx6ICKkpfTbgbKKn72A=;
        b=Gy0HcjD9xzLxRB6gTfzDQSHTVAPh1lejuspSshuhoKQ7tCG5PsTilTyPXomt2LxJxP
         DurhHnEmUpp+osNvu8aIWLElda2zoUHwUcPNDntuj0ryQV9S4v4pzCH/fOcaIwQpXMaH
         79ZnINvJxTlpvHwoUkRnHEj6hjrMXkpmCchyvTkdAZpMSafcP6OrvsVpvL057T81rKTa
         zf3F3ASRxkRkYqyZ9/hoSL2trTSHp1GfMtLnV9XfPnY9Y1J0panit4D400lO3tsSpD0L
         bEz1cy7r3zfmE+SRFlZy2SryrLZoJ9BC841rSuHI5RMh5+BzSLt3qyXQhUWrnVWSfwtG
         9dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965435; x=1763570235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/sJC5qxtjPyc2gXXFUC3VvLNx6ICKkpfTbgbKKn72A=;
        b=xJdp77oZ7cwGAn7YbP1qN0MVGi3LvWgqrtyYPFyeMyHw83sFrfoRRWNMEQN6jI2ozE
         kYoVDvXWd8bP2JaHrDL8w60et/dgRJA9nzYZKmKBHJuVa1v79iFy4Qj6jf9/Iux37mt1
         vXAhopmgbIOeTAKPN/iawE6SX0DQcekl2ZyspdLtWlYtZxRfNv521SIAPt/zzpyjelIa
         7V8Bz/ttuq0sj5Z431cvoghndEUwaNJijDzmRxXmrpCj6zphh7j5gGiYznln9uznz8Y9
         FcF740YzqYTJzlOxIJ1hBvyBsMGcD6+rVSrD6r03Vw2G/mS/mHZhag4VWyie6FFoEqDb
         4lXw==
X-Forwarded-Encrypted: i=1; AJvYcCU83lhdo5qKaY81rXmKgzW9qn4DOyKj6eGQi7Z8X30Ac0kOdk49TXjUTUSqrmh/3eQWeKImgKPrraXxvAMFKriK@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfcoPkrcACGNuxPojVrNzqtEFufDubMHUQN0wsmmB/f3+krQa
	8UWKXCh8whF3P3KniUcS7CWJ6vSWWGrUzUVTN6MBoOOx6saX9JknDCiBI7pf+vAgeRHdNREj2NB
	dY2YGGXJXnxIFEODpN2qgYFkaKGkrF+djExC/8WBS
X-Gm-Gg: ASbGncvLXpFS1KLIebyP216/C2KD1xJpm+65Of0Sn79cXX31P/ugbJgqekf2lbz9GKd
	oI4GOWMPWt6jFQ8bFw05DgNsr+/jsNnDvxmUIpXT1Kfz+KEc6qC2V8KoKOLmf3EdcRn4XJyMjXs
	0Zl6rP0Mb41NKVGYNdDlqWXNtD/PLYHGstkAJFpdOo0JiyDqBPoLIc2Z/yRVWREYQCp88dL8Lj/
	F+pQ9uS6Z3LXjd1y2DFrhtZZF8NajfepS0d3TUjRWXKYa6K6aCs2qyljetHM/6//qCIPxc9l2Cr
	sYIUqccgjj4e+Nwrh6Mwe45kpbSjtxqfCN2d
X-Google-Smtp-Source: AGHT+IHhxquoYta/ewaaJ8F5uIvrcKenfoA2sfnZPnx+zkuqIuP54G1ynPHjcOnwZAelhvq2e32oVGJKqjxoueEgunI=
X-Received: by 2002:a17:902:dace:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-2984f836f94mr5058645ad.6.1762965434663; Wed, 12 Nov 2025
 08:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930160923.13728-1-jbrnak@redhat.com> <20250930160923.13728-6-jbrnak@redhat.com>
 <CAP-5=fUJZEoAbNu+ZzjgshHRbq94dLn6-KPdzC=i9i350K=4dw@mail.gmail.com> <aRR788vna0u-CEUU@jbrnak-thinkpadx1carbongen9.tpbc.csb>
In-Reply-To: <aRR788vna0u-CEUU@jbrnak-thinkpadx1carbongen9.tpbc.csb>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 08:37:03 -0800
X-Gm-Features: AWmQ_bnLmYqiIkLsdps-P-2RoGwLA75CBMbitXrKXatjTGST23oU1Vt17CGid5E
Message-ID: <CAP-5=fWvSVswOwxjQmiDsSmvkD0HdVwPgXWib4zg=SQFyRfTUA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] perf test: Introduce storing logs for shell tests
To: Jakub Brnak <jbrnak@redhat.com>
Cc: namhyung@kernel.org, acme@kernel.org, acme@redhat.com, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 4:44=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
te:
>
> On Tue, Sep 30, 2025 at 12:00:19PM -0700, Ian Rogers wrote:
> > On Tue, Sep 30, 2025 at 9:09=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com>=
 wrote:
> > >
> > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > >
> > > Create temporary directories for storing log files for shell tests
> > > that could help while debugging. The log files are necessary for
> > > perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOG=
S
> > > is set keep the logs, else delete them.
> >
> > I think log files for tests are a good idea. We run tests in parallel
> > but read the stdout/stderr sequentially. For a failing test we may
> > fail to read stdout/stderr in some situations as the process has long
> > since died. Rather than add log files specifically for shell tests
> > perhaps update start_test to pass the file descriptors to the child
> > test processes and then clean up in finish_test?
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/builtin-test.c?h=3Dperf-tools-next#n528
> >
> > Thanks,
> > Ian
>
> Hi Ian,
>
> Thanks for the feedback.
>
> You've raised a good point about capturing stdout/stderr for parallel run=
s,
> but this patch is solving a different problem.
>
> The logs we're storing here are test-generated data artifacts, not the
> stdout/stderr of the test process itself.
>
> Our patch provides a $PERFSUITE_RUN_DIR environment variable so that comm=
ands inside the shell script (e.g., perf record)
> have a known directory to save these files for debugging.

Sgtm. Is there anyway this can be a common feature with kunit testing?
It'd be nice to have a similar strategy in the perf tests and kunit,
for consistency across the code base.

Thanks,
Ian

> Thanks,
> Jakub
>
