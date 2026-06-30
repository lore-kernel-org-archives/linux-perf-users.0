Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365F35E1B2;
	Wed,  1 Jul 2026 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870325; cv=none; b=A/v215/QVbDTY0GhWUZ1yAWuG7onB2M8Mc2KL3cx8vRocD1IQRG7Pv7MZCQ0YRmdG0YE7jxwZJ869bJlTg4130rjDdN+jtkaT2QGpzU8sS8SB6qWrT/V1kidxoLCr/G81FeEO/e7fMN4qY4QkY5b28jdjnNHWDHsCk/EXazySgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870325; c=relaxed/simple;
	bh=7uNCtGNYs8cw6SwHT+e3/7nvvD6h+DfOg9r13lS/bzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z88WQuDsluA6sWsi23NKcKlX5PYm5c6AHiCi2Q0DybCLo30Bb1K8tZzZQrh6Km6jniHK4qlEMMPsdjSUqVKef77q0NR4vOsEuUEMnSWQLxpNo3kKqFQcNdQaGeBOoYzrtRW8vwgLQhiZo52mnZKJREwCxZtc/jyli0sJ7eZLX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=I4TtXiu0; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="I4TtXiu0"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A0EC91611DA;
	Tue, 30 Jun 2026 23:50:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (100-98-253-236.trex-nlb.outbound.svc.cluster.local [100.98.253.236])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 44A8916005D;
	Tue, 30 Jun 2026 23:50:27 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Stretch: 74045f5472b98add_1782863427551_1733216960
X-MC-Loop-Signature: 1782863427551:3229863366
X-MC-Ingress-Time: 1782863427551
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.253.236 (trex/7.1.5);
	Tue, 30 Jun 2026 23:50:27 +0000
