Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA7CC54EBD
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Jan 2023 15:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAIP3A (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 10:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjAIP2m (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 10:28:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D76D212
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Jan 2023 07:28:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w1so8546728wrt.8
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2023 07:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=atG7EEcNlleWcb/1g4r1RTYwLZQvUtOWoyW0ww6KGuI=;
        b=iDWuz0kK+hrS1TjMbpXQgWpgN2CpO1NaBG9vSiRkHb4LWyEOFUWWwyLaoNHBOHzTSy
         0tKzOApl+lrCFW3A+yKrdH+Z8yBIQiLjscOUtKO1pVc3+L9B3k/hoNFGgAE01hbRRdnH
         zgiKODe4nD0rPEFJPFZrcp6Cn/d4gkts6szrI0EAzHqa/x0uIsK29W3JUXjaAbNV7X9O
         p8DREgHCAdNQQx5kCq+XH0yroe8KCunK109Hy9EKKQ3AGX045DfKECUL6droA1vWH8Gp
         cs86VCXQX2tGd0/eKZ469x8aWEIexN0R1vCwU+Arwglg+WvRnLAcIo4mxIVu4PS4+4h1
         sz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atG7EEcNlleWcb/1g4r1RTYwLZQvUtOWoyW0ww6KGuI=;
        b=YVXhXJRr87702AQRWi8LQZ0mp2QD1W44f9cEXBYvbhN805quKKfJw7IV/Q8HHVKheU
         hN5z2yBNBBV3h1L3yC1qLTCiV9HoZg9glGerhoCFRz8heJ4+lChnOl2Fku4WkWG8Pgj3
         MycoUJuas9iiiD1bQs0IGW/pcaYZz/KP3uigfyLkFo6MBq6N7hV4ljMy/Jrjd5wRr/6D
         o6NUrFdtW6BHSW0ZvKiDTNyGpk6D5KqU3PtCPnSMeHvOEuleVHSmTKrVD9/meIS2Uoev
         JXDaMEkRT8cU2GoMiTvkUyt0dooITh+7iEK36KnUx/7oCuY9Quv/7qFdm4N7lKKFC2Mc
         c04g==
X-Gm-Message-State: AFqh2koqj2EwuFhVP/L3Pvp/xnGoILEasMg7KleelLqOZBk408lMYt0R
        1DW+N6kknUykRxJXxyIqqO0MjFJye7T/BzRiqosvIWKnenBn7FOU
X-Google-Smtp-Source: AMrXdXsiqFcSp+z7D+SIrq8mHF8+qg0Q+ODp//r7DXimfi3T6Mbiu91grRXYCvxzKuxvpxu4kJGlzMMOn5leaXTi0C4=
X-Received: by 2002:a05:6000:12cb:b0:28c:459a:d5d with SMTP id
 l11-20020a05600012cb00b0028c459a0d5dmr1369048wrx.654.1673278118640; Mon, 09
 Jan 2023 07:28:38 -0800 (PST)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Jan 2023 07:28:26 -0800
Message-ID: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
Subject: Google Summer-of-Code 2023
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

The Linux Foundation will apply to be a mentor organization for the
Google Summer-of-Code again this year. That application process starts
on January 23rd. For the perf tool applying as part of the Linux
Foundation, we have a good record of getting the contributors we ask
for as part of the program. Contributors are very welcome! For the
program we need mentors and project ideas. For mentoring the workload
is to review changes, to attend the office hours with the contributor
and to fill-in the 2 evaluations. For the project suggestions,
anything goes. I've included links to last year's suggestions at the
bottom. If you have ideas for projects then please reply to this
email!

Last year there was confusion over whether people working in industry
could be part of the program. Our answer was yes in terms of support,
but they wouldn't qualify for the GSoC funding. I'll try to make this
clear on our wiki, if it isn't already on the Linux Foundation's.

We'd like to continue having the requirements that applications have:
1) what the project will be,
2) a weekly time plan.
To make the program run more smoothly this year, we're also going to
add a requirement that the contributor has sent a patch to the mailing
list. The patch doesn't need to do very much, say a documentation
improvement, but I'd like to be strict and say that any application
not meeting this bar be rejected. Thoughts about this, improvement
ideas, and thoughts on what are good requirements are appreciated.

Thanks,
Ian

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2022
https://wiki.linuxfoundation.org/gsoc/2022-gsoc-perf
