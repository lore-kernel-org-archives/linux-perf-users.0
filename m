From: Tan Xiaojun <tanxiaojun@huawei.com>
Subject: [RFC v3 4/5] drivers: perf: add some arm spe events
Date: Sat, 23 Nov 2019 18:11:17 +0800
Message-ID: <20191123101118.12635-5-tanxiaojun@huawei.com>
References: <20191123101118.12635-1-tanxiaojun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191123101118.12635-1-tanxiaojun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com, yao.jin@linux.intel.com, tmricht@linux.ibm.com, brueckner@linux.ibm.com, songliubraving@fb.com, gregkh@linuxfoundation.org, kim.phillips@arm.com, James.Clark@arm.com, jeremy.linton@arm.com
Cc: gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, tanxiaojun@huawei.com, huawei.libin@huawei.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Add some definitions of arm spe events, these are precise ip events.
Displayed in the perf list as follows:

---------------------------------------------------------------------
...
arm_spe_0//                                        [Kernel PMU event]
arm_spe_0/branch_miss/                             [Kernel PMU event]
arm_spe_0/llc_miss/                                [Kernel PMU event]
arm_spe_0/remote_access/                           [Kernel PMU event]
arm_spe_0/tlb_miss/                                [Kernel PMU event]
...
---------------------------------------------------------------------

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 drivers/perf/arm_spe_pmu.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 4e4984a55cd1..4df9abdb2255 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -161,6 +161,9 @@ static struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_pct_enable_CFG		config	/* PMSCR_EL1.PCT */
 #define ATTR_CFG_FLD_pct_enable_LO		2
 #define ATTR_CFG_FLD_pct_enable_HI		2
+#define ATTR_CFG_FLD_event_CFG			config	/* ARM SPE EVENTS */
+#define ATTR_CFG_FLD_event_LO			3
+#define ATTR_CFG_FLD_event_HI			6
 #define ATTR_CFG_FLD_jitter_CFG			config	/* PMSIRR_EL1.RND */
 #define ATTR_CFG_FLD_jitter_LO			16
 #define ATTR_CFG_FLD_jitter_HI			16
@@ -174,6 +177,11 @@ static struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_store_filter_LO		34
 #define ATTR_CFG_FLD_store_filter_HI		34
 
+#define ARM_SPE_EVENT_LLC_MISS			BIT(0)
+#define ARM_SPE_EVENT_BRANCH_MISS		BIT(1)
+#define ARM_SPE_EVENT_TLB_MISS			BIT(2)
+#define ARM_SPE_EVENT_REMOTE_ACCESS		BIT(3)
+
 #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
 #define ATTR_CFG_FLD_event_filter_LO		0
 #define ATTR_CFG_FLD_event_filter_HI		63
@@ -213,8 +221,43 @@ GEN_PMU_FORMAT_ATTR(load_filter);
 GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
+GEN_PMU_FORMAT_ATTR(event);
+
+static ssize_t
+arm_spe_events_sysfs_show(struct device *dev,
+		struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=0x%03llx\n", pmu_attr->id);
+}
+
+#define ARM_SPE_EVENT_ATTR(name, config) \
+	PMU_EVENT_ATTR(name, arm_spe_event_attr_##name, \
+		       config, arm_spe_events_sysfs_show)
+
+ARM_SPE_EVENT_ATTR(llc_miss, ARM_SPE_EVENT_LLC_MISS);
+ARM_SPE_EVENT_ATTR(branch_miss, ARM_SPE_EVENT_BRANCH_MISS);
+ARM_SPE_EVENT_ATTR(tlb_miss, ARM_SPE_EVENT_TLB_MISS);
+ARM_SPE_EVENT_ATTR(remote_access, ARM_SPE_EVENT_REMOTE_ACCESS);
+
+static struct attribute *arm_spe_pmu_event_attrs[] = {
+	&arm_spe_event_attr_llc_miss.attr.attr,
+	&arm_spe_event_attr_branch_miss.attr.attr,
+	&arm_spe_event_attr_tlb_miss.attr.attr,
+	&arm_spe_event_attr_remote_access.attr.attr,
+	NULL,
+};
+
+static struct attribute_group arm_spe_pmu_event_group = {
+	.name = "events",
+	.attrs	= arm_spe_pmu_event_attrs,
+};
 
 static struct attribute *arm_spe_pmu_formats_attr[] = {
+	&format_attr_event.attr,
 	&format_attr_ts_enable.attr,
 	&format_attr_pa_enable.attr,
 	&format_attr_pct_enable.attr,
@@ -252,6 +295,7 @@ static struct attribute_group arm_spe_pmu_group = {
 };
 
 static const struct attribute_group *arm_spe_pmu_attr_groups[] = {
+	&arm_spe_pmu_event_group,
 	&arm_spe_pmu_group,
 	&arm_spe_pmu_cap_group,
 	&arm_spe_pmu_format_group,
-- 
2.17.1
