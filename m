Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2F6C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Jun 2022 10:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbiF1KzK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbiF1KzK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Jun 2022 06:55:10 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D63431902
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 03:55:09 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-317710edb9dso113220877b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bx+nn3bN9pkcTAPrSO8SXuVhJpjdYzH6Wim9ZDKKiAY=;
        b=SgjVnFGomlUOotY/gew1wOdWrD475NDkUK1mb2rUT0EFvD8XhhNOIIykcSWEEL6YxM
         jJinJuo/gJhCW+dtmxOqBXMPReGrI3zwNRZ+WxliSN7Qpbi3jNvVW6ZwIMhSLVwOZY6t
         ByNEzLBuoiVfE3KB4iqfCywFWucy1UDCjq2jhO+UJZFD+1vUpogEWe/tfIk+C9HEG//B
         dURvYRrCbZJjIctxYxYIMKq5CBmVom2p/kc915BHwbw1lCKYOEFZKDEsHmdfX9irHD7j
         F1llsAgUDsNOJIVYDHW7Qal7uXAZjI8v4vAgdaHAB1+k39/T1eUyg4VTTYoCAmCLSqV5
         va5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bx+nn3bN9pkcTAPrSO8SXuVhJpjdYzH6Wim9ZDKKiAY=;
        b=oOjanR0I8NaYMPQNNdsWaJHgHiYfWtzHmWBxvW9vZdTBuVpfLvOQiPUet6ZMZiUaiK
         zRPmkodr8DIrYcRmn625Qy2YolTlrtjm4Q64mUQJxT5GJKP/OsO2Om2BMDkwkoTBhNWk
         ukAradI9syiRF2R7fcx9QRK35EW++vLMQaFMjfRcmJvYScK0p8t80VZckqMnEkpSv2K6
         WU0MX0az/+8I0Ij8BXZJjrLdsAEJeTQbG1B8GDyQMRgnCvXJYp/AzZ01uc9QMCMiFc/C
         WXQ0VluB2zlB2c7vhe0aXYd4AmC8yL5xSfdLZsGdP5NpqPFDm7DzAWn+0/Af4WXPmcMO
         1OHA==
X-Gm-Message-State: AJIora/+s9jLfHUUmIlyyheaQ0AbUqJqztCpu7frxkBIPeDYVLfC/3oE
        HTwC3NMElkPx8GJmLuYPM/S/l1RjsGjOIMiRvc8wOw==
X-Google-Smtp-Source: AGRyM1vz2ZG/AOoQ4vBN8VmbUXJLQvwRbaY4tA5etmPkx+EhZBLBb/NNp85KWwxKWmdK+O/VbOcVkqR614Ti4viQrKI=
X-Received: by 2002:a81:1a42:0:b0:318:3915:57d7 with SMTP id
 a63-20020a811a42000000b00318391557d7mr19561304ywa.327.1656413708510; Tue, 28
 Jun 2022 03:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-14-elver@google.com>
In-Reply-To: <20220628095833.2579903-14-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jun 2022 12:54:32 +0200
Message-ID: <CANpmjNPapZ9p3dSB1RC-cBoJ588XkRxJRzbhxx4THLZ9aWsx=A@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf/hw_breakpoint: Optimize toggle_bp_slot()
 for CPU-independent task targets
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
[...]
> +       /*
> +        * Update the pinned task slots, in per-CPU bp_cpuinfo and in the global
> +        * histogram. We need to take care of 5 cases:

This is a typo: "5 cases" -> "4 cases".
