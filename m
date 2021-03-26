Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1A4C433C1
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Mar 2021 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B885E61A26
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Mar 2021 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCZPvG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhCZPuo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Mar 2021 11:50:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF4C0613AA;
        Fri, 26 Mar 2021 08:50:44 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h7so4550474qtx.3;
        Fri, 26 Mar 2021 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=IE/p6g9B2j41zhqUWurLlnl/wvSKINeBITFu3XthIDw=;
        b=p5amyNRlPFbdvX8+G8rZZpCWz1eiLsPmRgfnfnuQrsvAuomUOUCem+Us27BVYWoOpJ
         +WX8mcl2uZSZjfJ7B4UWT6BtwcH/j+ShhXBZqu5mfieu/O16ijwKGhNBhhrQ85YdwCaD
         0lO9DkSlMZpGqhi3y4p6xaYaOysE3lYrveyH98PidrLDRmJxMQO2mW4pWW54oCI4jhP+
         CBbDDOuMSa/8NjnnkduMNkJ46pHE0vl/qALswUKogyzqw7mBR1Rk2NAW/WOkpydg8oUP
         wlIpSKsOHbfhNKRvtZFa1kHhOvhKZinI9jC3mCyNg2/iXhzHOwMYZA8LCV10TwfFA6lx
         3K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=IE/p6g9B2j41zhqUWurLlnl/wvSKINeBITFu3XthIDw=;
        b=QbWS381ZgZ2tqEiqlUqUjtn9w7djRiaP+mr0eAVD5fmHQi0NUiGhxUuYPL5eGTUuYR
         oSt3T3Qy3qIjZmSRz4/oy0fcAAZ3lRU3Cix9E0bEwv19eD6V3rPSHAAPef9L9pMK+Bui
         uh3yU5jPZ1O4aas8a0eMQkJmb9iqZAspaltfGYywWSyRNzqgwrT7a6ZIYsLECgXzYqUk
         Hax1tRfWboqYFsuFrnuBK3S1dwKp0SygJyDjSLvYV/MfXBgRMXIOKKXM5kmEIf6qmjRu
         FOkddWRLLyh8p5OFQeBbznCPKAQMaSAwUpvQX7SEp61vT0ix/tBSig14K7CKmFmFZ/zK
         LAMg==
X-Gm-Message-State: AOAM531KPKEufwKsA8aF9PRRD3cUvbnte7OEskaWzYLbZaGYf20qUFqn
        vmaO1R+vndP82amOl39CChA=
X-Google-Smtp-Source: ABdhPJwK+yJ7RtkvcmD0Kxv252vfc+rSR03GCh3POtfxdO6K/hLy2U8/ed9WOmaS2BxvtUGloaqiag==
X-Received: by 2002:ac8:4a18:: with SMTP id x24mr12675962qtq.33.1616773843573;
        Fri, 26 Mar 2021 08:50:43 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a207sm6968906qkc.135.2021.03.26.08.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 08:50:43 -0700 (PDT)
