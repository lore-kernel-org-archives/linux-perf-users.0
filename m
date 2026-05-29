Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB373F39C8;
	Fri, 29 May 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073121; cv=none; b=bAp9QUIKPLmGPd3/XbNBej+K7l0k0YG44t9cniJWtOlqefS0LSSZqH0uAa04L0UTIqXGc9PL4YfqMPPp4CyltnlAk+Hp2HKTu/+BFBKzs53LaqcZpD0EpRPUZyl1yEHOnQRT38otHGoCzTwPkhP6SM9Z1wcjTH1A1x12xjysN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073121; c=relaxed/simple;
	bh=ALGQmCpwsVKx34+Za/AJKF2HqIAWjst2g4Ih2YoNxeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ym4lp4bkyqunIMkB+4cZxzZJUNuhZbLeHOXEjBMn4OuWow6+HrV82AUATB2tcYi0EgnnlkDPIhoz+iQZbdY0UwTqtvVuInIqJ6cNJc9KOOMBEbbuO33kZAhdnc9BBLktmkM2dMXJyMRt+jDVK+oli97Um6NnB1v6hgyGRVXqg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p0TpU/ZM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p0TpU/ZM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93B87472F;
	Fri, 29 May 2026 09:45:11 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F3DF3F632;
	Fri, 29 May 2026 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780073116; bh=ALGQmCpwsVKx34+Za/AJKF2HqIAWjst2g4Ih2YoNxeM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p0TpU/ZMxNj3ljUd57XZ0SFVLeWHY4ior1Q/YF3mUFnFI6SE4eyRygirpz95YEntV
	 yQZKF9ccxkbND5FmTkIMylQ1E/9JfSmpFOMMz1a3brnYz9DwnU97J6rfZnC1NEL1Nl
	 OT3KpM3iFDX+qOJpexeGuRegya5aC+92F74iR2pg=
Message-ID: <c1d27212-8e2b-4820-bee6-ad7e7de81238@arm.com>
Date: Fri, 29 May 2026 17:44:58 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] perf/arm-cmn: Move struct arm_cmn_hw_event into
 struct hw_perf_event
To: Aviv Bakal <avivb@amazon.com>, will@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, zeev@amazon.com, blakgeof@amazon.com,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>
References: <20260504133923.23373-1-avivb@amazon.com>
 <20260524153848.16334-1-avivb@amazon.com>
 <20260524153848.16334-2-avivb@amazon.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260524153848.16334-2-avivb@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/05/2026 4:38 pm, Aviv Bakal wrote:
> In order to increase CMN_MAX_DIMENSION beyond 12 (required for meshes
> larger than 12x12, such as Graviton5), the arm_cmn_hw_event struct must
> grow. Since it is overlaid on the beginning of hw_perf_event via an
> unsafe cast, increasing its size would violate the static_assert that
> guards against overflowing into the 'target' field.
> 
> Resolve this by moving struct arm_cmn_hw_event into the hw_perf_event
> union as a proper named member, eliminating the cast in to_cmn_hw() and
> making the size reservation explicit. Set CMN_MAX_DIMENSION to 14 to
> accommodate larger mesh topologies.
> 
> Signed-off-by: Aviv Bakal <avivb@amazon.com>
> ---
>   drivers/perf/arm-cmn.c     | 26 +-------------------------
>   include/linux/perf_event.h | 22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f5305c8fdca4..3443b819afed 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -31,13 +31,8 @@
>   #define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
>   #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
>   
> -#define CMN_MAX_DIMENSION		12
> -#define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
>   #define CMN_MAX_DTMS			(CMN_MAX_XPS + (CMN_MAX_DIMENSION - 1) * 4)
>   
> -/* Currently XPs are the node type we can have most of; others top out at 128 */
> -#define CMN_MAX_NODES_PER_EVENT		CMN_MAX_XPS
> -
>   /* The CFG node has various info besides the discovery tree */
>   #define CMN_CFGM_PERIPH_ID_01		0x0008
>   #define CMN_CFGM_PID0_PART_0		GENMASK_ULL(7, 0)
> @@ -148,7 +143,6 @@
>   #define CMN_DT_PMSRR_SS_REQ		BIT(0)
>   
>   #define CMN_DT_NUM_COUNTERS		8
> -#define CMN_MAX_DTCS			4
>   
>   /*
>    * Even in the worst case a DTC counter can't wrap in fewer than 2^42 cycles,
> @@ -595,24 +589,6 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id)
>   static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
>   #endif
>   
> -struct arm_cmn_hw_event {
> -	struct arm_cmn_node *dn;
> -	u64 dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
> -	s8 dtc_idx[CMN_MAX_DTCS];
> -	u8 num_dns;
> -	u8 dtm_offset;
> -
> -	/*
> -	 * WP config registers are divided to UP and DOWN events. We need to
> -	 * keep to track only one of them.
> -	 */
> -	DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
> -
> -	bool wide_sel;
> -	enum cmn_filter_select filter_sel;
> -};
> -static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event, target));
> -
>   #define for_each_hw_dn(hw, dn, i) \
>   	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
>   
> @@ -622,7 +598,7 @@ static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event,
>   
>   static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
>   {
> -	return (struct arm_cmn_hw_event *)&event->hw;
> +	return &event->hw.cmn;
>   }
>   
>   static void arm_cmn_set_index(u64 x[], unsigned int pos, unsigned int val)
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..c38576a8e338 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h

