Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D209377ED7
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=38.105.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704743; cv=fail; b=eBBLUmGHkdqPzsRb0Pmq0KXQp9sC71u4XsOKRfRYh3+ANj0Ay8GvLTa64mfh2v8BNPzs/sWt33iC2VNs6RswwlgsArS/a8uu2CLacoEZqlBO1QsGHZK/ifaThzjhbg7h6YP4tbSr2/o+yWCfo5EYOTAWwRWgTTbFvTC64b6khpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704743; c=relaxed/simple;
	bh=FurJ5l6HDIh1sM/YPxaYNuKIpjU05pOZGGUjSPVy6Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIUv0V9hIRzmpeLYuHYgk0aj9wR54mUyD+v/BrX4lHq/lT/2Nqu/oAqWao9bO9gKumgHiyzNJvog0VL2/LzVcl2ve+3HR8TPVPuQVQa5vxxeeXSjHx+R5QCa5XR+RJQGY+/L3O52j7HgVp6/7stg2cOhPb9nFXHqNi6PunJoVF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=G75HzJHZ; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=btKCGcwd; arc=fail smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="G75HzJHZ";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="btKCGcwd"
Received: from mail-oa1-f72.google.com ([209.85.160.72])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.1)
 	id 1vy5OV-0000000BVZY-0G6F
 	for linux-perf-users@vger.kernel.org;
 	Thu, 05 Mar 2026 04:53:23 -0500
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-40f04a08234so9719312fac.0
         for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 01:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772704402; cv=none;
         d=google.com; s=arc-20240605;
         b=bNvjB+nHpD46GnQNVW9FaICFvnCIpj8Wp3dWryxiKAbl+njpKzVW8HhQ9XpXRBO0Kf
          xTYMtDC6kt4BKUSWDdNIxoquCJyILdWDd9KmU/v6Dt898uVHTdsXYIxykUcpfJTfMoID
          zNbKJFpOTIz3RTNUS8g2gaSYfCT3g0S8tGUReD+tIU7SrW7ibVQ1QXow5hcL18Mf7B/3
          SuPx5Kcfx2JoN/3wLz/jCzcs89kegqXlt9RYR+ErFFTTbdrcqNh46jrvP0Yu2cxXzKmL
          7MFLdkSjMqfojo4l/w0jAOqrQvL3eMashzATWWK/6SyMs6esWpcAHgVfp/1m6Rcm9QSV
          0rnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:dkim-signature;
         bh=ob2c1uAHRY3fkqiPurC7Qw0TY2b4yQyOCXWP+9awDQc=;
         fh=k8JFStkxjkVLhJmAArOidd2FUxQywXuHbBe6WUovluM=;
         b=kmOEdDe2miaJ1EAcGK8Tyruo1mm7YsfMKdo2j08KpnhceqOkt85icsMg/wRpkxt+9F
          3WUGH2zOgUCjfSxU8LSTFcBhekPjsTZAYi1zD53qSKH9PS7fVfIC6p2sbq8lsaFACb8H
          s7gQE9TPsI2+Pi+kUWVttJgiIr6x6IJhD9g/jQ23f5PLi1fsFTCZgjCQmd1CED+aYYtk
          zoq48NShdtZ7ZZJnFs1leZtXOkvYf+KJ+TSDx63e+IHrsT08b3gkelOtYcq44ATJsNwW
          X92E8L4EwPmKmZWSgFJppsfj3tdKAZhhNt8eisO55HhxsMwcfSTX90xoP6tMKiauykEl
          y72w==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1772704402; x=1773309202; darn=vger.kernel.org;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=ob2c1uAHRY3fkqiPurC7Qw0TY2b4yQyOCXWP+9awDQc=;
         b=G75HzJHZHf8nURhTWd77iC73YhLcF8vzxKGWwG62K3iWCicyi4A/y7RTdbd02dfiqe
          S5Qck5U2LWSHTcahvpf3r/7kKyKIrO+OqiiVQGIt8jrACH2PiRazyDkbF9oW4GHlIKXm
          VGxY0FiaO3VHltoyg+JdLoq6uMTukldMC7ff0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1772704403;
  bh=ob2c1uAHRY3fkqiPurC7Qw0TY2b4yQyOCXWP+9awDQc=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=btKCGcwde5/bfGsjxOrEYmbj+b7bmOmfwUDEKUrzAugUzAHz8CYwbzA0WbmT4odo2
  NCzYDamWHBqJDKyCCB35Y21srThL/vtMMwvVi0sZCCGP6NDcIvo4XN6YcfJsSi0tqP
  2h2Sjwnp39+DHgv0mZFY75M1YzFWlvxdFjyxW4Qf/Cya22F4E3h5fULO4/h3MLuySU
  Of41ZZasWGtyTn7EeBlr27xqV3fEwI0TB4/SD4M3DtkGxHnKc1pOsJAadbrScEfttQ
  hrRsKIKOFZ5Vv50HU0rQJXkclnL/SXDolKZEurxirzAjhpSNAgz9aBKUIwTpxAdQWU
  iZQrAIoRIZWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20230601; t=1772704402; x=1773309202;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
          :to:cc:subject:date:message-id:reply-to;
         bh=ob2c1uAHRY3fkqiPurC7Qw0TY2b4yQyOCXWP+9awDQc=;
         b=OOu9A65kl2F5MariupwJUR8N3aagmytJoi33HChkeD4DDskJ0SyU0NlohCplsCEpRn
          oHWXb8WhEh27gHYmir/Rl3T8dCMw5PquSnWAsUQ8ApTNVcy8uJWRwecDsS63pn1Q04on
          OmLjahnnuWCCOG6kANGGfWt4kqd5VRdUz8chS8eMktdXZENQM4O2VqZ+8rJxFJ4ODBNq
          jxMGEVAVyuc08n68BERyQyHDQugAiD6RdRTfN1t/mka1agl7QvYB70AX+OddTAK0fbAp
          Bl2rAbnJNL7EyQfHLnXcJ2nm8afaOEUGf+25/r5+alSlY6uSA6K28llo9as7Un0L1p1D
          2Ueg==
