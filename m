Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9E9C001B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 17:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjGSRq7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGSRq6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 13:46:58 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797EF1BFC
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 10:46:56 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-403f21d3c2dso19841cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689788815; x=1692380815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYibOhQ/sb7T0GVqrGS+JLuttKSP7dbSD4obWi2tT7o=;
        b=DqvencPSSPr2JJyXLrEqYm/67F/ouEBYqSRKwLqwY8JZEiYWqnkruw7t/OvRhlKXNk
         M2Bd9c1yBVnqK5HXtFfco1qntVSoG1FtvLv0FmqdjWlX0gTCagYd/Ul79qHNNApcuIzX
         96nkDN5vWJV+fB29hYkGSq5bVv2jnEpEieKbC/u4zZWFtO51eZp3cQSjnKDv1t4t64Eu
         +pa7/lKiGXBTGfwqHGZY0JzKsZzON4gbyUHvFMzx71RjexrpjhJZm8EtJ2zerAd8oH48
         0XK4V7OUTUYwsD4Yo2v1Mc5zjH3LVUsk3MJPmzgytKGh5Hd2D+Xbo9e9TvzpND/70vDE
         g2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788815; x=1692380815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYibOhQ/sb7T0GVqrGS+JLuttKSP7dbSD4obWi2tT7o=;
        b=F7yfK8ccjknsUNUssPzSqs/k8vcwKCMmBEaAZBwc1oK94i4l9cX/OYQO4MZE0shtkh
         ec0gM5TqXbZU7eSyQoiVhAn2yTV4oruT3d8nl4hVuURQmTFEXF8yJHoSSW9v+9i3+gI5
         pV/RG4rrKOqiKGu8ITj+4LLRO7NaNvs2+DaXHWkZOK8BQc+6g2FrKcwS1AXi3FLvZ+T4
         yPGFZIM+2QOjIRMa1nZ7HW1pViK5LTu5DShhocM1yoofJXb4I2wKz4chd2FKv+4QL4zH
         pNk0eV1zwy1bz2e8Ee5pKd32fEz6T0pKscJOz3dhuKxbYoTQiPQwo9YmEAV6N0ijWtza
         1jWQ==
X-Gm-Message-State: ABy/qLbkBkxu0bv3U35H+tt7heduuNvlWvHsL5zhwMVLmpTIApZLuas6
        4rEZ4A5J6TGCkVFIdmnjgDC8UjtNqKKVTLmNb4t9rg==
X-Google-Smtp-Source: APBJJlGoKIi4FBiyCYQOIQ+Vf+tb88VPR3HCoCjhXLwpWBaCgudXFTXJoz84j+yaSdbrPI22S1OaeJnRO0yzoEOZGJ8=
X-Received: by 2002:a05:622a:181f:b0:3ef:3361:75d5 with SMTP id
 t31-20020a05622a181f00b003ef336175d5mr3548qtc.11.1689788815460; Wed, 19 Jul
 2023 10:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com> <1fbdbb26-4fce-ea25-a96a-99982b3f1603@linux.ibm.com>
