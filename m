Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C03BB13B;
	Fri,  7 Aug 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115326; cv=none; b=uPQ4ai5kgChU6c5wY3GXa3KYAXbdc1k27yCh8RLKn11ecgUPl51YJlU50P2RAFCVe5nw0EHxukLmlcfv37KJA+ZkJ+OrS7YxbYtk4JB7qG7kvcQzx0T+WfFUnbB/FfSaO+gDJJnz6bBsjjWZMcLJynkGbNw2RmI4PpaPBLHdBhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115326; c=relaxed/simple;
	bh=rfl+0bj3ozQ4jj2fALkGdxM4esoHCSqn0jTUim8FZZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTKTaopO/qAx0vJuChBaSTTqbQwvI4dbw2V6bFZKUFMQNk9toSkKFieai5bT05kH8Ono4k4x/wkYE9YguWY+WGuR+JJJMJyK3+nz6JefjOWoskfFCwwwAeirAjK/pXElK24Pkru2l6ppn39hfHEmPnAjsCFcbSAJXQCJHSrJCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JThhUhKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JThhUhKz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EC08C19425;
	Fri,  7 Aug 2026 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786115326;
	bh=rfl+0bj3ozQ4jj2fALkGdxM4esoHCSqn0jTUim8FZZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JThhUhKzKr9ujeb96Z0zig1S+o9FKL6NAk3sBY8YRyQatJ0fFXEgjV3VncZTVezXG
	 +sXVbYmXKlQOQUfI+pFzYNd/c32pTmez5U+oVNhXTSXMljTd2ZtXvHQPZrD5OGLbNb
	 tHVAiKUTkefQ62Fc9uXc9N4vHTE1n4xUuJNNZNb6IEhNwOTYhP3nyyzFslQsAfrRrN
	 jg7ra+HanfZoyH/KMujaXdKrdIBgqJYUpL+xXAI1EdQJ5jhcVaFlxX85LLFyXArmzi
	 sl/pGLwKZt3qZXE9/HboBxrtw0Vek1dRDWd+f7J3BeReRp+/jByPlVtUbNmUkSPDFB
	 /hnKZv56kRhvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E293C2A09B;
	Fri,  7 Aug 2026 15:08:46 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Fri, 07 Aug 2026 17:08:36 +0200
Subject: [PATCH 2/2] perf kvm: Fix memory leak in cmd_kvm()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-perf-kvm-leaks-v1-2-7b5e2f97905a@gmail.com>
References: <20260807-perf-kvm-leaks-v1-0-7b5e2f97905a@gmail.com>
In-Reply-To: <20260807-perf-kvm-leaks-v1-0-7b5e2f97905a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786115324; l=579;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=bQ7xS4XFaVpnKKpn8MtN9GGFSGILFZ8PV3h9QmDPDm4=;
 b=ZEL/sEM4aOyQHDXYLa183cP3yfbP/aR9Z7x09kFLrR2Opvj8qjGUEqwryW1+OOYzK+dKokOBk
 B5H70klsqtcDuizvPnu7Msy4jezVygI2JVsfjBtKg1wapQNWaADsjF2
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

From: Michalis Niarchos <michael.niarchos@gmail.com>

Set the thread private data destructor.

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
 tools/perf/builtin-kvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 8e7bc7b2db18..21cb16b10f91 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2149,6 +2149,8 @@ int cmd_kvm(int argc, const char **argv)
 	if (!argc)
 		usage_with_options(kvm_usage, kvm_options);
 
+	thread__set_priv_destructor(free);
+
 	if (!perf_host)
 		perf_guest = 1;
 

-- 
2.55.0


