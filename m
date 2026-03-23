Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184431F9A8
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291694; cv=pass; b=q2dSzYgz29Us4Q9wEjMh7r5Ke9dUJrQ6RCqHqPZekgs2FpO3l2dbbVKWhEfmw5riJBl5kf4snLCekOzBsp/uwAGDP9uahzkiqs/ayBUBUeKn0c/Acch/fghgHZDpeuWMNBWd4+bRoLCTzd8umP5hKGReg7fgtmFLLwQu0ydR+iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291694; c=relaxed/simple;
	bh=MB65yswpmzE52DfyCvLz9QRDR8XnIT4yINdZfNtP86Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCXhfg24rl7mtCoQE/Yjn4D+9m5qhZfqWoliNi1cpWoprB35fqFn6boEn4IsTUb+oQ66h9gZWX/rcTq5MdTAOw0vxoBur2dk6xua4RjehLJ2qqo+jmrlSUvBzzpzWBqH2eVNQwMxPwN1lNC9cFjo6fDFQBwKZAJ3fjQdEpN5+Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5hoiPCO; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5hoiPCO"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1270fc2bdf2so1963c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 11:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774291692; cv=none;
        d=google.com; s=arc-20240605;
        b=WDZWtJNXPB3wy9POjIJy08pFpGVqhCFz8Gy81bdfvExhFfJIg94uFEEiF2EqtxFsdy
         KmpTW2mxTujDI4LdBeG7lsqQ1jLewQor4Pi17b/lT0+vss7KRbak5UE/OgLq89oaSs6V
         GOw3xC7xgDB1XgPoO7JgkcWgeYiU6FlV9tiMB8P4nfvM7Dey1S1AebT3JO5zxDQ4TPTZ
         sg+piXvryS7V1WZaKeHAMxDQUNUrlfYFuWPeWbfFEl+Hd6edbsZJnZzHiD6IP+mFMl16
         X23HWbimtlBcllJ1Qsx3rhmevt2p7C5KJAff1mLg5woj3kbqL3mwBniL9bH6wyKgGyKk
         rYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=whjjvimScDBVewyWwcwuS5G66IL1vUadauaQxpQ3HnY=;
        fh=Ib4RGcv4llhsLk12qaIswnADGWKkdzh61XCSci3l5dM=;
        b=M1PZK2NMZft6kufxjU7QzpXzo/Bj8Yjtm99XylyY+5MAghsxb+ufuwNUsIz/5lTuwo
         giLho32zIgzU2qqM0lZ5RBPX4XXicyfGd6RYSAWI+rxFnu6hHA2kU5A1CH748WuteXsX
         wEXgMvnPxdUDdm8BuyQiPA6+Wyc7oNhrT6zZ6L/5NP+PKCWYgad6BIeakI7wJ8WEcHg+
         dfz7HE+X8V4u/nZkuW9pTHSo8ZilEbU42dPJlVz+r29I4NL1954G3ZN1R7GA0bl1kO/E
         gCQtsUXGpSvIZrQQZp9UwEKXxnQZXyeTrb2flCWQkDiQ0NYAkOnbiXjKB3B7LN/So2kE
         Sm7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774291692; x=1774896492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whjjvimScDBVewyWwcwuS5G66IL1vUadauaQxpQ3HnY=;
        b=a5hoiPCOr3FEmotZCnmPfy2xAmLdyVQF5OOQCEBBdo3T/iitSANbnuU5n6Wc51ksgM
         jWwWSLZlPuJgY07if5EBQZwB7tJGrjW2IxtAn2Ec7puwTKatSIndpFjxGHsw8pql8Q0N
         yg2BSLeplrBX7wueReUSDo5ZZhZRL1TzK2V/96qYZQk2odA94EL8SQuElACZ+McpvEpE
         XJzn4CtA7UNK9vRnbWsqaPc/dV1KtcNIQA0Z+bIo4kAL4zCix9R8V+IDGdGS1ZAeOfZC
         9yk8IMJuBc2tmbFlzR8Q+MLgItMV714i1SCWtrfUhtUipd/PG3IIbg2Hhk8p+OSxlrPS
         8dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291692; x=1774896492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whjjvimScDBVewyWwcwuS5G66IL1vUadauaQxpQ3HnY=;
        b=Mte3Pkyziknn6BDxJZ9AeF5p8kgFM1bloK0yUkZKRvH5ASZ2uGGjRzHb9SX1Q0r7L7
         XfXCbaaqKiZHMnFkeACbN5HVuEbRwHRU/keDwfkuGDKqre9OmMpquGF9/HHxopuOhpgU
         tGBOIymmBCQuS+DtXLJGUqhFJybcN/Al0MtgRVKv2+MTD1W3T/AXhCJLFJQ4AthOaE0L
         SzaIlPwguW9y6ovGDIewfLeyPZI3ZQM3hMHyIIKP5dL4CL53qdl52c5hI0L5JdlPWEcQ
         zAc/uHr45UDI26cQXX94hfJc4FuM8FOnyx5L2+PGD9uHru5gsOFGjCe6Sq4Ana0AbuDo
         hfgw==
