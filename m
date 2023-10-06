Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0B273F9
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTz0IABK"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD182A6
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 08:30:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50348c54439so4347e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Oct 2023 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696606202; x=1697211002; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ry4Fisj82tQviAwEIuy3+xbA50llOUgd81Tf+MVIXSY=;
        b=hTz0IABKAeiP3jVS10Yhx1un+rRamyNOfOoWTUrZjHcnkkG5bF9ZXymbBGnOtRDnKL
         kxC2IglomMx9ox7blLRzbPhjDu875aghVrtQSPEpXoCPmqL45ay0QkGEKDqwkzT1RrNC
         1MB8diRC93itTb3pDHClBPWDrwbzMUJT/AEOQycEaDkuDfviZ2YIv0MW75gBH3N4p8y/
         HYpgniINyHt1DAMmtRDSXkS6TRDCShstT3yU+/UzRogslW+PqbU2dytIIQ4LqawH16Id
         c62A7Ei6y/LLXS61j6zl5OSwcKiVh9keNyCLuxa4c7VdIk51zgPMqIkqO8dmriqw8jdJ
         8bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606202; x=1697211002;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ry4Fisj82tQviAwEIuy3+xbA50llOUgd81Tf+MVIXSY=;
        b=wKqzHo3P577XBCI6pV3tZ/VefM2ZQ7a93A1mgv2Z6/ppQJssNXnu3pj0dWOTTG1CAy
         +aft/Rce54a+cblG4gcz1e0BtCq4OEM4imSDn1qxI5AgYd1y3nBNRRIJqURYGhX4L8fr
         8DT3fDMpH4inHlewBilYFZxc0gfvYNNTfUqnFh0ddX86ZUPR6g4OdTiYZmjJPiBylEo2
         bMl4/ATRMh4CUsnjp2uyGcbOre94d/oMA5ezI/GdbbvyOzDMwz+gjZwChz9qMfpqQ2DG
         zDdtCz3NgrFJRkueZnxoz7yvA2DLle+E1XGjZZp4Vpb0t+svM59sCJgrH5yLbijQnRtq
         89SA==
X-Gm-Message-State: AOJu0YwJSjXQWHZELtor/YThvQVCMQBvsOUgX7xwfwy/64GAWT1Nw75S
	xG7zHmuZHk+/CfPHpCGTvvofGiBQUJ28jhq0OtDpkw==
X-Google-Smtp-Source: AGHT+IG3GH+xexIwQbTHqOACN105l6po65IFiQ9f5Vh8L9zxNMB25MUqj87777n7mITRZ28Oh9fqGh+SArI2/Q/m7lA=
X-Received: by 2002:a05:6512:48f:b0:505:6e12:9e70 with SMTP id
 v15-20020a056512048f00b005056e129e70mr133361lfq.6.1696606201784; Fri, 06 Oct
 2023 08:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907210533.3712979-1-irogers@google.com>
In-Reply-To: <20230907210533.3712979-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Oct 2023 08:29:47 -0700
Message-ID: <CAP-5=fVaK2hhBTX4=zKX5Dft36RurctYEtGzsdUp6XKsjHguMw@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Avoid erange from hex numbers
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 2:05=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> We specify that a "num_hex" comprises 1 or more digits, however, that
> allows strtoull to fail with ERANGE. Limit the number of hex digits to
> being between 1 and 16.
>
> Before:
> ```
> $ perf stat -e 'cpu/rE7574c47490475745/' true
> perf: util/parse-events.c:215: fix_raw: Assertion `errno =3D=3D 0' failed=
.
> Aborted (core dumped)
> ```
>
> After:
> ```
> $ perf stat -e 'cpu/rE7574c47490475745/' true
> event syntax error: 'cpu/rE7574c47490475745/'
>                          \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'cpu'
>
> Initial error:
> event syntax error: 'cpu/rE7574c47490475745/'
>                          \___ unknown term 'rE7574c47490475745' for pmu '=
cpu'
>
> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,con=
fig,config1,config2,config3,name,period,percore,metric-id
> Run 'perf list' for a list of valid events
>
>  Usage: perf stat [<options>] [<command>]
>
>     -e, --event <event>   event selector. use 'perf list' to list availab=
le events
> ```
>
> Issue found through fuzz testing.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Hi, would be nice to land this.

Thanks!
Ian

> ---
>  tools/perf/util/parse-events.l | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index 4ef4b6f171a0..f7df52b22c39 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -156,8 +156,8 @@ event_pmu   [^,{}/]+[/][^/]*[/][^,{}/]*
>  event          [^,{}/]+
>
>  num_dec                [0-9]+
> -num_hex                0x[a-fA-F0-9]+
> -num_raw_hex    [a-fA-F0-9]+
> +num_hex                0x[a-fA-F0-9]{1,16}
> +num_raw_hex    [a-fA-F0-9]{1,16}
>  name           [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
>  name_tag       [\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=3D]*[\']
>  name_minus     [a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
> --
> 2.42.0.283.g2d96d420d3-goog
>
