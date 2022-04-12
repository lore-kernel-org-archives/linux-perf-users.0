Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F4EC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiDLNyW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiDLNyW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 09:54:22 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB62356C39
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 06:52:04 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id l11so9940013vsi.8
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ARL1hBUCxcydG1yNfsTclekze69Lm4jTzmy/NdEHp24=;
        b=lrxGGDaGYbJtiwEmF2GFgJeddrW7Mxl9RiuELp2XOda699d4umqxQQCCFuth17Exud
         QItAwULg8WBm5dRGXyyxIwXkTQB7HLJwbVwCbk4XmuYTYcbobdmXfJ1Jn4u0a2PCn9w2
         kfKb4Oe7XoWCrPzr1BKpUdipjlcm1+aDh64Yu37KmFk0CiYwJTM0awIEK3GmTyNXIswj
         vqjtiM2emo4BgmloOk1T5CniL3O8WRpT1w5zw0AIR411v2yEDguovU/s0gspRXWw1wN3
         zJjteglAjNufrxsuRvZpdZt+UIpIr6I/NK+fT4FieKnt9kOvAbK1DzE5Tw4phan6/vs+
         zaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ARL1hBUCxcydG1yNfsTclekze69Lm4jTzmy/NdEHp24=;
        b=q7BskZvbgdmP3dfjp4IsIpqFp/DUnKkhfePc5gY+Ew2XUtckrVCddH3AxAdvYp/QYk
         Nl9MJJGTVvkoTVV12b23A+sOIg4yvmTEzYq+uEck9RpeB1j9dc+3CyN83ZdbCaaQrInD
         SHPh4Nwt8kfzCi/HFZW9dbF005uIPRrpNRzoAS0tRB9jICkoWNfcxRRZB8Y8+ZNUz7VE
         opzpgktpC9x0kllPZ2WJinNlwafYyHFqwpXcZVeHMNYv/itrbXJNa4KXAwLz/56Fg36u
         1zbFcPmVbF0kGvjoOVhWgQYfhqbJposLwK3Z0Ot2fqe91+ukYTEd4omOqLzUfNkxHrHO
         re1A==
X-Gm-Message-State: AOAM530UeQIajnZ15hyGw68+vPUYlvt9P9NsPmLH1Q4zgS3xOlQbakOr
        MMETKAO7jw9xee+ZclBogJfXs1cCwwhBHnfkFHTmpXXUFEHDNA==
X-Google-Smtp-Source: ABdhPJyTScIZuF/Mfu7CGu+OU0TBL7b+qBsgbkDqiTG5UzODJ/C/2jDNDMjqvd4jZYesGYYm2cl+hh0cZVRfMnVLAeE=
X-Received: by 2002:a67:e917:0:b0:328:255a:ece3 with SMTP id
 c23-20020a67e917000000b00328255aece3mr5847396vso.78.1649771523486; Tue, 12
 Apr 2022 06:52:03 -0700 (PDT)
MIME-Version: 1.0
From:   Tanusree Debnath <tanu235m@gmail.com>
Date:   Tue, 12 Apr 2022 06:51:52 -0700
Message-ID: <CAPS78poKf3EF5y_AND3p7A_rc6SGbQtmBfQKnBzkqU+yq5TF6g@mail.gmail.com>
Subject: [Question about project size]Perf data converter is large project or
 medium project?
To:     linux-perf-users@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>, arnaldo.melo@gmail.com,
        mingo@redhat.com, acme@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
I am applying for GSoC. I wanted to know if "Perf data converter" is a
large project or a medium project as I have to mention that in the
google application form. Please let me know.
Thank you,
Tanusree Debnath
