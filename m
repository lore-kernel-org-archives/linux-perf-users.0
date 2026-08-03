Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F841A4F6;
	Mon,  3 Aug 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765120; cv=none; b=cbfjmYZAZd/q7kO4UTHti0YhYCXsDjGWVx/1ICZdzJxki2r2JBXEk3539DD9F4XN5rMlhicrdLOZbszHvxOq5O2Jv2AYzqDJwzclfwT+saZLE8IKtorx5hJviBXx4GYINPDTegeWsRU6/OZsUo2WnUCjVx3LUNtssR6C5pmU8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765120; c=relaxed/simple;
	bh=ZsG77edvOhH6XVLAwy7LIPSIlfSX56ZFI2RUHuh1Ges=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yf1xf0tNITEcW+jQLCCocYgV1WuEcfSliqbsfkdrCE+eMZM8mHnFZ31Js7DnhQaR2mZ2NJzLIGAPeHXJo6vO4jTWJYvC2Ixvp7xrEuDJNd61N5APA2eU1M//Fl2DG/4QHyAlDGOF7oJVdGLG9kImxGvNd+/kkU42w4Gk3dLFIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhSyIxX3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhSyIxX3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C79DEC2BCF6;
	Mon,  3 Aug 2026 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785765119;
	bh=ZsG77edvOhH6XVLAwy7LIPSIlfSX56ZFI2RUHuh1Ges=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HhSyIxX3IIa/Ji0lGLgiEs1+oCNeylXqiQPjpuzSebuo2DuMQe61O65cEGUBYWn7W
	 XeRw6Dzp7RG18Kub48sllMLoYesTGgRz6u5vYmQqDmjekdgQyTWX2A22M70Iy42j8j
	 f3rSY0KS4vwjFke8ZbhFQsiFo3fxhOqcJwwlxDLH7TuEDs8KuU55VAxt35bRDxnBrx
	 i5eO3A4pHFwdoRJBhnIEYDI3AQRYwPGGJKCv2CCjf+8RlKdfRLNN7i8qI5DfNakiYH
	 aLqUk7Iws56R8YBwaxfgUh+29xl0IP57XnoN/gNmULMZoE+t8gBjSNxY+1346vFUaz
	 0IPFqSHpOf6SA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D7CC55182;
	Mon,  3 Aug 2026 13:51:59 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 15:51:52 +0200
Subject: [PATCH v3 1/3] perf tools: Fix memory leak in cmd_kvm()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v3-1-e06268ec06fa@gmail.com>
References: <20260803-perf-kvm-fixes-v3-0-e06268ec06fa@gmail.com>
In-Reply-To: <20260803-perf-kvm-fixes-v3-0-e06268ec06fa@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785765118; l=1401;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=g8MhihpU3z6FgOHyL6TpVKQEHy5oaO74U3jKb0sNYoY=;
 b=BbRDa2JL+T5vHyyCpP1ffABm/DHENH52ZcIixvt5R+vfjvE4bHm9TXCeYzkjepYGFE17yRfwp
 kJ0Oa4an6p1CKk+vy+ZE9JgCNLaI2P3PW2iYhyOqtAcvw9w7Cg9IUa9
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
 tools/perf/builtin-kvm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 394302ebdb16..16cfa7ce7856 100644
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
@@ -2158,15 +2158,9 @@ int cmd_kvm(int argc, const char **argv)
 	if (!perf_host)
 		perf_guest = 1;
 
-	if (!file_name) {
+	if (!file_name)
 		file_name = get_filename_for_perf_kvm();
 
-		if (!file_name) {
-			pr_err("Failed to allocate memory for filename\n");
-			return -ENOMEM;
-		}
-	}
-
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
 		return __cmd_record(file_name, argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))

-- 
2.55.0


