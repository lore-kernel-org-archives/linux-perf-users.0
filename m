Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651D16C86C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714126; cv=none; b=donDhgKUtq6Mr5WrQWtnMRVRQoN3767Ff7yR0et/dA6TyVTLbCp4oMIOf0EGno8Kikz1N1HemdGDOullipu7/jlC1G2Hi/Yd/D3ptToLBxIn2eKWrEA0acICgut+UM63hWMiA5CD7hFlYEnA9nJR6bD9WMmZh1+wjKfSS5bUUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714126; c=relaxed/simple;
	bh=kY5IJZ4cikqhqf40Y/iuj0LM+o1ikDZwH7ZJwpsRXmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjXBj5xlL3Y3tHFik6ETTTOYWqXfN5Rw5tayMifDFGYRvosNoYDvzXfN6/fEA/Y+mJjq0jn5b+FsTchDEjzD03oGjdFqW3QXuMRoxybhwGcH4S22sNWxQuM9LAPXX/dlOK35dYCpRQ3K6enaBAAVZm6YLwdW4TbvQ/nfX7b3aSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykqYlNVg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykqYlNVg"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb67f59805so156965ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720714123; x=1721318923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQSa5gKT+eKn4P0zkPKjQyLYQdgXXMN3YnW0vi5qP9U=;
        b=ykqYlNVgh5hRiRvbxTMA9edPmc4NoPIFyKaani6+hBw2HiHxYmjmtxmi4hiIanV/MX
         ZTIpqJrjbjCnv04zsCx2kXa8T8r0t1ywsoPO7Uowj8kuwfpNdjkwel3TAS0rWm+yRXRO
         OdhgbAhIM7tj24RsJLq3PIPRCDoXmUUxD0AHj8BQEuMJ6l7f/epAsl9SmrAJGhTOqwdp
         fkrW5ir4FYFgIgIbXUzBy3y32AHbY5NbYwfl2Clo+MiK9v0LTiPA6lx5rcTvgOO9jzYL
         bXpUZtWPtzbrrQHbfM3AUr1b6CTjWlEpXnTKUUnVvdGTP799IiWHhJ9yVw0512cXlT+D
         ZUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714123; x=1721318923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQSa5gKT+eKn4P0zkPKjQyLYQdgXXMN3YnW0vi5qP9U=;
        b=TBCT+JgLY7qG2slNZr67IXS4j3MsrOMc1/u1WBPfspDkbMjYhYMsa9RFaRxdYsskTL
         dqxVC5Mlyb6mdPsC1OEHB5mBYJImV3DySeHEzbqAaDm7mUfmocJbPse5SLI4HubV1B8Y
         YFOfotsIFE5MIlBb/YJnm7m0maDsOVMwE4o34YkoSt+sfMgyuK0uDjxWSA9NvFtjylMc
         6MsloTcfoI5WJSZxx3wRDrpcSt0Xvl0u7QsR1nfakqECPVGPbAoY5tE4tdHeWQJ8rSjQ
         dX0eeZpKQ/NunliQAHWyIeK2eV3XDcvinuV1SkwBCla5dcB8KNlkKiM3H1csNAnUuXLZ
         Fs8A==
X-Forwarded-Encrypted: i=1; AJvYcCULUuFpbZQy/namNd46PL09SF6I+Aym/0tX29IYfrJWJ7dKtnHDecLeNkU8/j3FBUin/7RXrpFpY8p5XcRCrGyZb2jig3fHAmAe6S1kPcBq9w==
X-Gm-Message-State: AOJu0YzFnwiryKCDR+tlts0smHI/M1Jh0qM6xp3iuWzxhcXThEnmt9i6
	0iT9BrSGZvBUd1q6+G+FlzFNB5iqAT/raVetZF6PZJYoX1dkBcwEFCwQH7TYSh2953+MpseeCis
	l9NgeXY4oH2hRMNjlmm8zSWAZ0vc+D+Q/lft5
