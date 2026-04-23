Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8C386444
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776940539; cv=none; b=Ppj8iEFk6IpGNdRHZFbQhjNfRvOTAvBk/g70Uus+gg0vamjrE/xhCJ45n4HXlKAcjbag4LpcjBF6kD9kXoMnNpHj+Lhw2WGoOWFlL9Ck5j35Tu8cFkviamjuSg6NAhWR7iV4x5yuxvwxuwhahGtI98S4PXGlSgEr3IqwCV+htso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776940539; c=relaxed/simple;
	bh=xJ6Bk7I5SF1vqoFR5e+KmB+y6SkLYL+ygQiSFoOCb9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEumC56muBA37kBJad+yYdsisswpNUwiGkOKziuvoycz2WbggvpF/aFfBEA5PWO0kkhpscbbmvNY00/77fP7gJNyMrWDdy031zeNGK5YbfV8qjivoQQKP2rF10QDA9rqBf9BvNsediZJECyeDIVlIXPlLW2/R5lUAtMuhiXxDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K29FHxU0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K29FHxU0"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so2463850b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776940537; x=1777545337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTOiYWe3w6Vu7hnJzTQ5ZvV3Qw4Abvs4TqqonSRF/2M=;
        b=K29FHxU0lSIKoIjXxp9yaGJNDlzI6KKqUix0JiXS21JXcr2GrysNb5TlGb0rgbAkb4
         EXRafH2sOQaacB1UPlNUCvet1/AVTzBLHaaf3nadvWoALvFMLvzTKLdVCj7y273wwXQk
         ngkoVRxcXdjKCK7N7xHuoZQNAS4dpQnSUmjddLOFqeeDpBgOJTC+Eh09Kj4+omlLGoZK
         d0OKTB2FT1/j/woDrfBMfIxl3ftjYh5+FaR4WkN2qbEmB/0jRzhn/ans1ERexKXArS0C
         ILzvPGaqQjbirDtrtgQ+422jZJYjZht0di2Vcw31HlpjfhoQzK+LWXJKMwhze5ouDzB7
         U9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776940537; x=1777545337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTOiYWe3w6Vu7hnJzTQ5ZvV3Qw4Abvs4TqqonSRF/2M=;
        b=c5DIYy+cWqgI3XDcPBZHrI7Nyn0X4MQJneTsCSnWK3wbvzYwqPX3StOjKJyRCqYPx2
         bjRDbMojXvUqH5DWJ4ZxAxaZtXG/Jic4BnJmsCV6/47O+jYiQDq8LLc5QXwUPh0SVyzp
         +lWxF5ZgNq38aJosAE1ZaT3yVlNF6p7jGd6hp0kRLXOjMXSOVMiHVK97fSU/V/C4jQVk
         Q4Ege/1S/WqtJeRGMJMqRQVue1LqQomq7uJ785X8ffBLGh6XPXW1E2/ulgXFEiGdns5v
         HUpjN9Iok8lJBHrc/sUMIhF5nfGl9WouDyp6hrtt4L+diKA6vMwh7D8yVuWABCkCRmF4
         HgDQ==
X-Gm-Message-State: AOJu0YwDtEsAq7IzYvMLHOaTk0NrVeDFlOdRkhjVfLCA90oeh0Cv9va1
	qN5CBrpCIdVwaV26iaRjTd4MhhaZKBejsa+SyO/DxcbYhIqxG50bhAlc
