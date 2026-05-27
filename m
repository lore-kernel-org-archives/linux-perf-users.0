Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287F2E6116
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868661; cv=none; b=syvxjHy+vySln2/poJiZHDTbIUxVFmVAza1fREia+a8GJIvegWElQlhoIDO5bKKWmS3H8/Wi0B5N+uuSyq6c8DgmibcHdeCclbbNNVB4UxQjsgGUfX5Sj8HwJL3RPQ5hHH/red2W4jcNvTZG/7324Z6Gy7guyP8bBgj58A7YAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868661; c=relaxed/simple;
	bh=sB8lPGWD1DfVrrJ+Dvc46nu00meWYwPmxK8tVGR6r6w=;
	h=Cc:Subject:Date:In-Reply-To:To:Mime-Version:From:Message-Id:
	 References:Content-Type; b=DUs24IHCBkb26d0aHIf+WDo90cao58IAWO5VcUZgEr85MH3y674pZYdzTWmYE9w7p53UvrY5yVU56XoAqulzYPRl0jqQ8GKyMgVMdKonjtGKwiPGwGPk2SD/q4ZQgFZQ+W6vvw+PNRus7++4xhAbA70Uo09tX2sdNmMpN+oDmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=mHuuWNls; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="mHuuWNls"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779868654; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EzAqVnPXXfFeony1PZV7lcZnibd4znJbLgx5j4usx2Q=;
 b=mHuuWNls4fpIumt4Tsw35XaePszW6MzW7Oj75tqtYDqEXTefgCxf2ErKyDWqA8a5BD5UZH
 IOf/lpW9PHj6dYhoQKie0/6sBQyCP02h/1bOFTHp5UDde87c4y+M4ler4WWh+VLkYf81EU
 jOTn/iotroUanT+1qyhi4p52hMn5zDNansM9KzA8QHYtAm2vYj7GxzQ6d2U+7gPvxPwezu
 JnxTu1RsdEzhKOeTUYVk29VqQ2HhmMu4lwsuVUSe24USGDtLgIRjSvQd1WTF/x2+8qVchu
 jrvEH5mD1fVxqVFIkl36bufmztUayK75KQq3vRexSiQRCS1F316as5Fp89EMfQ==
Cc: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>, 
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>, 
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>, 
	<james.clark@linaro.org>, <linux-perf-users@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH v3] perf: Fix off-by-one stack buffer overflow in kallsyms__parse()
Date: Wed, 27 May 2026 15:57:16 +0800
Content-Transfer-Encoding: 7bit
In-Reply-To: <ahUAyRcMsJv4_W_Y@google.com>
To: <namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+26a16a3ec+9916f2+vger.kernel.org+qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260527075716.1642712-1-qirui.001@bytedance.com>
References: <ahUAyRcMsJv4_W_Y@google.com>
Content-Type: text/plain; charset=UTF-8

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
index e335ac2b9e19..198bfc7c1f63 100644
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
 
+		if (i == KSYM_NAME_LEN)
+			read_to_eol(&io);
+
 		err = process_symbol(arg, symbol_name, symbol_type, start);
 		if (err)
 			break;
-- 
2.20.1
