Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC74171C0
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tWV7OGc"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405DA3
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 08:31:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5032a508e74so6372e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696865505; x=1697470305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9lR87UXDmLmGW5fgYOoK9D3OVG+W1Apjk0vJRi7zLM=;
        b=1tWV7OGcc9ERBFbl2dNcxy8q1A0XpAwBL0l/MU9Blu9Vm6az6ft1qpkdtJAiwe4qYK
         YUZYHGV9S2coLdV5tIbCkPvg5ewylf7VYmM8GgU/4bcMJMbcUu8zT15akCx1XFZI/NT2
         ssWU40vzAGlif9Q+Eoq5iA581psoE/EzP7NFixsuZzNm1hfYzolD390CvsraTxxA7uyo
         h21YpmJUBie4B7uSJ0TIQjoDU3rf4RuzM7xodYvnrJlMUtesDgyPnbWLFMjgUWq7Sgzh
         gz9eINt4BOHJr3hS0bTDOGtDslDgV6GXsCeIXAegQQdHxRS/E/g6NE9tay8z7Qg5vw+5
         DZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865505; x=1697470305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9lR87UXDmLmGW5fgYOoK9D3OVG+W1Apjk0vJRi7zLM=;
        b=Mcrahvp7aJMB8rdbOHaYwjlMQcYUowNx/1MmXTywxrUm6mpVr+qUok4+/ReE0B7g9c
         6UfPL1iuwcZPxEYGBZ3Q5JxnuK+8p5XFzlnGL2T4imSb2Kzyu0ePRJH8ajB3KwGwnPzU
         xjaNqIsRxvT5DqJj8e1d/ayMrTxcyDmqBThtpU6kqmLoRhU4SW7AKZ3AXVOlQjvulaa+
         s6Uncwq+POUQdqHliDrOLUzb8dxHIQP65UUXoTpWF4QzoXrhpkMWx/bABlzRDie+ANS3
         wwcs2670H8p2rm0xmOg4wdcluFr83wbNuvfN+d5O7r+I8fABoUcHQUatkaTd6/VvUj7H
         Z/NA==
X-Gm-Message-State: AOJu0YwKJ4UXgFiE3mUjoR8nvANgfmb0J8dpa9W4NryfSMvg4QHwMtXh
	UWse5kw9jVh39YNKJLhTrmK/oOcbdzNnOKqs2miCXw==
X-Google-Smtp-Source: AGHT+IFej5jFA1THvSV2aeZXzaiKcyhdWw6v1JEH9n5f40OTL3FiZOid29zfdAkp5ezAFfSgfuUUxlraEg0PWsjYwkg=
X-Received: by 2002:a05:6512:4801:b0:502:a55e:fec0 with SMTP id
 eo1-20020a056512480100b00502a55efec0mr231745lfb.6.1696865505263; Mon, 09 Oct
 2023 08:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002221909.2958708-1-irogers@google.com> <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
 <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com> <CAP-5=fXzcR6QKKhFG5PS1pFYi5JsO4AOUoH_-Bv0O+11YzEkkw@mail.gmail.com>
 <CAM9d7cjQZvZm+Vyrx9PTUYMFN5RjE+i-Kq1kbffyVp2hGKF6sg@mail.gmail.com>
In-Reply-To: <CAM9d7cjQZvZm+Vyrx9PTUYMFN5RjE+i-Kq1kbffyVp2hGKF6sg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Oct 2023 08:31:33 -0700
Message-ID: <CAP-5=fUo-vuLofC4jgHC9z=BTe80OEiY_PoQWqQtyVdvHcf+KQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 10:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 2:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Thu, Oct 5, 2023 at 12:06=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> > >
> > > On 5/10/23 18:48, Ian Rogers wrote:
> > > > On Mon, Oct 2, 2023 at 3:19=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > >>
> > > >> The byte aligned buffer is cast to large types and dereferenced
> > > >> causing misaligned pointer warnings from undefined behavior saniti=
zer.
> > > >> Fix the alignment issues with memcpy which may require the
> > > >> introduction of temporaries.
> > > >>
> > > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > > >> ---
> > > >
> > > > This is a relatively small change that fixes building with
> > > > -fsanitize=3Dalignment -fsanitize-undefined-trap-on-error. Adrian, =
as
> > > > this is Intel-PT could you take a look?
> > >
> > > Thanks! This has been down my list of things to do for ages,
> > > but using get_unaligned_le16() etc seems nicer.  I sent a patch
> > > set for that.
> >
> > Thanks Adrian! Your patch set looks good and I think after Arnaldo's
> > comment is addressed we should go with it.
>
> I think it can be done as a later step as long as the interface is the
> same.  Can I add your Ack's to the Adrian's patchset?

I think addressing Arnaldo's comment:
https://lore.kernel.org/lkml/ZR8QnasisGEsaaDR@kernel.org/
will need some changes to the patch series, and so I was waiting to
see the outcome of that.

Thanks,
Ian

> Thanks,
> Namhyung
