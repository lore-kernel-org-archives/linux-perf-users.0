From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/53] perf cs-etm: Set sample flags for exception packet
Date: Wed,  6 Feb 2019 15:48:52 -0300
Message-ID: <20190206184903.24054-43-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Robert Walker <robert.walker@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mike Leach <mike.leach@linaro.org>, Suzuki K Poulouse <suzuki.poulose@arm.com>, coresight ml <coresight@lists.linaro.org>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The exception taken and returning are typical flow for instruction jump
but it needs to be handled with exception packets. This patch is to set
sample flags for exception packet.

Since the exception packet contains the exception number, according to
the exception number this patch makes decision for belonging to which
exception types.

The decoder have defined different exception number for ETMv3 and ETMv4
separately, hence this patch needs firstly decide the ETM version by
using the metadata magic number, and this patch adds helper function
cs_etm__get_magic() for easily getting magic number.

Based on different ETM version, the exception packet contains the
exception number, according to the exception number this patch makes
decision for the exception belonging to which exception types.

In this patch, it introduces helper function cs_etm__is_svc_instr(); for
ETMv4 CS_ETMV4_EXC_CALL covers SVC, SMC and HVC cases in the single
exception number, thus need to use cs_etm__is_svc_instr() to decide an
exception taken for system call.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Robert Walker <robert.walker@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190129122842.32041-8-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 215 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.h |  44 ++++++++
 2 files changed, 259 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a5497a761db7..a714b31656ea 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -97,6 +97,20 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 	return CS_ETM_PROTO_ETMV3;
 }
 
