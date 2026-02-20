Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFE3EBF28
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2026 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631589; cv=none; b=IgE8AejvYfBWmcdmmzV04n922gjRZbTlZA4Sgm4NM2fL11EwTsumh2WNm5LeubkspjIikdTJ/1RCn3/v4ECORKX1IkNg+HreWBePhoX5VsFiCrg5FoU+AOKaBdlYHLrPpLxJmL6Twl7zQ5shW3l/d4c+MJyzwEqefgfs7ayIJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631589; c=relaxed/simple;
	bh=zfKHOgfSLQuwB7G7ZF7duTdBbEPAamm4yVJTGlyImOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9KR/z6VcTVGLf2wTjOOuYd9lI8yDDDfp9gWBOEJKkWTJ41GkIOezD8jKMBilwdlWUoHB8OLHBwie4R+7uj1CkCo6gREk/xZwGqcHGxZO6TOlJFwXUQ8nN/CaJb2fpPdrkUhtHv05r3COeOsQw9wZX1g8Hs2GOINzVNGzLzwR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7wJWsyi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7wJWsyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC54BC116C6;
	Fri, 20 Feb 2026 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771631589;
	bh=zfKHOgfSLQuwB7G7ZF7duTdBbEPAamm4yVJTGlyImOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7wJWsyimdHNhtVY+1JPMa9HQrBKIVQDDv1Gw4a5DfleQirGP1eo9fUXI2TWYg+ho
	 phTM8NMd0LiLn6up6OL97iaEHpK+9k57n+7zWY/vIoy4bI4Z/Qzzel30SJu0T9vXwH
	 wRpLf2xZRcwBkO3hK9PEoCi7/1dz7pLHtwrvXqezZx/O7DTt0Btcx4DgpoQ+OKuHDc
	 jnPR8Ne5TLLIvVhAi1u2fyJ8rk5UOLALZb9to8FaHjDk1Hg8ZJyNg43xyOemkBy2g0
	 u6VW0hAnD6bPy5wsRpBinfbgDzzQ6xyOndHlXev39QbCKuy28zUD7S1KzbTqQfx3fL
	 Nj95kWb6gkkYQ==
Date: Fri, 20 Feb 2026 15:53:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: PING [PATCH v4 linux-next] perf parse-events: Fix big-endian
 'overwrite' by writing correct union member
Message-ID: <aZjz47hv-_sVNya2@google.com>
References: <20260217131456.4085419-1-tmricht@linux.ibm.com>
 <9a16463e-c2d9-4ab9-bd1a-a9c6e7981412@linaro.org>
 <53e9060e-cd7d-49eb-a100-7f658fa0f17b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53e9060e-cd7d-49eb-a100-7f658fa0f17b@linux.ibm.com>

Hello,

