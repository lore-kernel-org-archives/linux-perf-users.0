Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273C1A6806
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789942; cv=pass; b=ekFu0AYz8tQQlBANzLc4THo4SNuZv/O5tqsGrFR89oYKj94k11GRSH6QfYH38F5QexIAVuSj41jYz3kmSyEeFqfuoUXiHUM/BQVh2/mKLjzliWoJ9H73l3wHadOQSsDLyXDi5IefAIbHsCiTT3C4b4hxbNCuLmeqOztDj62ZtMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789942; c=relaxed/simple;
	bh=/nhB85i3ZyGW/Fa2uSoCQ0COIHxiHrySenMQnnB/q3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kv9ezZ3FeZ8UgURdPCWgBo8CQvO5XNAbvJ3ZFnbTivKLKi+DLym2NNVmCf2y0x9+iVI2OEMKT2RVXKTcJk0SmkKds49l26zTkLxDfV6c7hxRYKaV5sYXtYb1h0OUfgrpwAs3Zf0QGlXt/zdlzCSmEPHJ6HeAOUOfR1zrDaDaNZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWfJZ8sB; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWfJZ8sB"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so17484a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 19:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775789940; cv=none;
        d=google.com; s=arc-20240605;
        b=KCT5HScAUUo+IlteGCo5CPbeX3hAfoUSHOXAxR159kidRhZ1GZ4AvB3vXmAotPnGbR
         e94mhG4BvIvcyRF7v/Glk0Wkch9ckzOWoUyfXtCoPp14qOwmhDK/rIYF8d01cnBQAkjV
         wdHuMIZal6RPPkOCejmXiZ4f4wESRbVE5Qm70UIA9+5DyiHgRt8ZW0N4VE0my2wuzEvp
         teuQXa2qZtJiB5G2ChHnZQTb01mzCR+/IYQ28aSf7h5Ej7VZi1d0hj+KzFT4AHjnFGqL
         JbEkS/3PCghepBZtJ1hxj2EjPYXGLtPCYFiD86lEGwwvsM2u+A9TotD+QPIoMG7rtUkm
         w+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YKVqjxdKG4WXfAgY2+fpLBJPr+KJvfY+b39/7iv7nmU=;
        fh=hYhHvQmfdnJ44Rzs+idHKEKUbfSS/oJf2GB+oK/OJCI=;
        b=CH/Vcoj/Lak1oAh7TJTxQ2nQ3eNXXGx0IMOupWEQbIrOxPss51THEa7VC3rhGNJaeh
         O4vo2oTlbcooDYQ7n9dYBh6ThjzCKZ0njmj1PzFVOBgm8SsOBV+0VPMhNIOJB5RwHBkz
         WIee+3WYLmTKiCRieeFMU7CNoYlUNBzjWDKshzgjq+n6pb2swUqzxgs0c9pC7kHGxvN+
         MuMi04sLdrkf5TKHpZIjs0eO2mlDi7ZqRaQITccXPee4v2vOHZncXx3uB/ruUBEA4h0u
         2j88OINX1+HL+O/4MGWlq01FZTCkNp0igghz7zTQ5iGrjYP0JeG69ylspQjtwljUKkZW
         nLVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775789940; x=1776394740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKVqjxdKG4WXfAgY2+fpLBJPr+KJvfY+b39/7iv7nmU=;
        b=sWfJZ8sBdHH1C207tsZhuhFF99oxij5sC95Xxqp9SzGES229qFjz0mwPbHtSzxo7K8
         IYdSuCjl6yQBeXB1sx/9RekprfMK2nhBlQwhm4cmnq3FJuwvNcrKGGB1NhWVsaKb3F0y
         XKWWJqGbB1ra51G53nCvFy3FDh67/sJ8R09wP7/bCtzVdijknkk4UGmEDIcMgD4DDBnr
         Olr5VwactrAeSha4gnCXiVu1Fmd5AAs4dpDbJlPvOK7/8im600lldqatZCc/jtghNj/t
         ZxNIrcGoYpes4/mImq0k05dkLaZni3FKIdyfpA7zNPHyxLPFT6U+u491bfesmgrMFhaq
         Qo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775789940; x=1776394740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKVqjxdKG4WXfAgY2+fpLBJPr+KJvfY+b39/7iv7nmU=;
        b=WIOxL2hOVXKCF02cOZkicBGvP9/iQylneZGcvCGfHVL12k5WBBzEz8kSwKwXtuQBd9
         3M9Bp3a9NuH18Lp5S3Iv0NpIr4NpzOK9mDcKh7tZqppJDzNdKhYWTDGEEYvJ9Uo1TIgW
         4MFaibDflz6uAzmHelU4b5nU/2UOPpx0JMErg0EiITNcXGbUhzssGBLjW3RYISrKULa6
         wOf3fxicSeEUOKIuyzYHh+MclylcaAF29o+jqu4SQqsRF+i1SpfqiG68/xZX/7Dp8Q+I
         4kORf8LfikG5b/BSJxkWJlRMdiesxlok7STbuswqgQ1HvEOFzRhKbZLD/lzgrMu436Fv
         beWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXQtr6E/09ppXy7tuC0Jzp+aYxG6czUSJuQDhdICEl8JqQhFAzOCyGk2V441jYhsn5vRk0+rx9a+o+SkaBT+Yq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3TOj7oe0/u/qL42e12Tkwe82ewlNI9RB5sifCvibHJPuJGkbS
	Tvmo65hQlRCMan/U3KPE8ZYvjbAE9Obvi0SkZ8Bg8b4x8ueKcnsA73l45MWueHXnsHAS0y7yn/x
	ym5zghpFaScDYsZtf+UZtL92EVV4B42wq39Vxc9Co
