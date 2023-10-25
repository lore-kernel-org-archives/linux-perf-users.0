Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445ED30CE4
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYi9bmqa"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B39C
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 09:32:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso3778e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698251545; x=1698856345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RrYQPJFTaF9eHsWeEz4ouiuIk+0VdZGsfuH8gBMKQA=;
        b=MYi9bmqaf2lnn/r/ug84pUgWrcl4rKpQlnr4Eda/HDIGTjkCZPo4YgW2ZwM2a+T8nf
         0h5QOsN6/xqEMsgQIHsK/ChsmeQOUE+EQb0XgjgEGmIUz3CSs6vizaGGVS2GThv8Rs4T
         2MUkWdjzlnQU8oKaWqTY08hjeflRtW3gOdVrWNah205YaPBAKnVdp8eXAOI0FqqPAVjA
         ldl4xa2QuAXYuVSxauKCzqjt75pKEvw7Ndtg8xQ0Eo3TGb3XGXt9ymwwET3MPZZZr/r3
         /V1jUeg7Degojatj85wpp0XkPfl7s7ErNEOcvisoV/SN0b+ajNP2vix3W5P9kAwKeZVl
         gAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698251545; x=1698856345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RrYQPJFTaF9eHsWeEz4ouiuIk+0VdZGsfuH8gBMKQA=;
        b=v45ed6E60/dQDHgNcNd6qoolyRiarn/X8nqPj6c+8Uy9Jyc6GXDUqKgv8xG2NUI2i7
         V7woFgj1/uLBjdxkSFB4UoJLD/gfVP5mQwBZg2Rm88bJNoljfGRH+MsRzdAKrbjw2Isv
         4K+ykLMww53rVAc8NNvKjvqkDp21DhcgUCSzi8CEP9AmgQDiq4OWEX5Eyi4Kn1x69VZG
         ptaTJ3XEwGn6Jhom1Oly5HkVn972cWMulWCaIACVl6S4nhwc4haPwfO6b2chl8BfHPGv
         IlHm/v+LmiurowfOkFE0M5M5FOorLGTgi1xDYKU3hL12GitYcP3z/PtjnOlUqXWJpW/N
         8VJg==
X-Gm-Message-State: AOJu0YzIRGa26XrdYc+5AGk6g/Jm0CjfqHlq74DeviwLQIx9mPCGM3oN
	707JFyhHEKbxO3wqbecaDhLS2+Xeb0w5Jq1/ze9DBg==
X-Google-Smtp-Source: AGHT+IHlxXBY5S8IIEwvvIghCepp0kFs+PipnTXtJXYgtD73BVfHvM50kgrDvxtuzx7rEProVJcPaNw7Ds42gItGHIQ=
X-Received: by 2002:ac2:58ef:0:b0:501:a2b9:6046 with SMTP id
 v15-20020ac258ef000000b00501a2b96046mr68549lfo.7.1698251544464; Wed, 25 Oct
 2023 09:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010065738.2536751-1-xu.yang_2@nxp.com> <DB7PR04MB51464A0BF392FAFF62000E8B8CDFA@DB7PR04MB5146.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB51464A0BF392FAFF62000E8B8CDFA@DB7PR04MB5146.eurprd04.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Oct 2023 09:32:11 -0700
Message-ID: <CAP-5=fX=WJZ1vHnomdugDmzvYdTKSRLnMo5rJcX36jZjO8SS=Q@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: add loaded_json_aliases firstly for perf_pmu__num_events()
To: Xu Yang <xu.yang_2@nxp.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"acme@kernel.org" <acme@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 6:43=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
>
> > After pmu_read_sysfs(), event aliases in json may be loaded for non-cor=
e
> > pmu. And pmu->event_table is NULL for non-core pmu.
> > If perf_pmu__num_events() didn't add loaded_json_aliases to the total
> > number, perf list will show below error:
> >
> > Unexpected event imx8_ddr0/imx8_ddr0/write-command//
> > ...
> >
> > This is because perf_pmu__num_events() didn't count correct events numb=
er.
> > This will allow perf_pmu__num_events() to get corrent events number.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Hi Xu,

I'm not sure how but this email fails my email filters, I also wasn't
able to update my filters (gmail) to capture this email. Patches
should be sent to linux-kernel@vger.kernel.org as well as the
linux-perf-user list. The scripts/get_maintainer.pl will show you who
to send the patch to.


> > ---
> >  tools/perf/util/pmu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 8de6f39abd1b..920ab1c2e93b 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1609,6 +1609,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
> >               pmu_aliases_parse(pmu);
> >
> >       nr =3D pmu->sysfs_aliases;
> > +     nr +=3D pmu->loaded_json_aliases;
> >
> >       if (pmu->cpu_aliases_added)
> >                nr +=3D pmu->loaded_json_aliases;

Given the count is added here, I'm not sure why you think adding it
twice makes sense?

Hopefully the code in perf_pmu__num_events is fairly self explanatory.
But I'll break it down:

if (!pmu->sysfs_aliases_loaded)
    pmu_aliases_parse(pmu);
nr =3D pmu->sysfs_aliases;

Rather than parse sysfs for the number of events, they are just loaded
and then the count used. This is simplest because sysfs and json may
contain the same event.

if (pmu->cpu_aliases_added)
    nr +=3D pmu->loaded_json_aliases;

Were all the json events loaded? If so, add those on to the count.

else if (pmu->events_table)
    nr +=3D pmu_events_table__num_events(pmu->events_table, pmu) -
pmu->loaded_json_aliases;

We haven't loaded the json events so go get a count of them. The
number of loaded_json_aliases is subtracted as events in the table may
match ones in sysfs, in which case the sysfs event is updated with
json information (see update_alias possibly called by
perf_pmu__new_alias). We don't want to double count the event, hence
the subtract.

return pmu->selectable ? nr + 1 : nr;

Return the count, +1 if the PMU is selectable without an event such as
intel_pt//

For me to understand your problem it would be useful to have the cpuid
information for your processor (from this I can find the json) plus
the contents of the /sys/devices directory for the PMU. So I can see
what kind of situation we have. You may be able to create a
reproduction so I can test, see:

tools/perf/pmu-events/arch/test/
tools/perf/tests/pmu-events.c

Thanks,
Ian

> > --
> > 2.34.1
>
> A gentle ping.
