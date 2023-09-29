Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE627705
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 16:45:24 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5BFD6
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:45:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-419768e69dfso453131cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696005922; x=1696610722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNMPH3AbfXZ4xoyHo8Y8TRX7JVoOIIReWOsxmWerZzk=;
        b=wZb1f8y+CT001qljGEyNs4djdeTQcSZok4TLqmkuEVqunLzZKmMyulHgLeJ5yI/qa0
         Fw9hIMIihKhgr61iXO72D7ePf1xF8kpq0xJssqsGGqzeUJS5z2VuYAM2pcIFZLfniDFs
         lMC3FrIB2nn4oumVjqrzc1qNfMu9HdSBwVT1Gij+nzfzxlzD5Iegf6QSmO25OiccHgLt
         iy/VXaHcMsRbRIsxRBvyTP9Iku+zQytGe4+SSa+FARr2V1sbYauES5LPK/h3YTD7hqjm
         esM798CZyfbTC3YFa4P/3UixwH6ZRD+WnzV3ViYk3ObhWMx5gyzxQF7BtTSQytEdbWFp
         7JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696005922; x=1696610722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNMPH3AbfXZ4xoyHo8Y8TRX7JVoOIIReWOsxmWerZzk=;
        b=f6qPO7c+HK74F05SFBMumDEEkw6eFcyqVNt+SDwOQRRu2pGvW1P+kLDRDhWwhPVXfE
         f0Z6vUcpdB352A6WG65xJEFkmITLWAMWkTQdn0gt/0y4wovS1+pqVv5OI48CjU+G/mHL
         yIZbDeNrhpVJx1OYNaa7vNTdo6P53ElBufrp20VXuwLmp0ZlGGGOYAvbc3zUx8VsZkxR
         4lK/c9VrObbbgOkD2ltpp0asKWlEHnU/610/So2WyYqIdaK6GvfmVRp0pxClZMPay027
         Ek0uAIPY/vz7nPiLs0AwB4JcEKYeVAkKRRxV5OShXaFodC/dMOaBRwT/L3zL32cnxa3L
         PtZg==
X-Gm-Message-State: AOJu0YxflWfRUF9wZiAfV2bGlzo94FCKO8BPV5xtZNkokN4CAP2nozkY
	x1LfoqG5lrMojs3tpLyPwfVrvrEJ/gBGaDhx28LL7QDsx3o2c1P+3QZzbQ==
X-Google-Smtp-Source: AGHT+IFwgzVRVB0jJaSWtfmiSBfqYdIa5/64D2eUWJ/ivxKz4lvNoe9BcHgDcYr1L/zUX/Yk3wR3zbi3G6CWdmbPd40=
X-Received: by 2002:ac8:5910:0:b0:419:7d7e:7d83 with SMTP id
 16-20020ac85910000000b004197d7e7d83mr181697qty.5.1696005921963; Fri, 29 Sep
 2023 09:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PAWPR04MB97658DD9546C6D0A141C0766EAC3A@PAWPR04MB9765.eurprd04.prod.outlook.com>
 <CAP-5=fVPVodcSkOHnJOrgkUO1QOnNTcsPMsfeEKvzjTvqA2K+w@mail.gmail.com> <ZRb+ijwAImHsrSnv@anisse-laptop>
In-Reply-To: <ZRb+ijwAImHsrSnv@anisse-laptop>
From: Ian Rogers <irogers@google.com>
Date: Fri, 29 Sep 2023 09:45:10 -0700
Message-ID: <CAP-5=fWrQV0frxn4Re3G1X+APTiczpHoTUBozdenLBC7YUfhsw@mail.gmail.com>
Subject: Re: [6.5.4] perf: bison min. requirements
To: Anisse Astier <anisse@astier.eu>
Cc: Pierre Cheynier <p.cheynier@criteo.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 9:42=E2=80=AFAM Anisse Astier <anisse@astier.eu> wr=
ote:
>
> Hi Ian,
>
> On Tue, Sep 26, 2023 at 02:28:50PM -0700, Ian Rogers wrote:
> > On Tue, Sep 26, 2023 at 1:21???AM Pierre Cheynier <p.cheynier@criteo.co=
m> wrote:
> > >
> > > Dear list,
> > > At compiling 6.5.4 it seemed to me that this specific patch [1] added=
 an implicit dependency to bison >=3D 3.7.4, due to usage of YYNOMEM.
> > > Shouldn't this be part of Documentation/process/changes.rst?
> > >
> > > [1] https://www.spinics.net/lists/linux-perf-users/msg30885.html "per=
f parse-events: Separate YYABORT and YYNOMEM cases"
> > >
> > > Sorry for the noise, and thanks for inputs if ever I'm totally wrong =
here.
> >
> > We have a workaround to #define YYNOMEM to YYABORT when Bison is
> > less-than 3.8.1:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/Build?h=3Dperf-tools-next#n323
> > Perhaps you can help debug why this build logic isn't working for you?
>
> This fix (commit 88cc47e245979 in perf-tools-next) has reached Linus'
> tree, but not yet stable.
>
> But code using a more recent Bison is now backported to v6.5.4 (stable
> commit 0e8501c8a936e0b2ff4ffdff2c4866ba74969189, upstream commit
> 77cdd787fc45e3426b8e0b5038b85c276540dfb4), which is what causes the
> build regression on older bison that Pierre reported.
>
> Someone else noticed and already asked for a backport:
> https://lore.kernel.org/all/CAM9d7cggeTaXR5VBD1BoPr9TLPoE7s9YSS2y0w-PGzTM=
AGsFWA@mail.gmail.com/

Great! Fwiw, Linux perf is backward compatible with older kernels and
so using the backport version makes little sense. Ideally Linux perf
would be decoupled by package maintainers and allowed to follow Linux
at head.

Thanks,
Ian

> Kind regards,
>
> Anisse
