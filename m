Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022233CC2;
	Tue, 16 Jul 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116038; cv=none; b=qVigWZiPT4XWy8NP+pQ5+dPs+xl4jye5aXhYKmLdvFhbgZ0CpPgl4iZ2+dsadlOrVY7Ufa1nIRIW09k90oRmEHlkJMN1OeqTZsUvOlUZemC3vYqjTskcUA5oWeBYn7DPlVJzujQac2V3RngcA9AhaFlc/RTzmJoWDAmgpNQ6BFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116038; c=relaxed/simple;
	bh=Vpvhwa4qsodndTy7NBdg3aScGILEzlRJFwZ4g9/7nc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8aMMTtCwaQxNEjFXOqOkx5DD5ZW2UQx6Z3Rih3KONKa9jstktEA+GmJXEI62nEfJYlgPjCmlfdUi5QXkYHbEAFQIEXyMizvApTKhqMxJbtkBjusLreP90Z/jg9kn8x4ZcnygsfTiOej6GS8yTw+j8f+YcytHb48XKdOtqJk72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAB3f7drJZZmlIuWAw--.54428S2;
	Tue, 16 Jul 2024 15:46:52 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf daemon: Convert comma to semicolon
Date: Tue, 16 Jul 2024 15:43:40 +0800
Message-Id: <20240716074340.968909-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3f7drJZZmlIuWAw--.54428S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZrW7Aw17Zw18uryxAFb_yoW3ArX_uw
	n7WryxZ3s8urZFyryak3yrZry8tan8AF4vqFZYgF47tayDAF1qvF97Xr9rXFyYq3yvkF9x
	uws8Jw4jgr4UujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbJDG5UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: 2d6914cd59ff ("perf daemon: Add 'signal' command")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/perf/builtin-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index de76bbc50bfb..18f7f417ba11 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1433,7 +1433,7 @@ static int __cmd_signal(struct daemon *daemon, struct option parent_options[],
 	}
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.signal.cmd = CMD_SIGNAL,
+	cmd.signal.cmd = CMD_SIGNAL;
 	cmd.signal.sig = SIGUSR2;
 	strncpy(cmd.signal.name, name, sizeof(cmd.signal.name) - 1);
 
-- 
2.25.1

