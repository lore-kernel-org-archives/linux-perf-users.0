Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BD3CB2D7
	for <linux-perf-users@vger.kernel.org>; Tue,  5 May 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018176; cv=pass; b=nAAj84an2C3SmPHt0XLRoecxcMxBBt25XDBSCDcA4YDjUA2ZQ/RnboYwnxlFI5A0ezWwFuGgnuujJ7YWBP0tNYjnr2uSiVmLztGOElCKPVaMLTmkuIEpcncsdFBkukqlFwp2HAcSaixU5Ce/RGSiYepYcSjbFVN2oRDFhO2b3jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018176; c=relaxed/simple;
	bh=IYr5sgxlNbQccaI2qNEe8FWZ+RpMlTFVZKhdk0cW7Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSG7a6chQVbKZ1IzUhlmi/B2+Pd4BbboPm33AgC3Ha4X41QX8WVlQJZy4PSZ7G7CqEWJpprqCuteYnwb50QDm15T8ztZ3Eyi1/1Z/0LQPH80EpcUoPpY/VsxJRXVReG7QqTrat1aqo4wX1KOBMXbnFJGkxz1zOMFiSZfr2e5j2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ceGrjKVG; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ceGrjKVG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba180a022dso15295ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 14:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778018175; cv=none;
        d=google.com; s=arc-20240605;
        b=lSTySjhzwSA+ZHMRy6vUNEVMQmGbjCwsT7uFjAPXMS+MlrjuYQVxEJbl0Jl+1eGOl6
         G84Q/AF6/qsNv14jXMYFKp7Hz+tuxR6SaxI/ltSuX6V+4jWokBzc7G8frbCg8gPaq6tc
         Z4uqI9Zy/v/KA4xk7qGirsamRxhKr0/DVRh4Vt4Q9LAPaGh0qX6qpSqXGCb+J/0x6nUw
         TOFoTgyREhfKhHFv2HPA4G4DcAiZi0aEFzMRCqHAuVGkWpCoVwgLCdb07mGYuBgK1Ow3
         9/ZGQCHEu/sz+rTpyfu83xC1xEqa+qEGONMek47a1GKcxJ2zCm2kavOPd5udYXjvM8KZ
         TX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WvKA/G3luKR/3/bcAFBL+Uo03nyYp1P/5vlNBTqgnCw=;
        fh=cSGVwn10QLXRp3kGTXnKihni6Cg6QS3PuYOJdNrSTv0=;
        b=XjLC5PzKjMp3YhId/Wb54SWSmsH8+NhrUp0UERhXKS6jOOEIEzj8rrbUz+eLfIYqEy
         6SvPKBj/MRldo2fYsrbj2YK6QMc9+qRA+Q05w8P/pnyWCFeYYnDBNS7KavMfTcGA+EsR
         +5gkm3brZVxUYS3EOU8yj1fjF94hVBUHpzq7lppR2tMR2isAHKIQnEmbEvNCCeCMJy1I
         ZrC4CRg7u2ADSczWDpY34f+54CM7t+6WrTkgc8DuWEK8Iu8Zjg448dem2yIAXuXbxAFB
         57ABIhq7zhpI2BmcwRVXma9/2WJrCHJRx14chr/rVcNFY2erZka1NfvGugANs6Lxt2qe
         QFCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778018175; x=1778622975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvKA/G3luKR/3/bcAFBL+Uo03nyYp1P/5vlNBTqgnCw=;
        b=ceGrjKVGXZxZF/iaOdREfPE3QSRy2eDrt5cgRMDqRKP+iHpPgErOawn+FKPo93IuFE
         8ZXjvI/rQy3H2wUJkw3W5vr1klZ031+Z12vY9BC9OsqWg84YOH6O5uy9s7yz6b/yDaTP
         by1qr1n8aXu7zng0djJ8/sCl9AxV2KoH6pfMwfXYmM5Mj58CJOJCtmYPn1D519u79qzS
         D2FSDgFcwT38AkD3Jt8vaKLwoUOPUY0ng/mRUPE4X/XVJ+2aoLNRmuNDoU6ogrQIwgOJ
         6UC81wp6rV4wLsaDLAMZ5776pYto07b6U26+PiujfFGRMIfII/JR8MlLDTcjmHRCwWDL
         yDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018175; x=1778622975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WvKA/G3luKR/3/bcAFBL+Uo03nyYp1P/5vlNBTqgnCw=;
        b=gRTBe/zObj2R5CaV2kmvBqp2xXbeIPnMgoI7jITK4aXw9aPrr8kdGVlogxbF8WNX5G
         MXot8wmuXlFR3YhPnP0P6LvSa5baWaqRZspB5VFsG3uAFDdgfb+jdVwti5eBU+zIlkgS
         17DglUABEgbz3vqtYZJ64ta88PWumypHRdBkDrZXgWKeaUqzulW0yiRY0yzgeQAdmDrV
         dQmt60tHSVjAKijELgq8h0BG8UK6TSdanCssbsPlNgwVZ64YBrlx6J7zzCbbToAVsCM1
         IqS62lXauYkqZqeZbYQylV1OPgZW0lpNi97HEiGhUVp2Wdad7DBPielG+IoL0fPXYslL
         ctmw==