+static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
+{
+	struct int_node *inode;
+	u64 *metadata;
+
+	inode = intlist__find(traceid_list, trace_chan_id);
+	if (!inode)
+		return -EINVAL;
+
+	metadata = inode->priv;
+	*magic = metadata[CS_ETM_MAGIC];
+	return 0;
+}
+
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
 {
 	struct int_node *inode;
@@ -1122,10 +1136,174 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
+				 struct cs_etm_packet *packet,
+				 u64 end_addr)
+{
+	u16 instr16;
+	u32 instr32;
+	u64 addr;
+
+	switch (packet->isa) {
+	case CS_ETM_ISA_T32:
+		/*
+		 * The SVC of T32 is defined in ARM DDI 0487D.a, F5.1.247:
+		 *
+		 *  b'15         b'8
+		 * +-----------------+--------+
+		 * | 1 1 0 1 1 1 1 1 |  imm8  |
+		 * +-----------------+--------+
+		 *
+		 * According to the specifiction, it only defines SVC for T32
+		 * with 16 bits instruction and has no definition for 32bits;
+		 * so below only read 2 bytes as instruction size for T32.
+		 */
+		addr = end_addr - 2;
+		cs_etm__mem_access(etmq, addr, sizeof(instr16), (u8 *)&instr16);
+		if ((instr16 & 0xFF00) == 0xDF00)
+			return true;
+
+		break;
+	case CS_ETM_ISA_A32:
+		/*
+		 * The SVC of A32 is defined in ARM DDI 0487D.a, F5.1.247:
+		 *
+		 *  b'31 b'28 b'27 b'24
+		 * +---------+---------+-------------------------+
+		 * |  !1111  | 1 1 1 1 |        imm24            |
+		 * +---------+---------+-------------------------+
+		 */
+		addr = end_addr - 4;
+		cs_etm__mem_access(etmq, addr, sizeof(instr32), (u8 *)&instr32);
+		if ((instr32 & 0x0F000000) == 0x0F000000 &&
+		    (instr32 & 0xF0000000) != 0xF0000000)
+			return true;
+
+		break;
+	case CS_ETM_ISA_A64:
+		/*
+		 * The SVC of A64 is defined in ARM DDI 0487D.a, C6.2.294:
+		 *
+		 *  b'31               b'21           b'4     b'0
+		 * +-----------------------+---------+-----------+
+		 * | 1 1 0 1 0 1 0 0 0 0 0 |  imm16  | 0 0 0 0 1 |
+		 * +-----------------------+---------+-----------+
+		 */
+		addr = end_addr - 4;
+		cs_etm__mem_access(etmq, addr, sizeof(instr32), (u8 *)&instr32);
+		if ((instr32 & 0xFFE0001F) == 0xd4000001)
+			return true;
+
+		break;
+	case CS_ETM_ISA_UNKNOWN:
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static bool cs_etm__is_syscall(struct cs_etm_queue *etmq, u64 magic)
+{
+	struct cs_etm_packet *packet = etmq->packet;
+	struct cs_etm_packet *prev_packet = etmq->prev_packet;
+
+	if (magic == __perf_cs_etmv3_magic)
+		if (packet->exception_number == CS_ETMV3_EXC_SVC)
+			return true;
+
+	/*
+	 * ETMv4 exception type CS_ETMV4_EXC_CALL covers SVC, SMC and
+	 * HVC cases; need to check if it's SVC instruction based on
+	 * packet address.
+	 */
+	if (magic == __perf_cs_etmv4_magic) {
+		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
+		    cs_etm__is_svc_instr(etmq, prev_packet,
+					 prev_packet->end_addr))
+			return true;
+	}
+
+	return false;
+}
+
+static bool cs_etm__is_async_exception(struct cs_etm_queue *etmq, u64 magic)
+{
+	struct cs_etm_packet *packet = etmq->packet;
+
+	if (magic == __perf_cs_etmv3_magic)
+		if (packet->exception_number == CS_ETMV3_EXC_DEBUG_HALT ||
+		    packet->exception_number == CS_ETMV3_EXC_ASYNC_DATA_ABORT ||
+		    packet->exception_number == CS_ETMV3_EXC_PE_RESET ||
+		    packet->exception_number == CS_ETMV3_EXC_IRQ ||
+		    packet->exception_number == CS_ETMV3_EXC_FIQ)
+			return true;
+
+	if (magic == __perf_cs_etmv4_magic)
+		if (packet->exception_number == CS_ETMV4_EXC_RESET ||
+		    packet->exception_number == CS_ETMV4_EXC_DEBUG_HALT ||
+		    packet->exception_number == CS_ETMV4_EXC_SYSTEM_ERROR ||
+		    packet->exception_number == CS_ETMV4_EXC_INST_DEBUG ||
+		    packet->exception_number == CS_ETMV4_EXC_DATA_DEBUG ||
+		    packet->exception_number == CS_ETMV4_EXC_IRQ ||
+		    packet->exception_number == CS_ETMV4_EXC_FIQ)
+			return true;
+
+	return false;
+}
+
+static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq, u64 magic)
+{
+	struct cs_etm_packet *packet = etmq->packet;
+	struct cs_etm_packet *prev_packet = etmq->prev_packet;
+
+	if (magic == __perf_cs_etmv3_magic)
+		if (packet->exception_number == CS_ETMV3_EXC_SMC ||
+		    packet->exception_number == CS_ETMV3_EXC_HYP ||
+		    packet->exception_number == CS_ETMV3_EXC_JAZELLE_THUMBEE ||
+		    packet->exception_number == CS_ETMV3_EXC_UNDEFINED_INSTR ||
+		    packet->exception_number == CS_ETMV3_EXC_PREFETCH_ABORT ||
+		    packet->exception_number == CS_ETMV3_EXC_DATA_FAULT ||
+		    packet->exception_number == CS_ETMV3_EXC_GENERIC)
+			return true;
+
+	if (magic == __perf_cs_etmv4_magic) {
+		if (packet->exception_number == CS_ETMV4_EXC_TRAP ||
+		    packet->exception_number == CS_ETMV4_EXC_ALIGNMENT ||
+		    packet->exception_number == CS_ETMV4_EXC_INST_FAULT ||
+		    packet->exception_number == CS_ETMV4_EXC_DATA_FAULT)
+			return true;
+
+		/*
+		 * For CS_ETMV4_EXC_CALL, except SVC other instructions
+		 * (SMC, HVC) are taken as sync exceptions.
+		 */
+		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
+		    !cs_etm__is_svc_instr(etmq, prev_packet,
+					  prev_packet->end_addr))
+			return true;
+
+		/*
+		 * ETMv4 has 5 bits for exception number; if the numbers
+		 * are in the range ( CS_ETMV4_EXC_FIQ, CS_ETMV4_EXC_END ]
+		 * they are implementation defined exceptions.
+		 *
+		 * For this case, simply take it as sync exception.
+		 */
+		if (packet->exception_number > CS_ETMV4_EXC_FIQ &&
+		    packet->exception_number <= CS_ETMV4_EXC_END)
+			return true;
+	}
+
+	return false;
+}
+
 static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_packet *packet = etmq->packet;
 	struct cs_etm_packet *prev_packet = etmq->prev_packet;
