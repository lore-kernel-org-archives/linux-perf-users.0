Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E2259CA9
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210846; cv=none; b=Ogip36g9vrd5CyaDWzrc8J6JYZvVwN8+gnNTgW5+okz6XgnXmKgTAH3oVo/tVD6u33g9us2kP2njZN7Sx6sz5nuLUo8xYcMt9YW/pKXPH2GLYzlUMSz/6w+txKxrKi0iAkqnNhkpQv3nfqbPKf90+ut+bNc/eTmPW51/zHKlKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210846; c=relaxed/simple;
	bh=VaXAVBTtNR05XkFyRPxivs6yqAIhwdp23xAcqRqduqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reM5QqNWpGuh73UsDzewNCVCl0cnUiItwH1OpSHMha/WUlZoIfvJKLGT3dhcCaGwM+WCftQ4/pXoaCzSluyZ2TrRScUaw6rgnhioETBOs+HMUVMUuE0crpbaetoJNQBLTuHiNWd5P4r8INrp00APbhRf08jQxii2MeotsxXujxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfIIqjIM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfIIqjIM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223a0da61easo49265ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 13:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741210844; x=1741815644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUqGXUpXPq4q4UlP0fakT86HhY6hzAu+3uMQ7gZOAKY=;
        b=BfIIqjIMpSRy6GKZNetI+bxlBvcSzi7+b/qtS5+OUyCsLP0/UH8WOYAXZVJx3OCR5A
         KczGomkSWLTQqZqdrA47uj+oO79FWx170d/7dIcrb+I3L13R16AlKPrU4Vwq4kmY3k5t
         7+LUWDLqqkSd35qTMnn/l9i8IawoiXCxKCvhCdlIRDfrI3fF2TaTRDv4XUqY85Y4qKcJ
         jdHjTVvqp/peonnQWcr8NsaWdJBNwiDEQ27B4jHACrALzxxzbBhuZxKbj0GKqyiRqMif
         8Oz+6TL5riXTtEPbRv7Qc80mAp63pKjMkyqZNGy5hhpCKTYxv46jqtoiZLU6Hgx7rrXW
         kehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741210844; x=1741815644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUqGXUpXPq4q4UlP0fakT86HhY6hzAu+3uMQ7gZOAKY=;
        b=aUY43L4qM8Xx0XZfM18+ZOtEYshMRI52kyruf2Dy88eXHZhol/SbGq+V/zOtQg4j8c
         P7tgHoQ2DBaWOeYwc6gOZV78V9XQnBMqXdHl07Rw/vpL+Z3AzPYQ0x3qEwLBtADN5zsr
         NlIrSYeIvr4FCLyMmrAFMOwfg5gNw0jW3tDJj1bEkcUrBfNsdxr5j9V6XIsVKAyc3gVH
         aQplONPXccZ7sDRD3oJ5irb/tVPJT3e6XALa7dbhZkJBAelXryl/y0MWNJkYZNK51uSk
         MchtRU9Gx19BcngwrzQY2lPGI2HbQcWjFHsCNuvfjvHv/6wmeOKpBR9kUYuihizLV/Tk
         Hbug==
X-Forwarded-Encrypted: i=1; AJvYcCXuJ/o0m5+FerGFvh9ARSyQ5hKhRRJne6fayeLBVP/JLjfnNbb8pZ+PS6Rt4nGP6/Z0P0IXNY+TOkpccdD232NX@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBfbX+9+1Mh2smf4vRT5P50fwQ4/L42ffwC1t7aadvBGhRNK+
	CO7luXX55T56o+b6MWmpPKR63EVXwdXLoEhrsYhe92RgHrUiuBKYgJhE0ni1+dp/s1nUZq8Hy97
	q7J/hLCkxl9426YP7oOa+oop1LmPkry4THopd
X-Gm-Gg: ASbGncvXpxNyUkivgoSdEkS4FBHdyW2VqY5DmIYG52mc6hc8HqSsMUpANk+C9tf0axk
	5u/xLB/mDDYPAf8tIPNzB6H4MVELXVuAHL3PkYooWxRHIrFifGchCUZBrsyV7ZncCu6ptSSCu8q
	fIM6sTaJri9+me4fpGTVjON40dHZ17y2xe3ip3EnHCIahtPotKie4+ZzA=
X-Google-Smtp-Source: AGHT+IGu5HU672X0bhdCBQl0GPpUqytgdOk7SJm+x69wYHvN25rgPrjsINKHKZjP9G5gmS2lHMX//kWP48xZbtAnpFE=
X-Received: by 2002:a17:902:d2c7:b0:21f:2ded:bfc5 with SMTP id
 d9443c01a7336-2240ab173b0mr653355ad.28.1741210843927; Wed, 05 Mar 2025
 13:40:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org> <20250304-james-perf-hybrid-list-v1-2-a363ffac283c@linaro.org>
