Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2924337B
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Jan 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367763; cv=pass; b=nmh/bORYzxvxTdIF4Dc0fKLbkDDoOW8r1kvs7a8vKribwrhPzKfWMTQ3RAyI7+EqvIspY0yKB0YB+IeJWoOJiqkDGvWKi5OKGkGsDhGhUTLWpJpDoP/HvHqI7TjhgPlmk6HpSh0UCPU4WXR+/dy6nLvlKYxy840py+pHBbdE7dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367763; c=relaxed/simple;
	bh=eGoowmSEsPCstoNDJHVFm6y0yKxdukSXYtHUVQfsZWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHKSYKNFvlg0jbKB4cwfWtlkKEBV3iOqUOX1y+RXuudUed594INdm1Et4ox8zZc8nfK1QfZ0N1psSrfa+j3cqQggtqQlxgJNL+WX+rxBrKfPf88WVaNVmSk6DvI+g4R6Mhi0UIORufYrkjGQd4fsvyvfYlUF+P9c8Yoh8OxNBBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2qz+YSK; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2qz+YSK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f02651fccso341835ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jan 2026 07:29:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767367761; cv=none;
        d=google.com; s=arc-20240605;
        b=Oe8rO4Avz6LfLXuvhoU2W2M7xEp7ZG8TLlvdIabEYHe5iEuXppQ4DVi5FGciCDBLHT
         03e1na+Sno8C6Mhy71rcj9glRJaotxk+9RdYVgZOSP2IUqGavjjWuBO8HV+IKt3+icpD
         gJRM6jhUyRyxa3PVueRiX2ZRrF3XHaUi+DyD5O+5aPNjsM7eg7rVLtbMBqc4Ca0NuwfO
         Xk/Rav2rrhPoh5qg5sIMnkc8u22F42K9W+33bbufFVuri1t4hhPG+/pO9oHeuy9A3/JL
         ffPBzxABNPkioFLVNWh1ucjetsoPoky/VRui/ZnP33ls2nzIUMOo0hwc8fL/xacTssjL
         yXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1IrNNLIVA6NEnoB6P01BW0NnGhVoH9ArZXFEJWghKfQ=;
        fh=wZwlWXHGk/rFx8SmVIiK1KsegSmmH6azPzHBr+9ORpo=;
        b=Sg9QfAf7w0Q0JLFVUfgo6JdsUg7Dphpcfa+nJy05EesYuCNQesZQMMJKwVnZpw4wSg
         k4456Poudu8MZuxMPHWewjnxoWyHVBHDBUpx55IdRRqZWZ6KV1vWl2DTwCgsAPZD6fYz
         bfjcXqx/FCMYsp1dixZQvuchNzPHQj3yB66BRlVCu01jtK52+pc0EWLTO+zck6uZgqCh
         uLG0sbfMkSWjyo3koyEiZOQJkyTFsl5+PErkG4dO8YPriVPDnr5zhif/Rf1ibP7luwfX
         wMxJhfY6AiQItU63emWtMbQrC4bmhwXcoJa3hls1LWbEOJbQd1KawOAjV9mXYWE4HU5I
         DT2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767367761; x=1767972561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IrNNLIVA6NEnoB6P01BW0NnGhVoH9ArZXFEJWghKfQ=;
        b=L2qz+YSKl4YPq6HE4lQ2u2kNROjpEUwB2Ms1EE31/qyG24Yz1ldlepfkuvZOvffU4C
         PrFtI0VsjUifjwR66zx479fpVYBsKX43cLuRFEdrl44dqkNoIMVwrNfhzxDzDQD4h1fF
         HgwOAj0tgcn6eUm12vkK++In4eJLr5cU69cqRvrx8PeZdDoUZx9RG2cj9SuTtS5PlwUI
         LbEAFR4Q/0V7G0JGTbYJQcP88TBEeLSG2XK+/E9MHAdaIvDpyZwcNEq9pjy64TWN9wk5
         6TNRdi3iudA5UJu8BEhFee5/zkJFNGXwn88sjchjlKIuVYvTY4BfGFdtPBlOHt+MvXGF
         ZAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367761; x=1767972561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IrNNLIVA6NEnoB6P01BW0NnGhVoH9ArZXFEJWghKfQ=;
        b=WFbIovVlxBz+/g563GgFE1DLLnZ8oXvhYDSsq/WWN58xKMMz1AzsecTyfp96ZflN8l
         1qGXAKK/TjxtbsKiAabbeXzlLloQYbuSShS2RcdnojZBgzhUUDJJzOaXNw/Eh6h9k2x5
         XRx50sIWkUUj6mguItW3YiqPmX+n39u55zc6uDqjlfPinBzwn9Zj+E4F3zirHP1U8QfZ
         CVYb58/tYkXT4pI7rpx0GUPjBOF4ebPLWZd2mKOdh4Ji8pw2DdewAI5bVaVzL94URKay
         v+ZcZSm9gR5Vp4J62MgC1xhat2geVBw/b6EEmZUBHYiskHexFgkxWJYvmkB6h+uGae4V
         gHVw==
X-Forwarded-Encrypted: i=1; AJvYcCWU30M8nN/u28i4uyT4GXfz1OYoODMLN/3v2Ps7X2NEcXO4Rj1XcC8D1/EVT1cxOg+6iyWl5OmKEvTdLfNlK+Kq@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8N72Kpr6/GhC86lgx/CwlpmQm8+m+9mzEAWs/PlyOrn9oLut
	CSCzK0+ZG0F28ZhkU+bGedvYjmBr5cRzYQ9toYCGZqbRGupXMYj4fueJMa5dyE2fsa1JaCnERCi
	35qZiRpIKHLRtIEnElE74xxUj1SMosNcNYhCp9s8I
