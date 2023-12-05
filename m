X-Greylist: delayed 19918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 01:09:37 PST
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07B53D3
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 01:09:37 -0800 (PST)
Received: from localhost.localdomain (unknown [10.190.70.5])
	by mail-app3 (Coremail) with SMTP id cC_KCgDnXXGo6G5lrSx1AA--.843S4;
	Tue, 05 Dec 2023 17:09:04 +0800 (CST)
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
Subject: [PATCH] [v2] perf/x86/uncore: fix a potential double-free in uncore_type_init
Date: Tue,  5 Dec 2023 17:08:35 +0800
Message-Id: <20231205090835.1652-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgDnXXGo6G5lrSx1AA--.843S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry5XFyktw15CFWrCFWUCFg_yoW8JFyfpr
	WUJr1fKF18uan2grZ8G3WfXr4Ykws7Gr95Wr4Uu34xKF13Xw13tF4Ikr4Y9w1kCrW0yFyr
	JFyFvr4UJa4UXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
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
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoTBmVsUQg4xgATsg
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

When kzalloc for pmus[i].boxes fails, we should clean up pmus
to prevent memleak. However, when kzalloc for attr_group fails,
pmus has been assigned to type->pmus, and freeing will be done
later on by the callers. The chain is:

uncore_pci_init
  |->uncore_types_init
  |    |->uncore_type_init (first free)
  |
  |->uncore_types_exit
       |->uncore_type_exit (second free)

Therefore, freeing pmus in uncore_type_init may cause a
double-free. Fix this by setting type->pmus to NULL after kfree.

Fixes: 629eb703d3e4 ("perf/x86/intel/uncore: Fix memory leaks on allocation failures")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---

Changelog:

v2: Improving the call trace description.
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

