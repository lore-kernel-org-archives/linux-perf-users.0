Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E253C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 16:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbiDLQX0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbiDLQXZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 12:23:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB5F5D19F
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 09:21:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t1so10768628wra.4
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaklH84rCrU4lpiXP8yvmTmjobzVXsRZJg68fB8ePQQ=;
        b=i3Q1ntS34MHnFnrjwc0Pbeet7hWR1qSDsWaKlXU5MtWO9FTbHXUXWY84f0wOAKyn/a
         qElYCluYnJQttU4yE1fwZ8ELRgwX8oH/ee23KVlJ0QRQFz1LjbvmUTd2YWD2ppbJLn9R
         7ftv3OxWcznJyZGMv5eJ7KLHnvK166uBHoiodxemrDgxQbzCXLEtpvXvZWqKaEFz4Eyp
         KxJLn5TTsK84FNSYFp1k7Ze/BhvPKVgicjKa5c8N18uqyoiUT0APkzgrEmOdQWk3DvPp
         eN6xdNexFUiMIrrw0vKuQ/4n7Dva1rZITGZA+ECi7joUeqyCahCx1w88UZxx4p4FIlfA
         uKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaklH84rCrU4lpiXP8yvmTmjobzVXsRZJg68fB8ePQQ=;
        b=gNegy/Qqp3NwJa/Zm5yqcjRv56TPESbofxD2C3+Te5msVp4vFlhJcqHdDi7GrjHH0S
         zUtW6bKY6TgrmJ0jEFA3eFvLhQB+cuKb9/77tB0Rvn/ZF532BfOrvRtCycy/YJJdkBGM
         ezo5XQLgDvo11YBIAyiI4CmIdhae06oEtRcLZDtnRFB2lQp+VbgDzFNMNLV1JAvZ1IKK
         RpJ6h1eH+vIOAVnq4DbkMuF3f6ahmMtgtrFr7Pmd6he48XE9eQTVC73J5CWEYlB3AEPV
         i3dTb458OQsWGBqWNVmVBMo73QQp31VQEh89hcmrBcljMrAbfqccrThEHDT5NUYXi7oA
         X+Sw==
X-Gm-Message-State: AOAM531K/5ZZcK0/1AKuJn8vyVorFXXhX8KS0ihLTQmoSel7psUPPCuM
        o4o+TFZ6+GXaAhNFvgfZNkmAnrXqJliwXeoyHZDNBw==
X-Google-Smtp-Source: ABdhPJw3cfndLH3ZUhpSzzjuo9DBHjuzswehgTFoF0He2DYxPgFCa/mATA8WHqbj7bEk2KuOvbIrutr8YUle9ZXKziw=
X-Received: by 2002:adf:8123:0:b0:206:1759:f164 with SMTP id
 32-20020adf8123000000b002061759f164mr30353021wrm.654.1649780463588; Tue, 12
 Apr 2022 09:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220412154817.2728324-1-irogers@google.com>
In-Reply-To: <20220412154817.2728324-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Apr 2022 09:20:51 -0700
Message-ID: <CAP-5=fX8YatuJZG6dYftwWy0NnkRyJWqtyw7D0WAU9xDjh+b0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Tidy up symbol end fixup
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Apr 12, 2022 at 8:48 AM Ian Rogers <irogers@google.com> wrote:
>
> Fixing up more symbol ends as introduced in:
> https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
> caused perf annotate to run into memory limits - every symbol holds
> all the disassembled code in the annotation, and so making symbols
> ends further away dramatically increased memory usage (40MB to
>  >1GB). Modify the symbol end logic so that special kernel cases aren't
> applied in the common case.
>
> v2. Drops a merged patch. Fixes a build issue with libbfd enabled.
>
> Ian Rogers (4):
>   perf symbols: Always do architecture specific fixups
>   perf symbols: Add is_kernel argument to fixup end
>   perf symbol: By default only fix zero length symbols
>   perf symbols: More specific architecture end fixing
>
>  tools/perf/arch/arm64/util/machine.c   | 14 +++++++++-----
>  tools/perf/arch/powerpc/util/machine.c | 10 +++++++---
>  tools/perf/arch/s390/util/machine.c    | 12 ++++++++----
>  tools/perf/util/symbol-elf.c           |  2 +-
>  tools/perf/util/symbol.c               | 16 +++++++++-------
>  tools/perf/util/symbol.h               |  4 ++--
>  6 files changed, 36 insertions(+), 22 deletions(-)

Missed the:

Signed-off-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> --
> 2.35.1.1178.g4f1659d476-goog
>
