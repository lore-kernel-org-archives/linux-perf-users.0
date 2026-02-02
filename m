Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650714EC73
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Feb 2026 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769997357; cv=pass; b=tPBJdF5dbu63bxpXNBI/zzX0gXYwT4KyN2c1YZMGUuaknQo46uM5fMGLfSYM/lA7solzC69x81NYGv+vAQD2vYIWfMh/q+oyMQn401SGml4U1JC2nyUUGwY/HDQIVIelchdSacJ4ZRDJ8XI0Wi6fDjkW3ZOv0WAh5M8CvW7r1l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769997357; c=relaxed/simple;
	bh=37KY4Dvwd8SXMXHv7Hvv2vmtD7WX/uUuzGaEqb1gdOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smR5nCh/YXM0nkta86QdQ+ML8dzcJHr/w33FgMVpvkEVdnFNL19LXwkWR5wGWs1N1QQNUEOkldvo9Y2CeG8aUYTehbgQSkBrYsGHJygCmjpIPKi3/8gDYgXLNw+3kPI0NYUYrjdIwvokpO54I6hqQlAJVguU11mq5ip6ptofjgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1r2ORHz; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1r2ORHz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a76b39587aso109025ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Feb 2026 17:55:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769997355; cv=none;
        d=google.com; s=arc-20240605;
        b=awkc/yQod4MKrMpf4mPeJiQLs22+wIRwbYafg5eFAya4Vn7LAAUSEQMTF5+Ss1wUS9
         6Ynsc7gNnVhbGnxkdq+6bwzMPYsO+gk8jgZUhSMEU8wEfE6MKZcUjqxv+pBmjnWHsuxs
         nMl7pgGBxkUeUgsgm89WqHSDA9QOV+2fbXJVQ7lIICkIgqO8ihng0mTWSM9nLlE5KJ+9
         cS1ALEQmoSOT7akGZw96eseUbaBz2qba6GRRSwLX7IHq8b/6EekJk5vhhRpQkUiD9FH8
         RH3a/Pti4Wvu+ggLDOX9MpK+YO/LVH5We6PcelGZc9Oxi+5An5hyLrIXCTGBTqS47U9K
         +wEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zKMyhwj1CFOlY+qo9L/Ll46UsMAktS3TMkFqPphW4YM=;
        fh=1ra25f2ND/I7gl64t9rEgTBUU6/meWFH4Yrvf1TEslI=;
        b=dedhuCslbIXIOS1LDSp0hHEfSHoAwfKc7Bytxt7At14oxcsk0DwwjIHHu5eCtWAmfq
         l2iiOqkIrrUNdoDUBNYr12GZQdhSBBhOxxVZvdlMMuf8LRDm9ccgvuglAIYIIfe3ajSE
         z+OZdNIDgLsrTNMfkJ9RpMb7VK10hODDloS9+CXnd54uiXYqoEw81IV9DJMKgoHgq6GJ
         XYbsqE30+FUS4odQv/afYsKNW0Dejm/qUAuTa4F89qbETzCZ65WQwNrcto/GPqqeQN9K
         THk4wjz7RmWBaU2t4yrqYY+IU1y4EalJ6FaN8LIgtpabc0Zp5Cy7a/DvvJ9RJ2LTX1eZ
         lGIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769997355; x=1770602155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKMyhwj1CFOlY+qo9L/Ll46UsMAktS3TMkFqPphW4YM=;
        b=W1r2ORHzdOJQQfnMrM+PaqRqQH1WlnSe7v1n9eMbyRK06OW9uKfs+vejUbVcXe/qnF
         xjLAJKcXrq/IlVNjUX5amuOh2oMJsRCy54nOhgOlHPBsKwFaOA0StwlRg6TY0Hzl7m7G
         2A3RQrwi44SeTexmKSsL9LSy+JQc2kMYcNkW1tm52KOpnaWe5pXcWgLB004pFJAYEfSL
         LUGGjHmtHsPPYsEAx5XbJOFEtUaID2OHOqvLHo4Pxs5y2kPYr3DHgoKI00oaibdGj453
         HvGz1CmY1gm5t7ObM9L+T+YKnW2QuB8hDzZvqgYCpNu82ru8UwV5EfuJN6b8bbBauETg
         5zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769997355; x=1770602155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKMyhwj1CFOlY+qo9L/Ll46UsMAktS3TMkFqPphW4YM=;
        b=GDraiHL9/dtjRMDehP3ycZo8nwfQ8ZyQf/NGhw02I0fq0BHfVMfI5hjT1AGu5CEBLF
         oPCIMwjW/3cf84a13ucrYfluYrZXDGuisyUwxt+BJxNiMls/z6ITEBBRoruFAO6zaqV4
         Z7vwefvtDUjcK3SU5bqtS9Wfr0lM3zDLhsNUg6e+EqoALb2MgFb0hdMZtp/eBxAbU9O1
         +/vUg55FNm2Nx2ljHw8nCybyYAAX4ZfSRBOsJClKvpifYyyDb34TsRdMSxSOEri4rgy8
         ROvbxItiXanmyp8RPxmNxIP6MGjN2eh/TGL+2Qhh6DhGuopLPrOxOB8MocCREmpK3Xhg
         kaHw==
