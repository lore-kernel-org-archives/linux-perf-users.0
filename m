Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJprBs+a"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C04FF
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 13:13:19 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so1865e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 13:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701724397; x=1702329197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+Dl1d6P4p90dv5VdxYZbL5mNMDqiGBE2uSVy6Yzsvc=;
        b=WJprBs+aqu8xNEqIOcVtfs5SUOmnlVOtXqTDZdRtt5aviR1DQ0DtpogmYeObuwNm01
         jiFHou3uryvnBGGd7YUA115Qwblh/+eKIgJtNwdwjRLGJBy88sQEHAqP4jGnqAOkalo7
         WX0xuq4qZ/h1JjIu/YKyoLIs9gERWoFwM3GhhrfSMxuqnfhsA+X6i887W3SNa/MWSDgn
         MOa/FrwHP5qXbswPs9kGCDr5WAnj4RWTfGp+4eQrXXAu7mA3WSyq70aMJHgowlaw2MoE
         AdOdC2PrMmrk4jmY2bOXoLQnJkEjb8UHl7y7aFr6bw+7o29QJg1TLNXlliCFq/vFO3l/
         o8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701724397; x=1702329197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+Dl1d6P4p90dv5VdxYZbL5mNMDqiGBE2uSVy6Yzsvc=;
        b=Z1xZZbGIDp8cikYILmB8BzC/J5oBqypc4sHimxRi6r+Glh6mpfeZwqWC+Nxtwga0lU
         BuWW0RhJh0OSU2M2A7BBhAToTPD6p98tC7UV5/maEooU/pXoGOTvvd/rz00rCY4dpHNi
         FXpKZwhVQve8pNB1iJKH9AAO0yfiPfVynM4x9JTpYkcxnvrx5EBrPw7vWO0whB6fxXxS
         7oUjS/ThhMv/Mgp3W9gC/UWP7TOsLKbm0RLlOjgZfX4/BJ9qludvNkHSdAPmuPwhBb8D
         GsiJp0XPt/9XmMKGsyiSvYo2VN0kTPyOKf+7PKuq6/8DAhRVUFIio1pUDxBEcM20r5R5
         S+YA==
X-Gm-Message-State: AOJu0YwSD0mNsTQ3wPql2HtWwTh29V3eK1m+D1MFEZKYCV/Jc7m42/HK
	w4tCBmgY2rS8hlwJ1vcvMN/hxcdScFhkx6NgHGEHQe4Ed/NnuqHbHyXe+Q==
X-Google-Smtp-Source: AGHT+IFUGQiCVonpkjbD3G1w6HtwBrOXendCflfcgWfkve4cy1akFBvaxLgjGfoGqJUsaDbzDhEerx/X5MBOk5g+gUc=
X-Received: by 2002:a7b:cb59:0:b0:40b:4221:4085 with SMTP id
 v25-20020a7bcb59000000b0040b42214085mr433700wmj.1.1701724397294; Mon, 04 Dec
 2023 13:13:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123160110.94090-1-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fWtLHCyZh_6hBkCg16ekOXfwSGAVT9xvgKcUsMcu=Ou9w@mail.gmail.com>
 <ZW40nstmGUeV9Fie@kernel.org> <ZW406O38z3DmVwOX@kernel.org>
In-Reply-To: <ZW406O38z3DmVwOX@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 13:13:05 -0800
Message-ID: <CAP-5=fXWm_ZZjQ-36eTJTuWQsQwwCEXer22Oid7X-PSe8=WY1Q@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events: Update datasource event name to fix
 duplicate events
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@arm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:22=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Dec 04, 2023 at 05:20:46PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Mon, Dec 04, 2023 at 12:12:54PM -0800, Ian Rogers escreveu:
> > > On Thu, Nov 23, 2023 at 8:01=E2=80=AFAM Athira Rajeev
> > > <atrajeev@linux.vnet.ibm.com> wrote:
> > > >
> > > > Running "perf list" on powerpc fails with segfault
> > > > as below:
> > > >
> > > >    ./perf list
> > > >    Segmentation fault (core dumped)
> > > >
> > > > This happens because of duplicate events in the json list.
> > > > The powerpc Json event list contains some event with same
> > > > event name, but different event code. They are:
> > > > - PM_INST_FROM_L3MISS (Present in datasource and frontend)
> > > > - PM_MRK_DATA_FROM_L2MISS (Present in datasource and marked)
> > > > - PM_MRK_INST_FROM_L3MISS (Present in datasource and marked)
> > > > - PM_MRK_DATA_FROM_L3MISS (Present in datasource and marked)
> > > >
> > > > pmu_events_table__num_events uses the value from
> > > > table_pmu->num_entries which includes duplicate events as
> > > > well. This causes issue during "perf list" and results in
> > > > segmentation fault.
> > > >
> > > > Since both event codes are valid, append _DSRC to the Data
> > > > Source events (datasource.json), so that they would have a
> > > > unique name. Also add PM_DATA_FROM_L2MISS_DSRC and
> > > > PM_DATA_FROM_L3MISS_DSRC events. With the fix, perf list
> > > > works as expected.
> > > >
> > > > Fixes: fc1435807533 ("perf vendor events power10: Update JSON/event=
s")
> > > > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > >
> > > Given duplicate events creates broken pmu-events.c we should capture
> > > that as an exception in jevents.py. That way a JEVENTS_ARCH=3Dall bui=
ld
> > > will fail if any vendor/architecture would break in this way. We
> > > should also add JEVENTS_ARCH=3Dall to tools/perf/tests/make. Athira, =
do
> > > you want to look at doing this?
> >
> > Should I go ahead and remove this patch till this is sorted out?
>
> I'll keep it, its already in tmp.perf-tools-next, we can go from there
> and improve this with follow up patches,

Agreed. I could look to do the follow up but likely won't have a
chance for a while. If others could help out it would be great. I'd
like to have the jevents and json be robust enough that we don't trip
over problems like this and the somewhat similar AmpereOne issue.

Thanks,
Ian

> - Arnaldo
