Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58641C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Jul 2022 00:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiGNAqP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Jul 2022 20:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNAqH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Jul 2022 20:46:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B9C93
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Jul 2022 17:46:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l42so86793wms.5
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Jul 2022 17:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=f6spPUblCIvNStxvc9BXTnXfJC2e5EnBS8mAinmLssk=;
        b=QYwn5tQYK5wzRsdra7vT47cXY16QDcTb3KZPRtj6UG4CtnIktnit0MI7lJb/xAy/rT
         WxfJrZ5lUptjJ2+n4R7npPQQwART1ym9BHvhh8Xi++F244EgkGjkRgf6YgcZazdpZy+P
         OfX+5omAVllR6EcgCJZ5ElwMWAXPClqI0+u3btffsjU1L0xEt8ZiIr4Duy/WKPV69AwN
         IEmuCra47I02COKYQjRxQgYy48D6Sz8rU/31KMeA710AWG96jP0rGSo3YFCrXbMyOfhc
         TvlMw/0L99hetRZ0fNi5ALuKWFOfcrewaLRZEv/VOrFwoVOfEg1ODeTmzlR9L2KhV5vX
         xeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=f6spPUblCIvNStxvc9BXTnXfJC2e5EnBS8mAinmLssk=;
        b=enbkQdTG9HimHVQA5hKP7sY15PScgoECdmI1eUyM0stjNvu29xJgQQ3kn4750PrVsQ
         53LCBcwZSYE4QFcnwgT1szqxyyA1hp+NgLJReB8hGa3KoSgK6TDVfcQAXxAxTzo670Ud
         vjNqhMPd3BOu+gp0UJpJWLzHVC5XiegbRp8GHHs7Wm3ni6lOvSAl6ZaxNgyI9SiFyYgH
         Fivdpcy2Ez/dEz+57gemMpJ1tuQAZmFnUYVZsQ8vRXjECWfJ3Y4z2RG5xwak60C/aZlL
         QXhE0f9Vs9vcbrq8SD0FaQOUJqOYxmnMmP+LFtR9xAK5lf8/++qiGJT1VrlVmOCcKwKa
         5psg==
X-Gm-Message-State: AJIora9YVhXdxqrXcBOQWZeTUYoYYYGEypklZ8yzKGKfDglZd5Szq438
        FwKbZJY8L/rKE0gkjuqhTHiL89K6TfpVoeZa9O/9kP5qbuAl1Q==
X-Google-Smtp-Source: AGRyM1u99N/0oe1TT8oti7NN5bfOOgxwifE9ii0DELdV87d4t0FH/JNQul1j7k4r4lFfT+U6C9QW44eug43gqXZpZYc=
X-Received: by 2002:a05:600c:4e8f:b0:3a1:8b21:ebbc with SMTP id
 f15-20020a05600c4e8f00b003a18b21ebbcmr6298851wmq.149.1657759563433; Wed, 13
 Jul 2022 17:46:03 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 Jul 2022 17:45:51 -0700
Message-ID: <CAP-5=fVeuk7eb81KpsTG4_+-ahVcUMR64=zb7gQtkz6yQmLqvQ@mail.gmail.com>
Subject: July 14th - office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

A reminder that there will be another office hours on July14th at 2pm
GMT*. We should do our usual GSoC contributor check-ins, please feel
free to suggest additional agenda items! One suggestion has been to
discuss the json events and the recent python rewrite of jevents.c to
jevents.py.

If you experience problems accessing the meeting then my email can be
used for Google hangout messages, and I'll try to be on IRC (#perf on
irc.oftc.net).

The code of conduct is below**:
https://www.kernel.org/doc/html/latest/process/code-of-conduct.html

The Google meet details are here:
Linux Perf Tool - Office Hours
Thursday, July 14 =C2=B7 7:00 =E2=80=93 8:00am
Google Meet joining info
Video call link: https://meet.google.com/goj-quks-ydn
Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 227=
=E2=80=AC#
More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431
Notes (ask to be added to see):
https://docs.google.com/document/d/1tQZvJ12czMedpmLLZWS0XILAte97zdR6H_tgC3I=
vafs/edit?usp=3Dsharing&resourcekey=3D0-iV9_8Oc0cSOPl0-NvEYDAA

Thanks,
Ian

*The around the world times I believe are:
China: 10pm
India: 7:30pm
Europe: 4pm
UK: 3pm
US east coast: 10am
Brazil: 11am
US west coast: 7am

**More details from the first office hours are here:
https://lore.kernel.org/linux-perf-users/CAP-5=3DfWkxtm5-Ebwkh4pzA83prvuAJ5=
yy6CKQYatdkKWu3Tgeg@mail.gmail.com/
