Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5287D40
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 18:33:04 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
	by gateway (Coremail) with SMTP id _____8CxfOpfl2plZVU+AA--.31446S3;
	Sat, 02 Dec 2023 10:33:03 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.120])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxK9xdl2pl4CJSAA--.50484S2;
	Sat, 02 Dec 2023 10:33:02 +0800 (CST)
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
Subject: [PATCH] objtool/perf: Fix malloc call for new -Walloc-size
Date: Sat,  2 Dec 2023 10:32:56 +0800
Message-Id: <20231202023256.3398906-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxK9xdl2pl4CJSAA--.50484S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFW3Kr1xWrW7XFy3AryUXFc_yoWDuFg_ua
	1xX34vyryUCr9Fkr4UuaykAr1Fga1fZFs09Fnxtw13JF1Ut3Z0ga4DZF9rZF4fKr4qkrZ3
	Zws5GryUZr42kosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOxhLUUUUU=

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

So, just cast type to char, silence this error.

Signed-off-by: Sun Haiyong <sunhaiyong@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eee..29191d966522 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -357,7 +357,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
 
 static void prompt_integer(int *target, const char *msg)
 {
-	char *buf = malloc(0), *p;
+	char *buf = (char *)malloc(0), *p;
 	size_t dummy = 0;
 	int tmp;
 
-- 
2.42.1

