Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA615CD43
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006716; cv=none; b=cmVO4m5WWvxf+7vCqonnt4cKc2wvwpVw8/0M3RcCha3a7HpHm4uosIezuiXVUijwgyGL4r5MX1lR0aLf8CN207GXTfDNach61VPIfbyamjX+DpBbd71xDFJaf6p9I/cMblTM+lozNdR7RKMV3/5vB1AlKlOBLJxyAi46MzJcsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006716; c=relaxed/simple;
	bh=yH3iRUsoLLDhsHabHWKD2oqxK4r37P5N6+ce1wac2l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbM5DvQ2hsBs3zlyuMbsWdqKM/sga6LlSgooudNnBW3ctMuJ9JjQvAOaHjdAEe3wEUPU+68/pjdm2lE5yf9QOBqtCCph4BDJEice+q8bzB/gLrhiegtjF3SkkU/x40uUVq0nK+y+0rg4/1O4FhQL4wkA4Tn/1q3dsBYlA3588Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=26nGEyZR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="26nGEyZR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ee5f3123d8so17795ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717006714; x=1717611514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTkoaN82x0Ke+cDptM/CTkf19y5d0qlB64lrfqCGsL0=;
        b=26nGEyZRSeklHrrkCZ1TqLDqbB2AtS0pvXo8gVGKQELc865XNb7yvDxJ73plMzSoXa
         0hyOPBqtw8YSd+Pz4Ftmo+wiUYNeRC9w40hz4ZyKuGq8uOrpKLloAbdNNI+jbhjJQxfc
         2CPQlD6u3SyF3dxkzJNSMEpLMdspFRhyV0pZosj7pykiG7kJPtzO3Cirg0kXGLiMDYpy
         EZukUUzxwgUqIFI/ZSGIb0cb5GfDGo2DEWzwu1DjgcUp9wFwVs37kHtCg4tVgk3tPm7j
         r5/zBFokLyobJH+dZDhenID0VVVrswg4hsbCp+j88DkKqHJIayZ6zFaV+9Ep3tZvv8KS
         duQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717006714; x=1717611514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTkoaN82x0Ke+cDptM/CTkf19y5d0qlB64lrfqCGsL0=;
        b=PCxQ4tUx928UUjM1oIU4naEMqiVI+SbjmTE3wvtn2amJWjbhgzV0gaQde2uuENm+30
         U/2S4u/2cBdHFy7tW8tr/coP8DZFcH8NYR2lNKjl5zaNI3hCOyLnX/lVeT4q1z9ymshm
         IACOlqcZbGNc4oPL5FktBSpSmfKPFnggP10jBVELpLhih4ScqNigWwMIpk+K8hQ3U3mA
         qR943gFJd9xwTZk2zGla6y8uRcXsEjZbLYkQOKoINL9g3IIqn2tYCKh+LS8Ax3Wgj+ri
         xutgK8qnQHkDR8qzoksPDNSynlBd2MgVOs3RxztPILlpNU6zJb5lcmtCNAWqa43v/VQX
         iR2A==
X-Forwarded-Encrypted: i=1; AJvYcCW1Rrnca5jtKRtHYcJO44lqVSauOjHPlQomT6M/QErveRHnM/QqJROr8CddAsXI2W4ALuZSbpKp2pqOiDcW7FvX/0rMxJTJ3ZvnnI1xZLiV5w==
X-Gm-Message-State: AOJu0YwNewbPKr0ej/muFq+BMk/fEv3VXn0qZP6eu5J/XUCp9ptM6fR7
	DJrl54Lxosj9cucCHbxe28YiH/awbqHCx7Fv79tq8IpWWerqTqjQjNjmoE29KijK7mZuZ1OTcJ5
	/Lm66nmZ9JMu9fX50yt1f5GR3UsG741tw1KbI
X-Google-Smtp-Source: AGHT+IE6BQ6LYXkonQH6/sSre+pM9kJG/33V3I65mfoATs2Q1e/oCJW33dBKIkAu2X352V6JQmZfiL+EH4qORmDI4SQ=
X-Received: by 2002:a17:902:e846:b0:1f3:3ede:9b0 with SMTP id
 d9443c01a7336-1f6170de762mr217315ad.10.1717006713709; Wed, 29 May 2024
 11:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com> <20240510053705.2462258-4-irogers@google.com>
 <35d6875b-9a28-4953-a187-b6659880ac66@arm.com> <CAP-5=fUbZRkoRN__ZE3YmzhM5HqQABZ7jHymgshZGDzT0LgqOg@mail.gmail.com>
In-Reply-To: <CAP-5=fUbZRkoRN__ZE3YmzhM5HqQABZ7jHymgshZGDzT0LgqOg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 May 2024 11:18:16 -0700
Message-ID: <CAP-5=fXxsFp9tynNhkYqrgCMtP4F-XaADz+06hTWHHFVpVhfDg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf stat: Remove evlist__add_default_attrs use strings
To: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:39=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, May 29, 2024 at 8:39=E2=80=AFAM James Clark <james.clark@arm.com>=
 wrote:
> >
> >
> >
> > On 10/05/2024 06:37, Ian Rogers wrote:
> > > add_default_atttributes would add evsels by having pre-created
> > > perf_event_attr, however, this needed fixing for hybrid as the
> > > extended PMU type was necessary for each core PMU. The logic for this
> > > was in an arch specific x86 function and wasn't present for ARM,
> > > meaning that default events weren't being opened on all PMUs on
> > > ARM. Change the creation of the default events to use parse_events an=
d
> > > strings as that will open the events on all PMUs.
> > >
> > > Rather than try to detect events on PMUs before parsing, parse the
> > > event but skip its output in stat-display.
> > >
> > > The previous order of hardware events was: cycles,
> > > stalled-cycles-frontend, stalled-cycles-backend, instructions. As
> > > instructions is a more fundamental concept the order is changed to:
> > > instructions, cycles, stalled-cycles-frontend, stalled-cycles-backend=
.
> > >
> > > Closes: https://lore.kernel.org/lkml/CAP-5=3DfVABSBZnsmtRn1uF-k-G1GWM=
-L5SgiinhPTfHbQsKXb_g@mail.gmail.com/
> >
> > Taking a look at this one now. I think some example commands and output=
s
> > in the commit message would be helpful because there are quite a few
> > different things mentioned in the closes link.
> >
> > But I'm assuming this is just for the command without specifying an eve=
nt:
> >
> >   $ perf stat
> >
> > I didn't realise that wasn't working properly and I'd missed that Mark
> > spotted it in that link.
>
> Hi James,
>
> Do you want to take on owning fixing this? My concern is that by using
> event parsing:
>
> +                               "context-switches,"
> +                               "cpu-migrations,"
> +                               "page-faults,"
> +                               "instructions,"
> +                               "cycles,"
> +                               "stalled-cycles-frontend,"
> +                               "stalled-cycles-backend,"
> +                               "branches,"
> +                               "branch-misses",
>
> any of the names could conflict with something advertised on an ARM
> PMU somewhere. Clearly cycles has already proved to be controversial
> and broken for perf record on Neoverse.

Oh and these events are also broken on ARM M? PMUs with the revert
that's in v6.10, so I don't know how to go about fixing this.

Thanks,
Ian
