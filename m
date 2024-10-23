Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC06CDAF
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729656414; cv=none; b=ppf7tXlP7QV6QRY5GIBljdUKR5ar9VII2Wc4DNP+9iLq4C5aCVK2tIjr5zRFXceM8QOBHBHUHaRnQx9HSNoWBrr1oXiZUrS82fCkvj+TipxesjFsreoF2n40x7qFN3yFW9HBMMi6dEbEiaGclGCw3yCt85TCz/DUgESiuIlGFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729656414; c=relaxed/simple;
	bh=FrQLENoGP/dCOAZctQLYD3mOzEEySi5JjYNMWjRZHBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bl1NAZJZEOoWzZBitQeBRVcbY0pwphRrzNrNyiO6g1s6SNQSBCWF33XWCwq0vCxWz2/hS5RYLHFRZDWLGnrCo8DyzpttY9apo8hOCTXJn9YY/g7f0wIbP71TQyEedGmmisS2iOZDSc+GjF5/kywGTxlhc6exrUmzW5AV4SQuAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=al/7KxfA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="al/7KxfA"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4608dddaa35so185771cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 21:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729656411; x=1730261211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HitsFUO1EidESPoKRuV/OlPLmnVZu05z2WbOguU93h4=;
        b=al/7KxfAOsb5fB/0fhN4m+sRBwLHAwkEh3kiUqiRmgJCnr8WZ7yZoizOtT9w7n8L1E
         Kv30ORazqgyiFMPyy8TQQVNT/f6oagpSBgkIkuM7u2uuZMISmiQKi/LcV79i9gmYmdgu
         onr+2kdLnDjSPnhlR3r3OHleFSUXMuDZZUqaerODbnv0kPhGajImhDxZE9g2+MU+i9V3
         h+mwlz3YngF+itGfTKWI3hgEnkBDAxW0IWMJI/LBg+Z34cTq8G/uY2GXydu+h+nMBNht
         z7f7I4m5rl6zhH01R4wsuA+SsWczwAyYa12E9Mos/UqOsJuYHQTphCaqqJcxjyQMruNT
         58Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729656411; x=1730261211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HitsFUO1EidESPoKRuV/OlPLmnVZu05z2WbOguU93h4=;
        b=RzprYe6Eyc/NdWmRuBzuKm7FJlNzJa2xNykQR5GlXchhw1OKVy+8zZoRYu8bSZne5y
         3sBswrFmlMjkkvDKSXXRKPwAR46ivqLQOZCqMvKTlDq94r7bWAQ8JrKxiyg4lA5Mg9qB
         017aP93kYfVumJSeBgFLcCAUa21RFcvSvYHqc+o0cWF0V7m2HJTS1SUJuPudRO1nr5xn
         /WXbw7ej/PCqGrruZU30h2qgWjWF78CQgBNRpuszPiFt9dpAuYp3VSDHKTh5arydxLhx
         AXRVIM1BJrLA+t7auqmGketlbSo16CKjM3nvrURabCuKSNKnPYP78TZDGOxcNGUwsrJ2
         gLCw==
X-Forwarded-Encrypted: i=1; AJvYcCUdBhKPPdSJgNEVy7f1kZFG0qWrVFxP5dHACNBhPORZlBiX7N0+FzjINuhUrN9wn8lKZAIz3K5Vao+WCeoC/JUn@vger.kernel.org
X-Gm-Message-State: AOJu0YzImkFcuT8O/Lg5A2CfoKZ/hqI/nlRoZa3vQLh6vKbmtbdLdPid
	3+5LaCw88/h5ncL3TPn8VITSgcVa4fy1ZQd4T1f/fe61lGKcrZyqQ/ojmD0cQWJiMjmDQBRnkay
	Adi0XvADu6TExDBCPMdvg8eGr//M3M76q+T/P
X-Google-Smtp-Source: AGHT+IEjcmtwfLg+spZLHWFvoEQXhFCmc9lNLMfvrW3qkW/32GsJj6JhV52GinHNNzPhYKR/JM2jrFxzsdoMeNJWl9s=
X-Received: by 2002:a05:622a:5e8d:b0:460:b5ac:c23f with SMTP id
 d75a77b69052e-46113d497a8mr2104581cf.7.1729656411326; Tue, 22 Oct 2024
 21:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606044959.335715-1-irogers@google.com> <c7d6eedb-7c5e-4411-a83f-4328dc75ec46@linux.intel.com>
In-Reply-To: <c7d6eedb-7c5e-4411-a83f-4328dc75ec46@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Oct 2024 21:06:36 -0700
Message-ID: <CAP-5=fXY2Ofr_GRc7Mq7BfoR+2150o8e1JeyGctcGPRG70DqPg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] perf Documentation: Describe the PMU naming convention
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Tuan Phan <tuanphan@os.amperecomputing.com>, 
	Robin Murphy <robin.murphy@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Bhaskara Budiredla <bbudiredla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 11:15=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-06-06 12:49 a.m., Ian Rogers wrote:
> > It is an existing convention to use suffixes with PMU names. Try to
> > capture that convention so that future PMU devices may adhere to it.
> >
> > The name of the file and date within the file try to follow existing
> > conventions, particularly sysfs-bus-event_source-devices-events.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> >  .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-de=
vices
> >
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks for all the reviews. Could we land this?

Thanks,
Ian

> > diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices b=
/Documentation/ABI/testing/sysfs-bus-event_source-devices
> > new file mode 100644
> > index 000000000000..79b268319df1
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices
> > @@ -0,0 +1,24 @@
> > +What: /sys/bus/event_source/devices/<pmu>
> > +Date: 2014/02/24
> > +Contact:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
> > +Description: Performance Monitoring Unit (<pmu>)
> > +
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
> > +             uncore_imc_free_running_1 have an event data_read;
> > +             opening the data_read event on a PMU specified as
> > +             uncore_imc_free_running should be treated as opening
> > +             the data_read event on PMU uncore_imc_free_running_0
> > +             and PMU uncore_imc_free_running_1.
