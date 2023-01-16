Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B95C54EBE
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 22:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjAPWAm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 17:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjAPWAl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 17:00:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7152449D
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 14:00:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so24541066wmb.2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 14:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNMgnRdxl8cID5dDHZQku0mVCQNWegrqxUVZnzdGN40=;
        b=nNjvKSs3qKm3edSQucxlO+wqSAIaJBfNi6p974ivDyPbkfD8OZ+5nykh/KI0CjaL99
         ZME9P3rbqBe0w3vVscfSjuxMyr70jJgpfmAb9KdvkqTBrhUJpNL2cFmoXHQI09/3ffcM
         xKfMXfQeDGJ4VdSW+sRGlMmleWKNJbFBK+paWE5FucznXbSlp5PlaBiPepVgcOTH922c
         cVPaNj1quO1FKiniINuBvFIxBAGIN+Vq/X1KVn1VV0Z1/GQLknPUfX1Nwh5Jktp9HNn+
         Ons3PhsSm8KvF2oldYDiQH7KIOCmjmqySkSMRka3oebj7c1qn15LBRSqZwsT5eI+eGss
         nlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNMgnRdxl8cID5dDHZQku0mVCQNWegrqxUVZnzdGN40=;
        b=bcYbkNkSiO5zMFI5C3pHcTPQXuvxvDRvYDhq0nN5mQgZoXBCtZFEvYBiXgPkndQsH8
         z3CV0BjR2xgsoNm6NyFCLonRvyNNdcg9n6dBWmxMQZ7sMSJ/QnSYvnL9abJYxJUr/0vr
         xWyjfod0BSR38ILDG+yuDPzYMV/+QJqnsKLMnJf4A9hQmii9vpfbcvauqOfOjhHn/vHH
         Qj2Nio98YXl0mE6frEN9qmFb/MmMFHjD0+MJord3tMhwXLXl4OOAy7I5+wHpkMBzX7md
         Tn87PI9X5Rqk0D90tADMfEOduuqwI0kihcUoZvcqnNHoTbqG7EiIW1S0rAYbsRLDBos6
         wdJA==
X-Gm-Message-State: AFqh2kqnYtdl/sad9UQKCUPujUIm8L7NcoML/rubEJlSg3/Y0NbELAXh
        KJOTnBQ4CwrLa/rv3D2X271PnU27bbdDqi/uU6ta/g==
X-Google-Smtp-Source: AMrXdXsHuIgBy5BIQSMKTjuF57zvRXqW6FJhSaYVpJ46vp68UspRzwYrRXRofjTIHrEnHoSLw6D3Ivsy7ftSB8M1BWQ=
X-Received: by 2002:a05:600c:1c9a:b0:3d9:ee45:8a9e with SMTP id
 k26-20020a05600c1c9a00b003d9ee458a9emr45362wms.174.1673906438517; Mon, 16 Jan
 2023 14:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20220921170839.21927-1-atrajeev@linux.vnet.ibm.com>
 <Yyy0W6CnPk7BkkCU@kernel.org> <444a5a64-7bc6-d5fd-2880-611c5cbca587@intel.com>
 <3EE5CFF3-51BC-444E-8FEF-2AC219E809F6@linux.vnet.ibm.com> <41461A8A-74F7-4938-9E8D-9F275114E906@linux.vnet.ibm.com>
 <CAP-5=fXWCYQSpp92L64+7Piu0sfEq+RsigNLUowgCjsT218jow@mail.gmail.com> <5CAD9B57-1788-4C7E-9658-7634A49D8BF0@linux.vnet.ibm.com>
In-Reply-To: <5CAD9B57-1788-4C7E-9658-7634A49D8BF0@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 Jan 2023 14:00:26 -0800
Message-ID: <CAP-5=fXS+8Wg8+Qrob+7fb5Y6FeBQphzd=Y0a1eh6xNwc-SfYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/perf/tests: Fix string substitutions in build
 id test
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

On Mon, Jan 16, 2023 at 4:00 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 16-Jan-2023, at 11:47 AM, Ian Rogers <irogers@google.com> wrote:
> >
> > On Sun, Jan 15, 2023 at 9:03 PM Athira Rajeev
> > <atrajeev@linux.vnet.ibm.com> wrote:
> >>
> >>
> >>
> >>> On 28-Sep-2022, at 10:24 AM, Athira Rajeev <atrajeev@linux.vnet.ibm.c=
om> wrote:
> >>>
> >>> Hi All,
> >>>
> >>> Looking for what direction we can take here.
> >>> Do we want to change all tests in tools/perf/tests/shell except test_=
intel_pt.sh to use "bash" or go with
> >>> the approach in the patch ? Please share your comments
> >>>
> >>> Thanks
> >>> Athira
> >>>
> >>
> >> Hi All,
> >>
> >> Looking for what direction we can take here.
> >> Do we want to change all tests in tools/perf/tests/shell except test_i=
ntel_pt.sh to use "bash" or go with
> >> the approach in the patch ? Please share your comments
> >>
> >> Thanks
> >> Athira
> >
>
> Thanks Ian for the response.
>
> > I think some of what the patch is doing is good, some of it the
>
> Ian, can I take this as an ack for the patch so that Arnaldo can pick thi=
s in acme git ?

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > readability becomes a little harder by not being bash. I'm agnostic as
> > to which approach to take for the fix.
>
> May be we can take this as separate mail thread to get everyone=E2=80=99s=
 opinion on changing all tests in "tools/perf/tests/shell" except test_inte=
