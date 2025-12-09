Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAA30214D
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303791; cv=none; b=EnbiFETDvH8h0HkbTBxU6AlDKN1BvEJ7IzHu3jNx57A7/IBjShvlTnB1ZtVEzPZl/XKN/+y8Z96dXBE1lhAEpqr4q/8qoftxlO5ND1Ru+DRfxIGgg4+viB8nY17+9HoozJ9cntW/tcCLk0Ht15wjOrVjPUjlrm77iUAMuqAB4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303791; c=relaxed/simple;
	bh=zwm1qLFu94Db6H51LeTYt13G8ItIelgCeYsu1PKvXOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZjDPT3J6koHeWxnZf81tlDu6iL08zQD6Lo7JfXqXatlqloxpvFXUioqQa6rfhmXBBE3bGttIhYvv9QV7A2iJWeS/ItVGqeBE+ySifET05pAwhDsPNrY7kjhwMnBHeocE+DFhEL+Drh/hXnoK7XqX2/7k5NKXd7XgroynA2Se+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfiusQ+a; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfiusQ+a"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29e0753e5d8so7225ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765303789; x=1765908589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SncDcrBJsXhqfqOv9Q+sDuBjEHJt7USdvQKEHHZ/k90=;
        b=bfiusQ+a0xN+dYGGznERF6DcpRd83VdSUd4poIA8tDqb36GBeWRxf/OpLMVEotrMIC
         yHA2z3qM4Z7XHigz9joM6BlWae3kEITeHgLJCeGVBYCz8zc6RgdBhimC597l74KcOW2F
         xa/py5RiO6KeSzcn1pQdhlaULWEwDpwrzkJvvyaE8QT/v3On9tY1xhivv4CHKe6ctVAa
         hRZctrRspjR2HybgiJ5ohTzlezE3nPTJrul7fB946Kv5hJWAUdWq3Jf1ydZkZv4NNEZj
         T7rtj+RjQ3r6N/+nsfQOvpQDq+W3KXr04zAAVI3wsge8+Ac1xHf9VPhWeA0EUiFauUHM
         uqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765303789; x=1765908589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SncDcrBJsXhqfqOv9Q+sDuBjEHJt7USdvQKEHHZ/k90=;
        b=Ajx2o9vjZ50x6QfXk9iWvKJB4imAZCxlFtf660ph8Ctn/SvGlxUh6DUznF/5C9jpiB
         jPoeJIvdOULehjrmveT6/MPHEqmyqLxnXHL9+p/TvVJ1geau4MeCfS9ploVoZDw9L/am
         8nGTBkpRUAGQYhHEN34Wfv3GqzxQZ+fpOTpBbSdSZM9RUasC/ZUIGbYHNOjAKDk2j2Ug
         bHXyo8Hdjc9Cbgp4gcobqz7A4zr9THr7p0m3j2QE+Cwl0lTYhdQ5/5DZZUlObpfzDCeH
         w++ZIdgUjz0oTPwELHjdCpw0ka/fseQyvWLcOl7KJxCQ52avfzn2C14r4nW0y77Rn589
         IabQ==
X-Gm-Message-State: AOJu0YxNM0dwznkJ25nuxtP2ziZ4BFKm6L/yN8XCevvqy1CfH8PV1+tz
	pZc5mBZWF9S2UjZUoXznbxo8mBzgVvtXtbXigPILjM8i4n5S8rw0L9RRd/g8Mea0BLrAKE9n/fj
	+nEqu+gfPy8jM0s6hzLPdzNU5W3dl24czfUj2+wdy
X-Gm-Gg: AY/fxX7AHf1tF/7eSfZpW8+buRjmc7zUt9ZXSNh1Btxun6xGcnfRJpIQGVZ57t0VoNZ
	HRqS7k1KM01jdeswZ29vRAm4HjE9D//p+wqcDibln2DvHOaQA12w9xAi7pGyWXMdvwQKDJ531k8
	V7df/se7vMpYfWRrE+3nwnKXZjKrKHlPYkUVmcSWqBQz51BAOqmTnQXlh7i8oT3qtUce7j11czi
	mXOic3o0hDCECmbxWr82f6zK2pc8SXjktUmvurfK7S+JuCPq1VH8w5YPESXCT44KocY9AtIxmuG
	3aAyz4JKtCTZBkFbY6yn1Xpm
