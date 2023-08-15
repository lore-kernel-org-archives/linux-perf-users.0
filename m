Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594FFC0015E
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 09:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjHOJFZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 05:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjHOJFR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 05:05:17 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D110C
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 02:05:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so162921cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692090314; x=1692695114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8pKN5MCV3d+31+9G9lYvjgDTbv0WuS6GUtl295mKqA=;
        b=w0q9sxLSRiddNARvPMMu1PUEMagBcaxLz7j5upP6Xoyyc4ArLjboXenakWye3w5t2w
         DKAWnhJpST0WFoTyHop+738h6QZ17ZRXAm0bB4isyCfx0t6jxHL3mtojSbrPe4UxLNMD
         FiayEwuotWzyegI7G0kaFZWylliSmqJ2bmmrS9A89pSnalyf+jX03XrLevE0Lreob+Np
         3MVGctJ+2BwDU0P6/+ZB96D+AYilBfrqPHb0XD+wyN5vwom4P+5tuxTRp7uev6BaVH2z
         tMPyrj9JX2Xk7EQpu0OCK9sRCKP1Pecvpjz/wmJItrp13ieikHgU1XyEx+QeKgLlDNWL
         jPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090314; x=1692695114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8pKN5MCV3d+31+9G9lYvjgDTbv0WuS6GUtl295mKqA=;
        b=UDh9yduTJ113YRyC68kw5329s8rhFuMOLo/dUlP0VDXWQplm6DNPVlht18TU9BHASC
         B9wuNyGYgxmab3dyU0TdoRqKEy+386JweGuTnSTw6vlBhYCMHjSN0jzjt0CgccEvOW5w
         2Cxu5OAclbFBRzqnh5HbqqF8bLbrhmjXjn0nzXQJSYARUFP9MHABuO7BXoPz1d+wxw53
         FjUnbWLmCf/cks6bOu3G8DQCrdfpS5mjdGmOi7hTSXJN5u5i3qvDlsuSGUySi/HZKdqf
         Uhy9CwtcVrRH9ov7D26JtVSAgsYfUPh9DT14Et2PGvJOc2NHGeR1b5/gcQ05o1xlrZiX
         UvwA==
X-Gm-Message-State: AOJu0YyDDOlvLvhTp6bby7OcpdiLku4+qY5gR91ArWR6yXfPly0uiLq3
        CFRN8vT/EonmIAetggvvIVGRdtTVC6J3Kz8AlprhKQ==
X-Google-Smtp-Source: AGHT+IGJXAavhV8NOxz99me9XEA/iOMf+K+FC99ii+nIiZqgyufnvjl6qfGoIYVhU9NVxX+zYRyqYXDzjB8qQhoRXMA=
X-Received: by 2002:a05:622a:245:b0:403:b1e5:bcae with SMTP id
 c5-20020a05622a024500b00403b1e5bcaemr791122qtx.10.1692090313639; Tue, 15 Aug
 2023 02:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZNcxsN4Pvn5YPWsI@yoga> <ZNf9zM1mYAqCYqnf@yoga>
In-Reply-To: <ZNf9zM1mYAqCYqnf@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Aug 2023 02:05:02 -0700
Message-ID: <CAP-5=fWGb=h0NuU5tTTUVsgn-ScqZKqdTLHi5XuoL1jnPyyxpg@mail.gmail.com>
Subject: Re: [PATCH V2] perf test: Add support for testing gecko script
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Aug 12, 2023 at 2:47=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> On Sat, Aug 12, 2023 at 12:46:00PM +0530, Anup Sharma wrote:
> > This commit add support for testing gecko script. The test checks
> > for the presence of required sections such as "meta," "threads,"
> > "samples," "frameTable," "stackTable," "stringTable," and
> > "pausedRanges" which are few essential parameter to be present
> > in output file. Also it verifies the validity of the JSON format
> > using Python's JSON library if available.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> >
> > ---
> > Patch needed for testing:
> >     https://lore.kernel.org/linux-perf-users/ZNOS0vo58DnVLpD8@yoga/T/#u
>
> To run this script:
> ./test_gecko.sh
> or
> bash test_gecko.sh
>
> Expected output:
>
> Testing Gecko Command
> Staring Firefox Profiler on your default browser...
> Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
> 127.0.0.1 - - [13/Aug/2023 03:07:35] "GET /gecko_profile.json HTTP/1.1" 2=
00 -
> [ perf gecko: Captured and wrote into gecko_profile.json ]
> PASS: "Gecko Command"
> PASS: "The file contains valid JSON format"
> PASS: "test_meta"
> PASS: "test_threads"
> PASS: "test_samples"
> PASS: "test_frametable"
> PASS: "test_stacktable"
> PASS: "test_stringtable"
> PASS: "test_pauseranges"

