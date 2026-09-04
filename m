Received: from out198-12.us.a.mail.aliyun.com (out198-12.us.a.mail.aliyun.com [47.90.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01857080D;
	Fri,  4 Sep 2026 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491566; cv=none; b=PFKtXf/ZT36iecNGPldn8iwzmBhjyliVJdAIR3qNQhcrRF2HGQ5KJr8XhsnTFoLXt7VHa4WgF1/o29VsJwqP6/K91p75mW49hKR98EL5DCR4k6fv81k8y0Wsq94yCjtK3MumWmr2nZMH11PvnN1zly8TDyTEJWpaUA5O4aDSzyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491566; c=relaxed/simple;
	bh=7VDLthI2uZIfqh43XHAT4dnHqFIJAeZHKF+9HPx/EiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6ZCl/lkgAqXYwYRQ2JDE6SpQu246QogmFgl8lehZzaTXBOTMK/mbwW+D5Kb2p+OIxI7mVbIl6jvnGxkQ8HBOe708WUeHmVOxdtyGv5F+x5SQfRKBJFx+GdFdKvH0178DqIwEE26EZ2oxpo+MmKYCuQzOpmJ/u36ZeAPr1cxFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436402|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00867014-0.000596182-0.990734;FP=5927377541413799312|1|1|2|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=fuhao@open-hieco.net;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.j531Mf2_1788491537;
Received: from higon..(mailfrom:fuhao@open-hieco.net fp:SMTPD_---.j531Mf2_1788491537 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 11:12:25 +0800
From: Fu Hao <fuhao@open-hieco.net>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tingyin.duan@gmail.com,
	Fu Hao <fuhao@open-hieco.net>
Subject: [PATCH v5 4/5] perf/x86/uncore: Add L3 PMU support for Hygon family 18h model 6h
Date: Fri,  4 Sep 2026 11:12:12 +0800
Message-Id: <d45936ac077e5a62dae6f40edcafa13644620ed5.1788404433.git.fuhao@open-hieco.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788404433.git.fuhao@open-hieco.net>
References: <cover.1788404433.git.fuhao@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the L3 PMU slicemask and threadmask for Hygon family 18h
model 6h processor.

Signed-off-by: Fu Hao <fuhao@open-hieco.net>
Tested-by: Tingyin Duan <tingyin.duan@gmail.com>
---
 arch/x86/events/amd/uncore.c      | 48 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/perf_event.h |  8 ++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dbc00b6dd..fa7a1c70e 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -309,6 +309,14 @@ amd_f17h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	       attr->mode : 0;
 }
 
+static umode_t
+hygon_f18h_m6h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return boot_cpu_data.x86 == 0x18 &&
+	       boot_cpu_data.x86_model >= 0x6 && boot_cpu_data.x86_model <= 0xf	?
+	       attr->mode : 0;
+}
+
 static umode_t
 amd_f19h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -360,6 +368,8 @@ DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3
 DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(rdwrmask,	rdwrmask,	"config:8-9");		   /* PerfMonV2 UMC */
+DEFINE_UNCORE_FORMAT_ATTR(slicemask4,	slicemask,	"config:28-31");	   /* F18h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(threadmask32,	threadmask,	"config:32-63");	   /* F18h L3 */
 
 /* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
@@ -389,6 +399,12 @@ static struct attribute *amd_f17h_uncore_l3_format_attr[] = {
 	NULL,
 };
 
+/* F18h M06h unique L3 attributes */
+static struct attribute *hygon_f18h_m6h_uncore_l3_format_attr[] = {
+	&format_attr_slicemask4.attr,	/* slicemask */
+	NULL,
+};
+
 /* F19h unique L3 attributes */
 static struct attribute *amd_f19h_uncore_l3_format_attr[] = {
 	&format_attr_coreid.attr,	/* coreid */
@@ -414,6 +430,12 @@ static struct attribute_group amd_f17h_uncore_l3_format_group = {
 	.is_visible = amd_f17h_uncore_is_visible,
 };
 
+static struct attribute_group hygon_f18h_m6h_uncore_l3_format_group = {
+	.name = "format",
+	.attrs = hygon_f18h_m6h_uncore_l3_format_attr,
+	.is_visible = hygon_f18h_m6h_uncore_is_visible,
+};
+
 static struct attribute_group amd_f19h_uncore_l3_format_group = {
 	.name = "format",
 	.attrs = amd_f19h_uncore_l3_format_attr,
@@ -443,6 +465,11 @@ static const struct attribute_group *amd_uncore_l3_attr_update[] = {
 	NULL,
 };
 
+static const struct attribute_group *hygon_uncore_l3_attr_update[] = {
+	&hygon_f18h_m6h_uncore_l3_format_group,
+	NULL,
+};
+
 static const struct attribute_group *amd_uncore_umc_attr_groups[] = {
 	&amd_uncore_attr_group,
 	&amd_uncore_umc_format_group,
@@ -821,6 +848,12 @@ static int amd_uncore_l3_event_init(struct perf_event *event)
 		mask = AMD64_L3_F19H_THREAD_MASK | AMD64_L3_EN_ALL_SLICES |
 		       AMD64_L3_EN_ALL_CORES;
 
+	if (boot_cpu_data.x86 == 0x18 &&
+	    boot_cpu_data.x86_model >= 0x6 &&
+	    boot_cpu_data.x86_model <= 0xf)
+		mask = ((config & HYGON_L3_SLICE_MASK) ? : HYGON_L3_SLICE_MASK) |
+		       ((config & HYGON_L3_THREAD_MASK) ? : HYGON_L3_THREAD_MASK);
+
 	hwc->config |= mask;
 
 	return 0;
@@ -878,7 +911,8 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu->rdpmc_base = RDPMC_BASE_LLC;
 	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
 
-	if (boot_cpu_data.x86 >= 0x17) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    boot_cpu_data.x86 >= 0x17) {
 		*l3_attr++ = &format_attr_event8.attr;
 		*l3_attr++ = &format_attr_umask8.attr;
 		*l3_attr++ = boot_cpu_data.x86 >= 0x19 ?
@@ -905,6 +939,18 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		.module		= THIS_MODULE,
 	};
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
+	    boot_cpu_data.x86 == 0x18) {
+		*l3_attr++ = &format_attr_event8.attr;
+		*l3_attr++ = &format_attr_umask8.attr;
+		if (boot_cpu_data.x86_model >= 0x6 && boot_cpu_data.x86_model <= 0xf) {
+			*l3_attr++ = &format_attr_threadmask32.attr;
+			pmu->pmu.attr_update = hygon_uncore_l3_attr_update;
+		} else {
+			*l3_attr++ = &format_attr_threadmask8.attr;
+		}
+	}
+
 	if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
 		free_percpu(pmu->ctx);
 		pmu->ctx = NULL;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1eb13673e..f448e93ec 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -91,6 +91,14 @@
 #define AMD64_L3_COREID_MASK				\
 	(0x7ULL << AMD64_L3_COREID_SHIFT)
 
+#define HYGON_L3_SLICE_SHIFT				28
+#define HYGON_L3_SLICE_MASK				\
+	(0xFULL << HYGON_L3_SLICE_SHIFT)
+
+#define HYGON_L3_THREAD_SHIFT				32
+#define HYGON_L3_THREAD_MASK				\
+	(0xFFFFFFFFULL << HYGON_L3_THREAD_SHIFT)
+
 #define X86_RAW_EVENT_MASK		\
 	(ARCH_PERFMON_EVENTSEL_EVENT |	\
 	 ARCH_PERFMON_EVENTSEL_UMASK |	\
-- 
2.34.1

