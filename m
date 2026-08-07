Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76B44A3F4
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106602; cv=none; b=cA67Xk+yc51fHH0XdMLfGfBOw7lHHl79YOOvhvLWYhzhvUPMHJ2FTZmNIhmMKX4hK9ZJ6kVTQEfqnSzqDxgSf1Fa9Y6WQmsq3FQYQe/Vp/hlN6w8C6+zYo7HRBtgdMWcIlCeVq+4ZHgwScSzAg2lBKl3fHsB9HosbPKhyPRuGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106602; c=relaxed/simple;
	bh=vCyCv58QTzaI8yTrr8+MxdbtI1DfonkxDGiPgT9xhIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JJVE1dX/EzRvqQHv1FyadanPJZFkJVY6aBFYtqTmxYhgyZwV2O/+8h4tusJq6wKoE88g0g61tpnWHmZ0bvKczSln68ZxztpNP4RZnnNo3RMo5HCkQ1b/9hqn8LsY88khoMGThimg5X3GUX+KLH4ti0+xa9aW18e6JnZyJZPX6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XiaCMF3I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H9h81ov5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XiaCMF3I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H9h81ov5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgEgD2152420
	for <linux-perf-users@vger.kernel.org>; Fri, 7 Aug 2026 12:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BNJHVcH95oW8uKtThF5z2k
	7vNkI7JjEXWlUFtTQ+XEk=; b=XiaCMF3I88M2uk8Gr804NMwDBGoT9Bzb6shUqs
	9s4nMtKNlO+Tjgmdu2q5lJznyZQM5EjSLawKO6z7SUWU3LxuROQT1gKNTWrAzMos
	QjF3kx7yxujyDqJnusowgLJ7lHiWGyu9AXvTcQGvSCmSUcwZi5hzypqQri8jnzZI
	6kJTz/INgVFAV8jgsDdTT4ExwGKnRmBqx7B9QiCjLSqmcMeuGnwxk68uDCFjv9kH
	wgI7Zom0J+8tHnBrEZu0I0WUTrPLuELwlIECwqB3pENb4TBZdftVZx0DEzI/fXPA
	gyNAjY/0WIPHbRXor4+PEYCa6LSAsLJPP0TuFFtE4UlwxQDw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6rbu73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 12:43:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so43271165ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786106582; x=1786711382; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BNJHVcH95oW8uKtThF5z2k7vNkI7JjEXWlUFtTQ+XEk=;
        b=H9h81ov5TRUXH3aer28cdHTp7ZnYEGaiiY9gAeGWUWopZM1t7DDGxgcyX/hzCrm/W9
         GV22Jg3zzDG9GvEuG7wOQbLHqk9OBtD3X1ZNi0G6Dv80bNcwu+zvvG+y1JrHhddPNxHC
         gp11+H8ZYQrizhlzqlFsz1BW6r1X5aFsGO3MmHow1BJIgz115NvJ/DLMOFuFLGyK+lPe
         eZEKbYP8dbP4LnWHByynbYz9SRl/U96zp4GqYUSfdfIIrimGW0YnJvXxVKLcCoV/BAVV
         wMpR4EtvC/PqUPgupSiT9vu6/UR0oRwzN7j0flQbQWNpJLM0ubnytilBspKg9H9OnX4/
         urcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786106582; x=1786711382;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BNJHVcH95oW8uKtThF5z2k7vNkI7JjEXWlUFtTQ+XEk=;
        b=Xtv51lpKNBKw/m6BanvcNXw+yKppcJkdY3O/HxczGQmPVthF6GjwQ1wsH4fcdf48oV
         owJuK/eTtO/5Mq/1Lw0ZVQDxKgfyc1rWq6P2c+doaoPs97FWP+acVjjxdmoec8eREu1M
         /w+1DjXTnHSpsEgxS7I6syUUwR1kuQwDFauDflKLWHolXX0vYier24x/w+ZWCcH5Nrc0
         4F5DMEweLbidl15rcZNDZjFJKIkjzNTndldCsYhx8zyMgV7xsBID0r9V/j5r9whmL8XL
         Si++2MeHNXF3liLEd2TL6ITKgztTXLMr374WuNfzi2CeQqGHom5TVY49gh8FUqDORXnr
         a6SA==
