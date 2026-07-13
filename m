Received: from gerbil.ash.relay.mailchannels.net (gerbil.ash.relay.mailchannels.net [23.83.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091333812F6;
	Mon, 13 Jul 2026 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923420; cv=none; b=Wr6ATQypqtiyVkBU3dfMRYPh9lTKCrKcwpEGgVW7wtrHCOQCKjMMfJlk9WccQfGh305jZFYBmZHR/x5ePdBg+ymZCxkbYOi6Abuohurdgr0hcg2d+FyExGM4rf3iqVBiASzcF5lDYRi0xY1lBAX33riRISFioOfpS0JuqDA75eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923420; c=relaxed/simple;
	bh=OxMxLFHBhEdu3uMyPJ43SN3Z0J/FiifBUvc0DiPXFIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0AnrLk++hmyFSqr3nFqwx4e/oVArKIRuN2dInc3BAu1qz7UCDl9eCnyrKuBFoQsF/QWyCgfaDoF7LYPVETybpCqtE1LDJFtngI8p4r5t3mSzQFtzZzx0nTcAoGJ2nqq1/Po3QF235cv35++8dD4PAawBPzktYTux+Xwvvi5vS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bJh2I1/o; arc=none smtp.client-ip=23.83.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bJh2I1/o"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EF620722386;
	Mon, 13 Jul 2026 06:11:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.98.252.118])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 953EA722916;
	Mon, 13 Jul 2026 06:11:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Wiry: 4b5a23c836951b1c_1783923079893_295394544
X-MC-Loop-Signature: 1783923079893:2023655165
X-MC-Ingress-Time: 1783923079893
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.252.118 (trex/8.0.2);
	Mon, 13 Jul 2026 06:11:19 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4gzBs3049Qz77;
	Sun, 12 Jul 2026 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1783923079;
	bh=X3viXdzlmBwAY52OK6zwsX7RuN1+PXNKsPekwhrlHIE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=bJh2I1/oP61wkNIgOGkGQ6e2rbiGzEUVPVsNuvrTvPLtHGdRmyeCgfzMIzKC28F99
	 L3cFEaN9S07H422KPDJH9DADoWyvLsziV71DgBY4yXBncRHEFrPZvSY5ll0Iemwp9F
	 3LPZRe4TtG/nyJzvqKmQ8pIws4vtQ9Cr42UD+s6tGQDzLkbqsdAtoSPTYHUfyOyAq2
	 kLRLRUbGawpI1Lz+d+BuCRR3ztRfQ8+PGH1y4IfCFTmtVVep5syoEjAZTsgp7ogQw8
	 Yjpu1DiqWBPKHCAhcHLlqxBO6EfFxp49m1V+sWtVw1Qy0Tbsdhvmrfa28kMWRhviV0
	 Xf1KZCnLdk2jw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: harshal.t@samsung.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v3 2/3] perf/cxlpmu: Add missing CXL 4.0 events
Date: Sun, 12 Jul 2026 23:11:11 -0700
Message-Id: <20260713061112.105419-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260713061112.105419-1-dave@stgolabs.net>
References: <20260713061112.105419-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harshal Thakkar <harshal.t@samsung.com>

Add support for CXL 4.0 events that are exposed by the CPMU hardware
but not present in the driver. Such events are defined in Table 13-5
of the spec.

Signed-off-by: Harshal Thakkar <harshal.t@samsung.com>
[davidlohr: add missing throttle and queue occupancy events]
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/perf/cxl_pmu.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 39b46550a510..1fc83858f653 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -77,6 +77,10 @@
 #define CXL_PMU_GID_S2M_NDR		0x0024
 #define CXL_PMU_GID_S2M_DRS		0x0025
 #define CXL_PMU_GID_DDR			0x8000
+#define CXL_PMU_GID_QUEUE_OCC           0x8001
+#define CXL_PMU_GID_QUEUE_RESID         0x8002
+#define CXL_PMU_GID_RETRY_EVENTS        0x8003
+#define CXL_PMU_GID_THROTTLE            0x8004
 
 static int cxl_pmu_cpuhp_state_num;
 
