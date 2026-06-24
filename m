Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7B287510
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278150; cv=none; b=XUm7a7iwkBSLUbf3ZBEn762BRaegW4pevgkh6YovtlmpH3/v96lAzZBCZBYkB+sC7khdDeThpvBjhBu9EgfHnQS0qLRKBuRUk5AVxPZbh922YMpTX/SVsTg/2X5huJnabMTyCXPndcepudAzMnuPnDGqvfiQS5SWoFZd7ype1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278150; c=relaxed/simple;
	bh=w9/h5A9i0tFKwvMZ+fm1xkezA7frbUU0xlPQ5bEXIeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F8S3Y9laQJFPaNq2mgoMpK8WtvDrkh4SZ4KHSgq1ngSFaHyKBpNY9gvk4sxcaXG3stees33FCSXpd9WT8vIVlxIbgjLc88X/tGgGjWbpEOi/asR0cnAthQh+bmzgQawtEbfwOS57tFr++Or/f8YtGBFBbQ31q93XQw0ejxa7qig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elnZkWyT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="elnZkWyT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0532a6588so5142575ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278147; x=1782882947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFPERd+D8cAoAmR9+PDjt8Eoz3E0uFhdvI4++MtaiD0=;
        b=elnZkWyTZULmHLRWqTady8WNbTf9RQTpRlz7lP6ToMJtfsHVdSVkAutnffgJsdGoDV
         oDEj1iZjhVVb8RU3gLvSv/NZOZi+0rzq/ZbVsoe/zcZ/M/6UYs1Uuz8x97wI7wVgKIGf
         zL1dE02pAOaY6jHfpdUwwl5UzF4+l9D+NF4eEoYktgeyfJxsRlRczAkVuaXRctIStxih
         ApLO1M44IlyaUf71QsFGM7wFoOFKbO5+qWf5KGpO0j2/CqRX42bVwCEbANyXSwF4bCj+
         mBajui0/FD6Mmw+7tV47slf0C6LHZMM9/bTDMsZbpMDUEUXH/+qGOgE5knm7lhLEhQPk
         FKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278147; x=1782882947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFPERd+D8cAoAmR9+PDjt8Eoz3E0uFhdvI4++MtaiD0=;
        b=azCtuTDv3S1G9V9Px7ezNOVtHfxNDS91RHYn2dLMNxN0YCJsI9fHdwusB+uKHBDMRW
         cvvQiFuGbKsBStyWRz2FI7S1k0rrW/zzyrMC33x4mMk951BTIRun0hhIQfaX84r83PS+
         lLrzaqlDDSh3r/s4KWkn8yF8jnsGLfIHowBAfRdBJWz1RUVrouPMGM8P/1gn+yH4BMVb
         5B8yGdVuwWubdM1eyNTIbQbgqeM9YX+DHmZVFxB1oR1LHAg/+ijcwT2hHBSIxRUTPPTF
         iXZCmZx+dvzawwfRFr+nW6/bpWwLf/TQBTwh7g9yvGTxfiVcWjcJoPz2kncv5KgEAr2g
         2U8Q==
X-Forwarded-Encrypted: i=1; AHgh+RriAX3kAB9iXurBh3DNeihCiqgoE1tWpWM0KOVKxxlQPZ8YVlKLS2/lH3gLvj4v+htM86tIPrDHTQQ+fXVp5bzT@vger.kernel.org
X-Gm-Message-State: AOJu0YyNs1T/GBUBR/qCRqEiyPUBUXl0zaRPIpYVHeqcgSQ1IB5cXP6w
	9aTdu5iQssB04QroymrhcrPVX/q+j+Fndv3sGo1mGn4Xxx8cQPgEGE1ZCBgBit2lLX4oysINZDl
	OQbqDGHLzYg==
X-Received: from plgw16.prod.google.com ([2002:a17:902:e890:b0:2ba:67f8:6257])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18e:b0:2c0:c625:400d
 with SMTP id d9443c01a7336-2c7e171c1bamr20457025ad.37.1782278146334; Tue, 23
 Jun 2026 22:15:46 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:20 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-4-irogers@google.com>
Subject: [PATCH v2 03/16] perf tools: Fix sb_evlist leaks in top and record
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
we must only free it if we fail before starting the thread. Also set
top.sb_evlist to NULL to prevent use-after-free bugs.

Apply the same fix to builtin-record.c to avoid leaking rec->sb_evlist
and calling pthread_join on uninitialized threads in the error path.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: b38d85ef49cf ("perf bpf: Decouple creating the evlist from adding the SB event")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 2 ++
 tools/perf/builtin-top.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ebd3ed0c9b3e..b106d50f6d97 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2247,6 +2247,8 @@ static int record__setup_sb_evlist(struct record *rec)
 
 		if (evlist__add_bpf_sb_event(rec->sb_evlist, perf_session__env(rec->session))) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			evlist__put(rec->sb_evlist);
+			rec->sb_evlist = NULL;
 			return -1;
 		}
 	}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5933c46ee137..570410599f1b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1881,6 +1881,8 @@ int cmd_top(int argc, const char **argv)
 		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			status = -EINVAL;
+			evlist__put(top.sb_evlist);
+			top.sb_evlist = NULL;
 			goto out_put_evlist;
 		}
 	}
-- 
2.55.0.rc0.799.gd6f94ed593-goog

