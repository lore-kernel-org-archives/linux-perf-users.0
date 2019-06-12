From: Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v1 1/5] KVM: arm/arm64: Remove kvm_mmio_emulate tracepoint
Date: Wed, 12 Jun 2019 09:08:42 +0000
Message-ID: <1560330526-15468-2-git-send-email-yuzenghui@huawei.com>
References: <1560330526-15468-1-git-send-email-yuzenghui@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <1560330526-15468-1-git-send-email-yuzenghui@huawei.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, acme@kernel.org, linuxarm@huawei.com, acme@redhat.com, peterz@infradead.org, alexander.shishkin@linux.intel.com, mingo@redhat.com, ganapatrao.kulkarni@cavium.com, namhyung@kernel.org, jolsa@redhat.com, xiexiangyou@huawei.com
List-Id: linux-perf-users.vger.kernel.org

In current KVM/ARM code, no one will invoke trace_kvm_mmio_emulate().
Remove this TRACE_EVENT definition.

Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/trace.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
index 204d210..8b7dff2 100644
--- a/virt/kvm/arm/trace.h
+++ b/virt/kvm/arm/trace.h
@@ -114,27 +114,6 @@
 		  __entry->type, __entry->vcpu_idx, __entry->irq_num, __entry->level)
 );
 
-TRACE_EVENT(kvm_mmio_emulate,
-	TP_PROTO(unsigned long vcpu_pc, unsigned long instr,
-		 unsigned long cpsr),
-	TP_ARGS(vcpu_pc, instr, cpsr),
-
-	TP_STRUCT__entry(
-		__field(	unsigned long,	vcpu_pc		)
-		__field(	unsigned long,	instr		)
-		__field(	unsigned long,	cpsr		)
-	),
-
-	TP_fast_assign(
-		__entry->vcpu_pc		= vcpu_pc;
-		__entry->instr			= instr;
-		__entry->cpsr			= cpsr;
-	),
-
-	TP_printk("Emulate MMIO at: 0x%08lx (instr: %08lx, cpsr: %08lx)",
-		  __entry->vcpu_pc, __entry->instr, __entry->cpsr)
-);
-
 TRACE_EVENT(kvm_unmap_hva_range,
 	TP_PROTO(unsigned long start, unsigned long end),
 	TP_ARGS(start, end),
-- 
1.8.3.1
