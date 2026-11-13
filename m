Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606563;
	b=brgOP5WFJCPO1p4cgzns8mxujWU5/Bd0c1pC4Mhq3lwjNS/e9FZ99BkTITDSC53AyvLy
	 XLaMvGydXAian2hOqeGUvgJGzXwnAN+nml7I3jZeLojo5IVGsoAccjmcodez1Td97IjTH
	 3CjAwOL89V88cbZb5qtXp1rgIJqqykIALfbPOiL869UCyAHExIAGCJRtKgAlJAYVAeeMN
	 kuPJMz+tXLNevy5ZVCxSngikF0tBm+H39yOqnOco+ZFJmwB4tVXaVlCBxyo7B/x9CdSzT
	 fxrf0KOoseQFNhgi1Pc1eAcGJVgHdW5Jhrn9i2VYWX4GR+UxtTIDY5rbJqkD2uJkVkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jLoq5kV747oI2rAx28nt5PJySw6tzJe+qioAERJHbno=;
	b=tBYTe/ivMR3qINun+XFtLfVl4/v+Pe1bOaWssQ3Cn5et126yGgmCQSDh2SZraabaeGxT
	 uHVuk92TGBIvEdubtusF+cPNp9g8hYC7qCdFe8PKErh9Ac4loWjGLDfav6jZ9DPTvNJwr
	 uXx6FKq/OkBNXCb91x/hOwGQR+1oL3zXgnkWcsszKyrYTnLrA/mysPPH0DneofgAtyKjF
	 NsBC0UZXL3wh3usc8+oZStLyM338wqKanfpQoFtk8A5cUMpsVxXo8Gd2PDmdxROG+5dm5
	 2BcLq6gw7RB/UtyS3ePOzAa6z0ZgDxXS5loaHha8PX/tzBJxcOXwtBiekws+ybKXReA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kCqKPl8m;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7A606A8B3
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C7A606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kCqKPl8m
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so2168456eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606562; x=1795211362; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLoq5kV747oI2rAx28nt5PJySw6tzJe+qioAERJHbno=;
        b=kCqKPl8mQMq/Gn9vCbOSiDRLlHQutjB1DLZ63OSRtcgjrBcMbWG9EpzEWm+y/FMZ5w
         dFwERLXlWC1dft8SzpIYU/0A9R4UYt6zltGc7LxMvnENKBjs3yI0/badNFnSrc4tCIHG
         MxD1p8YYzG2+jQTTGmT9IZZVF1NDGX3/WpY40zVTvwdg3I1CgZR9+hpudLG6LSXmTnnw
         oz2QJBnpUA18iU9bghAvzv8mc4DgewSGJKE56iLFXmuxw0e6vHkBan3In31d7MeEFDA3
         jmk1OHVvBe8OaoCg9g4TRs526brVRu4XnobPwkWMYssND49puZTovWvyjDrF+wF7RSR/
         /G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606562; x=1795211362;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLoq5kV747oI2rAx28nt5PJySw6tzJe+qioAERJHbno=;
        b=A2Q5FviDuu17J/BPeZ1s8c+dz7LuimrP12nXqMwpgSllcYXPcNuhT4Q2TMNj9Xov8s
         50URdjoWGrAOWdfNUjN6LRFHHM2G+qKJMfgcQXULDwxzO8Edkj5KVVRp4vAwHsxjXUnx
         XEwKhT5Hpz2YiQGbrHm+HKDhehsAFhM5JIaJN18WyEbMqvYo6m0bukGsHQmIrsyUOhWA
         YZRnbLEZHU4tdpOxF9JBFH5MKakJcdi063NPJtCuY640JYNBZpemOl0UbMsQjYv3Nwii
         C1gX1F9VdA5H+GncLPn+C7Q4OJufSwVuMmoXBPmI9y+ihA6G/5CbM5KcwQ2movOIUCVG
         M+Mw==
X-Forwarded-Encrypted: i=1; AL+hErEmFu9VxCZ49y5IFE+nuoCk7RMXN+UTWvQE2WxZ5NctlyN+ZDqTg+DU9gjCKkOlVafeYKCD83LHNo8Ve4WuEOF+@vger.kernel.org
X-Gm-Message-State: APuU4Z8gDwK6GyYRs1WtjiLbB0TDejQGpZDu3lJgREPDTwoGoKo9O6S+
	Vyv/FRp1rLKMgduM8rjHjCSao2wOw7B6qs++nIRShcs043LBzircpt4DnFUCcj1U+eHYjbpJ1aY
	CZ/pK+YIFYQ==
X-Received: from dyvp15.prod.google.com ([2002:a05:693c:884f:b0:36c:9a6e:5413])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d115:b0:36f:29bf:4326
 with SMTP id 5a478bee46e88-37960384a9amr2927593eec.0.1794606561937; Fri, 13
 Nov 2026 13:49:21 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:28 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-5-irogers@google.com>
Subject: [PATCH v1 04/26] perf build: Don't check difference of perf and
 libbpf hashmap
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We want to explore diverging the perf hashmap from libbpf's to fix a
few subtle bugs around strict aliasing (casting void ** to long *) and
use of ERR_PTR which is non-standard in the perf codebase and a source
of bugs such as:
commit d05073adda0f ("perf trace: Avoid an ERR_PTR in syscall_stats")
commit 96f202eab813 ("perf trace: Fix IS_ERR() vs NULL check bug")
commit 9f3c16a430e8 ("perf expr: Fix return value of ids__new()")

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/check-headers.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 531c0e0e84df..846a1b2fa5d8 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -214,10 +214,6 @@ do
   beauty_check "$i" -B
 done
 
-# check duplicated library files
-check_2 tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
-check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
-
 # Files with larger differences
 
 check_ignore_some_hunks lib/list_sort.c
-- 
2.56.1.703.gf848ed807c-goog

