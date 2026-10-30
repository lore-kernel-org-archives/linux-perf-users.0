Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373212;
	b=tl7xMVnmYioOkk+iamFwEZeO9A0xvyCzdvzV7a/KPIELWVRx8I0Sr8RKISM3orpE2fUH
	 JxqMHE+IpZuBuQQYWBBtz+pq34mNFjoD/zXEZFOPpt7xuLmbXvfy0j/AaRwAtJ4C2VOYL
	 62qb6Ih0fpip6r6ruNQZjgPwWbvVRm4afYgD6lrDfaetuc6Bydb2Bibsa8syP+Gykqk+u
	 6n3an+miotOvyOfAOyD/BCpf3zPsUnmNnI2knrf64Cjl5STNaEXhe1yhDyyLnEJtyTPN0
	 e8SStIQpx+L0fmv4xfYSQgl5Y71mm2IZdHmopievg9pHYa88/b0OdIHSPoe8qsSIEdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373212;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=CQnY8qKFGpPU9NXWHDHKpiteq0S+2FYWabMRXfrAGd0=;
	b=vQ1+CtK0H192/VYbYU3LZrdBc6zDdeEPL68sDoVaP9dZLrFy0UZ+NV7Vjq+lYUbOigh5
	 5awORva0Fm6f5kmS6sZg2yDasYtOSho89P9ILCW96DaeS5jMg4fQKLBAk4QBgppA1Ff1Q
	 SzQ2FvuqJCjoVtzCy0oZI6iNQ54n7S69xu9GtyB1ZHKuA8CPro7T9/xnbXXrUnpm02gZ4
	 gDa4MX2y9GQTNvUMznMXau7olWDCzVg8Cp2gs6IQAM+q4t4wON3HkNR/43OSakMoaKxF9
	 ZOtKQaU+aTpG60OJKH+NHIE5OEYABTIw0V0auXQ8+SILcgWMBMhR1BdYiCWjk4PfwDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SwCm6YVD;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48531606A329;
	Fri, 30 Oct 2026 15:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48531606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SwCm6YVD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 791361682;
	Fri, 30 Oct 2026 08:13:28 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FB353F59E;
	Fri, 30 Oct 2026 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373211; bh=NrgmhdsujtT12W5xQ/MkNTy/uIFou/U+aGx0G8RML+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SwCm6YVDPMcXv50hLL0xE3ynlfWrT6UaBnmeC3/df0tEpFYmq28Ui1DlRzNQIBcpZ
	 8+C8Xi2dnMB0+IBbpo71TpbSx7mG6dMxfRnH0r49ilvmMRz2oaiKSl3SY+IOC93YsJ
	 EMc+v6SFlUwEjC7bITTX1MHHQajCdh4G+17v7beg=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:10 +0000
Subject: [PATCH v3 03/14] perf cs-etm: Break branch history when
 instruction memory is unavailable
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-3-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=1318;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=NrgmhdsujtT12W5xQ/MkNTy/uIFou/U+aGx0G8RML+k=;
 b=LDWF85DFHqcVcWG50iHm7JfbLnb2COwRgnhtGc/VIyMOmojGR8J+xwCS4JFbMaCrOVIRbLIbB
 nISQBwO/k8zCLqio3T5RbgbG5RvcjqmsLQF/Bv+AVdK4uAmwkP1u9LR
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The decoder currently ignores OCSD_GEN_TRC_ELEM_ADDR_NACC, allowing a
subsequent range to be paired with stale branch history from before the
unreadable code.

Treat an inaccessible instruction address as a discontinuity and flush
the pending range and branch history before processing subsequent
elements.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b56cf57a68c88de4686ecc8b0c7e71ac0f1d2f09..3fbb3fdf0382705bd4efa732c54ebb816144b2a8 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -594,7 +594,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 
 	if (type == OCSD_GEN_TRC_ELEM_EO_TRACE ||
 	    type == OCSD_GEN_TRC_ELEM_NO_SYNC ||
-	    type == OCSD_GEN_TRC_ELEM_TRACE_ON)
+	    type == OCSD_GEN_TRC_ELEM_TRACE_ON ||
+	    type == OCSD_GEN_TRC_ELEM_ADDR_NACC)
 		resp = cs_etm_decoder__buffer_discontinuity(etmq, packet_queue,
 							    trace_chan_id);
 	else if (type == OCSD_GEN_TRC_ELEM_INSTR_RANGE)

-- 
2.34.1

