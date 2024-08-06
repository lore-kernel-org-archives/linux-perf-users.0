Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E23B1AC
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959416; cv=none; b=cYlHgN/evhEHv9lVe5BXGggd4j8KthH/ASgsI0mUVUPKrophfnq+XlFYyPalKrwF+2UpwC+5BZez3/w1duwKJaduJyHwbW0rfmoJzEX37rUbRPNE2CYFX0BR84hbXuA+CmEqOJBLFfELXKcOVMFRLFQDoRwih5MsnfmVLuUanu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959416; c=relaxed/simple;
	bh=8F/sdfwOgYrozXSYzhW6xlVGWL5FX8sCck7YmA7e/mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZfehEmKOKD/duC3WJA1heWfgqWMogflIYGNGey1jiNYyt/l+CvOngYSQtI7Nx852yua95YIblZZk2uLGx4IyOuLOrD/yy/is5qZfE93OBKuHsjsxMXkupYfJ3PLhYUGdFFkioh1DhuRMVSi0zcLgT/GQYfWm3lOQek6EKxThyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cjWrwhOM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cjWrwhOM"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f16d2f2b68so13659941fa.3
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722959413; x=1723564213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F/sdfwOgYrozXSYzhW6xlVGWL5FX8sCck7YmA7e/mo=;
        b=cjWrwhOMAHiYkbqzY2U3HTQZbQXR7v6c9JBKTRVXLqYZTtEMK9BWjixQ656rZ7o6wa
         sccPWl/5xqcNGBR2tJ+Ha4cvuBqbVfQlYqCKC5Ux5TOWirR80KnwsV6exc2PL6eVdawX
         oy0gIpyucHMe/F1B/OPbgvyXQqMuH2RdM8Wdb66yUclOlEN1q3DAxn5p2rm+HhaxjHvN
         m1C0bV3uCRHiGcegXcn2n74IOIDwx74zVDfci6YjBzpRnDx8cG7oF1qWAGzQYc1aPTcp
         h56LVugsqWDzs1W1v4tSQmwhllOky/4Leg4Hw9nqUowgq4ZDMNCBo9uL1jJiNXclIhpB
         rC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959413; x=1723564213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8F/sdfwOgYrozXSYzhW6xlVGWL5FX8sCck7YmA7e/mo=;
        b=hb4YGF4mh4PECtT50Z+zVihzoNOOG1o32aD/hlSKI1fo2wIRXzxjtvSsg4IknDQz9V
         0iMcsrSe6UtcZC8443Iv8a+evUxQnUcO61jRxfE4AIwzkxWMuXqx/KcDXHfQeOKxG3qS
         vrVObWeSBrIR6a8jNUnFRbAeFlZE5Uv7xygXyEF19qUnKxDXe+b7KSE8l5WZcImusaXk
         khjj30Uo4tqKlpncJVASTazqTXEeJHQqTTcGeq4sZteAqCJdooqjTnPXQL+S+JSmEVnX
         i5V7VrV0NXKgzS4AtGfe7i2ogpG7ZSxSc43m5VSoQotZAEu30ho/CcmqBPYH/0Gvn9WI
         evGw==
X-Forwarded-Encrypted: i=1; AJvYcCXIIfzetb+gccPxbo+Q10H9wHHZeDBRGmqjMcEJ40aBq9Vz8CzO49gx8y7eXBipuVtVMgJlxawQnsI1VP69YY6gMeu0kYr+Uhn7cyPQAFoYow==
X-Gm-Message-State: AOJu0Yws2gK9dhPE1KJWP1TUzN3gj7kxLEmLPTApjbVU40szye5E55WI
	NgJkATcpjqNB6bmTGBb1KMFCTHMTwOCXm0wXuOtqipeawSeBxfFvyrdVdOL4PA7SFuFwKYq/Wob
	xcgKKlRcn85LKLunoHrlfgKO77jWRXW40+OWyPQ==
X-Google-Smtp-Source: AGHT+IEKRNQL6v8yZxwZiugCHsLJCc91BgG6XIW8t6WKvKDPtqvKAcvwQ3Mf0Z6iVsyMeVqV3TUGbDZ5W+id3C9qS34=
X-Received: by 2002:a2e:9ed3:0:b0:2ef:17ee:62a2 with SMTP id
 38308e7fff4ca-2f15aaab018mr133316761fa.14.1722959412812; Tue, 06 Aug 2024
 08:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com> <20240805194424.597244-4-irogers@google.com>
 <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
 <CAP-5=fWDmdAkJSoncedZTaSgFwG+p3--jywDj9krnXSfkhh6dQ@mail.gmail.com>
 <ZrInOywRKzRmjtKF@x1> <ZrIqR07cYJnhcTq8@x1>
In-Reply-To: <ZrIqR07cYJnhcTq8@x1>
From: Eric Lin <eric.lin@sifive.com>
Date: Tue, 6 Aug 2024 23:50:01 +0800
Message-ID: <CAPqJEFoFfCG0_fqkVqakUK7CWs_8WREpmAd+f3H26UasGRPz2Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware event
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Charles Ci-Jyun Wu <dminus@andestech.com>, 
	Locus Wei-Han Chen <locus84@andestech.com>, Atish Patra <atishp@rivosinc.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Guilherme Amadio <amadio@gentoo.org>, 
	Changbin Du <changbin.du@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com, 
	greentime.hu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Tue, Aug 6, 2024 at 9:51=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Aug 06, 2024 at 10:38:07AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Aug 05, 2024 at 09:05:26PM -0700, Ian Rogers wrote:
> > > On Mon, Aug 5, 2024 at 8:54=E2=80=AFPM Eric Lin <eric.lin@sifive.com>=
 wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > I've sent a patch to fix it and the patch already merged. Thanks.
>
> Also, already merged where? Upstream? In the riscv kernel tree? where?
>

The patch already merged to Linux upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D63ba5b0fb4f54db256ec43b3062b2606b383055d

Thanks.

Best regards,
Eric Lin

> - Arnaldo
>
> > > > https://lore.kernel.org/all/20240719115018.27356-1-eric.lin@sifive.=
com/
> > >
> > > Hi Eric/Arnaldo,
> > >
> > > Right, I already commented this should have gone through the
> > > perf-tools-next tree:
> > > https://lore.kernel.org/all/CAP-5=3DfV3NXkKsCP1WH0_qLRNpL+WuP8S3h1=3D=
cHaUMH5MFkVHQg@mail.gmail.com/
> > > Arnaldo, please take Eric's patch in preference to this one.
> >
> > So I removed your version from perf-tools-next, eventually we'll get
> > this merged upstream, I'm just checking this isn't going to get in our
> > way of testing what we have in perf-tools-next...
> >
> >
> > - Arnaldo
