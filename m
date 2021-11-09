Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7527FC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 14:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D9E611C5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 14:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhKIOJ6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 09:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhKIOJ6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 09:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636466831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6HrMco/R0NUD57OxTvVAWvFQ91tOHioQPvFqP/WswDk=;
        b=Gqx7G8v3CVl08FFdB/9DIMSmMKWW+pPsX3jBJxtu3Tq6WdYNDwar3iTbIlTje3xuTyM362
        pQKpVvvMNB6shqXL8cFiUONHbHMbu7AvVDg+M20mh8yFQw2sGrH4XfJwnrHFepIRvYAnHj
        ZmVWe9kqnAVyVmEqAnYZqNE0gOdBrY4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-srbnBx5kMcCOBRA67RH8tA-1; Tue, 09 Nov 2021 09:07:10 -0500
X-MC-Unique: srbnBx5kMcCOBRA67RH8tA-1
Received: by mail-wm1-f72.google.com with SMTP id b133-20020a1c808b000000b0032cdd691994so1413999wmd.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Nov 2021 06:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HrMco/R0NUD57OxTvVAWvFQ91tOHioQPvFqP/WswDk=;
        b=l3pKARGmRHr+aYGdhuGdFWT1HegpgbQIc8iSpCEaOHMjeIucO60Hkikev90vjOa8BR
         ydqCngCekokobZrvxSErFk1Q3tCp2IhaPhyLTAFm5obMPC2JbTfU8NHGB8lo34hNDqQ9
         zB/DCq6a3f0kRCvIlMtbDpW2M2d5R7s8nHFRkDXqyDZ361nTX25xFFl2J8VF2ECHyS8e
         kdUp47/g0tJjp87J/jOzok8EFPIdH+Ng+el22t/ZEw5MIMnWGvZ64oeGQ/HRVBXieY4V
         oCgMbA6p5VnKt6TOy4Dgx92r0JR6HRY05OrfTpVIMfoGxfJ6ISgo8qk0/y7r/atMrEJG
         tDcQ==
X-Gm-Message-State: AOAM5331mgyvZF0X5m5VrmG//H7uS9i/1ar6uM0WiYswZmhEiC8QyliD
        OmZfRU/iOpzlu8AwkKOuo3xyQFq80if+bcshUTjQawyf8ARGCtZd03hrJEmEP3q8MEZCRbRoKQz
        YGwJMuJz+H+mos4DKeLZMMseoELrReQ==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr9562292wrq.44.1636466829416;
        Tue, 09 Nov 2021 06:07:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaP3JI+F3utXxRMEWygfnuHNjAmS3H+yQwa9Je6KMvLAT6PSUOSZqkXEDwKRAQziCXRmv2DA==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr9562242wrq.44.1636466829164;
        Tue, 09 Nov 2021 06:07:09 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t189sm2762136wma.8.2021.11.09.06.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 06:07:08 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/2] perf tools: Fix perf build with dynamic libbpf
Date:   Tue,  9 Nov 2021 15:07:05 +0100
Message-Id: <20211109140707.1689940-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

hi,
sending fixes for building perf with LIBBPF_DYNAMIC=1.

We hit the window where perf uses libbpf functions, that did not
make it to the official libbpf release yet and it's breaking perf
build with dynamicly linked libbpf. Fixing this with adding weak
stub functions for possibly missing libbpf function.

thanks,
jirka

---
Jiri Olsa (2):
      perf tools: Add more weak libbpf functions
      perf tools: Add weak variants for the deprecated libbpf functions

 tools/perf/util/bpf-event.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

