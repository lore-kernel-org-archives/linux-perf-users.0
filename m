Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD91C84BB
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Jan 2026 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767490084; cv=pass; b=KY9trO+FVdWKk5WG3V2VzKNr1IpRQit2AFWOsdsL7ha2er8VCJJizAy7tGXQRlRZzKmjeVbNfMF/n4CkiJn8ij7H/DSfKr80fwqCH9tjJq3aZzyj+u68Be/O11EasDpCwkKeyJDcioNZ+lAszuiBEh6MthT5PsjH74H+o1Mg+nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767490084; c=relaxed/simple;
	bh=mk6XYP+qYyyrw5pRhi4f6d+XKyqffL/UvS4FrhIp04k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wy1rbI/3hxc5wXyWF1aD+qAdYfHgvDOstFkBBWKb5/dln4vv4y6mkAkKgN4LJVHqdr2SRz9KVkkPOj7VgywUGuUfa7XlqFAuJSPfOj4oO3reWt4NSjmYsMzDH7Wj/c5buPJRkhXvyMlk5wDt1zL1CmCy0R44zIs0eMgfleRcIIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTk4Vsd+; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTk4Vsd+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d06cfa93so81615ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Jan 2026 17:28:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767490082; cv=none;
        d=google.com; s=arc-20240605;
        b=Ev4YakSbwGOFcq7ZO4pRxe8jtXkXzlpx06qp9IaEXNCntf/9czGrGO0VwlRCdfEGSa
         VXemMuiooNirGPL8QdS1IbqQizMi699JPc9MfePS4E8o8feJoqF/8lMZpb3sWq9/XKNx
         MdbZ2FmlRBku587rBVC4LnNLNgUK55GbsO2Dd7bGVJ7WXOUtAOECdClL1Dl6CQDA4zlK
         4bEkVfQd9KTY/hR6xRU2VnUNMiJqWoKjNXHyP5UheJIhlQ4z91QQo3k9hfEPa/XZ7Vg4
         XH+nxn/LtaqCUtlOgvlJ3nXKLg4xBGaUGBGhaVt3xpodxZlt2d7d3VWZ4VzVH118Km4J
         igOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W6D/2JrYUVoSp15zgf9Dc61E217j6/kk7jaW+0mt5Zw=;
        fh=D10UX0MCxzFeRsVEdkMu0NOouCoTDwC58MdqszEJu/Q=;
        b=i2oQVJxBMMG8ebRHnYPfqovkHJH3xFR5uE2Vy7F9Tvk60k0e/iyyQXPskmqOkwBMtH
         ERiPaSr2hX/syfq4Q5B9v9IAFlhFjqsVq9I++1NNpOy9Pw4azGexCnPeEe1rUPE9Ha3c
         N3PC0K6TkX1/cDJk5dv6KkDYoxlDXdi3Kf31ylWsbnop+0zInKQD5fmPhKfa+BYDE0KG
         z49dMA/IYkJE3/krF4f/FBHW9oCvJsqH/N2hjxVRWDHPezlgJgfzWUu1wpOqe0nWlS99
         RW/D1jdL2lMAgKwCcLB5oyNn/KWhgU31fAvbM30oSzL9iA6V5vZRk5snuTQQVUj549UW
         ImzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767490082; x=1768094882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6D/2JrYUVoSp15zgf9Dc61E217j6/kk7jaW+0mt5Zw=;
        b=vTk4Vsd+YYO8YaQDr53ju2Ox502n5Q12MSE/WHgDQX7BZJDXaacLXEUQRQBF667CYX
         cSDeZASM54hN1T1Snk5XdWSqirFNbeHYB/JoopIrnikO6eUE6XXt8bp3e9eKZ3Bz5YXL
         4T0KGuc1tBFaugLghEIOHDoFYc0BP/kgKpUYHsIXWaGqKu32EP5uiLBy6KjzVnEGzLjp
         ssducgSiCJ8SS8hhLnwRFzKDfFHmCalELJCLMqauNFM9HNDm+BIdcE6i6T0Dww8gwVVc
         wivis26KLKYyj1Hk3arnzT9lxKK2e6Ns1nUQNQS1WsUZX9iZ/k8jXUzhb+BpOcduMZDs
         a+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767490082; x=1768094882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6D/2JrYUVoSp15zgf9Dc61E217j6/kk7jaW+0mt5Zw=;
        b=oBPc1Ip2oyseXAYVhqwc2aXh4+dI6+mNwDyivfAbzYFPiObcHofJDwcrBN/f5Y1Kky
         lT1F2uPu5vhUgBSGK7o5Y7xsqaxnLrP+SW0w0r0eMmErOehp4Tw0LMxMte8NJO711w16
         HbUfSV0k85kz4ePDUxrq52uQyFz8PYkq5XiLpbSpILSC+QNZ86dCFH+nDwoRycRUA2TG
         DbHznaAeJHrcUavAVHt002lYl3/SG8BD609ONgmzBcxGFkCtZQYWhEMLMirG71px3/xj
         5U6Id790h1RPyb024Pm5aE5xRvL5jjeNqaG0b6mRsahMtddzZeYrCqyDuAlH+qR3Rdhc
         ijaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7X68xvlckXeRaixWL/eiYqReSE5LFfHFhnqa0vufToyzAchtVEFhCKH7URAGoxwhCsMn4hWxyxYXqMu1D8QX1@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUgLClkjvHjuyCoG6qeMagKMF9K4R53M8KE7Yo1H3EFdIpWzV
	o3HRLDpXd7PPR1pqxT3e5qS9wliQI9JpIEjM7mWIWU8P8yF3BV4oa7x5lX4rwYMOh6h3iCfMcLK
	HiGXRPDqzKubEf0N0iK+4Qsaoe6ry9Vvc2zSuu4IT