In-Reply-To: <20250304-james-perf-hybrid-list-v1-2-a363ffac283c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 13:40:32 -0800
X-Gm-Features: AQ5f1Jp9Ral6oytFmR1JWJVisvtaLa3sVf0rx274oMPnZUwzWuT8Y2jALE4iORM
Message-ID: <CAP-5=fX+aSDLMDL3DMNCQ4tDuhaZPv-L6OgfOso3q5wf7anoGg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf list: Collapse similar events across PMUs
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:50=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Instead of showing multiple line items with the same event name and
> description, show a single line and concatenate all PMUs that this
> event can belong to.
>
> Don't do it for json output. Machine readable output doesn't need to be
> minimized, and changing the "Unit" field to a list type would break
> backwards compatibility.
>
> Before:
>  $ perf list -v
>  ...
>  br_indirect_spec
>        [Branch speculatively executed,indirect branch. Unit: armv8_cortex=
_a53]
>  br_indirect_spec
>        [Branch speculatively executed,indirect branch. Unit: armv8_cortex=
_a57]
>
> After:
>
>  $ perf list -v
>  ...
>  br_indirect_spec
>        [Branch speculatively executed,indirect branch. Unit: armv8_cortex=
_a53,armv8_cortex_a57]
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/builtin-list.c      |  2 ++
>  tools/perf/util/pmus.c         | 75 ++++++++++++++++++++++++++++++++++++=
+-----
>  tools/perf/util/print-events.h |  1 +
>  3 files changed, 70 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index fed482adb039..aacd7beae2a0 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -516,6 +516,7 @@ int cmd_list(int argc, const char **argv)
>                 .print_event =3D default_print_event,
>                 .print_metric =3D default_print_metric,
>                 .skip_duplicate_pmus =3D default_skip_duplicate_pmus,
> +               .collapse_events =3D true

So collapse_events is put in the callbacks but isn't a callback. I
think skipping duplicates and collapsing are the same thing, I'd
prefer it if there weren't two terms for the same thing. If you prefer
collapsing as a name then default_skip_duplicate_pmus can be
default_collapse_pmus.

>         };
>         const char *cputype =3D NULL;
>         const char *unit_name =3D NULL;
> @@ -574,6 +575,7 @@ int cmd_list(int argc, const char **argv)
>                         .print_event =3D json_print_event,
>                         .print_metric =3D json_print_metric,
>                         .skip_duplicate_pmus =3D json_skip_duplicate_pmus=
,
> +                       .collapse_events =3D false
>                 };
>                 ps =3D &json_ps;
>         } else {
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 4d60bac2d2b9..cb1b14ade25b 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -453,17 +453,50 @@ static int cmp_sevent(const void *a, const void *b)
>         /* Order by PMU name. */
>         if (as->pmu =3D=3D bs->pmu)
>                 return 0;
> -       return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
> +       ret =3D strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
> +       if (ret)
> +               return ret;
> +
> +       /* Order by remaining displayed fields for purposes of deduplicat=
ion later */
> +       ret =3D strcmp(as->scale_unit ?: "", bs->scale_unit ?: "");
> +       if (ret)
> +               return ret;
> +       ret =3D !!as->deprecated - !!bs->deprecated;
> +       if (ret)
> +               return ret;
> +       ret =3D strcmp(as->desc ?: "", bs->desc ?: "");
> +       if (ret)
> +               return ret;
> +       return strcmp(as->long_desc ?: "", bs->long_desc ?: "");
>  }
>
> -static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)
> +enum dup_type {
> +       UNIQUE,
> +       DUPLICATE,
> +       SAME_TEXT
> +};
> +
> +static enum dup_type pmu_alias_duplicate_type(struct sevent *a, struct s=
event *b)
>  {
>         /* Different names -> never duplicates */
>         if (strcmp(a->name ?: "//", b->name ?: "//"))
> -               return false;
> +               return UNIQUE;
> +
> +       /* Duplicate PMU name and event name -> hide completely */
> +       if (strcmp(a->pmu_name, b->pmu_name) =3D=3D 0)
> +               return DUPLICATE;
> +
> +       /* Any other different display text -> not duplicate */
> +       if (strcmp(a->topic ?: "", b->topic ?: "") ||
> +           strcmp(a->scale_unit ?: "", b->scale_unit ?: "") ||
> +           a->deprecated !=3D b->deprecated ||
> +           strcmp(a->desc ?: "", b->desc ?: "") ||
> +           strcmp(a->long_desc ?: "", b->long_desc ?: "")) {
> +               return UNIQUE;
> +       }
>
> -       /* Don't remove duplicates for different PMUs */
> -       return strcmp(a->pmu_name, b->pmu_name) =3D=3D 0;
> +       /* Same display text but different PMU -> collapse */
> +       return SAME_TEXT;
>  }
>
>  struct events_callback_state {
> @@ -501,6 +534,21 @@ static int perf_pmus__print_pmu_events__callback(voi=
d *vstate,
>         return 0;
>  }
>
> +static void concat_pmu_names(char *pmu_names, size_t size, const char *a=
, const char *b)
> +{
> +       size_t len =3D strlen(pmu_names);
> +       size_t added;
> +
> +       if (len)
> +               added =3D snprintf(pmu_names + len, size - len, ",%s", b)=
;
> +       else
> +               added =3D snprintf(pmu_names, size, "%s,%s", a, b);
> +
> +       /* Truncate with ... */
> +       if (added > 0 && added + len >=3D size)
> +               sprintf(pmu_names + size - 4, "...");
> +}
> +
>  void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb,=
 void *print_state)