$ scripts/get_maintainer.pl include/linux/perf_event.h
Peter Zijlstra <peterz@infradead.org> (maintainer:PERFORMANCE EVENTS SUBSYSTEM)
Ingo Molnar <mingo@redhat.com> (maintainer:PERFORMANCE EVENTS SUBSYSTEM)
Arnaldo Carvalho de Melo <acme@kernel.org> (maintainer:PERFORMANCE EVENTS SUBSYSTEM)
Namhyung Kim <namhyung@kernel.org> (maintainer:PERFORMANCE EVENTS SUBSYSTEM)
Mark Rutland <mark.rutland@arm.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Jiri Olsa <jolsa@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Ian Rogers <irogers@google.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Adrian Hunter <adrian.hunter@intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
James Clark <james.clark@linaro.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)

> @@ -119,6 +119,7 @@ struct perf_branch_stack {
>   };
>   
>   struct task_struct;
> +struct arm_cmn_node;
>   
>   /*
>    * extra PMU register associated with an event
> @@ -200,6 +201,27 @@ struct hw_perf_event {
>   			u64	conf;
>   			u64	conf1;
>   		};
> +#ifdef CONFIG_ARM_CMN
> +/* Some implementations use a mesh larger than the architectural max of 12 */
> +#define CMN_MAX_DIMENSION		14
> +#define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
> +#define CMN_MAX_NODES_PER_EVENT		CMN_MAX_XPS
> +#define CMN_MAX_DTCS			4

I doubt the maintainers would be too happy to have this degree of random
driver specifics in a core header. Certainly I wouldn't consider it a
great idea myself...

> +		struct arm_cmn_hw_event { /* arm_cmn */
> +			/*
> +			 * CMN PMU event state overlaid on hw_perf_event.
> +			 * Must fit before the 'target' field.
> +			 */
> +			struct arm_cmn_node	*dn;
> +			u64			dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
> +			s8			dtc_idx[CMN_MAX_DTCS];
> +			u8			num_dns;
> +			u8			dtm_offset;
> +			DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
> +			bool			wide_sel;
> +			int			filter_sel;
> +		} cmn;
> +#endif
>   	};
>   	/*
>   	 * If the event is a per task event, this will point to the task in

TBH I'd be tempted to just disable 32-bit compile-testing for now, but
if we're going to do anything "proper" then it's probably about time to
do this:

Thanks,
Robin.

----->8-----
Subject: [PATCH] perf/arm-cmn: Move DTM index data out of hw_perf_event

The amount of data we need to store all the per-DTM counter and
watchpoint allocations is already testing the limits of hw_perf_event,
and future CMNs are only likely to keep growing larger, so move these
arrays out to separate memory allocations. As part of that we can use
an explicit union for allocating cycle counters to dtc_cycles events,
which is arguably nicer anyway.

Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/perf/arm-cmn.c | 89 ++++++++++++++++++++++++++++--------------
  1 file changed, 59 insertions(+), 30 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 6e5cc4086a9e..470f6a82502e 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -598,17 +598,14 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
  
  struct arm_cmn_hw_event {
  	struct arm_cmn_node *dn;
-	u64 dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
+	union {
+		u64 *dtm_idx;
+		int cc_idx;
+	};
+	unsigned long *wp_idx;
  	s8 dtc_idx[CMN_MAX_DTCS];
  	u8 num_dns;
  	u8 dtm_offset;
-
-	/*
-	 * WP config registers are divided to UP and DOWN events. We need to
-	 * keep to track only one of them.
-	 */
-	DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
-
  	bool wide_sel;
  	enum cmn_filter_select filter_sel;
  };
@@ -626,25 +623,42 @@ static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
  	return (struct arm_cmn_hw_event *)&event->hw;
  }
  