X-Gm-Message-State: AOJu0YxunESJr1NE5IPHojUmFR1QOBisadaDq9goXEKWWTIqea5+eOpw
 	nguxsjzKnlBwP+r9G2UBmmjozomvCG8hvIAD9pTRKgPYuhLWdEBzubJcKSIlLfqefWDc8hO/ZFD
 	hSQYXJfxQAi2NRnQVxj2p8k7hEWTO/Nimw9tkHHEsicAi3DrPC5Du5kxG3aCsJpw7V466lnfqG5
 	krtXTVvcC8bjt+cQnsS/DHjZUGF3fl4lACwaJ9ENfGfZ+Ep+Zyr9T9X1G6+ojK
X-Gm-Gg: ATEYQzyEvwsg+jHd4617+DvIcf4wLONvrcb3GjfGJZzGSvaoqUwKIa3LBJyOlYbCeXg
 	1QW2FxnQsV527dQNtEHM28b/VMqZsigl5KXnasmMQLA6M2jFiTk2kQcwR3NO+mQ5W4eWCeuh5mY
 	cxxqQMM5QeDaj4OWZe9mWd81RxeH5b3ynh5E11JTWoEM1EOLLfVVWo5+y4hITfV7Gx7INF6O8do
 	c0e
X-Received: by 2002:a05:6820:1896:b0:663:22b:1486 with SMTP id 006d021491bc7-67b1775fa0dmr2822868eaf.41.1772704402250;
         Thu, 05 Mar 2026 01:53:22 -0800 (PST)
X-Received: by 2002:a05:6820:1896:b0:663:22b:1486 with SMTP id
  006d021491bc7-67b1775fa0dmr2822859eaf.41.1772704401864; Thu, 05 Mar 2026
  01:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOS8N5C+gSubTGww4Fcom9_+OTFTyBPnoBkt-YnG+Nti6F4GmA@mail.gmail.com>
  <CAP-5=fUEO7Af1LQNjoLTaiZcXQVbi19obAK_dGj=fShLYm-XiA@mail.gmail.com>
In-Reply-To: <CAP-5=fUEO7Af1LQNjoLTaiZcXQVbi19obAK_dGj=fShLYm-XiA@mail.gmail.com>
From: Andrew Hunter <ahunter@janestreet.com>
Date: Thu, 5 Mar 2026 17:53:10 +0800
X-Gm-Features: AaiRm53BFwES47252EVYXYw6h0pzk1BKU_d17DlzdCKMiF0NV_da72kWQIYTnyQ
Message-ID: <CAOS8N5DcEDYz+Zq7UcFvj1KSyH6UnFk4i72Ta87+U=KoUNcELQ@mail.gmail.com>
Subject: Re: potential bug -- ignoring frequency for Intel hardware events?
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey, Ian, thanks for the thoughts.

