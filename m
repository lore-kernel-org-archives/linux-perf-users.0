Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D342253E4
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916538; cv=none; b=HxdrhIie6JmQ2a8Xk79HKzMaiTg4DMsvD/xRjUx9Un0HPYIiv680ehIIJlAwRqme38+XVPY0BE4jlH06xUadNjmy4ZS6f8SQwQcDDaethTUd79nri5QQRkNDBr33Wu8Ef8NsehOUxSznpyY2hSolGIsPHzUbsIPNTUcGEH49JCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916538; c=relaxed/simple;
	bh=jzzqZ546crWmK++P+udZsg7eabyiw9jTTHglrNg5MOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkuvPx4zLX29wBnVFSGAThYdOfi8yY3hMJZTy712AV+SYa7frLxbMzi3l5mFYnTS0PVGoqtF53Ch6Ko4jJpEbW5BDIWFWQY7OUqO5BVuYBT2pEV3nCWR42rhA1vdV5T+Zp7G01T0h41OlTNSJLFPCH/sH3iq2wcMJSox416dD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ipy+vkrm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ipy+vkrm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d67abd215so41945ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758916536; x=1759521336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce6cCZkbpl15l1rm7dHqm72kP6CP/ta9NxvrV+RcQnc=;
        b=Ipy+vkrmLgA++tetFRY5O728huxZfePc6YvixlCFltuzR1AeZ6JOqtHzp1k/6gyhCf
         mqfqMKalC3p6mUsyUtqhDBruvCM1Mz8xniq+9bI8wqLaaJ1X6Eu1HjZ/LBZh95fv1TfV
         EynSsJkrRcqOY1NRZPCQ7WkENCF9CNxNIBFwO1lwSQa/OiNZpN+4XS5LDRvqJB8VX+1J
         QdqZ+EGVnVZ6TFoko6csxIVXQ0pPp7rUpunXWdx+4iJa9LlJAGhY8bG6biK8MQ88k915
         G4fmNzwgQueyLvTLIx3lW/V1kl+tiGXNHCL47m6GgdgD31DAhWJZgbwtqyMgEy1y282s
         voqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916536; x=1759521336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ce6cCZkbpl15l1rm7dHqm72kP6CP/ta9NxvrV+RcQnc=;
        b=RTiBpMqrDVPGQoeqnfJ/upILOeisntwAPU3bDnlTgKzB8RfN08qlQcUBK1Jwk1yXlG
         xTbqxlh6+QlgLaaODP7hcYZgzxlFjQ24d2JaruPBvhlw+IQTUdha9x1yjtkSv+qdogNL
         0ivjhymY5ALsr0uHmOl3D1zitf9RB/T45s7OMcR1V8TKt3X3/lz85ix5ozbYPDhk8T10
         vJ8Vep9UZ2gUbo6N1aFSl3oWzBvNY+ga30llufd5Lu0bBJnuaMdnil75BVATesSYV4pm
         FZOnL6gmozN1FX961ZGxms520Tu8zTcNZcJ+sUtbnkKjG4VYosldDu06kHZraFrZBCtN
         u0QA==
X-Forwarded-Encrypted: i=1; AJvYcCUsNi27w+07d3LpaR41q6DKy0l0+4d5I/x6MXmOxbsfR0Fayh5wSeRDx7PhESY31v1aPkK+0js88JkXB06nL148@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+EjQDDjdyUUmErDUe8LAzi31cMQxQSB6SqzpI3kNBpkTxOD1U
	afKjQb/OXeaXROPHUw5SbiQqQzt+QcNCZ/56hk7Bp/tAKZa7m+uWF7+T48zS0rWPbwsF/d4uNEg
	Wnk0+C0yf8KcQZiFHh04LLn+nHEDgTpMoM08a3/hA