X-Google-Smtp-Source: AGHT+IElvTnqaWO9R7urpZJutwvE+MMjdeEGJVTWB+RvH5lxKcz23FQGzGtnmWxXLdNYPtGOuFpCS6RTfBslR59gJ8I=
X-Received: by 2002:a17:902:f28c:b0:1fa:9627:d363 with SMTP id
 d9443c01a7336-1fbdec43278mr2668445ad.11.1720714123218; Thu, 11 Jul 2024
 09:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com> <20240629045350.285243-2-irogers@google.com>
 <d55916c7-a771-4fae-8bc8-595b7b1e9861@intel.com> <b4d28088-3de5-43a5-a4b6-12d3a29244b7@intel.com>
In-Reply-To: <b4d28088-3de5-43a5-a4b6-12d3a29244b7@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 09:08:31 -0700
Message-ID: <CAP-5=fX+VG3HsAPb=3DzEp2bUyAUvHk7f1zAhq3r=FKYaJPW6Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/28] perf auxtrace: Remove dummy tools
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:46=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 11/07/24 09:43, Adrian Hunter wrote:
> > On 29/06/24 07:53, Ian Rogers wrote:
> >> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >> index 0ec92d47373c..44db5b49128f 100644
> >> --- a/tools/perf/util/session.c
> >> +++ b/tools/perf/util/session.c
> >> @@ -1764,6 +1764,36 @@ int perf_session__deliver_synth_event(struct pe=
rf_session *session,
> >>      return machines__deliver_event(&session->machines, evlist, event,=
 sample, tool, 0, NULL);
> >>  }
> >>
> >> +int perf_session__deliver_synth_attr_event(struct perf_session *sessi=
on,
> >> +                                       const struct perf_event_attr *=
attr,
> >> +                                       u64 id)
> >> +{
> >> +    union {
> >> +            struct {
> >> +                    struct perf_record_header_attr attr;
> >> +                    u64 ids[1];
> >> +            } attr_id;
> >> +            union perf_event ev;
> >> +    } ev =3D {
> >> +            .attr_id =3D {
> >> +                    .attr =3D {
> >> +                            .header =3D {
> >> +                                    .type =3D PERF_RECORD_HEADER_ATTR=
,
> >> +                                    .size =3D PERF_ALIGN(sizeof(struc=
t perf_event_attr),
> >> +                                                       sizeof(u64))
> >> +                                        + sizeof(struct perf_event_he=
ader)
> >> +                                        + sizeof(u64),
> >> +                            },
> >> +                    },
> >> +                    .ids =3D { id, }
> >> +            },
> >
> > Nested definitions are not needed.  It can just be:
> >
> >               .attr_id.attr.header.type =3D PERF_RECORD_HEADER_ATTR,
> >               .attr_id.attr.header.size =3D sizeof(ev.attr_id),
> >               .attr_id.ids[0] =3D id,
> >
> >> +    };
> >> +
> >> +    memcpy(&ev.attr_id.attr.attr, attr, min((u32)sizeof(struct perf_e=
vent_attr), attr->size));
> >
> > It is not unreasonable to validate attr->size, but neither slicing
> > nor padding will work.  Better to just return an error:
> >
> >       if (attr->size !=3D sizeof(ev.attr_id.attr))
>
> Or rather
>
>         if (attr->size !=3D sizeof(ev.attr_id.attr.attr))

Thanks, I'll change this in v4. The struct perf_event_attr are
internal to the tool, so it shouldn't be possible for the size to
deviate.

Ian

> >               return -EINVAL;
> >
> > Then:
> >
> >       ev.attr_id.attr.attr =3D *attr;
> >
> >
> >> +    ev.attr_id.attr.attr.size =3D sizeof(struct perf_event_attr);
> >> +    return perf_session__deliver_synth_event(session, &ev.ev, NULL);
> >> +}
> >> +
>
