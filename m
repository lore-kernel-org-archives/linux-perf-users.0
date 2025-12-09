Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8A2C11D3
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295925; cv=none; b=lY+jSKe8U/pvXMCttpP6igedb8Z88rzbojnU2PuTHbRbFwM5uwXOzFFH8FgB4BwHe/0O4XBdC3OtRP2B+Xbk+dy0y+WVv6dKL3Z64/Q3R/n8FTwuNjpg0V/mUO4gEnY/i+F+K3RYWoXvQ374LAKM4HCZfFdTpPZv5NVitx2wkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295925; c=relaxed/simple;
	bh=CikQc/fnzb9c5oM/8Eb9yUjZRbCszrqJmho1dnojadM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0VS4pKdEo7gNKLVUtv8+YkZWxtp/dw9VmJ2rwR9h9lB/1xw8AQZaZ4UfYREz263o8NEdTPdnWQqThU5s9twXOvluGBWSV4hgIaeQ28R0+tn+Coa1ZBbY8J99XnutLRL8xpcDzun/vCCrwZE0AYAUS+/MZEWi3kkkO/a3QQz71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17J/Bqvq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17J/Bqvq"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297e13bf404so246165ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 07:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765295923; x=1765900723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDgse4smKZRxWXFHykbYNCZxcA+/jW1sukp85CRj1yk=;
        b=17J/Bqvq8YF4u4S6kHAnewzT343QAkwiKsVeX2h9Vill/7hJ+Tyk57O0bYRt6kpKiH
         3wlTB/tPV0w4qy1PZCdZdBXWsEmsaFsA6UQ0lb6PZ0b9PT+TOtMaXjBREGqcSppYd25J
         jffbiPSjCsU0tCyqfcxpo/eTIg7KqEy0rrbFNgunE93OWdTGSn0QXcMPLCx+loIuCwN4
         JxtK8BAE5c+QN2SxUQWiMpKxH7iXN4GhPBCZYXxafDsYDNRezHl9d65pHkUd+g/Tg4Bb
         EszaGWxkGIdJybS6/dIHAwinroloRdRhXaL8kfNZnQmgT7YrvNdgHjjGRNdD1+rsz+7k
         CC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765295923; x=1765900723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDgse4smKZRxWXFHykbYNCZxcA+/jW1sukp85CRj1yk=;
        b=ayC6c8g/kz2mK/9iW+2Wx/GA+BrQ96/UnH9TVsB8MbVN5MONnTiGWsmNLgBw9Qzs6k
         20Kx6OKwb/TFzBRrPiCHoGOKXh9bwEcWmRGr7dmaeC9oAMsAYqEz0b0uflSo4w4HxszA
         pL1ZhSmU//3Hj8vj1tpopbCoytv5stq3fJIGVUcmjpcHjbA8a2QHxA4DSf6+wbpKA1Cq
         jJroShGfozbLkpUdugqq/DMAel1BBadS3isGNJ5o6N7PIXahRGk9lmXynRTQ/zfXjNUc
         c6CDBUVaonlYuF0IZMRBYcDdhknuvnuh04S+fhTBkhcD/3zFxhu3tzy6LXKF0sD5xt41
         9HOA==
X-Gm-Message-State: AOJu0Yxz+EzZrs6+kGvWZ4dqjeiudVp/bSc99AOlAOfjFQgbe4E3iS/C
	ZqlnP4AP5B8C28J66PpSDgQb+r1VOZUQKJQt6GhWuAKeghc9jVhTc4yWRFg+uasJGfDY2NRqK/W
	DlZTMb0qZjC/7v4cJjNT96f4s2CnmyOxcIbTZoJxF
X-Gm-Gg: AY/fxX4yWmr2gng+0UR4eCUyWvk01zlkoIRL/j3Mpvo5vdw4+4Cfbh2pUOz8ROoSOts
	sQKCI8xt4+xE4Nc3dBtOESkMp84Srdd0sHzGxePz5MX8H1fe4QmurhTEH3gwicWAW4Cc3xgUkhB
	Qoc3iESS7MD4vIu4+z/XFszgukZnc6ljpkM+NL/Op3SO2JE9PffJvxDOM9Wbzmr2hfaFszMf04R
	ACXtGEV7kPIr384wtoD7J7aMP7/KXM9E4T3V2iW1qw94CJfu9gAk4A/4NBQMx0/lA17k5t63ekr
	LICLdigvD3OOOYaOBcSoiJ/N
X-Google-Smtp-Source: AGHT+IEZGJ2IBQ2j1MbdGq5XaIfuVItXVgOQ0Dn63+iXclg+rEg/7JRhz9Q9g5d8crMx5xPTS07qDWbS+y/SSIFNDuE=
X-Received: by 2002:a17:903:1c8:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-29e9417f3c2mr3300855ad.4.1765295922533; Tue, 09 Dec 2025
 07:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
 <20251208-james-perf-config-bits-v2-1-4ac0281993b0@linaro.org> <6ba6bde3-f56b-4354-b336-4739cb1edb71@linaro.org>
