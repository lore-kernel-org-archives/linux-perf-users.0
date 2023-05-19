Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0151FC7EE26
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 May 2023 17:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjESR5h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 May 2023 13:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjESR5h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 May 2023 13:57:37 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E333E40
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 10:57:22 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-335d6260e9bso12165ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684519041; x=1687111041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feLe7uBjxvtsjgM0Ag0LKjB+8s6DSGjCmg+1nAQWaOY=;
        b=UWEPqp9UptvnAfk22PADLuu0PozS6oMEPCEL9noGcIkKkyV1CzxlQgYoH8/DQRPm/Q
         Z4weKJQG99AKhii1BS65iIDij376x30zpkbo1+2B5wJqGL1tw5w+pqux9SeKNbCaMDBk
         UjRoY/1XZrF5KZlKJjIL+FDDYcPvPdULEXL+S7ZbRKF8ydoiNYtl0Oby0u6VB5CNBEfc
         F5iUdVPL7GWYFQhimNG//TYfx//gZkyM2Bn02X7uEyTX9Tu/x+OctOxh9+7a3Jb7vKot
         TL9hmU5a75pJHWizYF8Crxiui1Xb1209MH1lH0nxU1nEAZQXuXUvVqcvZ5/VQoXv+ydS
         E9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684519041; x=1687111041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feLe7uBjxvtsjgM0Ag0LKjB+8s6DSGjCmg+1nAQWaOY=;
        b=NrnzFKiCSYDiR6PQauJN0SaAYF1uYoD0/LGD7eRM1C/O8SnEItq1klhCNRhs3ZPqww
         Pkj9mA21QIgX+U9voqXUUe5QZJVFBKN9yidIfYMrv0F3Ji7agEDLFnonMTZV/n6r0UP1
         zTblYpjiYsM9OuOmrRHnMNHGRx7AOaxnHExTm6ocy7wBQvm1t7tyeiYu/u7NRoFxrqLc
         Dg1dJy/VWDzIwrNeza7xMabrQpgHSfPrkawMQJ3nXVbNLjEc8cJ8FgMb5mQxHaC4Jp8H
         GxlmRSRn9hKA/p461Si0pYlFwZYCuo05V25gsdvLJU6cYic0V0IcpC7V+ETpm/ZusB/W
         8bag==
X-Gm-Message-State: AC+VfDxu0alM0JsOFk9SREbf0l1Izw0TP47banhtSzSUNl9rK5sE4W0K
        8dLQYlJLq/yVRzG26sQChFmZxW26U+oDe8Mf0wRQ757MlDXpm7ea5mT7fg==
X-Google-Smtp-Source: ACHHUZ4Iy85v0Mq+Vc9LoHKjemBTC/WY96pgqW2Xf/leH4fSI4vSRcthQhPYCg9ugcXi9yBkN/TUxW83LDAN9jOmuHQ=
X-Received: by 2002:a05:6e02:1a0a:b0:32a:f2a9:d1b7 with SMTP id
 s10-20020a056e021a0a00b0032af2a9d1b7mr246411ild.10.1684519041141; Fri, 19 May
 2023 10:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAGA5_H6Ld9U0eTatJeExSGEynf41mvfcPZ34rtdO7rAVNuoXYQ@mail.gmail.com>
In-Reply-To: <CAGA5_H6Ld9U0eTatJeExSGEynf41mvfcPZ34rtdO7rAVNuoXYQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 19 May 2023 10:57:09 -0700
Message-ID: <CAP-5=fWV2+auUQHQ5cvn2948M=0ThtrHftgGMM44ceCZyHiQeQ@mail.gmail.com>
Subject: Re: DSO_BINARY_TYPE__SYSTEM_PATH_DSO
To:     Rajasekhar Pulluru <pullururajasekhar@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 19, 2023 at 10:49=E2=80=AFAM Rajasekhar Pulluru
<pullururajasekhar@gmail.com> wrote:
>
> Hi Team,
> Could someone help me shed some light on this macro
> DSO_BINARY_TYPE__SYSTEM_PATH_DSO ?
>
> Case-1: I am trying to run perf top -p `pidof <app>` on ubuntu host
> (based on ubuntu:jammy, outside the container) where the <app> runs
> inside a container that's based on ubuntu bionic, and I don't see any
> of <app> symbols (only hex-address and no function names) in perf top
> output.
>
> Case-2: When I try to run perf top -p `pidof <app>` on ubuntu host
> (based on ubuntu:bionic, outside the container) where the <app> runs
> inside a container that's also based on ubuntu bionic, and I can see
> <app> symbols (function names) in perf top output.
>
> On debugging both the cases, I find that, case-2 is able to display
> symbol when dso__load of </opt/bin/<app> is successful for the type
> DSO_BINARY_TYPE__SYSTEM_PATH_DSO, where-as the same fails for case-1
> (is_regular_file check fails), and perf top reports "Failed to open
> /opt/bin/<app>, continuing without symbols".
>
> In both the cases, the file /opt/bin/<app> is not available on the
> host, and its only available inside the container.
> What could be causing the above failure?
>
> Appreciate any help/inputs.

Hi Rajasekhar,

This is an area I'm not familiar with. I suspect the reason perf
record/report are succeeding from your description is namespace
information. If you look at the perf.data file with "perf script" and
probably the "-D" option, you should see information. I'm not sure
anybody has wired up the namespace code with perf top, which would go
a long way to explaining your problems.

Thanks for investigating this!
Ian

> Thanks & Regards,
> Rajasekhar
