Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B08ACCA483
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Jul 2022 20:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiGHUcI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Jul 2022 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiGHUb4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Jul 2022 16:31:56 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3587B9CE36;
        Fri,  8 Jul 2022 13:31:55 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id e1-20020a05683013c100b0061c1a6b8d11so3989406otq.8;
        Fri, 08 Jul 2022 13:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0B/exJxMFi1SZU84hxtogLTRJhADTBmMHexXyGp+XMs=;
        b=nYjxQeCkp1iLeEfRLOfkcs1608gRIK6Iknb7klM+Lf7hJwbZrWzRMwazATeCHEGTms
         xN0BPjZmS2ivCLEEqHxg/6GvtOP07q9YzeRmhPrTiv42p13wiIxmjTKPfQGKJs2RT7Ze
         pZ1fhD03GqOnexPSwZGWrGDeVec93mPvHf4GFf0AA4M4sMH4khStDysfFHYXd4Ic2IRz
         1jAaU4tRuBeknfuDy/SBVGsi53IqmObcVQk1/J8sx5s1DkMQ38rEnH/1yv7XJHTqdvkn
         teyKCmE/RjXRB83QA0v65/Q+kSuzoEDiGTjbZXxcZvzz5qVoFzaX0otwJwnL1rNLeCiK
         pg0g==
X-Gm-Message-State: AJIora/ryh2jv4Oe6vKamwfkFyNX4oLiWvJPYizwJmUWlIrxa5jMSG62
        jwz0AgOI1eBXJXX0LWz2NtZIaSPL1fiiHdJlOWs=
X-Google-Smtp-Source: AGRyM1v+YuqGSJknmDmAp+4llKViIBSyqnre9fRgbdcmXtOBih2YQuYHWWFxIBeHb2db4XvOUlQOVmkxxfvUcCjCh7c=
X-Received: by 2002:a9d:620a:0:b0:616:afea:1d62 with SMTP id
 g10-20020a9d620a000000b00616afea1d62mr2314892otj.124.1657312314496; Fri, 08
 Jul 2022 13:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220705150511.473919-1-german.gomez@arm.com> <20220705150511.473919-2-german.gomez@arm.com>
In-Reply-To: <20220705150511.473919-2-german.gomez@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 8 Jul 2022 13:31:43 -0700
Message-ID: <CAM9d7chzi9h+w5n_dXwAVwAgh-UyEQveVBh4ZenU60gUTDfrTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] perf test: Add test for branch stack sampling
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Tue, Jul 5, 2022 at 8:05 AM German Gomez <german.gomez@arm.com> wrote:
>
> Add a self test for branch stack sampling, to check that we get the
> expected branch types, and filters behave as expected.
>
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
