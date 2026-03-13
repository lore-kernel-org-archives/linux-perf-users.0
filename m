Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB0538F65A;
	Fri, 13 Mar 2026 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408099; cv=none; b=h4fykSfUWnHhJ7ERqdGK500bsNeAPpm4DmhURZ7gA4bFDJ9USAwren6trpnlvngmsiOxD8/gUeCsKyHQkP6IVIDapf4w+G5/89jwryaFIcAak6punUNGTFR/F4MdeJFmXZz/FalaRNk7AcfW3SvnmhnZUYztHAxHZR90MhvcPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408099; c=relaxed/simple;
	bh=sTVnkGCPo0ToxbTpptUzRAu1TrXMsVLxPw2PKOTQ7Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5mD5rq2bNyLC9bZ6o7BYp9lEAb1Bpg1+fsSJ76ZNcip7PcnZcmCvLY6L7i0ybt/N2ReqGVR6SOnAjn+WkACdyCSWXdngugrayoaSQTaLelteiqrY04r0kNmnDxRt6fJ2joPgvF/5MP6dOlqivmFcFrtgBitLgaHll5TuAJvYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADEF11C2B;
	Fri, 13 Mar 2026 06:21:31 -0700 (PDT)
Received: from e142892.manchester.arm.com (e142892.arm.com [10.33.8.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1265E3F73B;
	Fri, 13 Mar 2026 06:21:35 -0700 (PDT)
From: Mike Leach <mike.leach@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	acme@kernel.org
Cc: suzuki.poulose@arm.com,
	leo.yan@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@redhat.com,
	namhyung@kernel.org,
	Mike Leach <mike.leach@arm.com>
Subject: [PATCH 2/2] perf: tools: cs-etm: Enhance raw Coresight trace debug display
Date: Fri, 13 Mar 2026 13:21:29 +0000
Message-ID: <20260313132129.2743468-3-mike.leach@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313132129.2743468-1-mike.leach@arm.com>
References: <20260313132129.2743468-1-mike.leach@arm.com>
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

Signed-off-by: Mike Leach <mike.leach@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index f7e89693cf16..229b28538757 100644
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
@@ -686,7 +689,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 					   trace_config, &csid))
 			return -1;
 
-		if (ocsd_dt_set_pkt_protocol_printer(decoder->dcd_tree, csid, 0))
+		if (ocsd_dt_set_pkt_protocol_printer(decoder->dcd_tree, csid, CS_PKT_MON))
 			return -1;
 
 		return 0;
-- 
2.43.0