X-Forwarded-Encrypted: i=1; AJvYcCVXmhIQoEW/3zlQJ+1rAuV3tV7LVfEqnDFNZ0md8qAmklZSbyLwI7wp1jGi1qNt03vocA6/hlAbDWIjxeoORpvW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5UnYkcd0joUPIx56WOAwWNOlGQ1ErcDTDIb10icFjvYrj80HB
	beFT/55HR3PG16mc4JR45Z+MhTqsueQf/b/zFqvn9tioQkjBpuQvekytqs8S1nS/SMhBPJs7Y/t
	bXpQB7HbNVj3ROoS0kkd+9eKJcqfmYbQr+pASmm9q
X-Gm-Gg: AZuq6aKn4xLHPUpD0UxebCRLwCyLXOJ+nTPBGMTdY+OdnMdkFXzzb9JzGdMvFjnQWza
	N+XwjdITfvgo6MKtDekvOByzcllJdyFmdxT9Et/tRrlqPaeU6wyEevD7Uh0yg1Ygeh/tz43rr1m
	lYOFtXVC3CltLGC/+WnqiX5ZzN3jY6540QHU9LZM+SsMprnDmnDNV8gzB1kPYLBDoBMOG2pAXsQ
	NhKjBYkvhboUim35Sk8zeun8EPmR35UA5l5sz+fKmckOt+Fzq+O3kGKeEsd8lmDuhryNb+s4kh9
	54DgLGbwEjZ/DLlP+GnX9QDjCg==
X-Received: by 2002:a17:903:1b46:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-2a8f508a028mr1388475ad.5.1769997354552; Sun, 01 Feb 2026
 17:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131200224.1296136-1-irogers@google.com> <20260131200224.1296136-3-irogers@google.com>
 <20260201170459.GA584@debian-dev>
