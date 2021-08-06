Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F9C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380E6610CB
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245560AbhHFWvq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 18:51:46 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:41706 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhHFWvq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 18:51:46 -0400
Received: by mail-io1-f46.google.com with SMTP id 188so12821939ioa.8;
        Fri, 06 Aug 2021 15:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWafI0pCjrrfNHxq9438YyHZcLkkHXFc+m0sRuUPdcs=;
        b=ZlHSdzSWXpReP9+DwyCOjIDgW23fv8/oX/9LzHj7lKdhSJafVM7jYtu7E4jFBLaxhw
         vNxyVHu+YIa3bRH1B2priHwvCiWsa7d03weJ5BMm/0Q8gA6W8V+I9n0SC+/ApIJK8vXN
         9494VbPWxkevz9ANQb8hzhqAPDCdk1f+WggHdMsj8vOPm1AUpurLvblXZgWve424UMfn
         FgKiKdAFKovE9WrckpwvSHty4yLjYVjpmTNwpQnJx2d4bOdjO4FROvhSk/gGhTn03lG1
         68CBb8QqkZDS15B2jGfz4j5qhLsAgRj03MII04kdbewoEQWfGIUaeP9RiezzbEKnHYKb
         0KDw==
X-Gm-Message-State: AOAM531VcKE06KSd8ONaABUBShWxGO4yEefAXRTbewLxy0ACbCQ4Y2eA
        khMdpaqxD+ABSOwy1guEww==
X-Google-Smtp-Source: ABdhPJweFO666OdbM/CVxzCJS7O+0EI1W/IrUBQGjvsStdD20D+7wtlIVko7cnv6EYv1bValeWrsnw==
X-Received: by 2002:a5e:d719:: with SMTP id v25mr3510626iom.124.1628290288763;
        Fri, 06 Aug 2021 15:51:28 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id x11sm5670338ilu.3.2021.08.06.15.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:51:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v9 1/3] arm64: perf: Add userspace counter access disable switch
Date:   Fri,  6 Aug 2021 16:51:21 -0600
Message-Id: <20210806225123.1958497-2-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210806225123.1958497-1-robh@kernel.org>
References: <20210806225123.1958497-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Like x86, some users may want to disable userspace PMU counter
altogether. Add a sysctl 'perf_user_access' file to control userspace
counter access. The default is '0' which is disabled. Writing '1'
enables access.

Note that x86 also supports writing '2' to globally enable user access.
As there's not existing userspace support to worry about, this shouldn't
be necessary for Arm. It could be added later if the need arises.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v9:
 - Use sysctl instead of sysfs attr
 - Default to disabled
v8:
 - New patch

---
 arch/arm64/kernel/perf_event.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index d07788dad388..74f77b68f5f0 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -286,6 +286,21 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(long, "config1:0");
 
+static int sysctl_perf_user_access __read_mostly;
+
+static struct ctl_table armv8_pmu_sysctl_table[] = {
+	{
+		.procname       = "perf_user_access",
+		.data		= &sysctl_perf_user_access,
+		.maxlen		= sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
 static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
 	return event->attr.config1 & 0x1;
@@ -1136,6 +1151,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
 			caps : &armv8_pmuv3_caps_attr_group;
 
+	register_sysctl("kernel", armv8_pmu_sysctl_table);
+
 	return 0;
 }
 
-- 
2.30.2

