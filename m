Received: from out28-133.mail.aliyun.com (out28-133.mail.aliyun.com [115.124.28.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AA3CD8A4;
	Fri, 27 Mar 2026 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599000; cv=none; b=aq4gcyrsQ9QmFh5l34hmIHOefO7SyCGyBbVQ+IQ2DU8jfx5OMC3iKzcp56Mq0xWYTiI8Hur8n5pGlFl32GLCGF9OV7VljnuKvk7e7B8+38MXy57FcEWwKWFodjgSsbKTdZCwWWFHDMYlTwwMmuAB0zYfn/aiBLbdV0MGfJ2Nanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599000; c=relaxed/simple;
	bh=jekUoRM6xAl2PNYqAev73aVpcZjT/bi7bFrfh8DgPEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIRkDyShtq3HOBB5KdjGmUjMcvfjAJV7YQaCQJXZMfxdjN4KW8pCohHP6cG4nNRFo0lvTFXotTkANLzOyeQFXpv1sbtXsQ4cd0cf5h4MXn9/abxMdDl1VW7vrZDR2fKE8bKvqW+UqdrLxHgP2mFoBK/1MzKtUm3BJvZkjdP301w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436463|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.00828711-0.000511096-0.991202;FP=5927386199564553616|3|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=fuhao@open-hieco.net;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.h.LaOdR_1774598985;
Received: from higon..(mailfrom:fuhao@open-hieco.net fp:SMTPD_---.h.LaOdR_1774598985 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 16:09:51 +0800
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
	Fu Hao <fuhao@open-hieco.net>
Subject: [PATCH 4/8] perf/x86/uncore: Add L3 PMU support for Hygon family 18h model 6h
Date: Fri, 27 Mar 2026 16:09:38 +0800
Message-Id: <dc67a820436e1fd18c0d2c25f028155d123da3f4.1774595153.git.fuhao@open-hieco.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774595153.git.fuhao@open-hieco.net>
References: <cover.1774595153.git.fuhao@open-hieco.net>
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
---
 arch/x86/events/amd/uncore.c      | 48 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/perf_event.h |  8 ++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dd956cfca..e71d9e784 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -308,6 +308,14 @@ amd_f17h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
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
@@ -359,6 +367,8 @@ DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3
 DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(rdwrmask,	rdwrmask,	"config:8-9");		   /* PerfMonV2 UMC */
+DEFINE_UNCORE_FORMAT_ATTR(slicemask4,	slicemask,	"config:28-31");	   /* F18h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(threadmask32,	threadmask,	"config:32-63");	   /* F18h L3 */
 
 /* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
@@ -388,6 +398,12 @@ static struct attribute *amd_f17h_uncore_l3_format_attr[] = {
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
@@ -413,6 +429,12 @@ static struct attribute_group amd_f17h_uncore_l3_format_group = {
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
@@ -442,6 +464,11 @@ static const struct attribute_group *amd_uncore_l3_attr_update[] = {
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
@@ -820,6 +847,12 @@ static int amd_uncore_l3_event_init(struct perf_event *event)
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
@@ -877,7 +910,8 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu->rdpmc_base = RDPMC_BASE_LLC;
 	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
 
-	if (boot_cpu_data.x86 >= 0x17) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    boot_cpu_data.x86 >= 0x17) {
 		*l3_attr++ = &format_attr_event8.attr;
 		*l3_attr++ = &format_attr_umask8.attr;
 		*l3_attr++ = boot_cpu_data.x86 >= 0x19 ?
@@ -904,6 +938,18 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
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
index ff5acb8b1..404752601 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -89,6 +89,14 @@
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

