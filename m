Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D73A89AA;
	Thu,  8 Jan 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871773; cv=none; b=eCJU+gFH0BKH7oZfp7bINtGtYHjL0sWvZ8GkTPtLlF17CtmKvRchvVuHE8ARo8Cjpv6qI4GFCDzfpFcwX9NAgg0OZ4e5q5HUnsSZ5x9JbWr++r+NgwaY2O5v0hoXu448kFRt1k+kGtn+ufp9JXI7iJM/toV+h/fh56VH8PTqtRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871773; c=relaxed/simple;
	bh=pZyMWVIsrloIwBww2kcHOwUXE31eKMGHlDlIwvtxVIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zj9VDvB8YjBWta8AtFtHWdFh/9wOA749/IJDSduipz5TgJ5dA3VoFShMLpSF6vLDfDuvGd6W0MZnflgrMBrNxz6WkOVvASlIs5Arf2Y3B6Bm7DWs7V7nI6AEi/CDEzcLwD+290rhRElxphQQnQbHoxfMU4CbJPlugwaiDwPXhQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Gxi+BZ7f; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Gxi+BZ7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1767871759; bh=pZyMWVIsrloIwBww2kcHOwUXE31eKMGHlDlIwvtxVIE=;
	h=From:Date:Subject:To:Cc:From;
	b=Gxi+BZ7f2xc6+r9R/Q2SeBqW2rGQjsI5ah2T6hCeeon6/qacvcYUygCDJQ55upH8i
	 IM2AaVSNF+BGPPCO6kaO9BTv8vCkqT+pWMB5illOMqkqStP0On3D3I89nG0sUvR/0I
	 CLftj65pOrX21u1m/OgEFb3FmSqEryYodV9/+kTw=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.54.3)
	(envelope-from <n.schier@avm.de>)
	id 695f950e-3a9b-7f0000032729-7f000001c7dc-1
	for <multiple-recipients>; Thu, 08 Jan 2026 12:29:18 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  8 Jan 2026 12:29:18 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id AA10680A53;
	Thu,  8 Jan 2026 12:29:18 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id 9C6041819BF;
	Thu, 08 Jan 2026 12:29:18 +0100 (CET)
Received: from localhost ([::1] helo=l-nschier-z2.ads.avm.de)
	by l-nschier-z2.ads.avm.de with esmtp (Exim 4.99.1)
	(envelope-from <n.schier@avm.de>)
	id 1vdoCb-0000000Ev6b-26wl;
	Thu, 08 Jan 2026 12:29:17 +0100
From: Nicolas Schier <n.schier@avm.de>
Date: Thu, 08 Jan 2026 12:29:10 +0100
Subject: [PATCH v3] perf build: Raise minimum shellcheck version to 0.7.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-perf-raise-minimum-shellcheck-version-v3-1-36028909e7d0@avm.de>
X-B4-Tracking: v=1; b=H4sIAAWVX2kC/5XNOw7CMBBF0a0g1wzyJ9gJFftAFCYekxH5yQYLF
 GXvOCkQJUx3pzhvYhEDYWSHzcQCJoo09DnUdsPqxvZXBHK5meRSc8E1jBg8BEsRoaOeukcHscG
 2rRusb5AwLALsnS4LjxW3qmLZGgN6eq47p3PuhuJ9CK91Nonl++9CEiDgUmijKmvKfEebup1Dt
 vBJfpPmV1JmkosKvZLOGCE+5DzPb/r3GR4qAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620; i=n.schier@avm.de;
 h=from:subject:message-id; bh=pZyMWVIsrloIwBww2kcHOwUXE31eKMGHlDlIwvtxVIE=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBpX5UM0jU45eRkSVLLz1SOqQ+TQ7f5vjnKH0msO
 nrT9bkmH1WJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCaV+VDAAKCRCIxryciJpt
 uD4RD/0RXLMipNj8hrhZ8CPjRDLoe2V9MHYt9DpUOJyyyQdbcM4TZB2E+gwOsLCb0hyFWEHB06/
 1njXp/bh+98norncA68SMGsYNQYRgWKtpjC9BlNaA0MNc88+xZfxWOm5vZ6mUG9MPOGI8bFgpxh
 AOw98D1r7j6zuMIHm0WE6fKypWh8JemfO4kBjB1mCI1uhj5fnAdgLwMTHtyFMLu0tAWxYET/tq3
 hnOsFauNpA2cKHIx7meHgJTUClqbZUEUXO7fgKDJy75YCnNKi18MB47+oUveLorI5tRdo8+AHhC
 hRNnlVZBv4S/tahkTS32d33/x2ni8uCFxW5FkICBMHwWm33j+jqM34LYnS166h31uIeBoAwk43H
 RiKsjsdVizx2ki6LKaw15wedaXSGNDhWdZ0prW9KspVDpCHPTrZ4JKnnbPqw/FMtxAsTiS99MLS
 nhJNEEam5e3S5RPHggUNe741oyV9XuATguYbRbIylvPij4AIpTF5DWVTmozFuHffD7mTUVaKwYL
 QwgI2pd7GfqD+bT4RisBQZFvUS5GzFgotSAWfbEeG94Wg7u0VQtbWvKZMhWDHUiusfd2Z5ScMBj
 sfwCfhex2zpzRHt6dg9Nr+DO6T9ITAxf33wZ60fVs3xPf9Sed2my19AHttcVpdB99C8pSsYoE8c
 4EShExC5Os3NrVA==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1767871758-7F74F7BC-CD838DD2/0/0
X-purgate-type: clean
X-purgate-size: 2622
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
Changes in v3:
  * Update comment about minimum shellcheck version (Arnaldo Melo)
  * Link to v2: https://lore.kernel.org/r/20260107-perf-raise-minimum-shellcheck-version-v2-1-019ef32d7711@avm.de

Changes in v2:
  * Add one of the shellcheck messages to commit message (Namhyung Kim)
  * Link to v1: https://lore.kernel.org/r/20260106-perf-raise-minimum-shellcheck-version-v1-1-b46739a78888@avm.de
---
 tools/perf/Makefile.perf | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b3f481a626afa314632876449a11eb79b2978824..e6895626c1872a84c0a592df01d32403b7df3d2b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -251,11 +251,12 @@ else
 endif
 
 # shellcheck is using in tools/perf/tests/Build with option -a/--check-sourced (
-# introduced in v0.4.7) and -S/--severity (introduced in v0.6.0). So make the
-# minimal shellcheck version as v0.6.0.
+# introduced in v0.4.7) and -S/--severity (introduced in v0.6.0) as well as
+# dynamic source inclusions (properly handled since v0.7.2).
+# So make the minimal shellcheck version as v0.7.2.
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

