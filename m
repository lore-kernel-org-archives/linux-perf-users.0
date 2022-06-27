Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D20C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Jun 2022 16:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiF0Qbb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbiF0Qba (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Jun 2022 12:31:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C437EB7C2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jun 2022 09:31:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n1so13814075wrg.12
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jun 2022 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HNkxfGs48VSxHAOqXGkJUfu04O7swZ6fTeoWEAvO5OA=;
        b=JxILDstZMdk9Wup1kgij/cyPb408PmxxA5LgQWcgiPdlRRIOB+YN4TKx735As0O2kU
         RWOucHzqW4EZqsX3Qc9Jv799JtdMoSt8TrkCsnsKr2LZ3iKifiIVnxUsvI5+uA4Cbz7k
         ykzgRcFdfviDDgE5VsLFt9gCyMNAitmefRqf/pbjt6D7wbDFRrwRpFLftlJ/kNcsab84
         NTCY7ELhGB3OmIGw0MFQHWqkcRSWiu4PWpuQ31TuDLsVXVPx2zqfeEbU4Z/hx/m3gQHn
         R4ZK2VXbZLlFyf2LGiPH2Z8JRkBxrUvbANzOItXHakGokLYIjTafhyFt2f/e9RWGXlh2
         r48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HNkxfGs48VSxHAOqXGkJUfu04O7swZ6fTeoWEAvO5OA=;
        b=Bl1zGhhlcbw7HzkVG51ilwpcXJ9xGRD1OG+smhUthvihaXxtqvG7LMI9MA2u1Fn3lu
         oK7akHkihjgj0sykx2iKEvmT/3NB7u+yQsOInlHd2qsrOQXfiPp3p+iy2eCnJAaU//om
         7Efwanne41+vD7JjQDJ8PAs14ie2rrjF2bgou/rYGhL/hPXXYzXlJhLvufujUc6RNDhQ
         JJ/m+Qu5T7UzH4r68nPNOvG8Nxlo5v5DLsQVUf1xVyPwLRUhcJV5Cq28FnynMtS5H5M7
         ivOdNGL8kFL13cwQ5VZCeSMNUpEv3bwD/xKlIKlbkUSjnWEqhn6EjhiY0Y4oNsqmqJ6u
         6wvA==
X-Gm-Message-State: AJIora+SZRV61nxS4B6nIe2d7C8HYE/R81x4vcXsRTjCmIA4LUN8d0Lj
        eSP+fa1fnDM4ryrSvf4rzMUA8gRdAPpXfikdszKhgsNz/6i42w==
X-Google-Smtp-Source: AGRyM1vZLeX8DOJUVBkOawsyL/LVSq07z3KNnVgtcidRX9ilK784cJUBC9GeDCsNhTctvdCTd0tia+Bg7nUCpFdDagY=
X-Received: by 2002:a5d:544c:0:b0:21b:a288:f98c with SMTP id
 w12-20020a5d544c000000b0021ba288f98cmr12901121wrv.300.1656347487372; Mon, 27
 Jun 2022 09:31:27 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Jun 2022 09:31:15 -0700
Message-ID: <CAP-5=fUpDdYOcRBBy21cDi=eTov++cKY_E-rnP9++wvopJbijw@mail.gmail.com>
Subject: June 30th - office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

An earlier than of late reminder that there will be another office
hours on June 30th at 2pm GMT*. We should do our usual GSoC
contributor check-ins, please feel free to suggest additional agenda
items!

If you experience problems then my email can be used for Google
hangout messages, I'll try to be on IRC (#perf on irc.oftc.net).

A reminder that the code of conduct is below**:
https://www.kernel.org/doc/html/latest/process/code-of-conduct.html

The Google meet details are here:
Linux Perf Tool - Office Hours
Thursday, June 30 =C2=B7 7:00 =E2=80=93 8:00am (PDT)
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
