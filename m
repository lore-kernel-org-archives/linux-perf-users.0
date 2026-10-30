Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373228;
	b=opjZQbdnT0IEjEV+/MhNIGw8Ml1nwXMIHbefXTojTdD/5SCy2OV4qZMK+gb1EtDTP7Yg
	 V/AAcAGCWQIhErWH5/2NqruYeev9SfrzhN36BXni+WnSPBYCb+/Xi3wSt2ulORANpmpql
	 YpntAyQWJeUUed9F9feXsZUKbRka5Q2z6jlpExbxM6U5pNaiw6QNeGvu5DRxRweUlUmMb
	 S2vXrlkSz5cPys7lhFvxmjnJrV1l8uliVKaQoZDO9xNrAyDPX/hw0RXiZmrVdrRxxFU9O
	 jRxQu4YJGIf+CKHv//7Okn4IAX5FJNTMHFgo2pkFhATm4V2vzFQXdouU+KTxrCBMYAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373228;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=oFKk3nS8ygAMMKPXq4vJYs4te07iMMKNC18Bp28fxl0=;
	b=mRxSdgWVW9wOUFdEdNfzGLV5rKY+7mPy/pL5r6B9QMe9XVs70DGwg64Ot8JLOGj3sVlu
	 Am01t9Mr/VGYyU4hZVvWSVn7fYDoxXATtHizmIXjiVnQtdoFxw8iqzvXUC7ljK+y+sXkH
	 eXEaXUJOG3ZC+BWZGnUSdXQeEiC8YC0vy3pmuAZ4WMduj45MLOxjS0Z5S7T6NbqGOspiZ
	 6Z9noJ1r0UNczsb1qbZeRs349huvvDN2hflOfvksli2H5EjvjQeGFupFoiDjpWpK6ukzp
	 q6QIJLdHi4FmeWgikF3ahUxWfKgkTH7OoF+Hu4GWsY7VOh4FY3pLQPIk4oN8uOSyhqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hhXSUoDb;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96DE60A2627;
	Fri, 30 Oct 2026 15:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A96DE60A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hhXSUoDb
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFE2C1682;
	Fri, 30 Oct 2026 08:13:43 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C55553F59E;
	Fri, 30 Oct 2026 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373227; bh=7CV+vccRraYgpJImEBwcbhSmVEjGGmLdDw8Q04EKyoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hhXSUoDblqOq8UxHX3oLB+3Pe4xGy/baC4SBOUNjxZNPmLTBTYCID8/ecwBanBkcN
	 QjV0d9rPIY50GP39GFCCo0e/mivCpzTZnpGTX3xWqOukEdtass0yRYEx68JGTPj63s
	 GbviI9VkJX0TK+l4Ifxb7Sb+uhTGj5Tl88LXf+GE=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:16 +0000
Subject: [PATCH v3 09/14] perf cs-etm: Classify exception calls using the
 exception packet
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
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-9-7629b52ab047@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=6528;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7CV+vccRraYgpJImEBwcbhSmVEjGGmLdDw8Q04EKyoc=;
 b=JApVF8Y5pkMSUWor+afQ3A9VImE97UZ3hN9tl9dmXmX7rUkAdjkaexKacxE2NBWA0C3R+boJm
 bnwE0iK/1FbAQFusHyI2o/8Ip8SCjk0SmzZCqXm5yulaH0NiLLoNL9x
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

ETMv4 and ETE use the same exception number for SVC, HVC and SMC.
Identify SVC by inspecting the instruction before the preferred return
address in the exception packet.

Preserve the exception level and preferred return address from OpenCSD,
and use them with the packet's ISA in cs_etm__is_syscall() and
cs_etm__is_sync_exception(). This makes exception call classification
independent of the preceding instruction range.

Name the exception address pref_ret_addr in an anonymous union shared
with the range end_addr, keeping the packet layout unchanged. Name the
cs_etm__is_svc_instr() address argument ret_addr and document that it
checks the instruction immediately before the return address.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  7 ++++++-
 tools/perf/util/cs-etm.c                        | 21 ++++++++++-----------
 tools/perf/util/cs-etm.h                        |  5 ++++-
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 911bb28db2985bc65828ad342ca5b0a8bb903e47..ccae10e6cdad55607e092b90a1a940103fa050d7 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -511,7 +511,8 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
 				 struct cs_etm_packet_queue *queue,
 				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
