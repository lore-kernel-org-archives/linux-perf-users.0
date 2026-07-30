Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE143E49D7;
	Thu, 30 Jul 2026 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455988; cv=none; b=SojL5dCkgeVAFxWCJFc5opze0xkqhFEQerTmj7Kz8LJbw5R5+Mg7i4tLfaeHX+TwpIxDWV+RVR2oBcFITo/+h0fCUqAF31U8Hb/c8QWWxibCOSmBswQfOdb3PAKSZ/668iCN1Pc0Jdk1vYVbtl+2r1ztuI4EpO9LfnjX6lwbazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455988; c=relaxed/simple;
	bh=yi4gqRt9ul77JleP1bjpsD+zc1C5DbN8vXbgwbnShtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXOziVP4qE4SLJRdhzd7BEgvAHbL9KVnndIFl9NaxyNggEanOZDQQbm2btn79ZJkqT77kfTnIBfmBwXNAa2c3QVY6DxgTH0IGj7ffVl+cgOfuwtLefcKWJp8k8rk8jQJ3x/28fkHWAfcTrG/8rP5Gr3aDhjiBNd56pLvLsxNTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGlTiEoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGlTiEoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDC81F000E9;
	Thu, 30 Jul 2026 23:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785455987;
	bh=5QQ0sGTHmC0CmT0OUvz2BBXS9LspEW5NESBGglrUW28=;
	h=From:To:Cc:Subject:Date;
	b=EGlTiEoanuXEQLPeu3o33MXg1L7L3wKcNOV9fAgHjpB0biAuCBr3bVzcqBtckOdwu
	 WCs8QXi4midaQgcTnrx9Fcu5TulmvPgBEejUDxi9oIhTdgjhfxEQmSAJVWPw9H3YF0
	 MEO/rLRytcoXg0vQSSawVte5R/shk18B7hy6r8IGtbANr41y/o+g+NhmIozGgMQdwm
	 l6S5BwsHq26RHtsLKHZli/Ea7Z7yFCEICnGBDU0eIslwD+QAN4la8yxWRbPnXSMHbv
	 tX4J4eUp6uLg6TuUDj7DjBw3TufFaEAvr8Gc7I/7pSk0o/YCh8QAR8x5jETzK4vdYh
	 Ql8rkZMrA0F5Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf build: Fix a build error on 32-bit x86
Date: Thu, 30 Jul 2026 16:59:46 -0700
Message-ID: <20260730235946.618096-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit d7507a94a072 ("KVM: SVM: Treat exit_code as an unsigned
64-bit value through all of KVM") added "ull" suffix to SVM exit codes
and it makes the 32-bit build fail like below.

  In file included from util/kvm-stat-arch/kvm-stat-x86.c:4:
  util/kvm-stat-arch/../../../arch/x86/include/uapi/asm/svm.h:137:32:
             error: conversion from 'long long unsigned int' to 'long unsigned int' changes
                    value from '18446744073709551615' to '4294967295' [-Werror=overflow]
    137 | #define SVM_EXIT_ERR           -1ull
        |                                ^
  util/kvm-stat-arch/../kvm-stat.h:131:17: note: in definition of macro 'define_exit_reasons_table'
    131 |                 symbols, { -1, NULL }                   \
        |                 ^~~~~~~
  util/kvm-stat-arch/../../../arch/x86/include/uapi/asm/svm.h:249:11: note: in expansion of macro 'SVM_EXIT_ERR'
    249 |         { SVM_EXIT_ERR,         "invalid_guest_state" }
        |           ^~~~~~~~~~~~
  util/kvm-stat-arch/kvm-stat-x86.c:12:45: note: in expansion of macro 'SVM_EXIT_REASONS'
     12 | define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
        |                                             ^~~~~~~~~~~~~~~~

As the exit_code was unsigned long, the compiler complained about the
truncation.  Let's convert it to u64 to suppress the error.

Fixes: fac520e43a60 ("tools headers: Sync KVM headers with the kernel sources")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/kvm-stat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 1db31c0751875875..8eee8d073f4147f2 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -69,7 +69,7 @@ struct kvm_events_ops {
 };
 
 struct exit_reasons_table {
-	unsigned long exit_code;
+	u64 exit_code;
 	const char *reason;
 };
 
-- 
2.55.0.571.g244d577d93-goog