@@ -385,13 +389,23 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memwrfwd,		CXL_PMU_GID_M2S_REQ, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrdtee,		CXL_PMU_GID_M2S_REQ, BIT(5)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrddatatee,		CXL_PMU_GID_M2S_REQ, BIT(6)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminvtee,               CXL_PMU_GID_M2S_REQ, BIT(7)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memspecrd,		CXL_PMU_GID_M2S_REQ, BIT(8)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminvnt,		CXL_PMU_GID_M2S_REQ, BIT(9)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memcleanevict,		CXL_PMU_GID_M2S_REQ, BIT(10)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminvptee,		CXL_PMU_GID_M2S_REQ, BIT(11)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memspecrdtee,		CXL_PMU_GID_M2S_REQ, BIT(12)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_req_teupdate,		CXL_PMU_GID_M2S_REQ, BIT(13)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memclnevcttee,		CXL_PMU_GID_M2S_REQ, BIT(14)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memclnevctu,		CXL_PMU_GID_M2S_REQ, BIT(15)),
 	/* CXL rev 3.0 Table 3-35 M2S RwD Memory Opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwr,			CXL_PMU_GID_M2S_RWD, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrptl,		CXL_PMU_GID_M2S_RWD, BIT(2)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_biconflict,		CXL_PMU_GID_M2S_RWD, BIT(4)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memrdfill,		CXL_PMU_GID_M2S_RWD, BIT(5)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrtee,		CXL_PMU_GID_M2S_RWD, BIT(9)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrptltee,		CXL_PMU_GID_M2S_RWD, BIT(10)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memrdfilltee,		CXL_PMU_GID_M2S_RWD, BIT(13)),
 	/* CXL rev 3.0 Table 3-38 M2S BIRsp Memory Opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_i,			CXL_PMU_GID_M2S_BIRSP, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_s,			CXL_PMU_GID_M2S_BIRSP, BIT(1)),
@@ -406,15 +420,25 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,		CXL_PMU_GID_S2M_BISNP, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,		CXL_PMU_GID_S2M_BISNP, BIT(5)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,		CXL_PMU_GID_S2M_BISNP, BIT(6)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curtee,		CXL_PMU_GID_S2M_BISNP, BIT(8)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datatee,		CXL_PMU_GID_S2M_BISNP, BIT(9)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invtee,		CXL_PMU_GID_S2M_BISNP, BIT(10)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblktee,		CXL_PMU_GID_S2M_BISNP, BIT(12)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datablktee,		CXL_PMU_GID_S2M_BISNP, BIT(13)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblktee,		CXL_PMU_GID_S2M_BISNP, BIT(14)),
 	/* CXL rev 3.1 Table 3-50 S2M NDR Opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,			CXL_PMU_GID_S2M_NDR, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,			CXL_PMU_GID_S2M_NDR, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,			CXL_PMU_GID_S2M_NDR, BIT(2)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpm,			CXL_PMU_GID_S2M_NDR, BIT(3)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,		CXL_PMU_GID_S2M_NDR, BIT(4)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmptee,			CXL_PMU_GID_S2M_NDR, BIT(5)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmptee_s,		CXL_PMU_GID_S2M_NDR, BIT(6)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmptee_e,		CXL_PMU_GID_S2M_NDR, BIT(7)),
 	/* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,			CXL_PMU_GID_S2M_DRS, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,		CXL_PMU_GID_S2M_DRS, BIT(1)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatatee,		CXL_PMU_GID_S2M_DRS, BIT(2)),
 	/* CXL rev 3.0 Table 13-5 directly lists these */
 	CXL_PMU_EVENT_CXL_ATTR(ddr_act,				CXL_PMU_GID_DDR, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(ddr_pre,				CXL_PMU_GID_DDR, BIT(1)),
@@ -423,6 +447,32 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(ddr_refresh,			CXL_PMU_GID_DDR, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(ddr_selfrefreshent,		CXL_PMU_GID_DDR, BIT(5)),
 	CXL_PMU_EVENT_CXL_ATTR(ddr_rfm,				CXL_PMU_GID_DDR, BIT(6)),
+	/* CXL 4.0 Table 13-5 DDR add-on events opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(ddr_cas_rd_ap,			CXL_PMU_GID_DDR, BIT(7)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_cas_wr_ap,			CXL_PMU_GID_DDR, BIT(8)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_refresh_all_banks,		CXL_PMU_GID_DDR, BIT(9)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_refresh_same_bank,		CXL_PMU_GID_DDR, BIT(10)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_pwrdn_entry,			CXL_PMU_GID_DDR, BIT(11)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_pwrdn_exit,			CXL_PMU_GID_DDR, BIT(12)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_rd_wr_ddr_bus_switching,	CXL_PMU_GID_DDR, BIT(13)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_incoming_rd_req,		CXL_PMU_GID_DDR, BIT(14)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_incoming_wr_req,		CXL_PMU_GID_DDR, BIT(15)),
+	/* CXL 4.0 Table 13-5 QUEUE OCCUPANCY events opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(rd_queue_occ,			CXL_PMU_GID_QUEUE_OCC, BIT(0)),
+	CXL_PMU_EVENT_CXL_ATTR(wr_queue_occ,			CXL_PMU_GID_QUEUE_OCC, BIT(1)),
+	CXL_PMU_EVENT_CXL_ATTR(rd_wr_merged_queue_occ,		CXL_PMU_GID_QUEUE_OCC, BIT(2)),
+	CXL_PMU_EVENT_CXL_ATTR(pwrdn_event,			CXL_PMU_GID_QUEUE_OCC, BIT(3)),
+	/* CXL 4.0 Table 13-5 QUEUE RESIDENCY events opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(mc_rd_resid_cnt,			CXL_PMU_GID_QUEUE_RESID, BIT(0)),
+	CXL_PMU_EVENT_CXL_ATTR(mc_wr_resid_cnt,			CXL_PMU_GID_QUEUE_RESID, BIT(1)),
+	/* CXL 4.0 Table 13-5 RETRY events opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_rd_crc,      CXL_PMU_GID_RETRY_EVENTS, BIT(0)),
+	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_wr_crc,      CXL_PMU_GID_RETRY_EVENTS, BIT(1)),
+	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_ca_parity,   CXL_PMU_GID_RETRY_EVENTS, BIT(2)),
+	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_ecc,         CXL_PMU_GID_RETRY_EVENTS, BIT(3)),
+	/* CXL 4.0 Table 13-5 THROTTLE events opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(thermal_throttle_event,		CXL_PMU_GID_THROTTLE, BIT(0)),
+	CXL_PMU_EVENT_CXL_ATTR(power_throttle_event,		CXL_PMU_GID_THROTTLE, BIT(1)),
 	NULL
 };
 
-- 
2.39.5

