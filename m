Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDA61C33
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5539133;
	Thu, 12 Oct 2023 21:24:09 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-27d0e3d823fso1123037a91.1;
        Thu, 12 Oct 2023 21:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697171049; x=1697775849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPtXecqRleGGMmT5CUZqBotuwI7hZYRU/fdzYpvoY/g=;
        b=DDp5ep7b+Bep9TBIv1+r2+2J+vw/wKRdz8zpgxkCdLGy4RM5YkADLyWc9Xzv5BIdKe
         kAAYnpZjET0/IffDECmpidppJFb6oeUZ+HVqapfdH3Web8B5xXg/X+MYlpuELBLvrEfr
         GH+2vxLxJW9XCByyIa8rcAJaa48frQVumekaXodSw5mf9aVHw2LEGFYVMAe0i8vAM08w
         E2cYhz7c/zhgb+Rkt531SnEx+KS3qG/YzNgOfjEASLtY0gI9Zkn9fbKyvKkWdnDk+nWt
         2ocRRe1KWA2ZaOj4UupdHg0xbmEFiGAqUdbEy4uru0G1CIVl0+byWJg+KMZaxvuHdA6W
         HTEw==
X-Gm-Message-State: AOJu0YyWvKJGHehkMvpEpo9v95UFcoL6ptbhcLo6o6kVZCroaejYG6ed
	E40X99wJsIyOp9ErAi1VTSHEJH9FhTmBOMhv6D35SBjS
X-Google-Smtp-Source: AGHT+IGqx7n6u6EdF1wE5BZc1tBFdG4nONqzdJkFx7oPCWlxS60pkORW9L9ZZUIlygJ8k0P7vm8sP1FzOaaniHpm/dY=
X-Received: by 2002:a17:90a:1dd:b0:27d:10b1:5deb with SMTP id
 29-20020a17090a01dd00b0027d10b15debmr5448912pjd.31.1697171049056; Thu, 12 Oct
 2023 21:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002221909.2958708-1-irogers@google.com> <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
 <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com> <CAP-5=fXzcR6QKKhFG5PS1pFYi5JsO4AOUoH_-Bv0O+11YzEkkw@mail.gmail.com>
 <CAM9d7cjQZvZm+Vyrx9PTUYMFN5RjE+i-Kq1kbffyVp2hGKF6sg@mail.gmail.com>
 <CAP-5=fUo-vuLofC4jgHC9z=BTe80OEiY_PoQWqQtyVdvHcf+KQ@mail.gmail.com>
 <CAM9d7cjdb5WE-xdSdKD=p_EtsS7OSVEWL+GL3RVwczu-+1JvFQ@mail.gmail.com>
 <CAP-5=fVe9v=KOxJE5TfmivBQCD=7SRFpnqkob7e05U76d_bSPQ@mail.gmail.com> <6452eca3-e8de-40b5-8e04-2e37892880f7@intel.com>
In-Reply-To: <6452eca3-e8de-40b5-8e04-2e37892880f7@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 12 Oct 2023 21:23:57 -0700
Message-ID: <CAM9d7cgmDh_39jvYdKdm-jhcLpB6+NmY8nPhdMDLtGNLzKX3JA@mail.gmail.com>
Subject: Re: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 5:27=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 11/10/23 09:50, Ian Rogers wrote:
> > On Tue, Oct 10, 2023 at 10:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> >>
> >> On Mon, Oct 9, 2023 at 8:31=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> >>>
> >>> On Sun, Oct 8, 2023 at 10:29=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> >>>>
> >>>> On Thu, Oct 5, 2023 at 2:24=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> >>>>>
> >>>>> On Thu, Oct 5, 2023 at 12:06=E2=80=AFPM Adrian Hunter <adrian.hunte=
r@intel.com> wrote:
> >>>>>>
> >>>>>> On 5/10/23 18:48, Ian Rogers wrote:
> >>>>>>> On Mon, Oct 2, 2023 at 3:19=E2=80=AFPM Ian Rogers <irogers@google=
.com> wrote:
> >>>>>>>>
> >>>>>>>> The byte aligned buffer is cast to large types and dereferenced
> >>>>>>>> causing misaligned pointer warnings from undefined behavior sani=
tizer.
> >>>>>>>> Fix the alignment issues with memcpy which may require the
> >>>>>>>> introduction of temporaries.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>>>>>> ---
> >>>>>>>
> >>>>>>> This is a relatively small change that fixes building with
> >>>>>>> -fsanitize=3Dalignment -fsanitize-undefined-trap-on-error. Adrian=
, as
> >>>>>>> this is Intel-PT could you take a look?
> >>>>>>
> >>>>>> Thanks! This has been down my list of things to do for ages,
> >>>>>> but using get_unaligned_le16() etc seems nicer.  I sent a patch
> >>>>>> set for that.
> >>>>>
> >>>>> Thanks Adrian! Your patch set looks good and I think after Arnaldo'=
s
> >>>>> comment is addressed we should go with it.
> >>>>
> >>>> I think it can be done as a later step as long as the interface is t=
he
> >>>> same.  Can I add your Ack's to the Adrian's patchset?
> >>>
> >>> I think addressing Arnaldo's comment:
> >>> https://lore.kernel.org/lkml/ZR8QnasisGEsaaDR@kernel.org/
> >>> will need some changes to the patch series, and so I was waiting to
> >>> see the outcome of that.
> >>
> >> It seems it's done without further changes.  Can I get your Ack's now?
> >
> > With the unaligned.h patch on its own, I think patch 1 of 5 needs
> > dropping. For the rest I'm happy to acked-by.
>
> The new patch is on top of the others, so patch 1 is still needed.

I think I can squash it to the patch 1 if needed.

Thanks,
Namhyung
