Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2FC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 06:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39E560F51
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 06:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhIEGUk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhIEGUj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 02:20:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392CDC061575
        for <linux-perf-users@vger.kernel.org>; Sat,  4 Sep 2021 23:19:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id y144so3634724qkb.6
        for <linux-perf-users@vger.kernel.org>; Sat, 04 Sep 2021 23:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markhansen.co.nz; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=/6nfJ7qwDy9nO60vMh0HZ9m00iN5hwn8CHtY19KFrlE=;
        b=g0AUJ4YUhpl54C0b+27KsUEOrqL2HLxVOCitsTmYXBH3CZOqEvfP5PtWyNpkXe0NJb
         jyBBGhAPemn94eIOvVY/cBLvi66UBuaJn8Eglf6ZQXDplpzmD2DzfkgFleHHnz7XP4zZ
         JDThhFRUc2+d0ZmF6xO0FuSenn1T+usG7NXg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/6nfJ7qwDy9nO60vMh0HZ9m00iN5hwn8CHtY19KFrlE=;
        b=ktnGbJegGlUwheX4iQ1ueYcULqG7AGYTOV5e5GmhgGLwoei0fpJOHuKyu9v/Cn8Z5x
         2mnovN/Z4VKD/aa/4102vY8AOpnXRRI3nbqrp1c+VXZf4WTC6HWk1kPWaHsN4sbZxAr2
         +AxlOLIGqNgVDtNupOgYxX+Dx1/rbEeo95o3u0B+r4RcyAHq/UYuNmadHF9WmLzEEAMU
         NlrnZ0ybMQAEpMeEisImcDrVmUktyciAJP3ufncALkhT3Ypv50aUx/2HtAksTZZGGTk/
         vvPO12cYZz5oTtbhb6a2On+jVdn0F4tENcVDsgGEYpfzQOmDS4KJaFoYMedPl1TGbx9z
         2wwQ==
X-Gm-Message-State: AOAM530S9K666du/v9AbhFoj9sYLMg3FUxx9D55Q8dHfmiOG0Y1gjBLH
        WE/fQOUF8P7JJLbDCTe9VXJp7WBhnRIMhwd8Inh7XkHQLpkaGMec
X-Google-Smtp-Source: ABdhPJyCFit6xQWXGDPkW7n9KexqGY+tch2tX7A2oWPedF0Sgvze3VgDSXnGkxFeSTfzgvk9rYPyhPI5Wd/82gzBAHk=
X-Received: by 2002:a05:620a:2094:: with SMTP id e20mr5791834qka.171.1630822774947;
 Sat, 04 Sep 2021 23:19:34 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Hansen <mark@markhansen.co.nz>
Date:   Sun, 5 Sep 2021 16:19:24 +1000
Message-ID: <CAM07o6QB9rUgzxHxR=sdwTddn+2GxeK5Uwj9QeCVMyEiD5SRdA@mail.gmail.com>
Subject: A list of visual Profiler UIs for linux perf
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi perf-toolers,

I wrote a quick literature-review of profiler user interfaces
available for analysing the output of Linux perf:
https://www.markhansen.co.nz/profiler-uis/

I couldn't find a similar list of profiler UIs online. Hopefully this
can help people find the profiler UI that's right for them.

I'd appreciate any feedback; in particular: did I miss any great perf UIs?

Thank you for all your work on perf,
Mark