X-Forwarded-Encrypted: i=1; AHgh+RrudqsWua30H8dOxGcf+N+RMh2VwkLqFuLbRJzH2W1I9dfCRUsxePnSstmS2vrxfe+ATPW0/oPiZMqp5kBCLeYF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Cez5xMybDcmPmDA7PMUGwWHJIiENYPQNgTyWwrJ09TsypuAX
	hsGmY4+FK0euDUCbVb60Ksu5AiHx+h/MQgD3fdYzm9D5kOoo1lbirCVCHKmtPLZ462Il6WnNMAX
	rQ8DRIc8bL3+azgS3z0A8IFcuCpRNmEk8Zm6qiGSb50jiw6To9htUT8q3YTse+6VBNvJ33KU/
X-Gm-Gg: AR+sD10XD56a3IMbZzoCKqu+JUdS1EDYtf5qzqSkraYlBBG9OuT3nrCgZ3h1Hk2/Cxc
	pxFv5c53//kwRCXwQLXUraAEYFB995GTCAPU40Nfwf6Sw2IzLmo6kxFLRBYx0+pcxf65qGPuhju
	0LOe+/FUkII1oSl+T2w8swXTPcnXIUBAwrmn1V2rKGeuk28FtNADXzBH6gxS5tb/n+ViyjA2ZA/
	0LO1dmKU5+5KsJ5pa0NO2mNUjzP4M+ZcxVuquOu6Wh+b3nL8cQ/DbMZK4IlMD3pCVXdjabE0u7A
	dw3ovZHyt13m1FFYuqQ46hNOq6RAbAea24ekbpuh+4UHLxHClf4dfkSAdrDm+JVNVsfPPxsbw5H
	XHW5BUUl4leA+3gxdGc3Y
X-Received: by 2002:a17:902:d98b:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d106ad0db2mr116568955ad.10.1786106581888;
        Fri, 07 Aug 2026 05:43:01 -0700 (PDT)
X-Received: by 2002:a17:902:d98b:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d106ad0db2mr116567865ad.10.1786106581404;
        Fri, 07 Aug 2026 05:43:01 -0700 (PDT)
Received: from [10.213.104.145] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14cce74b9sm8736875ad.28.2026.08.07.05.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:43:00 -0700 (PDT)
From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 18:11:52 +0530
Subject: [PATCH v3] perf/core: Fix group leader use-after-free after
 sibling detach
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-fix-group-leader-uaf-v3-1-b0c2310c9a0d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAI/SdWoC/4WNzQ6CMBAGX4X0bEn/Yz35HsZDLQvUgMUWiIbw7
 rZ48aDxsskk384sKEJwENGhWFCA2UXnbwn4rkC2NbcGsKsSI0aYIoopXLsHboKfBtyBqSDgydT
 YCqUVAckkEJRehwBpt2lP5zfH6XIFO2ZXXrQujj48t+5M8+5PYqaYYmOlUJJZo4U4+hjL+2Q66
 /u+TAfl0sw+XJz8cLHk0lxoyuieS4AvrnVdX5USUsMdAQAA
X-Change-ID: 20260626-fix-group-leader-uaf-c46960e525e0
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786106576; l=6966;
 i=aditya.chillara@oss.qualcomm.com; s=20260626; h=from:subject:message-id;
 bh=vCyCv58QTzaI8yTrr8+MxdbtI1DfonkxDGiPgT9xhIk=;
 b=DP4WT/Hf9tUW1+W8S5PXpuGvq4H7halCf68jcP2TymfU5keyyzVLtAcbHkIBu+m0iX6X2DWzH
 hQ5lXQzkzm/BGpOTyYAXSokR9BomVr0iq9tdmNZBgJx1xBTBRfvVD6a
