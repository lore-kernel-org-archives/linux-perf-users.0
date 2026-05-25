Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3C3655E4
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751165; cv=none; b=W0brbFSB4/dNANnamjpnOP/u7jeWfXTgmMMhJDNx59ew69s7wGjVUgu94NoU/Vtnmrr4b58eA543bjml4GNsouSfXEPWkpmfGkcZ0uW97ayZrOq7nlYgfKGL1rJF5CjjjyzFsKrzpbUAFVUBTqypXHlm0easPTp2Bs3e3cIWJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751165; c=relaxed/simple;
	bh=cURiuYzNr2CBqT8pygcAgfyCBy0HxP7y/rD1ibkTquY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FDxi/CAxVriiN5PqdUDPB2FLdtFEOWyjItlQfyvcPU2SKdUf6O0KzEYO1jmyodFtZvjgw85NcK5KqJiPEMDJZNcLvT/CY9FLhFnr4tMDCN1XOOlvCO+Qa5YnmSRPYLUsCluVg2NrYq/+/pJT+c00J/CfDBl0IpZ/tybEuVcXa1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cej0+ROA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cej0+ROA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f2d983d109so950507eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751163; x=1780355963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xq4ITk+f921panuL8UoNawFY8vlZouj316Z+sTkCPNI=;
        b=cej0+ROAqjH5dP2scsWsk5DFIbPtGft21f3cBmC0kxA5Elvobie/gpJbocrS9ir941
         KOdxK6iPhFgWLhGNpCvlyKqdiLxAcwkv0HQDZqihy2Km9BdfJykI4nrp9ImaYeR0Xyzs
         WyWUFCv97hgsMQxefLHfLslabCIrk7jhKQ20/XyeCNeKIw7QjXHqHQTxvtJnNCV6j+Wf
         XjZAy3vVNr/cBDjaSPMDFab1FQvsQYURfeEvfBWMYIgLXv35l8mzglYjXYnBnG67Ci+K
         DyRCsZse/v1rnLp2MHwYVSGlPpyl69S06rJvdjWg6Tr2H194Bc2GuKs/LdEhlNbWq0tK
         8nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751163; x=1780355963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xq4ITk+f921panuL8UoNawFY8vlZouj316Z+sTkCPNI=;
        b=os8EexQrcIggJnxxJFto9KBFQdZK7KKQkOasqHOlDHZ+Pdt2doeFMaiaYsbJoWNAm+
         df0isYgb2pKDl0noa08ZgMUerhRYyohQnSvXU9cXVk+In5L+nbf0YpPSa4n0s22qqtnQ
         tCDTPSDCHdkG0CWOXd1OAgoYLl6d7xwTjMzmZ5LqtotvfFRDnnbDGf2aww1ow5kFoOyO
         dlPj4KDUq8Ia8aZzXc/+VgEpuVit6qZLANZUNEU7Bi+v8WWfYUWIAp+Co1rNI/Pcg5hc
         3lFKg8n2mC6/ldOy7uo6Ukn/ExNoDphoj1vVrL4Wk50QyNWGc7Yu6K4pK/+yJLvdYL9f
         PYjw==
X-Forwarded-Encrypted: i=1; AFNElJ854XMTGBq2oR0G07InnzyfCeSCpVMe0MZ+Z2fbm/2sf7yjUiwhAQjpRgVZLOVYL7VymbF6PaUqLLOpMC8F5VfD@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiidWcNNTiduTMN2FLxc3/7oIU6z1Mkkn6sVsEuyjcOmJiIrQ
	aIG2lUMtyxWKB9fFhtTF/MzlVfRohH7Q89bgq2qFHWXnklEOoeuLwONKm/JlzDitoCAQfZrE2lY
	E0HPiNbSSAw==
X-Received: from dyblz48.prod.google.com ([2002:a05:7301:1630:b0:304:59b1:e122])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d89:b0:2ed:6f94:9d9f
 with SMTP id 5a478bee46e88-304490514cbmr8224624eec.11.1779751162980; Mon, 25
 May 2026 16:19:22 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:52 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-7-irogers@google.com>
Subject: [RFC PATCH v2 06/14] perf stat: Extend STD output linter to test
 metric-only checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run
the metric-only check under the --new print flag:

  - check_metric_only

This guarantees that standard console metric-only outputs produced by
the decoupled printing callbacks are formally validated by the test linter.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/tests/shell/stat+std_output.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 0d38a1283967..69720b19b908 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -134,6 +134,7 @@ then
 	check_per_cache_instance "STD (New API)" "$perf_cmd"
 	check_per_cluster "STD (New API)" "$perf_cmd"
 fi
+check_metric_only "STD (New API)" "$perf_cmd"
 
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

