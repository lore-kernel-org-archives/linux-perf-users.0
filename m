Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A34AC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Dec 2022 19:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiLVTOn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Dec 2022 14:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLVTOl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Dec 2022 14:14:41 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E129F27CD8
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Dec 2022 11:14:40 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id bq12so2116549qtb.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Dec 2022 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJNaFLC8BKqHDga1qfAWPtgnMSOxG5YailbfsAfU+ik=;
        b=b61Hcf9HQ4PdKZUPZZLS3zdovc4g6u1yYBjSZgqYu6QJAjBaXfM3ZQUO9y8930Wl8o
         5VplkZ9Tddes/053LAXLBP2Yeu/xoJFUXi0nNmXuIWvwOum0uE6dBYUiwQCYUhLt0vi1
         6nttqcTaSWh1ipcrOsn2D42Af5+OwmrLsWf2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJNaFLC8BKqHDga1qfAWPtgnMSOxG5YailbfsAfU+ik=;
        b=yuF2EKExoG0sE01UHwVvmko67tXwE2UGP6nLUBD5a5KKaTJv83EyRkgIM4K3IPCTlS
         iCT2E4kB99/5lu15YDK7YUbM68CqsK7ndtAn+Wvx+RwGQ1kMIcYdovTOPtAb0lTnopX+
         heTZGCpYcGLfcuEeYsL9614TDTMK7I9JVMe8W+cSUxDtl2azKDZusbs0S9C/xgKONqoZ
         jH56zIsKKE/i/LrbT0VlFT4y7Iega5Qdl68/GU3YcnIBQIZhmNyEjp+FAlDRN96Jgj0b
         wLjvjX2ux5HR5OCPOCOKL86tBKFBXZRVqR4Zsb7rg7pbcBcnIarWMGtm0xLoRtlH09Ny
         bSwA==
X-Gm-Message-State: AFqh2kpPnAxL3VfLdABd9b9L/O1Gk3MfaPlxDVymMyNhyY2IF9yTuvc3
        cj+E7+hQpTin7jgW98MOfSrCy9PdMzvJQTAM
X-Google-Smtp-Source: AMrXdXvGCQyOhg5TknliwMq7j0G8+tWwnmbDWhu5CskbZ4uu6TmdoNd92LzKEj+PodGA+a1KgS4iEg==
X-Received: by 2002:ac8:7513:0:b0:3a8:2e90:f7d4 with SMTP id u19-20020ac87513000000b003a82e90f7d4mr9123613qtq.27.1671736479878;
        Thu, 22 Dec 2022 11:14:39 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id m20-20020a05620a24d400b006fc9fe67e34sm825141qkn.81.2022.12.22.11.14.37
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 11:14:37 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id k3so1359714qki.13
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Dec 2022 11:14:37 -0800 (PST)
X-Received: by 2002:a05:620a:4720:b0:6ff:cbda:a128 with SMTP id
 bs32-20020a05620a472000b006ffcbdaa128mr277409qkb.697.1671736477239; Thu, 22
 Dec 2022 11:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20221222164914.508929-1-acme@kernel.org>
In-Reply-To: <20221222164914.508929-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Dec 2022 11:14:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4u5rpaPrOokekEg_5Sud=8SZhA=KTALXNOC_S89jKBg@mail.gmail.com>
Message-ID: <CAHk-=wi4u5rpaPrOokekEg_5Sud=8SZhA=KTALXNOC_S89jKBg@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.2: 2nd batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@gmail.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Dec 22, 2022 at 8:49 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>         Please consider pulling,

I have pulled this, because it's purely tooling.

HOWEVER.

You are now on my shit-list for violating the Christmas peace with a
pull request where most of the contents were not in linux-next, and
weren't fixes.

I'm PISSED.  Right now I am in the mindset of "I pulled this, but I
never *ever* want to see another pull request from this f*cker".

Get bent.

                    Linus
