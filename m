Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C131F993
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949465; cv=none; b=OfGWmxiKMXAilFi2ZNfLHp1OOdjwNxtx8wF29JPPdC46Lh1Eiw8NlXa/TXstHkLLpGLMFrXQ75BgQ1WVoYUu5ydwErGqerUm9Y+bowyeMhsecsMXJq+gWmPMJukX4VFPpV4XxUXJtq98P8O5I3yOHoHqMB495KqWKywgpxXEkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949465; c=relaxed/simple;
	bh=L4OwX7EOOcFILlkX7Bso+5/s3EcBVS14i8bw+vOWz5A=;
	h=Cc:Date:In-Reply-To:Subject:Mime-Version:To:Content-Type:From:
	 Message-Id:References; b=nAxdA+Kwd5TMS59nVweQ9X5XBH9bzEVtb0EF0oEOx7Wrs28B50v9Jcu/5/1btQFgqz2AIN6KaeKmQJzKZ0t9pv/+6po3GSgWOjt1lUPzyMhyx43KHh3aLVEWukn5xk54XP4HPrWXVD7hkVgDoWy6/UhH0tbpYPHWAPc258sfMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JdLk8pQ2; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JdLk8pQ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779949452; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=a690jNWvfJDoDqNgVEkoqe/wZ0bPpMJOvhDbSdRwRQw=;
 b=JdLk8pQ2ZcR65HR/Htdn1GeseOPyfgShb9Y0kJNzxLTmkpnAue9IL3EW18flpbA5OD2a4p
 eUfprX/uPRXI6Q7izgRcFISpmjNshgUAii/W7kz9wBNZvxtjTyu+OqiI2uf84hKfH+QkF6
 GTh2ILtR9fuI9CRK1/75TgFCUCg0NMqIffIjA7OUuwfSTfsvxVOceps5SmVgPzGjTfVBaU
 7S4SLTAzyBvzKyWMWGSx5BlbS1d6SsdU6tdXN7cGgoR2P6mjmcHhOU95hOcT17WOaxfero
 25IY9PS4YmrwnebmHV1nczXZdhlW0GtxzZogg6jfabB1N2wSGUtRESwWxpdq9Q==
Cc: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>, 
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>, 
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>, 
	<james.clark@linaro.org>, <linux-perf-users@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
Date: Thu, 28 May 2026 14:23:55 +0800
In-Reply-To: <ahcrYd2xj1gWvl0m@google.com>
Subject: [PATCH v4] perf: Fix off-by-one stack buffer overflow in kallsyms__parse()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.20.1
To: <namhyung@kernel.org>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260528062355.2320045-1-qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+26a17df8a+361e34+vger.kernel.org+qirui.001@bytedance.com>
References: <ahcrYd2xj1gWvl0m@google.com>

In kallsyms__parse(), the loop reading symbol names iterates with
i < sizeof(symbol_name), which allows i to reach sizeof(symbol_name)
upon loop exit. The subsequent symbol_name[i] = '\0' then writes one
byte past the end of the stack-allocated symbol_name[] array.

Fix this by changing the loop bound to KSYM_NAME_LEN, so
the null terminator always lands within the array. The overflow is
triggerable by a kallsyms entry with a symbol name of KSYM_NAME_LEN+1
or more characters (e.g., long Rust mangled names or a malicious
/proc/kallsyms).

Fixes: 53df2b934412 ("libsymbols kallsyms: Parse using io api")
Signed-off-by: Rui Qi <qirui.001@bytedance.com>

---

Changes in v4:
- Use KSYM_NAME_LEN for the loop bound as well, as suggested by Namhyung.

Changes in v3:
- Use KSYM_NAME_LEN instead of sizeof(symbol_name) - 1 for the
  overflow check, as suggested by Namhyung.

Changes in v2:
- Added read_to_eol(&io) when a symbol name exceeds the buffer size,
  preventing remaining characters from being parsed as the next symbol entry.
- Added Fixes tag.
---
 tools/lib/symbol/kallsyms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index e335ac2b9e19..d64bd9cc82a9 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -60,7 +60,7 @@ int kallsyms__parse(const char *filename, void *arg,
 			read_to_eol(&io);
 			continue;
 		}
-		for (i = 0; i < sizeof(symbol_name); i++) {
+		for (i = 0; i < KSYM_NAME_LEN; i++) {
 			ch = io__get_char(&io);
 			if (ch < 0 || ch == '\n')
 				break;
@@ -68,6 +68,9 @@ int kallsyms__parse(const char *filename, void *arg,
 		}
 		symbol_name[i]  = '\0';
 
+		if (i == KSYM_NAME_LEN)
+			read_to_eol(&io);
+
 		err = process_symbol(arg, symbol_name, symbol_type, start);
 		if (err)
 			break;
-- 
2.20.1