Hi Anup,

this works for me but when I run as root (using sudo) I need to set
PERF_EXEC_PATH. Running as a user it launches firefox profiler which I
don't think it should.

Thanks,
Ian

> > changes in v2:
> >     - Removed uncessary prepare_perf_data.
> >     - provided patch which is required for testing this patch.
> > ---
> >  tools/perf/tests/shell/test_gecko.sh | 130 +++++++++++++++++++++++++++
> >  1 file changed, 130 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/test_gecko.sh
> >
> > diff --git a/tools/perf/tests/shell/test_gecko.sh b/tools/perf/tests/sh=
ell/test_gecko.sh
> > new file mode 100755
> > index 000000000000..44160eff87fd
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/test_gecko.sh
> > @@ -0,0 +1,130 @@
> > +#!/bin/bash
> > +# perf script gecko test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +err=3D0
> > +
> > +cleanup() {
> > +  rm -rf gecko_profile.json
> > +  trap - exit term int
> > +}
> > +
> > +trap_cleanup() {
> > +  cleanup
> > +  exit 1
> > +}
> > +trap trap_cleanup exit term int
> > +
> > +report() {
> > +    if [ "$1" =3D 0 ]; then
> > +        echo "PASS: \"$2\""
> > +    else
> > +        echo "FAIL: \"$2\" Error message: \"$3\""
> > +        err=3D1
> > +    fi
> > +}
> > +
> > +find_str_or_fail() {
> > +    grep -q "$1" <<< "$2"
> > +    if [ "$?" !=3D 0 ]; then
> > +        report 1 "$3" "Failed to find required string:'${1}'."
> > +    else
> > +        report 0 "$3"
> > +    fi
> > +}
> > +
> > +# To validate the json format, check if python is installed
> > +if [ "$PYTHON" =3D "" ] ; then
> > +     if which python3 > /dev/null ; then
> > +             PYTHON=3Dpython3
> > +     elif which python > /dev/null ; then
> > +             PYTHON=3Dpython
> > +     else
> > +             echo Skipping JSON format check, python not detected plea=
se set environment variable PYTHON.
> > +             PYTHON_NOT_AVAILABLE=3D1
> > +     fi
> > +fi
> > +
> > +# Check execution of perf script gecko command
> > +test_gecko_command() {
> > +    echo "Testing Gecko Command"
> > +    perf script gecko -a sleep 0.5
> > +    # Store the content of the file in the 'out' variable
> > +    out=3D$(< "gecko_profile.json")
> > +    # Get the length of the gecko_profile.json output in 'out'
> > +     length=3D${#out}
> > +     if [ "$length" -gt 0 ]; then
> > +        echo "PASS: \"Gecko Command\""
> > +    else
> > +        echo "FAIL: \"Gecko Command\""
> > +        err=3D1
> > +        exit
> > +    fi
> > +}
> > +
> > +# with the help of python json libary validate the json output
> > +if [ "$PYTHON_NOT_AVAILABLE" !=3D "0" ]; then
> > +     validate_json_format()
> > +     {
> > +             if [ "$out" ] ; then
> > +                     if [ "$PYTHON -c import json; json.load($out)" ];=
 then
> > +                             echo "PASS: \"The file contains valid JSO=
N format\""
> > +                     else
> > +                             echo "FAIL: \"The file does not contain v=
alid JSON format\""
> > +                             err=3D1
> > +                             exit
> > +                     fi
> > +             else
> > +                     echo "FAIL: \"File not found\""
> > +                     err=3D2
> > +                     exit
> > +             fi
> > +     }
> > +fi
> > +
> > +# validate output for the presence of "meta".
> > +test_meta() {
> > +    find_str_or_fail "meta" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "threads".
> > +test_threads() {
> > +     find_str_or_fail "threads" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "samples".
> > +test_samples() {
> > +     find_str_or_fail "samples" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "frameTable".
> > +test_frametable() {
> > +     find_str_or_fail "frameTable" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "stackTable".
> > +test_stacktable() {
> > +     find_str_or_fail "stackTable" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "stringTable"
> > +test_stringtable() {
> > +     find_str_or_fail "stringTable" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "pausedRanges".
> > +test_pauseranges(){
> > +     find_str_or_fail "pausedRanges" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +test_gecko_command
> > +validate_json_format
> > +test_meta
> > +test_threads
> > +test_samples
> > +test_frametable
> > +test_stacktable
> > +test_stringtable
> > +test_pauseranges
> > +cleanup
> > +exit $err
> > --
> > 2.34.1
> >
