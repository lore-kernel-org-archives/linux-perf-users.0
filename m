Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF03515CB;
	Tue, 22 Sep 2026 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039610; cv=none; b=hyLBoQ2bjtTJHaePkb4RB1vNI6UOFzof3Av+LH5O/2XME4IQdfdFmtGFId+r+yVnjBZYoIKRrIwesz1049p/Vnd6sFvv1xXclGBJysZ9Q7zYnAS1smZaRwRw7SO8WVg8v9D7wumuyQrxhfHEKe/WxkCfp0BNqvyFif6vhPEHgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039610; c=relaxed/simple;
	bh=UR5nFJwkj174M38Rf7pMCMXwi0EDVRjVxKZ8ctRigsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNTdO4qe4zRAdX3zYu2fbkxxJ2EQUfVAy1u6iU0pyxjwihhL/qSleUfAQR7b+AIz6H8p6WZ/bdOsl23Xzny+ELOFXEO6MwtwWpeLRXTKcmTFVVufVz2A+ThfeFQ9jy8GAWAfbeHij87cqCmHsW7nZR4r86HPRXQo1KkSBJ1R/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNx8KIRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNx8KIRq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04C9EC2BCFB;
	Tue, 22 Sep 2026 01:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790039610;
	bh=UR5nFJwkj174M38Rf7pMCMXwi0EDVRjVxKZ8ctRigsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pNx8KIRq5ALClGkuXNf/Pylrxb+kncfvfj6ZkRKmiQ8J1Hor/se3sue30XyXf586M
	 r7AoFeHbtGpw03X9mhFRONgOewY74ICh0AsAkkYhxTDi0UZ5wfkRAPNw/U4y1UJjoq
	 qp7dj88Iopy2XroCgGs+7q8bjR6/sVREpXCc3Rqit8KITSofYHK+dUWH9Do+LQ8Wkb
	 JaXg5SWEqn16jDL2Xs144A8RjLTNJdDJaNg/IJ7VtTdLcy2kEpjK3Yoq3c0PfIIdl/
	 WrTHQf+bAU6C14iJtgbzHE9R09MkyrU1n+sfgi8Awyzj3aarRPdjdObnmUcunYnw8u
	 9hZI3cIyq497A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A12C982E6;
	Tue, 22 Sep 2026 01:13:29 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:13:25 -0400
Subject: [PATCH 2/3] perf/core: install the guest callbacks before the
 guest_state gate
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-perf-core-v1-2-ac56a719c02b@vt.edu>
References: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
In-Reply-To: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790039609; l=2132;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=EKbfAAEuHXRbqtIgqar7H0RYkgyyMtdCwdbGpT3bE1g=;
 b=ZpaU9ZI7WaXpXDJiGjpiEAoMai0KL5ezxVwvrrROvMJEBwc+0IBlyTwqSd1W2F0D6S/fniuMh
 wzTVRlQWoAoDYA3yPvj1G9kbXzDwywaxXX1uYJwID+O076zZvPR98hn
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

perf_register_guest_info_callbacks() updates the __perf_guest_state
static call first and __perf_guest_get_ip and the interrupt handlers
afterwards. perf_instruction_pointer() and perf_misc_flags() test
perf_guest_state() and then call perf_guest_get_ip().

Without CONFIG_HAVE_STATIC_CALL, which arm64 selects only under CFI, a
static call is a plain load of key->func. A PMI on another CPU can then
see the new state callback while get_ip still resolves to the RET0
default, and report an instruction pointer of zero for a guest sample.

Install the callees first and the gate last, separated by smp_wmb(). The
reader keeps its control dependency.

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 kernel/events/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7cce3fc7c..3b5c59263 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7760,7 +7760,14 @@ void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 		return;
 
 	rcu_assign_pointer(perf_guest_cbs, cbs);
-	static_call_update(__perf_guest_state, cbs->state);
+
+	/*
+	 * perf_guest_state() is the gate the PMI paths test before they call
+	 * perf_guest_get_ip() and the interrupt handlers. On architectures
+	 * without inline static calls the updates are plain pointer stores,
+	 * so install the callees first and the gate last, behind a write
+	 * barrier.
+	 */
 	static_call_update(__perf_guest_get_ip, cbs->get_ip);
 
 	/* Implementing ->handle_intel_pt_intr is optional. */
@@ -7771,6 +7778,10 @@ void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 	if (cbs->handle_mediated_pmi)
 		static_call_update(__perf_guest_handle_mediated_pmi,
 				   cbs->handle_mediated_pmi);
+
+	/* Order the callee updates above before the gate below. */
+	smp_wmb();
+	static_call_update(__perf_guest_state, cbs->state);
 }
 EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
 

-- 
2.43.0