Date:   Fri, 26 Mar 2021 12:50:15 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <80EE46ED-9007-4CB7-9A52-A7A2ADC616C6@linux.vnet.ibm.com>
References: <1616425047-1666-1-git-send-email-atrajeev@linux.vnet.ibm.com> <1616425047-1666-4-git-send-email-atrajeev@linux.vnet.ibm.com> <YFuWb3S8p0ZGjmGu@krava> <80EE46ED-9007-4CB7-9A52-A7A2ADC616C6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2 3/5] tools/perf: Add powerpc support for PERF_SAMPLE_WEIGHT_STRUCT
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>
CC:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mpe@ellerman.id.au, acme@kernel.org, jolsa@kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        ravi.bangoria@linux.ibm.com, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, peterz@infradead.org
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <F5813758-37E5-404D-BBC2-49F5BE6101C7@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On March 26, 2021 12:23:04 PM GMT-03:00, Athira Rajeev <atrajeev@linux=2Ev=
net=2Eibm=2Ecom> wrote:
>
>
>On 25-Mar-2021, at 1:13 AM, Jiri Olsa <jolsa@redhat=2Ecom> wrote:
>
>On Mon, Mar 22, 2021 at 10:57:25AM -0400, Athira Rajeev wrote:
>
>Add arch specific arch_evsel__set_sample_weight() to set the new
>sample type for powerpc=2E
>
>Add arch specific arch_perf_parse_sample_weight() to store the
>sample->weight values depending on the sample type applied=2E
>if the new sample type (PERF_SAMPLE_WEIGHT_STRUCT) is applied,
>store only the lower 32 bits to sample->weight=2E If sample type
>is 'PERF_SAMPLE_WEIGHT', store the full 64-bit to sample->weight=2E
>
>Signed-off-by: Athira Rajeev <atrajeev@linux=2Evnet=2Eibm=2Ecom>
>---
>tools/perf/arch/powerpc/util/Build   |  2 ++
>tools/perf/arch/powerpc/util/event=2Ec | 32
>++++++++++++++++++++++++++++++++
>tools/perf/arch/powerpc/util/evsel=2Ec |  8 ++++++++
>3 files changed, 42 insertions(+)
>create mode 100644 tools/perf/arch/powerpc/util/event=2Ec
>create mode 100644 tools/perf/arch/powerpc/util/evsel=2Ec
>
>diff --git a/tools/perf/arch/powerpc/util/Build
>b/tools/perf/arch/powerpc/util/Build
>index b7945e5a543b=2E=2E8a79c4126e5b 100644
>--- a/tools/perf/arch/powerpc/util/Build
>+++ b/tools/perf/arch/powerpc/util/Build
>@@ -4,6 +4,8 @@ perf-y +=3D kvm-stat=2Eo
>perf-y +=3D perf_regs=2Eo
>perf-y +=3D mem-events=2Eo
>perf-y +=3D sym-handling=2Eo
>+perf-y +=3D evsel=2Eo
>+perf-y +=3D event=2Eo
>
>perf-$(CONFIG_DWARF) +=3D dwarf-regs=2Eo
>perf-$(CONFIG_DWARF) +=3D skip-callchain-idx=2Eo
>diff --git a/tools/perf/arch/powerpc/util/event=2Ec
>b/tools/perf/arch/powerpc/util/event=2Ec
>new file mode 100644
>index 000000000000=2E=2Ef49d32c2c8ae
>--- /dev/null
>+++ b/tools/perf/arch/powerpc/util/event=2Ec
>@@ -0,0 +1,32 @@
>+// SPDX-License-Identifier: GPL-2=2E0
>+#include <linux/types=2Eh>
>+#include <linux/string=2Eh>
>+#include <linux/zalloc=2Eh>
>+
>+#include "=2E=2E/=2E=2E/=2E=2E/util/event=2Eh"
>+#include "=2E=2E/=2E=2E/=2E=2E/util/synthetic-events=2Eh"
>+#include "=2E=2E/=2E=2E/=2E=2E/util/machine=2Eh"
>+#include "=2E=2E/=2E=2E/=2E=2E/util/tool=2Eh"
>+#include "=2E=2E/=2E=2E/=2E=2E/util/map=2Eh"
>+#include "=2E=2E/=2E=2E/=2E=2E/util/debug=2Eh"
>
>
>nit, just #include "utils/=2E=2E=2Eh" should work no?
>
>other than that, the patchset looks ok to me
>
>Acked-by: Jiri Olsa <jolsa@redhat=2Ecom>
>
>
>
>Hi Jiri, Arnaldo
>
>Thanks for reviewing the patch set=2E
>I checked that, just using "utils/=2E=2E=2Eh" also works=2E
>Below is the change which I verified=2E Since the patches are presently
>merged in=20
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/acme/linux=2Egit/log/=
?h=3Dtmp=2Eperf/core,
>
>can you please suggest how can we go about this change ?

I'll fix it up here,

Thanks for the patch=2E

- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
