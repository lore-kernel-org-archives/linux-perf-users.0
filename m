Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D536CDFE
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216705; cv=pass; b=XG+5eOTmkQgDoc6Hv2T7crQ2X0dBK0PyCWkPxYS5zR1qX0yauuidb+b10hdA43l9p0xZdiCPoDN0A6d14KMHpkhhhZCOGkg+a7GqzJ+SUpjepRyLd1eToFTKEYL2jm2R7YghO95EA2xsf9ph2NC8CQ/Fg+OXl/iSYm2nTBkH/3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216705; c=relaxed/simple;
	bh=IU9y+9j5E9B013njm1UV1tBZUXY1taocDKD45TOWbkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvWUNDWHQvvqbhax/uCJ6V8RUzjiLN3Fs2Yi+dzOpfN2ZbcrZ5QneAnQQkNILkJgvb9GUIv6LqLRAR64qdfxHnC1ElmVItAy+7ed4YwzmoorbpcfcMJSScvXjz44msIFbNO5dpWVHUGB0vSTFCySrrEYHbU9ABQeTtZOBfxT+wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iM73mNj9; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iM73mNj9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso405ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 11:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216703; cv=none;
        d=google.com; s=arc-20240605;
        b=PgiH5sdZ3wzeJJTBN0N/GnQgkBLEqm7cREwwb34lDPohE7tHu7Ye5OzYfkYDilKYbk
         V0MqPzJ4lFBrW7uT+y2zeZ0XngOj2mWGHSssX/n4d5hL9D/oo1eoipq0CNxbHPP2ylyF
         1JT1naUTeBHZ53bLiuh6HPdCylfDGdy6W3A84c5SlLzzror1FaePj7bnpltvZhd3Jh3j
         pj9IiJ2b+xOrRjAwThVVq7WZq/GAM9dMt08iEhWRUw8NB9zzXMq9YUCzHDVUPGzSDfu9
         zJVCeQQGB8oto9IQlUtDaVL0qHI2BOjnBABctrKtabMdjf4ZOGElYH1tzwZTLbEqNFSE
         BTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EalNVzOnQCObvT3qTEwR9Kn2ZIT8zrWoSDlBQNLrOWc=;
        fh=cO1W5lS+ML3jFPjkhMtkHXg4Xqp5OT5dokuLAwXSmk4=;
        b=ie+ulPtUfnkpvoBEhFwJUiiGWF3pQ8lL0+k1awF1RTQso1/G98uNDGaVMOcQBPqKLb
         TY7e9gRwzqCvMqFeSPq/ILst+VOig4z2KotlcQESI8GKt94Kz61zwWZsUU0bFmGmKWDZ
         Dl8Bl2RJD3iFBvHLhugZoMa7c4recP9THXP4BsrzlMWK74oHX0gBQbcuFmqtJQNPTmgn
         42049Ztqzu+/e9088a07CNdOU0inLXj+DHsYaJM8LKICovmWsxRHtxxCyJEk0FnGgTe9
         T7RlWytZkiZFmTSeC7VpByUW0Sx18MPoXI4tRPo3mhJNWUui/Vl0R5CCqQAY7hXSFWGC
         IogQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216703; x=1779821503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EalNVzOnQCObvT3qTEwR9Kn2ZIT8zrWoSDlBQNLrOWc=;
        b=iM73mNj9Q/ISqT+Sgx4hwa2ry16XTRgTmccSVdEYUnvo7CP6I2Z3TJGDrBh67y+qUk
         6gotClss8FAUfWw5ip7SIH9fdwWdHr8w8lHj8U5hSmpjpmeRaN+bYvnI1pZd0LpDSs9p
         1AAO0ZjeowyHJ4Qf5oyK8VDG8fm4VwQK2DerSp6HT3/IXyfoq6x2rTLjYn6n0bUtOX8X
         7zN9naQD6BNJP8XE5P7b5hX2xTESh6SVR7yWQ4Jm6bALw0d37c8hsbggtyLx/2X3qCO5
         a/olz8fbQlEqFfiJPuudzmcVdXtxSplnNjuJUqZ7THy7gSD76plpqKqWS0A36GHWXSBv
         /v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216703; x=1779821503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EalNVzOnQCObvT3qTEwR9Kn2ZIT8zrWoSDlBQNLrOWc=;
        b=Qrtrn8SwAI1J2j+ukJAx3TUQJOwggxfydqUq4WZSc4D4pulizee7VcDB9Y2umFnomh
         Y0zPhTD9YTiBhIDNF59hVBKOVU/mRsgtSk0a8LY7cNARUl2TYHFc8TL5Vi/97t8L+XJC
         xjdLUw5QnaGKrMKyftrsq9AhtLZzY0x3vZT0fZ8Bet7xoojxq3flusSU88Scgv1riNha
         YUoQ+Ppao3+ievFjXpoBAmyPgvKjl/0QLF2OPUlfIr5qLzAWG2hqRjd4HH83B9fV02A4
         2Qukg+sKG8s7TsbX+6gpWA3zrWHHdqlR3m6XB//oDcpLZqCka01+Zdhh2SBlMqqmJI4G
         cesA==
