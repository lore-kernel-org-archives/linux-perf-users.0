From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v2 5/8] powerpc/hv-24x7: Update post_mobility_fixup() to
 handle migration
Date: Fri, 21 Feb 2020 11:40:19 +0530
Message-ID: <20200221061022.3047-6-kjain@linux.ibm.com>
References: <20200221061022.3047-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200221061022.3047-1-kjain@linux.ibm.com>
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
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, suka@us.ibm.com
Cc: mark.rutland@arm.com, ravi.bangoria@linux.ibm.com, maddy@linux.vnet.ibm.com, tglx@linutronix.de, jmario@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org, mpetlan@redhat.com, alexander.shishkin@linux.intel.com, linux-perf-users@vger.kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, anju@linux.vnet.ibm.com, mamatha4@linux.vnet.ibm.com, kjain@linux.ibm.com, jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org, kan.liang@linux.intel.com
List-Id: linux-perf-users.vger.kernel.org

Function 'read_sys_info_pseries()' is added to get system parameter
values like number of sockets and chips per socket.
and it gets these details via rtas_call with token
"PROCESSOR_MODULE_INFO".

Incase lpar migrate from one system to another, system
parameter details like chips per sockets or number of sockets might
change. So, it needs to be re-initialized otherwise, these values
corresponds to previous system values.
This patch adds a call to 'read_sys_info_pseries()' from
'post-mobility_fixup()' to re-init the physsockets and physchips values.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index b571285f6c14..226accd6218b 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -371,6 +371,18 @@ void post_mobility_fixup(void)
 	/* Possibly switch to a new RFI flush type */
 	pseries_setup_rfi_flush();
 
+	/*
+	 * Incase lpar migrate from one system to another, system
+	 * parameter details like chips per sockets and number of sockets
+	 * might change. So, it needs to be re-initialized otherwise these
+	 * values corresponds to previous system.
+	 * Here, adding a call to read_sys_info_pseries() declared in
+	 * platforms/pseries/pseries.h to re-init the physsockets and
+	 * physchips value.
+	 */
+	if (IS_ENABLED(CONFIG_HV_PERF_CTRS) && IS_ENABLED(CONFIG_PPC_RTAS))
+		read_sys_info_pseries();
+
 	return;
 }
 
-- 
2.18.1
