Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BAF2C9E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C59B9E;
	Sun,  8 Oct 2023 22:24:40 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-277504a23a1so2989498a91.0;
        Sun, 08 Oct 2023 22:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696829080; x=1697433880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xpof+8MbEOLDax78hKDLCrUVP8odJ1HYCOuSnwvkb5I=;
        b=Es+LJpJkTC+2aHljVWmVOsCHsrWiX7jF+9fqTzpvtBZyPUVOtz4FHRtKCpAt+5zAN2
         GIpTUbfiIaZJZtxCU9x5YYMi71cT+3uJkP6AfrBCEEqqKEVEMwtEi4tTAx4azj/fMHpX
         J1ZSHG++9JOUlN77tHSWkAqX9yV8uAV3Ds7P1YXldvTYkyJLsJQaDARe3P4UqJnP3o/k
         0hDyohZ+yoL+UWGvLh2ARDquOtxDWPiXn5DeYMt6Z/dA0JG3InO4b6amy+XLkwfvtnRF
         cty3F3HzMoc8fTi5Yasdg5KJt1C6ztJ+H2b75DrVy28PwPbm+sGVhlXGdKV69OQqSaCx
         /SQg==
X-Gm-Message-State: AOJu0YylijT0CDCWG502i0+iQZJco7q3NxZokdtNeom36Bift7rxtY1P
	YGLS2IXNGVTXGE9izvouikuo95SMw6NEd4mLI0Q=
X-Google-Smtp-Source: AGHT+IGlZTVUJimbJ4382rrvyMBBLWKp02q9nIUsfNPqYSn9dUx1CL3d3IRwDhiTd8SL9iGmefccuffFCWqnQltCM2Q=
X-Received: by 2002:a17:90a:5415:b0:279:5a3:d5f with SMTP id
 z21-20020a17090a541500b0027905a30d5fmr18561685pjh.9.1696829079975; Sun, 08
 Oct 2023 22:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230930060206.2353141-1-irogers@google.com> <CAM9d7chAvXoU90uCNAqr6DxH1-pUYqd82_BAdoZjjs1Uscm8Vw@mail.gmail.com>
 <CAP-5=fWDzjtkf7cSZVgSYUzFohH0tp81A7muke_+bH7rgnGJxw@mail.gmail.com>
In-Reply-To: <CAP-5=fWDzjtkf7cSZVgSYUzFohH0tp81A7muke_+bH7rgnGJxw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 8 Oct 2023 22:24:29 -0700
Message-ID: <CAM9d7chtUBQVq-EWeGUfdGHcriNvG=p5=L+m0c3jFr98LgdvgQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Avoid system wide when not privileged
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 10:10=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Oct 2, 2023 at 9:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Hi Ian,
> >
> > On Fri, Sep 29, 2023 at 11:02=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Switch the test program to sleep that makes more sense for system wid=
e
> > > events. Only enable system wide when root or not paranoid. This avoid=
s
> > > failures under some testing conditions like ARM cloud.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > While I'm ok with the change, I wonder why it doesn't have the same
> > code structure as in the stat_all_metrics.sh which checks the actual re=
sult.
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> The metric group isn't printed when we print the metrics within it.
> This could be changed.

Ok, we can change it later.  Applied to perf-tools-next, thanks!
