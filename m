Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB882382381;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753206; cv=none; b=EbjFqdmpA0W929llgOUwOGg0XleIbd9P6UuwswVJuFHN+oJQTNv2/lwWnUo3PnV2a+L1thTpYu4KxGsvoX1LAZieePajd5RmGCaGuMc/3e2zsZQF8+9iwTR8Q8tDH3TKhV3fP8jmvgBcC3XH6oGmdvzDdB6E1MRzTJxYcMME1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753206; c=relaxed/simple;
	bh=D4oNQ6oqj39gKILMcLpB9mw/COd0/NB/PFjbdnNGxUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kn+Wt5UnZQ3jb+H4r0pFeG8WeYUWIcQNPrWTMOMW/LD43OLWGXOOttDK6AV03jW4lc5uyWAVptGEOVNWMThOqYm5x411gVtHkkfUGlQSZOXIWQ48T93u7j9AAqBeHHUNy9ekQsSj8lnx9aHXxPr5HZl3nxnnos5G8gIAryc/9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e86ppyWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e86ppyWI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AE66C2BCB9;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785753205;
	bh=D4oNQ6oqj39gKILMcLpB9mw/COd0/NB/PFjbdnNGxUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e86ppyWIz3LANAAP89ozzlPgLUFtt8MlyYLKueLbXsrKxCbftL8dt117M+m7THawn
	 ClZRH46jseRDBOEtbjmbPmSgEclpAeYEu/gReGBx+TipiVddPdrwLqycml5wVhjjHH
	 zg2u2its2w6/hLQGH9ydS8yJUoJ7x/gNkghISSJ/s1+sg8JyVI+RKv9qq+Md2NIBMK
	 6ttgfjw99Aq6/32k3gfnAkDtu7E/Upt79Vw1Krpx7N9XneANsLBBvZ3MzdFbnRyoS1
	 AiiZwoZqBCVhOU6oYpauY6ofZw70JZa4sKXpBnz0qHppbP7MPqK+QndwgebluFh66i
	 ZbQwU+XAJPumA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A096C5518F;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 12:33:20 +0200
Subject: [PATCH 1/4] perf tools: Fix memory leak in cmd_kvm()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v1-1-a5db849ac973@gmail.com>
References: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
In-Reply-To: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785753204; l=909;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=pkvE3n3gTEaq2KuDwi9uZbKHwl+KAztpvrJQ/tTLtCs=;
 b=WNwQczX2dy1XjwQwopzjgQDoEkFVdosmmiIGscy2JIeCAu4XCNQ7KYP8ZjihRf+4Nog+608gw
 PVbVva6K74YCcQRQECSbghjCfKM6mnjXf77YXFqN1BINueMxS0ASA4l
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


