Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F10C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 00:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772A160F92
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 00:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhI0AxR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232299AbhI0AxR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 26 Sep 2021 20:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632703899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2/VmYY08V9u3YFjqBs+eNyl3HzGVSi8fmveCf89uSWM=;
        b=QZp6tug6Tj/LQTtnDlFk4pI29yya5vAK6aBq7X+QzRN4E+UUR/zykj+Sj/z0IesUyJQTfQ
        zvyb9PZBJ1Hvup2Jr6NnMHzQaA+uzc34WGK83skW2phN2vhAhdFcEPbfpnM58PIzXGA6hi
        VlYCWpzyaB50JbeFoOyN4rLFBxy9yno=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-DKVXlCXQMXm4vWOgc_bPRQ-1; Sun, 26 Sep 2021 20:51:38 -0400
X-MC-Unique: DKVXlCXQMXm4vWOgc_bPRQ-1
Received: by mail-qk1-f199.google.com with SMTP id l3-20020a05620a28c300b0045db8137fa9so46706172qkp.5
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Sep 2021 17:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2/VmYY08V9u3YFjqBs+eNyl3HzGVSi8fmveCf89uSWM=;
        b=wm6rOsQu8I7DR0o1MDPFcTSfagUbEi8SzsEq9RVFPED5juTdXhczRhP5Ya6SCEVm7d
         FwdvZPYe5y58iOxiZ+BdYkpglevPkEQUxIMJaScrnpUBocPCqKtvyTHFL75kIgpiQvGz
         0JldvZa+qayS7pUGZdOsBSQqwlBlbbpJJlY2/Hl0To5B9xIgIcPQynUJq2XTSWdeeElL
         sXE4hFvVw4wB4WXm93KXWekXOJjAL9sUgcZwQulI23rnow/wHQLg368b5zPL9dRJ4Idt
         tVWdcfCge500X18iYd2qs+0m6OHhr+cnCJxGBskcXbicktHWyfeElpBh5OAOmhKyWYpl
         USvQ==
X-Gm-Message-State: AOAM533HTX55U7kSNBkd/FTwIrilzmFyatnmiVLKAQgKNUuN4VvZ1muv
        zxKq3yF7lijPnOkstPoMVVwSY5tx0zPimXTB7f/cr1LM3kSwehoX7t1jKUX6+cdkukYVLdBKlhf
        5UAIFQrkc3Ww60EhLRonvzhokcmKstw==
X-Received: by 2002:ac8:429a:: with SMTP id o26mr9174856qtl.317.1632703898073;
        Sun, 26 Sep 2021 17:51:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUcbTh8QhEC6Qzf+SlzmapnnglMqi+jffl07PUgFhO6gl3Aj1jZZ/AmIWRdIB9Qrm4b0WXSQ==
X-Received: by 2002:ac8:429a:: with SMTP id o26mr9174838qtl.317.1632703897875;
        Sun, 26 Sep 2021 17:51:37 -0700 (PDT)
Received: from haro.redhat.com ([75.183.81.126])
        by smtp.gmail.com with ESMTPSA id o21sm9862600qtt.12.2021.09.26.17.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:51:37 -0700 (PDT)
From:   William Cohen <wcohen@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Cc:     William Cohen <wcohen@redhat.com>
Subject: [PATCH] perf annotate: Add riscv64 support
Date:   Sun, 26 Sep 2021 20:51:15 -0400
Message-Id: <20210927005115.610264-1-wcohen@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds basic arch initialization and instruction associate
support for the riscv64 CPU architecture.

Example output:

  $ perf annotate --stdio2
  Samples: 122K of event 'task-clock:u', 4000 Hz, Event count (approx.): 30637250000, [percent: local period]
  strcmp() /usr/lib64/libc-2.32.so
  Percent

	      Disassembly of section .text:

	      0000000000069a30 <strcmp>:
	      __GI_strcmp():
	      const unsigned char *s2 = (const unsigned char *) p2;
	      unsigned char c1, c2;

	      do
	      {
	      c1 = (unsigned char) *s1++;
   37.30        lbu  a5,0(a0)
	      c2 = (unsigned char) *s2++;
    1.23        addi a1,a1,1
	      c1 = (unsigned char) *s1++;
   18.68        addi a0,a0,1
	      c2 = (unsigned char) *s2++;
    1.37        lbu  a4,-1(a1)
	      if (c1 == '\0')
   18.71      ↓ beqz a5,18
	       return c1 - c2;
	       }

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 .../perf/arch/riscv64/annotate/instructions.c | 34 +++++++++++++++++++
 tools/perf/util/annotate.c                    |  5 +++
 2 files changed, 39 insertions(+)
 create mode 100644 tools/perf/arch/riscv64/annotate/instructions.c

diff --git a/tools/perf/arch/riscv64/annotate/instructions.c b/tools/perf/arch/riscv64/annotate/instructions.c
new file mode 100644
index 000000000000..869a0eb28953
--- /dev/null
+++ b/tools/perf/arch/riscv64/annotate/instructions.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+static
+struct ins_ops *riscv64__associate_ins_ops(struct arch *arch, const char *name)
+{
+	struct ins_ops *ops = NULL;
+
+	if (!strncmp(name, "jal", 3) ||
+	    !strncmp(name, "jr", 2) ||
+	    !strncmp(name, "call", 4))
+		ops = &call_ops;
+	else if (!strncmp(name, "ret", 3))
+		ops = &ret_ops;
+	else if (name[0] == 'j' || name[0] == 'b')
+		ops = &jump_ops;
+	else
+		return NULL;
+
+	arch__associate_ins_ops(arch, name, ops);
+
+	return ops;
+}
+
+static
+int riscv64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+{
+	if (!arch->initialized) {
+		arch->associate_instruction_ops = riscv64__associate_ins_ops;
+		arch->initialized = true;
+		arch->objdump.comment_char = '#';
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0bae061b2d6d..d919fa993872 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -151,6 +151,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/mips/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
 #include "arch/powerpc/annotate/instructions.c"
+#include "arch/riscv64/annotate/instructions.c"
 #include "arch/s390/annotate/instructions.c"
 #include "arch/sparc/annotate/instructions.c"
 
@@ -192,6 +193,10 @@ static struct arch architectures[] = {
 		.name = "powerpc",
 		.init = powerpc__annotate_init,
 	},
+	{
+		.name = "riscv64",
+		.init = riscv64__annotate_init,
+	},
 	{
 		.name = "s390",
 		.init = s390__annotate_init,
-- 
2.27.0

