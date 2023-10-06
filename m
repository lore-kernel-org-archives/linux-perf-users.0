Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2238F98
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251ABCA;
	Fri,  6 Oct 2023 12:05:39 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57b8cebf57dso1344084eaf.0;
        Fri, 06 Oct 2023 12:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619138; x=1697223938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTVoeVfMOxsjEM7ujAVqwzrstYR+YNmGmlAo8xZUyMo=;
        b=ahx8z5uV0WL9ctIOMDegl9omLN+95Edtqz+etGLiAsFZIie1bF/UTV4q4BYDZCHhmA
         aa86+UGsPL4yuSGQ7Qij/98biA28SLq/oAaB8WPE407eoQ6QauIZzVw3jKbeMaRMIPhU
         dvD1DW5QdamR+TXGf5jp8gqMaDNNr84fIv5zoh35/qxn76eHWOkUiM2ADWvEll+DsdSK
         +Lw/f7BhRlQTLH8XyCGnbsjc6q/6tkRIcZsCrjr94qh6rkAZR+pkcc3k4TNHhesKEAvi
         hx+e25rRCc+yzkZdZTl4tPBC70c/2YqK0lQYuSiFEwb3insOB2XI6Wb5Pe6r0xsyCtnj
         zyiw==
X-Gm-Message-State: AOJu0YwEmV0XZzr9vQ25XdUfs73Pv+/1jsgZHuBCh62esO5U3sDJXyXu
	wUvGQfpkHECvZGTYvENxnrO+9/MktBmzdcnIZ6w=
X-Google-Smtp-Source: AGHT+IHYPEjnvWDeT4zLtq3cc/leWn1Uoy2fLkCUMXkmWJbiIU6zZFunk+iDI3YM2AB8kvMEy+wZiuEeMV1OW/zFQ1A=
X-Received: by 2002:a05:6358:938f:b0:140:ecf2:4c69 with SMTP id
 h15-20020a056358938f00b00140ecf24c69mr9234027rwb.3.1696619137983; Fri, 06 Oct
 2023 12:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907210533.3712979-1-irogers@google.com> <CAP-5=fVaK2hhBTX4=zKX5Dft36RurctYEtGzsdUp6XKsjHguMw@mail.gmail.com>
In-Reply-To: <CAP-5=fVaK2hhBTX4=zKX5Dft36RurctYEtGzsdUp6XKsjHguMw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 6 Oct 2023 12:05:26 -0700
Message-ID: <CAM9d7cjDmX=k1aEYGZAf5NJ-j6_q55BOOaMofABHE52KWD3jjA@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Avoid erange from hex numbers
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ian,

On Fri, Oct 6, 2023 at 8:30=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Sep 7, 2023 at 2:05=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > We specify that a "num_hex" comprises 1 or more digits, however, that
> > allows strtoull to fail with ERANGE. Limit the number of hex digits to
> > being between 1 and 16.
> >
> > Before:
> > ```
> > $ perf stat -e 'cpu/rE7574c47490475745/' true
> > perf: util/parse-events.c:215: fix_raw: Assertion `errno =3D=3D 0' fail=
ed.
> > Aborted (core dumped)
> > ```
> >
> > After:
> > ```
> > $ perf stat -e 'cpu/rE7574c47490475745/' true
> > event syntax error: 'cpu/rE7574c47490475745/'
> >                          \___ Bad event or PMU
> >
> > Unable to find PMU or event on a PMU of 'cpu'
> >
> > Initial error:
> > event syntax error: 'cpu/rE7574c47490475745/'
> >                          \___ unknown term 'rE7574c47490475745' for pmu=
 'cpu'
> >
> > valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,c=
onfig,config1,config2,config3,name,period,percore,metric-id
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >     -e, --event <event>   event selector. use 'perf list' to list avail=
able events
> > ```
> >
> > Issue found through fuzz testing.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