On Fri, Feb 20, 2026 at 10:31:17AM +0100, Thomas Richter wrote:
> On 2/17/26 15:09, James Clark wrote:
> > 
> > 
> > On 17/02/2026 1:14 pm, Thomas Richter wrote:
> >> v1 -> v2: Add comments from James Clark and Ian Rogers
> >> v2 -> v3: Improve switch statement in add_config_term()
> >> v3 -> v4: Fix clang warnings
> >>
> >> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
> >> due to a NULL dereference when the backward mmap path isn't enabled.
> >>
> >> Reproducer:
> >>    # ./perf test -F 'Read backward ring buffer'
> >>    Segmentation fault (core dumped)
> >>    # uname -m
> >>    s390x
> >>    #
> >>
> >> Root cause:
> >> get_config_terms() stores into evsel_config_term::val.val (u64) while later
> >> code reads boolean fields such as evsel_config_term::val.overwrite.
> >> On big-endian the 1-byte boolean is left-aligned, so writing
> >> evsel_config_term::val.val = 1 is read back as
> >> evsel_config_term::val.overwrite = 0,
> >> leaving backward mmap disabled and a NULL map being used.
> >>
> >> Store values in the union member that matches the term type, e.g.:
> >>    /* for OVERWRITE */
> >>    new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
> >> to fix this. Improve add_config_term() and add two more parameters for
> >> string and value. Function add_config_term() now creates a complete node
> >> element of type evsel_config_term and handles all evsel_config_term::val
> >> union members.
> >>
> >> Impact:
> >> Enables backward mmap on big-endian and prevents the crash.
> >> No change on little-endian.
> >>
> >> Output after:
> >>   # ./perf test -Fv 44
> >>   --- start ---
> >>   Using CPUID IBM,9175,705,ME1,3.8,002f
> >>   mmap size 1052672B
> >>   mmap size 8192B
> >>   ---- end ----
> >>   44: Read backward ring buffer                         : Ok
> >>   #
> >>
> >> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to remove macros")
> >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> >> Cc: James Clark <james.clark@linaro.org>
> >> Cc: Ian Rogers <irogers@google.com>
> >> ---
> >>   tools/perf/util/parse-events.c | 82 +++++++++++++++++++++++++++-------
> >>   1 file changed, 65 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> >> index b9efb296bba5..7b4629625b1e 100644
> >> --- a/tools/perf/util/parse-events.c
> >> +++ b/tools/perf/util/parse-events.c
> >> @@ -1117,7 +1117,7 @@ static int config_attr(struct perf_event_attr *attr,
> >>     static struct evsel_config_term *add_config_term(enum evsel_term_type type,
> >>                            struct list_head *head_terms,
> >> -                         bool weak)
> >> +                         bool weak, char *str, u64 val)
> >>   {
> >>       struct evsel_config_term *t;
> >>   @@ -1128,8 +1128,62 @@ static struct evsel_config_term *add_config_term(enum evsel_term_type type,
> >>       INIT_LIST_HEAD(&t->list);
> >>       t->type = type;
> >>       t->weak    = weak;
> >> +
> >> +    switch (type) {
> >> +    case EVSEL__CONFIG_TERM_PERIOD:
> >> +    case EVSEL__CONFIG_TERM_FREQ:
> >> +    case EVSEL__CONFIG_TERM_STACK_USER:
> >> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
> >> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
> >> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
> >> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
> >> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
> >> +        t->val.val = val;
> >> +        break;
> >> +    case EVSEL__CONFIG_TERM_TIME:
> >> +        t->val.time = val;
> >> +        break;
> >> +    case EVSEL__CONFIG_TERM_INHERIT:
> >> +        t->val.inherit = val;
> >> +        break;
> >> +    case EVSEL__CONFIG_TERM_OVERWRITE:
> >> +        t->val.overwrite = val;
> >> +        break;
> >> +    case EVSEL__CONFIG_TERM_MAX_STACK:
> >> +        t->val.max_stack = val;
> >> +        break;
> >> +    case EVSEL__CONFIG_TERM_MAX_EVENTS:
> >> +        t->val.max_events = val;
> >> +        break;
> >> +    case EVSEL__CONFIG_TERM_PERCORE:
> >> +        t->val.percore = val;
> >> +        break;
> >> +    case EVSEL__CONFIG_TERM_AUX_OUTPUT:
> >> +        t->val.aux_output = val;
> >> +        break;
> >> +    case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
> >> +        t->val.aux_sample_size = val;
> >> +        break;
> >> +    case EVSEL__CONFIG_TERM_CALLGRAPH:
> >> +    case EVSEL__CONFIG_TERM_BRANCH:
> >> +    case EVSEL__CONFIG_TERM_DRV_CFG:
> >> +    case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> >> +    case EVSEL__CONFIG_TERM_AUX_ACTION:
> >> +        if (str) {
> >> +            t->val.str = strdup(str);
> >> +            if (!t->val.str) {
> >> +                zfree(&t);
> >> +                return NULL;
> >> +            }
> >> +            t->free_str = true;
> >> +        }
> >> +        break;
> >> +    default:
> >> +        t->val.val = val;
> >> +        break;
> >> +    }
> >> +
> >>       list_add_tail(&t->list, head_terms);
> >> -
> >>       return t;
> >>   }
> >>   @@ -1142,7 +1196,7 @@ static int get_config_terms(const struct parse_events_terms *head_config,
> >>           struct evsel_config_term *new_term;
> >>           enum evsel_term_type new_type;
> >>           bool str_type = false;
> >> -        u64 val;
> >> +        u64 val = 0;
> >>             switch (term->type_term) {
> >>           case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> >> @@ -1234,20 +1288,15 @@ static int get_config_terms(const struct parse_events_terms *head_config,
> >>               continue;
> >>           }
> >>   -        new_term = add_config_term(new_type, head_terms, term->weak);
> >> +        /*
> >> +         * Note: Members evsel_config_term::val and
> >> +         * parse_events_term::val are unions and endianness needs
> >> +         * to be taken into account when changing such union members.
> >> +         */
> >> +        new_term = add_config_term(new_type, head_terms, term->weak,
> >> +                       str_type ? term->val.str : NULL, val);
> >>           if (!new_term)
> >>               return -ENOMEM;
> >> -
> >> -        if (str_type) {
> >> -            new_term->val.str = strdup(term->val.str);
> >> -            if (!new_term->val.str) {
> >> -                zfree(&new_term);
> >> -                return -ENOMEM;
> >> -            }
> >> -            new_term->free_str = true;
> >> -        } else {
> >> -            new_term->val.val = val;
> >> -        }
> >>       }
> >>       return 0;
> >>   }
> >> @@ -1277,10 +1326,9 @@ static int add_cfg_chg(const struct perf_pmu *pmu,
> >>       if (bits) {
> >>           struct evsel_config_term *new_term;
> >>   -        new_term = add_config_term(new_term_type, head_terms, false);
> >> +        new_term = add_config_term(new_term_type, head_terms, false, NULL, bits);
> >>           if (!new_term)
> >>               return -ENOMEM;
> >> -        new_term->val.cfg_chg = bits;
> >>       }
> >>         return 0;
> > 
> > Reviewed-by: James Clark <james.clark@linaro.org>
> > 
> 
> Friendly ping, this still fails in linux-next...

Sorry for the delay, I'll queue it up after the merge window.

Thanks,
Namhyung

