Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412051A00DF
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735132; cv=none; b=RSJV7xbfiVp1S4D2tA+3wf1Ssi89cxOynEAK5pWu6fU34JCo0W+iuC5ExkTeP9XHKg5fFtEF9js9vPBos8MtpUBPrSbZbC5sHLBefbot5JetDfHpphRK4khivW08HM3bj0DHk2AdPIm26A0VnRj0p5/8KozVnzdGu7leRyXyqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735132; c=relaxed/simple;
	bh=FA8rurZAujgc19PD/q0qvrBhAi2huUDq19HfgpAZxRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiRCJrM9uwIVf0NZywuFWSZtjdo2kXC54EEot65vqTbOV81X+WDl2kA4eZum0L8nNOK5SH0mCxtrJFxhXePs4URfona8NNNzyHpY1ElVvU1D2a4HiodoZG1Q6yzpm0ezICXj5l7KoxIrvMpUwYokv5djo4yvxcU59tQoLDdeBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAjmkSfu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAjmkSfu"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447df43324fso39081cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720735129; x=1721339929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnYOe1dJG5+d+L3aqlBxYsGPG+LDmnP2wQAV+RTmgZI=;
        b=cAjmkSfua2dfCU+sYh2XS15j1Hl4zIcTULvAjVLPF8VvxEACnVZ1cFrY6thrAQQTdy
         lQtewdjHNtkVtieTQZ/+Px6XOFCPm3zCvIlEBlacoL9rijsmkXAJZMvWm3FVrvYmVfps
         3wfe0E+OzbBt7KLLScWS6J+6+L/LFHbYwOVZnKkvWqA/g1nYRfJTUtS5EIXcCGzuZSF+
         BgQZMncF4I0xaU6fDvZW052MudMwU24qgzxBETakPnMbL7GMbrFXQ9dsMBEyVc8a9KwO
         3p2z6PKYJK/TEbpKaeI8cBBScV7t3dl4nyWfY37bViiImelQhXvQm6lfzg+aTxh65h4q
         ohRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735129; x=1721339929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnYOe1dJG5+d+L3aqlBxYsGPG+LDmnP2wQAV+RTmgZI=;
        b=WUfm/EzAhph/aTpYRIz9NeSG8K1pvfso5XvsdE/lO00ZtXHizdjc23QO6KSlD7VAX7
         eADdacl6OKRa1A7wk8ryDHSbU7S0tm5KbTNIof3AyPpi0RNmDfryIwQ3V4U0sVfXSitR
         dd1cM/vV6Sv5CXV+xNK/zuKrTYHyB7WCCBSy9wCbdNgaNJdliRCPgBK1GRCGpLtJ5OcG
         ULbiYv9e22jOtp7C4P7g1N3SdMcTqeUXA4P2wWcLixAnmh4giMmWJtLj7l4fTvxRFbZU
         XA3urCLcJRmrSX22zBAV42ACeiRzyAiyTuNc8lvCYyckzgUCFFzxRgv2iLqGIn4dbZ2c
         A+xA==
X-Forwarded-Encrypted: i=1; AJvYcCVXBMpxrunEL75DvUS54yiUwsypc6Ilsy2hiWVYYTsQVuC6zUHglsYT+Nd9vumhFnC3JDFU+V7tfDx0wosY0WgqSOtsZMXezADygVHq5xFKMw==
X-Gm-Message-State: AOJu0YzgR7dWAztIV2oII+ehwtzR5HzElBlyY971+3hadaRw9BU2zXi+
	ZXRE5okK2ulboG8RmKsMGPJ4+bUtTD2QXAJUnKlcYCdb6r078opxS3to0xCY+GL0s7Fq4Jy7qjw
	c68OSg3RuiKIGDtJd+fFnSL4fPtgSZq7EBLWe
X-Google-Smtp-Source: AGHT+IELqWv5DEQWx38sI2VPsWnfcnaJgBIGYKNZMWEGKlbGp4EDsVqCEuin4magvXGBDti3fGOMeO+hfnwUiVNYQ7A=
X-Received: by 2002:ac8:60d0:0:b0:447:e5df:e1be with SMTP id
 d75a77b69052e-44e7350fe53mr1078961cf.8.1720735128225; Thu, 11 Jul 2024
 14:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
In-Reply-To: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 14:58:36 -0700
Message-ID: <CAP-5=fVwZfV+gNWcmEtRnkOtrvozMdXPVrZ37COHkf4BX1VPgw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] perf: add logic to collect off-cpu samples
To: Ajay Kaher <ajay.kaher@broadcom.com>, chu howard <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, rostedt@goodmis.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, yangjihong1@huawei.com, zegao2021@gmail.com, 
	leo.yan@linux.dev, asmadeus@codewreck.org, siyanteng@loongson.cn, 
	sunhaiyong@loongson.cn, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:16=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.com=
> wrote:
>
> Add --off-cpu-kernel option to capture off-cpu sample alongwith on-cpu
> samples.
>
> off-cpu samples represent time spent by task when it was on wait queue
> (schedule out to waiting for events, blocked on I/O, locks, timers,
> paging/swapping, etc)
>
> Refer following links for more details:
> https://lpc.events/event/17/contributions/1556/
> https://www.youtube.com/watch?v=3DsF2faKGRnjs

Hi Ajay,

I wonder if Howard's improvements (not landed) for `perf record
--off-cpu` would solve this problem for you?
https://lore.kernel.org/lkml/20240424024805.144759-1-howardchu95@gmail.com/
Or is that approach problematic due to the use of BPF?

Thanks,
Ian

> Ajay Kaher (3):
>   perf/core: add logic to collect off-cpu sample
>   perf/record: add options --off-cpu-kernel
>   perf/report: add off-cpu samples
>
>  include/linux/perf_event.h            | 16 ++++++++++++++
>  include/uapi/linux/perf_event.h       |  3 ++-
>  kernel/events/core.c                  | 27 ++++++++++++++++++-----
>  tools/include/uapi/linux/perf_event.h |  3 ++-
>  tools/perf/builtin-record.c           |  2 ++
>  tools/perf/util/events_stats.h        |  2 ++
>  tools/perf/util/evsel.c               |  4 ++++
>  tools/perf/util/hist.c                | 31 ++++++++++++++++++++++++---
>  tools/perf/util/hist.h                |  1 +
>  tools/perf/util/record.h              |  1 +
>  tools/perf/util/sample.h              |  1 +
>  11 files changed, 81 insertions(+), 10 deletions(-)
>
> --
> 2.39.0
>