+	u64 magic;
+	int ret;
 
 	switch (packet->sample_type) {
 	case CS_ETM_RANGE:
@@ -1206,6 +1384,43 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 					      PERF_IP_FLAG_TRACE_END;
 		break;
 	case CS_ETM_EXCEPTION:
+		ret = cs_etm__get_magic(packet->trace_chan_id, &magic);
+		if (ret)
+			return ret;
+
+		/* The exception is for system call. */
+		if (cs_etm__is_syscall(etmq, magic))
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_SYSCALLRET;
+		/*
+		 * The exceptions are triggered by external signals from bus,
+		 * interrupt controller, debug module, PE reset or halt.
+		 */
+		else if (cs_etm__is_async_exception(etmq, magic))
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_ASYNC |
+					PERF_IP_FLAG_INTERRUPT;
+		/*
+		 * Otherwise, exception is caused by trap, instruction &
+		 * data fault, or alignment errors.
+		 */
+		else if (cs_etm__is_sync_exception(etmq, magic))
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_INTERRUPT;
+
+		/*
+		 * When the exception packet is inserted, since exception
+		 * packet is not used standalone for generating samples
+		 * and it's affiliation to the previous instruction range
+		 * packet; so set previous range packet flags to tell perf
+		 * it is an exception taken branch.
+		 */
+		if (prev_packet->sample_type == CS_ETM_RANGE)
+			prev_packet->flags = packet->flags;
+		break;
 	case CS_ETM_EXCEPTION_RET:
 	case CS_ETM_EMPTY:
 	default:
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index fb5fc6538b7f..d76126e0e3d0 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -53,6 +53,50 @@ enum {
 	CS_ETMV4_PRIV_MAX,
 };
 
+/*
+ * ETMv3 exception encoding number:
+ * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
+ * table 7-12 Encoding of Exception[3:0] for non-ARMv7-M processors.
+ */
+enum {
+	CS_ETMV3_EXC_NONE = 0,
+	CS_ETMV3_EXC_DEBUG_HALT = 1,
+	CS_ETMV3_EXC_SMC = 2,
+	CS_ETMV3_EXC_HYP = 3,
+	CS_ETMV3_EXC_ASYNC_DATA_ABORT = 4,
+	CS_ETMV3_EXC_JAZELLE_THUMBEE = 5,
+	CS_ETMV3_EXC_PE_RESET = 8,
+	CS_ETMV3_EXC_UNDEFINED_INSTR = 9,
+	CS_ETMV3_EXC_SVC = 10,
+	CS_ETMV3_EXC_PREFETCH_ABORT = 11,
+	CS_ETMV3_EXC_DATA_FAULT = 12,
+	CS_ETMV3_EXC_GENERIC = 13,
+	CS_ETMV3_EXC_IRQ = 14,
+	CS_ETMV3_EXC_FIQ = 15,
+};
+
+/*
+ * ETMv4 exception encoding number:
+ * See ARM Embedded Trace Macrocell Architecture Specification (ARM IHI 0064D)
+ * table 6-12 Possible values for the TYPE field in an Exception instruction
+ * trace packet, for ARMv7-A/R and ARMv8-A/R PEs.
+ */
+enum {
+	CS_ETMV4_EXC_RESET = 0,
+	CS_ETMV4_EXC_DEBUG_HALT = 1,
+	CS_ETMV4_EXC_CALL = 2,
+	CS_ETMV4_EXC_TRAP = 3,
+	CS_ETMV4_EXC_SYSTEM_ERROR = 4,
+	CS_ETMV4_EXC_INST_DEBUG = 6,
+	CS_ETMV4_EXC_DATA_DEBUG = 7,
+	CS_ETMV4_EXC_ALIGNMENT = 10,
+	CS_ETMV4_EXC_INST_FAULT = 11,
+	CS_ETMV4_EXC_DATA_FAULT = 12,
+	CS_ETMV4_EXC_IRQ = 14,
+	CS_ETMV4_EXC_FIQ = 15,
+	CS_ETMV4_EXC_END = 31,
+};
+
 /* RB tree for quick conversion between traceID and metadata pointers */
 struct intlist *traceid_list;
 
-- 
2.20.1