X-Gm-Gg: AY/fxX63Bq8Q89pxJzZ2b7lwzSPHNDM2hrhJ7/P4nIdPmPybyuaduZxNSE/P1J2Iodd
	1haaYt6Vw11dX72bOcpATJA/btRkCUP4zMoRPyRAJjtIefb3OsyFxik9zVsUH6gVBbkxmqKf1+/
	sxJiIVtSkirI5RC+o4ur6wcasNEmO7c9y33KHUZKP5dpQoumCmNTrmiRf99HtgXaer4YoL0owSY
	D/bJnSUMCPjUayQ9YmeKFp3JNYHHU8BBMipi7770UeeORvcprBWRnC+H7WdPXQMnLa8wxAh
X-Google-Smtp-Source: AGHT+IHkRM3nbQcOLPK48izIgmx+1XDVnVC8tPksDt2Q+LaV8kDbzbl+/fNpBXQmPomVnOxMH/Rg7BkIQtTEpzsiFbM=
X-Received: by 2002:a17:903:32cf:b0:2a1:35df:250f with SMTP id
 d9443c01a7336-2a3a48b30ebmr3054145ad.15.1767367761024; Fri, 02 Jan 2026
 07:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-james-perf-uncountable-events-v1-1-f2d9932999fd@linaro.org>
In-Reply-To: <20251231-james-perf-uncountable-events-v1-1-f2d9932999fd@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Jan 2026 07:29:09 -0800
X-Gm-Features: AQt7F2rS--MzMnSf-RM3PcQkHgwOlcc1ZDooZ9mUFWMOcjVEabNgLf8roIrcl70
Message-ID: <CAP-5=fUNJLoy25rS=diSXNR9h-h4m6EFPTy8M+KpTKxm6HtDSA@mail.gmail.com>
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

On Wed, Dec 31, 2025 at 4:13=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> These events are never countable by the PMU and are only intended to
> be used as external inputs to trace. Therefore showing them in 'perf
> list' is misleading so remove them.

What does "trace" mean in this context?

Thanks,
Ian

> The generator script doesn't emit these events when used with the new
> telemetry-solution input files [1].
>
> 'perf list' should only show countable events because there are events
> that are sometimes implemented, sometimes countable and sometimes not,
> for example TRB_TRIG. If we always include any implemented events
> whether they are countable or not then it's not possible to tell whether
> they are usable in perf without going to the docs, defeating the point
> of 'perf list'.
>
> It's also not useful yet to display implemented events that are not
> countable (for help in using trace rather than perf stat), because
> PMU_OVFS and PMU_HOVFS are practically always implemented and TRB_TRIG
> is always implemented when there is TRBE.
>
> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/=
main/data/pmu/cpu
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json  |  8 --------
>  tools/perf/pmu-events/arch/arm64/common-and-microarch.json | 12 --------=
----
>  tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json   | 10 --------=
--
>  3 files changed, 30 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json b/=
tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
> deleted file mode 100644
> index d8b7b9f9e5fa..000000000000
> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -[
> -    {
> -        "ArchStdEvent": "PMU_OVFS"
> -    },
> -    {
> -        "ArchStdEvent": "PMU_HOVFS"
> -    }
> -]
> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b=
/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> index 2416d9f8a83d..468cb085d879 100644
> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> @@ -432,24 +432,12 @@
>          "EventName": "TRB_WRAP",
>          "BriefDescription": "Trace buffer current write pointer wrapped"
>      },
> -    {
> -        "PublicDescription": "PMU overflow, counters accessible to EL1 a=
nd EL0",
> -        "EventCode": "0x400D",
> -        "EventName": "PMU_OVFS",
> -        "BriefDescription": "PMU overflow, counters accessible to EL1 an=
d EL0"
> -    },
>      {
>          "PublicDescription": "Trace buffer Trigger Event",
>          "EventCode": "0x400E",
>          "EventName": "TRB_TRIG",
>          "BriefDescription": "Trace buffer Trigger Event"
>      },
> -    {
> -        "PublicDescription": "PMU overflow, counters reserved for use by=
 EL2",
> -        "EventCode": "0x400F",
> -        "EventName": "PMU_HOVFS",
> -        "BriefDescription": "PMU overflow, counters reserved for use by =
EL2"
> -    },
>      {
>          "PublicDescription": "PE Trace Unit external output 0",
>          "EventCode": "0x4010",
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json b/t=
ools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
> deleted file mode 100644
> index 65bd6cdd0dd5..000000000000
> --- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -[
> -    {
> -        "ArchStdEvent": "PMU_OVFS",
> -        "BriefDescription": "This event counts the event generated each =
time one of the condition occurs described in Arm Architecture Reference Ma=
nual for A-profile architecture. This event is only for output to the trace=
 unit."
> -    },
> -    {
> -        "ArchStdEvent": "PMU_HOVFS",
> -        "BriefDescription": "This event counts the event generated each =
time an event is counted by an event counter <n> and all of the condition o=
ccur described in Arm Architecture Reference Manual for A-profile architect=
ure. This event is only for output to the trace unit."
> -    }
> -]
>
> ---
> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> change-id: 20251230-james-perf-uncountable-events-28adfb93b73f
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
