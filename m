Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111A5C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 18:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiFOSY7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiFOSY6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 14:24:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874525588
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 11:24:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q15so16441173wrc.11
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dcAxWgbZuRHTp66ggWKgZRQnYEOnRN0xUdUzompkjlI=;
        b=AAlNd6Lwcr4sbv/nSgSJS5gZgZrBovngMXOuvbDW0zpntn6a/XL7WMUmwe8rMzK3q6
         6gtaP6LvEWknTyRNCguVVZRGxl/ayptS3v1Sa6YbjgBCi9ol/mFKVaB9grW3pdDqiBt+
         eB9b0gK84ouMfD28zfMFPqod3FZF6MhZVfyVCsIYCdz8PXzcsGDAWzkkls6hHS6bZvd1
         MOVYNbqENDjsvSOzqE171ictHpZvTrDrYStn5I55jl9n/XoHHc6jTHo/hIFSnEJE/7e6
         TovJzNnywKoG4OL2QPQSAS38IeYYWw8Aymm8jfmCaghllXplNlE0FuB/KMwq+qPw5/Kn
         bdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dcAxWgbZuRHTp66ggWKgZRQnYEOnRN0xUdUzompkjlI=;
        b=EntbKkTTd719b9RpweLgCzfl5rp8p17vCGEkmgPI6sfk813ASJJQs8UXee888Sosqc
         ZmZ/tmA9sfd8LEIF8Zz5AUJSOE+yL6brMNIpcAAog/WK0pZzw4pYpa0h1RY8gYudgw5g
         4OwuyrybTZRI/WKvAaRQ8fWCx8qmfjz6LjKkbL00hFCTZgFf6OXEhJH6MpLXb7xMhqie
         mbp53LYjD/ocHo+4JIv5z5O67L3e6GLh4wIPaacuIfg5To/zuMlW9HN6pzvtVl5ynVOe
         Z5Nrq+mQVIUqeSrh1F90ZkLNqftyaQ7Xrd3DaRgtOg0z91vdN/BF7buhz3UOnG9rUeQU
         aUgw==
X-Gm-Message-State: AJIora+JsqZKyMFpwuRZ0TEmA4MCvPy61SeVbBpb92b4RnYrqdQt9H3k
        jsD4BOscEfUQj+y3TpZaWFFcfU/hw0M7D5KiDqqTw+cpUcu5Aw/c0io=
X-Google-Smtp-Source: AGRyM1uc3C11xrMSmEKL/cMINqibGVrFUNr3O/PY9RbSRqM4JK5iyabAQ9529q2C9akOMeAmdgJ+dK9xmZRWwqjgAuE=
X-Received: by 2002:adf:e19e:0:b0:211:7169:dfa6 with SMTP id
 az30-20020adfe19e000000b002117169dfa6mr1072699wrb.654.1655317494855; Wed, 15
 Jun 2022 11:24:54 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jun 2022 11:24:42 -0700
Message-ID: <CAP-5=fVdLBjQa4ptJGMfSSm69d=vezqLr=ZwoCk8J1R4OPVTgQ@mail.gmail.com>
Subject: June 16th - office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

A reminder that there will be another office hours tomorrow at 2pm
GMT. The around the world times I believe are:
China: 10pm
India: 7:30pm
Europe: 4pm
UK: 3pm
US east coast: 10am
Brazil: 11am
US west coast: 7am

If you experience problems then my email can be used for Google
hangout messages, I'll try to be on IRC (#perf on irc.oftc.net).

A reminder that the code of conduct is here:
https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
More details from the first office hours are here:
https://lore.kernel.org/linux-perf-users/CAP-5=3DfWkxtm5-Ebwkh4pzA83prvuAJ5=
yy6CKQYatdkKWu3Tgeg@mail.gmail.com/

The Google meet details are here:
Linux Perf Tool - Office Hours
Thursday, June 16 =C2=B7 7:00 =E2=80=93 8:00am
Google Meet joining info
Video call link: https://meet.google.com/goj-quks-ydn
Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 227=
=E2=80=AC#
More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431
Notes (ask to be added to see):
https://docs.google.com/document/d/1tQZvJ12czMedpmLLZWS0XILAte97zdR6H_tgC3I=
vafs/edit?usp=3Dsharing&resourcekey=3D0-iV9_8Oc0cSOPl0-NvEYDAA

Agenda:
 - It is the first week of GSoC so we should do our first check in
with the contributors.

If other people have agenda items then please reply-all to this
e-mail. I believe there is interest in discussing hybrid plans - I
don't have hybrid plans but if others want to discuss this then please
let me know.

Thanks and I hope to see you tomorrow,
Ian
