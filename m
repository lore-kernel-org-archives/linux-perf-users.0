Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C247ECC1;
	Tue,  1 Sep 2026 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280591; cv=none; b=LsCz8Y0a0o680R6iXUOx8AQ7Zr09niwNWxK9d52l7cKtJGCz06pvkl3HEOS50Y7Zcjm4hYpeZSW5MuyHdi1aWS+QHL6z/TK1CErig742ViQhc+f0dM14Yhar/fmpmEogNH2yCQNpw7NZuSiYQJQtHIV06YRuZCkMXwY1E/Y8xNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280591; c=relaxed/simple;
	bh=iMtaS5GWT0jFESE4RL7PHAY9JqupVahiVJckgzwls+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fF/qDqOetPztdqSabMrNpP/Bq3sDQI1hzt4IRM/+qN+uw1AGs0uwPXNZVkUz35LcB2lGmC5/gLgBpB7Tg3CjwsaDmpuC9WHLbffwd3TwQR/QxLJQgmPJMglJNvLz1ZgH5teKj9W+6plr/Sf7tZFsv/Plm7MZMrgVQVfrsw8CJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SRUlRGAB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SRUlRGAB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C58D1BD0;
	Tue,  1 Sep 2026 09:36:25 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24FB53F85F;
	Tue,  1 Sep 2026 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788280588; bh=iMtaS5GWT0jFESE4RL7PHAY9JqupVahiVJckgzwls+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SRUlRGABFptdnM91OaKeohvJHQbHyEn2+3wfjPHtipzXJaGlc2SHnJtgkYwIq9DsT
	 4pMjceAzzKGlveJpmnuT2JWOYgSHpGjOUDOWpXgPx9ftKpg47xsCKfaTdxjiCItYw1
	 xCmpAwHWrwqSQ4GwAj7XyCKQup8Evhv9J6N8JUV8=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 01 Sep 2026 17:36:15 +0100
Subject: [PATCH 1/3] perf/core: Export perf_event_itrace_started()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-perf_suppress_itrace_start_records-v1-1-c4fbc6860859@arm.com>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
In-Reply-To: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788280584; l=763;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=iMtaS5GWT0jFESE4RL7PHAY9JqupVahiVJckgzwls+w=;
 b=woIwLWnXbrAOStcXTnYAgUT0ItWKPN5TCRiHcwDNRnJiYUEnHPoXJW0xbje5sbpQoQh4eulHW
 lhsfg+a9tr0A5nte1YqsAA1PfTBZPvmYbFbA1YsPbVtdKBTbGghkBgd
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since Arm SPE and CoreSight drivers can be built as modules, export
perf_event_itrace_started() so that it can be used by these modules.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a311042afab6b65814a84c67b87ba929b..8afe89179a62127eebae0f38f29cde045ba56251 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10560,6 +10560,7 @@ void perf_event_itrace_started(struct perf_event *event)
 {
 	WRITE_ONCE(event->attach_state, event->attach_state | PERF_ATTACH_ITRACE);
 }
+EXPORT_SYMBOL_GPL(perf_event_itrace_started);
 
 static void perf_log_itrace_start(struct perf_event *event)
 {

-- 
2.34.1