X-Forwarded-Encrypted: i=1; AJvYcCX5sYmNN8KCb7oToJMAS0nG3t3d6vMPq4cK2idF9eQ+RmFTuSHbJbt4Ru7acPcPqNQAxmuYw8EUlAG4bNQ3Y1uJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmOK9p1ppfVrRzRCRCZuCcYPAYgtaRhxn3BPZ2Y23w2yRd1kC
	qoNhCSlJjTUXj5Jw4sanoWJ6igmQJFncSjNBWgQl2tBlvQqUS3jSZZQgHNpvMzlIABXlriGkVCI
	o1ksNq2p29R1WXCfoxhLMJUlaLlTxoER2biO3YDPV
X-Gm-Gg: ATEYQzwDk9C9cO0VMZNqygWXlF1j44RUJflWLYwbqzhL201tDzLz+X0CfSQHgHmdXiG
	U9YxEnwOQ/bRAg+jYJzgByKM7tknln8zC9qgGn+dFslJJPTFbaVjYVoifqrKWaFNoqzAFGSMLCp
	58xMvUq1974oHrThdUN9hdsrtdBliOVD+QY4sU3lUrMLw3H3rDk1t6D+Mm87doPc3R0GOAd5Gxf
	kNYyPaq+wHPiHFV/4fq1cAHeSEEk03qJFHh2lI7PrH68rht874mRUNQHNA86UotRCCIla+OOst2
	Cn+CvWGULrMHb5Ym88DIcH8VX+vHAbwre1C7Vw==
X-Received: by 2002:a05:701b:2719:b0:12a:6ca2:3085 with SMTP id
 a92af1059eb24-12a8e72d8b1mr13551c88.18.1774291691020; Mon, 23 Mar 2026
 11:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314083304.75321-1-atrajeev@linux.ibm.com>
 <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com> <CAP-5=fVcWpBTALH1zr7dL3qH9j24c3t3L0zvExaWbnC-2tXjcg@mail.gmail.com>
 <AD8DAAE1-50E9-45CD-AD81-D9DFF139B362@linux.ibm.com> <8C75E314-2038-4A76-BA4F-F36AE3F30B0B@linux.ibm.com>
