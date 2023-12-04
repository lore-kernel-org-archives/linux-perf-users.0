Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B582113
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 00:21:02 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
	by gateway (Coremail) with SMTP id _____8AxDOvsi21lc7I+AA--.54643S3;
	Mon, 04 Dec 2023 16:21:01 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.120])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxzdzri21loxJUAA--.54592S2;
	Mon, 04 Dec 2023 16:20:59 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org
Cc: alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH v2] tools/perf: Fix malloc call for new -Walloc-size
Date: Mon,  4 Dec 2023 16:20:55 +0800
Message-Id: <20231204082055.91877-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Dxzdzri21loxJUAA--.54592S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFW3Kr1xWrW7XFy3AryUXFc_yoWkJFb_ua
	1Iqrn7AryUCr9FyrWDua95Xr1Fga1fuan09FnIq3WfJrn8t3Z09as8ZF9rZF45Gr4qkrZ7
	Zws3Gry5Zr42kosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU

From: Sun Haiyong <sunhaiyong@loongson.cn>

GCC 14 introduces a new -Walloc-size included in -Wextra which errors out
like:
```
builtin-top.c: In function ‘prompt_integer’:
builtin-top.c:360:21: error: allocation of insufficient size ‘0’ for
type ‘char’ with size ‘1’ [-Werror=alloc-size]
  360 |         char *buf = malloc(0), *p;
      |                     ^~~~~~

```

So, just set it to NULL, silence this error.

Signed-off-by: Sun Haiyong <sunhaiyong@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
v2:

* Refer to Namhyung's comment and set it to NULL.

 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eee..3960c4d15eff 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -357,7 +357,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
 
 static void prompt_integer(int *target, const char *msg)
 {
-	char *buf = malloc(0), *p;
+	char *buf = NULL, *p;
 	size_t dummy = 0;
 	int tmp;
 
-- 
2.31.4

