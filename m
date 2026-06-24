Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57B30674B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278151; cv=none; b=V7FVIIKFNrsjMHuEhycP8gWKRXDvFLhYlV73IlWRO+c5XGB7mZXRtU4wEOpY97hKj+n3DO15Qdz7Cg+nM51D0REuIEmeJyv7fC3dQ3rSsdXx+potrr/lvm3vsLm9fqAM8S9W+V0mnQjts725eKDTm8+M8jN0LJX7pbG+zHUqwr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278151; c=relaxed/simple;
	bh=S6n3MCf+1noOOXyOT0egh28Ba2We0vmyA3uvN9n9H/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYcehYvCaJlB7W9N1UUox4I1Pd7QElUM/ePIRKwLHcGz9rYvo8wa9nvj8KniklAxhiriQifxWmJDdZFz1Ji/fekIbjQn3qD5UpkUBUweLT3OjEIlVhFH9QhScp4Q6v3kKCDtWu4c8sJXVo43c/56Fe5z0gSzd1xDZL7eDJFhl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WakVhBlD; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WakVhBlD"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13980b6561dso1848585c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278149; x=1782882949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVENzGx1t9zyrPYrTEFVcAA53+POZbJtBY/pByBi5mQ=;
        b=WakVhBlDx+HUpgcc4DDrWm6ctEKaPeM7I3P+2fK1nDdRiiiotYFpnCDsSV4J/VK66/
         2R4HdhfDaSbQkQU5G2znI8637kU586LL4em50eJQ0dw4Q7PQBn43wIGS489aIuwXD8TJ
         9VkA3vXg/d51etI/V9yxas2fxd2JPqFx7SgHdbYlX8/RFW47WGzg3JH0ntWjszUNjiR1
         g+2Q96OGLS4H1P83bhSBWlnemEVz4YdxJbqROW/p3NWgaekzzhZz1s9w8kUU3uJGwMlv
         TWFEgEfYCPmVQ9TDItwYkYYD7afbeB32vQyA8y9+gtlbbO1IAL5JPROH9pc9KZ4UDd1i
         esLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278149; x=1782882949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVENzGx1t9zyrPYrTEFVcAA53+POZbJtBY/pByBi5mQ=;
        b=Mad2wMLr0ZTT5CqPtx9wdgEvhnRNKXDJrMrS4lj/nFKEP3S61HXVX5swZuPbJ/Eqze
         UVlFi+8Ig+phz4tomY0QUCnu4wshG9jMgfq+JzUtjTSXuqXKCX3iBYTEEG4+nwPcShm5
         RhLKvozwkuMbQM4iTXAxJAifBWOdI7zHoMq2E3o3RmeqXWtcflcQoVRDtTdBzd1PQT42
         zqFrG8L317gjEkIiaPQMzSxAWTbKmjlpVuZ5t3XWLWXcqO54R5os1Dow1jhiW0v3CQR7
         Wr7qgCzg52tUloqLIOKxBaIS7FDAi1MWrQs91EqsM7nnmChIEWC08E/lq2FykPFuLVWA
         gu+w==
X-Forwarded-Encrypted: i=1; AFNElJ+JNR95YLoyCIstDm0YLDDOTlZAiVd40Vb09p/30RhCaqosFIKCkboSS4dhd6kP/XvSfQlTIKmzhfAKBanv4aVD@vger.kernel.org
X-Gm-Message-State: AOJu0YwQt5D+Li02a4eNqQkNzyzSVwStpOAtzk9vwFvhn04dlGXoZkpf
	VXeYA+AcuMh7p+487mYRdXRz0ETClD8owO3TmJSFpAMxnomKNK/BC71ZTLqHlH4/O251t2F1Nwt
	u/eA8e70R9A==
X-Received: from dlbsi14.prod.google.com ([2002:a05:7022:b88e:b0:136:23d8:d537])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef12:b0:137:ae1d:5b58
 with SMTP id a92af1059eb24-139d0c89158mr1499600c88.20.1782278148344; Tue, 23
 Jun 2026 22:15:48 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:21 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-5-irogers@google.com>
Subject: [PATCH v2 03/16] perf top: Fix sb_evlist leak
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in cmd_top() where top.sb_evlist was not freed if
evlist__add_bpf_sb_event() fails. Note that evlist__start_sb_thread() and
evlist__stop_sb_thread() take ownership of the evlist and free it, so
we must only free it if we fail before starting the thread.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: b38d85ef49cf ("perf bpf: Decouple creating the evlist from adding the SB event")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5933c46ee137..abc74b8ab759 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1881,6 +1881,7 @@ int cmd_top(int argc, const char **argv)
 		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			status = -EINVAL;
+			evlist__put(top.sb_evlist);
 			goto out_put_evlist;
 		}
 	}
-- 
2.55.0.rc0.799.gd6f94ed593-goog

