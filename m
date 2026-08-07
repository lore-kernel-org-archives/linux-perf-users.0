Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5583D3327;
	Fri,  7 Aug 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115326; cv=none; b=HUCBroknR9Eop5YoCjfNuwRuFcOuQtBKvU5aAjcwmPpg0TbPvl4+iHpw1N22N8SZUhIJ9CH23krC1gQUxoPSyh+NfzyIWRNhECoJ4WarILU1g+nhFKR9gApF/3EfhioSac7zrzikxlK9LDNSOSVvNbikALLUrNHsIfXd771gjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115326; c=relaxed/simple;
	bh=M4wHK8VFzW1lE9rOKw/akrIuQPmsqmv1O0MSP5bWHcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7GGrywkjJ2ggUzqkXwk0l4lhHY6LElpU/47kZLO7M/aJg1L4GE/fDibAq0jw/yGXp+1XYgmqRCRLlLLqikWTtUQ2gcAnS52lF0MBdMw39CgpTlkWO3kX6Rc9qECFfxNjWkHhPO7ZpQF9eg9guqqJ8mibisiVSPCNqvfNqIWEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmpTWoEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmpTWoEc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AE7BC2BCF6;
	Fri,  7 Aug 2026 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786115326;
	bh=M4wHK8VFzW1lE9rOKw/akrIuQPmsqmv1O0MSP5bWHcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lmpTWoEcfE35xy8UpR/u9g7c56XiF1rNYm+I5doGVmYlOyLHr+LQrh5FSsQNrZiEV
	 bSt2/zQw+FTlvJNcDwKVtDq5hMVahhNqYPozVYTgj4GOgaIg2Z3Ez+u3YEZQJarC6z
	 2RbqALAiVX540p3bWXmZ6fxTQjGScYrFXRge9NtUDfT1X5IoL3/V2J7HHMEOrvtTzk
	 VmWkkwiAkT6blqIzxFHU8s1A/1oylpLK8iUv6M9Qsjc3t+XaQtOKOahhe/1dBifUwI
	 Ym74VmGyPT+YaDCYBNbbJRBWn3VAlZoSPuUL6UDAdH/2u+twW7MJJ9dYh0YF1bt7md
	 JNPZIyau6XEnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D400C5AC7A;
	Fri,  7 Aug 2026 15:08:46 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Fri, 07 Aug 2026 17:08:35 +0200
Subject: [PATCH 1/2] perf kvm: Fix memory leak in process_sample_event()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-perf-kvm-leaks-v1-1-7b5e2f97905a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786115324; l=1353;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=UAZeAebDM873C0dbCUU7lvlcAJE4j8rs08YgESgmpsA=;
 b=qtTjJiu01JaYfeHbocbCEWEI7xu5ZDiixjxUlsRwASTEx6l8a1f3WZ/OYh7JSdC4iJJbIZv2C
 IfJTtZKqDzKD4WMIUnzWL3Vo12eX/f6gsBY7hGlOoW0yWOE0Mrh8F3o
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

From: Michalis Niarchos <michael.niarchos@gmail.com>

machine__resolve() indirectly acquires a thread reference via
machine__findnew_thread(). Release it, as suggested by the documentation
of the former.

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
 tools/perf/builtin-kvm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 00baafb05603..8e7bc7b2db18 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1145,7 +1145,7 @@ static int process_sample_event(const struct perf_tool *tool,
 	if (machine__resolve(machine, &kvm->al, sample) < 0) {
 		pr_warning("WARNING: at offset %#" PRIx64 ": fail to resolve address location, skipping sample\n",
 			   sample->file_offset);
-		return 0;
+		goto out;
 	}
 
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
@@ -1153,13 +1153,16 @@ static int process_sample_event(const struct perf_tool *tool,
 		pr_debug("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
 			 perf_event__name(event->header.type), event->header.type,
 			 sample->file_offset);
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	if (!handle_kvm_event(kvm, thread, sample))
 		err = -1;
 
 	thread__put(thread);
+out:
+	addr_location__exit(&kvm->al);
 	return err;
 }
 

-- 
2.55.0


