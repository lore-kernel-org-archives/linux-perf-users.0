Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47F4AFE0F
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269497; cv=none; b=fZ5be5W3fSeN442nJ5ZJB3loWfGsSo9Ipv67PbkBIgwmAwXSQ0v52ZBXNPWkHrxyXGJTtPh6ujZhm9WIOkVriMMinPyYW+PfwwLNyLlAZt+GWPOMWW4p7CCQ7lDIIpyRZ8+0bUcJbVASp3+/ggVO4vFpkNOjg/O3OT3JmtGzEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269497; c=relaxed/simple;
	bh=00O/XGUo+gBY8Wrh3lceAcc3am3kVkGIFmp1zBrc5ks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYx3eKCUNFt76xSiZv5Xj0Kg4KDdUMx6kErGu1ytFEI1ifoOF2/IAnzqkq3VpdhFkps+oiGoSxwvChPTDwyZt2Cva7TfxgShKeONN60g4ZRWG4rnW2MUdnnzQxtFIDBA+OPQIuJlO9SXWn0vQYPH3P4KnLftTQu+Z4lfwcoCEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8v8a+vZ; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8v8a+vZ"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33310847fcaso4090648eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269495; x=1790874295; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/c9r9PHvMsmrjg/Wx3rSzk0iudZgpbLaOYADILi2T0o=;
        b=R8v8a+vZNQ3MmS1B6GSSLezDGq36Q5ugQbGjch4JkIJrf/LbAzuYirWRVh3PS6Yk+s
         gM0da00RxwinKbYPkq3wKHSz1GUsxzg6YF+B8C70OolasX8HITvdpgnTZ9i4XjnwJrL7
         IGUUVCI+DZA24hgllTnkS0V1SzmPcyCUqUN6vhHgCWaBbwSb46ZW/Hm8BCYhsKaC6hFR
         c4F9dz2xfbt3/0RlJvN0GrC/4HXIn5Q9YNI0OiqHRRUW7Za8EbuAiVO4f8vQUxDkK2pv
         /sJX31HfDqGljSzt5VuSbzj3kUz88BNPPRMPVUtNO49KklWDXAhkarJMsFBK+U2JO06h
         naNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269495; x=1790874295;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/c9r9PHvMsmrjg/Wx3rSzk0iudZgpbLaOYADILi2T0o=;
        b=s2xtVtEpEkP3oROALQly46LP+gPfHyf4y3OEA7TUbsOPU25gIuYGYW4/mKu0sj05dQ
         bSK+DghFiC+tSwdKV4qJcbPAC1PqnGzqpr01cwWQtuVJ/7ceGudbmTak/kvaf7oHeBuc
         tB/i/80RPuu6T/JDw554Elduh6pMdp4fmmM47DGDmxbx5aSKEfeYfTeSrNm5fM8JYGVH
         aSx9fRZHdvz/DWtiDojDazajzyLKUSX6PgpVif99JTTHXJXefz2b7yGo94YB8AEzRWKU
         VmcSy65Z5PgHUcHrCbzF/E5fQkglz9o03gHTEWA81w3RtToh864wYTp4hjIUYOlYvTIT
         wsLg==
X-Forwarded-Encrypted: i=1; AKwUvBwnY5CD7cmh7jPMgKHtExnj5kRElJSB//L+TkViHjbZwFwxJ/PZhfvlNfSGoVdgsA7QCC1PggJMNsyJXlu7f+Wm@vger.kernel.org
X-Gm-Message-State: AFuF++m5IcQsa5HggM+CIRiIVwrGpCq1aedUBvHeuKLrp21e7wD3NErH
	ugJ/CTUwq4hkLxWXIXxCuENFMI9CEjGA4iHux+MvPveAjxpQvnsRDLkIoPnFIDxj3fJqfg62tLp
	cnUY302gPQw==
X-Received: from dlx9.prod.google.com ([2002:a05:7022:89:b0:144:dc13:586b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:428e:20b0:143:2973:c08d
 with SMTP id a92af1059eb24-14503fb6d74mr2514161c88.28.1790269494414; Thu, 24
 Sep 2026 10:04:54 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:44 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-25-irogers@google.com>
Subject: [PATCH v2 24/26] perf vendor events intel: Fix sierraforest umask encoding.
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Fix UMaskExt that was wrongly encoded when the UMask was 0.

Fixes: 9626368d429a ("perf vendor events intel: Update sierraforst events to v1.01")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/pmu-events/arch/x86/sierraforest/uncore-cache.json  | 5 +++++
 .../arch/x86/sierraforest/uncore-interconnect.json           | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
index 35b1763b0020..0b95faa5e469 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
@@ -701,6 +701,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.DIRBACKED_ONLY",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -730,6 +731,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.INCLUSIVE_ONLY",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -748,6 +750,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.UPDATE_EXCLUSIVE",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -767,6 +770,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.VICTIM_EXCLUSIVE",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -776,6 +780,7 @@
         "EventName": "UNC_CHA_REMOTE_SF.VICTIM_SHARED",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
index 1f6e0970141a..7fa6def25379 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
@@ -515,6 +515,7 @@
         "EventName": "UNC_B2CMI_IMC_WRITES.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x300",
         "Unit": "B2CMI"
     },
     {
@@ -524,6 +525,7 @@
         "EventName": "UNC_B2CMI_IMC_WRITES.NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x500",
         "Unit": "B2CMI"
     },
     {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

