Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C428E56C
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455378; cv=none; b=cB4Wus6OQ1zC5H+zCIMLE+F4m/mZoMzkWA5v904cQKqvgbS1ISACNtqPl8zn1T9Jstn01EizLdJF2jbq7seDqJp+H3QeqxAXLu0B4yDk6aofIOYGWw1bIJ/tHVy3wGdaDAT09FHq+RRPdfw7/9JXStPEMZJ140URRkEcqsrNvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455378; c=relaxed/simple;
	bh=m4h+499vGYh+iYxijfsahqG0vZFEdsOg94f6d1R6aEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+YaaVble0dnx2q/leZaU78w/0xdPULxJIbaUtegtRMNp3uvpHAx1XjCfzj9OuuWLvC74/Ff7j5Ig8QnH5OIo8fuHT1EHszTRQ6BluCOpz8aAfirM4ZyTuG65gajTchcyD97/n7o5rVAzXuUBDeWlkz6On6InVjyKRx/xCQTsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJU8AekB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJU8AekB"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3dd745f8839so15115ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748455375; x=1749060175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZwa7gPGfpqcfVjfPBpJgP+00qIL0eiwvLWJGKbrQm4=;
        b=RJU8AekBhrmHemkCVXQxJLq99BM0QXB8tDeu3nc17weJOaOqdOQjB35orkt665CESb
         hW3X3WCPAfIFp1bFqDmuv7Gz8YzyqeG0hq09OCOHygeY75YPw/XkaSWiIOHApcvBxQs6
         CV01bTp75CdPxCZzmkCDJCSkrmXlDb3bko7ECOPhoE4FxpyECJiuftqfDgI3JN3+IzE0
         UfxZiShaUJTybhIstXVIYFYuwn0aPFYCjlTzH/yOKBDgqq0jxSoh2asHoHlxvNoPwX3K
         PdgmMl3DpSf090APJ16AplhKgtKZZ3MPKbzPZZ7KHXXIdt86otE/HKZnNkBHNqA3cQSw
         9yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748455375; x=1749060175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZwa7gPGfpqcfVjfPBpJgP+00qIL0eiwvLWJGKbrQm4=;
        b=Bgp0vYPtRs1MRhqkIeF29aqSVNb6wRiwhwhc7rYKmY3oXbmJU8FB4hnZb+h2XhwWFg
         CqgBzBF4IkaYTuvYXdLt5ultGBFMqusYBNkU2NxtjjfOK2Os8f0CsOkWVM8O12rgoODH
         boOS3tGiCuGYK9M2sWbR97H1xCKyhAMIYStbjN23s1ftWLPpeCwiobm4O/qcKkifQXjK
         Ecu8RvY/ABqt4mGKIBAiyJ+9GLnFW84QJIm5B62NAR45fdb1+cU3aE7hC37h2n4sfqBR
         w/JLuJD2mnVRiCiHYtFFDKYFbmdXaXT12HFq/0NYdOM76XUvhV31+nuzJfVTfNTSH+lx
         T1+w==
X-Forwarded-Encrypted: i=1; AJvYcCWMktIm9caKUtiPXCGY05kHWnu08IDEZEPAk+fft8F6xMhlhfW/qyXWSGwnGPcoaXniiTZwtkKoWRqQWBhyRmKE@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5E0rff6m6M+bNQ0wsoL1ODinXqaqUUv66v17uDkgQ8JxKCEg
	fmC97HYYNlW9GbZR50G76542br2eodtB4A1saoGA3mrkXXaLWwqWPY8djOK8Zf/5z2j5s5G23v8
	5cpRJlO1MSLk3mH1qVCK0Zmh/PSrHfPtEyQRvAEVN
X-Gm-Gg: ASbGncvHnKcfx0lf1ipquKRnrld75aQSdTt/YU6IiDsNg8UJ4ctBKVcnTw0RlVXkZKv
	QfudTtbM3qVNqrMWI/dkGVcmTOkapGhibom3kbzd2z3rN3sdefJxsfXjemVDZ60lXHk32c+pXW8
	0SuwjDpxeIYT/L62x4xLXMlGjTLB2pZCzfjpxVTb4iruw87ZbBkN1KTeMNtzLewAtu25YLpYhb
X-Google-Smtp-Source: AGHT+IHXVQtYnSEhg9S6Ul4Dw2KI+kuRxxZduzNu/XhB4JQvv3y5qplcavKDXgnjzk+dDGCqQiJHpne8h1TEyjl/eck=
X-Received: by 2002:a05:6e02:1185:b0:3dc:7e19:fcc4 with SMTP id
 e9e14a558f8ab-3dd91bb281bmr133785ab.8.1748455375252; Wed, 28 May 2025
 11:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528032637.198960-1-irogers@google.com> <20250528032637.198960-5-irogers@google.com>
 <aDdNk1IOqtyM44AX@google.com>
In-Reply-To: <aDdNk1IOqtyM44AX@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 May 2025 11:02:44 -0700
X-Gm-Features: AX0GCFvrd4KaGrUHxBiOU6BspUaFU5sD2jWIH0NE1i9_H57R3df7_M2FSm5zBYI
Message-ID: <CAP-5=fUmrnOUOBWcypD=Q7bCSQ3HTnicRXhr8nmSRqcbZv7Mmw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] perf intel-tpebs: Avoid race when evlist is being deleted
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 10:53=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Tue, May 27, 2025 at 08:26:34PM -0700, Ian Rogers wrote:
> > Reading through the evsel->evlist may seg fault if a sample arrives
> > when the evlist is being deleted. Detect this case and ignore samples
> > arriving when the evlist is being deleted.
> >
> > Fixes: bcfab08db7fb ("perf intel-tpebs: Filter non-workload samples")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/intel-tpebs.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpeb=
s.c
> > index 4ad4bc118ea5..3b92ebf5c112 100644
> > --- a/tools/perf/util/intel-tpebs.c
> > +++ b/tools/perf/util/intel-tpebs.c
> > @@ -162,9 +162,17 @@ static bool is_child_pid(pid_t parent, pid_t child=
)
> >
> >  static bool should_ignore_sample(const struct perf_sample *sample, con=
st struct tpebs_retire_lat *t)
> >  {
> > -     pid_t workload_pid =3D t->evsel->evlist->workload.pid;
> > -     pid_t sample_pid =3D sample->pid;
> > +     pid_t workload_pid, sample_pid =3D sample->pid;
> >
> > +     /*
> > +      * During evlist__purge the evlist will be removed prior to the
> > +      * evsel__exit calling evsel__tpebs_close and taking the
> > +      * tpebs_mtx. Avoid a segfault by ignoring samples in this case.
> > +      */
> > +     if (t->evsel->evlist =3D=3D NULL)
> > +             return true;
> > +
> > +     workload_pid =3D t->evsel->evlist->workload.pid;
>
> I'm curious if there's a chance of TOCTOU race.  It'd certainly help
> the segfault but would this code prevent it completely?

Good point. I think the race is already small as it doesn't happen
without sanitizers for me.
Thinking about the evlist problem. When a destructor (evlist__delete)
it is generally assumed the code is being single threaded and in C++
clang's -Wthread-safety will ignore destructors for this reason
(annoying imo as it hides bugs). I don't see a good way to solve that
for the evlist and evsel for the TPEBS case without using reference
counting. Adding reference counts to evlist and evsel would be do-able
as we could use reference count checking, but it would be a large and
invasive change. Wdyt?

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >       if (workload_pid < 0 || workload_pid =3D=3D sample_pid)
> >               return false;
> >
> > --
> > 2.49.0.1238.gf8c92423fb-goog
> >