X-Forwarded-Encrypted: i=1; AFNElJ8ctuPTAgLdXt3fVhz+zMayzM0pDR3rjDrpLtGkfxbcHJ52KF8C+t1Rw/zb737EY0zCAWqtfu0k1B659CnC0EmR@vger.kernel.org
X-Gm-Message-State: AOJu0YzOP9MPNSW2aq6hj8iwj4A+BCYbAFa2fpuVIX6YXcZztriSPiWN
	YkQM2D0C2jPkCn5O6z5Q5bBmSUijCgkp1uB8WCjKVxQPt0Boy160DzZrjo0Bi0KvFZr6R8HI7r8
	Nv91V+kn8Ubdlb9GkCNnywEoEhj33xSprHo8hW5xH
X-Gm-Gg: AeBDieshu1UeIpvqEDjdPicfm74UAMofwlBqol4Wmei5/9TfrpqUimKz2eAzIcO61b5
	pf/v5pwUmjlvIz7b1+Gy/lokMnWIzwlR3aqXneLU8854O2ftAG1IF4E2HxbzU0d9e0cOcvXqCP+
	tBoo2vLKzPpW3TyIbs3d9H1qd39sx1DQlouIlbSC59Rm/3NY3mgbyY7++6Ec5Oyvs+fnNE8XilT
	xliLd+uFaSZjbQ3slBk33Uzk5JHHH4JqRVOuK+CM+KVxafdFf2TT4dZKgXZRpBcCDhzWkOXxG0u
	AULZzbstp1XPh9rcb1eClWOmzunx3g==
X-Received: by 2002:a17:903:46cf:b0:2ae:575b:2345 with SMTP id
 d9443c01a7336-2ba7cee15e2mr575165ad.9.1778018174219; Tue, 05 May 2026
 14:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321061448.810525-1-irogers@google.com> <acW_IHQVZnxIETdd@google.com>
 <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com>
 <ac8pEDUKjuMxXUS6@google.com> <CAP-5=fXeBje03BM8D9q-0KsXg2KmyRa81CuphtSQfHp0isFc_w@mail.gmail.com>
 <adPzEmwDaHq4SsZw@google.com>
In-Reply-To: <adPzEmwDaHq4SsZw@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 May 2026 14:56:02 -0700
X-Gm-Features: AVHnY4LII5jgRRc27QRyhGFkP8ME7OPHLC8sU-Q3XpYlIzyqYOg69wCYmjBV1Uc
Message-ID: <CAP-5=fW-H-ri3MdVv4Vh4xiyB-qpDqnO3gqXR+XyfMK+kXpHQA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 10:53=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Apr 03, 2026 at 08:29:25AM -0700, Ian Rogers wrote:
> > On Thu, Apr 2, 2026 at 7:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 10:59:52PM -0700, Ian Rogers wrote:
> > > > On Thu, Mar 26, 2026 at 4:20=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> > > > > > Doing a `perf sched record` then `perf sched stats report` cras=
hes as
> > > > > > the tp_handler isn't set. Add extra checks that tp_handler is s=
et
> > > > > > before accessing through it.
> > > > >
> > > > > Oh.. unintended use case. :)  Probably better to add a dummy hand=
ler
> > > > > for `perf sched stats report`.
> > > >
> > > > Perhaps. I'd prefer to land the simpler change as-is.
> > >
> > > Well.. I guess the dummy handler approach would be simpler and perfor=
m
> > > better. :)
> > >
> > > Thanks,
> > > Namhyung
> > >
> > >
> > > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > > index d083e2bb770303a4..9fb5447f9014d026 100644
> > > --- a/tools/perf/builtin-sched.c
> > > +++ b/tools/perf/builtin-sched.c
> > > @@ -4955,6 +4955,7 @@ int cmd_sched(int argc, const char **argv)
> > >                 .switch_event       =3D replay_switch_event,
> > >                 .fork_event         =3D replay_fork_event,
> > >         };
> > > +       struct trace_sched_handler stats_ops  =3D {};
> >
> > Oh, because there's an existing null test on the function pointer we
> > don't need dummy functions, which is what I thought you were asking
> > for. I'm still not convinced this is very intention revealing, but if
> > it works for you then you can have my reviewed-by tag.
>
> Applied this and the patch 2 to perf-tools-next, thanks!

Thanks Namhyung. Did this get accidentally dropped? I'm not seeing it
in perf-tools-next.

Ian

> Best regards,
> Namhyung
>
