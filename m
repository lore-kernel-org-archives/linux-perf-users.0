Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676313D246;
	Wed,  5 Mar 2025 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141909; cv=none; b=hZQnwVMWt11rvOqbTv33TPVBiHIP9wF/n1cAazlJ9o54uHYeC2j3OkrXKkxw53MvwKNAfjwFCggMKj6YZ4ZQ4elhb6JyFMlWzFGjKIQKxVbI4yF1P82HqhtcEjoAQlBDAvfN37AWHHGkSSzmva1Knyb5iCoP6dOZA+tosIglODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141909; c=relaxed/simple;
	bh=AyUtY8EH5UDNbyxsA8HRMam21nN63MmotaxvrpbIjW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4OxPgC6CkXdluPdj4WOu67PvmXjWtyt8ONg0Z5Z7GqMlVpZHnEuuOQjDjSa8cSmL28ZddQyHmAcOKSvoVT3mv3YjF7+j8/yGCmCInD0cbJa8DyV/paWirsPEGJkOXYBMTKp2+54O2ct6qf3UI4NWzX+1ctQvloLDadpCTqYsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WgKX1Gtb; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WgKX1Gtb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kh3PdUqQv4yuFnWuzC0+SLXgYE4BaGgxZrXdphcypfg=; b=WgKX1GtbiuLCealw
	ivaJddyw16qqhG56IqKBFKjkk9qnEWfpdnQU/DSpkvNQD7VMtkKtHq9JKPnklDVZtiTnR7UgQg8Za
	MRJB5m9/ps3m+Hq3WqcreAHTrKNkeQrNn2rMvzINnW4OlMn7WZejBB0V+g0UPk8PGJgwW5sUb/PqE
	MFEmdXkKpn4YtIu4TiVm8IX6Ct5CxL2uuEPunLv66PvI3vyb418NKQHOmZEGfM/nuV9zg3zZmER1g
	GmsFLbj4x9qe4jVQT2lUyA1mp8im7BwJeqEQ9Ieb6TnsZdgmHtdvOWWWKq41VgrQVNSkIlj8h1vrC
	cPRta8Jb7ypIW7T6tg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tpeXk-002ic7-1H;
	Wed, 05 Mar 2025 02:31:32 +0000
From: linux@treblig.org
To: irogers@google.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/6] perf util: Remove unused pstack__pop
Date: Wed,  5 Mar 2025 02:31:17 +0000
Message-ID: <20250305023120.155420-4-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305023120.155420-1-linux@treblig.org>
References: <20250305023120.155420-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of pstack__pop() was removed in 2015 by
commit 6422184b087f ("perf hists browser: Simplify zooming code using
pstack_peek()")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/pstack.c | 14 --------------
 tools/perf/util/pstack.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/tools/perf/util/pstack.c b/tools/perf/util/pstack.c
index a1d1e4ef6257..141ffa129c69 100644
--- a/tools/perf/util/pstack.c
+++ b/tools/perf/util/pstack.c
@@ -63,20 +63,6 @@ void pstack__push(struct pstack *pstack, void *key)
 	pstack->entries[pstack->top++] = key;
 }
 
-void *pstack__pop(struct pstack *pstack)
-{
-	void *ret;
-
-	if (pstack->top == 0) {
-		pr_err("%s: underflow!\n", __func__);
-		return NULL;
-	}
-
-	ret = pstack->entries[--pstack->top];
-	pstack->entries[pstack->top] = NULL;
-	return ret;
-}
-
 void *pstack__peek(struct pstack *pstack)
 {
 	if (pstack->top == 0)
diff --git a/tools/perf/util/pstack.h b/tools/perf/util/pstack.h
index 8729b8be061d..712051b8130f 100644
--- a/tools/perf/util/pstack.h
+++ b/tools/perf/util/pstack.h
@@ -10,7 +10,6 @@ void pstack__delete(struct pstack *pstack);
 bool pstack__empty(const struct pstack *pstack);
 void pstack__remove(struct pstack *pstack, void *key);
 void pstack__push(struct pstack *pstack, void *key);
-void *pstack__pop(struct pstack *pstack);
 void *pstack__peek(struct pstack *pstack);
 
 #endif /* _PERF_PSTACK_ */
-- 
2.48.1

