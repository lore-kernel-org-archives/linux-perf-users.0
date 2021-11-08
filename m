Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD98FC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D1960EE0
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhKHSJ6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhKHSJ5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 13:09:57 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B810FC061570
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 10:07:12 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o12so14509618qtv.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 10:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=+FgFg6CGI++zV9ojz69GS11CyYD+jB2kl8CnH40olNo=;
        b=Y5eOvx985H+s2IhAFXpn84scRQ0QSnJhneQ0/ri3EiitZ/cb+LHZGJpJcG8g6KDG2A
         JqywW7/LZXB5jmkMcC02YYzrIpbIKQKsEsE9OzBLbDHTLiOGth4v+La2zfJJPPbCS7zB
         gePyuijLOA5Fu6n8PdQO+zsfthXkl6cpAWj7wyNVGNflyWH3sa53AqntCKJ+yngorsdv
         AuoJ8L5XqW6ajtxcDzZuRTI40cno7x3Eo/tQrbW409/FofWeM47nywjZ7pBdYRMWI4QZ
         zfOcgkD86eoIC/yRQ66QZ4wqhg2iWY3Uu9zCU/dSPm1pkwrIDp8aYLhPFHHlSiEdlr7d
         zMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=+FgFg6CGI++zV9ojz69GS11CyYD+jB2kl8CnH40olNo=;
        b=ISNuDmMFz1cWSAhrs+FFQYSs8WrC8x/5nv8W74PuWe8C2/45JUpLN0SvqhZW+UjiGs
         3YZg36iCnqikE4L+Cw+6uWJix983lG/uhdsG4Eh0w68EjmBlwL9QYb0GBrwD7+fVD5zi
         PXtSkhAuEdnZo32x42LjVxJSE1H4LGkCPvUseMaXIPPfjcoKQxrE6ofRIz42kJ1SIHIL
         fZ0a4JKt1jFpIGWD4nSu+d/apn47deOzVs6CACJWNQd6Aq96d8AbwCW5EgmrCEe7vbYO
         5zCMuMENcc/rUwJqiysD1kHB8D6M/OisR0iYZK6oS9jzlNNq5P9Frw9mcV0DsBQ1hETa
         sVFg==
X-Gm-Message-State: AOAM53094uVt7/d037YRnImNxmh/6gm58mjiipLq3ESoagHaRGnu+Iwg
        wm5NLjCFhm8/cJg7DgpY+MTlgwL2S4M=
X-Google-Smtp-Source: ABdhPJxI0202icvG6Wazwn8Pjf+jHHry+3Vjchak64+c/zk4PE/pTW9FR0JVKmhQWgeFId8W+f+ESA==
X-Received: by 2002:a05:622a:1883:: with SMTP id v3mr1475922qtc.327.1636394831536;
        Mon, 08 Nov 2021 10:07:11 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id bi39sm4979082qkb.29.2021.11.08.10.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 10:07:10 -0800 (PST)
