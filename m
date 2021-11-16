Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8264CC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 14:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D7461B48
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 14:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhKPOHy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbhKPOHy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Nov 2021 09:07:54 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468EAC061570;
        Tue, 16 Nov 2021 06:04:57 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id u16so13775835qvk.4;
        Tue, 16 Nov 2021 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=mZinczTsHmp3D5RmZy6kAXCseVBqZP/LezZQ7PBZdU8=;
        b=Y8WGB5FGDhBOdoEpW1Bfmjkz/y9U3FNU1gPxM6ZoC92rTtlSGbjw4qjRHhKwhjvKtb
         tbHdFc736irq8fhJsBAamoKxj9Hh9b56UAU1QGQwz/wandS4R/SRXZTlG1IN9IK6Hcnh
         fK4Ia5mLu+o18+h/CPobygBHHzkypE66y4q5J0XZhHCipqeHs7MwtjDmXwLRorxIaecB
         xrMDerII3eY4zlaglamRvf76aH6NhfZfZodTs34LHcS26ZkBAbJ1U23xJvZ30vBWdm9H
         cpe9qUVlSyTH+Jm46R/4pftvIFSCQ1f5hhqvV27AiLsWnXi1acsEGsXHXHQyshY8vVfa
         Rv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=mZinczTsHmp3D5RmZy6kAXCseVBqZP/LezZQ7PBZdU8=;
        b=UwRvg9O1emJXotXfZfsOBixqI1dsYeZ0Om/d5X++Qa0SyBCyHtMby5Gp8vNTcKx3BX
         4Qe3Dqo/LyiqkIG7qp9q6sl+mRxa/NCDmrYYlLe9E8qGR2A4kyh3bUWYCxz2PWw/PVnN
         X2w/4Reu9ZhpOmO5P24+rCsKjU0xIYc2/h9gKqmloXQBe6B9am5MQQaRHFiLgfIrh54w
         BA/YGcAT8Oh+wSFBJuQrEac29130Z/FxFzOeGK4HLCj39CLz6rITFdSn+uJoJhansh+j
         0StMm1sSoJ3xVKVXWy/0/mBu6tQ4r8UOrwGPDSvm/56v+lBcwIO7SSteHON/fbbNmM0P
         bAIA==
X-Gm-Message-State: AOAM530d/CVUwXmFDL/mVX+IQLiHeusJ1gJVsej3zGMwVMwEjrfiNHku
        IAl6Exr32AWz+6BCQtZonx0=
X-Google-Smtp-Source: ABdhPJx+Dw6JA9Kvd/vZcCFCB88hFI6xtddOiXVg0QKnyINhgQGMIVHn3k1C0aDHuPNSKMCdkL6DPg==
X-Received: by 2002:a05:6214:c42:: with SMTP id r2mr45911397qvj.53.1637071496430;
        Tue, 16 Nov 2021 06:04:56 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i6sm8936833qkn.26.2021.11.16.06.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 06:04:55 -0800 (PST)
Date:   Tue, 16 Nov 2021 11:03:54 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Marco Elver <elver@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabian Hemmer <copy@copy.sh>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] perf test: Add basic stress test for sigtrap handling
User-Agent: K-9 Mail for Android
In-Reply-To: <YZO4zVusjQ+zu9PJ@elver.google.com>
References: <20211115112822.4077224-1-elver@google.com> <YZOpSVOCXe0zWeRs@kernel.org> <YZO4zVusjQ+zu9PJ@elver.google.com>
Message-ID: <0683D134-7465-46A8-A3FF-2E2D9131BB3D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On November 16, 2021 10:57:33 AM GMT-03:00, Marco Elver <elver@google=2Eco=
m> wrote:
>On Tue, Nov 16, 2021 at 09:51AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Mon, Nov 15, 2021 at 12:28:23PM +0100, Marco Elver escreveu:
>> > Add basic stress test for sigtrap handling as a perf tool built-in te=
st=2E
>> > This allows sanity checking the basic sigtrap functionality from with=
in
>> > the perf tool=2E
>>=20
>> Works as root:
>>=20
>> [root@five ~]# perf test sigtrap
>> 73: Sigtrap                                                         : O=
k
>> [root@five ~]
>>=20
>> Not for !root:
>[=2E=2E=2E]
>> FAILED sys_perf_event_open(): Permission denied
>> test child finished with -1
>> ---- end ----
>> Sigtrap: FAILED!
>
>Ah, that shouldn't be the case=2E It's missing exclude_kernel/hv, and thi=
s
>test should work just fine as non-root=2E Please squash the below as well=
=2E
>Let me know if you'd like a v2=2E

I'll squash

>
>Ack for your change printing errors as well=2E
>
>Thanks,
>-- Marco
>
>------ >8 ------
>
>From: Marco Elver <elver@google=2Ecom>
>Date: Tue, 16 Nov 2021 14:52:18 +0100
>Subject: [PATCH] fixup! perf test: Add basic stress test for sigtrap hand=
ling
>
>Exclude kernel/hypervisor so the test can run as non-root=2E
>
>Signed-off-by: Marco Elver <elver@google=2Ecom>
>---
> tools/perf/tests/sigtrap=2Ec | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/tools/perf/tests/sigtrap=2Ec b/tools/perf/tests/sigtrap=2Ec
>index febfa1609356=2E=2Ee566f855bf74 100644
>--- a/tools/perf/tests/sigtrap=2Ec
>+++ b/tools/perf/tests/sigtrap=2Ec
>@@ -46,6 +46,8 @@ static struct perf_event_attr make_event_attr(void)
> 		=2Eremove_on_exec =3D 1, /* Required by sigtrap=2E */
> 		=2Esigtrap	=3D 1, /* Request synchronous SIGTRAP on event=2E */
> 		=2Esig_data	=3D TEST_SIG_DATA,
>+		=2Eexclude_kernel =3D 1,
>+		=2Eexclude_hv	=3D 1,
> 	};
> 	return attr;
> }