l_pt.sh to use =E2=80=9Cbash" ?
>
> >
> > An aside, I noticed that we do run some tests at build time:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/lib=
/Makefile?h=3Dperf/core#n390
> > So perhaps we can have a shellcheck build option, defaulted off but
> > enabled as part of Arnaldo's regular test scripts. The shellcheck
> > build option would run shellcheck to make sure that there weren't
> > errors in the shell code, which it is far too easy to introduce.
>
> Sure, that is a good option to have. I will check on having =E2=80=9Cshel=
lcheck" as a build option.
>
> Thanks
> Athira
>
> >
> > Thanks,
> > Ian
> >
> >>>> On 23-Sep-2022, at 11:54 AM, Adrian Hunter <adrian.hunter@intel.com>=
 wrote:
> >>>>
> >>>> On 22/09/22 22:15, Arnaldo Carvalho de Melo wrote:
> >>>>> Em Wed, Sep 21, 2022 at 10:38:38PM +0530, Athira Rajeev escreveu:
> >>>>>> The perf test named =E2=80=9Cbuild id cache operations=E2=80=9D sk=
ips with below
> >>>>>> error on some distros:
> >>>>>
> >>>>> I wonder if we shouldn't instead state that bash is needed?
> >>>>>
> >>>>> =E2=AC=A2[acme@toolbox perf-urgent]$ head -1 tools/perf/tests/shell=
/*.sh | grep ^#
> >>>>> #!/bin/sh
> >>>>> #!/bin/bash
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/bash
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/bash
> >>>>> #!/bin/sh
> >>>>> #!/bin/bash
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> #!/bin/sh
> >>>>> =E2=AC=A2[acme@toolbox perf-urgent]$
> >>>>>
> >>>>> Opinions?
> >>>>>
> >>>>
> >>>> Please don't change tools/perf/tests/shell/test_intel_pt.sh
> >>>>
> >>>> I started using shellcheck on that with the "perf test:
> >>>> test_intel_pt.sh: Add per-thread test" patch set that I sent.
> >>>>
> >>>> FYI, if you use shellcheck on buildid.sh, it shows up issues even
> >>>> after changing to bash:
> >>>>
> >>>> *** Before ***
> >>>>
> >>>> $ shellcheck -S warning tools/perf/tests/shell/buildid.sh
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 69:
> >>>>      link=3D${build_id_dir}/.build-id/${id:0:2}/${id:2}
> >>>>                                     ^-------^ SC2039: In POSIX sh, s=
tring indexing is undefined.
> >>>>                                               ^-----^ SC2039: In POS=
IX sh, string indexing is undefined.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 77:
> >>>>      file=3D${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/e=
lf
> >>>>                                     ^-------^ SC2039: In POSIX sh, s=
tring indexing is undefined.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 123:
> >>>>      echo "running: perf record $@"
> >>>>                                 ^-- SC2145: Argument mixes string an=
d array. Use * or separate argument.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 124:
> >>>>      ${perf} record --buildid-all -o ${data} $@ &> ${log}
> >>>>                                              ^-- SC2068: Double quot=
e array expansions to avoid re-splitting elements.
> >>>>                                                 ^-------^ SC2039: In=
 POSIX sh, &> is undefined.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 126:
> >>>>              echo "failed: record $@"
> >>>>                                   ^-- SC2145: Argument mixes string =
and array. Use * or separate argument.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 131:
> >>>>      check ${@: -1}
> >>>>            ^------^ SC2068: Double quote array expansions to avoid r=
e-splitting elements.
> >>>>            ^------^ SC2039: In POSIX sh, string indexing is undefine=
d.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 158:
> >>>> exit ${err}
> >>>>   ^----^ SC2154: err is referenced but not assigned.
> >>>>
> >>>> For more information:
> >>>> https://www.shellcheck.net/wiki/SC2068 -- Double quote array expansi=
ons to ...
> >>>> https://www.shellcheck.net/wiki/SC2145 -- Argument mixes string and =
array. ...
> >>>> https://www.shellcheck.net/wiki/SC2039 -- In POSIX sh, &> is undefin=
ed.
> >>>>
> >>>> *** After ***
> >>>>
> >>>> $ shellcheck -S warning tools/perf/tests/shell/buildid.sh
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 123:
> >>>>      echo "running: perf record $@"
> >>>>                                 ^-- SC2145: Argument mixes string an=
d array. Use * or separate argument.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 124:
> >>>>      ${perf} record --buildid-all -o ${data} $@ &> ${log}
> >>>>                                              ^-- SC2068: Double quot=
e array expansions to avoid re-splitting elements.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 126:
> >>>>              echo "failed: record $@"
> >>>>                                   ^-- SC2145: Argument mixes string =
and array. Use * or separate argument.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 131:
> >>>>      check ${@: -1}
> >>>>            ^------^ SC2068: Double quote array expansions to avoid r=
e-splitting elements.
> >>>>
> >>>>
> >>>> In tools/perf/tests/shell/buildid.sh line 158:
> >>>> exit ${err}
> >>>>   ^----^ SC2154: err is referenced but not assigned.
> >>>>
> >>>> For more information:
> >>>> https://www.shellcheck.net/wiki/SC2068 -- Double quote array expansi=
ons to ...
> >>>> https://www.shellcheck.net/wiki/SC2145 -- Argument mixes string and =
array. ...
> >>>> https://www.shellcheck.net/wiki/SC2154 -- err is referenced but not =
assigned.
>
