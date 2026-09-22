Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E021ADC83;
	Tue, 22 Sep 2026 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039610; cv=none; b=eivUNX+7LHK2v4Hyw2pZfv5su082yu0aE0910VCd4phgKkSpKNrGqtHJnS5RykPmIUQ1ksWuLRfp6ib2pKoNPzPiYGGUeN1yyieZLXq5qK/FZRJa+bTkAQ9K+6KlPegQu72KKIPexGjjUqdcKNzD/vc+8uy0LdfA2y0t/7+AbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039610; c=relaxed/simple;
	bh=Nb54YeIaV3E3NlTttD9OOWd6wAuG/Hsz8+JaRWecMqg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PpLG+rR57n25e94NwUZItzTkv4LtzdQFb5H4sP6pAEnW5mJi4g+THMFDFdXevFvlDn5iIW2DmOgaqc/R417OtIBnlWZ+NVOTD1r/ny82UOY41FafWIktX93pPH/1ViNx2YluIi/b6xhMVctvAdZggpjyRvezu9CcrAFT5fvBTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwK7y4Vn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwK7y4Vn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDE92C2BCB3;
	Tue, 22 Sep 2026 01:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790039609;
	bh=Nb54YeIaV3E3NlTttD9OOWd6wAuG/Hsz8+JaRWecMqg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QwK7y4VnrdV5ku9SqhhArusxYbRWqDyM0fAzyczQkx/ktJsARC5wMh8B+5qewVRB7
	 4+qoZTod0JJsNsLa5csyzh5Zkt0I3XrBxlT6Reh9AiOi/iziGaKaskER+QKxFMdYQV
	 dC4O/YE4i7iiPAg1CSlG7mPIhfvIiESYbJBP9CxBhZ+hG12JCKjsB8hTnOVDNOgvRt
	 CKlVbvHSYR8s4/NnK32syX1kX0ipyk1AklkfEstI6m/6niof53hPuPCv8HIjZrkrHN
	 YU9TBGm9k/LgxXuy6sewdKB7DV6sKcWwFQsFUYmdwtWa4xZcSDUFEgjiSuWFRzfnog
	 m8vaoqCztVBxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9999C982FB;
	Tue, 22 Sep 2026 01:13:29 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Subject: [PATCH 0/3] perf/core: order three publications against their
 readers
Date: Mon, 21 Sep 2026 21:13:23 -0400
Message-Id: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADPWsWoC/yXMzQ6CMBAE4Fche3ZNfxSir0I8bNdFamIhWyUmh
 He3xeM3mZkVsmiUDNdmBZUl5jilAntogEdKD8F4LwZnXGsuzuIr4Cw6IE8qeDZtR5aCZ/JQJrP
 KEL/7XX/7O3/CU/hdP2ojUBYMSonHGu1cuqNH5RNs2w82YdNekAAAAA==
X-Change-ID: 20260921-mb-perf-core-5067a1ab3ca3
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790039609; l=1596;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=Nb54YeIaV3E3NlTttD9OOWd6wAuG/Hsz8+JaRWecMqg=;
 b=Qufw9awzqgW30NW3R8Rvt7FlPangeXfqjc1Vcsvx28UERBU41CkZExuqs2IpSdYBKslMa56IO
 kxQ9Kj0rPauCTreGFniqP/ZsiyGykJKBMTxqcUMbkBZRfw4d8BzJnw4
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

Three plain publications in kernel/events/core.c are read by paths running on
other CPUs: the aux_output link set in perf_get_aux_event() and read from the
PMU interrupt, the guest callbacks installed by
perf_register_guest_info_callbacks() and tested through perf_guest_state()
before perf_guest_get_ip() is called, and perf_event_cache read by
free_event_rcu().

The guest callback case is the one with a visible symptom. Without
CONFIG_HAVE_STATIC_CALL, which arm64 selects only under CFI, a static call is
a plain load of key->func, so a PMI on another CPU can observe the new state
callback while get_ip still resolves to the RET0 default and report an
instruction pointer of zero for a guest sample. The callees are now installed
before the gate, separated by a write barrier.

The other two are ordered in practice by the ctx->lock hand-off at schedule-in
and by initialisation order, and those patches make the publication explicit.

Found with MBCheck, a static herd7-based memory consistency checker.
Compile-tested on arm64 with W=1, no new warnings.

---
Jaidev Shastri (3):
      perf/core: publish the aux_event link with release semantics
      perf/core: install the guest callbacks before the guest_state gate
      perf/core: publish perf_event_cache with release semantics

 kernel/events/core.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-perf-core-5067a1ab3ca3

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


