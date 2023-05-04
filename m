Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314CC77B73
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 22:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEDWhC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 18:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEDWhB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 18:37:01 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9208F86AD
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 15:37:00 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33164ec77ccso434675ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 15:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683239819; x=1685831819;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u0FXZemdZP1sc4GdQsiRnSDQqgwioJ3/xR0t3+isdx4=;
        b=K3lcgAap8BGRpF2ce0mJQa6SnLs9oKFAc2rQTpNmaZNEwxxNo14peRWA1WDrCKHZFd
         vnIoaMxme68jPugJIlPqKCAoC4eE+U36bSY3o4MGtBtGTfC31sJr/k1iwiSqAd9XaGQh
         cd7pIqjcE2cgzTr8TCUwaBvVhdjmt6S47tL4KCP0VYEcYdEkT+YTcyRoZcPstK2S2LhS
         RdSRnqG6sypVD1Z0581/lidHabYBfx3A1m0DDzLQwWmK/Ovc4j/MxHFHWv6NdDXlLJbc
         4EczlQ4tbrNccqMCIsU+V1v8fUQfOwzwWD7gcUgV9UW/sAkHZVNMOfGcMFbSBh36+00V
         AMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683239819; x=1685831819;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0FXZemdZP1sc4GdQsiRnSDQqgwioJ3/xR0t3+isdx4=;
        b=kI1AMXIG96CoG+rxFM7UlFdayiWvoqHwpUrSYlcxkmoPa0zRBlUZmKZLlNdIt+X+LZ
         s+gmi4I0gA8gqQYp6xejiI+jVkdgnxSdNuqWHkX1U7YV4eRurDzH6YlAv0Vv9AZA2/xr
         Sc+FJHLLthYT9yaMc2Yf359ewajW/e4cIXj4dM6eNrmqfzEI7gNdgB3cdqjB4aYOV7Db
         0/hGK98sTgt38hRD3QAfswiVn6fAhafdRs9oIpWLMviQxAMgZ7MPca/ptuCIXg6v404P
         0ajycqxVWQu53W9D+4LMHJViMrTLttLf7P26KLX/H1n4/M+vjFm7xR+szQwKvcWmuO49
         WZfA==
X-Gm-Message-State: AC+VfDwgzdLvKayKgqh7IXRgUCEwuHUVyDL4QO/MWP3n7SGgYyOqqN7e
        yZ11Jiw6L/ap7O8auBdEtB0DUhmNwb+BTyH+ut7gOMZoCYWhxF9n8rxCiw==
X-Google-Smtp-Source: ACHHUZ72hPg1K9a9AjDt4CfdHBNgN6g2p1ks0bnG2jPWxr1DyIwjVYMJ6IVdl2ZrJ8zxazhYzjw2m6dMr4OdAfr7OH0=
X-Received: by 2002:a92:c247:0:b0:31f:ba43:2ed5 with SMTP id
 k7-20020a92c247000000b0031fba432ed5mr22553ilo.11.1683239819384; Thu, 04 May
 2023 15:36:59 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 4 May 2023 15:36:48 -0700
Message-ID: <CAP-5=fXKi+VAr-_n5tAaJ7Z2fvU7jc5N-CKCjkCAh_01_pzMfA@mail.gmail.com>
Subject: uapi vs kernel headers
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

when the C compiler builds perf the priority of the "-I" flags is left
to right. This means that in the perf build:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.config?h=perf-tools-next#n355
if the build is looking for <linux/types.h> then whereas most projects
would expect that to come from /usr/include/linux/types.h (which
matches the uapi version) perf actually builds with the kernel version
(tools/include/linux/types.h). The kernel version will declare types
like u64 that are __u64 in the uapi code, so reversing the include
order massively breaks the build as u64 and many associated types are
missing.

It almost feels accidental that perf does things this way, and it
feels more obvious if perf were to reverse the include order and deal
with the fall-out in the code (ie perf's linux/types.h would agree
more with what normal projects have). Perhaps perf needs its own
types.h to minimize the fallout. I wondered what more general opinions
on this were? Is this something that should be fixed?

Thanks,
Ian
