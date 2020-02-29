From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v3 1/8] powerpc/perf/hv-24x7: Fix inconsistent output values
 incase multiple hv-24x7 events run
Date: Sat, 29 Feb 2020 14:43:49 +0530
Message-ID: <20200229091356.22157-2-kjain@linux.ibm.com>
References: <20200229091356.22157-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200229091356.22157-1-kjain@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, suka@linux.vnet.ibm.com
Cc: mark.rutland@arm.com, maddy@linux.vnet.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, mingo@kernel.org, kan.liang@linux.intel.com, ak@linux.intel.com, alexander.shishkin@linux.intel.com, anju@linux.vnet.ibm.com, mamatha4@linux.vnet.ibm.com, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, ravi.bangoria@linux.ibm.com, kjain@linux.ibm.com, jmario@redhat.com, namhyung@kernel.org, tglx@linutronix.de, mpetlan@redhat.com, gregkh@linuxfoundation.org, linux-perf-users@vger.kernel.org, jolsa@kernel.org
List-Id: linux-perf-users.vger.kernel.org

Commit 2b206ee6b0df ("powerpc/perf/hv-24x7: Display change in counter
values")' added to print _change_ in the counter value rather then raw
value for 24x7 counters. Incase of transactions, the event count
is set to 0 at the beginning of the transaction. It also sets
the event's prev_count to the raw value at the time of initialization.
Because of setting event count to 0, we are seeing some weird behaviour,
whenever we run multiple 24x7 events at a time.

For example:

command#: ./perf stat -e "{hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/,
			   hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/}"
	  		   -C 0 -I 1000 sleep 100

     1.000121704                120 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     1.000121704                  5 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     2.000357733                  8 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     2.000357733                 10 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     3.000495215 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     3.000495215 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     4.000641884                 56 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     4.000641884 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     5.000791887 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/

Getting these large values in case we do -I.

As we are setting event_count to 0, for interval case, overall event_count is not
coming in incremental order. As we may can get new delta lesser then previous count.
Because of which when we print intervals, we are getting negative value which create
these large values.

This patch removes part where we set event_count to 0 in function
'h_24x7_event_read'. There won't be much impact as we do set event->hw.prev_count
to the raw value at the time of initialization to print change value.

With this patch
In power9 platform

command#: ./perf stat -e "{hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/,
		           hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/}"
			   -C 0 -I 1000 sleep 100

     1.000117685                 93 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     1.000117685                  1 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     2.000349331                 98 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     2.000349331                  2 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     3.000495900                131 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     3.000495900                  4 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     4.000645920                204 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     4.000645920                 61 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     4.284169997                 22 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Suggested-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 573e0b309c0c..48e8f4b17b91 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1400,16 +1400,6 @@ static void h_24x7_event_read(struct perf_event *event)
 			h24x7hw = &get_cpu_var(hv_24x7_hw);
 			h24x7hw->events[i] = event;
 			put_cpu_var(h24x7hw);
-			/*
-			 * Clear the event count so we can compute the _change_
-			 * in the 24x7 raw counter value at the end of the txn.
-			 *
-			 * Note that we could alternatively read the 24x7 value
-			 * now and save its value in event->hw.prev_count. But
-			 * that would require issuing a hcall, which would then
-			 * defeat the purpose of using the txn interface.
-			 */
-			local64_set(&event->count, 0);
 		}
 
 		put_cpu_var(hv_24x7_reqb);
-- 
2.21.0