X-Gm-Gg: ASbGncsk51do7sBCuN9pPcP+eZTUU6Z//NHwCQbMRcA+f7j/g66OPHJKuBxg8/aM4or
	DJrHRRjUcuoPSiBwEdWHZIcVMb1W3bJAAvuAwAQN4bRLe0959NckWJFspdlpv5TagS+RuHO2IbD
	KvfTmsZZTM/2drCG/mjDMOUIK6+lnoFmHwj0Faqg+ktX1MdbsZBw12Unih1z/z5mAiCPlgBqdKB
	aMlDRvWUKFhu6Q=
X-Google-Smtp-Source: AGHT+IHqqaGO4A5X9tXv85+UThFsp1WyFXo7c2mTuxzc9F1lez4Kga38TLhbDDPTA/ceaGQ36UUf+n7Q7lkcG8uFELM=
X-Received: by 2002:a17:903:1c8:b0:248:dce7:40e1 with SMTP id
 d9443c01a7336-2815ea640f2mr1362255ad.9.1758916536107; Fri, 26 Sep 2025
 12:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603181634.1362626-1-ctshao@google.com> <CAP-5=fVjA9630Com3xNWvgDHbwmsswQ8GEbqvnZ5QCtARQJuvQ@mail.gmail.com>
 <CAP-5=fXY68WRiz3PVD19GBPg4t+_-f3pyLCwhdCDZHmQ=Aag3Q@mail.gmail.com> <CAP-5=fU=5Be2mUL0Ptw1hLG9NuvS9dT1DN83nA2Q9kTskqmh-w@mail.gmail.com>
In-Reply-To: <CAP-5=fU=5Be2mUL0Ptw1hLG9NuvS9dT1DN83nA2Q9kTskqmh-w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Sep 2025 12:55:24 -0700
X-Gm-Features: AS18NWBMCeK2hF4YpKgqiPP4OGoXmAWjL0HfQZEdBABxTX6Ao2wg8LWlNzw0V-M
Message-ID: <CAP-5=fVFsb0L+upWwq94QG_zZ5t1Sr-Q+h5it0=iDBvZGs+t7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf: Reveal PMU type in fdinfo
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:42=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Jul 9, 2025 at 8:25=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Tue, Jun 24, 2025 at 8:06=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Tue, Jun 3, 2025 at 11:16=E2=80=AFAM Chun-Tse Shao <ctshao@google.=
com> wrote:
> > > >
> > > > It gives useful info on knowing which PMUs are reserved by this pro=
cess.
> > > > Also add config which would be useful.
> > > > Testing cycles:
> > > >
> > > >   $ ./perf stat -e cycles &
> > > >   $ cat /proc/`pidof perf`/fdinfo/3
> > > >   pos:    0
> > > >   flags:  02000002
> > > >   mnt_id: 16
> > > >   ino:    3081
> > > >   perf_event_attr.type:   0
> > > >   perf_event_attr.config: 0
> > > >
> > > > Testing L1-dcache-load-misses:
> > > >
> > > >   $ ./perf stat -e L1-dcache-load-misses &
> > > >   $ cat /proc/`pidof perf`/fdinfo/3
> > > >   pos:    0
> > > >   flags:  02000002
> > > >   mnt_id: 16
> > > >   ino:    1072
> > > >   perf_event_attr.type:   3
> > > >   perf_event_attr.config: 65536
> > > >
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > >
> > > Ping.
> > >
> > > Thanks,
> > > Ian
> >
> > Hi Peter and Ingo,
> >
> > This small kernel change enables being able to better diagnose which
> > processes are using perf events for what. In the series it is used in
> > perf to blame EBUSY for PMUs like intel-pt on which processes are
> > using that PMU.
> > Are there issues that need resolving before the patch can be
> > considered for inclusion?
> >
> > The original patch was sent in October 2024:
> > https://lore.kernel.org/lkml/20241031223948.4179222-2-ctshao@google.com=
/
>
> Ping. We're nearly up to a 1 year anniversary on this 10 line change.

Ping.

Thanks,
Ian
