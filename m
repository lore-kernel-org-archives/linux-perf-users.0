Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C25D36BCF6;
	Fri,  6 Mar 2026 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770332; cv=none; b=c1ec7uqjhZwDcjrRtC3ycNZ9cFWj+kzb7PcjIhcc9hkatQ29sCUAAUaASuVI2PCuffSfVqbG/SopkeY7MDq9mHH6Svl2Jr6EDcdlNhMEGZQENOTsh+1eFoeWJz3y/lKity2JVSAbL8GPiDVasVyVnNAe+KzUp5KzRmr1SF3KoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770332; c=relaxed/simple;
	bh=4CJu3/4PEhIlraIF/x5LUF38XxPT9ZU2g8ykGWzvP7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FXskCdy8hbxRuxud/wqpCN0kGZVnltdZe2/vSXvbsJAnK2uFMqOzAO6TC4HXCgbZYNrTg6nHROm6lwZ/leJ59GdbQTGnjlTd/ldSouhLATAhg3hpEcmNPtSXFj6EPcnX1NHFs8euzViPx6uv9YAHOrORFTv7gciOldDd7sKP4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABnS+IIVKppML3qCQ--.18342S2;
	Fri, 06 Mar 2026 12:11:53 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] perf ftrace: Fix hashmap__new() error checking
Date: Fri,  6 Mar 2026 12:10:52 +0800
Message-Id: <20260306041052.1266836-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnS+IIVKppML3qCQ--.18342S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1fXFyxCF48CrW8Zr1fJFb_yoW8GFWfpa
	s8CF4kC398AFs8Kw1q9F1avF1DGr9rJry8X3sFga98Z3s8trn5J342yFWFqF48X3929347
	Aay7ua1rtr48ZF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYfOzDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The hashmap__new() function never returns NULL, it returns error
pointers. Fix the error checking to match.

Additionally, set ftrace->profile_hash to NULL on error, and return the
exact error code from hashmap__new().

Fixes: 0f223813edd0 ("perf ftrace: Add 'profile' command")
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changes in v2:
- Set ftrace->profile_hash to NULL on error
- Return PTR_ERR(ftrace->profile_hash) instead of -ENOMEM
- Update commit message
---
 tools/perf/builtin-ftrace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6b6eec65f93f..4cc33452d79b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -18,6 +18,7 @@
 #include <poll.h>
 #include <ctype.h>
 #include <linux/capability.h>
+#include <linux/err.h>
 #include <linux/string.h>
 #include <sys/stat.h>
 
@@ -1209,8 +1210,12 @@ static int prepare_func_profile(struct perf_ftrace *ftrace)
 	ftrace->graph_verbose = 0;
 
 	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
-	if (ftrace->profile_hash == NULL)
-		return -ENOMEM;
+	if (IS_ERR(ftrace->profile_hash)) {
+		int err = PTR_ERR(ftrace->profile_hash);
+
+		ftrace->profile_hash = NULL;
+		return err;
+	}
 
 	return 0;
 }
-- 
2.25.1

