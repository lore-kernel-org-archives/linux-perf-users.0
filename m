Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2434AC46467
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 06:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjAPGR7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 01:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjAPGR5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 01:17:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AFB3C2C
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jan 2023 22:17:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so18025587wma.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jan 2023 22:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp0sb687cfAtkgOhH9CyeFxw4s7UGrILk9cGl0V1EFw=;
        b=cpW+xQTnEW4v0uSMkPsOTFZMUbQZFkKTRQTvwD3uNmD5B8KuA10dVE2vUpwvbGk9Vp
         fzXGQMEITqfZoSEQrOsVaDTCTRkvQaAxL1qzZWTJ7Z4EnP4uwMQOiJjWAOmDyDbidcsA
         ac9aD9hE1FlWzA486SlloDzavOMlnIBe2fR8CfdaRcPFszHuGI66gjQKAKL+9J18Dl0s
         EXMJXcnRtDDX2RYBv2JqyU4lJ4SrbD/jypKBXcWbv1gWKfSs0aefFt1AmMWADGUWdbiL
         tR1TbvobCmzQ9GOhxwmCGzWnAm4tYgzRIRsyplNUdLFMdIApFFy8r2uEDYexGJx6mlyN
         loKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp0sb687cfAtkgOhH9CyeFxw4s7UGrILk9cGl0V1EFw=;
        b=JJnFJ76Sj61hc//qbpV4CAE5A2GwRdUphnAroDNk/07hGttPRRcbnbClL3vvrJt1C4
         GI5LXxJQfQ0p7zMih5pTEOVPkN/ckzbAKsKZyEoWQh6iYoLtKV2mElCm9YEGWGzUym40
         55lJiX9XXILQ4e+TXNl8nb+87afKW8qlxrgXWpdeSVIZRqvcBSwtKnD7qONa9jX6HedQ
         NFrGzvfOY37AMHJqb9JHVM0m840dO/vxclWJwOe/U7Rlm4Tz4rEAqRT//RRLs8ARqUrZ
         19VP9b5STErXSuR94oCId3UyDqXfDrlCQGhGXzqSzDKgkg3pN2TTrYOjxgPg6hboSz52
         zjsQ==
X-Gm-Message-State: AFqh2kqiEDdY3f4NkiTYy6OPiit2nZdN9qaderQPQWjQRFDCA4ZoMBzx
        hU/R5hSeGqM310lQRndKm5PfD7X1ElaVUBU0lDTrOg==
X-Google-Smtp-Source: AMrXdXs/UQTUZsYehzlgD4gQ6IXe852cPjiEO3A1MF9nbrIPmjUcZh4AcFCB9+cvn21su2lK4v8naYLha0izmn7umQ0=
X-Received: by 2002:a05:600c:cc5:b0:3da:b40f:c734 with SMTP id
 fk5-20020a05600c0cc500b003dab40fc734mr431632wmb.115.1673849874818; Sun, 15
 Jan 2023 22:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20220921170839.21927-1-atrajeev@linux.vnet.ibm.com>
 <Yyy0W6CnPk7BkkCU@kernel.org> <444a5a64-7bc6-d5fd-2880-611c5cbca587@intel.com>
 <3EE5CFF3-51BC-444E-8FEF-2AC219E809F6@linux.vnet.ibm.com> <41461A8A-74F7-4938-9E8D-9F275114E906@linux.vnet.ibm.com>
In-Reply-To: <41461A8A-74F7-4938-9E8D-9F275114E906@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 15 Jan 2023 22:17:42 -0800
Message-ID: <CAP-5=fXWCYQSpp92L64+7Piu0sfEq+RsigNLUowgCjsT218jow@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/perf/tests: Fix string substitutions in build
 id test
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jan 15, 2023 at 9:03 PM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 28-Sep-2022, at 10:24 AM, Athira Rajeev <atrajeev@linux.vnet.ibm.com=
> wrote:
> >
> > Hi All,
> >
> > Looking for what direction we can take here.
> > Do we want to change all tests in tools/perf/tests/shell except test_in=
tel_pt.sh to use "bash" or go with
> > the approach in the patch ? Please share your comments
> >
> > Thanks
> > Athira
> >
>
> Hi All,
>
> Looking for what direction we can take here.
> Do we want to change all tests in tools/perf/tests/shell except test_inte=
l_pt.sh to use "bash" or go with
> the approach in the patch ? Please share your comments
>
> Thanks
> Athira

I think some of what the patch is doing is good, some of it the
readability becomes a little harder by not being bash. I'm agnostic as
to which approach to take for the fix.

An aside, I noticed that we do run some tests at build time:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/lib/Mak=
efile?h=3Dperf/core#n390
So perhaps we can have a shellcheck build option, defaulted off but
enabled as part of Arnaldo's regular test scripts. The shellcheck
build option would run shellcheck to make sure that there weren't
errors in the shell code, which it is far too easy to introduce.