-static void arm_cmn_set_index(u64 x[], unsigned int pos, unsigned int val)
+static void arm_cmn_set_dtm_idx(struct arm_cmn_hw_event *hw, unsigned int pos, unsigned int val)
  {
-	x[pos / 32] |= (u64)val << ((pos % 32) * 2);
+	hw->dtm_idx[pos / 32] |= (u64)val << ((pos % 32) * 2);
  }
  
-static unsigned int arm_cmn_get_index(u64 x[], unsigned int pos)
+static unsigned int arm_cmn_get_dtm_idx(struct arm_cmn_hw_event *hw, unsigned int pos)
  {
-	return (x[pos / 32] >> ((pos % 32) * 2)) & 3;
+	return (hw->dtm_idx[pos / 32] >> ((pos % 32) * 2)) & 3;
  }
  
-static void arm_cmn_set_wp_idx(unsigned long *wp_idx, unsigned int pos, bool val)
+static u64 *arm_cmn_alloc_dtm_idx(void)
+{
+	return kzalloc(DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64), GFP_KERNEL);
+}
+
+static void arm_cmn_set_wp_idx(struct arm_cmn_hw_event *hw, unsigned int pos, bool val)
  {
  	if (val)
-		set_bit(pos, wp_idx);
+		set_bit(pos, hw->wp_idx);
  }
  
-static unsigned int arm_cmn_get_wp_idx(unsigned long *wp_idx, unsigned int pos)
+static unsigned int arm_cmn_get_wp_idx(struct arm_cmn_hw_event *hw, unsigned int pos)
  {
-	return test_bit(pos, wp_idx);
+	return test_bit(pos, hw->wp_idx);
+}
+
+static unsigned long *arm_cmn_alloc_wp_idx(void)
+{
+	return bitmap_zalloc(CMN_MAX_XPS, GFP_KERNEL);
+}
+
+static void arm_cmn_clear_idx(struct arm_cmn_hw_event *hw)
+{
+	memset(hw->dtm_idx, 0, DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64));
+	if (hw->wp_idx)
+		memset(hw->wp_idx, 0, CMN_MAX_XPS);
  }
  
  struct arm_cmn_event_attr {
@@ -1377,7 +1391,7 @@ static int arm_cmn_get_assigned_wp_idx(struct perf_event *event,
  				       struct arm_cmn_hw_event *hw,
  				       unsigned int pos)
  {
-	return CMN_EVENT_EVENTID(event) + arm_cmn_get_wp_idx(hw->wp_idx, pos);
+	return CMN_EVENT_EVENTID(event) + arm_cmn_get_wp_idx(hw, pos);
  }
  
  static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
@@ -1388,7 +1402,7 @@ static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
  	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
  
  	dtm->wp_event[wp_idx] = hw->dtc_idx[dtc];
-	arm_cmn_set_wp_idx(hw->wp_idx, pos, wp_idx - CMN_EVENT_EVENTID(event));
+	arm_cmn_set_wp_idx(hw, pos, wp_idx - CMN_EVENT_EVENTID(event));
  }
  
  static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
@@ -1459,7 +1473,7 @@ static u64 arm_cmn_read_dtm(struct arm_cmn *cmn, struct arm_cmn_hw_event *hw,
  			dtm = &cmn->dtms[dn->dtm] + hw->dtm_offset;
  			reg = readq_relaxed(dtm->base + offset);
  		}
-		dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
+		dtm_idx = arm_cmn_get_dtm_idx(hw, i);
  		count += (u16)(reg >> (dtm_idx * 16));
  	}
  	return count;
@@ -1506,7 +1520,7 @@ static void arm_cmn_event_read(struct perf_event *event)
  	unsigned long flags;
  
  	if (CMN_EVENT_TYPE(event) == CMN_TYPE_DTC) {
-		delta = arm_cmn_read_cc(cmn->dtc + hw->dtc_idx[0]);
+		delta = arm_cmn_read_cc(cmn->dtc + hw->cc_idx);
  		local64_add(delta, &event->count);
  		return;
  	}