On Thu, Mar 5, 2026 at 1:42=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
> Mixing the options I think is messy and broken in some cases. However,
> in this case I think the period that gets set is overriden here:
> https://github.com/torvalds/linux/blob/master/tools/perf/util/evsel.c#L15=
37
> ```
> /*
> * We default some events to have a default interval. But keep
> * it a weak assumption overridable by the user.
> */
> if ((evsel->is_libpfm_event && !attr->sample_period) ||
>     (!evsel->is_libpfm_event && (!attr->sample_period ||
> opts->user_freq !=3D UINT_MAX ||
> opts->user_interval !=3D ULLONG_MAX)))
> evsel__set_default_freq_period(opts, attr);
> ```
>

Yeah, I agree I think this is the direct effect of passing `-F/-c`.

Notably, this happens _before_  evsel__apply_config_terms, where we
apply period/freq modifiers; however, as I mentioned, that application
tries (I think incorrectly) to notice if we've already set those
flags.



> > The other surprising thing I noticed is that the same logic appears to
> > stomp on modifiers passed directly to the event.  For example if I
> > run:
> >
> > $  perf record -vv  -e br_inst_retired.all_branches/period=3D2000/
> > /bin/ls  2>&1 | head -n 100
> > Using CPUID GenuineIntel-6-8F-8
> > Attempt to add: cpu/period=3D0x7d0,br_inst_retired.all_branches/
> > ..after resolving event: cpu/period=3D0x7d0,event=3D0xc4,period=3D0x61a=
89/
> > br_inst_retired.all_branches -> cpu/period=3D0x7d0,br_inst_retired.all_=
branches/
> > DEBUGINFOD_URLS=3D
> > Lowering default frequency rate from 4000 to 2000.
> > Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
> > nr_cblocks: 0
> > affinity: SYS
> > mmap flush: 1
> > comp level: 0
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             4 (cpu)
> >   size                             136
> >   config                           0xc4 (branch-instructions)
> >   { sample_period, sample_freq }   400009
> >
> > This I'm less confident of the fix for, but thought I'd mention.  My
> > best guess is from this line:
> >
> > > ..after resolving event: cpu/period=3D0x7d0,event=3D0xc4,period=3D0x6=
1a89/
> >
> > which suggests that the event definition appended a period, and the
> > later one is stomping on the former one.
>
> Events can have a period in their json definition, for
> br_inst_retired.all_branches is here:
> https://github.com/torvalds/linux/blob/master/tools/perf/pmu-events/arch/=
x86/sapphirerapids/pipeline.json#L66
> ```
>     {
>         "BriefDescription": "All branch instructions retired.",
>         "Counter": "0,1,2,3,4,5,6,7",
>         "EventCode": "0xc4",
>         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
>         "PublicDescription": "Counts all branch instructions retired.
> Available PDIST counters: 0",
>         "SampleAfterValue": "400009"
>     },
> ```

Yeah, I agree that this is causing perf to believe there's a config
term with PERIOD in it.


> I'm not clear on the sys_perf_event_open output data which suggests
> you are in period mode but the warnings mention frequency mode:
> https://github.com/torvalds/linux/blob/master/tools/perf/util/record.c#L2=
06
>

I think this is orthogonal; it's just a warning about the choice of
-F.  I didn't pass either -c or -F here, and `perf record` then sets
.freq=3D4000.


> > My questions for perf maintainers / people who know this better:
> >
> > - should the EVSEL__CONFIG_TERM_{PERIOD,FREQ} terms check for both
> > user_interval and user_freq, or am I missing a reason that this is
> > intentional?
>
> I think there was an attempt to keep the parsing simple and then override=
 later.
>
> The json data should always be "weak" and overridden by the command
> line arguments.
>
> It could well be a bug :-) Thanks for digging into things!
>

OK, glad I'm not missing thing.  To summarize, there are three ways we
could specify a period or a frequency:

1) from the event definition out of json/similar
2) on the command line flags affecting all events, (i.e. -c and -F.)
3) as a modifier passed in (-e foo/period=3D12345/).

I believe that if more than one of these choices is specified, we
should pick 3) over 2) over 1), do you agree?  This seems like the
cleanest UI, and also matches some comments.

I haven't attempted to write the patch yet, but what I'd propose is to
delete the initialization here:
https://github.com/torvalds/linux/blob/master/tools/perf/util/evsel.c#L1537

and also the conditional on user_interval/freq here:
https://github.com/torvalds/linux/blob/master/tools/perf/util/evsel.c#L1189

Then, I'd attempt to arrange it so that we have evsel_config_term for
each of 1, 2, and 3) _in that order_ (so they override correctly.)

Does this seem like a reasonable patch to attempt?

THe one thing I'm not sure about is the `weak` attribute on terms,
which I'm having some difficulty tracing where we do and don't set.
As you say I think the intention is for that to mean "overridable" but
I'm not sure this is working well--what do you think?

Thanks!
