Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01DEC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 07:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352641AbhKZHZY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:25:24 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:36489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352901AbhKZHXX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 02:23:23 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MHndY-1mnoMh405W-00Ew3W; Fri, 26 Nov 2021 08:20:09 +0100
Received: by mail-wr1-f50.google.com with SMTP id r8so16554664wra.7;
        Thu, 25 Nov 2021 23:20:09 -0800 (PST)
X-Gm-Message-State: AOAM530YTVhtZdjNiO0FYWaKcWvEin9mBQ7YWMJj3MIdquUI2PjjPql/
        9W208ywtIs79wl14oImlsaTGoMsNeIfnlUuSOb0=
X-Google-Smtp-Source: ABdhPJzZwWlD2B3L8ZKxMP+6Iw52iLVzMbJFKx/TFmY1gNnt9IEggU9uLBROHoo9pcxPbq1sCUgEFqfcp4SmYx9h+ko=
X-Received: by 2002:adf:d091:: with SMTP id y17mr12829566wrh.418.1637911209569;
 Thu, 25 Nov 2021 23:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Nov 2021 08:19:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1WPgrkw5N9acSZ1bRPjBUS0bXSjSBRSW2pYA-m-mc=Qw@mail.gmail.com>
Message-ID: <CAK8P3a1WPgrkw5N9acSZ1bRPjBUS0bXSjSBRSW2pYA-m-mc=Qw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] perf bench futex: Add support for 32-bit systems
 with 64-bit time_t
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alistair Francis <alistair23@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hYmhYfv1vXnsBy8eWwNIgqRIfL6Tno94tKUg3ZEupl2gRlzxgmi
 D/Q5tOf5zg+x8+HJ4lt2u89AnavIrhlZlAEEtTRii1xJkBUj1px1ksF1XU+Lfj+yxqVx8GM
 Atc7RIGeNkpmaKmdN06EVFF6q8QqzFM46UoyN/YUcVPYzGXa9/I3QzycelUOpPtY4mSoh63
 NsTq4zWN628DGMI8P1U+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JXIaV9G0zME=:Fgf+SZKwynQ+mY9X0XzFM7
 Q4QniIx2EhGIubc0USdhUdwwaA2WQ9ojUlBKdGMYmx4PTNPawXv6xDcjlSQSGU64zztite3WH
 6+NQLexK9uPnYM+1IoGnu+jnFSXE6A7OFTNPnQCTUuIXAMIgyOjdMfmfFt7zIwvYDsyU8vFIX
 3q/7BsN1cupn8RUsFUbkmWknEc013TaliNcXe+6rtWYiXqz6LXaDMhg5W3LjqZQcR9fQ8fKpq
 vHBl8Pp74RyanlAaiZP1ynwX1yeYxP/iyJLaa66Qie37fQkOzW89TgqxEYA4UIExH7368cL8D
 ddtS6WzUWrqdtDtaOK5okxN076DCfsRtxc4229DyzOXkMU06Phti0bX0dwVWf4uEsg43/d2nE
 s5QjcYUfL4aUTuCP/E022jXGIqkEtjrNlmvWjRA4WFPSvcBwV2BwGuqV7VPBm82zDr6W7NdXo
 iBSu3RbugNHGACty01hKUFtzaSTrUTO23o/Zq3NI46mrLUmyIZYc9eJMT73uCnSpeHKz92XWu
 LV1H1r64LVbrVd47MlVGJF2cPX+o/DFJ5mDFVAgrUQV/tw4OkwH6xYOcyWTPESIc0yUQqloyM
 SpTci7uC93WMr4J+LgETlbOUhI4VdVY5iOtdvmBGe2CCD5uMZbdiYA/OUEHDgeFWqZ96fMvGm
 mTNf7yHtqYUhpdjTj//0wuabNlaX8t3TggMTUCmVf32WY1qvh8IV8xuPt4FxA9Pa+O11BivYJ
 V/5iUS+4TIPoHqiHEedaaFGeZqRBKvRc/LIS9OcBhWcdERNde+kDrJw5EBTlsoetKYlDHLR03
 Xil9VaYDBxMchwBj/JcfzE+G4zeGz+h1G4O78m9z7plWH91A2Q=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 26, 2021 at 7:00 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> time_t and as such don't have the SYS_futex syscall. This patch will
> allow us to use the SYS_futex_time64 syscall on those platforms.
>
> This also converts the futex calls to be y2038 safe (when built for a
> 5.1+ kernel).
>
> This is a revert of commit ba4026b09d83acf56c040b6933eac7916c27e728
> "Revert "perf bench futex: Add support for 32-bit systems with 64-bit time_t"".
>
> The original commit was reverted as including linux/time_types.h would
> fail to compile on older kernels. This commit doesn't include
> linux/time_types.h to avoid this issue.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>


Reviewed-by: Arnd Bergmann <arnd@arndb.de>
