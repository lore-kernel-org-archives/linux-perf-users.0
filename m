Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+GrW/PL"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCC1B9
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 10:00:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50beed2a46eso178e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 10:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702404028; x=1703008828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLc2uwTCsXHrkyfMISisr6i9Izcj9rKOSvz6R6z0jK8=;
        b=1+GrW/PL+8KSPt7tJTWJJmQEFkBa54Y+7z0E/Ov2Z6uyi9irIKdjO61mnQFQyH7dEP
         j15p3cm9MEzj0zOzeio1JV/RcBAtnf2rxUf/ncdqTHS+w12yDoIMi7gOdAXfxt8jHatM
         n+hgOuJACS5NmFzT8CGZcSdog7KzoTbgT5EpSC1N9fzcRo+wbsXKMLulm+1oPgWzNpzh
         NJYRYh7Wx6OjrysBqZeU6me9B7IJqFktgEK909UEyOc/CrQbbpCRxO8gRWq/xmhiHA5f
         MCp9DbFaVEuWoIjsVRhWIU0s5IC91TBzy9SlaFG4/qDaDoyWBEcvReJhbeswnI0aAuOZ
         ldQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404028; x=1703008828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLc2uwTCsXHrkyfMISisr6i9Izcj9rKOSvz6R6z0jK8=;
        b=hiA6yAdp1EWZ4h2K1P66x8Bi3A7J1Rw5vn/zHXwbGx4mW+Zcxvw8v8xZto7IKz8H1n
         NqioZMSdU3VBHrrtak8FilsJDPaowGmL/me1uxVSk07eXlNTS+tJUdKiS0qhF1vk2dd6
         t+6A9lcqqb8aWAvwZ/BKoYaT5vOLctDG+ZVkPp5pk2gaAe8hdlX/MBljPzDnifqhBeEI
         rvKtVn9ofWp95x+IwUsZZ658E+5ECJMYGlvANEem9CbbdAie6EPRcXmfIhasbec8G6dU
         7lUWTc/eNewieqJ3Okex515gALSOLE4+sF43TwkIapnLCFdN2bi54Ug3eGL5jtQembzy
         +Mmw==
X-Gm-Message-State: AOJu0Yz9M+Wb7Zu6EfAtKE/ro+B0S8BOtRf8rLza4bRfL7Bf5fOjtFk5
	91TpLMv+SY/tJ0/HApsyxPFGxh2Qxnc8C/hoOwc2Ovzxb+6J+qo8k64QlzUgsGU=
X-Google-Smtp-Source: AGHT+IEO6SMKP18mW79wlSCfRL85uc/ZxGxAtrMNO3aesJ0MKMM65U17ubTZNlIPBFHjTe8ED02eAlkrmkn47QZmOkU=
X-Received: by 2002:a19:e058:0:b0:50b:fc76:42c with SMTP id
 g24-20020a19e058000000b0050bfc76042cmr240096lfj.2.1702404027469; Tue, 12 Dec
 2023 10:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org> <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
In-Reply-To: <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Dec 2023 10:00:16 -0800
Message-ID: <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, mark.rutland@arm.com, 
	maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Dec 12, 2023 at 7:56=E2=80=AFAM Liang, Kan <kan.liang@linux.intel=
.com> wrote:
> >
> >
> >
> > On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com e=
screveu:
> > >> From: Kan Liang <kan.liang@linux.intel.com>
> > >>
> > >> perf top errors out on a hybrid machine
> > >>  $perf top
> > >>
> > >>  Error:
> > >>  The cycles:P event is not supported.
> > >>
> > >> The user_requested_cpus may contain CPUs that are invalid for a hybr=
id
> > >> PMU. It causes perf_event_open to fail.
> > >
> > > ?
> > >
> > > All perf top expects is that the "cycles", the most basic one, be
> > > collected, on all CPUs in the system.
> > >
> >
> > Yes, but for hybrid there is no single "cycles" event which can cover
> > all CPUs.
>
> Does that mean the kernel would reject the legacy "cycles" event
> on hybrid CPUs?

I believe not. When the extended type isn't set on legacy cycles we
often have the CPU and from that can determine the PMU. The issue is
with the -1 any CPU perf_event_open option. As I was told, the PMU the
event is opened on in this case is the first one registered in the
kernel, on Intel hybrid this could be cpu_core or cpu_atom.. but IIRC
it'll probably be cpu_core. On ARM =C2=AF\_(=E3=83=84)_/=C2=AF. In any case=
 you only
have an event that will be enabled on a fraction of the CPU cores the
thread you are monitoring could be scheduled on. This is why 2 or more
events are needed (depending on how many core types you have).

Thanks,
Ian

> Thanks,
> Namhyung
