Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3883C9EFC
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230181; cv=pass; b=T/28yUUu9ztbAoT4iYHwciWCUQezeyzImPO/AVN6epgd3ZsNn5FIIvcW0IYuEVwSz3jp+8flMvLtOdCbHy77neNFDGeBkHVDstYDEpB12+zfkknkSVxf9rPdsjsA2gQaJxfwl8VOAFxF3tGR490IBq1z2dlsZoJzEFYp05k8khA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230181; c=relaxed/simple;
	bh=siNZISg3GNBeJf8yWH9J+JBY1zcpCFCaTKBk6ifXNRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLLBEPAAksY4fm5SCILkTtt6hsgvHPr4n4LT6iDOLY2413H2U6wdvTGsYeFNF14wgUzECpFkRoxPDlp+OBWPB9Zg5vdBfn4dMQxGaNe6y1dSFFgmQx1Vh7XmNClfbdFbHstl1mYmrnAeoAPWUlbM0Ps6Bf/QZ82Gbsa4UM5UQr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKPmav3M; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKPmav3M"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2591757fbso95535ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 08:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775230179; cv=none;
        d=google.com; s=arc-20240605;
        b=lAruAlp0sCSkGvBY6p2i8WVHBx0DNHRdBmi628aNW2CBY/s2Z9vkr6uAnhBZjrtBdg
         cM6MzHSskx8DQ4GsLN8BdlG/sTWzvKYLyHNJB/J6vc1UWVrfN0uuhStXO/KfEWXaaIZe
         HO7AFlvLgaTtvYwX5S0Hpf8FlNbfn7006co0b3PNv5gY5frbazTbk5IuP6K8pqq5KLw+
         3rLoOKg9+W5K7KvjS2Gx1xrDwtJFr377L8PPkXCuskDOLkH/1Ms2oOltQsBYMFL7uuYH
         5qs7JjDucVklf6F11hJuIG4UzYSh+XRP621K5LbQGIRwf6PIydwPQm2/Y6zNFi5bEoEe
         Fphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q13A7NNNhi4HN9nlr+c56u0s/kqqPYR1H9gR5ubc/Uk=;
        fh=o1NxlCps5L6NKvOau9ynRt76VmqsIiaLfMEpezy+UyI=;
        b=c66eLSdg3RZChVkHlYzRY4ndOxYWbtf0wCIE6cbd7F+mBLlV6mVDoEk5iY7y9sYuXD
         JoeWyexQ/0KKf7ZOFcudDctSl0t3EzmX1xiRh7qE4kRzy2+GJWrYMjb/wSRfp1av1ndu
         m3i6qb0OT40x9huQSHgkXzTlVKzoKwiZ7+3+ZjWsmlkqtmTkwo/jEQ2lFObqLlE7M67G
         vuQlflxQJIsnKmv0rj6O4Qv+zFPcixl4e9ctxvssPd1x8SSuN38evfJ/xbqxZBVKpo6B
         1UHRBu/0KYY4dNGiYKCaVAB55bIEFzfe20aryKMJXM/ro5nIUR9kRvU4vYU2fpZnCdxj
         +KEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775230179; x=1775834979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q13A7NNNhi4HN9nlr+c56u0s/kqqPYR1H9gR5ubc/Uk=;
        b=CKPmav3MNw3TPgw3lPjAwkOx0pKFjVO2mRuJSTjMeNabXIGtQSs4lJZIXX1FI5AiUl
         Nl00W5qcZh9xqBMuHCYaxxZ+2n75yzlNdStRHBRIViCUqpPg0ciB8mE1DtN0Q1JE0oJx
         qYzLkLGMPiIw3pazpLnpnjvrfQbQJxN4jWrQuhNHWwdIV2naROrVgnAHBXEtT3IbV121
         nRundXbbiJVlbXfa6OSgOqDsHOwLRmIRXryyPfpyOWvTOw6JGEnYYNDmWzIS4qEa2x80
         DkRhKfuoVxk4eyedG894Ul4T5OI1SRgYjiqFCKnSj9halMPpWAZ83hhDNHcSFIpX+SZK
         gNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230179; x=1775834979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q13A7NNNhi4HN9nlr+c56u0s/kqqPYR1H9gR5ubc/Uk=;
        b=WMdboVzRbsuUAFyNEplPU3pY0/8gF3waXz+ax4ObYDFqJc0xB+uTZd088f0QZmnsiq
         Znfz8mELS4wyEfgn5Sm0trXkaiNXny9Fb/XZsJ/RKR1+/79sp58uBvErGTQ9FsmcJNtF
         X+oikZgRhrBFCVFXh1VlWJj9xFIrnlW6+qEdESl9cbqQaQA5MBthL59YAYmTZvV7F1yi
         VlqD2Rb/uxWryKqx/NXQY8D+WBFM9VskM50s67TKp6FGwsqQx6x4fbbcfo18NFIVfvgW
         N7wcObFsUiHcEFWD46jWZcXvlcJnh6LfnlXL8jDx2l1N1RRgL2UdwONGEc3eaqWsaPKR
         iGVg==