Thanks,
Ian

> >> On 23-Sep-2022, at 11:54 AM, Adrian Hunter <adrian.hunter@intel.com> w=
rote:
> >>
> >> On 22/09/22 22:15, Arnaldo Carvalho de Melo wrote:
> >>> Em Wed, Sep 21, 2022 at 10:38:38PM +0530, Athira Rajeev escreveu:
> >>>> The perf test named =E2=80=9Cbuild id cache operations=E2=80=9D skip=
s with below
> >>>> error on some distros:
> >>>
> >>> I wonder if we shouldn't instead state that bash is needed?
> >>>
> >>> =E2=AC=A2[acme@toolbox perf-urgent]$ head -1 tools/perf/tests/shell/*=
.sh | grep ^#
> >>> #!/bin/sh
> >>> #!/bin/bash
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/bash
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/bash
> >>> #!/bin/sh
> >>> #!/bin/bash
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> #!/bin/sh
> >>> =E2=AC=A2[acme@toolbox perf-urgent]$
> >>>
> >>> Opinions?
> >>>
> >>
> >> Please don't change tools/perf/tests/shell/test_intel_pt.sh
> >>
> >> I started using shellcheck on that with the "perf test:
> >> test_intel_pt.sh: Add per-thread test" patch set that I sent.
> >>
> >> FYI, if you use shellcheck on buildid.sh, it shows up issues even
> >> after changing to bash:
> >>
> >> *** Before ***
> >>
> >> $ shellcheck -S warning tools/perf/tests/shell/buildid.sh
> >>
> >> In tools/perf/tests/shell/buildid.sh line 69:
> >>       link=3D${build_id_dir}/.build-id/${id:0:2}/${id:2}
> >>                                      ^-------^ SC2039: In POSIX sh, st=
ring indexing is undefined.
> >>                                                ^-----^ SC2039: In POSI=
X sh, string indexing is undefined.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 77:
> >>       file=3D${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/el=
f
> >>                                      ^-------^ SC2039: In POSIX sh, st=
ring indexing is undefined.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 123:
> >>       echo "running: perf record $@"
> >>                                  ^-- SC2145: Argument mixes string and=
 array. Use * or separate argument.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 124:
> >>       ${perf} record --buildid-all -o ${data} $@ &> ${log}
> >>                                               ^-- SC2068: Double quote=
 array expansions to avoid re-splitting elements.
> >>                                                  ^-------^ SC2039: In =
POSIX sh, &> is undefined.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 126:
> >>               echo "failed: record $@"
> >>                                    ^-- SC2145: Argument mixes string a=
nd array. Use * or separate argument.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 131:
> >>       check ${@: -1}
> >>             ^------^ SC2068: Double quote array expansions to avoid re=
-splitting elements.
> >>             ^------^ SC2039: In POSIX sh, string indexing is undefined=
.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 158:
> >> exit ${err}
> >>    ^----^ SC2154: err is referenced but not assigned.
> >>
> >> For more information:
> >> https://www.shellcheck.net/wiki/SC2068 -- Double quote array expansion=
s to ...
> >> https://www.shellcheck.net/wiki/SC2145 -- Argument mixes string and ar=
ray. ...
> >> https://www.shellcheck.net/wiki/SC2039 -- In POSIX sh, &> is undefined=
.
> >>
> >> *** After ***
> >>
> >> $ shellcheck -S warning tools/perf/tests/shell/buildid.sh
> >>
> >> In tools/perf/tests/shell/buildid.sh line 123:
> >>       echo "running: perf record $@"
> >>                                  ^-- SC2145: Argument mixes string and=
 array. Use * or separate argument.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 124:
> >>       ${perf} record --buildid-all -o ${data} $@ &> ${log}
> >>                                               ^-- SC2068: Double quote=
 array expansions to avoid re-splitting elements.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 126:
> >>               echo "failed: record $@"
> >>                                    ^-- SC2145: Argument mixes string a=
nd array. Use * or separate argument.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 131:
> >>       check ${@: -1}
> >>             ^------^ SC2068: Double quote array expansions to avoid re=
-splitting elements.
> >>
> >>
> >> In tools/perf/tests/shell/buildid.sh line 158:
> >> exit ${err}
> >>    ^----^ SC2154: err is referenced but not assigned.
> >>
> >> For more information:
> >> https://www.shellcheck.net/wiki/SC2068 -- Double quote array expansion=
s to ...
> >> https://www.shellcheck.net/wiki/SC2145 -- Argument mixes string and ar=
ray. ...
> >> https://www.shellcheck.net/wiki/SC2154 -- err is referenced but not as=
signed.
> >
>
