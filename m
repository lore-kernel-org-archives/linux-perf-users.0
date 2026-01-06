Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44834A33;
	Tue,  6 Jan 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705580; cv=none; b=FqzThrN9OfZj02ndOC9xkLarGbr/Y/Hb6K9OcseoYVwAWiEjTVkFXGsRHZcMy7keR3cqGDcObd6NaHkueFDA8Zwf63psmJTOU6EDlxICK4aenZT9LGjpQfkD+fVM0Ke+YqMv/viTyBlCArsc5xSq70gh6DxdRszUT5gEufuHNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705580; c=relaxed/simple;
	bh=NIk3jixpKQos4F+qz+6mlChRWLrFwYWt7V14P9rOrTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RXm0Gm+Cgy+jirlDbU1PhmkcmpyRvkTROKvNE/05RWG9ANs3jpyqNTn3Xzqp3C31kyVCDzajyN2z8brxx3+RYwK+JybQIdwrn7ZS5ZxNq/9CnSSfd4k0DjGzPHukJNLvB6Rv0nah3PZ4S/UubWWxxO1V+jSar+COrwVuMHT1StA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Lj6nFio0; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Lj6nFio0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1767705575; bh=NIk3jixpKQos4F+qz+6mlChRWLrFwYWt7V14P9rOrTI=;
	h=From:Date:Subject:To:Cc:From;
	b=Lj6nFio0TrNJXdX96+1r0KbHAdqgdkKrflEK8EYBmymuvMD4izul84XCLtHNmeB1K
	 MYWxo8eULW/jDlmbGOrbFbIUPjT7JbjOHjxD9fz2KxmjPIHSLUI7D1tq2PjIJ2t2qN
	 Xub+DSSE68PVQubw50hJahoyvJVs57czl2gCUuEA=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.54.3)
	(envelope-from <n.schier@avm.de>)
	id 695d0be7-3a9b-7f0000032729-7f000001cb7e-1
	for <multiple-recipients>; Tue, 06 Jan 2026 14:19:35 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  6 Jan 2026 14:19:35 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 68DEF807F8;
	Tue,  6 Jan 2026 14:19:35 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id 592D3181630;
	Tue, 06 Jan 2026 14:19:35 +0100 (CET)
Received: from localhost ([::1] helo=l-nschier-z2.ads.avm.de)
	by l-nschier-z2.ads.avm.de with esmtp (Exim 4.99.1)
	(envelope-from <n.schier@avm.de>)
	id 1vd6yE-00000009qgn-0iAf;
	Tue, 06 Jan 2026 14:19:34 +0100
From: Nicolas Schier <n.schier@avm.de>
Date: Tue, 06 Jan 2026 14:19:28 +0100
Subject: [PATCH] perf build: Raise minimum shellcheck version to 0.7.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-perf-raise-minimum-shellcheck-version-v1-1-b46739a78888@avm.de>
X-B4-Tracking: v=1; b=H4sIAOALXWkC/x3NQQrCMBBG4auUWTuQVg3Wq4iLkP4xg00sM1iE0
 rsbXb7N9zYyqMDo2m2kWMXkVVv0h45iDvUBlqk1DW7wrneeF2hiDWLgIlXKu7BlzHPMiE9eoT+
 Bz5O/nBJGF44jNWtRJPn8P7f7vn8BSIkSIncAAAA=
X-Change-ID: 20260106-perf-raise-minimum-shellcheck-version-5d684fe90a39
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Petlan <mpetlan@redhat.com>, 
 Jakub Brnak <jbrnak@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>
Cc: Philipp Hahn <p.hahn@avm.de>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Schier <nsc@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=n.schier@avm.de;
 h=from:subject:message-id; bh=NIk3jixpKQos4F+qz+6mlChRWLrFwYWt7V14P9rOrTI=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBpXQvliGmql/Dp3L0bsENt6vVkxAwZsoddB6F8v
 CiV8D5EqNWJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCaV0L5QAKCRCIxryciJpt
 uMOdD/996WfFnrBjQ+Jl/jMjDBM5zpqEmh14lWbIgA+3Nt+prGNZhbIeZt0qnvYccv0mHRpRnd9
 h40Xdt287vSZk14w3nKAjHLVxM6BAhHPg4WIz2ZXFJ+vv64bKEgXOaykgTKSmKcF6cV2je8/ngW
 lRFi78J1Gli3maAY0zz6vL1l3d/H/1nEja4tyIA1IybqXB7i7BtE+36S1vha3jbr9wIv4xD9cAv
 IjKOPJxx2MjqTemfLEVs4VZTuQII1uy2XaaPhHykhFMHWQ8C6DD2cqjDr4GQF8OOi9/xAVdhUl6
 L4/YHrhgjGLQm+tz2HM1heMq0IZX0/nEqPVvX5rA+jplLwNdb/iSmTx5mhlL7rRgt1XpqcyHIsy
 w5B8fRAr5Cl42aPoWN6w5FVkUkfERNNbHmI6bDgIRPmD7fs1FHjKCUQibrHwmoyNCa493hHCGtD
 aOwjtUZtrve3K7pccgqDlm8onZ6xgbehI1O5aTiDjj/V9waQsroQZDR6UrI2cXUjm4V7nYpPOaC
 uhPMWOmiW2yeD2YuHgTjxKFaUgfncIof+TXVVzqgpHKHQ5Vjg+dFWi3Mb4TauixP4cuoI6ltfVT
 Yml/JwR722hia/OQ9AgalbexMnLn3406C7u6oq2fRfUMqT7ZH9owiJmiBZmY2RLspxMIuvU6fF0
 YWHWzye7pbr/P2Q==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1767705575-147757BC-135280A7/0/0
X-purgate-type: clean
X-purgate-size: 1829
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Raise the minimum shellcheck version for perf builds to 0.7.2, so that
systems with shellcheck versions below 0.7.2 will automatically skip the
shell script checking, even if NO_SHELLCHECK is unset.

Since commit 241f21be7d0f ("perf test perftool_testsuite: Use absolute
paths"), shellcheck versions before 0.7.2 break the perf build with
several SC1090 [2] warnings due to its too strict dynamic source
handling [1].

Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")
Link: https://github.com/koalaman/shellcheck/issues/1998 # [1]
Link: https://www.shellcheck.net/wiki/SC1090
Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
This is an alternative to introducing several shellcheck directives to
let old shellcheck versions handle the dynamic source statements
correctly:
https://lore.kernel.org/lkml/20260106-perf-add-shellcheck-sc1090-annotation-v2-1-bd52dc47369e@avm.de/
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b3f481a626afa314632876449a11eb79b2978824..e2d668fb7f439befd6d1d9cbf66765f8b815e3c6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -255,7 +255,7 @@ endif
 # minimal shellcheck version as v0.6.0.
 ifneq ($(SHELLCHECK),)
   ifeq ($(shell expr $(shell $(SHELLCHECK) --version | grep version: | \
-        sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 060), 1)
+        sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 072), 1)
     SHELLCHECK :=
   else
     SHELLCHECK := $(SHELLCHECK) -s bash -a -S warning

---
base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
change-id: 20260106-perf-raise-minimum-shellcheck-version-5d684fe90a39

Best regards,
-- 
Nicolas Schier