X-Google-Smtp-Source: AGHT+IEiMkHnErFY3xSEYPzNrt11GTEx6o4mPddiQfiRo0+bAE6QQr1kKqsnVNSst008HDptI5o+Bfx8pq7ktiA8ot8=
X-Received: by 2002:a17:903:181:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-29ebf7db6b8mr61265ad.2.1765303788613; Tue, 09 Dec 2025 10:09:48
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
 <20251208-james-perf-config-bits-v2-1-4ac0281993b0@linaro.org>
 <6ba6bde3-f56b-4354-b336-4739cb1edb71@linaro.org> <CAP-5=fV_Y5W2RyJhBgnk49JuTf8EsyisY-LfL3sVhC4TVRC_gg@mail.gmail.com>
 <d275d2fb-8670-4832-b9c4-de98376e58ad@linaro.org>
In-Reply-To: <d275d2fb-8670-4832-b9c4-de98376e58ad@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Dec 2025 10:09:37 -0800
X-Gm-Features: AQt7F2onDRc5S89BorZiT7l1vpPuHViidV4AHe_AXt8lCoNFqyrn_fJfCfHKiZo
Message-ID: <CAP-5=fW6_MVrezxT6ssjhWnYtF_51nvuFCCSPaHzqwYw9EK4Wg@mail.gmail.com>
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

