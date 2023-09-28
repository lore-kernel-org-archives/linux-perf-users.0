Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B96B1FD1
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Sep 2023 03:53:04 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360EBF;
	Wed, 27 Sep 2023 20:53:01 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-79f82b26abfso433092339f.1;
        Wed, 27 Sep 2023 20:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695873181; x=1696477981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvXKDHU8dCgQlyr4ZtKhvdlZrarpGOogxwwhdFc0rsA=;
        b=sMJYqP0sQCi2t3L/i6aR5nNyw1+VWiPFUN5njQLiXD7lzsIYOx5vFyNChRYyauueRN
         NDw5zFQXlkzg3tPI68EAW7AJmw4DiBrAqYPVyE3koiiqrGdOOqilyVuDsv/2Bo33IGQA
         jeTDNzUdHI26B2y5RzMu92iW6DDOZLRfmzeOVEUWvxQ5UG8pswx4PJRq4r/HGEco3N9i
         /GqiTIsc/tzgDQaw3SFuFu+j8pFiK9shbLCXInp573j3h8bAFt4frXJR+tag9b7tge5n
         VmbrwZo16LuoNWysK3QCB2mHd8JJFnY8U3+i+luAMMlNl3qQDZJtgqkdubyGDbm+suXw
         HL6w==
X-Gm-Message-State: AOJu0YzJuqZoh/ynpJNJ6NsBsx+ZOhPVlXLIrtF0zBBIjyluVdPCv0pd
	gl1uorsDXn5wv010CDrUUYL6OhzCjQzKe+IV3jU=
X-Google-Smtp-Source: AGHT+IHm/6FbTRZxUekuz1SoZ9JXtxWU427MpHMHLiPLHvV2T/i2EQyHvDFH7Jma8+vt3/KH+az9tJ1hBVikMUuS+UI=
X-Received: by 2002:a6b:a12:0:b0:792:792e:6619 with SMTP id
 z18-20020a6b0a12000000b00792792e6619mr107225ioi.2.1695873180930; Wed, 27 Sep
 2023 20:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925055037.18089-1-colin.i.king@gmail.com> <CAP-5=fUht_JQKW8ekDCpHyRbdVe168nmLGrWU21aZDYSyDeMQQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUht_JQKW8ekDCpHyRbdVe168nmLGrWU21aZDYSyDeMQQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 27 Sep 2023 20:52:49 -0700
Message-ID: <CAM9d7cg59xYzHt-tMQ3C8hohn4710rxAhpAu1c88pb=MJu1tXw@mail.gmail.com>
Subject: Re: [PATCH][next] perf kwork: Fix spelling mistake "Captuer" -> "Capture"
To: Ian Rogers <irogers@google.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 9:08=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sun, Sep 24, 2023 at 10:50=E2=80=AFPM Colin Ian King <colin.i.king@gma=
il.com> wrote:
> >
> > There is a spelling mistake in a pr_debug message. Fix it.
> > (I didn't see this one in the first spell check scan I ran).
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
