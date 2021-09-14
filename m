Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A56C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 20:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88EB061168
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 20:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhINUtX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:49:23 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34634 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhINUtX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 16:49:23 -0400
Received: by mail-ot1-f51.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso444452otp.1;
        Tue, 14 Sep 2021 13:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSLH2PKNJHJiOXUml/UMr4IbcsQFO5Do6RK1J+6XzDg=;
        b=ENf2YGiYL1MoLOi5FfZ6scD0ykZtbLjuNoopGW92SE184SYIK1D46HmqqY9dB1tJh2
         KbwG2UhXa8tcwGaxw8OkupF145t7Pmnr6x5efXohczdrvduoXhT4Sgwj0lHUoGhX31xp
         NjxHTZ9UavlDlAc+uk1zjk8HVz+hMAExnP516HnFQu7wL4ESFh2SBwo7cPBF+q1MfcLo
         aT8VIeSuiMBM7ySPsCjVh5Onl1jTcWjgndWFUJ/QbsW0QBaCdp5gSpJYe5JE2H/ylkyT
         afQLn3ofnF/54uukVMmMl1g0J6hd8mo9mY2hrtvskK4WPs1hMl9FAXDY/HgMrWSEtvO0
         ZGsQ==
X-Gm-Message-State: AOAM5338SbLvJM9UXO1XuRQdJf69QB6ZlNAX4QCcDveaK4JfStuhWJvs
        cq1wc9NmfCR7GhbrhZVkKQ==
X-Google-Smtp-Source: ABdhPJwijdoM3VZ7InIf0R1CBiB7dwm8lmTGO/TIgJP9Z1Twe5rxNNJVFg4BOdjky3KFjvXP4UuVTA==
X-Received: by 2002:a9d:1469:: with SMTP id h96mr16835050oth.82.1631652485041;
        Tue, 14 Sep 2021 13:48:05 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id y14sm2883236oti.69.2021.09.14.13.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 13:48:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v10 3/5] arm64: perf: Add userspace counter access disable switch
Date:   Tue, 14 Sep 2021 15:47:58 -0500
Message-Id: <20210914204800.3945732-4-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914204800.3945732-1-robh@kernel.org>
References: <20210914204800.3945732-1-robh@kernel.org>
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

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-perf-users@vger.kernel.org
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v10:
 - Add documentation
 - Use a custom handler (needed on the next patch)
v9:
 - Use sysctl instead of sysfs attr
 - Default to disabled
v8:
 - New patch
---
 Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++
 arch/arm64/kernel/perf_event.c              | 27 +++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 426162009ce9..346a0dba5703 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -905,6 +905,17 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
 The default value is 8.
 
 
+perf_user_access (arm64 only)
+=================================
+
+Controls user space access for reading perf event counters. When set to 1,
+user space can read performance monitor counter registers directly.
+
+The default value is 0 (access disabled).
+
+See Documentation/arm64/perf.rst for more information.
+
+
 pid_max
 =======
 
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index b4044469527e..a8f8dd741aeb 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -286,6 +286,8 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(long, "config1:0");
 
+static int sysctl_perf_user_access __read_mostly;
+
 static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
 	return event->attr.config1 & 0x1;
@@ -1104,6 +1106,29 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	return probe.present ? 0 : -ENODEV;
 }
 
+int armv8pmu_proc_user_access_handler(struct ctl_table *table, int write,
+                void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret || !write || sysctl_perf_user_access)
+		return ret;
+
+	return 0;
+}
+
+static struct ctl_table armv8_pmu_sysctl_table[] = {
+	{
+		.procname       = "perf_user_access",
+		.data		= &sysctl_perf_user_access,
+		.maxlen		= sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= armv8pmu_proc_user_access_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 			  int (*map_event)(struct perf_event *event),
 			  const struct attribute_group *events,
@@ -1136,6 +1161,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
 			caps : &armv8_pmuv3_caps_attr_group;
 
+	register_sysctl("kernel", armv8_pmu_sysctl_table);
+
 	return 0;
 }
 
-- 
2.30.2

