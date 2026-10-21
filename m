Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602689;
	b=LKFvM7iw4GD4bz9O2nxLeuxKygvWGKUGuOqmw7ZQaW7aQlxEozqU6f42dAEaAQ/DwUSq
	 fER8nH/YRmNnYvx8pyszoKvjNrTxvZmGEPT9qnuPEpB4/A+0TLGLjT0gzUit/TTB5PqiG
	 h6DTwg9m3BYWgx7ikUirEM64XHEOPWB4wEbaizipe354j0krxxHKB/VTQDt6+FxrdyuMY
	 BDpaR5X6d+w0PdU8LtOo7OF7KmlDZdU/MF6eFrxuhQCxDoNY6sz7F7qryPPaoxdsBrgoG
	 +LWBuymwhceJipKdAlC9nkISOXQ5vfcHmA1f37gOkLhBeP0Gtt/nfAcoNhqDDFA3E/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=BGtpnjqbgsSI0YGAfALssqGviHqvt2+cOYL3HWLbbPs=;
	b=Tkl4NCa5/+QHRvPDOBlDn4p9Z1OEUnC4mmM6HRj5qWf7Go7nywzIMyxohzvJY9b/rYSL
	 BMKows+5pq4Uhbov2QdRktLiEgefSUwOAbyoR0VAWbPaK2DZn4GT63+YQojfOFOvF2AFP
	 3k1AyNLjyWawtuplE2dRt7Y4aPiRSDR7XQ0tqMcM7rKi/f8/vI/Igfw79X7E/RYEAoTAm
	 FfhSPpNAz6xhc1DY7idqqq1fm4iojvn4St7pBNOpSwvXmZ0NjEUVwxgtZ2Sq/FOJOH8IZ
	 NllG3XiyjzH/hdapz6YxSpVOlZ2bpEk2Pi4UNEDK8Q7C2BT4aLzKK2f88vWqKG8gkZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IkFzbnFS;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96F606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E96F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IkFzbnFS
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-359b81ad4e8so1627726eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792602688; x=1793207488; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGtpnjqbgsSI0YGAfALssqGviHqvt2+cOYL3HWLbbPs=;
        b=IkFzbnFSKkeWqasRjc2/8jpsHs6JtPJCDzosVxASVCgQsrdtWQa9MXhtWkRKIzJFVv
         mmbAg8HjYrRG2DPz7QZivK09iF0d9BdE6NXbHfUhCb+5DGqCnO68Ds6c//LuE6jTRJfI
         Me6b6upFGjTEraJUC4AVjke2cIASr55xqijxV2Jvzl3iuzumwTItjrFtlKox5Jhe7Q8i
         1gMI9AKwuTfRyZ2rFIrOS4i4Yf9Dy9Dpp9tvjD+1IkbnJ7DbLe8HCDTTomZAK7b5RsBa
         Q3SUvFyFo1CFi6TC6nvF7TPdFDWoDs441Vry3qS2MPbbxobfPupEpK0oX/0tpEIWHv1Z
         RP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602688; x=1793207488;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BGtpnjqbgsSI0YGAfALssqGviHqvt2+cOYL3HWLbbPs=;
        b=X74eLcSUqOW3S0/LN9NODHWoMc/fBg4Cxxqo6VNeQsb0Kq2oi6Osxl6k+oTtgbOl3x
         aZKshMRkasxUM6LU/hfgZHtYVLE6QZoIGXc+uFDuBQBu7tzrifKMwMZF2wIZZVqKPnZL
         59DxIEO7mTflPvrl8nKstq5aNdum4btgfCpBQLVvSiokbsGDNU0RFm24Y1XOZ575jL5j
         peXcfvPSyNyv1xswUhy94q7MJeAkCLkb98HD/tmMtzdOeLUQXGO9NFvNjVDJz6elbC6E
         YZ9hg6XWvEaaI7rk7AdG2dxyf2jmOqh8yqOwGB1yQ62EXRhw6Qq+Gnezd+8qWkMLObP7
         PTTg==
X-Forwarded-Encrypted: i=1; AKwUvBw8Hoif8NtEuYl9Z9JUTV3Ubvc9bL4LMjTOmgrLMkJ6oPfJrdeAt+huI0bRvW9FnoZM2j99H/q3q8bke7v3BkIF@vger.kernel.org
X-Gm-Message-State: AFq9FYJGNu78YohKLeA/+qMom2PbbyuPSnRDZu2yqlQZpZoLbk46qq/M
	i3ARNfpNpLvcbAbZy2gkz+DsNrmjWsCJk4oXdbHeIFmPqDJPkP9aKtJrWT4Le+Yf6fVUgifonqn
	xz64wUr+gHw==
X-Received: from dlea17-n1.prod.google.com ([2002:a05:701b:4211:10b0:191:592e:bf3b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:ca01:b0:151:8280:2c1a
 with SMTP id a92af1059eb24-190a6dbd524mr3636882c88.42.1792602687882; Wed, 21
 Oct 2026 10:11:27 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:10:32 -0700
In-Reply-To: <20261021171044.155240-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020163640.746159-1-irogers@google.com> <20261021171044.155240-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021171044.155240-7-irogers@google.com>
Subject: [PATCH v6 06/17] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
2.56.0.218.g1ec904b173-goog

