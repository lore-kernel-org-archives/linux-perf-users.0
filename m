Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7FCC43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 17:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbiFOR5M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiFOR5M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 13:57:12 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261D544C9
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 10:57:11 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o73so9308074qke.7
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:mime-version;
        bh=lUE1wMAUhn3kDY9KTIDAYl8As1JumgEjfydHKTXBoMA=;
        b=UWiV+IKLfovZ0BMALPQiVyjiWYDSwQjf/lH3EyiJcqf1sGrFa9gWqv1UgYKIEotxDK
         9pfzIcBtAQoovKOvqxNUaBKSI1Fg5CEL0GGtA8Tpq3gqQt4haQyD0qeeDfzPxSlzcX9Q
         rv6g+VqLqiM0sbc03LRWTiXOe5rhouubMjflU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version;
        bh=lUE1wMAUhn3kDY9KTIDAYl8As1JumgEjfydHKTXBoMA=;
        b=oDSjnrNPZk9JjjwfF4bQQC+YsSq+mrFgYZqTtwO3+gE9j0PcYs1jJtI2PBRNwNR7ZE
         9yKAA61IS7uPdJYlsKn2FRUzqia5a2ihaRdF+LlvJUtIh5u/FkV7ZwSGmQDHHq+/unj/
         7CQcEt3iJP6YJQB7GTClo0MLFxtMf/8chSMJM2ftuHnD5pMJRd9otsKA4HGUjbq9/3Kf
         N/McRaMfCIKwykO6UVxT5+S9Y76rxZLzkpbd9evX3M7AYZcRGUfLFY+moFI8by/PbexC
         NZHyTfzrkZfwxXtHM1uEhdi5Yq74+1BJWQznrwQzCCF0JtzWsi1eNHPfjTdFDAMSMXvl
         4PZA==
X-Gm-Message-State: AJIora9MPC83zKrN2oALmKHQmSZl80FcC8RPGIPFpVGb/NHXX5+IDeqj
        Bf8etx16NCq5VXb3le6lwx8GKQ==
X-Google-Smtp-Source: AGRyM1vMLNv5LCOOU21DkgjrnWPbkBrClGJuiXoZyFYP/yNZz3BJ/0L0FVWKnHb/Puwp1Jk0RvbucQ==
X-Received: by 2002:a37:6b47:0:b0:6a7:48d:e64a with SMTP id g68-20020a376b47000000b006a7048de64amr729185qkc.112.1655315830505;
        Wed, 15 Jun 2022 10:57:10 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id cc23-20020a05622a411700b00304f98ad3c1sm9327430qtb.29.2022.06.15.10.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:57:09 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 15 Jun 2022 13:57:03 -0400 (EDT)
To:     linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [perf] why is /proc/sys/kernel/perf_user_access ARM64 only?
Message-ID: <30d95df2-c3b-b3e3-d65e-c6be0355fb1@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


Just wasted a lot of time tracking down why rdpmc() event reading wasn't 
working on an ARM64 machine.

It turns out ARM64 has added a custom
	"/proc/sys/kernel/perf_user_access"
to control rdpmc access, but only on ARM64.
	e2012600810c9ded81f6f63a8d04781be3c300ad

Why is this ARM64-only?  Why isn't this generic perf infrastructure?
How is this different from the existing
	/sys/bus/event_source/devices/cpu/rdpmc
tooling?

Also, when user events are disabled, why is the ARMv8 PMU not disabling
the cap_user_rdpmc bit in the perf mmap() page?

rdpmc was trouble before, but now it's an even bigger 
architecture-dependent mess just trying to figure out if the feature is 
enabled or not.

Vince
