Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A434CFAE
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433685; cv=none; b=aCN6cx8c3h+1H2wY8ujLsJcLKNCpT5H7MyCvxlX1hfPE7akRzErBNIDcPDxGEtyqs3p9Nai2+Nsrw8YIT+wQTlFRTHv+dNoENOmTUwgCKE36JZaeMxktnbjuLvy8hDPZ6pgcNb34yUOv26HpaclgUpHfpBxcqkPv8ou0VMohcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433685; c=relaxed/simple;
	bh=BZheaZlvdNOGDwnHYLM4kyyCtxpqR+olfIdYle2boqs=;
	h=Date:From:Mime-Version:Content-Type:Cc:Subject:To:Message-Id; b=Z3Yw2IrMmJWtgQwgJNrat1aPjABGQ0vNgmmuSo03T2cSJZNyxGSDRi6/7CTeLjILxFJ1Qp1O5D8/+vqWTFwQlGW8N6aVsdn0J9LsRSF7nT5vAedb1cH15KTXdTOhyaAvGV1to+BkTNTYtmshfySABHy6LLqn3p0CDP3R1yTZCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I1GWJjzo; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I1GWJjzo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779433677; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6z1TYy5E0tOzgyxnPs/nOn5HdZODxSrxiWThQuif2zM=;
 b=I1GWJjzoYtY6D16U7/hkvWisew+gfGxIr4IUHBfmOk/lw/D6lhBqqYNU7MetJVBFZHdCGg
 RlZsNMLw/mqT8kVcUDbBZQKzg0+J6x8lbAsFBMIdCiREZXokiXYSj5c/nva+8noKQnfJz+
 myl8G9OGTnriWd0rzX5lE9bp9n4rQn0kJT2liQ7VLn6PpMiVFcLkcRwMJXpZgHGRC7wxkd
 jOg4HQEkrT9t23DEwQ31AUEckfIpK9LTbHdzHDwHbKga/SdUk8CWnPsCTIaIz4MChgqzQ+
 ElI6UELO8xzzuLIstx17BTJkktZfsC+Uep4WivJ/NybqkbhIFwLhFuj+Cl/flw==
Date: Fri, 22 May 2026 15:07:38 +0800
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a1000cb+439227+vger.kernel.org+qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
From: "Rui Qi" <qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Mark Rutland" <mark.rutland@arm.com>, 
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, 
	"Adrian Hunter" <adrian.hunter@intel.com>, 
	"James Clark" <james.clark@linaro.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH v2] perf: Fix off-by-one stack buffer overflow in kallsyms__parse()
X-Original-From: Rui Qi <qirui.001@bytedance.com>
To: "Peter Zijlstra" <peterz@infradead.org>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>
Message-Id: <20260522070738.31900-1-qirui.001@bytedance.com>

In kallsyms__parse(), the loop reading symbol names iterates with
i < sizeof(symbol_name), which allows i to reach sizeof(symbol_name)
upon loop exit. The subsequent symbol_name[i] = '\0' then writes one
byte past the end of the stack-allocated symbol_name[] array.

Fix this by changing the loop bound to sizeof(symbol_name) - 1, so
the null terminator always lands within the array. The overflow is
triggerable by a kallsyms entry with a symbol name of KSYM_NAME_LEN+1
or more characters (e.g., long Rust mangled names or a malicious
/proc/kallsyms).

Fixes: 53df2b934412 ("libsymbols kallsyms: Parse using io api")
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
Changes in v2:
- Added read_to_eol(&io) when a symbol name exceeds the buffer size, 
  preventing remaining characters from being parsed as the next symbol entry.
- Added Fixes tag.

 tools/lib/symbol/kallsyms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index e335ac2b9e19..0f87c654ea63 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -60,7 +60,7 @@ int kallsyms__parse(const char *filename, void *arg,
 			read_to_eol(&io);
 			continue;
 		}
-		for (i = 0; i < sizeof(symbol_name); i++) {
+		for (i = 0; i < sizeof(symbol_name) - 1; i++) {
 			ch = io__get_char(&io);
 			if (ch < 0 || ch == '\n')
 				break;
@@ -68,6 +68,9 @@ int kallsyms__parse(const char *filename, void *arg,
 		}
 		symbol_name[i]  = '\0';
 
+		if (i == sizeof(symbol_name) - 1)
+			read_to_eol(&io);
+
 		err = process_symbol(arg, symbol_name, symbol_type, start);
 		if (err)
 			break;
-- 
2.20.1