Received: from offworld.lan (unknown [138.84.33.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4gqfz51qQ4z2c;
	Tue, 30 Jun 2026 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1782863427;
	bh=LfFDVQHs+tNLe1oUjnj7JQ19+ShsoFj+4O5XzfmndR4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=I4TtXiu0E9hewGRY/HrkauxDqQ3qnrml3PhP9RxumoAmCS1kwr0xpAB+r/WnUkc4N
	 EJzVZmwX4cv+BALhKo+eqjG1tDZQNJUy0PKnO2cPvdeGMfUsM+A2Hcr1iNUm+ME25I
	 AjBbBQR7xwbEszH62u8DRXdnuyrX8u/lDVWJOn+0eupfGZcXxMSSzqN55YTU2zzt0F
	 1LGo2U/Rh0BBa7KrXMdroINiKjeKZJtphSxTeoPqJK3sxAHwoipl5QGKHNPpeRIFlD
	 MW5x+JleBDYiv6XLw7hiLAuEn5r3yARjDu+jRUHm2Ia3sICSeTmE05gjtSlMeh2Zs0
	 AmMZ2XGdnB0Xg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: harshal.t@samsung.com,
	linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 2/2] perf/cxlpmu: Add missing CXL 4.0 events
Date: Tue, 30 Jun 2026 16:50:02 -0700
Message-Id: <20260630235002.253297-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260630235002.253297-1-dave@stgolabs.net>
References: <20260630235002.253297-1-dave@stgolabs.net>
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
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/perf/cxl_pmu.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 58c15680f299..f3ac36c6a02f 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -77,6 +77,9 @@
 #define CXL_PMU_GID_S2M_NDR		0x0024
 #define CXL_PMU_GID_S2M_DRS		0x0025
 #define CXL_PMU_GID_DDR			0x8000
+#define CXL_PMU_GID_QUEUE_OCC           0x8001
+#define CXL_PMU_GID_QUEUE_RESID         0x8002
+#define CXL_PMU_GID_RETRY_EVENTS        0x8003
 
 static int cxl_pmu_cpuhp_state_num;
 
@@ -410,13 +413,23 @@ static struct attribute *cxl_pmu_event_attrs[] = {
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
+	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memrdfill, 		CXL_PMU_GID_M2S_RWD, BIT(5)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrtee, 		CXL_PMU_GID_M2S_RWD, BIT(9)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrptltee, 		CXL_PMU_GID_M2S_RWD, BIT(10)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memrdfilltee, 		CXL_PMU_GID_M2S_RWD, BIT(13)),
 	/* CXL rev 3.0 Table 3-38 M2S BIRsp Memory Opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_i,			CXL_PMU_GID_M2S_BIRSP, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_s,			CXL_PMU_GID_M2S_BIRSP, BIT(1)),
@@ -431,15 +444,25 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,		CXL_PMU_GID_S2M_BISNP, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,		CXL_PMU_GID_S2M_BISNP, BIT(5)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,		CXL_PMU_GID_S2M_BISNP, BIT(6)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curtee, 		CXL_PMU_GID_S2M_BISNP, BIT(8)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datatee,		CXL_PMU_GID_S2M_BISNP, BIT(9)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invtee, 		CXL_PMU_GID_S2M_BISNP, BIT(10)),
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
+	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatatee, 		CXL_PMU_GID_S2M_DRS, BIT(2)),
 	/* CXL rev 3.0 Table 13-5 directly lists these */
 	CXL_PMU_EVENT_CXL_ATTR(ddr_act,				CXL_PMU_GID_DDR, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(ddr_pre,				CXL_PMU_GID_DDR, BIT(1)),
@@ -448,6 +471,27 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(ddr_refresh,			CXL_PMU_GID_DDR, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(ddr_selfrefreshent,		CXL_PMU_GID_DDR, BIT(5)),
 	CXL_PMU_EVENT_CXL_ATTR(ddr_rfm,				CXL_PMU_GID_DDR, BIT(6)),
+	/* CXL rev 3.2 Table 13-5 DDR add-on events opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(ddr_cas_rd_ap, 			CXL_PMU_GID_DDR, BIT(7)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_cas_wr_ap,  			CXL_PMU_GID_DDR, BIT(8)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_refresh_all_banks,  		CXL_PMU_GID_DDR, BIT(9)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_refresh_same_bank,		CXL_PMU_GID_DDR, BIT(10)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_pwrdn_entry,			CXL_PMU_GID_DDR, BIT(11)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_pwrdn_exit,			CXL_PMU_GID_DDR, BIT(12)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_rd_wr_ddr_bus_switching,	CXL_PMU_GID_DDR, BIT(13)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_incoming_rd_req,		CXL_PMU_GID_DDR, BIT(14)),
+	CXL_PMU_EVENT_CXL_ATTR(ddr_incoming_wr_req,		CXL_PMU_GID_DDR, BIT(15)),
+	/* CXL rev 3.2 Table 13-5 QUEUE OCCUPANCY events opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(rd_queue_occ,			CXL_PMU_GID_QUEUE_OCC, BIT(0)),
+	CXL_PMU_EVENT_CXL_ATTR(wr_queue_occ,			CXL_PMU_GID_QUEUE_OCC, BIT(1)),
+	/* CXL rev 3.2 Table 13-5 QUEUE RESIDENCY events opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(mc_rd_resid_cnt,			CXL_PMU_GID_QUEUE_RESID, BIT(0)),
+	CXL_PMU_EVENT_CXL_ATTR(mc_wr_resid_cnt,			CXL_PMU_GID_QUEUE_RESID, BIT(1)),
+	/* CXL rev 3.2 Table 13-5 RETRY events opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_rd_crc,      CXL_PMU_GID_RETRY_EVENTS, BIT(0)),
+	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_wr_crc,      CXL_PMU_GID_RETRY_EVENTS, BIT(1)),
+	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_ca_parity,   CXL_PMU_GID_RETRY_EVENTS, BIT(2)),
+	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_ecc,         CXL_PMU_GID_RETRY_EVENTS, BIT(3)),
 	NULL
 };
 
-- 
2.39.5

