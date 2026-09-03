Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2037F739;
	Thu,  3 Sep 2026 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430133; cv=none; b=OJi1XxK/qRFZC+xrNKKwq9a4QDdWBLqHh3ZgkBIU5eg1rfGnBlQ5+pI0De3IDsegiuylDzfhKMrcq0ET05lJ/mJ0fcysAjpGWqKkqe3tg8ljrbH4Wj91H3Ugdv+0D+xry6hIx2sHuHmBjq2cEj853B4E9nlUGpkzZpO+gjMS++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430133; c=relaxed/simple;
	bh=RrPukmqqWKZqZW3YdUJoOHS/lLlJKqX4D91o/6td3os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y4MEIxw32YpX/fngnon+1azv2p+JjcyqdU0nQj0g9KtDl3O8OG8fM04n+gjL21qic1HNthkSw1rgKDJMW8s7pqa+ibBKI5SZHPWTsxU+hhUNp182o54b4qkes8yDjMRDkyNgiuGjiWdBXe/mjpuHRpxuv+BSHAJyxHwbrtTSuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD3ZPLmN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD3ZPLmN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17415C2BCC7;
	Thu,  3 Sep 2026 10:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788430132;
	bh=RrPukmqqWKZqZW3YdUJoOHS/lLlJKqX4D91o/6td3os=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UD3ZPLmNcnKyfNbb6n1z20DfBCdbz5jtxnTdq+YgjdJTD36LOQ3zJJc9xUGHx4AMS
	 08PY+LotXPEcF0xJsgykbTTnQU4otAoBHKnq6q6ydsmVmQeUEcfWGrc3cy2xtP59tB
	 M0c3a4Xr6KIJnFwAgsLcNqlA7rIBvMHD5gBr1h0YmBEQmXybYyCiYadm+Mj1hv0+lp
	 dqsW/S5Q/TRrp/y1JhVsarj7XUkBqF2v16QPdHScWu8tA9onaMeE0tbQTpN96Nourv
	 +vcSO8iWHEOyXcRLVbKwx8dA+KT+AFAOolvfaGY2UFuDE1kXcPuyjoO9xU4MHcqTUm
	 nzqYTRISfN4rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A3FC61DD3;
	Thu,  3 Sep 2026 10:08:51 +0000 (UTC)
From: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>
Date: Thu, 03 Sep 2026 03:08:19 -0700
Subject: [PATCH] perf evsel: Validate branch stack before byte swapping
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-sympwn-linux-002-final-v2-v1-1-7c6e4166b814@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAxA0auUrA1kUhD1KuJinGY0UmOZ2Fopv
 bujLt/i/wVciorDoVmgyKSuD6sImwbSNdpFULtqYOIt7alFf9+Hl2GvNs5IxJjVYo8To7QUd13
 mQClA7YciWeff+3j628fzTdLzO4R1/QCPldH3fQAAAA==
X-Change-ID: 20260903-sympwn-linux-002-final-v2-e30a8df210c1
To: namhyung@kernel.org, acme@kernel.org
Cc: jolsa@kernel.org, peterz@infradead.org, 
 alexander.shishkin@linux.intel.com, adrian.hunter@intel.com, 
 linux-kernel@vger.kernel.org, mark.rutland@arm.com, james.clark@linaro.org, 
 mingo@redhat.com, linux-perf-users@vger.kernel.org, irogers@google.com
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788430131; l=3854;
 i=markdamirkan@gmail.com; s=pscsi-20260818; h=from:subject:message-id;
 bh=1QaosPwDGDLYOEtRj7PUXBnmCUkFKdpxpXkSjRMNBI4=;
 b=yx86HJ7Wmyz1M6NZHzsIok9mDkvy04ZT1MoIBHP15SF+miQwCAlyZrfHhILE1DPbmIL1eiJsU
 418RUu9pdcTCOfCYJI7N/6RKv7pMhkOT15NjQPYYRYkaLo2d2vC+Nsg
