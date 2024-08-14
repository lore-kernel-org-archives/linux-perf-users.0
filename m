Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3834A01
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596219; cv=none; b=NuQaA+x13RC5wBDgRRnfIIwELmwtcvJYVIoHVs9RxPJPBzqc45DPhn+t2E0gK6ypa2978Plir2eh+b0tC4ZHl3IpU+VotnKhkimn5YLAowpinNTzeVxAhqGdnV+8VMeswpzTGKgymYSKi2dUHaRYIK/MwWM2feog4Gq8DLiHJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596219; c=relaxed/simple;
	bh=HUc/+dKdoclQJ30l+pQG0Jo6TjouBGA6yWoH3XnWHOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GB0XwABK9Vs0UaFRaDSecp/2c9jBaaiobP0DgblqAMXUX2JK9b+fpby6TUktQt1ksa0dWXccmmb+SQaGl6qzKsHcSrzM56ftjmnw8wcFEP1PZloZEjQ3NsBRc0qlIaBeEA0kHEJ8YA8o7BKFjBID4Ziptm+YyAYztDLZMlSMWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0JjW/mV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0JjW/mV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd7509397bso38305ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723596217; x=1724201017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUc/+dKdoclQJ30l+pQG0Jo6TjouBGA6yWoH3XnWHOQ=;
        b=o0JjW/mVk1zGRyCuLlIGHJl6/ufkAePreMkAf8SjXsQncKU12zi5A9h5dcsBiyjpj8
         KNrUPV71FkdlOxDPg4/25xGffHoNoQ4D+XwNCdUGinq7TfVScmezEqmzdF1QJ+fd6ilQ
         cG9LGE6y7LMi4Pg8bc+kyLPraBdiE9Q931sJ90tJsVD4aypb+jb2PSgBlth0k2yCJvNj
         Tl97zPT/Aawiz5gJOq/Wz24TkwftpGP9EapsF8pHdlKQGPvAJ9XPGZoVTB1L/z8sV3XK
         mvwFIl9hsfYdMdCWN2su+JIxy/4PqafaLRT3SewSRDoFopwkJ4d/qWr3PHO4+DmxZY50
         jxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723596217; x=1724201017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUc/+dKdoclQJ30l+pQG0Jo6TjouBGA6yWoH3XnWHOQ=;
        b=CJVC9wE84EfU8aBk7lqaRzB9A0YleeJFQfxH+MH13qxkAKYqb8hOPapApScFwgG9K+
         OiWLJV1/Q7PsGUYVOAoBI+/uMhJE9Fj9z6Hc952zphkCJY4cZATcUFUePqhgy+k/yShb
         S1vZUcaErsnLC4wKBsoMZcJoZzOxox4pHOGe5C/km9DkiK5Wr4KmFYTr40SiiTb2s+64
         IQI++pEhcV82lNnfvQnwLEjJqlusQQDGg9eFNOWs5Hn0ofpdjPen10HLpcIpUyNX6Le/
         eXOMwg4i3Kq+S9zi+V4wFrztpBuIneTkDByI4v/Q9wBJjl9kv7Bk5Mn094MUZrGdhLVY
         XMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9c5gJA4Ogs+o8bbhGfmCi4blebV1kWjbnugTNjZHKdPgkeIOBdKQfdqbhBeJYNq2WOJozDpnQk83ViA8lnMGzRKClToTj8Jb2oEL5Y45tCQ==
X-Gm-Message-State: AOJu0YyB+cjwlhkHEL7G3703zMOtdIp+QKhwuedPyYoG4EB5LonAb5YY
	EWJU2rhDt4rAAUD6JcT0Atkd7kZl9oxMFshHn8yAcewV3wgOQhOjB9CdB66o8GL5HJiJNUAIlSU
	Kn0pzBuvGD//eQmkN6JBlRKrb4lMT4uI+R7GB
X-Google-Smtp-Source: AGHT+IET8BpalyuCRR3ec4d/UltRhOMUt1gKg+BS5WJWfldGsTfJGsa7NaAJTms1Gk/0y55tUSYbmPRWE04G4jEP/Rc=
X-Received: by 2002:a17:902:cec8:b0:1ff:622c:27b2 with SMTP id
 d9443c01a7336-201d8fda9c8mr367005ad.3.1723596217174; Tue, 13 Aug 2024
 17:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813040613.882075-1-irogers@google.com> <ZrtzTTHim_vGX1ma@x1>
 <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com>
 <ZruhsN4i6xtc59nJ@x1> <CAP-5=fXVrhanvW6vrUJsubuWUC4jBM5v_NOFp40cqTsqdHHNaw@mail.gmail.com>
 <CAM9d7cgGgXTyTQNPDyVuKWM=Gxt3=J6QZ6FiYDXZRWASgKPskA@mail.gmail.com>
In-Reply-To: <CAM9d7cgGgXTyTQNPDyVuKWM=Gxt3=J6QZ6FiYDXZRWASgKPskA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 17:43:25 -0700
Message-ID: <CAP-5=fXXNCKZcv-5SUcQH7o2E9uiRJ22s=-_UrY+_jWmtmH2wg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Aug 13, 2024 at 12:11=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Tue, Aug 13, 2024 at 11:11=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Aug 13, 2024 at 09:04:57AM -0700, Ian Rogers wrote:
> > > > On Tue, Aug 13, 2024 at 7:53=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> > > > > > lock__parse calls disasm_line__parse passing
> > > > > > &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> > > > > > lock__delete.
> > > > > >
> > > > > > Found with lock/leak sanitizer.
> > > >
> > > > Ooops, I meant address/leak sanitizer.
> > > >
> > > > > Applied both patches to perf-tools-next.
> > > >
> > > > Thanks, could you fix the commit message.
> > >
> > > Sure,
> >
> > Also, it'd be good if maybe Namhyung could take a look. I did things
> > this way as it made sense to me, but we have nested things going on
> > and potentially the free would be more natural in ins_ops__delete.
>
> Looks good to me.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks Namhyung, thanks Arnaldo. I think git blame said Namhyung
because of a refactoring. I'm glad the free is in the correct
location.

Thanks,
Ian
