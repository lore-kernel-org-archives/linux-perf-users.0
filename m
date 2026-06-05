Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE83B7769;
	Fri,  5 Jun 2026 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691643; cv=none; b=G4IQowjIbyoNbqA1Mfw3ZKpJNN06qfNMqyb54dCQ4Gv2SZ5A6SCAspLT4kcZTFoDPBsr97MSjl+QeIyFuVPl/z8KTUk4Sq50ggTMAZCMVmhYvqGyQWy4W73AMeb8BcuKCu4H9SAGjXk3+DAZtoKyzb3iUl3EYNUhu7sEYdBNIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691643; c=relaxed/simple;
	bh=8zVKOytPidba42CCO5uk3rYknH2kLtRMBSzZDgyjXLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WW+W4/ImQayX6fbZT5Y/7l4zkv/FpdKSUvbZw7r2HUGsXZGUZBLxT0w9Rpro2adQW73CqMvn/QQ39hnzR7GFu9/mqHW3ZJjgYl6acQRn8EpZXhLs1fGwiH9MlPuzikICnW32cbILTzfnMT6e7ddwJGQPtXzj0pql3xrI+c0FNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxgT7hcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxgT7hcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFA41F00898;
	Fri,  5 Jun 2026 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691642;
	bh=GraoFdIITf74OVmkd+NYzAN9KfdWC2E1x83zmhk9dQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxgT7hcmIjfhk4AFUvW1H3KSbry4gpUPo0hxDkORggB+1AdrgQl++skCZNSVSJwOg
	 YjASrxqFXYoZ/l/3E+6NEf5sZPt+twKvVivN9ng45KFrs84t29mvr3hBJISs09tX9F
	 GDgkQjvMCM/GDv7+2m3fYzMZVhQVsF832S8nb5RpflnGb6tlGFXBXlguH5dYdxWO2Z
	 dtWTnNt60Ts14xnm/8+uVrWNRegL5ZEYVIXx9K2uKK0Lj88QnJThJrOdNAB6UkXU7D
	 PBFWhzLC7Cauh/US8Sa0U12C6Or0FAaLqsaf6QBXgjKNwprTNiXEVconyizuAoRAqU
	 5s2fRw7xoeI2g==
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
Subject: [PATCH 7/8] perf sched: Use thread__put() in free_idle_threads()
Date: Fri,  5 Jun 2026 17:33:15 -0300
Message-ID: <20260605203316.1758661-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605203316.1758661-1-acme@kernel.org>
References: <20260605203316.1758661-1-acme@kernel.org>
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
index af6322ffaaa6eb1d..3668048ca96cb71a 100644
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