In-Reply-To: <8C75E314-2038-4A76-BA4F-F36AE3F30B0B@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 11:47:58 -0700
X-Gm-Features: AQROBzCkCY-gzX_BTnf1QZfpfdHg1WjDHCzE2j3_luUCpN1rSSkLLcz8j3iVv8Y
Message-ID: <CAP-5=fXcZVxKcfV5giqDWxBPm53cNYLGhrTL8Q=uibrqJPmzgw@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix the check for parameterized field in
 event term
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Venkat <venkat88@linux.ibm.com>, jolsa@kernel.org, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 5:19=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
>
>
> > On 18 Mar 2026, at 12:05=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.=
com> wrote:
> >
> >
> >
> >> On 17 Mar 2026, at 9:39=E2=80=AFPM, Ian Rogers <irogers@google.com> wr=
ote:
> >>
> >> On Tue, Mar 17, 2026 at 1:56=E2=80=AFAM Venkat <venkat88@linux.ibm.com=
> wrote:
> >>>
> >>>> On 14 Mar 2026, at 2:03=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ib=
m.com> wrote:
> >>>>
> >>>> The format_alias() function in util/pmu.c has a check to
> >>>> detect whether the event has parameterized field ( =3D? ).
> >>>> The string alias->terms contains the event and if the event
> >>>> has user configurable parameter, there will be presence of
> >>>> sub string "=3D?" in the alias->terms.
> >>>>
> >>>> Snippet of code:
> >>>>
> >>>> /* Paramemterized events have the parameters shown. */
> >>>>      if (strstr(alias->terms, "=3D?")) {
> >>>>              /* No parameters. */
> >>>>              snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->=
name, alias->name);
> >>>>
> >>>> if "strstr" contains the substring, it returns a pointer
> >>>> and hence enters the above check which is not the expected
> >>>> check. And hence "perf list" doesn't have the parameterized
> >>>> fields in the result.
> >>>>
> >>>> Fix this check to use:
> >>>>
> >>>> if (!strstr(alias->terms, "=3D?")) {
> >>>>
> >>>> With this change, perf list shows the events correctly with
> >>>> the strings showing parameters.
> >>>>
> >>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> >>
> >> Thanks Athira, Sashiko is noting in its review:
> >> https://sashiko.dev/#/patchset/20260314083304.75321-1-atrajeev%40linux=
.ibm.com
> >
> > Thanks Ian for pointing this. Its interesting to see this review.
> > I will check through the review.
> >
> > Thanks
> > Athira
> >>
> >> By inverting this check, parameterized events now proceed to
> >> parse_events_terms() and the rest of format_alias().
> >>
> >> If a parameterized event uses a built-in perf keyword for its paramete=
r name
> >> (e.g., config=3D?), the lexer parses it as a predefined term token, wh=
ich sets
> >> term->config to NULL.
>
> Hi All,
>
> sashiko brought up a scenario :
>
> =E2=80=9CIf a parameterized event uses a built-in perf keyword for its pa=
rameter name
> (e.g., config=3D?), the lexer parses it as a predefined term token, which=
 sets
> term->config to NULL."
>
> Existing usage for parameterized events in perf:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In perf,  =E2=80=9C?=E2=80=9D is often used in event aliases to indicate =
that a parameter needs to be provided
> by the user (e.g., param1=3D?). This information is exposed via =E2=80=9C=
format=E2=80=9D in sysfs too.  The current way,
> how this is consumed in different PMU drivers is: example:
>
>   # cat /sys/devices/pmu/format/param1
>     config:12-15
>
>    # cat /sys/devices/pmu/format/param2
>     config1:0-17
>
> Here param1 uses bits 12:15 in config and param2 used bits 0:17 in config=
1
>
> And event will use these parameterized fields:
>     #cat /sys/devices/pmu/events/event1       domain=3D1,param1=3D?,param=
2=3D?
>
> =E2=80=9CPerf list=E2=80=9D expects "param1=3D?,param2=3D?=E2=80=9D In th=
e event listing
>    # perf list|grep event1
>    pmu/event1,param1=3D?,param2=3D?/                       [Kernel PMU ev=
ent]
>
> The patch here address fix in =E2=80=9Cstrstr=E2=80=9D check in format_al=
ias for =E2=80=9Cperf list=E2=80=9D to display these user expected =E2=80=
=9C?=E2=80=9D fields
> in event alias.  Traditionally, perf treats config, config1, and config2 =
etc as hardcoded numeric
> keywords or builtin keyword.
>
> The scneario sashiko brought up is interesting. Where a parameterized eve=
nt
> uses a built-in perf keyword  for its parameter name.
>
> sashiko review : Scenario where parameterized event uses a built-in perf =
keyword
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Example, having =E2=80=9Cconfig2=E2=80=9D in sysfs format-driven logic. B=
elow is an example case.
>
>     #cat /sys/devices/pmu/events/event1
>      config2=3D?,domain=3D1,param1=3D?,param2=3D?
>
>       # cat /sys/devices/hv_24x7/format/config2
>          config2:0-16
>
>  Here =E2=80=9Cperf list=E2=80=9D will show as (null) or might crash too =
as sashiko review pointed out.
>
>     # perf list|grep event1
>     pmu/event1,(null)=3D?,param1=3D?,param2=3D?/                    [Kern=
el PMU event]
>
> This is because term->config is null for built-in keywords. perf lexer se=
ts this to NULL
> for predefined keywords ( like 'config', 'period'), storing the type in t=
he enum instead.
>
> To fix displaying the =E2=80=9C=3D?=E2=80=9D in =E2=80=9Cperf list=E2=80=
=9D for keywords like config2,  format_alias() function needs to handle
> null term->config , ie by using parse_events__term_type_str() to map NULL=
 config
> pointers back to their string keywords
>
> But this only will fix the =E2=80=9Cperf list=E2=80=9D part of it.  =E2=
=80=9CPerf stat=E2=80=9D or record will still fail since
> currently these keywords are not considered as placeholders for =E2=80=9C=
?=E2=80=9D values.
>
> If a PMU wants to use any builtin-keywords in parameters and want to ensu=
re
> it is set by user, this could be useful.  Again considering this as a use=
 case, we need other changes
> to allow these built-in keywords to function as placeholders (e.g., confi=
g2=3D?) within a PMU alias.
>
> I am adding changes which I have identified needed for this support.
> If it is better to post this separately as patch set and discuss, definit=
ely will do that.
> I wanted to run the idea of this new scenario with everyone. Apologies fo=
r the long text.
>
> Thanks and looking for comments.
>
>
> From 21179a76be97ef81c69a9492f0f432dec5b5361c Mon Sep 17 00:00:00 2001
> From: Athira Rajeev <atrajeev@linux.ibm.com>
> Date: Mon, 23 Mar 2026 08:38:30 -0400
> Subject: [PATCH] tools/perf: Enable parameterized values for keywords lik=
e
>  config1
>
> PMU defines events that require user-supplied parameters (like chip
> or core) are packed into specific bit-fields of the different config
> registers. Traditionally, perf treats config, config1, and config2
> as hardcoded numeric keywords, causing it to bypass the sysfs
> format-driven bit-masking logic.
>
> This patch allows these built-in keywords to function as placeholders
> (e.g., config2=3D?) within a PMU alias.
>
> Changes includes:
> - Updated config_term_pmu in parse-events.c to recognize string
>   placeholders for event terms. otherwise it will expect those to
>   be of type PARSE_EVENTS__TERM_TYPE_NUM
> - Updated pmu_config_term in pmu.c to make sure if keywords are used
>   as placeholders , they pass through sysfs based format logic
>  (pmu_find_format) and pmu_resolve_param_term() logic
> - Modified format_alias() to ensure "perf list" display the parameterized
>   events correctly
> - Replace snprintf with scnprintf in buffer offset calculations to
>    ensure the 'used' count will not exceed the "len"
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>  tools/perf/util/parse-events.c |  5 +++++
>  tools/perf/util/pmu.c          | 37 +++++++++++++++++++++++++---------
>  2 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index b9efb296bba5..282b0a0a5340 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1051,6 +1051,11 @@ static int config_term_pmu(struct perf_event_attr =
*attr,
>                  */
>                 return 0;
>         }
> +
> +       if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR && term->va=
l.str)
> +               if (strstr(term->val.str, "?"))
> +                       return 0;