X-Gm-Gg: AeBDievIHe6VPf1QggjBSZbe0RO3fCIjd3DlhboPVQcBiaKIHjEb/8FiImxNukAZXyU
	KQ0ThYGDXnMt9vvurVMPZCdNOlDFMqUeQbncN2bR0GsRYJ4l4yIWGDOHfw6TwMrffaBeUmXsbbc
	GbG4qBTnMuUjQrZAhueBH0l/e3DoryMhOAJXOJRBIB71mHck2WjL1i+dUNUXfDJGsMO5q6KX46O
	rt/XyCyn6KyKduDTsDJW8zO+hW7XLf0+cxV5uLQq+UFLBxgXfKRauax8z+6Mi3bbI/OV+y4AWbs
	d3FIjZ4JwPqcKUi5x9XihX3x9GIEXUmLwTvjBzuPCldvDKZD9Hq8Dl/KsUKD/H1Uw6IJ7zhdCCV
	iupmfkSFeZhGVtRBkcovmjDJ0E5CZGOMXBQ8nSwZ91mlnZJR8NRYtl49t3LsYnRlPy2GS+nCAGl
	pKe4NbHf1itiWXe4sSHGpjFkX9SpSRTPN8jdQXQtyDekDWvJtzS0cPcoA=
X-Received: by 2002:a05:6a00:1749:b0:82c:d7c4:4c6b with SMTP id d2e1a72fcca58-82f8c81dd75mr27533723b3a.11.1776940537240;
        Thu, 23 Apr 2026 03:35:37 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb38f2sm19099318b3a.30.2026.04.23.03.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:35:36 -0700 (PDT)
From: Jianping Liu <frankljpliu@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	wangming01@loongson.cn,
	wangrui@loongson.cn,
	frankljpliu@gmail.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianping Liu <frankjpliu@tencent.com>
Subject: [PATCH v2] perf annotate: Fix NULL pointer dereference in loongarch_call__parse
Date: Thu, 23 Apr 2026 18:35:30 +0800
Message-ID: <20260423103530.3938202-1-frankljpliu@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianping Liu <frankjpliu@tencent.com>

loongarch_call__parse() dereferences the return value of strchr()
without NULL check:

  name = strchr(endptr, '<');
  name++;

When objdump output for a 'bl' (branch-and-link) instruction does not
contain a symbol name delimited by '<' and '>' (e.g., when the call
target has no associated symbol), strchr() returns NULL, and the
subsequent name++ produces a wild pointer (0x1). This leads to a
segmentation fault when strchr() is later called with this invalid
pointer:

  #0  __strchr_lasx () from /lib64/libc.so.6
  #1  loongarch_call__parse () at arch/loongarch/annotate/instructions.c:29
  #2  disasm_line__init_ins () at util/annotate.c:1205
  ...

The objdump line triggering the crash looks like:

  bl              98824   # 0x9000000000641ea0

Note the absence of "<function_name>" after the address.

Rather than aborting parse with -1 (which would clear dl->ins.ops and
lose the is_call attribute, preventing the TUI from drawing branch
arrows and navigating the call), follow the same pattern as the generic
call__parse() in util/disasm.c: when the symbol name is absent, jump to
the address-based symbol lookup so that ops->target.sym can still be
resolved via maps__find_ams() using the already-parsed target address.
This preserves is_call semantics and keeps TUI navigation working.

---
Changes from v1:
- Instead of returning -1 when the '<sym>' token is absent jump to the
  address-based symbol lookup so that maps__find_ams() can still resolve
  ops->target.sym from the already parsed target address.

- Link to v1: https://lore.kernel.org/all/20260423053102.3717015-1-frankljpliu@gmail.com/
---

Fixes: 4ca0d340ce20 ("perf annotate: Fix instruction association and parsing for LoongArch")
Signed-off-by: Jianping Liu <frankjpliu@tencent.com>
Reviewed-by: Ming Wang <wangming01@loongson.cn>
---
 tools/perf/util/annotate-arch/annotate-loongarch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index c2addca77320..a949b4392dd4 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -29,6 +29,9 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 	ops->target.addr = strtoull(c, &endptr, 16);
 
 	name = strchr(endptr, '<');
+	if (name == NULL)
+		goto find_target;
+
 	name++;
 
 	if (arch->objdump.skip_functions_char &&
@@ -46,6 +49,7 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 	if (ops->target.name == NULL)
 		return -1;
 
+find_target:
 	target = (struct addr_map_symbol) {
 		.ms = { .map = map__get(map), },
 		.addr = map__objdump_2mem(map, ops->target.addr),
-- 
2.43.7