In-Reply-To: <20260201170459.GA584@debian-dev>
From: Ian Rogers <irogers@google.com>
Date: Sun, 1 Feb 2026 17:55:43 -0800
X-Gm-Features: AZwV_Qhcem8Bk7pzFsCUDa55vlzfQf_z4Xlvnl5l4tr16HwWCArY51n37Nz_Lv8
Message-ID: <CAP-5=fXedkNLSWXVRJy7SDknx3Mb+BqUHPf7Oo7JSHshgoJ0qQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] perf kvm stat: Remove use of the arch directory
To: Leo Yan <leo.yan@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, Yunseong Kim <ysk@kzalloc.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Blake Jones <blakejones@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 9:05=E2=80=AFAM Leo Yan <leo.yan@linux.dev> wrote:
>
> On Sat, Jan 31, 2026 at 12:02:20PM -0800, Ian Rogers wrote:
>
> [...]
>
> > @@ -1666,7 +1661,7 @@ kvm_events_record(struct perf_kvm_stat *kvm, int =
argc, const char **argv)
> >               return ret;
> >       }
> >
> > -     for (events_tp =3D kvm_events_tp; *events_tp; events_tp++)
> > +     for (events_tp =3D kvm_events_tp(); *events_tp; events_tp++)
> >               events_tp_size++;
> >
> >       rec_argc =3D ARRAY_SIZE(record_args) + argc + 2 +
> > @@ -1681,7 +1676,7 @@ kvm_events_record(struct perf_kvm_stat *kvm, int =
argc, const char **argv)
> >
> >       for (j =3D 0; j < events_tp_size; j++) {
> >               rec_argv[i++] =3D STRDUP_FAIL_EXIT("-e");
> > -             rec_argv[i++] =3D STRDUP_FAIL_EXIT(kvm_events_tp[j]);
> > +             rec_argv[i++] =3D STRDUP_FAIL_EXIT(kvm_events_tp()[j]);
> >       }
>
> Nitpick: we can assign reuse events_tp throughout the
> kvm_events_record().  Something like:
>
>   events_tp =3D kvm_events_tp();
>   for (j =3D 0; events_tp[j]; j++)
>        events_tp_size++;
>
>   ...
>
>   for (j =3D 0; j < events_tp_size; j++) {
>        rec_argv[i++] =3D STRDUP_FAIL_EXIT("-e");
>        rec_argv[i++] =3D STRDUP_FAIL_EXIT(events_tp[j]);
>   }
>
> [...]
>
> > +int setup_kvm_events_tp(struct perf_kvm_stat *kvm)
> > +{
> > +     switch (EM_HOST) {
> > +     case EM_PPC:
> > +     case EM_PPC64:
> > +             return __setup_kvm_events_tp_powerpc(kvm);
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
> > +{
> > +     switch (EM_HOST) {
> > +     case EM_AARCH64:
> > +             return __cpu_isa_init_arm64(kvm);
> > +     case EM_LOONGARCH:
> > +             return __cpu_isa_init_loongarch(kvm);
> > +     case EM_PPC:
> > +     case EM_PPC64:
> > +             return __cpu_isa_init_powerpc(kvm);
> > +     case EM_RISCV:
> > +             return __cpu_isa_init_riscv(kvm);
> > +     case EM_S390:
> > +             return __cpu_isa_init_s390(kvm, cpuid);
> > +     case EM_X86_64:
> > +     case EM_386:
> > +             return __cpu_isa_init_x86(kvm, cpuid);
> > +     default:
> > +             pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
> > +             return -1;
> > +     }
> > +}
>
> For a general solution, I'd prefer to use "install" + callback methods
> rather than the opened code.  E.g., each arch installs a structure
> with callbacks:
>
>   struct kvm_stat_arch kvm_stat_aarch64 {
>       .setup_events_tp =3D NULL;
>       .cpu_isa_init    =3D __cpu_isa_init_arm64;
>       ...
>   };
>
> Then at the init phase, we can install arch's structure:
>
>   switch (EM_HOST) {
>   case EM_AARCH64:
>       kvm_stat_arch_init(&kvm_stat_aarch64);
>       break;
>   ...
>   }
>
> Afterwards, it is no need to check EM_HOST anymore, it can simply
> invoke the arch's callback:
>
>   int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
>   {
>       if (!arch_kvm_stat || !arch_kvm_stat->cpu_isa_init)
>           return -1;
>
>       return arch_kvm_stat->cpu_isa_init(kvm, cpuid);
>   }
>
> As a result, we can avoid spreading "switch (EM_HOST)" everywhere.

So the use of switch(EM_HOST) is to just show the equivalence between
the before and after code. The EM_HOST has become an e_machine read
from the session/env by the end of the series. I agree there is naming
clean up, etc. that can be done to the kvm_stat code but I just wanted
to focus the series on the removal of the arch directory by way of
switching to using the e_machine value.

Thanks,
Ian

> Thanks,
> Leo
>