In-Reply-To: <6ba6bde3-f56b-4354-b336-4739cb1edb71@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Dec 2025 07:58:31 -0800
X-Gm-Features: AQt7F2py_yb8y5sEdWL_sj5dKYcliEu1dCmZ7RHB13qbHpYjiU2r9ka3GKUHG9w
Message-ID: <CAP-5=fV_Y5W2RyJhBgnk49JuTf8EsyisY-LfL3sVhC4TVRC_gg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] perf parse-events: Refactor get_config_terms()
 to remove macros
To: James Clark <james.clark@linaro.org>
Cc: Linux perf Profiling <linux-perf-users@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 4:48=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> On 08/12/2025 2:22 pm, James Clark wrote:
> > The ADD_CONFIG_TERM() macros build the __type argument out of a partial
> > EVSEL__CONFIG_TERM_x enum name. This means that they can't be called
> > from a function where __type is a variable and it's also impossible to
> > grep the codebase to find usages of these enums as they're never typed
> > in full.
> >
> > Fix this by removing the macros and replacing them with an
> > add_config_term() function. It seems the main reason these existed in
> > the first place was to avoid type punning and to write to a specific
> > field in the union, but the same thing can be achieved with a single
> > write to a u64 'val' field.
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >   tools/perf/util/evsel_config.h |   1 +
> >   tools/perf/util/parse-events.c | 146 ++++++++++++++++++++++++--------=
---------
> >   2 files changed, 86 insertions(+), 61 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_con=
fig.h
> > index bcd3a978f0c4..685fd8d5c4a8 100644
> > --- a/tools/perf/util/evsel_config.h
> > +++ b/tools/perf/util/evsel_config.h
> > @@ -50,6 +50,7 @@ struct evsel_config_term {
> >               u64           cfg_chg;
> >               char          *str;
> >               int           cpu;
> > +             u64           val;
> >       } val;
> >       bool weak;
> >   };
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 17c1c36a7bf9..d5b009b4ebab 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1116,105 +1116,107 @@ static int config_attr(struct perf_event_attr=
 *attr,
> >       return 0;
> >   }
> >
> > -static int get_config_terms(const struct parse_events_terms *head_conf=
ig,
> > -                         struct list_head *head_terms)
> > +static struct evsel_config_term *add_config_term(enum evsel_term_type =
type,
> > +                                              struct list_head *head_t=
erms,
> > +                                              bool weak)
> >   {
> > -#define ADD_CONFIG_TERM(__type, __weak)                              \
> > -     struct evsel_config_term *__t;                  \
> > -                                                             \
> > -     __t =3D zalloc(sizeof(*__t));                             \
> > -     if (!__t)                                               \
> > -             return -ENOMEM;                                 \
> > -                                                             \
> > -     INIT_LIST_HEAD(&__t->list);                             \
> > -     __t->type       =3D EVSEL__CONFIG_TERM_ ## __type;        \
> > -     __t->weak       =3D __weak;                               \
> > -     list_add_tail(&__t->list, head_terms)
> > -
> > -#define ADD_CONFIG_TERM_VAL(__type, __name, __val, __weak)   \
> > -do {                                                         \
> > -     ADD_CONFIG_TERM(__type, __weak);                        \
> > -     __t->val.__name =3D __val;                                \
> > -} while (0)
> > +     struct evsel_config_term *t;
> >
> > -#define ADD_CONFIG_TERM_STR(__type, __val, __weak)           \
> > -do {                                                         \
> > -     ADD_CONFIG_TERM(__type, __weak);                        \
> > -     __t->val.str =3D strdup(__val);                           \
> > -     if (!__t->val.str) {                                    \
> > -             zfree(&__t);                                    \
> > -             return -ENOMEM;                                 \
> > -     }                                                       \
> > -     __t->free_str =3D true;                                   \
> > -} while (0)
> > +     t =3D zalloc(sizeof(*t));
> > +     if (!t)
> > +             return NULL;
> > +
> > +     INIT_LIST_HEAD(&t->list);
> > +     t->type =3D type;
> > +     t->weak =3D weak;
> > +     list_add_tail(&t->list, head_terms);
> >
> > +     return t;
> > +}
> > +
> > +static int get_config_terms(const struct parse_events_terms *head_conf=
ig,
> > +                         struct list_head *head_terms)
> > +{
> >       struct parse_events_term *term;
> >
> >       list_for_each_entry(term, &head_config->terms, list) {
> > +             struct evsel_config_term *new_term;
> > +             enum evsel_term_type new_type;
> > +             char *str =3D NULL;
> > +             u64 val;
> > +
> >               switch (term->type_term) {
> >               case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> > -                     ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num=
, term->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_PERIOD;
> > +                     val =3D term->val.num;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> > -                     ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num, te=
rm->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_FREQ;
> > +                     val =3D term->val.num;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_TIME:
> > -                     ADD_CONFIG_TERM_VAL(TIME, time, term->val.num, te=
rm->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_TIME;
> > +                     val =3D term->val.num;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
> > -                     ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str, ter=
m->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_CALLGRAPH;
> > +                     str =3D term->val.str;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
> > -                     ADD_CONFIG_TERM_STR(BRANCH, term->val.str, term->=
weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_BRANCH;
> > +                     str =3D term->val.str;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
> > -                     ADD_CONFIG_TERM_VAL(STACK_USER, stack_user,
> > -                                         term->val.num, term->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_STACK_USER;
> > +                     val =3D term->val.num;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_INHERIT:
> > -                     ADD_CONFIG_TERM_VAL(INHERIT, inherit,
> > -                                         term->val.num ? 1 : 0, term->=
weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_INHERIT;
> > +                     val =3D term->val.num ? 1 : 0;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
> > -                     ADD_CONFIG_TERM_VAL(INHERIT, inherit,
> > -                                         term->val.num ? 0 : 1, term->=
weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_INHERIT;
> > +                     val =3D term->val.num ? 0 : 1;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
> > -                     ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack,
> > -                                         term->val.num, term->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_MAX_STACK;
> > +                     val =3D term->val.num;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
> > -                     ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events,
> > -                                         term->val.num, term->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_MAX_EVENTS;
> > +                     val =3D term->val.num;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
> > -                     ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
> > -                                         term->val.num ? 1 : 0, term->=
weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_OVERWRITE;
> > +                     val =3D term->val.num ? 1 : 0;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
> > -                     ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
> > -                                         term->val.num ? 0 : 1, term->=
weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_OVERWRITE;
> > +                     val =3D term->val.num ? 0 : 1;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> > -                     ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str, term-=
>weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_DRV_CFG;
> > +                     str =3D term->val.str;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_PERCORE:
> > -                     ADD_CONFIG_TERM_VAL(PERCORE, percore,
> > -                                         term->val.num ? true : false,=
 term->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_PERCORE;
> > +                     val =3D term->val.num ? true : false;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
> > -                     ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
> > -                                         term->val.num ? 1 : 0, term->=
weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_AUX_OUTPUT;
> > +                     val =3D term->val.num ? 1 : 0;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
> > -                     ADD_CONFIG_TERM_STR(AUX_ACTION, term->val.str, te=
rm->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_AUX_ACTION;
> > +                     str =3D term->val.str;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
> > -                     ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_s=
ize,
> > -                                         term->val.num, term->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE;
> > +                     val =3D term->val.num;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> > -                     ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.str,=
 term->weak);
> > +                     new_type =3D EVSEL__CONFIG_TERM_RATIO_TO_PREV;
> > +                     str =3D term->val.str;
> >                       break;
> >               case PARSE_EVENTS__TERM_TYPE_USER:
> >               case PARSE_EVENTS__TERM_TYPE_CONFIG:
> > @@ -1229,7 +1231,23 @@ do {                                            =
               \
> >               case PARSE_EVENTS__TERM_TYPE_RAW:
> >               case PARSE_EVENTS__TERM_TYPE_CPU:
> >               default:
> > -                     break;
> > +                     /* Don't add a new term for these ones */
> > +                     continue;
> > +             }
> > +
> > +             new_term =3D add_config_term(new_type, head_terms, term->=
weak);
> > +             if (!new_term)
> > +                     return -ENOMEM;
> > +
> > +             if (str) {
> > +                     new_term->val.str =3D strdup(str);
> > +                     if (!new_term->val.str) {
> > +                             zfree(&new_term);
> > +                             return -ENOMEM;
> > +                     }
> > +                     new_term->free_str =3D true;
> > +             } else {
>
> This will incorrectly hit the else if term->val.str is NULL. Not sure if
> that can happen but will fix anyway.
>
> > +                     new_term->val.val =3D val;
>
> There's an uninitialized variable warning for val here on release
> builds. Will fix too

I'm not sure how I feel about the change, but did you check that it is
ubsan clean? I worry it is introducing writes to "val" and then reads
from say "period" in the evsel_config_term val union. I believe ubsan
will flag this as:
https://en.cppreference.com/w/cpp/language/union.html
"It is undefined behavior to read from the member of the union that
wasn't most recently written."

Thanks,
Ian

> >               }
> >       }
> >       return 0;
> > @@ -1290,10 +1308,16 @@ static int get_config_chgs(struct perf_pmu *pmu=
, struct parse_events_terms *head
> >               }
> >       }
> >
> > -     if (bits)
> > -             ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits, false);
> > +     if (bits) {
> > +             struct evsel_config_term *new_term;
> > +
> > +             new_term =3D add_config_term(EVSEL__CONFIG_TERM_CFG_CHG,
> > +                                        head_terms, false);
> > +             if (!new_term)
> > +                     return -ENOMEM;
> > +             new_term->val.cfg_chg =3D bits;
> > +     }
> >
> > -#undef ADD_CONFIG_TERM
> >       return 0;
> >   }
> >
> >
>