X-Developer-Key: i=aditya.chillara@oss.qualcomm.com; a=ed25519;
 pk=3vcOzHlHNCpL/4rvfU3cpTk2xIC7SI+TH0gypa9FdZQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5OSBTYWx0ZWRfX3Mq/XD5mEZCp
 bVlJGm5Xp6pYwASSCyOHJqw9xrEownz2WCEIX0R/HBgum2n7leEl6LV8RPhyXT2BQMlAvr95Ygq
 Y9yYf5W2DzgSNqXU92tueZJBqp87/UYJTuMZxIDpy+hkNqN4Js4uByU3ICOySSJam+rjlSTWi0b
 aQBwZfAQjO4SF7dB9hRkUyUo4UQkU8wZ6yOMLj9vMVVvkxs3jnxOy2Q82MG5GxP6TnlE5PeAmZL
 yoK7M3PXdYVZwp06r9HFjlJcTRFJTlkT4Brt0hhvihsGZrb85RTVaj2WGo3skuX2y8jBghEvo+J
 dvOneK7lz5Felz72hRlrvsOmp6ysAZrCGAb65I8ltb/TOB7U4MUIuLX17f/Q446zkp8McKquZki
 2Pnu8BDwlli7EkLjFKHabTmOJ89Pw7zGC07WwDBuKaBNmhe47HnAL/lJ2v0e05MEVb12Ywg9yyY
 N1335M2bTgkCy613S8A==
X-Authority-Analysis: v=2.4 cv=HPXz0Itv c=1 sm=1 tr=0 ts=6a75d2d6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=WLCWugTz48h6f64SD0IA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: b9Ta84odt6gvjVHrw7rsnnAi0jiGu4Ls
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5OSBTYWx0ZWRfX+5O8433IMM/q
 KOzsc/c4WoBJaotzl5Lb5Q+pN8UDisdgdAvyktpMJ7swr3qRvOZOO6F9mUMIpMNQZyzHrkj4OKJ
 PdX+E+7Vm6byQdceZ38sEUw5bm1xW20=
X-Proofpoint-GUID: b9Ta84odt6gvjVHrw7rsnnAi0jiGu4Ls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070099

perf_group_detach() handles leader and sibling detach differently. When the
group leader is detached, all siblings are promoted to singleton events and
their group_leader pointer is reset to themselves. When a sibling is
detached, it is removed from the leader's sibling_list, but its
group_leader pointer is left pointing at the old leader.

That is harmless when the sibling is being closed and freed immediately, as
in the DETACH_DEAD path. It is not safe when the sibling is detached but
kept alive, such as during CPU hotplug with DETACH_GROUP. In that case the
sibling is removed from the context, while its file descriptor can still
keep it alive.

A typical failing sequence is:

  - A group contains leader L and sibling S.
  - CPU hot-unplug detaches S with DETACH_GROUP, removing it from
    L->sibling_list but leaving S->group_leader == L.
  - L is later closed and freed.
  - A PERF_IOC_FLAG_GROUP ioctl on S follows S->group_leader and
    dereferences the freed leader.

This was reproduced by running the perf event fuzzer, CPU hotplug, and a
stress workload concurrently:

Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cdb
CPU: 2 PID: 12489 Comm: perf_fuzzer 6.18.7 PREEMPT
pc : perf_ioctl+0x34c/0xc68
x20: ffffff89a3fa2c70 x8 : 6b6b6b6b6b6b6b6b
Code: 943c4a0e 340047a0 f9404a94 f9411e88 (f940b908)
Call trace:
perf_ioctl+0x34c/0xc68 (P)
__arm64_sys_ioctl+0xa0/0xf4
invoke_syscall+0x58/0xe4
el0_svc_common+0xa8/0xdc
do_el0_svc+0x1c/0x28
el0_svc+0x40/0xc0
el0t_64_sync_handler+0x68/0xdc
el0t_64_sync+0x1c4/0x1c8

The fault happened in perf_ioctl(), where perf_event_for_each() follows
the stale group_leader pointer and perf_event_for_each_child() then
dereferences the freed leader's context.

Fix the use-after-free by promoting the detached sibling to a singleton.
Also fix __event_disable() cgroup accounting and event state change.

Fixes: 8a49542c0554 ("perf_events: Fix races in group composition")
Assisted-by: PatchWise:gpt-5.5
Signed-off-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
Changes in v3:
- Fixed cgroup accounting and event state change in __event_disable().
- Used __event_disable() in perf_promote_sibling_to_leader().
- Set event->nr_siblings = 0 in the leader path after promoting all siblings.
- Reused leader pointer in perf_group_detach().
- Link to v2: https://patch.msgid.link/20260630-fix-group-leader-uaf-v2-1-9349121835ee@oss.qualcomm.com

