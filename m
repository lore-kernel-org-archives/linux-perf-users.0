Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76B2AB4
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 19:37:49 -0800 (PST)
Received: from localhost.localdomain (unknown [10.190.70.5])
	by mail-app2 (Coremail) with SMTP id by_KCgBHvdS4mG5l3TBKAA--.35678S4;
	Tue, 05 Dec 2023 11:28:00 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/uncore: fix a potential double-free in uncore_type_init
Date: Tue,  5 Dec 2023 11:27:09 +0800
Message-Id: <20231205032709.9525-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgBHvdS4mG5l3TBKAA--.35678S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWfGr13Aw17Aw47AryrJFb_yoWkArX_WF
	1UJaykJr4Ska95W348AFW5Grn7Kw48Z3yrGr1FqF4kAry5tF1DCFs7Gr9ayw4xWrWDZFW8
	ArZxKr1jvw18AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoTBmVsUQg4xgAMs-
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

When kzalloc for pmus[i].boxes fails, we should clean up pmus
to prevent memleak. However, when kzalloc for attr_group fails,
pmus has been assigned to type->pmus, and freeing will be done
later on by the callers. The chain is: uncore_type_init ->
uncore_types_init -> uncore_pci_init -> uncore_types_exit ->
uncore_type_exit. Therefore, freeing pmus in uncore_type_init
may cause a double-free. Fix this by setting type->pmus to
NULL after kfree.

Fixes: 629eb703d3e4 ("perf/x86/intel/uncore: Fix memory leaks on allocation failures")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 01023aa5125b..d80445a24011 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1041,6 +1041,7 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 	for (i = 0; i < type->num_boxes; i++)
 		kfree(pmus[i].boxes);
 	kfree(pmus);
+	type->pmus = NULL;
 
 	return -ENOMEM;
 }
-- 
2.17.1

