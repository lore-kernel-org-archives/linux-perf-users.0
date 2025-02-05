Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB01FE44E
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738730915; cv=none; b=murlGazklLSrSmq9dVYzY5c9rPyMs9Ipmg7ABWGerF8w40bg1wn/tC2YxroL1C6dEWUYlWkTY+5RieBmgQP9U+tE+2IlC0r3FzK9Zpdxd58N3xloXsoWdkbTXxQ9fkwy8Umcws0SVXl0oCsFa78jqbTnXdHh+U06AheNrsOtaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738730915; c=relaxed/simple;
	bh=eiU7uDePcWnOLNcxWdT2qg+j5h1OAuZA2Uk+PVY+hYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lX2G2oqfctj3xqBIso7HjTEupKY2z0tGALsx1s9yOTOf9eNWDBaPDQ/QTzTEivGkNttnGWKI4Z5sqm3mHI7xOzkqhRXg0fciz48lZ4ugF+IVHubnAVmvoRL1yJyEu9jDBIqIHVCHpEWaVYEvdJEhx+QV2dWrhfJFKD4BDxmhgMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiyAltxK; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiyAltxK"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a814c54742so269405ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 20:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738730912; x=1739335712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdUHWjnri+g2A9ir83ZJXkiX3qchGiLgbVc6h7UdLQQ=;
        b=NiyAltxK3Q5Cc/hdIDUenz7gDZvYnybQ0wxy3+LevpJqp9RGKumE008G+JNjJYUH9N
         PZ9C7oPIlAGXPgKn5XHka7GcvhLHSD7+mPyJou0kYvPac3dOyGHpjq/2qrqi3xZj6DBI
         jVVYQsf0jggxPe0/gXFBUnA+6hydjoJTAeDi0d4MwKLtZJTkzTtZiuu0Lc6TcJffgkX5
         BDZyVb4gSzXteE/I97h9ucWFRrCthh+3wIoitTvEtZ586/x2uWim4Vt8j1NzsIk4xaoZ
         QO0PTB4I6B7iTdbEZlURaJtDk5jvSNEOMj6Ojp5RMUT7mFqUqq6Psm+AemcPhQilSgQ3
         iCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738730912; x=1739335712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdUHWjnri+g2A9ir83ZJXkiX3qchGiLgbVc6h7UdLQQ=;
        b=o2hbWSUFCcN8nrYQ7ZgpIGylhjHQDFBVcexqgL6NfB1u5K+Q45nMRVuNlKzO9NbRXW
         H7kz79zn4TAw8ARqJ+6ISiet8X2QRuMyNcn17MMh5TkVi+aBbGYtjQX4IGPxvN87sbYX
         2vKsD3VYrKxTc70EmIDqpl9rHKNyenOiw2Nh+7MpqHfgwKU4Hij0T2N7qm9XOFzNs4BL
         ZTwyEFCKLgWxOrl1mY6UGSxEGF6lCyF/+J1AEdnj7OJV60F0EKKGVCNfJh0hkxCdKne2
         MG5XoqDk4w61UOA28aNWstqicAtoIvjKdo7Vs2yQYlcmkd1qPHbOZbLF+/U/TG9jMLoW
         Yb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYwjBlH4V2K5UVLPMj4wGjOLuu1Pg51h6grv920Odldg4abyaYHptI6rRhw7/cEXUh4KqhYXiS1tjFWep6jm1/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Hgdu0Wtnap7kFPggsq4Deh3tZSBJ43bSk6+kJr7c5HfBRS77
	dDKFo1EUfE5ko9Q7Zdte8Zd3X1CohJ244V9gAR5u6HEJnZov6L6tQp6RcQ3p4HmIusIDe0mtOuB
	3ioDe4riPQdqTw5ATqC1VJ5qpssbp7ZN6+z6h
X-Gm-Gg: ASbGncukGIxS18fGbPBQJW3SWOU//dR2sqGjX+htMmVjFbJhrOgUvAZ2Fd+ljWhvkst
	3+0Dt+76UCycKKUwIut3FzJj2WAJIMz2AvRPlETecHst0DD8dRb4/8TMAyFWY9eGE2Z7kCjOC1A
	==
X-Google-Smtp-Source: AGHT+IExCH3kYciLrs8VTeCS1q0/fpKXMt3mVQ/MBzl9HvILLwYiPvM02gN2sXmcSaAnL4t/wfGrKez4ICUMXO/LOBA=
X-Received: by 2002:a05:6e02:1fc3:b0:3d0:52e9:2154 with SMTP id
 e9e14a558f8ab-3d052e92393mr367155ab.21.1738730912166; Tue, 04 Feb 2025
 20:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com> <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com> <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com> <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com> <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
 <Z6LFp5jiED7_-weN@google.com>