In-Reply-To: <1fbdbb26-4fce-ea25-a96a-99982b3f1603@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 10:46:40 -0700
Message-ID: <CAP-5=fWZy-y9kiuAFQsaNeRYn8PJofFR5DHj5qA53FhB3+UrfQ@mail.gmail.com>
Subject: Re: [PATCH V2 00/26] tools/perf: Fix shellcheck coding/formatting
 issues of perf tool shell scripts
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 18, 2023 at 11:17=E2=80=AFPM kajoljain <kjain@linux.ibm.com> wr=
ote:
>
> Hi,
>
> Looking for review comments on this patchset.
>
> Thanks,
> Kajol Jain
>
>
> On 7/9/23 23:57, Athira Rajeev wrote:
> > Patchset covers a set of fixes for coding/formatting issues observed wh=
ile
> > running shellcheck tool on the perf shell scripts.
> >
> > This cleanup is a pre-requisite to include a build option for shellchec=
k
> > discussed here: https://www.spinics.net/lists/linux-perf-users/msg25553=
.html
> > First set of patches were posted here:
> > https://lore.kernel.org/linux-perf-users/53B7D823-1570-4289-A632-2205EE=
2B522C@linux.vnet.ibm.com/T/#t
> >
> > This patchset covers remaining set of shell scripts which needs
> > fix. Patch 1 is resubmission of patch 6 from the initial series.
> > Patch 15, 16 and 22 touches code from tools/perf/trace/beauty.
> > Other patches are fixes for scripts from tools/perf/tests.
> >
> > The shellcheck is run for severity level for errors and warnings.
> > Command used:
> >
> > # for F in $(find tests/shell/ -perm -o=3Dx -name '*.sh'); do shellchec=
k -S warning $F; done
> > # echo $?
> > 0
> >

I don't see anything objectionable in the changes so for the series:
Acked-by: Ian Rogers <irogers@google.com>

Some thoughts:
 - Adding "#!/bin/bash" to scripts in tools/perf/tests/lib - I think
we didn't do this to avoid these being included as tests. There are
now extra checks when finding shell tests, so I can imagine doing this
isn't a regression but just a heads up.
 - I think James' comment was addressed:
https://lore.kernel.org/linux-perf-users/334989bf-5501-494c-f246-81878fd2fe=
d8@arm.com/
 - Why aren't these changes being mailed to LKML? The wider community
on LKML have thoughts on shell scripts, plus it makes the changes miss
my mail filters.
 - Can we automate this testing into the build? For example, following
a similar kernel build pattern we run a python test and make the log
output a requirement here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/Build?h=3Dperf-tools-next#n30
   I think we can translate:
for F in $(find tests/shell/ -perm -o=3Dx -name '*.sh'); do shellcheck
-S warning $F; done
   into a rule in make for log files that are then a dependency on the
perf binary. We can then parallel shellcheck during the build and
avoid regressions. We probably need a CONFIG_SHELLCHECK feature check
in the build to avoid not having shellcheck breaking the build.

Thanks,
Ian

