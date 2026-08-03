Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B1403142;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762363; cv=none; b=H+e6g5tHQU0yQzbQLYlNSc4O9AzRjTI3RBJLWTnt3pTLj1TTiRuhX8a/erUqJwRyxpjq9SiZLeYz14nmH7hO1lc9/DcWVka/Ee8ubnrTunuqM8CT8/MeAJwmnAh7GBu89HWREn98uAjGu5tUZeSWTQFWHXAS+EjHMHdbxrV1i0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762363; c=relaxed/simple;
	bh=D4oNQ6oqj39gKILMcLpB9mw/COd0/NB/PFjbdnNGxUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3/XosDXpj95RjDLCGQ1mTg9D+mWzONAylJqRZEC4dkvh+wHvTJ91xcAEQPc4J4Jdgrfg4wKBbzf88wtNpK7W5EaRGhqk2DPhW1xbzq+cTc6H1zXe9o4YAYm6+ksXpFZrtqrydQX93nXEucrELuYYXvU5FAKRTLxdTSD6gjxhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAWSdPMW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAWSdPMW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22B42C2BCF6;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785762363;
	bh=D4oNQ6oqj39gKILMcLpB9mw/COd0/NB/PFjbdnNGxUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nAWSdPMW3Ri3LqCmn6P7JTAutCr1siBVKKW7LIhopivQkeliqThBHQLcY7NbfljwF
	 1biY80yhsU2HJV6cVl9RQp5EyYr7ZRcNZDAVtMk3M9QwEDgELQKZztXCRZptaE/PQV
	 95uzjSo4ABG2XtJr4FQkX61/gY4xrInlzOJMGMdWXAm0OCnqpPdDLWqfWgbZ11hnE5
	 h684nlqKZ1Jbl05MWgrUIXb/knwKQwBQTZ+PWYKJNdk+KFsfiKq8j6ZS3R0M/Mybz0
	 xH6qSPSEcBgoC2CySyAKiMh5uUfgqEeHifl5Gf2hjHOByYTXLpM2hbzRf2Xu4CP89G
	 BaqLxBo1g9tTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4152C55184;
	Mon,  3 Aug 2026 13:06:02 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 15:05:40 +0200
Subject: [PATCH v2 1/4] perf tools: Fix memory leak in cmd_kvm()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v2-1-1b337189fffc@gmail.com>
References: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
In-Reply-To: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michalis Niarchos <michael.niarchos@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785762361; l=909;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=pkvE3n3gTEaq2KuDwi9uZbKHwl+KAztpvrJQ/tTLtCs=;
 b=bSQo6/zQqYRFtMeMXnJH1eHGDdpfTHATAGO0WNIJ9r70EmynCwmiQguMVd6unc0U5hHCatnZT
 mub6h/xB5vMAlPb74J5B53+o2SqRPl+gRzv2CQBWrLu3bwiX9KeEwTV
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

From: Michalis Niarchos <michael.niarchos@gmail.com>

filename may get allocated by get_filename_for_perf_kvm(), but is
never freed. Use string literals to remove the need for freeing.

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
 tools/perf/builtin-kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 394302ebdb16..44c6998f2ee5 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -606,11 +606,11 @@ static const char *get_filename_for_perf_kvm(void)
 	const char *filename;
 
 	if (perf_host && !perf_guest)
-		filename = strdup("perf.data.host");
+		filename = "perf.data.host";
 	else if (!perf_host && perf_guest)
-		filename = strdup("perf.data.guest");
+		filename = "perf.data.guest";
 	else
-		filename = strdup("perf.data.kvm");
+		filename = "perf.data.kvm";
 
 	return filename;
 }

-- 
2.55.0