Changes in v2:
- Moved the fix to perf_group_detach() with a small refactor.
- Added guards to prevent double perf_cgroup_event_disable()
  and incorrect event state change in sibling detach path.
- Link to v1: https://patch.msgid.link/20260626-fix-group-leader-uaf-v1-1-ac54652ca944@oss.qualcomm.com
---
 kernel/events/core.c | 67 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4638544205f2..e8fdd88e156d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2343,6 +2343,34 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 				    &event->pmu_ctx->flexible_active;
 }
 
+/* @sibling must already be unlinked from its old leader's sibling_list. */
+static void perf_promote_sibling_to_leader(struct perf_event *sibling,
+					   struct perf_event_context *ctx,
+					   int group_caps)
+{
+	/*
+	 * Events that have PERF_EV_CAP_SIBLING require being part of
+	 * a group and cannot exist on their own, schedule them out
+	 * and move them into the ERROR state. Also see
+	 * _perf_event_enable(), it will not be able to recover this
+	 * ERROR state.
+	 */
+	if (sibling->event_caps & PERF_EV_CAP_SIBLING)
+		__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
+
+	sibling->group_leader = sibling;
+	sibling->group_caps = group_caps;
+
+	if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
+		add_event_to_groups(sibling, ctx);
+
+		if (sibling->state == PERF_EVENT_STATE_ACTIVE)
+			list_add_tail(&sibling->active_list, get_event_list(sibling));
+	}
+
+	perf_event__header_size(sibling);
+}
+
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
@@ -2366,8 +2394,9 @@ static void perf_group_detach(struct perf_event *event)
 	 */
 	if (leader != event) {
 		list_del_init(&event->sibling_list);
-		event->group_leader->nr_siblings--;
-		event->group_leader->group_generation++;
+		leader->nr_siblings--;
+		leader->group_generation++;
+		perf_promote_sibling_to_leader(event, ctx, event->event_caps);
 		goto out;
 	}
 
@@ -2377,32 +2406,14 @@ static void perf_group_detach(struct perf_event *event)
 	 * to whatever list we are on.
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
-
-		/*
-		 * Events that have PERF_EV_CAP_SIBLING require being part of
-		 * a group and cannot exist on their own, schedule them out
-		 * and move them into the ERROR state. Also see
-		 * _perf_event_enable(), it will not be able to recover this
-		 * ERROR state.
-		 */
-		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
-
-		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
 
 		/* Inherit group flags from the previous leader */
-		sibling->group_caps = event->group_caps;
-
-		if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
-			add_event_to_groups(sibling, event->ctx);
-
-			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
-				list_add_tail(&sibling->active_list, get_event_list(sibling));
-		}
+		perf_promote_sibling_to_leader(sibling, ctx, event->group_caps);
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
 	}
+	event->nr_siblings = 0;
 
 out:
 	for_each_sibling_event(tmp, leader)
@@ -2592,12 +2603,7 @@ __perf_remove_from_context(struct perf_event *event,
 	if (flags & DETACH_DEAD)
 		state = PERF_EVENT_STATE_DEAD;
 
-	event_sched_out(event, ctx);
-
-	if (event->state > PERF_EVENT_STATE_OFF)
-		perf_cgroup_event_disable(event, ctx);
-
-	perf_event_set_state(event, min(event->state, state));
+	__event_disable(event, ctx, state);
 
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
@@ -2666,8 +2672,9 @@ static void __event_disable(struct perf_event *event,
 			    enum perf_event_state state)
 {
 	event_sched_out(event, ctx);
-	perf_cgroup_event_disable(event, ctx);
-	perf_event_set_state(event, state);
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
 }
 
 /*

---
base-commit: e9dac177a4ea335a3f035f81405088e17947f258
change-id: 20260626-fix-group-leader-uaf-c46960e525e0

Best regards,
--  
Aditya Chillara <aditya.chillara@oss.qualcomm.com>