> > Changelog:
> > v1 -> v2:
> >   - Rebased on top of perf-tools-next from:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=
=3Dperf-tools-next
> >
> >   - Fixed shellcheck errors and warnings reported for newly
> >     added changes from perf-tools-next branch
> >
> >   - Addressed review comment from James clark for patch
> >     number 13 from V1. The changes in patch 13 were not necessary
> >     since the file "tests/shell/lib/coresight.sh" is sourced from
> >     other test files.
> >
> > Akanksha J N (1):
> >   tools/perf/tests: Fix shellcheck warnings for
> >     trace+probe_vfs_getname.sh
> >
> > Athira Rajeev (14):
> >   tools/perf/tests: fix test_arm_spe_fork.sh signal case issues
> >   tools/perf/tests: Fix unused variable references in
> >     stat+csv_summary.sh testcase
> >   tools/perf/tests: fix shellcheck warning for
> >     test_perf_data_converter_json.sh testcase
> >   tools/perf/tests: Fix shellcheck issue for stat_bpf_counters.sh
> >     testcase
> >   tools/perf/tests: Fix shellcheck issues in
> >     tests/shell/stat+shadow_stat.sh tetscase
> >   tools/perf/tests: Fix shellcheck warnings for
> >     thread_loop_check_tid_10.sh
> >   tools/perf/tests: Fix shellcheck warnings for unroll_loop_thread_10.s=
h
> >   tools/perf/tests: Fix shellcheck warnings for lib/probe_vfs_getname.s=
h
> >   tools/perf/tests: Fix the shellcheck warnings in lib/waiting.sh
> >   tools/perf/trace: Fix x86_arch_prctl.sh to address shellcheck warning=
s
> >   tools/perf/arch/x86: Fix syscalltbl.sh to address shellcheck warnings
> >   tools/perf/tests/shell: Fix the shellcheck warnings in
> >     record+zstd_comp_decomp.sh
> >   tools/perf/tests/shell: Fix shellcheck warning for stat+std_output.sh
> >     testcase
> >   tools/perf/tests: Fix shellcheck warning for stat+std_output.sh
> >     testcase
> >
> > Kajol Jain (11):
> >   tools/perf/tests: Fix shellcheck warning for probe_vfs_getname.sh
> >     testcase
> >   tools/perf/tests: Fix shellcheck warning for record_offcpu.sh testcas=
e
> >   tools/perf/tests: Fix shellcheck issue for lock_contention.sh testcas=
e
> >   tools/perf/tests: Fix shellcheck issue for stat_bpf_counters_cgrp.sh
> >     testcase
> >   tools/perf/tests: Fix shellcheck warning for asm_pure_loop.sh shell
> >     script
> >   tools/perf/tests: Fix shellcheck warning for memcpy_thread_16k_10.sh
> >     shell script
> >   tools/perf/tests: Fix shellcheck warning for probe.sh shell script
> >   tools/perf/trace: Fix shellcheck issue for arch_errno_names.sh script
> >   tools/perf: Fix shellcheck issue for check-headers.sh script
> >   tools/shell/coresight: Fix shellcheck warning for
> >     thread_loop_check_tid_2.sh shell script
> >   tools/perf/tests/shell/lib: Fix shellcheck warning for stat_output.sh
> >     shell script
> >
> >  .../arch/x86/entry/syscalls/syscalltbl.sh     |  2 +-
> >  tools/perf/check-headers.sh                   |  6 ++--
> >  .../tests/shell/coresight/asm_pure_loop.sh    |  2 +-
> >  .../shell/coresight/memcpy_thread_16k_10.sh   |  2 +-
> >  .../coresight/thread_loop_check_tid_10.sh     |  2 +-
> >  .../coresight/thread_loop_check_tid_2.sh      |  2 +-
> >  .../shell/coresight/unroll_loop_thread_10.sh  |  2 +-
> >  tools/perf/tests/shell/lib/probe.sh           |  1 +
> >  .../perf/tests/shell/lib/probe_vfs_getname.sh |  5 ++--
> >  tools/perf/tests/shell/lib/stat_output.sh     |  1 +
> >  tools/perf/tests/shell/lib/waiting.sh         |  1 +
> >  tools/perf/tests/shell/lock_contention.sh     | 12 ++++----
> >  tools/perf/tests/shell/probe_vfs_getname.sh   |  4 +--
> >  .../tests/shell/record+zstd_comp_decomp.sh    | 14 +++++-----
> >  tools/perf/tests/shell/record_offcpu.sh       |  6 ++--
> >  tools/perf/tests/shell/stat+csv_output.sh     |  2 +-
> >  tools/perf/tests/shell/stat+csv_summary.sh    |  4 +--
> >  tools/perf/tests/shell/stat+shadow_stat.sh    |  4 +--
> >  tools/perf/tests/shell/stat+std_output.sh     |  3 +-
> >  tools/perf/tests/shell/stat_bpf_counters.sh   |  4 +--
> >  .../tests/shell/stat_bpf_counters_cgrp.sh     | 28 ++++++++-----------
> >  tools/perf/tests/shell/test_arm_spe_fork.sh   |  2 +-
> >  .../shell/test_perf_data_converter_json.sh    |  2 +-
> >  .../tests/shell/trace+probe_vfs_getname.sh    |  6 ++--
> >  tools/perf/trace/beauty/arch_errno_names.sh   | 15 ++++------
> >  tools/perf/trace/beauty/x86_arch_prctl.sh     |  6 ++--
> >  26 files changed, 67 insertions(+), 71 deletions(-)
> >