On Tue, Dec 9, 2025 at 9:55=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> On 09/12/2025 15:58, Ian Rogers wrote:
> > On Tue, Dec 9, 2025 at 4:48=E2=80=AFAM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >> On 08/12/2025 2:22 pm, James Clark wrote:
> >>> The ADD_CONFIG_TERM() macros build the __type argument out of a parti=
al
> >>> EVSEL__CONFIG_TERM_x enum name. This means that they can't be called
> >>> from a function where __type is a variable and it's also impossible t=
o
> >>> grep the codebase to find usages of these enums as they're never type=
d
> >>> in full.
> >>>
> >>> Fix this by removing the macros and replacing them with an
> >>> add_config_term() function. It seems the main reason these existed in
> >>> the first place was to avoid type punning and to write to a specific
> >>> field in the union, but the same thing can be achieved with a single
> >>> write to a u64 'val' field.
> >>>
> >>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>> ---
> >>>    tools/perf/util/evsel_config.h |   1 +
> >>>    tools/perf/util/parse-events.c | 146 ++++++++++++++++++++++++-----=
------------
> >>>    2 files changed, 86 insertions(+), 61 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_c=
onfig.h
> >>> index bcd3a978f0c4..685fd8d5c4a8 100644
> >>> --- a/tools/perf/util/evsel_config.h
> >>> +++ b/tools/perf/util/evsel_config.h
> >>> @@ -50,6 +50,7 @@ struct evsel_config_term {
> >>>                u64           cfg_chg;
> >>>                char          *str;
> >>>                int           cpu;
> >>> +             u64           val;
> >>>        } val;
> >>>        bool weak;
> >>>    };
> >>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-e=
vents.c
> >>> index 17c1c36a7bf9..d5b009b4ebab 100644
> >>> --- a/tools/perf/util/parse-events.c
> >>> +++ b/tools/perf/util/parse-events.c
> >>> @@ -1116,105 +1116,107 @@ static int config_attr(struct perf_event_at=
tr *attr,
> >>>        return 0;
> >>>    }
> >>>
> >>> -static int get_config_terms(const struct parse_events_terms *head_co=
nfig,
> >>> -                         struct list_head *head_terms)
> >>> +static struct evsel_config_term *add_config_term(enum evsel_term_typ=
e type,
> >>> +                                              struct list_head *head=
_terms,
> >>> +                                              bool weak)
> >>>    {
> >>> -#define ADD_CONFIG_TERM(__type, __weak)                             =
 \
> >>> -     struct evsel_config_term *__t;                  \
> >>> -                                                             \
> >>> -     __t =3D zalloc(sizeof(*__t));                             \
> >>> -     if (!__t)                                               \
> >>> -             return -ENOMEM;                                 \
> >>> -                                                             \
> >>> -     INIT_LIST_HEAD(&__t->list);                             \
> >>> -     __t->type       =3D EVSEL__CONFIG_TERM_ ## __type;        \
> >>> -     __t->weak       =3D __weak;                               \
> >>> -     list_add_tail(&__t->list, head_terms)
> >>> -
> >>> -#define ADD_CONFIG_TERM_VAL(__type, __name, __val, __weak)   \
> >>> -do {                                                         \
> >>> -     ADD_CONFIG_TERM(__type, __weak);                        \
> >>> -     __t->val.__name =3D __val;                                \
> >>> -} while (0)
> >>> +     struct evsel_config_term *t;
> >>>
> >>> -#define ADD_CONFIG_TERM_STR(__type, __val, __weak)           \
> >>> -do {                                                         \
> >>> -     ADD_CONFIG_TERM(__type, __weak);                        \
> >>> -     __t->val.str =3D strdup(__val);                           \
> >>> -     if (!__t->val.str) {                                    \
> >>> -             zfree(&__t);                                    \
> >>> -             return -ENOMEM;                                 \
> >>> -     }                                                       \
> >>> -     __t->free_str =3D true;                                   \
> >>> -} while (0)
> >>> +     t =3D zalloc(sizeof(*t));
> >>> +     if (!t)
> >>> +             return NULL;
> >>> +
> >>> +     INIT_LIST_HEAD(&t->list);
> >>> +     t->type =3D type;
> >>> +     t->weak =3D weak;
> >>> +     list_add_tail(&t->list, head_terms);
> >>>
> >>> +     return t;
> >>> +}
> >>> +
> >>> +static int get_config_terms(const struct parse_events_terms *head_co=
nfig,
> >>> +                         struct list_head *head_terms)
> >>> +{
> >>>        struct parse_events_term *term;
> >>>
> >>>        list_for_each_entry(term, &head_config->terms, list) {
> >>> +             struct evsel_config_term *new_term;
> >>> +             enum evsel_term_type new_type;
> >>> +             char *str =3D NULL;
> >>> +             u64 val;
> >>> +
> >>>                switch (term->type_term) {
> >>>                case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> >>> -                     ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.n=
um, term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_PERIOD;
> >>> +                     val =3D term->val.num;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> >>> -                     ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num, =
term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_FREQ;
> >>> +                     val =3D term->val.num;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_TIME:
> >>> -                     ADD_CONFIG_TERM_VAL(TIME, time, term->val.num, =
term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_TIME;
> >>> +                     val =3D term->val.num;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
> >>> -                     ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str, t=
erm->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_CALLGRAPH;
> >>> +                     str =3D term->val.str;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
> >>> -                     ADD_CONFIG_TERM_STR(BRANCH, term->val.str, term=
->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_BRANCH;
> >>> +                     str =3D term->val.str;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
> >>> -                     ADD_CONFIG_TERM_VAL(STACK_USER, stack_user,
> >>> -                                         term->val.num, term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_STACK_USER;
> >>> +                     val =3D term->val.num;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_INHERIT:
> >>> -                     ADD_CONFIG_TERM_VAL(INHERIT, inherit,
> >>> -                                         term->val.num ? 1 : 0, term=
->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_INHERIT;
> >>> +                     val =3D term->val.num ? 1 : 0;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
> >>> -                     ADD_CONFIG_TERM_VAL(INHERIT, inherit,
> >>> -                                         term->val.num ? 0 : 1, term=
->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_INHERIT;
> >>> +                     val =3D term->val.num ? 0 : 1;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
> >>> -                     ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack,
> >>> -                                         term->val.num, term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_MAX_STACK;
> >>> +                     val =3D term->val.num;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
> >>> -                     ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events,
> >>> -                                         term->val.num, term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_MAX_EVENTS;
> >>> +                     val =3D term->val.num;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
> >>> -                     ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
> >>> -                                         term->val.num ? 1 : 0, term=
->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_OVERWRITE;
> >>> +                     val =3D term->val.num ? 1 : 0;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
> >>> -                     ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
> >>> -                                         term->val.num ? 0 : 1, term=
->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_OVERWRITE;
> >>> +                     val =3D term->val.num ? 0 : 1;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> >>> -                     ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str, ter=
m->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_DRV_CFG;
> >>> +                     str =3D term->val.str;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_PERCORE:
> >>> -                     ADD_CONFIG_TERM_VAL(PERCORE, percore,
> >>> -                                         term->val.num ? true : fals=
e, term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_PERCORE;
> >>> +                     val =3D term->val.num ? true : false;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
> >>> -                     ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
> >>> -                                         term->val.num ? 1 : 0, term=
->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_AUX_OUTPUT;
> >>> +                     val =3D term->val.num ? 1 : 0;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
> >>> -                     ADD_CONFIG_TERM_STR(AUX_ACTION, term->val.str, =
term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_AUX_ACTION;
> >>> +                     str =3D term->val.str;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
> >>> -                     ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample=
_size,
> >>> -                                         term->val.num, term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE=
;
> >>> +                     val =3D term->val.num;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> >>> -                     ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.st=
r, term->weak);
> >>> +                     new_type =3D EVSEL__CONFIG_TERM_RATIO_TO_PREV;
> >>> +                     str =3D term->val.str;
> >>>                        break;
> >>>                case PARSE_EVENTS__TERM_TYPE_USER:
> >>>                case PARSE_EVENTS__TERM_TYPE_CONFIG:
> >>> @@ -1229,7 +1231,23 @@ do {                                          =
                 \
> >>>                case PARSE_EVENTS__TERM_TYPE_RAW:
> >>>                case PARSE_EVENTS__TERM_TYPE_CPU:
> >>>                default:
> >>> -                     break;
> >>> +                     /* Don't add a new term for these ones */
> >>> +                     continue;
> >>> +             }
> >>> +
> >>> +             new_term =3D add_config_term(new_type, head_terms, term=
->weak);
> >>> +             if (!new_term)
> >>> +                     return -ENOMEM;
> >>> +
> >>> +             if (str) {
> >>> +                     new_term->val.str =3D strdup(str);
> >>> +                     if (!new_term->val.str) {
> >>> +                             zfree(&new_term);
> >>> +                             return -ENOMEM;
> >>> +                     }
> >>> +                     new_term->free_str =3D true;
> >>> +             } else {
> >>
> >> This will incorrectly hit the else if term->val.str is NULL. Not sure =
if
> >> that can happen but will fix anyway.
> >>
> >>> +                     new_term->val.val =3D val;
> >>
> >> There's an uninitialized variable warning for val here on release
> >> builds. Will fix too
> >
> > I'm not sure how I feel about the change, but did you check that it is
> > ubsan clean? I worry it is introducing writes to "val" and then reads
> > from say "period" in the evsel_config_term val union. I believe ubsan
> > will flag this as:
> > https://en.cppreference.com/w/cpp/language/union.html
> > "It is undefined behavior to read from the member of the union that
> > wasn't most recently written."
> >
> > Thanks,
> > Ian
> >
>
> Maybe for C++, but not for C [1]:
>
>    Accessing my_union.i after most recently writing to the other member,
>    my_union.d, is an allowed form of type-punning in C, provided that the
>    member read is not larger than the one whose value was set
>
> Type punning with unions is widely used in the kernel and there are a
> couple of instances in Perf. There are tons of discussions about it on
> the mailing lists too. I can check it with ubsan though.

Thanks. I'm mostly worried about ubsan being clean. One of those
mailing list discussions, or sadly outside the usual trolls lack of
discussion, is my trying to remove a prevalent source of type punning:
https://lore.kernel.org/lkml/20251016205126.2882625-1-irogers@google.com/

Ian

> [1]: https://en.wikipedia.org/wiki/Type_punning#C_and_C++
>
> >>>                }
> >>>        }
> >>>        return 0;
> >>> @@ -1290,10 +1308,16 @@ static int get_config_chgs(struct perf_pmu *p=
mu, struct parse_events_terms *head
> >>>                }
> >>>        }
> >>>
> >>> -     if (bits)
> >>> -             ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits, false);
> >>> +     if (bits) {
> >>> +             struct evsel_config_term *new_term;
> >>> +
> >>> +             new_term =3D add_config_term(EVSEL__CONFIG_TERM_CFG_CHG=
,
> >>> +                                        head_terms, false);
> >>> +             if (!new_term)
> >>> +                     return -ENOMEM;
> >>> +             new_term->val.cfg_chg =3D bits;
> >>> +     }
> >>>
> >>> -#undef ADD_CONFIG_TERM
> >>>        return 0;
> >>>    }
> >>>
> >>>
> >>
>
