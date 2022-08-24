Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD50C00140
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Aug 2022 19:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiHXTGI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Aug 2022 15:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbiHXTFw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Aug 2022 15:05:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64297BF5F
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 12:05:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k9so21926674wri.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=px7GQbtr/Q2dJ/FjqBe1Nrw7VFV0pJ4nzRQzHVYZOYQ=;
        b=JFHUexFCa4LWQwtu7wM7PzQM3rzkG6aC2FZcVyr10cncZ9637yaVAEhNt7SH2EydAS
         0TLu1PUKjhCGgQWYpASanu91HBbOzC9DNualbYsUKecldcKL7LrAVKg1xNdVRpOIe+wk
         IxK2PCzf35SFloKGSMPpqkjaIUANq7fFL/CsHBEgd1x0OM/HMmdg0GPHXzcB0Wug5rBu
         +h0NCSmR7Gjj/0ZRB8trLlulDPzhgG2fowdGayEggQfAGL73rXjwRVFhQF3myscnnDHf
         qYgCNigiXQge2W3T5u11kIwY2IlhInMrHK3AX/3uY03Kw5ArY50ggRrcFcFaPAp+ubBi
         y8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=px7GQbtr/Q2dJ/FjqBe1Nrw7VFV0pJ4nzRQzHVYZOYQ=;
        b=zBMWcE3B7HD9rA7xnWK+uIMhDstyUWeclE3hP4GwUp5xTIBYOQRpsdgt3GhO40wxQ7
         hoVMb4TdngF3xlVgttwRzbnol7IR7eC18AY/f3La2Hn23fsQI/f2ydHmAxfH+OXpr9jS
         dAjjbpDg1F4dwKGi+kDc0RPKKak49VPhGCzqpBSi1qyiJllA1ETn72tTVKJC0aqw4oVM
         8z/pm3C8cLaY+i9Q9Xv3ds1Z1HAzAiZwZo6NxcDesn84Xyn+UlVBJ576y0ojOI1372BJ
         pjUdrbiBu8510rlkb9JsuLguA3hPYbC3OZUTjuSbBQcW74MzrknmQNPUG7GMQRJlmmw2
         1/LA==
X-Gm-Message-State: ACgBeo0ra7ZK48ZpF5Pqav/ZjcOsUFmJLWgeFiZTi2T6QHV4P0k84LRp
        hOziO3Rx1GI1xGkkxy+usI7PTIIccPVlUyiYIpxO73pu6YF/XF3a
X-Google-Smtp-Source: AA6agR4PV+jx5a6vBEMfU+alSA7Z9evYzZcseTeGG9DD/Loll/mROvXUDuaIOyK6WZ92auc9xtPGLanUddX99b7j0Fw=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr313703wri.300.1661367943037; Wed, 24
 Aug 2022 12:05:43 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Aug 2022 12:05:30 -0700
Message-ID: <CAP-5=fUF2SyfTBfh=SugoCpN=7mUroZk85nKbuX3P6cNUkG2sQ@mail.gmail.com>
Subject: August 25th - no office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

there were no suggestions for agenda items for the usual bi-weekly
office hours, so let's skip this one. Here is link to the last office
hours 2 weeks ago that contains a link to the notes:
https://lore.kernel.org/linux-perf-users/CAP-5=fWiQHvYZp5R=uw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/#t

Thanks,
Ian