X-Developer-Key: i=markdamirkan@gmail.com; a=ed25519;
 pk=/wb49ibt4gZFDncmhFQBYtjPvzT1tfJtvK4Mqt1P2Wc=
X-Endpoint-Received: by B4 Relay for markdamirkan@gmail.com/pscsi-20260818
 with auth_id=961
X-Original-From: Mark Amirkan <markdamirkan@gmail.com>
Reply-To: markdamirkan@gmail.com

From: Mark Amirkan <markdamirkan@gmail.com>

When perf reads an opposite-endian branch stack, __evsel__parse_sample()
swaps each entry before checking whether all entries fit in the event. A
truncated sample can therefore make the swap loop read and write past the
event boundary.

A truncated perf.data file makes perf report crash with SIGSEGV. ASan
reports an out-of-bounds read. A regression test puts an entry just past
the declared end and shows that its flags are changed before the parser
returns -EFAULT.

Move the bounds check before the byte-swap loop. Valid samples are handled
as before.

Fixes: 63c12ae2f246 ("perf evsel: Add bitfield_swap() to handle branch_stack endian issue")
Cc: stable@vger.kernel.org
Assisted-by: Symbolic
Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
---
 tools/perf/tests/sample-parsing.c | 48 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c           |  3 ++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 32dbc484487a..583951534937 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
+#include <errno.h>
 #include <inttypes.h>
 #include <stdlib.h>
 #include <string.h>
@@ -417,6 +418,49 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	return ret;
 }
 
+static int test_truncated_branch_stack(void)
+{
+	struct perf_event_attr attr = {
+		.sample_type = PERF_SAMPLE_BRANCH_STACK,
+	};
+	struct {
+		struct perf_event_header header;
+		u64 nr;
+		struct branch_entry entry;
+	} input = {
+		.header = {
+			.type = PERF_RECORD_SAMPLE,
+			.size = sizeof(input.header) + sizeof(input.nr),
+		},
+		.nr = 1,
+	};
+	struct perf_sample sample;
+	struct evsel *evsel;
+	u64 flags = 1;
+	int err;
+
+	input.entry.flags.value = flags;
+	evsel = evsel__new(&attr);
+	if (!evsel)
+		return -1;
+
+	evsel->sample_size = __evsel__sample_size(attr.sample_type);
+	err = __evsel__parse_sample(evsel, (union perf_event *)&input,
+				    &sample, /*needs_swap=*/true);
+	perf_sample__exit(&sample);
+	evsel__put(evsel);
+
+	if (err != -EFAULT) {
+		pr_debug("truncated branch stack returned %d, expected -EFAULT\n", err);
+		return -1;
+	}
+	if (input.entry.flags.value != flags) {
+		pr_debug("truncated branch stack modified data past the event\n");
+		return -1;
+	}
+	return 0;
+}
+
 /**
  * test__sample_parsing - test sample parsing.
  *
@@ -433,6 +477,10 @@ static int test__sample_parsing(struct test_suite *test __maybe_unused, int subt
 	size_t i;
 	int err;
 
+	err = test_truncated_branch_stack();
+	if (err)
+		return err;
+
 	/*
 	 * Fail the test if it has not been updated when new sample format bits
 	 * were added.  Please actually update the test rather than just change
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4cb455f4a7d..cc0bc0857754 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3639,6 +3639,8 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			e = (struct branch_entry *)&data->branch_stack->hw_idx;
 		}
 
+		OVERFLOW_CHECK(array, sz, max_size);
+
 		if (swapped) {
 			/*
 			 * struct branch_flag does not have endian
@@ -3654,7 +3656,6 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 				e->flags.value = evsel__bitfield_swap_branch_flags(e->flags.value);
 		}
 
-		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
 
 		if (evsel__has_branch_counters(evsel)) {

---
base-commit: aadea57f532882d8bab444646863c7ef8a778ff1
change-id: 20260903-sympwn-linux-002-final-v2-e30a8df210c1

Best regards,
--  
Mark Amirkan <markdamirkan@gmail.com>


