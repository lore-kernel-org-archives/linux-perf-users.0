Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921203AA9D8
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259706; cv=none; b=JH7ExM82jn1SRn3kaJHaijkLKVbLIAZj/GeQfUYKjJ5IW/uh5F/uObxEMfEufDx0UJxTLA4XCKSUPRM7wJL07HLXG97c8Tp3d3TGTiuxjHQiwW11026VrLB9wZOBbLr/gBp5D0a+UOGNlyhsSjbeR0ihoAqXC/8+9NLXrX1pZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259706; c=relaxed/simple;
	bh=gu4JmblVv7LZ8mh2w/vK0itTuIYVGGtu2PAK2cVEN08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AI+UuBMWO9LNW+kImglQHlRmCDNYwnvbmQos+I92ismWoW6eVAgWJK4ep9IGmAl5GPWiRhTFjB2hzJtSvciFoq2aBd7bRqSghnJh0DINo2xi+R1hnAJDll4Dut+W9NVGzmsyrPAREncH2ki9tAlMdprocbltrh9GFVmRTMEkyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4anMKo4; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4anMKo4"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so567648a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259705; x=1786864505; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmLwD1z8Vp5YH6ks1S+BnDxVzcwfvN4i58qyMDnWh1k=;
        b=f4anMKo4zCob/8H1uctm7YBDDNqjSTS0hqAdeeeXaFOdSPKd2o5+GbZ/AnwXNtoGdd
         +F7Pz3NHrK2Big2jpFSOJCp2eAAA/9+vlC3NT5R1jMNhxi3SdI2Ud2rjna+UYua3HTyE
         DttoBGP2EYJ2JvbpsIZHIbwIZGqoyLKYbdcsZBCzapTTpf1Faxb85WGCV3TdNHXP6Pe/
         DQKgj/7MbTzR/XTvjgpDiC5+dJKGZZBpsMi32Y8b8RZmvLRJ6Nb/pL75WMvnUBwz1VZW
         RP+DlTlcxoolEm4T6vmNDOQB7JJR1F7Sl5uz76ONbBnb8C970kZ24TX9EtY8WWwiONHj
         4wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259705; x=1786864505;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wmLwD1z8Vp5YH6ks1S+BnDxVzcwfvN4i58qyMDnWh1k=;
        b=iMRTgFKZvjU4wyzoYdHQajFoN0yrrYu9urRQfQ1bKQBcEeEnxEUmJ4CjhzcNRNxsJj
         nLKxOXSviHZI7LY2/KynNX57x8kSzZj/13EiZtSCzeSsLYZiZ2WaTKTMZd8VK4dg/yPv
         BTp9nWy2XeIrOCRl5wlU3bYcxY/e3gDsO00ri+behJxdeHBdcI05Dznajg9CltCXR4Sb
         BYMZ1HhRo0QAYNjST3Qxc6wWOYuMkbLMjWS6tY+nC51M560+nlQN2J4u7rX4na4edYLN
         hRW6OYxUpOJWojQHt0efqxDobudPqH/oydITvhcgKHHt2icVId08ZPXhBqH7A+1kV+Ou
         K83Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr2gzYiGRGSZmMTzyZg45xU+uyLDrWGgZSqep715ACxRoU0yPoYvBRMeoH+BcoA6Poan4X1mggFvAS2C1AHIR3Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyUya8hzI6DeznHx0f5XeUrcnMNruwwF8Tv6oAerk0TVhj37i+z
	z0lNIs0N9ylPR2bGSGplgyz67GrFapIyPUwL0+wqRmn0Zqefsf2YuSQUYe9wMo26YCjL4os0nTm
	gKKZjsxI8XQ==
X-Received: from dlbur22-n1.prod.google.com ([2002:a05:7022:ea56:10b0:13b:9778:570])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:498b:b0:38e:7268:220d
 with SMTP id 98e67ed59e1d1-3903c628176mr38042175a91.20.1786259704814; Sun, 09
 Aug 2026 00:15:04 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:40 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-2-irogers@google.com>
Subject: [PATCH v3 01/15] perf script: Fix metric_evlist leak in script_find_metrics
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in script_find_metrics() where metric_evlist is leaked
when returning early on error paths.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 3622990efaab ("perf script: Change metric format to use json metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f91d8b1fbd01..ad8ca08ceb5f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2276,8 +2276,8 @@ static int script_find_metrics(const struct pmu_metric *pm,
 	}
 	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
 		 pm->metric_name);
-	evlist__put(metric_evlist);
 out:
+	evlist__put(metric_evlist);
 	return 0;
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