nit: Since the nested if spans more than two lines, could you add
curly braces {} to the outer if statement. Could you also add a
comment explaining why the runtime parameter causes an early return
and why you used `strstr` instead of `strcmp`?

> +
>         return config_term_common(attr, term, parse_state);
>  }
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 23337d2fa281..2c4503e1a11b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1442,10 +1442,19 @@ static int pmu_resolve_param_term(struct parse_ev=
ents_term *term,
>                                   __u64 *value)
>  {
>         struct parse_events_term *t;
> +       const char *name =3D term->config;
> +
> +       if (!term->config)

I think you meant "if (!name)" here.

> +               name =3D parse_events__term_type_str(term->type_term);
>
>         list_for_each_entry(t, &head_terms->terms, list) {
> +               const char *t_name =3D t->config;
> +
> +               if (!t_name)
> +                       t_name =3D parse_events__term_type_str(t->type_te=
rm);
> +
>                 if (t->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM &&
> -                   t->config && !strcmp(t->config, term->config)) {
> +                   t_name && name && !strcmp(t_name, name)) {
>                         t->used =3D true;
>                         *value =3D t->val.num;
>                         return 0;
> @@ -1453,7 +1462,7 @@ static int pmu_resolve_param_term(struct parse_even=
ts_term *term,
>         }
>
>         if (verbose > 0)
> -               printf("Required parameter '%s' not specified\n", term->c=
onfig);
> +               printf("Required parameter '%s' not specified\n", name);
>
>         return -1;
>  }
> @@ -1494,6 +1503,7 @@ static int pmu_config_term(const struct perf_pmu *p=
mu,
>         struct perf_pmu_format *format;
>         __u64 *vp;
>         __u64 val, max_val;
> +       const char *name;
>
>         /*
>          * If this is a parameter we've already used for parameterized-ev=
al,
> @@ -1507,7 +1517,8 @@ static int pmu_config_term(const struct perf_pmu *p=
mu,
>          * traditionally have had to handle not having a PMU. An alias ma=
y
>          * have hard coded config values, optionally apply them below.
>          */
> -       if (parse_events__is_hardcoded_term(term)) {
> +       if (parse_events__is_hardcoded_term(term) &&
> +                      term->type_val !=3D PARSE_EVENTS__TERM_TYPE_STR) {

What is being guarded against in this case? Could you update or add a comme=
nt.

>                 /* Config terms set all bits in the config. */
>                 DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
>
> @@ -1576,7 +1587,11 @@ static int pmu_config_term(const struct perf_pmu *=
pmu,
>                 return 0;
>         }
>
> -       format =3D pmu_find_format(&pmu->format, term->config);
> +       name =3D term->config;
> +       if (!name)
> +               name =3D parse_events__term_type_str(term->type_term);
> +
> +       format =3D pmu_find_format(&pmu->format, name);
>         if (!format) {
>                 char *pmu_term =3D pmu_formats_string(&pmu->format);
>                 char *unknown_term;
> @@ -2117,7 +2132,7 @@ static char *format_alias(char *buf, int len, const=
 struct perf_pmu *pmu,
>                                                    skip_duplicate_pmus);
>
>         /* Paramemterized events have the parameters shown. */
> -       if (strstr(alias->terms, "=3D?")) {
> +       if (!strstr(alias->terms, "=3D?")) {

I wonder if it would be safer if we did a `str_ends_with(alias->terms,
"=3D?")`. This likely applies to the other strstr usage.

Thanks,
Ian

>                 /* No parameters. */
>                 snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->na=
me, alias->name);
>                 return buf;
> @@ -2129,15 +2144,19 @@ static char *format_alias(char *buf, int len, con=
st struct perf_pmu *pmu,
>                 pr_err("Failure to parse '%s' terms '%s': %d\n",
>                         alias->name, alias->terms, ret);
>                 parse_events_terms__exit(&terms);
> -               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->na=
me, alias->name);
> +               scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->n=
ame, alias->name);
>                 return buf;
>         }
> -       used =3D snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->na=
me, alias->name);
> +       used =3D scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->n=
ame, alias->name);
>
>         list_for_each_entry(term, &terms.terms, list) {
> +               const char *name =3D term->config;
> +
> +               if (!name)
> +                       name =3D parse_events__term_type_str(term->type_t=
erm);
>                 if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
> -                       used +=3D snprintf(buf + used, sub_non_neg(len, u=
sed),
> -                                       ",%s=3D%s", term->config,
> +                       used +=3D scnprintf(buf + used, sub_non_neg(len, =
used),
> +                                       ",%s=3D%s", name,
>                                         term->val.str);
>         }
>         parse_events_terms__exit(&terms);
> --  2.47.3
>
>
>
> Thanks
> Athira
>
> >>
> >> Does this cause a NULL pointer dereference in the term iteration loop?
> >>
> >> list_for_each_entry(term, &terms.terms, list) {
> >> if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
> >>   used +=3D snprintf(buf + used, sub_non_neg(len, used),
> >>     ",%s=3D%s", term->config,
> >>     term->val.str);
> >> }
> >>
> >> Passing a NULL pointer to the %s format specifier for term->config mig=
ht
> >> cause a segmentation fault or formatting corruption.
> >>
> >> Can this also lead to a stack buffer overflow due to how snprintf() re=
turn
> >> values are accumulated?
> >>
> >> snprintf() returns the number of characters that would have been writt=
en.
> >> If the event names and terms are long enough, the "used" variable can =
exceed
> >> "len" (which is typically 1024 bytes).
> >>
> >> When evaluating "buf + used" in the same loop:
> >>
> >> used +=3D snprintf(buf + used, sub_non_neg(len, used), ...);
> >>
> >> If "used" exceeds 1024, this creates an out-of-bounds pointer. Modern
> >> compilers can use this undefined behavior to infer that "used" <=3D 10=
24
> >> must be true, which optimizes out the safety check inside sub_non_neg(=
):
> >>
> >> static int sub_non_neg(int a, int b)
> >> {
> >> if (b > a)
> >>   return 0;
> >> return a - b;
> >> }
> >>
> >> The compiler can reduce this to simply "a - b" (or "len - used").
> >> If "used" is actually greater than 1024, "len - used" evaluates to a
> >> negative integer. This negative value is implicitly cast to size_t for
> >> snprintf(), resulting in a massive size limit.
> >>
> >> Would this cause snprintf() to write past the end of the stack buffer
> >> without bounds checking? Using scnprintf() might prevent "used" from
> >> exceeding "len".
> >>
> >> Thanks,
> >> Ian
> >>
> >>>> ---
> >>>> tools/perf/util/pmu.c | 2 +-
> >>>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >>>> index 23337d2fa281..0b8d58543f17 100644
> >>>> --- a/tools/perf/util/pmu.c
> >>>> +++ b/tools/perf/util/pmu.c
> >>>> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
> >>>> skip_duplicate_pmus);
> >>>>
> >>>> /* Paramemterized events have the parameters shown. */
> >>>> - if (strstr(alias->terms, "=3D?")) {
> >>>> + if (!strstr(alias->terms, "=3D?")) {
> >>>> /* No parameters. */
> >>>> snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->=
name);
> >>>> return buf;
> >>>> --
> >>>> 2.47.3
> >>>>
> >>>
> >>> Tested this patch, and its working as expected.
> >>>
> >>> Before Patch:
> >>>
> >>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
> >>> hv_24x7/CPM_EXT_INT_OS/                            [Kernel PMU event]
> >>>
> >>> After Patch:
> >>>
> >>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
> >>> hv_24x7/CPM_EXT_INT_OS,domain=3D?,core=3D?/ [Kernel PMU event]
> >>>
> >>>
> >>> ./perf stat -e hv_24x7/PM_PAU_CYC,chip=3D0/
> >>>
> >>>
> >>> Performance counter stats for 'system wide':
> >>>
> >>>       2018866563      hv_24x7/PM_PAU_CYC,chip=3D0/
> >>>
> >>>    229.938231314 seconds time elapsed
> >>>
> >>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >>>
> >>> Regards,
> >>> Venkat.
>
>
