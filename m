Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD39DC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25D3610A4
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbhJ0UTQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:19:16 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:38503 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbhJ0UTO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 16:19:14 -0400
Received: by mail-oo1-f45.google.com with SMTP id z11-20020a4a870b000000b002b883011c77so1342846ooh.5;
        Wed, 27 Oct 2021 13:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gs33L1/6raqSK9QUUTnv7TCH3v7KbK1ze/ld1T0DSZo=;
        b=4S3IY6FBnX6P8WFDhrEl9wBUSi5heulG88+x1GvfdLmElMgLR42BToVx1V5rQkTdwU
         IDuzzSiYQaKBsDQVCrqmcyfAogqI9Ql28rQn1Yy73lyYwYwsr86MnOTMlDq4BCaAFR2B
         XqqLNvARZ81KZClF4IzrGqo1+RzDfwNbGo4SrXczPVtaZV1HSWNQZfo88BeJWRYHYhhB
         DE9iOJLnyVVqCIIFhZ/TAs1wTDUvz3hj52BYHvJxNS5T+Rw2WOrzGt0NNy71hEmjJ/BL
         TKitc4cWvmHfVpfAPhrQuMehYxVbh4DAS+ubhESkzA+nFecCM+dqwtPRpKaYz3m4EgTe
         sTkA==
X-Gm-Message-State: AOAM533+s3QBousmoRLumITNKYWJ+Mtqr3HSa9AmU5HQsEO8d5TS7thx
        NZOQsZCOtiFwvOKEeFzzMA==
X-Google-Smtp-Source: ABdhPJxEw8P6AKcB9sJjShdyjp0gatixa3NyoLwxJ4UxIdPPki11tPBo4AKLVK7L57BRHSb04Cq0zg==
X-Received: by 2002:a4a:b48a:: with SMTP id b10mr23855994ooo.24.1635365807099;
        Wed, 27 Oct 2021 13:16:47 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id f10sm415332otc.26.2021.10.27.13.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:16:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v12 3/5] arm64: perf: Add userspace counter access disable switch
Date:   Wed, 27 Oct 2021 15:16:39 -0500
Message-Id: <20211027201641.2076427-4-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211027201641.2076427-1-robh@kernel.org>
References: <20211027201641.2076427-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Like x86, some users may want to disable userspace PMU counter
altogether. Add a sysctl 'perf_user_access' file to control userspace
counter access. The default is '0' which is disabled. Writing '1'
enables access.

Note that x86 supports globally enabling user access by writing '2' to
/sys/bus/event_source/devices/cpu/rdpmc. As there's not existing
userspace support to worry about, this shouldn't be necessary for Arm.
It could be added later if the need arises.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-perf-users@vger.kernel.org
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v11:
 - Move custom handler to next patch
v10:
 - Add documentation
 - Use a custom handler (needed on the next patch)
v9:
 - Use sysctl instead of sysfs attr
 - Default to disabled
v8:
 - New patch
---
 Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++++
 arch/arm64/kernel/perf_event.c              | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

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
index b4044469527e..6ae20c4217af 100644
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
@@ -1104,6 +1106,19 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	return probe.present ? 0 : -ENODEV;
 }
 
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
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 			  int (*map_event)(struct perf_event *event),
 			  const struct attribute_group *events,
@@ -1136,6 +1151,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
 			caps : &armv8_pmuv3_caps_attr_group;
 
+	register_sysctl("kernel", armv8_pmu_sysctl_table);
+
 	return 0;
 }
 
-- 
2.32.0

