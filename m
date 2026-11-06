Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948644;
	b=DgMK08kkDb3uozylwuCqdpq00ml4leVyEyEkiUYGRkDYMgD7q3H8Po4r+A7MuUPoYEPN
	 H9stTBwCwTVPFUDSMQHaponXuSKMCNwLvRezU/uIOAfKlVb3kkArwl0sI/yx0iU/eI4wC
	 jGopr8jAhPK+TYsbv0pOengVQ5FScU/Qd70ZGTiK/Q1UDJcg43s0P1E0pTfZEg81BQw0w
	 0WNqXmDiQzC7J8C2iQOuFU+/nf5ll43MJ6mDkOcpUwsdo/cPZ93xZGH/FRog5R27wHAyX
	 OD8enZ/JIWvaFfK718+EH8D3usI1iU3DmxIbFHlSGfqhJ6YXNnW8Ud2JUWtRqJP2rkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dlGmy1iETR07VpwAF3gSNr7L3yDUEizC6SlTALxKZy0=;
	b=KCXp48ymVr09c5AsONiryFiih7U3ltsgNnC5BkYlZ1WOA7rig6DN/O11SVOkhEyvwuRV
	 FiNOa3CawE1cQn0x+4IlnnhhbjQHH/1tohNUvTUjsX8FqKmWMi2499PRGL9klzj8Z7iTo
	 x9XO1hpg9wg2BjNcWSMNVLNn2RkPX/EqAyWucEp9KN2eHoG45N3L79HWW3lHFoZyYuBuM
	 bMVd9khU6zLXjIDufbgkJK6Kc/sWpghctHzPVLyNebghTRtbx6MsgK4U6bSfq+CLk5Rf6
	 6DEw5RrvFQKwxZ0R+o4lfr8SgLHdeg9LQ3wIUWhb5ZtAbhI6t010d3EoX6ZqRvj4vog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=glmXlu7G;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77364606D80D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77364606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=glmXlu7G
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso517399eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948643; x=1794553443; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlGmy1iETR07VpwAF3gSNr7L3yDUEizC6SlTALxKZy0=;
        b=glmXlu7GQIswPutY3CMwwBHfn4dj6yvsNrnSScZmfh+i3gcKOKHVC5zE5Fmdm38fC0
         l8ck8guO6lHPapJgkWRUwb+5VKsZL/c9Vzh0p0ODUHXrlBa+WjRaprGHIOoxyQmrbGEH
         sKLK2JsACi9sPSwFObiwb1Q/L6qfKLvy2k0cXcvWtr5qFsCShoLCujWRsq6VviyYkvnC
         J9lT8WcDVoKm4mU4sVnEy1U6ukQB21ao04tYFqn2RokZIkPHo7ivtMiD2pwhKSLA+C6n
         ktBOClq5oPNK9ZBLmSerCq3IfWvFyT3GphCq4p9+YgJ70h98QtMwMgn55ulzqn3P8gAr
         t7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948643; x=1794553443;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dlGmy1iETR07VpwAF3gSNr7L3yDUEizC6SlTALxKZy0=;
        b=CeJ9InQiMoUoQ1VBg4FMTStHy3pcTO+LnTavpQ102WlVwgjjHYuqtoV7ke1CO6PlEa
         q9XyhaLVDejPgNcma60TIOCqmv/zSAQPThSeL3qwMo4zU73gXQQntE3ZfkpSAkvbMQIN
         znKsoLt+G0PsiLO8c7wp8JSwlcDg2E0JshKi7s3ZILeKLC6zZ2O9bb81yoy5yOflpVV3
         fXoNB0QhRYze7+mCBo1DlSGuICgY1Uxc2jh2uHqqdbqq7po40PbHcpPNKui2KrYkdnto
         oQSgnYNbdRcB0Ucswj7yRkgjOTjXZZBahPx8+XeqmgOPS4TlaoKl+TUA5N1yfpQ0+vUd
         Bkng==
X-Forwarded-Encrypted: i=1; AL+hErGtR3Ibkv79dUjkaWstbb62GToJjHWAmY2amQsyDlWOPr1Keda8+XT4DFajbBjoqvoTysJ5EyXwfTu2VdG87QH8@vger.kernel.org
X-Gm-Message-State: APuU4Z+tqMfR/Ii4zv4eaTnomv8JZCDAQ9hNWoW9isNN8vhZbvLjevHI
	pTcPl8ILqO7c8gyMa6MGHyqHgvk93zTipq45txnwOEzr6OBxKJcJOY7PKp3qpKY4qndGeARr5ol
	/fF+UvzUQmQ==
X-Received: from dycrv5.prod.google.com ([2002:a05:693c:2e85:b0:36e:b3e6:ebe2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:80db:b0:36a:1f4f:3e9
 with SMTP id 5a478bee46e88-36f75444e55mr1973496eec.20.1793948643167; Thu, 05
 Nov 2026 23:04:03 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:30 -0800
In-Reply-To: <20261106070344.329897-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106070344.329897-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106070344.329897-7-irogers@google.com>
Subject: [PATCH v10 06/20] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Annotate strs, num_strs, and capacity in struct comm_strs with
__guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
accesses hold comm_strs->lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 6343a3c9debe..9fc4e91a36e9 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -16,9 +16,9 @@ DECLARE_RC_STRUCT(comm_str) {
 
 static struct comm_strs {
 	struct rw_semaphore lock;
-	struct comm_str **strs;
-	int num_strs;
-	int capacity;
+	struct comm_str **strs __pt_guarded_by(&lock) __guarded_by(&lock);
+	int num_strs __guarded_by(&lock);
+	int capacity __guarded_by(&lock);
 } _comm_strs;
 
 static void comm_strs__remove_if_last(struct comm_str *cs);
-- 
2.56.0.455.g6c5a503b38-goog

