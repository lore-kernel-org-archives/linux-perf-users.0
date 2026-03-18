Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD93845B7;
	Wed, 18 Mar 2026 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830209; cv=none; b=g2klRrT9JL/0DMfnoJe1rU2EaPLPw4TQvZxD7Wb09/Hi4OO82sh6YX339smcb4BmDPgnjbD532cpwEWy9w3C/WQfvcjom50TTcR9Vcuugb4UHL3UhWrW0Bd8+d2GKWLrtkiDm2PzoEq3JzObWbb0Rf+fO2KlGJQSNRd0nCsPunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830209; c=relaxed/simple;
	bh=RNkUpeQXLrL7zLI6RJumXgvFvfhO87X1ECakAHmll+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIFGYIecgw9lQyrTwgjRMyOSWJJ+1kjG0fBwbqpUmI+aarbKFX77K+osYakAR263dMEQWfn3PCn5EFQm3p25Nh13lSwXZJN4iK41agEGLS3H0ajMzefVjeRYXXV2nGjqQTje9Ok6mB0Pk/xacBQhynZWsuFxeIBd1ZU/rO+ztKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E23A1E7D;
	Wed, 18 Mar 2026 03:36:41 -0700 (PDT)
Received: from e142892.manchester.arm.com (e142892.arm.com [10.33.8.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1DB733F778;
	Wed, 18 Mar 2026 03:36:45 -0700 (PDT)
From: Mike Leach <mike.leach@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	acme@kernel.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	james.clark@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	Mike Leach <mike.leach@arm.com>
Subject: [PATCH v2 2/2] perf: tools: cs-etm: Enhance raw Coresight trace debug display
Date: Wed, 18 Mar 2026 10:36:40 +0000
Message-ID: <20260318103640.464982-2-mike.leach@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318103640.464982-1-mike.leach@arm.com>
References: <20260318103640.464982-1-mike.leach@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling perf with CORESIGHT=1, an additional build option may
be used: CSTRACE_RAW=1, which will cause the CoreSight formatted trace
frames to be printed out during a perf --dump command. This is useful
when investigating issues with trace generation, decode or possible
data corruption.

e.g. for ETMv4 trace source into a formatted ETR sink a dump -

. ... CoreSight ETMV4I Trace data: size 0x28c150 bytes
Idx:0; ID:14;	I_ASYNC : Alignment Synchronisation.
Idx:12; ID:14;	I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 };
                Decoder Sync point TINFO
Idx:17; ID:14;	I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.;
                Addr=0x0000000000000000;

becomes with CSTRACE_RAW=1:

. ... CoreSight ETMV4I Trace data: size 0x28c150 bytes
Frame Data; Index 0; ID_DATA[0x14]; 00 00 00 00 00 00 00 00
                                    00 00 00 80 01 01
Idx:0; ID:14;	I_ASYNC : Alignment Synchronisation.
Frame Data; Index 16; ID_DATA[0x14]; 00 9d 00 00 00 00 00 00
                                     00 00 04 85 57 08 f2
Idx:12; ID:14;	I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 };
                Decoder Sync point TINFO
Idx:17; ID:14;	I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.;
                Addr=0x0000000000000000;

CSTRACE_RAW=1 has no effect on ETE + TRBE trace as there is no trace
formatting in the TRBE buffer.

This patch enhances the output so that for each packet the individual
bytes associated with the packet are printed.

Thus for ETMv4 this now becomes:

. ... CoreSight ETMV4I Trace data: size 0x28c150 bytes
Frame Data; Index 0; ID_DATA[0x14]; 00 00 00 00 00 00 00 00
                                    00 00 00 80 01 01
Idx:0; ID:14;[0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x80];
             I_ASYNC : Alignment Synchronisation.
Frame Data; Index 16; ID_DATA[0x14]; 00 9d 00 00 00 00 00 00
                                     00 00 04 85 57 08 f2
Idx:12; ID:14; [0x01 0x01 0x00 ]; I_TRACE_INFO : Trace Info.; INFO=0x0
                                  { CC.0 }; Decoder Sync point TINFO
Idx:17; ID:14; [0x9d 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 ];
               I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.;
	       Addr=0x0000000000000000;

ETE trace output changes from:

Idx:0; ID:14; I_ASYNC : Alignment Synchronisation.
Idx:12; ID:14; I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0, TSTATE.0 };
               Decoder Sync point TINFO
Idx:15; ID:14; I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.;
               Addr=0xFFFF80007CF7F56C;
becoming:

Idx:0; ID:14;[0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x80];
              I_ASYNC : Alignment Synchronisation.
Idx:12; ID:14; [0x01 0x01 0x00 ]; I_TRACE_INFO : Trace Info.; INFO=0x0
               { CC.0, TSTATE.0 }; Decoder Sync point TINFO
Idx:15; ID:14; [0x9d 0x5b 0x7a 0xf7 0x7c 0x00 0x80 0xff 0xff ];
               I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.;
	       Addr=0xFFFF80007CF7F56C;

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Mike Leach <mike.leach@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 8592a778b26a..91d3feb18aaf 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -22,12 +22,15 @@
 /* use raw logging */
 #ifdef CS_DEBUG_RAW
 #define CS_LOG_RAW_FRAMES
+#define CS_PKT_MON	1
 #ifdef CS_RAW_PACKED
 #define CS_RAW_DEBUG_FLAGS (OCSD_DFRMTR_UNPACKED_RAW_OUT | \
 			    OCSD_DFRMTR_PACKED_RAW_OUT)
 #else
 #define CS_RAW_DEBUG_FLAGS (OCSD_DFRMTR_UNPACKED_RAW_OUT)
 #endif
+#else
+#define CS_PKT_MON	0
 #endif
 
 /*
@@ -664,7 +667,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 					   trace_config, &csid))
 			return -1;
 
-		if (ocsd_dt_set_pkt_protocol_printer(decoder->dcd_tree, csid, 0))
+		if (ocsd_dt_set_pkt_protocol_printer(decoder->dcd_tree, csid, CS_PKT_MON))
 			return -1;
 
 		return 0;
-- 
2.43.0