X-Forwarded-Encrypted: i=1; AJvYcCUlDzzKeYjRlWtIl/rQ4pyXVSC9r22YZNM1A0lGUvzM2jP8QqBEJCuaBJxkrGHKY6eJHWmxIMRQJuinfcR5hRcw@vger.kernel.org
X-Gm-Message-State: AOJu0YxlP/J6D8EsI7GsT9EEFV2sD2Seed0SJNKFm4hHVCtRn6o6y43k
	dIiqJ78ltfEzTKjPyCZG/UXiOhh3Q6CWBO1pHX9YWfPy2hSVtqGBEzRhZhlw0W5xFtetA4Df51S
	+iEISUoojPEzbiVmdlI9s/FOMz+RZtoi3VJsHG6Mb
X-Gm-Gg: AeBDievgy0Es8Q7XZvukArFU6Rx5GQg2EhCuOsnWLKvFUgII3/lppdUXg6NF08+S8KJ
	6DdKCvK5PYi/wnyqgj0I3WkwnqjXRRpdTXCVyvrc4dmv+Qn9OVwwCopku1dgBETPhHHbW4zVP9Z
	Hw5Dv4uTpJlfPguMgAU7KL62vumqtjI2+2YLNihBZFldrLqsufBQTN86znzorUbYzfHxiv9vfB1
	zeaNdj/Qg3TwTnIh3Uk5b/PjFV0DhJZ4QK3ZpLveMg0+4+Rgq0rDWQS3eTfrMzHX1MLWndBopeC
	N7TPNgqQ
X-Received: by 2002:a17:903:17c8:b0:2b0:aee4:afe7 with SMTP id
 d9443c01a7336-2b282f4b9a3mr2296925ad.10.1775230178573; Fri, 03 Apr 2026
 08:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321061448.810525-1-irogers@google.com> <acW_IHQVZnxIETdd@google.com>
 <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com> <ac8pEDUKjuMxXUS6@google.com>
In-Reply-To: <ac8pEDUKjuMxXUS6@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Apr 2026 08:29:25 -0700
X-Gm-Features: AQROBzCaXvfhEtVBIBohPAapfAo-yUd_76AjU-BmVwJsogZ_IfmcHOU7XgJNOsQ
Message-ID: <CAP-5=fXeBje03BM8D9q-0KsXg2KmyRa81CuphtSQfHp0isFc_w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 7:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Mar 31, 2026 at 10:59:52PM -0700, Ian Rogers wrote:
> > On Thu, Mar 26, 2026 at 4:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> > > > Doing a `perf sched record` then `perf sched stats report` crashes =
as
> > > > the tp_handler isn't set. Add extra checks that tp_handler is set
> > > > before accessing through it.
> > >
> > > Oh.. unintended use case. :)  Probably better to add a dummy handler
> > > for `perf sched stats report`.
> >
> > Perhaps. I'd prefer to land the simpler change as-is.
>
> Well.. I guess the dummy handler approach would be simpler and perform
> better. :)
>
> Thanks,
> Namhyung
>
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index d083e2bb770303a4..9fb5447f9014d026 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4955,6 +4955,7 @@ int cmd_sched(int argc, const char **argv)
>                 .switch_event       =3D replay_switch_event,
>                 .fork_event         =3D replay_fork_event,
>         };
> +       struct trace_sched_handler stats_ops  =3D {};

Oh, because there's an existing null test on the function pointer we
don't need dummy functions, which is what I thought you were asking
for. I'm still not convinced this is very intention revealing, but if
it works for you then you can have my reviewed-by tag.

Thanks,
Ian

>         int ret;
>
>         perf_tool__init(&sched.tool, /*ordered_events=3D*/true);
> @@ -5037,6 +5038,7 @@ int cmd_sched(int argc, const char **argv)
>         } else if (!strcmp(argv[0], "stats")) {
>                 const char *const stats_subcommands[] =3D {"record", "rep=
ort", NULL};
>
> +               sched.tp_handler =3D &stats_ops;
>                 argc =3D parse_options_subcommand(argc, argv, stats_optio=
ns,
>                                                 stats_subcommands,
>                                                 stats_usage,
>
