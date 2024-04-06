Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1A11CA9
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Apr 2024 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361758; cv=none; b=PQDOC87lvIBMVseDvJq5+WiAgX7NftnQRcMs4Wa6Cqry00iDp7aifH8MsgusR0OsZ2QEntW/Jam6LhI5G4eGg+BQR0CrYuyaFhhzmSgyAd/JgXDjasthD9G93e9CurDTDBJZnteUqQYG+n5HDkuYdvo60gD+AOHQaMnhXaOb+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361758; c=relaxed/simple;
	bh=KpAjSKdrkXBv5fhkmB8UZX/hjLXR4hCJGaSDHH5mrss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2wrIZ5k4zoONSsGHNh2vhnmV+w5cE/yl6OxHQn+SBEr8X5jPgDuqdnqtL64iHt+lDGSIHGboUnC50Hz6SqGS/OkF1qTNjymu/6UpMe/p5avvF49oQX+0O64nh+OZuop7UBBIoxnHKf9ks0WghYEzMo6DyD8BCT/7+HrrTqDFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M27blDDT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M27blDDT"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-432d55b0fa9so77881cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Apr 2024 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712361755; x=1712966555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLJYi/uIy6sK2MdDlOJLgbHqv1oRQBKBfPlyT2agfv8=;
        b=M27blDDTtD59bi4ub/jJVO9pm6mYDSE7fVoZOgqVuWkL5j+2SHxsrCkHkoMVDUAXv7
         tuSpfKzuQprSNXNeN3VfPmlOhbI3zr6eaDxf+gMNQuuRRSgIFgLIQFg1KrIJnG9tBlrz
         0rm0N3WGNB4XuYOklpcx5bxOvj1v00PpDBcoji8A0BsyhLTCslQ+mHBAYxtdaYnjQYS7
         +MYxRv0iFp4BmNCDDevH2q1vyU+qxNqt8UisUFm0+kyKocRLB0fNY1m6aNA8C4E3vbAP
         t3M086TJgL8Vv/eWdEWQosdMFqo2DJRMD6ns7VUp8sDSa8XoM+8IrsnefV61qdW/ocG1
         MRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361755; x=1712966555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLJYi/uIy6sK2MdDlOJLgbHqv1oRQBKBfPlyT2agfv8=;
        b=I8JzIBUEKHIRYx3zuXjWYqn7kg0EhzohPufAE7RR9lJBV8nwIEhR2yMKDNzWjx4Pjx
         w1oBxXkmiRwYIJs2uqCy6pulGJWNY0ehl43rdO6SOErQs3Lxj9dfe/+ufe/hegkgemVc
         I9w4MeabfL+4aIi/LoegNl0mGac/LcrkeiARBTnASlHMpb+WhPa+qhRlSNNsed+lheEy
         v1JTla+I/SFya1NWxo1ego4OXwmJv1IgR8s44mtEzPJyxtnYq+aWTZ26iXCZXfGJEDug
         wmYEy5O9m9clGKk06dTUHfuDMVpwGlnp1wORNV715OK0CFzktJD8ZI35FKy0TAc7iQeY
         EbWA==
X-Forwarded-Encrypted: i=1; AJvYcCUwzcFJfg8/Q5qFBe6CST8LFduZW+XumAcW2yskpw7Co7FBOgMJY9Fn0EkmyJvEIImlL7djWuzlYR43LtLfdYk65HGJgUTiuZkw0kyV1ViaRg==
X-Gm-Message-State: AOJu0Yy1uh4Pg1dPkNvZmzb8GIf1G4fsZDbUCuBOYMGVAuBEu3fD5oMH
	ddY3ldLr3RYi+pnqe+w5vteidsWiB6i9cv04YqvLpbMKmhUE5o7oKChwpHQKnMWPUFoJYzz6Dov
	9z4ZN9n4wkaGER5bOXINSLzeFjHyb9OnKQzEk
X-Google-Smtp-Source: AGHT+IHDwjio3l7mml1EfKtiOH234s8twE/rMYCk/i2c0VPCw0Zx/DnaBqN791dqwnniasoxYJ08IkF6E1rOTp4zMAI=
X-Received: by 2002:a05:622a:4114:b0:432:c041:462a with SMTP id
 cc20-20020a05622a411400b00432c041462amr109796qtb.28.1712361755157; Fri, 05
 Apr 2024 17:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405211800.1412920-1-namhyung@kernel.org>
In-Reply-To: <20240405211800.1412920-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Apr 2024 17:02:20 -0700
Message-ID: <CAP-5=fUhngjbL3Q7a3EuBSGdDKg8PFjRzpe5yHTDdeLmz4oWDg@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf annotate-data: small random fixes and updates
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> I found some problems in the data type profiling with perf annotate.
> The patch 1 should go to perf-tools and others can go to perf-tools-next.
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf annotate: Make sure to call symbol__annotate2() in TUI
>   perf annotate-data: Fix global variable lookup
>   perf annotate-data: Do not delete non-asm lines
>   perf annotate: Get rid of symbol__ensure_annotate()

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/ui/browsers/annotate.c |   2 +-
>  tools/perf/util/annotate-data.c   |  10 ++-
>  tools/perf/util/annotate.c        | 104 ++++++++++++++++++++----------
>  3 files changed, 80 insertions(+), 36 deletions(-)
>
>
> base-commit: b6347cb5e04e9c1d17342ab46e2ace2d448de727
> --
> 2.44.0.478.gd926399ef9-goog
>
