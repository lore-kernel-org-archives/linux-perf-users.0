Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2E0C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Apr 2022 09:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiDRJ1B (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiDRJ1B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Apr 2022 05:27:01 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F05715FD7
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Apr 2022 02:24:22 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 12so14204410oix.12
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Apr 2022 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fl6ppFqSL+ldLOtCtxZXfq1o9zlQYEZKTYtXl+gtm6I=;
        b=XwFSqeM8sRdiwRjGddB0ngRMEjIBdDhYEEcxd8vn0H8JltIrN/yt91IJpHw7DeUIFH
         9KusOs8gDpThLQC3cWrJeMvCDRXVmy9h4UfMHLcibihuNKSETjM4gijKpyxOSgDLh+bo
         bgTrHj7W4HRlWoC4lkVIJBI05/wbS03JpoLtupt+SqjEZ1kszlKuK+oiAQCBiULnMSA8
         oKMhw0fAtSvEgjtiMZOsWIv8o6AE2k3QhcETpf47UKt6YIvi5ISVUDsdgLycz9Rqx2h5
         fdCRo3rFUvf9i7OJsKJhvTWtUtq73IfC7uY5hw4hDPkXFJFWjmmPk9kiBDlahNyJfRIq
         XZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fl6ppFqSL+ldLOtCtxZXfq1o9zlQYEZKTYtXl+gtm6I=;
        b=TkchHkqZ5X7QWCA3ZWLpFOOqbnLHUFURqQwqsEGA8UX+DGhD6rMSI1yzRUzCEPSk3b
         165LvZIAcGd/O8ciYE+9LDI+Xa74ixrhpOVPks2pozIPWGDtjU84ALXJh8lWjBC/cwjG
         fpipz0vyhmXIekPgQKfA3DvpKG1ei7uCpJEmLHhkf/DxXpn4pq137+tqdmc3LrFabCnb
         W7hHuUd3SuYrgaUnlkrlZf/xTgcH7Fanr/uBEQ9oc115Ov7Qicg+2uUg0/noIaOEff6B
         nPwE51MuHPcMmiWdDUCs+wSZcO0jM+9TvmL0QmtpVABc+tAdoz1NyvaRuJ/m/gEHfkhh
         DbdA==
X-Gm-Message-State: AOAM530PSAvvRrJA5Bwxp3P9aPTyrWWe33mGO145aU/WodIDZ/m/LQzf
        ppzifueMiUy5NiV+LsbYzhTlfVKhsQUe0cmGqF+ylOzSww==
X-Google-Smtp-Source: ABdhPJzO3XAZbCNOVvn4FUJnzKjKOxXLngm71s2oGBeG1HGOGhFKO5mA+A9xH9BD6zVkcgZxvIhuV1nwzU3tlQk+gsE=
X-Received: by 2002:a05:6808:1309:b0:2f9:c16f:d58c with SMTP id
 y9-20020a056808130900b002f9c16fd58cmr6809898oiv.292.1650273861371; Mon, 18
 Apr 2022 02:24:21 -0700 (PDT)
MIME-Version: 1.0
From:   Mahmood Naderan <mahmood.nt@gmail.com>
Date:   Mon, 18 Apr 2022 11:24:08 +0200
Message-ID: <CADa2P2VjP3GLMBvrQhD-mt1119r3UFNKVFVY3KRXuTLDvGV8yA@mail.gmail.com>
Subject: Effect of sched_latency_ns
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I would like to test the effect of latency_ns parameter on the
execution time of a program. The program is a 16-thread MM
implementation and the CPU is Ryzen with 8/16 (cores/threads). I also
have created a busy system with stress --cpu 16.

The default value of latency_ns is 24,000,000. If I use lower values,
the execution time gets longer. If I use larger values, the execution
time goes a little bit down. But the problem is when I use perf and
see the stats, they vary over multiple executions. This is expected
because of real hardware execution, but I am not able to figure out
the conclusion about the effect.

Example:

For 100,000

       142,696        context-switches
         1,625        cpu-migrations
        51,106        page-faults
  40.103996890 seconds time elapsed

For 24,000,000

        62,185        context-switches
           379        cpu-migrations
        52,929        page-faults
  19.424256128 seconds time elapsed

For 100,000,000

        63,646        context-switches
           513        cpu-migrations
        52,930        page-faults
  19.716886869 seconds time elapsed

        54,644        context-switches
           487        cpu-migrations
        52,894        page-faults
  16.788766277 seconds time elapsed



Any explanation about the effect? What should I expect?



Regards,
Mahmood