-{	int ret = 0;
+{
+	int ret = 0;
 	struct cs_etm_packet *packet;
 
 	ret = cs_etm_decoder__buffer_packet(etmq, queue, elem, trace_chan_id,
@@ -521,6 +522,10 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
 
 	packet = &queue->packet_buffer[queue->tail];
 	packet->exception_number = elem->exception_number;
+	if (elem->context.el_valid)
+		packet->el = elem->context.exception_level;
+	if (elem->excep_ret_addr)
+		packet->pref_ret_addr = elem->en_addr;
 
 	return ret;
 }
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a9191c06060a2455e8bf1cd5f00fb9e92904eefa..14a6466255017386addaee539141bf89b6dcf76f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2061,7 +2061,7 @@ static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
 	 * to generate branch sample for the instruction range before the
 	 * exception is trapped to kernel or before the exception returning.
 	 *
-	 * The exception packet includes the dummy address values, so don't
+	 * The exception packet does not describe an instruction range, so don't
 	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
 	 * for generating instruction and branch samples.
 	 */
@@ -2192,9 +2192,10 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 	return 1;
 }
 
+/* Check whether the instruction before ret_addr is an SVC. */
 static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 				 struct cs_etm_traceid_queue *tidq,
-				 struct cs_etm_packet *packet, u64 end_addr)
+				 struct cs_etm_packet *packet, u64 ret_addr)
 {
 	/* Initialise to keep compiler happy */
 	u16 instr16 = 0;
@@ -2215,7 +2216,7 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 		 * with 16 bits instruction and has no definition for 32bits;
 		 * so below only read 2 bytes as instruction size for T32.
 		 */
-		addr = end_addr - 2;
+		addr = ret_addr - 2;
 		cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
 					    sizeof(instr16), (u8 *)&instr16);
 		if ((instr16 & 0xFF00) == 0xDF00)
@@ -2231,7 +2232,7 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 		 * |  !1111  | 1 1 1 1 |        imm24            |
 		 * +---------+---------+-------------------------+
 		 */
-		addr = end_addr - 4;
+		addr = ret_addr - 4;
 		cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
 					    sizeof(instr32), (u8 *)&instr32);
 		if ((instr32 & 0x0F000000) == 0x0F000000 &&
@@ -2248,7 +2249,7 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 		 * | 1 1 0 1 0 1 0 0 0 0 0 |  imm16  | 0 0 0 0 1 |
 		 * +-----------------------+---------+-----------+
 		 */
-		addr = end_addr - 4;
+		addr = ret_addr - 4;
 		cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
 					    sizeof(instr32), (u8 *)&instr32);
 		if ((instr32 & 0xFFE0001F) == 0xd4000001)
@@ -2267,7 +2268,6 @@ static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 			       struct cs_etm_traceid_queue *tidq, u64 magic)
 {
 	struct cs_etm_packet *packet = tidq->packet;
-	struct cs_etm_packet *prev_packet = tidq->prev_packet;
 
 	if (magic == __perf_cs_etmv3_magic)
 		if (packet->exception_number == CS_ETMV3_EXC_SVC)
@@ -2280,8 +2280,8 @@ static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 	 */
 	if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
 		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
-		    cs_etm__is_svc_instr(etmq, tidq, prev_packet,
-					 prev_packet->end_addr))
+		    cs_etm__is_svc_instr(etmq, tidq, packet,
+					 packet->pref_ret_addr))
 			return true;
 	}
 
@@ -2319,7 +2319,6 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 				      u64 magic)
 {
 	struct cs_etm_packet *packet = tidq->packet;
-	struct cs_etm_packet *prev_packet = tidq->prev_packet;
 
 	if (magic == __perf_cs_etmv3_magic)
 		if (packet->exception_number == CS_ETMV3_EXC_SMC ||
@@ -2343,8 +2342,8 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 		 * (SMC, HVC) are taken as sync exceptions.
 		 */
 		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
-		    !cs_etm__is_svc_instr(etmq, tidq, prev_packet,
-					  prev_packet->end_addr))
+		    !cs_etm__is_svc_instr(etmq, tidq, packet,
+					  packet->pref_ret_addr))
 			return true;
 
 		/*
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index b81099c2b301c25f894cc9a50edfde87aceff49d..e40b9b7d0a9bd90f089c2f20527332264ead4249 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -174,7 +174,10 @@ struct cs_etm_packet {
 	enum cs_etm_sample_type sample_type;
 	enum cs_etm_isa isa;
 	u64 start_addr;
-	u64 end_addr;
+	union {
+		u64 end_addr;		/* Range packets */
+		u64 pref_ret_addr;	/* Exception packets */
+	};
 	u32 instr_count;
 	u32 last_instr_type;
 	u32 last_instr_subtype;

-- 
2.34.1

