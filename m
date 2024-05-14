Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6791E487
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709958; cv=none; b=Y4hdBKQFm3VY0n1Qtx62gYYcoqTYNW3nGDSqrFBpdQVn7DjoYk/9yGPlnr7dF6x4TtHQvj6K0X3REgd8wjS9WOhyIvbPUNA6COV4anJCPI+apMLhCPK97z4IujlGND9kjQQpjrvsmPt1bJgUqC1xoNQRykPx8rCmKLv45f0XiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709958; c=relaxed/simple;
	bh=Da94fetaeTFAIYn25zhN8Bh1d0YUjBDQGxwyzJXpsf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Et9Fz6kM33nrJRP7cY4zuDIxOabIBoiE1N0fhL+lHJn2rhIZ2zFHYpqFeDHi7cnpfcz8aJQXG5Gwwxu3hmi+t4M/zkwrn0VIMIV1RyNCOf4y4iUbUhMYPMo+kyj6i9dbcVjeXLIHSiV8rUIReYNXt+X9SA8kQvv3oP7vdsuaLOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRN17uuy; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRN17uuy"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36db4cbf339so32185ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715709956; x=1716314756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofET/i5UeEiORcp9qMDOEPQa5PYgwrq80ixI+8R+cBI=;
        b=BRN17uuyswcxP+/TZrTc9LgPkaNBQkIVcrTPaI3jGBAn77fVKxG/pqxuVyZn7Uf4Yh
         gqoMMk0C0UpkPjJMyIWhXS9+adtO/dEX9/11pfsmcbBQN8dGzJ8Q+YQMZgfrdzqzfX6o
         a/gBX5g5+cU9TL7qnRQHhqWZ2flY+hfGMYKYvYya4yV0pBj8QT7hvBhCGlXBb8jo3SCd
         FqRBzQYi/pgDsIFl0rID3nV6IUyZiLVEB3z51QEbu+Mec8xU5TsGdcYBMRhA+malN7A3
         I4nnhTA02K5pjB9MlBTMrPSm4yIOwWm1EvaeRHYOSfPDZbc+vKJJTWh5sAzGJiNBUcv6
         GUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715709956; x=1716314756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofET/i5UeEiORcp9qMDOEPQa5PYgwrq80ixI+8R+cBI=;
        b=q3zEvzfmLtzDNTvn1D1Qk9XCx5TtQDt+3OFyBEaCnE30hdNKug1EtIor6noovs/7J/
         NOmQhd8n+d+6gg7B1VQ05QizJaK97IhBzeD4VIqVdhAX+znsTAGNDmRqEtjjffLqaBq1
         OFe80kRkx6lzumusN1UFpw2lcfs8z0bsl2V+adMQKknJyGwbWv2OUMt6Ie4zeyMoUVmY
         Q3dHl1XCmE4zhy50XXMZWX0wx9GXEllIrUPq5rkbAdSNLCQnVVDJteiEnod8LZAMxIfU
         Rw3+wvSfdcMYuVbqsNeIKiuraP51qVmKK/Gxf4VBCCU247lZEbKk4j3EA0CBvF6UKEa0
         Dgmw==
X-Forwarded-Encrypted: i=1; AJvYcCVZbh6kjv97z/8wEZ0nZywH3XEjrQlQ5P8uzo8AR/y75flbJ5ThqQw09n11bUgZh1OT0pgOw8QAeLPaH3lfCY2eYMOIBDNIS3qPhHxou4Uq1Q==
X-Gm-Message-State: AOJu0YwASeCIV9zqQEnLfXkzPltRICwaY2xTRK0hZa/S4u9+v01XVYjR
	fOKjZnwAXmumOPCPbYuf/VcIYp/uZnCIn1xOs8N0y4T3WoSvontUlB76aKS80J3Y0007cpT6+ho
	8j7j4U31kmVl3w6eUpunqPTFXllbJapdno39B
X-Google-Smtp-Source: AGHT+IH6wXTnT+/6KH/uu3qSxsNzTUbvDP0JrFZVGjxdT02crkc+KQtTzzRa+Xyeqtw1AyMbLn7qUuUs7dURQhivniU=
X-Received: by 2002:a05:6e02:10cf:b0:36c:60f9:5257 with SMTP id
 e9e14a558f8ab-36cccb5cc60mr6895725ab.27.1715709956372; Tue, 14 May 2024
 11:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514005817.2902473-1-irogers@google.com> <793876b1-fd4d-42ef-91e2-88b4a48794b7@infradead.org>
In-Reply-To: <793876b1-fd4d-42ef-91e2-88b4a48794b7@infradead.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 May 2024 11:05:45 -0700
Message-ID: <CAP-5=fXfUeuouJkW5uiB-6A6M9Ng86QzgNXZjO0C77oL4anWsA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf Documentation: Describe the PMU naming convention
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 10:40=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi,
>
> On 5/13/24 5:58 PM, Ian Rogers wrote:
> > It is an existing convention to use suffixes with PMU names. Try to
> > capture that convention so that future PMU devices may adhere to it.
> >
> > The name of the file and date within the file try to follow existing
> > conventions, particularly sysfs-bus-event_source-devices-events.
> > ---
> >  .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-de=
vices
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices b=
/Documentation/ABI/testing/sysfs-bus-event_source-devices
> > new file mode 100644
> > index 000000000000..3f7e53e82de7
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices
> > @@ -0,0 +1,24 @@
> > +What: /sys/bus/event_source/devices/<pmu>
> > +Date: 2014/02/24
> > +Contact:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
> > +Description: Performance Monitoring Unit (<pmu>)
> > +
>
> Mostly looks good to me. I prefer a small change (below).
>
> > +             Each <pmu> directory, for a PMU device, is a name
> > +             optionally followed by an underscore and then either a
> > +             decimal or hexadecimal number. For example, cpu is a
> > +             PMU name without a suffix as is intel_bts,
> > +             uncore_imc_0 is a PMU name with a 0 numeric suffix,
> > +             ddr_pmu_87e1b0000000 is a PMU name with a hex
> > +             suffix. The hex suffix must be more than two
> > +             characters long to avoid ambiguity with PMUs like the
> > +             S390 cpum_cf.
> > +
> > +             Tools can treat PMUs with the same name that differ by
> > +             suffix as instances of the same PMU for the sake of,
> > +             for example, opening an event. For example, the PMUs
> > +             uncore_imc_free_running_0 and
> > +             uncore_imc_free_running_1 have an event data_read,
>
> s/,/;/
> or: s/,/./ and begin the next sentence with a capital letter.
>
> > +             opening the data_read event on a PMU specified as
> > +             uncore_imc_free_running should be treated as opening
> > +             the data_read event on PMU uncore_imc_free_running_0
> > +             and PMU uncore_imc_free_running_1.
>
> With that change, you may add:
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
> thanks.

Thanks Randy, I'll leave this on the list to bake a little longer and
then send a v2 with your fixes.

Ian

> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html
