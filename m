Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0001C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 21:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiEQV7Z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 17:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiEQV7X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 17:59:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398350E2D
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 14:59:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7dbceab08so4288267b3.10
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 14:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=87brBgMZyYr2KZM5gqgOZ1FKoktrRC3RtBsl96TyHFk=;
        b=OWZ1xxTAzR+DWRYf1pCTH/HydXSZArPwWEXY2qmEPGNHV4KEvfWQONU/80zcaaMoQT
         UxIQd5HwISoRC1LniAQjieSp5FjKdd321vE7mx1xHK6ameQFtpXLHzcENSi6qXlvN+zI
         SLtUWnjDn5hPEiQ+jNsY2Baj5rsbvSq1Z4BF4AY8H6pyHdBTJOF6wiimFd4x3T5QFBm9
         wcVinFed7dxUOKfUcLy/8iy+/adRfOdwTprKzMntkMJA67QbD9olRsPqwnxYhVqGtkez
         HxixWrlGWMqQsvO3N9pMov6EcTUmbxfa/YbDearvZO9bwRXgHu2Iow6t6c9C7/uwNpFT
         XhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=87brBgMZyYr2KZM5gqgOZ1FKoktrRC3RtBsl96TyHFk=;
        b=fCetC19+/VFTHibA4x6RGSjhRpqmMR8jMMQrv7blrmwFd8QOOVdp/ihri/0PiQQRXY
         kLzIs2e0c1wVcETQUMLb3ceSU0wLidGgyG0hplxTTUr4wFI8EnuD0fubrTSce8KVLADr
         R79uWhWkKzlF8m2cJp2jKuSdzrBatv9s1lAJy8JF3bfP0hduIXvsIJ+BwHqH5S8Drdmc
         aOZnZVzsA/h8d4jRmyaCJNR4CETQqoCroWXgNFxwaY8U00wcuhXqjZWo+X5ZhGEBpNOJ
         BGu10yA8fUdl8sgdCjoC23vhBQ3ZqPWSoKGTzSuKMJ86xRkWIl83yf1bL8jJ9aoXP5Z/
         43MA==
X-Gm-Message-State: AOAM532sG5EOBfpyZeKOLK0PcZqbQww5BYcpidcaTaO5vq+rWx7ElLyB
        itWJr+nKIw2cyqgSBUxKSybsIVAFifVl
X-Google-Smtp-Source: ABdhPJyxEk2HSbePnkp7Cg+Zed5QyldoSY6BiLKeR0+bUCh9h22z7R6MWypZH/tO2eEHsxTwuCUlguFzn2Su
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:4091:0:b0:64d:6dd1:db7d with SMTP id
 n139-20020a254091000000b0064d6dd1db7dmr16261350yba.191.1652824761121; Tue, 17
 May 2022 14:59:21 -0700 (PDT)
Date:   Tue, 17 May 2022 14:59:14 -0700
Message-Id: <20220517215917.692906-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 0/3] JSON output for perf stat
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Parsing the CSV or text output of perf stat can be problematic when
new output is added (columns in CSV format). JSON names values and
simplifies the job of parsing. Add a JSON output option to perf-stat
then add unit test that parses and validates the output.

This is a resend of two v2 patches:
https://lore.kernel.org/lkml/20210813220754.2104922-1-cjense@google.com/
https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/
with a few formatting changes and improvements to the linter.

The CSV test/linter is also added to ensure that CSV output doesn't regress:
https://lore.kernel.org/lkml/20210813192108.2087512-1-cjense@google.com/

v3. There is some tidy up of CSV code including a potential memory
    over run in the os.nfields set up caught by sanitizers. To
    facilitate this an AGGR_MAX value is added. v3 also adds the CSV
    testing.

v2. Fixes the system wide no aggregation test to not run if the
    paranoia is wrong. It also makes the counter-value check handle
    the "<not counted>" and "<not supported>" cases.

Claire Jensen (3):
  perf test: Add checking for perf stat CSV output.
  perf stat: Add JSON output option
  perf test: Json format checking

 tools/perf/Documentation/perf-stat.txt        |  21 +
 tools/perf/builtin-stat.c                     |   6 +
 .../tests/shell/lib/perf_csv_output_lint.py   |  48 +++
 .../tests/shell/lib/perf_json_output_lint.py  |  91 +++++
 tools/perf/tests/shell/stat+csv_output.sh     | 147 +++++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
 tools/perf/util/stat-display.c                | 384 +++++++++++++-----
 tools/perf/util/stat.c                        |   1 +
 tools/perf/util/stat.h                        |   2 +
 9 files changed, 741 insertions(+), 106 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+csv_output.sh
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

-- 
2.36.0.550.gb090851708-goog