@@ -1573,7 +1587,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
  	int i;
  
  	if (type == CMN_TYPE_DTC) {
-		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
+		struct arm_cmn_dtc *dtc = cmn->dtc + hw->cc_idx;
  
  		writel_relaxed(CMN_DT_DTC_CTL_DT_EN | CMN_DT_DTC_CTL_CG_DISABLE,
  			       dtc->base + CMN_DT_DTC_CTL);
@@ -1591,7 +1605,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
  			writeq_relaxed(mask, base + CMN_DTM_WPn_MASK(wp_idx));
  		}
  	} else for_each_hw_dn(hw, dn, i) {
-		int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
+		int dtm_idx = arm_cmn_get_dtm_idx(hw, i);
  
  		arm_cmn_set_event_sel_lo(dn, dtm_idx, CMN_EVENT_EVENTID(event),
  					 hw->wide_sel);
@@ -1607,7 +1621,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
  	int i;
  
  	if (type == CMN_TYPE_DTC) {
-		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
+		struct arm_cmn_dtc *dtc = cmn->dtc + hw->cc_idx;
  
  		dtc->cc_active = false;
  		writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
@@ -1620,7 +1634,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
  			writeq_relaxed(~0ULL, base + CMN_DTM_WPn_VAL(wp_idx));
  		}
  	} else for_each_hw_dn(hw, dn, i) {
-		int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
+		int dtm_idx = arm_cmn_get_dtm_idx(hw, i);
  
  		arm_cmn_set_event_sel_lo(dn, dtm_idx, 0, hw->wide_sel);
  	}
@@ -1764,6 +1778,14 @@ static enum cmn_filter_select arm_cmn_filter_sel(const struct arm_cmn *cmn,
  }
  
  
+static void arm_cmn_event_destroy(struct perf_event *event)
+{
+	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
+
+	kfree(hw->dtm_idx);
+	bitmap_free(hw->wp_idx);
+}
+
  static int arm_cmn_event_init(struct perf_event *event)
  {
  	struct arm_cmn *cmn = to_cmn(event->pmu);
@@ -1788,6 +1810,11 @@ static int arm_cmn_event_init(struct perf_event *event)
  	if (type == CMN_TYPE_DTC)
  		return arm_cmn_validate_group(cmn, event);
  
+	event->destroy = arm_cmn_event_destroy;
+	hw->dtm_idx = arm_cmn_alloc_dtm_idx();
+	if (!hw->dtm_idx)
+		return -ENOMEM;
+
  	eventid = CMN_EVENT_EVENTID(event);
  	/* For watchpoints we need the actual XP node here */
  	if (type == CMN_TYPE_WP) {
@@ -1798,6 +1825,9 @@ static int arm_cmn_event_init(struct perf_event *event)
  		/* ...but the DTM may depend on which port we're watching */
  		if (cmn->multi_dtm)
  			hw->dtm_offset = CMN_EVENT_WP_DEV_SEL(event) / 2;
+		hw->wp_idx = arm_cmn_alloc_wp_idx();
+		if (!hw->wp_idx)
+			return -ENOMEM;
  	} else if (type == CMN_TYPE_XP &&
  		   (cmn->part == PART_CMN700 || cmn->part == PART_CMN_S3)) {
  		hw->wide_sel = true;
@@ -1848,7 +1878,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
  
  	while (i--) {
  		struct arm_cmn_dtm *dtm = &cmn->dtms[hw->dn[i].dtm] + hw->dtm_offset;
-		unsigned int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
+		unsigned int dtm_idx = arm_cmn_get_dtm_idx(hw, i);
  
  		if (type == CMN_TYPE_WP) {
  			int wp_idx = arm_cmn_get_assigned_wp_idx(event, hw, i);
@@ -1862,8 +1892,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
  		dtm->pmu_config_low &= ~CMN__PMEVCNT_PAIRED(dtm_idx);
  		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
  	}
-	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
-	memset(hw->wp_idx, 0, sizeof(hw->wp_idx));
+	arm_cmn_clear_idx(hw);
  
  	for_each_hw_dtc_idx(hw, j, idx)
  		cmn->dtc[j].counters[idx] = NULL;
@@ -1883,7 +1912,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
  				return -ENOSPC;
  
  		cmn->dtc[i].cycles = event;
-		hw->dtc_idx[0] = i;
+		hw->cc_idx = i;
  
  		if (flags & PERF_EF_START)
  			arm_cmn_event_start(event, 0);
@@ -1948,7 +1977,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
  				goto free_dtms;
  		}
  
-		arm_cmn_set_index(hw->dtm_idx, i, dtm_idx);
+		arm_cmn_set_dtm_idx(hw, i, dtm_idx);
  
  		dtm->input_sel[dtm_idx] = input_sel;
  		shift = CMN__PMEVCNTn_GLOBAL_NUM_SHIFT(dtm_idx);
@@ -1981,7 +2010,7 @@ static void arm_cmn_event_del(struct perf_event *event, int flags)
  	arm_cmn_event_stop(event, PERF_EF_UPDATE);
  
  	if (type == CMN_TYPE_DTC)
-		cmn->dtc[hw->dtc_idx[0]].cycles = NULL;
+		cmn->dtc[hw->cc_idx].cycles = NULL;
  	else
  		arm_cmn_event_clear(cmn, event, hw->num_dns);
  }
-- 
2.54.0.dirty

