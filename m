Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA4EC19F2B
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Aug 2022 23:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbiHCXGV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 19:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiHCXGV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Aug 2022 19:06:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D44E605
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Aug 2022 16:06:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v3so22322838wrp.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Aug 2022 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FoVaTdVnnKpapjEtX/Bhowc8mgQLn0GKcR1f2+ULZaU=;
        b=APJ5cgJSkIzr57+jBa3oRb2z34UPYSKa+b/ufo9X8GlDTJhGmNcxt2UT3D6O8AJhYv
         fe5IJq6HulCvtyg8CEBqaW42GWRihB4xUrv+pfwV6jTLu8ALODD+UvWo7YAkZSg+fEbZ
         MKb3WMm1e2aCQAqP4njGZA2TUVkUt8943tSPUhL7KeXr8V6xyKQ7v6xS1fVIJzCVbyyP
         IZam3HmgWZFxPGIs9jNKGQK4P3cWsMaluPcDVgMpM0471A5r3wBE/ZPd6rzdt1KUGkRE
         JEX+0paS44ZrXrteN3j02Bu63IsjIl/dZ2NV3sjzXinD1mgRelOh7orv8aabwA5dmSpV
         C/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoVaTdVnnKpapjEtX/Bhowc8mgQLn0GKcR1f2+ULZaU=;
        b=zufB8fgRPZ7cMMK1AqMB6vAP9HUhlCEl1Wcmg3/ooa160XcCAb7CL3AgTUle+THycF
         LHzuIDwLrmPqDgpgCBlUoTltnWrXmASVAJlwaZXdr2INw/Brj8f21cXgBkIyzBZ4scmM
         igBrUIVM2KE4lgT4PT20XqDjosfbfGAEocfwMp3fpkFRWkIE43JBLDiKS+VyJMsiNknp
         If6eH2YtIIyjKKrInpUv0xQAuD43/ugfKU1RG8YYc1I4DIHEA0tLBf5RFhLcxpKYScgV
         q/dC8kEkHxByj3/lXQ0ixKmhZ3LvgDMCgGHLbFYGIuA9tGJ5HJskrKDkXWDyTKoV57Uq
         Nz/A==
X-Gm-Message-State: ACgBeo0lc6EomRPAsYiOTM8TYXEvkj3/3ul3lgTYwkm8mSTB9w6RMs2e
        H63SBf/GWZCce0qf2SrHj2zIDkz1p4aU9LPUB5XHmuzTcLvtow==
X-Google-Smtp-Source: AA6agR5G0W57caREqGvPCwmAaQ13rQA8ouaOC7td77160JwzDVuMHiVltMu/kLxYKeaBwDLnuBQMRvDJKIsznsdbFjo=
X-Received: by 2002:a05:6000:1ac9:b0:220:7f40:49e3 with SMTP id
 i9-20020a0560001ac900b002207f4049e3mr1834734wry.40.1659567976810; Wed, 03 Aug
 2022 16:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220803150744.133128-1-leo.yan@linaro.org>
In-Reply-To: <20220803150744.133128-1-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 Aug 2022 16:06:04 -0700
Message-ID: <CAP-5=fWArHKrxu80WKZystkEDFW_jhuU02m89S8tXkqvOChpoA@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Introduce script for data symbol parsing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 3, 2022 at 8:07 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> This commit introduces a shell script for data symbol parsing.
>
> The testing is designed a data structure with 64-byte alignment, and it
> has two fields "data1" and "data2", and other fields are reserved.
>
> Using "perf mem" command, it records and reports memory samples for a
> workload with 1 second duration.  If have no any memory sample for the
> data structure "buf1", it reports failure;  and any memory accessing for
> the data structure is not for "data1" and "data2" filed, it also means
> the wrong data symbol parsing and returns failure.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/shell/test_data_symbol.sh | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_data_symbol.sh
>
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
> new file mode 100755
> index 000000000000..7039dae4e087
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -0,0 +1,94 @@
> +#!/bin/bash
> +# Check perf data symbol parsing
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Leo Yan <leo.yan@linaro.org>, 2022
> +
> +skip_if_no_mem_event() {
> +       perf mem record -e list 2>&1 | egrep -q 'available' && return 0
> +       return 2
> +}
> +
> +skip_if_no_mem_event || exit 2
> +
> +# skip if there's no compiler
> +if ! [ -x "$(command -v cc)" ]; then
> +       echo "skip: no compiler, install gcc"
> +       exit 2
> +fi
> +
> +TEST_PROGRAM_SOURCE=$(mktemp /tmp/__perf_test.program.XXXXX.c)
> +TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +check_result() {
> +       # The memory report format is as below:
> +       #    99.92%  ...  [.] buf1+0x38  ...
> +       result=$(perf mem report -i ${PERF_DATA} --stdio 2>&1 | egrep "buf1" | \
> +               awk '{ for (i = 1; i <= NF; i++) { if ($i ~ /^buf1/) { print $i; break; } } }')
> +
> +       # Testing is failed if has no any sample for "buf1"
> +       [ -z "$result" ] && return 1
> +
> +       while IFS= read -r line; do
> +               # The "data1" and "data2" fields in structure "buf1" have
> +               # offset "0x0" and "0x38", returns failure if detect any
> +               # other offset value.
> +               if [ "$line" != "buf1+0x0" ] && [ "$line" != "buf1+0x38" ]; then
> +                       return 1
> +               fi
> +       done <<< "$result"
> +
> +       return 0
> +}
> +
> +cleanup_files()
> +{
> +       echo "Cleaning up files..."
> +       rm -f ${PERF_DATA}
> +       rm -f ${TEST_PROGRAM_SOURCE}
> +       rm -f ${TEST_PROGRAM}
> +}
> +
> +trap cleanup_files exit term int
> +
> +# compile test program
> +cat << EOF > $TEST_PROGRAM_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +typedef struct _buf {
> +       long data1;
> +       long reserved[6];
> +       long data2;
> +} buf __attribute__((aligned (64)));
> +
> +static buf buf1;
> +
> +int main() {
> +       int i;
> +       for (;;) {
> +               buf1.data1++;
> +               buf1.data2 += buf1.data1;
> +       }
> +       return 0;
> +}
> +EOF
> +
> +echo "Compiling test program..."
> +cc $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> +
> +echo "Recording workload..."
> +perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
> +PERFPID=$!

I wonder here you could do:
TESTPID=$(ps -o pid -h --ppid "$PERFPID")

> +sleep 1
> +
> +kill $PERFPID
> +wait $PERFPID
> +# test program may leave an orphan process running the workload
> +killall $(basename $TEST_PROGRAM)

And then here kill $TESTPID to avoid the killall which worries me a little.

Thanks,
Ian

> +
> +check_result "$variable_name"
> +exit $?
> --
> 2.25.1
>