Date:   Mon, 08 Nov 2021 15:07:05 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 18/59] libperf: Move group_name to perf_evsel
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fU=4q5=6ejcc1G4RKdUDbENSLdNVBbP=iWuYiwc8Yq_0Q@mail.gmail.com>
References: <20211108133710.1352822-1-jolsa@kernel.org> <20211108133710.1352822-19-jolsa@kernel.org> <CAP-5=fU=4q5=6ejcc1G4RKdUDbENSLdNVBbP=iWuYiwc8Yq_0Q@mail.gmail.com>
Message-ID: <D3BB2601-12C9-46D4-82E3-4E2F47604F14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On November 8, 2021 2:58:39 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom=
> wrote:
>On Mon, Nov 8, 2021 at 5:39 AM Jiri Olsa <jolsa@redhat=2Ecom> wrote:
>>
>> Moving group_name to perf_evsel struct=2E
>>
>> Signed-off-by: Jiri Olsa <jolsa@kernel=2Eorg>
>> ---
>>  tools/lib/perf/include/internal/evsel=2Eh |  1 +
>>  tools/perf/tests/parse-events=2Ec         | 32 ++++++++++++-----------=
--
>>  tools/perf/util/auxtrace=2Ec              |  6 ++---
>>  tools/perf/util/evsel=2Ec                 | 10 ++++----
>>  tools/perf/util/evsel=2Eh                 |  1 -
>>  tools/perf/util/evsel_fprintf=2Ec         |  2 +-
>>  tools/perf/util/header=2Ec                |  6 ++---
>>  tools/perf/util/parse-events=2Ec          |  4 ++--
>>  8 files changed, 31 insertions(+), 31 deletions(-)
>>
>> diff --git a/tools/lib/perf/include/internal/evsel=2Eh b/tools/lib/perf=
/include/internal/evsel=2Eh
>> index 81df282fa008=2E=2Ebefcd180ef3d 100644
>> --- a/tools/lib/perf/include/internal/evsel=2Eh
>> +++ b/tools/lib/perf/include/internal/evsel=2Eh
>> @@ -64,6 +64,7 @@ struct perf_evsel {
>>          */
>>          struct {
>>                  char                   *name;
>> +               const char              *group_name;
>
>I like the constification here=2E But why constify group_name and not
>name as well?


Can be done in a separate patch, in other series, no?

I understand that he probably is taking advantage of this move do constify=
 'group_name', but then, looks unrelated too this move to libperf as well=
=2E

- Arnaldo



>
>Thanks,
>Ian
>
>>                 bool                    auto_merge_stats;
>>                 struct list_head        config_terms;
>>                 const char              *metric_id;
>> diff --git a/tools/perf/tests/parse-events=2Ec b/tools/perf/tests/parse=
-events=2Ec
>> index 15d6d3d907b7=2E=2E50746bb524f0 100644
>> --- a/tools/perf/tests/parse-events=2Ec
>> +++ b/tools/perf/tests/parse-events=2Ec
>> @@ -782,7 +782,7 @@ static int test__group3(struct evlist *evlist __may=
be_unused)
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>>         TEST_ASSERT_VAL("wrong group name",
>> -               !strcmp(leader->group_name, "group1"));
>> +               !strcmp(leader->core=2Egroup_name, "group1"));
>>         TEST_ASSERT_VAL("wrong core=2Enr_members", evsel->core=2Enr_mem=
bers =3D=3D 2);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 0);
>>         TEST_ASSERT_VAL("wrong sample_read", !evsel->core=2Esample_read=
);
>> @@ -800,7 +800,7 @@ static int test__group3(struct evlist *evlist __may=
be_unused)
>>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core=2Eattr=2Eexc=
lude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core=2Eattr=2Eprecis=
e_ip =3D=3D 3);
>>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader=
));
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 1);
>>         TEST_ASSERT_VAL("wrong sample_read", !evsel->core=2Esample_read=
);
>>
>> @@ -817,7 +817,7 @@ static int test__group3(struct evlist *evlist __may=
be_unused)
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>>         TEST_ASSERT_VAL("wrong group name",
>> -               !strcmp(leader->group_name, "group2"));
>> +               !strcmp(leader->core=2Egroup_name, "group2"));
>>         TEST_ASSERT_VAL("wrong core=2Enr_members", evsel->core=2Enr_mem=
bers =3D=3D 2);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 0);
>>         TEST_ASSERT_VAL("wrong sample_read", !evsel->core=2Esample_read=
);
>> @@ -872,7 +872,7 @@ static int test__group4(struct evlist *evlist __may=
be_unused)
>>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core=2Eattr=2Eexc=
lude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core=2Eattr=2Eexc=
lude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core=2Eattr=2Eprecis=
e_ip =3D=3D 1);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>>         TEST_ASSERT_VAL("wrong core=2Enr_members", evsel->core=2Enr_mem=
bers =3D=3D 2);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 0);
>> @@ -915,7 +915,7 @@ static int test__group5(struct evlist *evlist __may=
be_unused)
>>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core=2Eattr=2Eex=
clude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", evsel->core=2Eattr=2Eexcl=
ude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>>         TEST_ASSERT_VAL("wrong core=2Enr_members", evsel->core=2Enr_mem=
bers =3D=3D 2);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 0);
>> @@ -947,7 +947,7 @@ static int test__group5(struct evlist *evlist __may=
be_unused)
>>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core=2Eattr=2Eex=
clude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", evsel->core=2Eattr=2Eexcl=
ude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>>         TEST_ASSERT_VAL("wrong core=2Enr_members", evsel->core=2Enr_mem=
bers =3D=3D 2);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 0);
>> @@ -1001,7 +1001,7 @@ static int test__group_gh1(struct evlist *evlist)
>>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core=2Eattr=2Eexc=
lude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core=2Eattr=2Eexc=
lude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>>         TEST_ASSERT_VAL("wrong core=2Enr_members", evsel->core=2Enr_mem=
bers =3D=3D 2);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 0);
>> @@ -1041,7 +1041,7 @@ static int test__group_gh2(struct evlist *evlist)
>>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core=2Eattr=2Eex=
clude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", evsel->core=2Eattr=2Eexcl=
ude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>>         TEST_ASSERT_VAL("wrong core=2Enr_members", evsel->core=2Enr_mem=
bers =3D=3D 2);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 0);
>> @@ -1081,7 +1081,7 @@ static int test__group_gh3(struct evlist *evlist)
>>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core=2Eattr=2Eex=
clude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", evsel->core=2Eattr=2Eexcl=
ude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>>         TEST_ASSERT_VAL("wrong core=2Enr_members", evsel->core=2Enr_mem=
bers =3D=3D 2);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 0);
>> @@ -1121,7 +1121,7 @@ static int test__group_gh4(struct evlist *evlist)
>>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core=2Eattr=2Eex=
clude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", evsel->core=2Eattr=2Eexcl=
ude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>>         TEST_ASSERT_VAL("wrong core=2Enr_members", evsel->core=2Enr_mem=
bers =3D=3D 2);
>>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) =3D=
=3D 0);
>> @@ -1160,7 +1160,7 @@ static int test__leader_sample1(struct evlist *ev=
list)
>>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core=2Eattr=2Eexc=
lude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core=2Eattr=2Eexc=
lude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader=
));
>>         TEST_ASSERT_VAL("wrong sample_read", evsel->core=2Esample_read)=
;
>>
>> @@ -1189,7 +1189,7 @@ static int test__leader_sample1(struct evlist *ev=
list)
>>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core=2Eattr=2Eexc=
lude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core=2Eattr=2Eexc=
lude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader=
));
>>         TEST_ASSERT_VAL("wrong sample_read", evsel->core=2Esample_read)=
;
>>
>> @@ -1213,7 +1213,7 @@ static int test__leader_sample2(struct evlist *ev=
list __maybe_unused)
>>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core=2Eattr=2Eexc=
lude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core=2Eattr=2Eexc=
lude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader=
));
>>         TEST_ASSERT_VAL("wrong sample_read", evsel->core=2Esample_read)=
;
>>
>> @@ -1228,7 +1228,7 @@ static int test__leader_sample2(struct evlist *ev=
list __maybe_unused)
>>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core=2Eattr=2Eexc=
lude_guest);
>>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core=2Eattr=2Eexc=
lude_host);
>>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core=2Eattr=2Epreci=
se_ip);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader=
));
>>         TEST_ASSERT_VAL("wrong sample_read", evsel->core=2Esample_read)=
;
>>
>> @@ -1259,7 +1259,7 @@ static int test__pinned_group(struct evlist *evli=
st)
>>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D evsel->=
core=2Eattr=2Etype);
>>         TEST_ASSERT_VAL("wrong config",
>>                         PERF_COUNT_HW_CPU_CYCLES =3D=3D evsel->core=2Ea=
ttr=2Econfig);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader=
));
>>         TEST_ASSERT_VAL("wrong pinned", evsel->core=2Eattr=2Epinned);
>>
>> @@ -1303,7 +1303,7 @@ static int test__exclusive_group(struct evlist *e=
vlist)
>>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE =3D=3D evsel->=
core=2Eattr=2Etype);
>>         TEST_ASSERT_VAL("wrong config",
>>                         PERF_COUNT_HW_CPU_CYCLES =3D=3D evsel->core=2Ea=
ttr=2Econfig);
>> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
>> +       TEST_ASSERT_VAL("wrong group name", !evsel->core=2Egroup_name);
>>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader=
));
>>         TEST_ASSERT_VAL("wrong exclusive", evsel->core=2Eattr=2Eexclusi=
ve);
>>
>> diff --git a/tools/perf/util/auxtrace=2Ec b/tools/perf/util/auxtrace=2E=
c
>> index c679394b898d=2E=2Ea882bc81e0fb 100644
>> --- a/tools/perf/util/auxtrace=2Ec
>> +++ b/tools/perf/util/auxtrace=2Ec
>> @@ -1235,9 +1235,9 @@ static void unleader_evsel(struct evlist *evlist,=
 struct evsel *leader)