>  {
>         struct perf_pmu *pmu;
> @@ -510,6 +558,7 @@ void perf_pmus__print_pmu_events(const struct print_c=
allbacks *print_cb, void *p
>         struct events_callback_state state;
>         bool skip_duplicate_pmus =3D print_cb->skip_duplicate_pmus(print_=
state);
>         struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> +       char pmu_names[128] =3D {0};
>
>         if (skip_duplicate_pmus)
>                 scan_fn =3D perf_pmus__scan_skip_duplicates;
> @@ -539,12 +588,21 @@ void perf_pmus__print_pmu_events(const struct print=
_callbacks *print_cb, void *p
>         qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>         for (int j =3D 0; j < len; j++) {
>                 /* Skip duplicates */
> -               if (j < len - 1 && pmu_alias_is_duplicate(&aliases[j], &a=
liases[j + 1]))
> -                       goto free;
> +               if (j < len - 1) {
> +                       enum dup_type dt =3D pmu_alias_duplicate_type(&al=
iases[j], &aliases[j + 1]);
> +
> +                       if (dt =3D=3D DUPLICATE) {
> +                               goto free;
> +                       } else if (print_cb->collapse_events && dt =3D=3D=
 SAME_TEXT) {
> +                               concat_pmu_names(pmu_names, sizeof(pmu_na=
mes),
> +                                                aliases[j].pmu_name, ali=
ases[j+1].pmu_name);
> +                               goto free;
> +                       }
> +               }

I think a label called 'free' is a little unfortunate given the
function called free.
When I did things with sevent I was bringing over previous `perf list`
code mainly so that the perf list output before and after the changes
was identical. I wonder if this logic would be better placed in the
callback like default_print_event which already maintains state
(last_topic) to optionally print different things. This may better
encapsulate the behavior rather than the logic being in the PMU code.

>
>                 print_cb->print_event(print_state,
>                                 aliases[j].topic,
> -                               aliases[j].pmu_name,
> +                               pmu_names[0] ? pmu_names : aliases[j].pmu=
_name,
>                                 aliases[j].name,
>                                 aliases[j].alias,
>                                 aliases[j].scale_unit,
> @@ -553,6 +611,7 @@ void perf_pmus__print_pmu_events(const struct print_c=
allbacks *print_cb, void *p
>                                 aliases[j].desc,
>                                 aliases[j].long_desc,
>                                 aliases[j].encoding_desc);

The encoding_desc will have a PMU with the suffix removed as per
skipping duplicates:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1954
So I think something like:
```
  br_mis_pred_retired
       [Instruction architecturally executed,mispredicted branch. Unit:
        armv9_cortex_a510,armv9_cortex_a710]
```
Would have an encoding of `armv9_cortex_a510/.../` without the a710
encoding being present. That said, I'm not sure anyone cares :-)

Thanks,
Ian

> +               pmu_names[0] =3D '\0';
>  free:
>                 zfree(&aliases[j].name);
>                 zfree(&aliases[j].alias);
> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-event=
s.h
> index 445efa1636c1..e91f9f830a2a 100644
> --- a/tools/perf/util/print-events.h
> +++ b/tools/perf/util/print-events.h
> @@ -27,6 +27,7 @@ struct print_callbacks {
>                         const char *threshold,
>                         const char *unit);
>         bool (*skip_duplicate_pmus)(void *print_state);
> +       bool collapse_events;
>  };
>
>  /** Print all events, the default when no options are specified. */
>
> --
> 2.34.1
>
