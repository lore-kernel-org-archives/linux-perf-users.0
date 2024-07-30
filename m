Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29F16A921;
	Tue, 30 Jul 2024 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320589; cv=none; b=KPjxIP8WAvIgrPFzdIFu5I4HBdQ4rFQ2A4N3jzLAKp8NacOZY4lVZJz9qAXaH1QtWAsEzrm+qVLvKGoJ2yxfvQWQUhlIhuke7G0GCd6c+9mGjbVfcH/TLHfAOzd9Mx/mqiTeWA3U0a50n8vPyIxEiWhwf+nhpzYgYy3/2jZes18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320589; c=relaxed/simple;
	bh=68Z0ev5O8qNeVBCiiLxDXkPE6X/fm/ltYuf2azXCuJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S42Diu4FUs+UWYwphV1tYy4VxY61YBi8h871UCEPtBRyOmRcQc07YDYYkqPaFy0gVJGRDVmYlpdpr19bpVfuXPbDPKMtxPejs2uUVQUTLidx6FpMzZztae8ge547USPUhNUxvhNvmKVDCxD0dbqoDlUzNSmCstt69EcUpNHjeD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx+enJhqhmG0UEAA--.14739S3;
	Tue, 30 Jul 2024 14:23:05 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxRuTGhqhmAhgGAA--.30579S4;
	Tue, 30 Jul 2024 14:23:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf list: Give clues if failed to open tracing events directory
Date: Tue, 30 Jul 2024 14:23:01 +0800
Message-ID: <20240730062301.23244-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240730062301.23244-1-yangtiezhu@loongson.cn>
References: <20240730062301.23244-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxRuTGhqhmAhgGAA--.30579S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1DGF1DJr1rJF4UAr15WrX_yoW5Jr1Upr
	s5CrnIkrn5Jw4UG34xJF1rury3CrZ7ur1a9rykCw4ayFZ3XFs0vF4Ikr1YvF13Jr1UJ34S
	qa1q9r4kCrW8XFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jz2NtUUUUU=

When executing the command "perf list", I met "Error: failed to open
tracing events directory" twice, the first reason is that there is no
"/sys/kernel/tracing/events" directory due to it does not enable the
kernel tracing infrastructure with CONFIG_FTRACE, the second reason
is that there is no root privileges.

Add the error string to tell the users what happened and what should
to do, and also call put_tracing_file() to free events_path a little
later to avoid messy code in the error message.

At the same time, just remove the redundant "/" of the file path in
the function get_tracing_file(), otherwise it shows something like
"/sys/kernel/tracing//events".

Before:

  $ ./perf list
  Error: failed to open tracing events directory

After:

(1) Without CONFIG_FTRACE

  $ ./perf list
  Error: failed to open tracing events directory
  /sys/kernel/tracing/events: No such file or directory

(2) With CONFIG_FTRACE but no root privileges

  $ ./perf list
  Error: failed to open tracing events directory
  /sys/kernel/tracing/events: Permission denied

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/lib/api/fs/tracing_path.c | 2 +-
 tools/perf/util/print-events.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 30745f35d0d2..834fd64c7130 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -69,7 +69,7 @@ char *get_tracing_file(const char *name)
 {
 	char *file;
 
-	if (asprintf(&file, "%s/%s", tracing_path_mount(), name) < 0)
+	if (asprintf(&file, "%s%s", tracing_path_mount(), name) < 0)
 		return NULL;
 
 	return file;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 3f38c27f0157..81e0135cddf0 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -68,11 +68,12 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 	struct dirent **sys_namelist = NULL;
 	int sys_items;
 
-	put_tracing_file(events_path);
 	if (events_fd < 0) {
 		pr_err("Error: failed to open tracing events directory\n");
+		pr_err("%s: %s\n", events_path, strerror(errno));
 		return;
 	}
+	put_tracing_file(events_path);
 
 	sys_items = tracing_events__scandir_alphasort(&sys_namelist);
 
-- 
2.42.0