>>
>>         /* Update group information */
>>         if (new_leader) {
>> -               zfree(&new_leader->group_name);
>> -               new_leader->group_name =3D leader->group_name;
>> -               leader->group_name =3D NULL;
>> +               zfree(&new_leader->core=2Egroup_name);
>> +               new_leader->core=2Egroup_name =3D leader->core=2Egroup_=
name;
>> +               leader->core=2Egroup_name =3D NULL;
>>
>>                 new_leader->core=2Enr_members =3D leader->core=2Enr_mem=
bers - 1;
>>                 leader->core=2Enr_members =3D 1;
>> diff --git a/tools/perf/util/evsel=2Ec b/tools/perf/util/evsel=2Ec
>> index aafd91805870=2E=2E7621eddc8e58 100644
>> --- a/tools/perf/util/evsel=2Ec
>> +++ b/tools/perf/util/evsel=2Ec
>> @@ -395,9 +395,9 @@ struct evsel *evsel__clone(struct evsel *orig)
>>                 if (evsel->core=2Ename =3D=3D NULL)
>>                         goto out_err;
>>         }
>> -       if (orig->group_name) {
>> -               evsel->group_name =3D strdup(orig->group_name);
>> -               if (evsel->group_name =3D=3D NULL)
>> +       if (orig->core=2Egroup_name) {
>> +               evsel->core=2Egroup_name =3D strdup(orig->core=2Egroup_=
name);
>> +               if (evsel->core=2Egroup_name =3D=3D NULL)
>>                         goto out_err;
>>         }
>>         if (orig->pmu_name) {
>> @@ -797,7 +797,7 @@ const char *evsel__metric_id(const struct evsel *ev=
sel)
>>
>>  const char *evsel__group_name(struct evsel *evsel)
>>  {
>> -       return evsel->group_name ?: "anon group";
>> +       return evsel->core=2Egroup_name ?: "anon group";
>>  }
>>
>>  /*
>> @@ -1436,7 +1436,7 @@ void evsel__exit(struct evsel *evsel)
>>         perf_cpu_map__put(evsel->core=2Ecpus);
>>         perf_cpu_map__put(evsel->core=2Eown_cpus);
>>         perf_thread_map__put(evsel->core=2Ethreads);
>> -       zfree(&evsel->group_name);
>> +       zfree(&evsel->core=2Egroup_name);
>>         zfree(&evsel->core=2Ename);
>>         zfree(&evsel->pmu_name);
>>         zfree(&evsel->core=2Emetric_id);
>> diff --git a/tools/perf/util/evsel=2Eh b/tools/perf/util/evsel=2Eh
>> index c09bbddd5da0=2E=2Ee06d171baba3 100644
>> --- a/tools/perf/util/evsel=2Eh
>> +++ b/tools/perf/util/evsel=2Eh
>> @@ -54,7 +54,6 @@ struct evsel {
>>          * they can be released properly=2E
>>          */
>>         struct {
>> -               char                    *group_name;
>>                 const char              *pmu_name;
>>                 struct tep_event        *tp_format;
>>                 char                    *filter;
>> diff --git a/tools/perf/util/evsel_fprintf=2Ec b/tools/perf/util/evsel_=
fprintf=2Ec
>> index 8c2ea8001329=2E=2E4670d1e745b2 100644
>> --- a/tools/perf/util/evsel_fprintf=2Ec
>> +++ b/tools/perf/util/evsel_fprintf=2Ec
>> @@ -48,7 +48,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_a=
ttr_details *details, FILE
>>                         return 0;
>>
>>                 if (evsel->core=2Enr_members > 1)
>> -                       printed +=3D fprintf(fp, "%s{", evsel->group_na=
me ?: "");
>> +                       printed +=3D fprintf(fp, "%s{", evsel->core=2Eg=
roup_name ?: "");
>>
>>                 printed +=3D fprintf(fp, "%s", evsel__name(evsel));
>>                 for_each_group_member(pos, evsel)
>> diff --git a/tools/perf/util/header=2Ec b/tools/perf/util/header=2Ec
>> index 4610b23fed28=2E=2Ea14b690a6025 100644
>> --- a/tools/perf/util/header=2Ec
>> +++ b/tools/perf/util/header=2Ec
>> @@ -788,7 +788,7 @@ static int write_group_desc(struct feat_fd *ff,
>>
>>         evlist__for_each_entry(evlist, evsel) {
>>                 if (evsel__is_group_leader(evsel) && evsel->core=2Enr_m=
embers > 1) {
>> -                       const char *name =3D evsel->group_name ?: "{ano=
n_group}";
>> +                       const char *name =3D evsel->core=2Egroup_name ?=
: "{anon_group}";
>>                         u32 leader_idx =3D evsel->core=2Eidx;
>>                         u32 nr_members =3D evsel->core=2Enr_members;
>>
>> @@ -2094,7 +2094,7 @@ static void print_group_desc(struct feat_fd *ff, =
FILE *fp)
>>
>>         evlist__for_each_entry(session->evlist, evsel) {
>>                 if (evsel__is_group_leader(evsel) && evsel->core=2Enr_m=
embers > 1) {
>> -                       fprintf(fp, "# group: %s{%s", evsel->group_name=
 ?: "", evsel__name(evsel));
>> +                       fprintf(fp, "# group: %s{%s", evsel->core=2Egro=
up_name ?: "", evsel__name(evsel));
>>
>>                         nr =3D evsel->core=2Enr_members - 1;
>>                 } else if (nr) {
>> @@ -2743,7 +2743,7 @@ static int process_group_desc(struct feat_fd *ff,=
 void *data __maybe_unused)
>>                         evsel__set_leader(evsel, evsel);
>>                         /* {anon_group} is a dummy name */
>>                         if (strcmp(desc[i]=2Ename, "{anon_group}")) {
>> -                               evsel->group_name =3D desc[i]=2Ename;
>> +                               evsel->core=2Egroup_name =3D desc[i]=2E=
name;
>>                                 desc[i]=2Ename =3D NULL;
>>                         }
>>                         evsel->core=2Enr_members =3D desc[i]=2Enr_membe=
rs;
>> diff --git a/tools/perf/util/parse-events=2Ec b/tools/perf/util/parse-e=
vents=2Ec
>> index 24d01b768078=2E=2E05a96b0f7b41 100644
>> --- a/tools/perf/util/parse-events=2Ec
>> +++ b/tools/perf/util/parse-events=2Ec
>> @@ -1841,7 +1841,7 @@ parse_events__set_leader_for_uncore_aliase(char *=
name, struct list_head *list,
>>         for (i =3D 0; i < nr_pmu; i++) {
>>                 evsel =3D (struct evsel *) leaders[i];
>>                 evsel->core=2Enr_members =3D total_members / nr_pmu;
>> -               evsel->group_name =3D name ? strdup(name) : NULL;
>> +               evsel->core=2Egroup_name =3D name ? strdup(name) : NULL=
;
>>         }
>>
>>         /* Take the new small groups into account */
>> @@ -1869,7 +1869,7 @@ void parse_events__set_leader(char *name, struct =
list_head *list,
>>
>>         __perf_evlist__set_leader(list);
>>         leader =3D list_entry(list->next, struct evsel, core=2Enode);
>> -       leader->group_name =3D name ? strdup(name) : NULL;
>> +       leader->core=2Egroup_name =3D name ? strdup(name) : NULL;
>>  }
>>
>>  /* list_event is assumed to point to malloc'ed memory */
>> --
>> 2=2E31=2E1
>>
