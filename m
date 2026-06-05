Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551B3DFC61;
	Fri,  5 Jun 2026 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702770; cv=none; b=kSjp5mos3BNlKWdokuSJADCJVxciaq3FTGxmNdfFsfi6uBnOv0EXFwc13IVeQJ4v/6WIxO+w3WQ5X2e3g3QARFl7z3CQNroLlA5M8Gwro0JckOC7tsPP6k5P+CJoNr/+EBU7M6faC5Xx7uHmCWvk6+nP3jlgXg2AggEiwxUoi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702770; c=relaxed/simple;
	bh=WtrrDXKiDxIbs99Gm+qAELVsqsOTsu5vRDXbZ5/Fy1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqfaW3LUt3NPjHpM33wjLAt3KFbJ0PTEQt5jPcF9pMMh20UV/cDvtcT0chD1dW43GK2uO5y5Nq9/cabYGMJu+P/kGnfudIltPZbkDiE8t66Z+4feVtFaZwxc2zgRLfbrQYv1GlCofpvkISG5S0qyynSoOkGZtNhhYgclEKp2tZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU41hQ9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU41hQ9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EB31F00893;
	Fri,  5 Jun 2026 23:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702769;
	bh=Gk6/priqYvwcZIoohK9yYGBxtpztJnmaiEMTYJz0TqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aU41hQ9m8AKjPdCbaXZmaA+fFnLuTgQRN23SA8nY+WyjGT+TrGs1ge55g0qWX9mW2
	 7U/gVu1gltmF+QUsUspLtpHHAtuMoFeBu/UuZLnj4Im/LyMSAykSKcBt4D6c4FYEhy
	 F49Ac0hxOb8r0oU1GpOl2H18/wzJ8VeNNPyKiylUjflTSNwBotcXO3hVssyLU8lTkV
	 L68axWe2tLkfFjoWhMoUXUiNyx4JWeepsSZwfxIlT28lpdbwWCE8pFEZ3oQQh7DpqN
	 AfenKRhU2QLQZBrGwABWek2qrIIjBnCoRTlpXgH1OkBqG47l45vIV/5Yz7ii517gpK
	 v/JPoQyzPz10w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 8/9] perf sched: Use thread__put() in free_idle_threads()
Date: Fri,  5 Jun 2026 20:38:36 -0300
Message-ID: <20260605233837.1773732-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233837.1773732-1-acme@kernel.org>
References: <20260605233837.1773732-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

free_idle_threads() calls thread__delete() directly instead of
thread__put(), bypassing the reference counting lifecycle.  Under
REFCNT_CHECKING builds, this leaks the pointer handle since
thread__delete() frees the object without going through the refcount
wrapper.

The idle threads are created via thread__new() (refcount=1) in
get_idle_thread().  Callers get additional references via thread__get()
which they release with thread__put().  free_idle_threads() drops the
base reference — thread__put() is the correct call, matching the
thread__new() acquisition.

Fixes: 49394a2a24c7 ("perf sched timehist: Introduce timehist command")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index c0cd3cbb602aa4c0..732c65008a8a5240 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2481,7 +2481,7 @@ static void free_idle_threads(void)
 			if (itr)
 				thread__put(itr->last_thread);
 
-			thread__delete(idle);
+			thread__put(idle);
 		}
 	}
 
-- 
2.54.0

