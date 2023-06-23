Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409EEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 15:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjFWPsY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFWPsY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 11:48:24 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09691992
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:48:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40079620a83so276801cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687535302; x=1690127302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO6SynvDn3OzRWZeh6Y6I9PLRzw90cIdMvq1TvAG1lE=;
        b=XNfL+IvqTPhEayZh8TUqs8sbjtBoiL2cVXMhE+IQqmhUstgrzCvxxnDQ9ZZTEXiNoL
         OSiwZjLHqJayefoCIf/m+ZY6jZsJcuH86EAoPZIVHxaE/vzDlrplWDetx+TvGxLNi823
         LNzl1MT9fb4CBN9/4BA4UP+gYpaWQZoCaqlKtbS+PXngfiw2MO4s0kMYsHUxN0hRlLhL
         TegwkEO8G0/L5ylg3cHFfShxCFbN9RurNn7lb5AWU/X7l5mwulUMvQpCuXDBLVjWdTvu
         qZ/DQH8ifQLWRq5TecUs30MITLsRPM0wOCpfCEcHrHaeKpf/C9zrHoZPjS3XI0MXZHfO
         mhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687535302; x=1690127302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO6SynvDn3OzRWZeh6Y6I9PLRzw90cIdMvq1TvAG1lE=;
        b=fth3u6iko8k95BcJXp1QMzWEeTf4f7OD1lRK5bR3CLLT08Tn0jSYEoS/NRJHWEbb7c
         LCVPy2W9v0urYCdZTGayRVniB4GTpWoi9x5EkoC0jsHMEKwudqbl0Sdt59S3D/2AopJS
         Rc+50Q4JpFwqctXiepusjHjPvV+b8uez9EG9rs73JhtZXSxLMCeWZFLZlabXJPTO1yYN
         RHsxeQdagX+fTRjoB9u2kDsJdlyPWdEMA4VQyaX4ZKiomr4Fs5gYKOFJDRBoPozQkiVG
         4OyMT8gTMm6+gXEYDFOqRjdbIapW+4GTIZLnlXXzR1p/JYoig4Bg4kJhKDcTgJqtk02a
         LVFQ==
X-Gm-Message-State: AC+VfDziM63MgNAAnPtoJvu0Xj4J6aI58jdKHOXRjlEC7j1KBdUORvcz
        ORNSAVhI/GOwTkeOJ5l+oPkSlMOTmsXfazrmg2HkHA==
X-Google-Smtp-Source: ACHHUZ4u/h8F6A8tOpO+LDivCm5tM6rBWGHMgWLvab898rSjVn941KaIjNwcgCxVpZ7dkZxqVAFkzESMbcXAQodPgn8=
X-Received: by 2002:a05:622a:1051:b0:3f7:ff4a:eae5 with SMTP id
 f17-20020a05622a105100b003f7ff4aeae5mr154232qte.12.1687535301890; Fri, 23 Jun
 2023 08:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <151a8677-3259-0586-03f3-fb751782daa9@oracle.com>
In-Reply-To: <151a8677-3259-0586-03f3-fb751782daa9@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 08:48:10 -0700
Message-ID: <CAP-5=fXDVUToBbS6z8YY9K0vh5Z=PHh83RZXX3=NugTEqFeXzQ@mail.gmail.com>
Subject: Re: perf test pmu-events question
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 23, 2023 at 8:20=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> Hi Ian,
>
> I was doing some re-write for pmu sys events metric support and I want
> to add more testcases - we don't really have any.
>
> So I noticed that tests/pmu-events.c::test__parsing() can pick up on an
> invalid metric for the test CPU, like M3 as it references itself.
> However we can't detect whether event aliases referenced in the metric
> exist for the CPU. Is it worth testing for this? Would it be sane to
> scan the associated CPU event tables to see if we can find the event
> there? Or do we already have some per-non-test-CPU metric validator
> already in the testcases (I could not see it)?


Hi John,

we always need more tests :-) For Intel there has historically been a
problem that the names in metrics and the event data will get out of
alignment. There is a best effort test during the metric generation
that this doesn't happen any more here:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L117=
1-L1188
But still things get messed up, such as PMU names being mismatched -
when this happens the JSON events just don't appear at runtime. We
could try to replicate the event matching logic at creation time in
jevents.py and that should do what you mention and be
multi-architecture. The metric test tests every metric produces an
output, and this fails when event parsing fails, so this has
traditionally been the way to find bad metrics. We do have build time
tests like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/Build?h=3Dperf-tools-next#n30

Intel don't have JSON encodings for the TSX events and so they use
sysfs events and this is what motivated the has_event test:
https://lore.kernel.org/linux-perf-users/20230623151016.4193660-1-irogers@g=
oogle.com/

Some other thoughts in this area:
1) I'd like to get sysfs snapshots so that we can get things like
parse-events coverage of heterogeneous PMUs without needing such a
system.
2) The largest part of the perf binary is the json data. I'd like to
convert the json data to a sysfs style, then compress it in a way
where we benefit from duplication between files (zip can't do this,
but tgz or 7zip can). libarchive can load these formats from memory.
The current json data on x86 converts to about 7MB of read-only data,
but the same json files compress down to about 1.5MB. The perf binary
is about 3MB of code, so doing the compression should hopefully make
the file size about half what it currently is and do something to stem
the problem of the binary slowly growing over time with new
architecture releases.
3) I'm hoping we can do something like a unionfs with the in memory
sysfs, on disk sysfs tar balls and the like, and the machine's actual
sysfs so that we can just have one consistent view in the tool.
4) I want to make PMUs lazier so that we don't need to eagerly load
all the events. The cycles event doesn't need json or sysfs data, but
it is all still loaded due to wanting the PMU. This faults in a lot of
JSON data on x86 that is then never used.

Thanks,
Ian

> Thanks,
> John
>
>
