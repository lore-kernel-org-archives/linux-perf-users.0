Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F53BCD2C
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362094; cv=none; b=IXew5nvyR84qdi2Jx/v/UWFIPOoZvaOdblwlcksZ12t6+cmOfDxGw4mj1soVjDezEhYPr8Qw0ihbfbhUk21+tHw0L73A00T4nTXPh/JqeeU4xpOI8BlDpNgXxigmjz8d7UBgGCB5aaKtrdmB7aOIEVo3sBl4KtCrE4Ttj6DjZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362094; c=relaxed/simple;
	bh=8MQncbk3PkKdWLQOQBcSX2uFmzw7dIsaDKTVDxl4RUY=;
	h=To:From:Message-Id:Cc:Date:Content-Type:Subject:Mime-Version; b=UFZCgybCWiG1J+It5BurzAOKAq5etPz11xxuH241ZBqM+nS32UGe/GKIeLhar3hGk2q5uJKpj7kVdL5cR4SXNWEF5OJYFG+i4Twiw4s8Wl9ZRisfbmBs/2ym980ZPdssi6F6oGw3RPResHp9JQJL7dWR5T+qI3dGwe8GQPmBiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ppbmf3D9; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ppbmf3D9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779362086; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=d7ZCh8m2voWK3gzcY2pJKmDWXfZxjO+ytTGSGQ+ql5I=;
 b=Ppbmf3D9jN2akvssgmPrb7FLkzeB7wVpTuKiI8w7Zru+RUBU8/e8VjZsDU4kTydsBJy2eW
 fQDYhc2waVDbRYMdtUuO5vlFpi+DniZ1Y63xkDfYbBo0oyt9g4vlGGjgika0m580vhfPOh
 4MC2Fcvh5CSeHNkC6FeqbdakuzgwRPCazjzUisR7iQ+eF7HEo6ph7k+OWrpO/Y2niG0YzL
 uDrYibFWZoXGh8euaDFvOwFLcYgejp7maulUuQmTzmRrHFHDkySn9RcMpVkmL1r+PLF91e
 7EelpfODmU896jKrmLGj81kb7twPqop8YRNZK3D9y84GA6VUh8E5WElE3gKuHw==
Content-Transfer-Encoding: 7bit
To: "Peter Zijlstra" <peterz@infradead.org>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Namhyung Kim" <namhyung@kernel.org>
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260521111429.4042238-1-qirui.001@bytedance.com>
Cc: "Mark Rutland" <mark.rutland@arm.com>, 
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, 
	"Adrian Hunter" <adrian.hunter@intel.com>, 
	"James Clark" <james.clark@linaro.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
Date: Thu, 21 May 2026 19:14:29 +0800
X-Lms-Return-Path: <lba+26a0ee924+cd3296+vger.kernel.org+qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] perf: Fix off-by-one stack buffer overflow in kallsyms__parse()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>

In kallsyms__parse(), the loop reading symbol names iterates with
i < sizeof(symbol_name), which allows i to reach sizeof(symbol_name)
upon loop exit. The subsequent symbol_name[i] = '\0' then writes one
byte past the end of the stack-allocated symbol_name[] array.

Fix this by changing the loop bound to sizeof(symbol_name) - 1, so
the null terminator always lands within the array. The overflow is
triggerable by a kallsyms entry with a symbol name of KSYM_NAME_LEN+1
or more characters (e.g., long Rust mangled names or a malicious
/proc/kallsyms).

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 tools/lib/symbol/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index e335ac2b9e19..f7100d43ecf4 100644
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
-- 
2.20.1
