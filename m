Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65736C00140
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Aug 2022 22:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbiHHWgy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 18:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244727AbiHHWgp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Aug 2022 18:36:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F557192AA
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Aug 2022 15:36:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z17so12418618wrq.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Aug 2022 15:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=/fYTKzN+KmvOSZAeaqzQF8kkx1WjOkaE4GNtbDr+tPk=;
        b=Vr5qowAorj5TI6twxK5U4r9o5FwteExAaQhfkv+S+M0dHD0Io29z8SVBIjpMcIJfjE
         /TF851kO0Apf5Dq53MgrZ9SQdY+zQR1p9X+SiI1cJAR1RR269aIcPg2cLNI2HF3CeWX2
         CvDICXsV76mcG7g5WCOiCVLI1FcjwKSNcFNRb8WP/IajpQII3+8htbkFAAxzmNN2/173
         FonX7HiozmAha7Xe4rkjUZu7lP3IXaHG0aC4QbTS8pFGl3g/g/FBjMzTpyCGsf1bSOoA
         kQoj3hGvA3E8L5jBOq5LgjlQI0m1Ygf2SDHpHyUKVawH9OuJ10N1geuGrIlJV6lVCEDy
         JknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/fYTKzN+KmvOSZAeaqzQF8kkx1WjOkaE4GNtbDr+tPk=;
        b=LNcOSzrUWbQv2smR7Zb4+TR0IohMMVp/B2ts9uY9+y91eGAJ+TrsNHKudW29PauGSg
         I7BErpl/Ld76h99UPDNrLqtCbIsnc9ibpbSMdA4UiswFKbYhc75hUyvVAxGe79w6BIMx
         LZz3s9y6J7u54H5jOS83UcJykE5cFZAVjXo41wSB4UbimXjM0l27jeGXg6+bPWt5nPep
         EtpyMlm+Fk4mnTyWMDaOJugb3JtvHTcZwcDDIFMWOjvC8XXpLxRm8h6wClbEwQvDMyp6
         CU3M9Yg38TvUSYA2spCh+8TxAOash5QoasixosBiktnCrg+pqHvK5t5kRMcnE8CXS8gl
         FmgQ==
X-Gm-Message-State: ACgBeo1yXGNxuVlfrI9Ey+/6BbrCq6OD455355YfVfvwHwlZ1JsWCt5f
        7CStx2a/eH1A/C5cjbSTGg71ESCNm+T6bkq69l+M527GU7taWg==
X-Google-Smtp-Source: AA6agR4/2pvuOUpsw2LGeedPWkg+RSJkZwr1Yd5CFYEmYLomrKmw/cYLlbF3yDhUUiR1kPCZ2VPFzP7+9qDH2mLRURc=
X-Received: by 2002:a5d:6d4e:0:b0:21e:660e:55bf with SMTP id
 k14-20020a5d6d4e000000b0021e660e55bfmr11962855wri.343.1659998201771; Mon, 08
 Aug 2022 15:36:41 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Aug 2022 15:36:29 -0700
Message-ID: <CAP-5=fWiQHvYZp5R=uw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com>
Subject: August 11th - office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

There will be another office hours on Thursday August 11th at 2pm
GMT*. Currently on the agenda is the idea of having a reviewer
rotation similar to BPF:
https://lore.kernel.org/bpf/50da58e3-e056-2d24-765b-818fed09e216@iogearbox.=
net/T/
Please suggest other agenda items as replies to the mailing list to this em=
ail.

If you experience problems accessing the meeting then my email can be
used for Google hangout messages, and I'll try to be on IRC (#perf on
irc.oftc.net).

The code of conduct is below**:
https://www.kernel.org/doc/html/latest/process/code-of-conduct.html

The Google meet details are here:
Linux Perf Tool - Office Hours
Thursday, August 11 =C2=B7 7:00 =E2=80=93 8:00am
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
