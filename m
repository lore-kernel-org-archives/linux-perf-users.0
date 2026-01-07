Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DDC25F7A9;
	Wed,  7 Jan 2026 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774008; cv=none; b=kxLz6ck5mTPR8iwgSetk2eOfK4drxk/IEOZZ1c1Q+lYeNAES9JKbxzluKaQwGQWJ0Z4BwnV6pcO/ksg3IEKW5NbR5K4l4RfNt3qeI4IgfEnS5ie1yOkdWacb2DHXbfvxoUz1leTp44l+OCNcIOLpulkB4FGtFmviHT1X7oyo1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774008; c=relaxed/simple;
	bh=yHteBbzgr+52e8wup931qb9JvrQo0+uwX+yBNNToe28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m4zjJkzawFYEsqjLcio9QUcMUsorGRxNw6SIgC7ygZdWsunpXyClb6L3r9UzhbsuT57O1cW5EU+QKEC7a6FJwzIR+oNIZJZ+84BtamutHMu6jDSVlhnd+Z8TvH55WWEVLbZjLZ5qIq8oVphLyLp18tck3qtKXtdEcwT1hvvYIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.54.3)
	(envelope-from <n.schier@avm.de>)
	id 695e159a-44e8-7f0000032729-7f000001c1c8-1
	for <multiple-recipients>; Wed, 07 Jan 2026 09:13:14 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed,  7 Jan 2026 09:13:14 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 5065C8001F;
	Wed,  7 Jan 2026 09:13:44 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id 3FF38181FBC;
	Wed, 07 Jan 2026 09:13:44 +0100 (CET)
Received: from localhost ([::1] helo=l-nschier-z2.ads.avm.de)
	by l-nschier-z2.ads.avm.de with esmtp (Exim 4.99.1)
	(envelope-from <n.schier@avm.de>)
	id 1vdOfm-0000000BiQN-3kSm;
	Wed, 07 Jan 2026 09:13:42 +0100
From: Nicolas Schier <n.schier@avm.de>
Date: Wed, 07 Jan 2026 09:13:26 +0100
Subject: [PATCH v2] perf build: Raise minimum shellcheck version to 0.7.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-perf-raise-minimum-shellcheck-version-v2-1-019ef32d7711@avm.de>
X-B4-Tracking: v=1; b=H4sIAKYVXmkC/5WNQQ6CMBBFr2Jm7ZgWsIAr72FYVBjsRApkqo2Gc
 HcLN/Dv3l+8t0AgYQpwOSwgFDnwNCbIjgdonR0fhNwlhkxlRmllcCbpUSwHQs8j+7fH4GgYWkf
 tEyPJZsBzZ6qip1rZvIbkmoV6/uydW5PYcXhN8t2zUW/vv4WoUeO9MGVe27JKu9roTx1Bs67rD
 3HRbb3XAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042; i=n.schier@avm.de;
 h=from:subject:message-id; bh=yHteBbzgr+52e8wup931qb9JvrQo0+uwX+yBNNToe28=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBpXhW2f8ttkHUbRHYNJMZReS2WlV/7yfS/f5hPU
 wIPV+NvHguJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCaV4VtgAKCRCIxryciJpt
 uHW9EACZsSX1C7uDu9Ib5twoNPjQMggG7wSwoDrYC8o3kJvba9ve1CCAhAunkRmum1uHVGULBt4
 PeTrzAwrA0gwtr5RSzl9fSkggz/gzCgmJ1R3u1JYFBd2vxRrr/I6eoXooYwXFJJ5jEC0aXt+p1o
 k9JxrHeQIHzUuTklkD/D6YQLGRjSjgi1jM5zDBpX2WuTMWVbXGn7KZokyZehRegFgUZamdPRzYH
 D1rwNJxho23JgPiXRM5TpkCf9FLVlZp8x0mre9DXTKIXc9LU1AlZopeQQP/JrGSMqehAFR5OHwr
 JvUYapgDa5qHDQtK/eMP8wT4PM5QAFhe0Hj/WQxVypMJQnoKBOf3atwu6shOVBu0gE51b3zdeMs
 X6SQXjcx8ey9HIcc4yZbupgbd3Y60knVLJTwnWHK1+LJPnuoRx1/wRVvLgrK7TWO5TO12U/chjA
 4oDh9uBs93/F9kDwReCCwcNCZKybtrj594Jw1P453BNA2JIgbsRBuxpASDO0tLxo8Wlt0lCdTJP
 WqAwYPtt59ZnL4kxefcCINY37cAuiyeXocNNOVrr3VcGxsWRXyocQIGIuD6usrBcmrnFMJ9oQgj
 yw3oLiGt6xAdOtq9Y+cG9ODySow3r0WE1zpSMoGx/OOslsQS2epLsmnihYVU9StGm5SitBDsTgU
 UtC6JyFqhyyy5WQ==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1767773594-D9E7D9FC-3D2D5C8B/0/0
X-purgate-type: clean
X-purgate-size: 2044
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Raise the minimum shellcheck version for perf builds to 0.7.2, so that
systems with shellcheck versions below 0.7.2 will automatically skip the
shell script checking, even if NO_SHELLCHECK is unset.

Since commit 241f21be7d0f ("perf test perftool_testsuite: Use absolute
paths"), shellcheck versions before 0.7.2 break the perf build with
several SC1090 [2] warnings due to its too strict dynamic source
handling [1], e.g.:

  In tests/shell/base_probe/test_line_semantics.sh line 20:
  . "$DIR_PATH/../common/init.sh"
    ^---------------------------^ SC1090: Can't follow non-constant source. Use a directive to specify location.

Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")
Link: https://github.com/koalaman/shellcheck/issues/1998 # [1]
Link: https://www.shellcheck.net/wiki/SC1090
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
Changes in v2:
  * Add one of the shellcheck messages to commit message (Namhyung Kim)
  * Link to v1: https://lore.kernel.org/r/20260106-perf-raise-minimum-shellcheck-version-v1-1-b46739a78888@avm.de
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

