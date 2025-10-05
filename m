Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A029B8F8
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688715; cv=none; b=Ctsm2/1ZLnD20BTQQ/hkvOuko5cuE4yV+mpAEyHZrdoJ5o6l4PMW5FUtrq2UqHEaMLhywlA/KpFtqXZR7HLPqtK5+Bq//KUQGf9bZ+gMoNVXVgkIzeJdLmw9F7OVvxIGU3AuVC4TuTihZaDf5iLvA2kD8jHnWwWIFlz9vLFxqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688715; c=relaxed/simple;
	bh=hdoCQdAbtsUWh5ZmAMAISE0mVBpYI+EBEkd3D2mOABY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7knRiINX82l45DF8ttZr2hP6PoKi1ZnJfn4hxcNg/ELKyA0+Qg2iigsW+7ZaicV2ZxUc9oxPa6dFS/F7FzkRUH/TG+JeTFCEN3sY5pos6HiUi5N7hzswVPAcy/ENjPbaey67GyRNW0Mqtp5b6tz+u7eQqxdFkkxswK6ttukWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QitbECAc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QitbECAc"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3304def7909so3631507a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688713; x=1760293513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmHQ9jUxY2dsC0Ng49EzdCtxcjpPoOc0ALb07dGw4cA=;
        b=QitbECAcy00f9B+2FI94ZmBCi38POKxdIruWgupGB+tBdISiwwV1e07Vgec7gOA+D9
         a/Wm9irvkFilrvZ+Wk6vN25vrSkDRjmjRkwdQJLgsmKB4iFnTHGFg0KOues8j11EBpLr
         n/G07/xnSIwPVr5hCLq+HIJvu/qT4IFNtjw5hRGmBXjusqsRlXhKAWqd4px9SueZ7dhB
         vLQ98mfCBZBdl2s3gmt2Niw4nXTX6iwHEU9Vc1HQUBo1PSjo0Ze4jegjvqRYin/kQpHQ
         OBucvs0TP0ktWRvlF2mj4W/uVfFdINf4l7u2VLnDA+OgvLQpzbunmAWsOk01V6aOweqs
         dv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688713; x=1760293513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmHQ9jUxY2dsC0Ng49EzdCtxcjpPoOc0ALb07dGw4cA=;
        b=uSuVJKjTwTlpjOFSUVKoKR0v4X0RTCYbxxCYamBtcZ/cEzMYuIBx7gLdIi/TBlmCxO
         hM/U5GjCXTtkpLxKt3qTuUzoAAFvf8oDuu0cK4KxTPEe2KKKo7duRYGGCJGO8ktX3DUB
         OQgc3bmraQ0XeE84J7LHnIca7Rcs7ghNRYKoDaF2k9NURhwZTDdfJfANDrAVXrHVf+dX
         ulxHITlWdk73moVt+zx7ax1/T4/4bIpxVMHF9gxqUV/rsp79/6LvuL9BbTsr5i2Vxk+I
         WGiGWX8rS7+hj83Nw1yJJaNQwWSc2A0XSZDhVBfo217Db8lNAVozVyzpAzsm5ZxPU/Db
         iuNA==
X-Forwarded-Encrypted: i=1; AJvYcCWQixIKKe1XxEw/ZborzATkgo/GTWU+aDFVVfbXGkGIEYtAm5CLDnARdFEJc9ZPxVMYG+vpbt761PXxxfQL6fRW@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKR/OObXbrJ37//3REF7iOpdISmApoVYKoWtjhWYy/QRR8Cko
	RJsCTpDQvoEqkzY5ojNcDLAVAjtoDdkU/+41brrLtfbTnqvdC9WDUNFyLXKcZzh7OC3T9Fqcf0W
	DsqaayPjf0w==
X-Google-Smtp-Source: AGHT+IGxfBHBtAfDVShxnkdfD4AX6csx/jar1g5lis37MLHrFEcPg8BXzuFbbyHPvfJr+Z8jNe1tOat4HX9C
X-Received: from pjbfr15.prod.google.com ([2002:a17:90a:e2cf:b0:335:2897:47c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a91:b0:332:1edf:a694
 with SMTP id 98e67ed59e1d1-339c279e567mr11876520a91.31.1759688713326; Sun, 05
 Oct 2025 11:25:13 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:21 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-19-irogers@google.com>
Subject: [PATCH v7 18/27] perf top: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a11f629c7d76..710604c4f6f6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1695,11 +1695,13 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		struct evlist *def_evlist = evlist__new_default();
 
-		if (err)
+		if (!def_evlist)
 			goto out_delete_evlist;
+
+		evlist__splice_list_tail(top.evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	status = evswitch__init(&top.evswitch, top.evlist, stderr);
-- 
2.51.0.618.g983fd99d29-goog