In-Reply-To: <Z6LFp5jiED7_-weN@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 20:48:20 -0800
X-Gm-Features: AWEUYZnEXt5oa58VVHL92sDVTZqpUBQ5pNK1_z8JNXYTnpv9jKbdMz_GMnU9w-c
Message-ID: <CAP-5=fU6WSOK_N0NoLcMSSdaWAkdC2DUBwLqsLn_KA7m6dJyeQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Atish Kumar Patra <atishp@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Feb 03, 2025 at 04:41:11PM -0800, Ian Rogers wrote:
> > On Mon, Feb 3, 2025 at 4:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > [snip]
> > > Yep, I agree it's confusing.  So my opinion is to use legacy encoding
> > > and no default wildcard. :)
> >
> > Making it so that all non-legacy, non-core PMU events require a PMU is
> > a breaking change and a regression for all users, command line event
> > name suggesting, any tool built off of perf, and so on. Breaking all
> > perf users and requiring all perf metrics be rewritten is well..
> > something..
>
> Well, I guess the majority of users don't use non-core PMU events.  And
> we used to have PMU prefix on those events for years so old users should
> not be affected.  Actually perf list shows them with PMU prefix so I
> think new users are also expected to use the PMU name.
>
>   $ perf list pmu
>   ...
>   cstate_pkg/c2-residency/                           [Kernel PMU event]
>   ...
>   i915/actual-frequency/                             [Kernel PMU event]
>   i915/bcs0-busy/                                    [Kernel PMU event]
>   ...
>   msr/tsc/                                           [Kernel PMU event]
>   ...
>   power/energy-cores/                                [Kernel PMU event]
>   ...
>   uncore_clock/clockticks/                           [Kernel PMU event]
>   uncore_imc_free_running/data_read/                 [Kernel PMU event]
>   ...
>
> The exception is the JSON events like below.
>
>   uncore interconnect:
>     unc_arb_coh_trk_requests.all
>          [UNC_ARB_COH_TRK_REQUESTS.ALL. Unit: uncore_arb]
>
> which I hoped to be 'uncore_arb/unc_arb_coh_trk_requests.all/' or even
> 'uncore_arb/coh_trk_requests.all/'.  But it would be hard to change the
> all metric expressions now.  Also users can directly use them as they
> are listed by `perf list`.  So we need to support that without PMUs.

So there's nothing wrong with your proposal except it breaks non-core
events. We can't agree to flip the default on a flag for perf top:
https://lore.kernel.org/lkml/20240516222159.3710131-1-irogers@google.com/
to make perf top behave as, you know, top does as it could be an
option people depend on. A behavior that matters if you do user
filtering as exited processes stay in perf top (both confusing and
un-top like). Fwiw, that reminds me of another patch series being
unreviewed:
https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.com/
Anyway, the perf top flag is one that no-one knows exists on a command
most people don't know exists - Julia Evans' zine of course loves it
and we love Julia's work and the zine. So, it would seem to me that
changing something as fundamental as how all non-core events behave
would be seen as a regression. Imagine the person going to
perfmon-events.intel.com, finding an event name and expecting to be
able to use it with perf. Now they need to grub around in perf list to
locate the PMU. What is appropriate for them to know about how
suffixes work and show in perf list..? Well that's assuming suffixes
work in the future as ARM will probably launch an a1000 CPU and the
PMU will look like a hex suffix and the whole naming convention
implodes.

Even with this what would be the behavior of core events? You want
legacy events to have priority over sysfs/json when there is no PMU.
You know, and have stated not caring, RISC-V wants different and that
it breaks Apple-M's PMUs for a fairly large range of kernel releases
including 1 LTS kernel - the only reason I'm writing patches in this
area in the 1st place. Software is soft and you can go fix software
anywhere in the stack. Listening to vendors and not breaking everyone
is the point-of-view these patches have been coming from. I find it
very hard to have a conversation where this is just forgotten about
and we're working on hypotheticals which seem to be both unwanted and
implausible.

I don't know why people (yourself, Linus) keep wanting to show me the
perf list output. It is arbitrary. I rewrote it and changed the
behavior of all uncore PMUs within it (we didn't used to deduplicate
based on the PMU suffix). It is nice that people think it reads like
some religious text. Why is the formatting different in perf list for
json specified events? Well it is because json events have
descriptions and the events you are showing with a PMU don't have a
description. I think because there is no description, an effort was
made to keep the output compact and put the PMU and event name
together. It wasn't trying to enter some kind of long lasting marriage
that the event name should only ever be used with the PMU. What
happens if an event is both in sysfs and json? Well the sysfs event
will get the description from the json and then I believe it won't
behave as you show. Did the event get broken, as perf list no longer
shows it with a PMU, by having a json description written? I think not
and I think having descriptions with events is a good thing.

Thanks,
Ian