X-Gm-Gg: AY/fxX7uSsyPXjKY905Ki1wjkoVMaaPXlRqC4btPHU3QB6kjArgI0MiC0GonAL8uS0v
	c6NMoXXi3Ch2tNNoE8RpgbpckyufTLBa2y9DOOYKWROjmEpmlzYnQp1WAE2dYQlY/u8Ga/ZAGa6
	cLLvRoG/SvJ18YYGy628gonuuaVLg93uyYpPB3eyR3NupUXykMMVjpTCdxdxrudyGGMSC6lW3P0
	uK9gNl1TMsyqlVElIYVj2/KKk7e4OowbtyEPPC3TPVBZ/tOX9CtRoHppMHZaoODhHNYH7iGiOLC
	jq4tSI8=
X-Google-Smtp-Source: AGHT+IGR0CSdOd5Po/wNVWrEJqUZznOrS/jBm/GnLu5HAE6JT5lGfrjeB9BDoXGSjl8H9zT5JrqJbT2xoUKUsCO9Zig=
X-Received: by 2002:a05:7022:62a8:b0:120:5719:624c with SMTP id
 a92af1059eb24-121da89a169mr42938c88.19.1767490081402; Sat, 03 Jan 2026
 17:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-james-perf-uncountable-events-v1-1-f2d9932999fd@linaro.org>
 <CAP-5=fUNJLoy25rS=diSXNR9h-h4m6EFPTy8M+KpTKxm6HtDSA@mail.gmail.com> <951f10c5-e1ac-45d4-b7ca-56aa32e57cd6@linaro.org>
In-Reply-To: <951f10c5-e1ac-45d4-b7ca-56aa32e57cd6@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 3 Jan 2026 17:27:49 -0800
X-Gm-Features: AQt7F2o5no2WckBB9YJGcdTGhjJumxJNEyTbpp6daTpOP-viEjkWjPdRLGjbC28
Message-ID: <CAP-5=fWQU59Vyb6y+W6ObOTh3nzFSofsn8sc6JzwZp7FiV+n6w@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events arm64: Remove uncountable events
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 8:38=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 02/01/2026 3:29 pm, Ian Rogers wrote:
> > On Wed, Dec 31, 2025 at 4:13=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >> These events are never countable by the PMU and are only intended to
> >> be used as external inputs to trace. Therefore showing them in 'perf
> >> list' is misleading so remove them.
> >
> > What does "trace" mean in this context?
> >
>
> CPU trace, Either ETE (Embedded Trace Extension) or ETM (Embedded Trace
> Macrocell). You can select PMU events as inputs to the trace block to
> make it do things like start and stop tracing.