X-Gm-Gg: AeBDiesB31K1Z7syUeDmOfOon+EpF8rlxcI8vEoJvlXJjdSjIx9AkkqR6X6E6netGWZ
	H/XUwmDLtv28+nCQD6cUIhH6lzubJ6bjvck1k3QEuIlAoiVrobochho/yccF09+Ac7ao3de1gRt
	0LzeHgc0es6qaMpiPbHElPkNk/wazyY4/Cdh35kkUlFa507Lr5KnD51nmkGK4bEgzkrYUL3HGxx
	Aeel84pQ9nGoG6VXGfakuINZCaf8es86Nl4OrQNXRil7I78qSXG2sMnapAVK6B81QPUzfN9dRbz
	3ERZ6/PF+OsAHb484A==
X-Received: by 2002:a05:6402:534d:20b0:66f:a171:b9c0 with SMTP id
 4fb4d7f45d1cf-6700fe9740fmr72153a12.2.1775789939252; Thu, 09 Apr 2026
 19:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320152928.1916447-1-jmattson@google.com> <CALMp9eQh37Mxb3qvFWnYNTUiUBdSnRMsPdqgMdQD3XpC1HOs+w@mail.gmail.com>
 <3824da20-f3e5-4db2-bfb8-b49d57ed38cc@linux.intel.com>
In-Reply-To: <3824da20-f3e5-4db2-bfb8-b49d57ed38cc@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Apr 2026 19:58:47 -0700
X-Gm-Features: AQROBzAQg93JqkKQgcRPzQXWXfxTcrq33ko_FqMlfxJOJrMuQW12Az-RBb1p398
Message-ID: <CALMp9eQxk80rfkUSXHYhnNCC_gqpSjEaO3iOiSm8ZcV=zPWPAw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Don't update PEBS_ENABLE MSR in NMI context
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 7:24=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 3/21/2026 2:58 AM, Jim Mattson wrote:
> > On Fri, Mar 20, 2026 at 8:29=E2=80=AFAM Jim Mattson <jmattson@google.co=
m> wrote:
> >> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> >> index 5027afc97b65..852baf6a05e9 100644
> >> --- a/arch/x86/events/intel/ds.c
> >> +++ b/arch/x86/events/intel/ds.c
> >> @@ -1982,8 +1982,10 @@ void intel_pmu_pebs_enable_all(void)
> >>  {
> >>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> >>
> >> -       if (cpuc->pebs_enabled)
> >> +       if (cpuc->pebs_enabled || cpuc->pebs_stale)
> >>                 wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> >> +
> >> +       cpuc->pebs_stale =3D false;
>
> Sashiko comments
>
> "
>
> Can this race with an NMI?
> If a PMI fires exactly between wrmsrq() and cpuc->pebs_stale =3D false:
> CPU0
> intel_pmu_pebs_enable_all()
>     wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>
>     <--- NMI (PMI) fires here
>     handle_pmi_common()
>         ... throttles event ...
>         cpuc->pebs_stale =3D true;
>     <--- NMI returns
>
>     cpuc->pebs_stale =3D false;
> Would this clobber the pebs_stale flag set by the NMI, leaving the softwa=
re
> state desynchronized from the hardware MSR and potentially causing the PM=
U
> to skip the MSR update on the next enable?
>
> "
>
> It looks reasonable.
> https://sashiko.dev/#/patchset/20260320152928.1916447-1-jmattson%40google=
.com
>
> Thanks.

I believe this function is only called while the PMU is disabled (on
the path to re-enabling it), so there should be no PMIs.

Sadly, though, this patch has not fixed our problem.
