Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745328479
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eh+J96NB"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7F5CE
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 15:35:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-502f29ed596so2363e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2023 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696545320; x=1697150120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKaIQ8Zyh16/tVcnFuQ7sDuazPniKY0bHDKBdsLSgQk=;
        b=eh+J96NBuFviMzGYQlf4gKBBEneDV9hiuYpnxbID13tIz/GUaGyVD2AtxSLHbKZ2YT
         zPgv1xGYVrkxBefoN08PQaUANOZGLHmJf1wdHVMu8Bd9uJ/HlbToiAbPTQu8iGYaQV1t
         pdTP/+58ifJeJaIcvJSaBC9hzmDBZSY5KZw5W7m9PRfvFTzH860suvBOKm2XoWem68Oc
         KJ0IvE6D/U6OAWdaj35peKV8AMGp5RD+vHyynr4vgRNbtzr9UJ63Pxi0TI6uynZtQ0V5
         XmH7mpoZGBAXxqJ67AXpFRYxNm4SJ+UX7xhRpXcG1vkyUZPAgcsvg1UVnkjvqpJLSnHn
         rF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545320; x=1697150120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKaIQ8Zyh16/tVcnFuQ7sDuazPniKY0bHDKBdsLSgQk=;
        b=iYns78b9ceIHwzowzS7cgWZ0EQbelKFDFT9ApF+5ugt5B29JP5KiKEEpBxOeqQXvWw
         tEjYTPfQDnGCZ50UkJN5skajAuOc/lFzsB53HQj6Y3Y8JDCzvkAJAvpkH4JbC1W3grBI
         sLJZ3tiBIWATimZ7cF16eX0ls15iiPbN+pPFrbya8oZ7yz82ePpCwZkoA3KEQyBIgiFR
         88kPdAW1JdS1nMaFlP6orBWO51rGErVWexfNjI+MUaA6YAWoTjkQ3qaVz5WVvJ3F2Ktw
         WFQgz0/ozRolxhRNkf0VcjWuQvUJFueq1zlt8MGlsnwMIghlyiuukF7dgyCR5VgpqeDF
         QmHA==
X-Gm-Message-State: AOJu0Yz0y2gHdB5RPtGVp98/BIYi/t2E3DvAkqnQtb8OCr5KQ9MpyiZ1
	8oW0+0+rKJ9n0TzmgN7VQjEPhGPpjcLJJE3r/JTi+w==
X-Google-Smtp-Source: AGHT+IFqiQSTSTwPTJ61CESf8GdTp78bw4W7PrhxaBvAYX3nwWRy9q/Us0yHiv3NoCGSa/fT9UUpSF7pItxtBuBJLKY=
X-Received: by 2002:a19:7006:0:b0:502:dc15:7fb with SMTP id
 h6-20020a197006000000b00502dc1507fbmr90726lfc.5.1696545319446; Thu, 05 Oct
 2023 15:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com> <20230923053515.535607-2-irogers@google.com>
 <CAKwvOdmHg_43z_dTZrOLGubuBBvmHdPxSFjOWa3oWkbOp2qWWg@mail.gmail.com>
 <CAP-5=fV6c1tWAd2GjMwn4PQN=3BXNQGz=vbonHSjRjQ3fbEL+g@mail.gmail.com>
 <ZRWMWcNKvZMgiAMR@bergen.fjasle.eu> <CAK7LNASuOWtd-iv2C3HLWr1oq9gD8BiP4B=8wRUo81CSK=g5Yw@mail.gmail.com>
In-Reply-To: <CAK7LNASuOWtd-iv2C3HLWr1oq9gD8BiP4B=8wRUo81CSK=g5Yw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Oct 2023 15:35:07 -0700
Message-ID: <CAP-5=fVz-Yqb_AnkJkoBAO8id7m2f0qaU_VnFVDoAXagwHfz6A@mail.gmail.com>
Subject: Re: [PATCH v1 01/18] gen_compile_commands: Allow the line prefix to
 still be cmd_
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ming Wang <wangming01@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yuan Can <yuancan@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 7:31=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Thu, Sep 28, 2023 at 11:26=E2=80=AFPM Nicolas Schier <nicolas@fjasle.e=
u> wrote:
> >
> > On Mon, 25 Sep 2023 09:06:11 -0700, Ian Rogers wrote:
> > > On Mon, Sep 25, 2023 at 8:49=E2=80=AFAM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Sep 22, 2023 at 10:35=E2=80=AFPM Ian Rogers <irogers@google=
.com> wrote:
> > > > >
> > > > > Builds in tools still use the cmd_ prefix in .cmd files, so don't
> > > > > require the saved part. Name the groups in the line pattern match=
 so
> > > >
> > > > Is that something that can be changed in the tools/ Makefiles?
> > > >
> > > > I'm fine with this change, just curious where the difference comes
> > > > from precisely.
> > > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > I agree. The savedcmd_ change came from Masahiro in:
> > > https://lore.kernel.org/lkml/20221229091501.916296-1-masahiroy@kernel=
.org/
> > > I was reluctant to change the build logic in tools/ because of the
> > > potential to break things. Maybe Masahiro/Nicolas know of issues?
> >
> > I haven't seen any issues related to the introduction of savedcmd_; and
> > roughly searching through tools/ I cannot find a rule that matches the
> > pattern Masahiro described in commit 92215e7a801d ("kbuild: rename
> > cmd_$@ to savedcmd_$@ in *.cmd files", 2022-12-29).  For consistency,
> > I'd like to see the build rules in tools/ re-use the ones from scripts/
> > but as of now I don't see any necessity to introduce savedcmd in
> > tools/, yet.
> >
> > Kind regards,
> > Nicolas
>
>
> tools/build/Build.include mimics scripts/Kbuild.include
>
> That should be changed in the same way.

Thanks Masahiro,

I support that as a goal, I'm not sure I want to embrace it here. For
example, in tools/build/Build.include there is:
```
# Echo command
# Short version is used, if $(quiet) equals `quiet_', otherwise full one.
echo-cmd =3D $(if $($(quiet)cmd_$(1)),\
           echo '  $(call escsq,$($(quiet)cmd_$(1)))';)
```

This is relevant given the use of cmd_ and not savedcmd_. In
scripts/Kbuild.include there is no equivalent, nor is there in
scripts. So do I dig into the history of echo-cmd unfork that, and
then go to the next thing? I find a lot of things like
tools/selftests/bpf won't build for me. When I debug a failure is it
because of a change or a pre-existing issue? Given the scope of the
Build.include unification problem, and this 4 line change, I hope we
can move forward with this and keep unification as a separate problem
(I totally support solving that problem).

Thanks,
Ian

> --
> Best Regards
> Masahiro Yamada