Ah ok, trace immediately makes me think of `perf trace` currently.
Presumably there's no perf integration for ETE and ETM that somehow
use these event encodings? Looks not and the changes make sense to me.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > Thanks,
> > Ian
> >
> >> The generator script doesn't emit these events when used with the new
> >> telemetry-solution input files [1].
> >>
> >> 'perf list' should only show countable events because there are events
> >> that are sometimes implemented, sometimes countable and sometimes not,
> >> for example TRB_TRIG. If we always include any implemented events
> >> whether they are countable or not then it's not possible to tell wheth=
er
> >> they are usable in perf without going to the docs, defeating the point
> >> of 'perf list'.
> >>
> >> It's also not useful yet to display implemented events that are not
> >> countable (for help in using trace rather than perf stat), because
> >> PMU_OVFS and PMU_HOVFS are practically always implemented and TRB_TRIG
> >> is always implemented when there is TRBE.
> >>
> >> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tr=
ee/main/data/pmu/cpu
> >>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >> ---
> >>   tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json  |  8 ----=
----
> >>   tools/perf/pmu-events/arch/arm64/common-and-microarch.json | 12 ----=
--------
> >>   tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json   | 10 ----=
------
> >>   3 files changed, 30 deletions(-)
> >>
> >> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json=
 b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
> >> deleted file mode 100644
> >> index d8b7b9f9e5fa..000000000000
> >> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
> >> +++ /dev/null
> >> @@ -1,8 +0,0 @@
> >> -[
> >> -    {
> >> -        "ArchStdEvent": "PMU_OVFS"
> >> -    },
> >> -    {
> >> -        "ArchStdEvent": "PMU_HOVFS"
> >> -    }
> >> -]
> >> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.jso=
n b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> >> index 2416d9f8a83d..468cb085d879 100644
> >> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> >> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> >> @@ -432,24 +432,12 @@
> >>           "EventName": "TRB_WRAP",
> >>           "BriefDescription": "Trace buffer current write pointer wrap=
ped"
> >>       },
> >> -    {
> >> -        "PublicDescription": "PMU overflow, counters accessible to EL=
1 and EL0",
> >> -        "EventCode": "0x400D",
> >> -        "EventName": "PMU_OVFS",
> >> -        "BriefDescription": "PMU overflow, counters accessible to EL1=
 and EL0"
> >> -    },
> >>       {
> >>           "PublicDescription": "Trace buffer Trigger Event",
> >>           "EventCode": "0x400E",
> >>           "EventName": "TRB_TRIG",
> >>           "BriefDescription": "Trace buffer Trigger Event"
> >>       },
> >> -    {
> >> -        "PublicDescription": "PMU overflow, counters reserved for use=
 by EL2",
> >> -        "EventCode": "0x400F",
> >> -        "EventName": "PMU_HOVFS",
> >> -        "BriefDescription": "PMU overflow, counters reserved for use =
by EL2"
> >> -    },
> >>       {
> >>           "PublicDescription": "PE Trace Unit external output 0",
> >>           "EventCode": "0x4010",
> >> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json =
b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
> >> deleted file mode 100644
> >> index 65bd6cdd0dd5..000000000000
> >> --- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
> >> +++ /dev/null
> >> @@ -1,10 +0,0 @@
> >> -[
> >> -    {
> >> -        "ArchStdEvent": "PMU_OVFS",
> >> -        "BriefDescription": "This event counts the event generated ea=
ch time one of the condition occurs described in Arm Architecture Reference=
 Manual for A-profile architecture. This event is only for output to the tr=
ace unit."
> >> -    },
> >> -    {
> >> -        "ArchStdEvent": "PMU_HOVFS",
> >> -        "BriefDescription": "This event counts the event generated ea=
ch time an event is counted by an event counter <n> and all of the conditio=
n occur described in Arm Architecture Reference Manual for A-profile archit=
ecture. This event is only for output to the trace unit."
> >> -    }
> >> -]
> >>
> >> ---
> >> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> >> change-id: 20251230-james-perf-uncountable-events-28adfb93b73f
> >>
> >> Best regards,
> >> --
> >> James Clark <james.clark@linaro.org>
> >>
>
