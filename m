Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536017B504;
	Tue, 25 Jun 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338783; cv=none; b=MaR9JCCfF+KqOjunh4DVHEev1wRcM2/q8XM5xmyZP4zSF4R5O0K2AwnmbzJoP1cWwGGWuDcxyBkCaA9erBOFUOPTphWuwXAzcUiIn+vfbnxFkL2HphYZSna03xlXqv3XEuB/A+84rsTGOcK/fC3iMX+M5t/lkg1QWuw08aukkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338783; c=relaxed/simple;
	bh=e8IHt3dEOYuVV4aLgtoUAfKr3hSwY2xoWIJ2s7A9plo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdOqFLMLtem9g1MDOjbQlF0PfL17dXEHtboA60Rl3a3hIZdm8zhKS9QwC29kJuzAvuQAqlROIH6gLsoS36LqDpOltEpm9xNIJLC/vbjmQ9KltQgLqQzWd0SDkw5bDMie9m8S8+QlZvv+j9d/xtVvYBrkZoEV+6DuyWJJbfoAXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7178727da84so2858839a12.0;
        Tue, 25 Jun 2024 11:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719338781; x=1719943581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYRoSYBMyUfFW3qOTYX0mms4VCXUWC1J1GTwb+UHwcs=;
        b=RUH5aEewNsayYwJVkfqQ/QzZqSGRgheWyxQwR2B9ztD+Y7Br1q/5DMOxYYTa90B5xH
         oY+NwGaJreggP4dygaGVsQj1rT2SFiecDZHHwQXk3sMDMwFdIo1ySZCWnxLjLTK8AX17
         g1gDxKsTSY/1VvbJjClnssxZlQKKmISWUpngghrsjPnBiWe3a/2axJrm2RGOIWMQoLMu
         4X39AvctWI9aSfQHB3iyNFkqbP3AFLNeJ9MH+xlExV1uMdUK8CNLOPt+ZVAgF5pHRo9e
         Gvg6YKl1mBJv9sHkLLO71GqoaB/OlzQm5J1ZZ85kfegW0m572hoiFQsu+3s9DoHBx47h
         SDiA==
X-Forwarded-Encrypted: i=1; AJvYcCVQWt2GNJxmOAxfcROUnpSiGiqDiVTe0sW3V88OIP0DYaDPR3GPjzAD6jP3nbCZ5DyblFwHEbiqjP7RgVt2f2oYNDaF2/rkFDdj+f2w5PDXle74CbtBZm+vn2EviVoo5WaHwlDe1zCJSXrFNMsrlg==
X-Gm-Message-State: AOJu0YwKFDVC0KdX6sxZLjfhhpDZa4dhPe8kG21U5bbWhwqpSuxnwaKE
	sCPNdhTJ+a/hZ207QjLXyIgSnXltf40NtOcAD/t+bw1TpUEkPitLf1V60riEtHOXpU2Qb8XeC1a
	WTu7ex7kHzo6keGuM0RfRaN58mSc=
X-Google-Smtp-Source: AGHT+IEnjRNws1Iz7snCymBOJS0N0HgLeEPogsPgzYspdRnnmFsVh0OjNbMFg0qf1poVQ28TQR5WihNyX3Us7XRjSXE=
X-Received: by 2002:a17:90b:3616:b0:2c8:3f5:28ae with SMTP id
 98e67ed59e1d1-2c8504c7bdbmr7030880a91.4.1719338781055; Tue, 25 Jun 2024
 11:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623064850.83720-1-atrajeev@linux.vnet.ibm.com>
 <20240623064850.83720-2-atrajeev@linux.vnet.ibm.com> <536ccca7-278c-4d50-9c24-bf4409cd75dc@intel.com>
In-Reply-To: <536ccca7-278c-4d50-9c24-bf4409cd75dc@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 25 Jun 2024 11:06:10 -0700
Message-ID: <CAM9d7chzgJXNDObXW2KVD7JALOh6C5ZbHw7cjuvfbaSNCtqqEw@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] tools/perf: Use is_perf_pid_map_name helper
 function to check dso's of pattern /tmp/perf-%d.map
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org, jolsa@kernel.org, 
	irogers@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 5:03=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 23/06/24 09:48, Athira Rajeev wrote:
> > commit 80d496be89ed ("perf report: Add support for profiling JIT
> > generated code") added support for profiling JIT generated code.
> > This patch handles dso's of form "/tmp/perf-$PID.map".
> >
> > Some of the references doesn't check exactly for same pattern.
> > some uses "if (!strncmp(dso_name, "/tmp/perf-", 10))". Fix
> > this by using helper function perf_pid_map_tid and
> > is_perf_pid_map_name which looks for proper pattern of
> > form: "/tmp/perf-$PID.map" for these checks.
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>
> Add a Fixes tag, then
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, but I'm not sure which commit I can add the Fixes tag because
the original commit 80d496be89ed is too old and I'm sure we added a
lot of changes after that.

Namhyung


>
> > ---
> >  tools/perf/util/dsos.c    | 2 +-
> >  tools/perf/util/srcline.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> > index ab3d0c01dd63..846828ea1f00 100644
> > --- a/tools/perf/util/dsos.c
> > +++ b/tools/perf/util/dsos.c
> > @@ -275,7 +275,7 @@ static void dso__set_basename(struct dso *dso)
> >       char *base, *lname;
> >       int tid;
> >
> > -     if (sscanf(dso__long_name(dso), "/tmp/perf-%d.map", &tid) =3D=3D =
1) {
> > +     if (perf_pid_map_tid(dso__long_name(dso), &tid)) {
> >               if (asprintf(&base, "[JIT] tid %d", tid) < 0)
> >                       return;
> >       } else {
> > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > index 9d670d8c1c08..51eb78993fe2 100644
> > --- a/tools/perf/util/srcline.c
> > +++ b/tools/perf/util/srcline.c
> > @@ -39,7 +39,7 @@ static const char *srcline_dso_name(struct dso *dso)
> >       if (dso_name[0] =3D=3D '[')
> >               return NULL;
> >
> > -     if (!strncmp(dso_name, "/tmp/perf-", 10))
> > +     if (is_perf_pid_map_name(dso_name))
> >               return NULL;
> >
> >       return dso_name;
>
