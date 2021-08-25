Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F728C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 00:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09465610A6
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 00:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhHYAOv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbhHYAOu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 20:14:50 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C02C061757
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 17:14:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g9so28632539ioq.11
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 17:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEtdD3iEI8OCv5vkiUPCt9bs8Qna6djyYdDmTXGr1vY=;
        b=hrjQisC8NRybYk3NN5NB0ZXu6ZB/egOpYVZfJwU8VaKEkxKCeTjoB2W1oTblANva+J
         0B9dPfkD/vSLqy61/ws4j8C1wo6QZ544ezuo4vyAmSNFCtaFVfSqyZkerRiNpIyhWkze
         QtUPbJgkxzmfzy4OBPX53UR0bMIzwzIhp7EGsCthV9lF3vaN/j+i8mxvZKiMm0uV84hJ
         jKmLVePIEkD5Arre4R32ZfIIkjyK3b2Dmbd38/kpgM3XuiBe5hVdCS/+VBAqOABgo5Tt
         6LvEKKCnJjATi+92rqkqKWbX1rFBRKLCDHfvt/RE4m42FsUU/9JUo45x8QOowPojyF0F
         UOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEtdD3iEI8OCv5vkiUPCt9bs8Qna6djyYdDmTXGr1vY=;
        b=m1KCrZBevEgNL7NGlLHUPslXPYRe5bWZioCOAGT+w9Xp6MIKkPmmmbX0+nBUbBd4F0
         8LEpdL/4ju4G4FGZPazmgdgYRXFeBVnWE2E1iPPXJ610/fSD+HvOK9TaxNxcVtZZA1zU
         wgBNgOBIf5u2M4pN2trjA8kc+Ds24lawiAz/x5VHbZWWaMhQawh3JBUJfVsJeWGQmFHY
         qFaLVcyaux783S0TA6j8mBrFYI6JgeP/sNilRNwbh/xCOj+fm85ggdEf98n6YjInpVQd
         omTn0BfnsxF+G3bzqcFb/QhMql/6irxA01mn2U+Qrr/DUL3OSpNPbMZmMyK0DnNVxnhC
         /Kuw==
X-Gm-Message-State: AOAM530vHBI3CCUEIwBeO1Jvk8wgFV3LNRB0nv7sqI0OJrqlasq7+dlb
        +8muJEC+XdfKNxf5qsDdRptD+35c1IEMZMKp7fyw1g==
X-Google-Smtp-Source: ABdhPJyxjKuzPbTRDaEqEK4umKGFFDpVf1wDeQrV8SwRC0vLqzqXxU52E9RjaqJpkKtZAEx5ZAiJxUfgQNJQJkcEJkU=
X-Received: by 2002:a5e:9249:: with SMTP id z9mr9664169iop.14.1629850444634;
 Tue, 24 Aug 2021 17:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <2e52bc21-8e60-f1fc-804b-d8993ca7c482@huawei.com>
In-Reply-To: <2e52bc21-8e60-f1fc-804b-d8993ca7c482@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Aug 2021 17:13:51 -0700
Message-ID: <CAP-5=fXqM4Y5R5BXJb9Caf8NO1Oyz+qFaote3AqFu0MDGCvgAQ@mail.gmail.com>
Subject: Re: [Question] perf tools: lex parsing issue
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 23, 2021 at 4:23 AM John Garry <john.garry@huawei.com> wrote:
>
> Hi jirka,
>
> If you remember from some time ago we discussed how the lex parsing
> creates strange aliases:
>
> https://lore.kernel.org/lkml/20200320093006.GA1343171@krava/
>
> I am no expert on l+y, but it seems that we simply don't set the term
> config field for known term types. Well, not for
> PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD type anyway.
>
> This super hack resolves that issue:
>
> --->8----
>
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -765,7 +765,12 @@ event_config ',' event_term
> struct list_head *head = $1;
> struct parse_events_term *term = $3
>
> + if (term->type_term == PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD) {
> +       term->config = strdup("period");
> + }
> +
> if (!head) {
>         parse_events_term__delete(term);
>         YYABORT;
> --
>
> ----8-----

Agreed this is hacky, I think it'd be better to fix this up in the
output. For example:

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6cdbee8a12e7..c77c42275efa 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -365,15 +365,21 @@ static int __perf_pmu__new_alias(struct
list_head *list, char *dir, char *name,
        memset(newval, 0, sizeof(newval));
        ret = 0;
        list_for_each_entry(term, &alias->terms, list) {
+               const char * config = term->config;
+
                if (ret)
                        ret += scnprintf(newval + ret, sizeof(newval) - ret,
                                         ",");
+               if (!config) {
+                       /* Note: config_term_names in parse_events.c
isn't accessible */
+                       config = config_term_names[term->type_term];
+               }
                if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
                        ret += scnprintf(newval + ret, sizeof(newval) - ret,
-                                        "%s=%#x", term->config, term->val.num);
+                                        "%s=%#x", config, term->val.num);
                else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
                        ret += scnprintf(newval + ret, sizeof(newval) - ret,
-                                        "%s=%s", term->config, term->val.str);
+                                        "%s=%s", config, term->val.str);
        }

        alias->name = strdup(name);

It looks like a similar fix is needed in format_alias.

Thanks,
Ian

> So we get "umask=0x80,period=0x30d40,event=0x6" now, rather than
> "umask=0x80,(null)=0x30d40,event=0x6", for the perf_pmu_alias.str, as an
> example.
>
> Did you ever get a chance to look into this issue? Do you know how could
> or should this field be set properly?
>
> Some more background:
> The reason I was looking at this is because I think it causes a problem
> for pmu-events (JSONs) aliasing for some PMUs. Specifically it's PMU
> which use "config=xxx" in sysfs files in
> /sys/bus/event_source/devices/PMUx/events/, rather than "event=xxx". The
> actual problem is that I trigger this warn in pmu.c:
>
> static void perf_pmu_assign_str(char *name, const char *field, char
> **old_str,
> char **new_str)
> {
>
> if (*new_str) { /* Have new string, check with old */
>         if (strcasecmp(*old_str, *new_str))
>                 pr_debug("alias %s differs i ... <---
>
> As I get "config=event=0xXXX" vs "config=(null)=0xXXX"
>
> As I am not sure how to solve that yet, but, since we have
> config=(null), I thought it best to solve the first issue first.
>
> Thanks,
> John
