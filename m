Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8DAEC875F
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 23:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjIGXul (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 19:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjIGXul (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 19:50:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C901BCB
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 16:50:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-414dff0a8ecso148431cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Sep 2023 16:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694130636; x=1694735436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI7lyyNrHMidQz42MaI4SQgbCij4QziFNgwQ58DIUNU=;
        b=gKN929xihfNNAn3Gz7vOtDvIr/MrCtT8/uroIfTL/7zmpt8v7SfySDl1qTeKHAco98
         DVPDrc051/S+v50KdjoTesvIUHu8jb+Dqi29BXUb8Ma0QM6pH5+naPzvFy/GE+inOhvW
         Rui7KsHwq2CsQMDZ3ghQFFjnOjqHtcpAHhLB/XcKAYn8HeBMegx4AazPfqUNzvVNkjqH
         7eW65mt4BhlvJv4HwajvioLbsu7Si1/WyK74LtH0qQrOA6sdgdxvMoxS2sy4zoEWUm45
         NTyf2wsAguynohQ9/96hqfaITaPVFv04L7+1xK+RreQ4HigIlUUnkh4jbBZJnwHcEjxU
         zfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694130636; x=1694735436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lI7lyyNrHMidQz42MaI4SQgbCij4QziFNgwQ58DIUNU=;
        b=IbQjcGkDHmFA3CqDhxq1mGX7rtt52XQKKYDAIO7i1vMWaqmiycfJyasXhud1Zimh0u
         59QhEOISb3DKVaOR9P7OvbrjwnKFA6vRKt32s+xcWYhku3g+BR16DsZqYqMmH7DEkbaz
         ck7py0QGIWZXEbuOE/XUAbN5qjJ3ZCvu42kbW3Rim77P2e1wpszJds6oPzhqKRnvxx7P
         Ni6ESlfCZ1NsTGEYXK/coU27MlXWb7Qkjkuabks3Bp4UxCBXymRnPyrNXoT6RnIWYB8k
         0TCOA6xEwoWPWoKsgO5EgPgjhd/johZum2OzAligyXMoTHQC7rEPOkI9Hq34m0ukz/Vy
         noRQ==
X-Gm-Message-State: AOJu0YzVak5HLi37ZmPiSvmftGBWD51K67z0s8atsR1WLuJ+bFw0UuPp
        I0/mvkYlv6njOakJ9LYK64JlRRRLHKvv3gpfcoO36Q==
X-Google-Smtp-Source: AGHT+IFIrqZFQD5DkBaHyX2450phYhAeUfIeuOhvTy5PjEIztUJEcgP8OQU4IbkYjWqd9kpOx3DBHv79ZeEZsdcTcVM=
X-Received: by 2002:a05:622a:1893:b0:40f:c60d:1c79 with SMTP id
 v19-20020a05622a189300b0040fc60d1c79mr113357qtc.28.1694130636327; Thu, 07 Sep
 2023 16:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230907171540.36736-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230907171540.36736-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Sep 2023 16:50:23 -0700
Message-ID: <CAP-5=fXVSh0q6cQwQdGR-jxTTec_s43geZ02gEekrFbSvCKnZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix for shellcheck issues with version "0.6"
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        root <root@ltcden13-lp4.aus.stglabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 7, 2023 at 10:17=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> From: root <root@ltcden13-lp4.aus.stglabs.ibm.com>
>
> shellcheck was run on perf tool shell scripts s a pre-requisite
> to include a build option for shellcheck discussed here:
> https://www.spinics.net/lists/linux-perf-users/msg25553.html
>
> And fixes were added for the coding/formatting issues in
> two patchsets:
> https://lore.kernel.org/linux-perf-users/20230613164145.50488-1-atrajeev@=
linux.vnet.ibm.com/
> https://lore.kernel.org/linux-perf-users/20230709182800.53002-1-atrajeev@=
linux.vnet.ibm.com/
>
> Three additional issues are observed with shellcheck "0.6" and
> this patchset covers those. With this patchset,
>
> # for F in $(find tests/shell/ -perm -o=3Dx -name '*.sh'); do shellcheck =
-S warning $F; done
> # echo $?
> 0
>
> Athira Rajeev (3):
>   tests/shell: Fix shellcheck SC1090 to handle the location of sourced
>     files
>   tests/shell: Fix shellcheck issues in tests/shell/stat+shadow_stat.sh
>     tetscase
>   tests/shell: Fix shellcheck warnings for SC2153 in multiple scripts

Series:
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/tests/shell/coresight/asm_pure_loop.sh            | 4 ++++
>  tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh     | 4 ++++
>  tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh | 4 ++++
>  tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh  | 4 ++++
>  tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh    | 4 ++++
>  tools/perf/tests/shell/probe_vfs_getname.sh                  | 2 ++
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh        | 2 ++
>  tools/perf/tests/shell/record+script_probe_vfs_getname.sh    | 2 ++
>  tools/perf/tests/shell/record.sh                             | 1 +
>  tools/perf/tests/shell/stat+csv_output.sh                    | 1 +
>  tools/perf/tests/shell/stat+csv_summary.sh                   | 4 ++--
>  tools/perf/tests/shell/stat+shadow_stat.sh                   | 4 ++--
>  tools/perf/tests/shell/stat+std_output.sh                    | 1 +
>  tools/perf/tests/shell/test_intel_pt.sh                      | 1 +
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh            | 1 +
>  15 files changed, 35 insertions(+), 4 deletions(-)
>
> --
> 2.31.1
>
