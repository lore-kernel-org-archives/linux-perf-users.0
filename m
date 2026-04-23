Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6136494A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776922276; cv=none; b=IAybxXDfov1nztZ99VNJRU16KJYc/DGA4r1trA8gjNZSnyb824tbdpBjsUQOBC11olUYsEWZHJc4N3Vi8svQVhIFwS494vnS+JbbYJsWOFqcfoc+d2g1B/KvcoOLf7oOaIkmAfeBolGzDzJaN4wqOyzcE7Mr4efI8bQfFMt08N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776922276; c=relaxed/simple;
	bh=ixNZgL6I+s9Q7NnsT9wVdgFw1Ll16T9Sj/4u6fVFle8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JRloG882DUe2/5N2NZ4juacvedFreA3SQ3qRFcSyglRIE11QCPef97i5+E5/fYGmuYfNgE8qafL8ZmuZTnPDfYs/B+lx0eYamwYIp9QORjnY9mJBTn9sDub8ukEb8KD9c4Y3z717n5V3/McOSQQ6Y7DkIA7zawhefcTbfsg86BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB8YX9Iv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB8YX9Iv"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso1596580a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 22:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776922275; x=1777527075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/FD1FV0ffYsy3LxXhovkzmPDGgobrJWkZafkNu/+vQ=;
        b=gB8YX9IvCCfYnE2D/p+WBqgqZ9NCa1N3g91O+hKw604NwyqjScAzy9dADLgojN2YSM
         IAPl+SDOZVEu92i25NQAj/qNarF224YJKesS8050p5clv8Kh4xPOAvhtK2+qbmx6hyTl
         obdWLd6AcIihMLItsXao+i8Rou3TY3Se4fIMQx+cJoh5igbmMJIUh2wh95E/GIybr12B
         MJCvaCo8gNWRpA0ROH8YPurjLEMq59r5O3GqFzVN7eQhMMe+wRclJMKby4A5tli50iIm
         DVeL18opj6uraMjbJrOEn6hEY6BqNH97tmau2A5fQpVmkT8KAZu/f9HW2l0Af0sg+P4k
         +yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776922275; x=1777527075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/FD1FV0ffYsy3LxXhovkzmPDGgobrJWkZafkNu/+vQ=;
        b=QTEUwD2NBnDCDClCQSiF0UZwLJEFyBQRIpUx0mZl7tyeWA/lbeHhDSEMxMugAXSWEw
         i9OpMNW9c+KbqgX7GdmGuBrEgj3OO1JtGoyLazwVjAF9c8AQrbqUpTWr3H6xUaAz/4GX
         rrreTKtjTLDhc/A4oVY0wI1aiNp90GZnBf/C8yGHiXcYHcFwCQeZfSOjxQOCIZaksiby
         lDC6v7ZOZZYKK3xspE72nfD4DQh8Hh6tD0mCQV9Y48YynM35YJ6EdHETydfD6eFts0dC
         bRkXX7o/4/AO1tqO6jh3TYIsaSBufkDmH/1gTj6gISRZU/3FVm/ZEq9ygowNmqk4GGAI
         Mo4w==
X-Gm-Message-State: AOJu0YztXx/PbVXo5EMxtg/4lcvc5prFlQZ7ao/v2pBBmXGw6OoAKjGL
	LVh0714Wpn73cknLNej0X6Hg2vErU48OeKoTH7rjqDMFfrMkNY0+L7zN
X-Gm-Gg: AeBDieueQYnomoI4zCdRe2PIeJsVN/o7e4n+kZYry90ZXFdxuQPYpVPKDBpG9lnD0oS
	7CXiKsKmOwWNqN7zoGyNLGFsp/V+rUtjVHLJWRWnzKGCFwLJuMcuMP+SjHB0rDFKula51OaDSXI
	rjyKXlbSZUh4B3PpBX0TBag2UE0/xykWcFAZHo1H/P/lgccE5BNt7GiZTetH9e7USf9uQvDm9rz
	/chwqvJQBJog0dar62qqfExuK3LmJJcW1pzK0twrXQGZkp7odVrasLagpFidz84FKE4/aHGK269
	KMAYYf5zVKFp1LwcxdBciI1yOxhfhUFiJQeEp0hQWUUKLnozuc0B2Np++3kv/S2i3ATpSgSx+KC
	QwxgHIOOtcsaOOmQR7U2ZcwGeTyGHA4QTaZuVSYlqGMmzTh2X3w9KrP3cAGVn7DMuO0LrCK+zTP
	a1q2878fr/CcmTWjG/rK5WXRqkX/UZEXRiI/7GHv4Hs6m63vryfoRLdg==
X-Received: by 2002:a05:6a20:938e:b0:398:7ca0:43a9 with SMTP id adf61e73a8af0-3a08d89fa06mr25628629637.36.1776922274709;
        Wed, 22 Apr 2026 22:31:14 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea09914sm18576129b3a.26.2026.04.22.22.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 22:31:14 -0700 (PDT)
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
Subject: [PATCH] perf annotate: Fix NULL pointer dereference in  loongarch_call__parse
Date: Thu, 23 Apr 2026 13:31:02 +0800
Message-ID: <20260423053102.3717015-1-frankljpliu@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Add a NULL check for the return value of strchr() before dereferencing
it, consistent with s390_call__parse() which handles the same case
correctly.

Fixes: 4ca0d340ce20 ("perf annotate: Fix instruction association and parsing for LoongArch")
Signed-off-by: Jianping Liu <frankjpliu@tencent.com>
Reviewed-by: Ming Wang <wangming01@loongson.cn>
---
 tools/perf/util/annotate-arch/annotate-loongarch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index c2addca77320..0179062a6cf9 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -29,6 +29,9 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 	ops->target.addr = strtoull(c, &endptr, 16);
 
 	name = strchr(endptr, '<');
+	if (name == NULL)
+		return -1;
+
 	name++;
 
 	if (arch->objdump.skip_functions_char &&
-- 
2.43.7