X-Gm-Message-State: AOJu0Yxg82rb6/VaYE8qhxsnXnIH3VGGXjpSY0pwhBa1TH1kM5kj/EN+
	3RqaYYF75pWKgrJvWqoogiZsteuoKZtWsVAq0AT/aNM4kpm+VLW02GX9klxLkThTp70Drzs01HT
	yao8DiYVu9z0gExZtTcGjUc/yJjU/6IRtZItYjr6X
X-Gm-Gg: Acq92OGceh5ucgHBQgWA+JbUXan24iAT1lsHmCvtOgqnBwOPkuRSsh2+983Hh5SEZjv
	/d4HEwJS5uZ8jsNQ8t/7K6cPLVChzHC2D8Y3SA9ye61BN491xGgu0KIG90XwEXkbMvw02dIQblj
	Pf0Gbor7QnvmttkeHJu1GtJ+YOMNq4vWwF04I4geQ7GUQoSqUH8iDlNBlCXdKiDLDfE+sDA2bP8
	9+Dgs3yoD0czpM4N88kPjfjtqDOi6C4YCHWgnr/fVF10IlbyFJcGEnEgFNW4vnG6RQ5YLPSzYlr
	AssGP1hGdvXHb41xVnO5Asq5hofPLT+aRSVKeo/Igja5deOq
X-Received: by 2002:a17:902:ce85:b0:2a9:5ef5:399b with SMTP id
 d9443c01a7336-2bdb32bcb70mr7034445ad.19.1779216702069; Tue, 19 May 2026
 11:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519175043.1490261-1-thomas.falcon@intel.com>
In-Reply-To: <20260519175043.1490261-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 11:51:30 -0700
X-Gm-Features: AVHnY4KdbgbeSn09aZKtEKegQDoJaCw3UbmNbzzBtwd1pdqNATWRnOKMnPRefac
Message-ID: <CAP-5=fW=b_7ovTarHSJLNoQypHOXT6Xz=gfDwONMEF4avQ5QGA@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/2 v2] perf: Fix missing branch counter
 information in script and annotate
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 10:50=E2=80=AFAM Thomas Falcon <thomas.falcon@intel=
.com> wrote:
>
> This series fixes two issues related to branch counter (br_cntr)
> display in perf.
>
> The first patch fixes a missing '+' indicator in 'perf script' output.
> The '+' suffix is used to signal that event occurrences may have been
> lost due to branch counter overflow.
>
> The second patch fixes a regression in 'perf annotate' TUI mode where
> the Branch Count column was never displayed. The check for whether to
> enable branch counter display was performed before events were processed
> and the counter data was populated, so the condition was never satisfied.
> Moving the check to after event processing resolves this.
>
> v2: Added a cover letter and expanded commit message for patch 1/2.
>     Patch 2/2 was missing some conditional checks to enable branch counte=
r
>     display, which have been added back.
>
>
> Dapeng Mi (1):
>   perf script: Fix missing '+' indicator when branch counter reaches
>     upper limit
>
> Thomas Falcon (1):
>   perf annotate: Fix missing branch counter column in TUI mode

For the series:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/builtin-annotate.c | 9 +++++----
>  tools/perf/builtin-script.c   | 8 ++++++--
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> --
> 2.43.0
>
