Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79B38FAE
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOZTJBM5"
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42943CF
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 11:58:00 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b6a7e0deeso1429662eaf.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Oct 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696618679; x=1697223479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fH8sBNRx2fIy/cr7x3xLOPUSQ51+JC0fFgoMH/eJTHg=;
        b=aOZTJBM5DSkXbXD4XK+ZaxzqooM3OjUm2qHDia48lmcI6J96f9X0ci7xNebdYzgz/5
         q8UCUbdQL1GQqobn89WXC3eK5x17vLFaaF/22xosLINIfvSKIFq7ecCVWm3AJqcGpsx7
         E7wyJvkZsXYcJzRgt9pOSN7Iam51e5+yyVihCrvlb01AjDziRsEtH3mhoqq1IZf74wyT
         kp12kZG+ZE6oGLqDwnzlTuBH+EzUYUDzgdtWPu5ABoKjfdXq3sVI1onShrE9Tpd5Q//t
         Xs4Za46ghJ4gSQOWxoEX1/2BzDFhT6tqB9esHXhiG5HJin4ONSLAEHYrxq0JKXmjdrAm
         yHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618679; x=1697223479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fH8sBNRx2fIy/cr7x3xLOPUSQ51+JC0fFgoMH/eJTHg=;
        b=wqzijlQfoKb61CNPPuY8Yr2x3GYS6sCI5EO9NrlatbRjTMGFb37o1L90eqU/ZMhfop
         2klD9gb/qDCQGYNGGz6anvAyZg1jOyX/eRYSnCGcpPspbNNuW5pjMw5knlodK4bzY478
         3RNu7vFZ+v/RW+wHaA7UbtH7trvyHxPSXnVjApXKvRAx/J3PFAI7+xZBOudBy1KtkmeK
         iAkgCVq6kd1scQG52soxDp1LFHV4yNiSgZqPTMgV7CPeDkOZEzrlWt8Q63W2imIOziO0
         XBt9eQf7jmj+yuaJXp5gywOwCtRUu9k1h5AGvPcMalbHf4hZ9vAA0AMq7CJDeGfuZfWj
         qJNg==
X-Gm-Message-State: AOJu0Yzy5ZLtSnEEqK6vpFtbEsqB67DNDqCo8lvvRUoqa+spCVJGwHQX
	VRPlCtEWj3ChL9KsE8vGQYo=
X-Google-Smtp-Source: AGHT+IHnonBxv+zOm/+XowjrI1AllD2F9Bg2Hk+xtT7dRLELZsfDk2MBzzp4kiHTBamvc3MrLIRVug==
X-Received: by 2002:a05:6358:4291:b0:143:8601:54d with SMTP id s17-20020a056358429100b001438601054dmr8327995rwc.2.1696618679360;
        Fri, 06 Oct 2023 11:57:59 -0700 (PDT)
Received: from saturn.lan ([2601:648:8900:1ba9:7fee:84d2:5412:6733])
        by smtp.gmail.com with ESMTPSA id cp13-20020a17090afb8d00b002684b837d88sm3898026pjb.14.2023.10.06.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:57:58 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: x86@kernel.org
Cc: peterz@infradead.org,
	rostedt@goodmis.org,
	linux-perf-users@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH] LBR: filter vsyscall addresses
Date: Fri,  6 Oct 2023 11:57:26 -0700
Message-ID: <20231006185726.6300-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We found that a panic can occur when a vsyscall is made while LBR sampling
is active. If the vsyscall is interrupted (nmi) for perf sampling this
call sequence can occur (most recent at top):

    0 __insn_get_emulate_prefix
    1 insn_get_emulate_prefix
    2 insn_get_prefixes
    3 insn_get_opcode
    4 decode_branch_type
    5 get_branch_type
    6 intel_pmu_lbr_filter
    7 intel_pmu_handle_irq
    8 perf_event_nmi_handler

Within __insn_get_emulate_prefix at frame 0, a macro is called:

    peek_nbyte_next(insn_byte_t, insn, i)

Within this macro, this dereference occurs:

    (insn)->next_byte

Inspecting registers at this point, the value of the next_byte field is the
address of the vsyscall made, for example the location of the vsyscall
version of gettimeofday() at 0xffffffffff600000. The access to an address
in the vsyscall region will trigger an oops due to an unhandled page fault.

The test program below can be used to run the vsyscall version of
gettimeofday() repeatedly. In order to repro the panic, run this program
with the perf command:

    perf record --branch-filter any_call ./a.out

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/time.h>

int vsyscall_gettimeofday(struct timeval *tv)
{
	register int64_t rax __asm__("rax") = 0xffffffffff600000;
	register void *rdi __asm__("rdi") = tv;

	__asm__ volatile (
		"callq *%%rax \n\t"
		: "+r" (rax)
		: "r" (rdi)
	);

	return rax;
}

int main()
{
	struct timeval tv;

	for (;;) {
		memset(&tv, 0, sizeof(tv));
		vsyscall_gettimeofday(&tv);
		printf("sec:%ld, usec:%ld\n", tv.tv_sec, tv.tv_usec);
	}
}

To prevent the problem, filtering for vsyscalls can be done when
determining the branch type. This patch will return a "none" branch if a
kernel address if found to lie in the vsyscall region.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>

---
 arch/x86/events/utils.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index 76b1f8bb0fd5..dab4ed199227 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/insn.h>
+#include <linux/mm.h>
 
 #include "perf_event.h"
 
@@ -132,9 +133,9 @@ static int get_branch_type(unsigned long from, unsigned long to, int abort,
 		 * The LBR logs any address in the IP, even if the IP just
 		 * faulted. This means userspace can control the from address.
 		 * Ensure we don't blindly read any address by validating it is
-		 * a known text address.
+		 * a known text address and not a vsyscall address.
 		 */
-		if (kernel_text_address(from)) {
+		if (kernel_text_address(from) && !in_gate_area_no_mm(from)) {
 			addr = (void *)from;
 			/*
 			 * Assume we can get the maximum possible size
-- 
2.41.0

