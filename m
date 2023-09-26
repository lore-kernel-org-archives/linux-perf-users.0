Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54FD4B23D
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 22:50:37 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D02D53;
	Tue, 26 Sep 2023 15:50:34 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-79f989480e0so308580439f.3;
        Tue, 26 Sep 2023 15:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695768633; x=1696373433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZKclDe/uYQzuxv6DMuerm/HlKiq6cyDhOcFQbVTnOc=;
        b=E5LXbiIEUFABrXGeIQdVeDWK8weUS6sCdNxp3dO4psocIb+uMOqBR2LNUYZ4VoJm0v
         c+ndZD29YnuEMo8qNtU9BwebxSFlMggFsYf8rdjgS7+Q0ypWVOnNbt2X5WI/gCxE8LjF
         TAyu+ARuQCvTM5QtMdteV/j+YVYH2ZWikklSYxpgmqQO3Ggf1hIj3sgsFEFu+2tP//gX
         VQlvxjiEBoaAMH9wrDxGCeMic+vtFqPhrEnX1watMJCYZUAGps73ijakuCMm0YgObqN+
         gEGHj69+715cHEUmECJ4P6Jg7r47mkmLtPFB8e2000Iwph4i+FdxX5IO52GMX3qm6tG7
         tfzw==
X-Gm-Message-State: AOJu0YwhbXu3eI9Vm868Dt+0lasUZZrXiZsQltk69SqplwR5tSBr58et
	k5x/OiNaKMoIu/fcdtYtRAoPsAh5q06kT3MWoP0=
X-Google-Smtp-Source: AGHT+IG8erDIQDWM5olgRw5CxHf9k6FwCSZykxOrwwmFf79OvuCG9QgUReitrYI/fKnlSjJh0pyWySGV/UMd1m7AbAU=
X-Received: by 2002:a5e:8306:0:b0:783:63d6:4c5 with SMTP id
 x6-20020a5e8306000000b0078363d604c5mr191066iom.12.1695768633651; Tue, 26 Sep
 2023 15:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920061839.2437413-1-ilkka@os.amperecomputing.com> <CAP-5=fX0JYb96A+RCtJpSvqoz4Ya306FJZ3gRUX3o_Qj7Jaisg@mail.gmail.com>
In-Reply-To: <CAP-5=fX0JYb96A+RCtJpSvqoz4Ya306FJZ3gRUX3o_Qj7Jaisg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Sep 2023 15:50:22 -0700
Message-ID: <CAM9d7cjiPB=6Q-k1GEkxNfF+dnrCd5edUX6j=hYg-5nYRufVsw@mail.gmail.com>
Subject: Re: [PATCH v2] perf vendor events arm64: Fix for AmpereOne metrics
To: Ian Rogers <irogers@google.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	D Scott Phillips <scott@os.amperecomputing.com>, James Clark <james.clark@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Will Deacon <will@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Dave Kleikamp <dave.kleikamp@oracle.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:40=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Sep 19, 2023 at 11:19=E2=80=AFPM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
> >
> > This patch addresses review comments that were given for
> > 705ed549148f ("perf vendor events arm64: Add AmpereOne metrics")
> > but didn't make it to the original patch [1][2]
> >
> > Changes include: A fix for backend_memory formula, use of standard metr=
ics
> > when possible, using #slots, renaming metrics to avoid spaces in the na=
mes,
> > and cleanup.
> >
> > [1] https://lore.kernel.org/linux-perf-users/e9bdacb-a231-36af-6a2e-691=
8ee7effa@os.amperecomputing.com/
> > [2] https://lore.kernel.org/linux-perf-users/20230826192352.3043220-1-i=
lkka@os.amperecomputing.com/
> >
> > Fixes: 705ed549148f ("perf vendor events arm64: Add AmpereOne metrics")
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
