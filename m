Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CD1287510
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278145; cv=none; b=HyRRYlpsCyqIblCszeUAcf+jR0AKx45y8WGMewWLm6rldEU4fQpnMMZyms4Xc7wVlKHTPLWAXTv0ILqupmKCOaioC/Q98otH2pIgf1pPahCVQMqO4cC/L0uaVzGfjsGVDpvnjFNB6FMUE4Iu8NYOZXCs4n9HtVQHH95s5N9K9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278145; c=relaxed/simple;
	bh=y3JLNXMU3meVqL6DTdtNooDpurlcG/1zki6N0tqiEcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OXYr/hUKTjU8f1FlZtI5r5ekmu9IkCBukz2+5XNher+ic1b4N03v5baSYYwcIKTjNgaBKpRuib1RYReXNdRxxB3VljlepE4AhE0/AqdRB8jwju2spbGfKScuwX1Dz/G7FXLIpPOEdgo6KiVhZpt1KYlUsukzLqcIhWlEYf0XHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAP+Qhcy; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAP+Qhcy"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30bcbb34e57so793467eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278142; x=1782882942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwPeC9H/gK5/B8TWrIGq0FGEcFZbozfElkWt4zX0Gwo=;
        b=eAP+QhcyYsz6diuGRYmVeuCMGjRzFUCqTDwSPlskTLk9E4SvxeQqxppmItEfiMhNCO
         DR/UK0k3Khi/5VxydMIdf9CmA0+TJ2lnAyNF4Ay6MMFnp4ezI2clhdoDiTU5zW70VdP6
         mjfVyY2eHvYmnBYhEi6bHhE5uG3jRWbjlZSn3UXB5dfl6GBOIXO9QaVAYkkokr/93rCN
         uFcuMEPTFmsdxNq9zti774qnqDDXvSH/u/fd5cOTu4Fsz0FRnfZiWwKldAyHRGrMiOrx
         DEfJvT3af2dk+vggHCX/k89PrdD6FcYeOOL++g9B6ipKKwParAM4RchdrWYP+ZmJa4HX
         w6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278142; x=1782882942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwPeC9H/gK5/B8TWrIGq0FGEcFZbozfElkWt4zX0Gwo=;
        b=SlViHdWzi9dt5hVq5MxXKQwGvUxYKJaN1U2Sbq/RFsyU9NHEy51JY74rqL0s23r7hZ
         UTLWh5cRC1g8jQd1hUlPcvEaCOWfHkxQ0ou3puuvqCp9bCAf9WE+UKSIhvS0bTlW0muG
         FhGY6GE2T4zW12EB2SnPGgaZ39ZNrXePin1OVRwL+ONTCxggkVnWbgwfxJADZgwI7M3n
         YylszZaVvY7WJJ9nJN+9P0zVQX9Tx0sifzw+3TSCtfE/AWHf+wgceTUQ9PmDLjF4Azcj
         89EsNFQjy/3FLz4BwoQBGXLimiUa0eyt7skOcpLbzMix5L3E483khGvlqGahVy8gE3c0
         SAbA==
X-Forwarded-Encrypted: i=1; AFNElJ96BR1z6MIDSXczF3j0cvvofs2ubjSiCzRG6ObkAvByLIcrC+3nyMhqmaWLVtNVyOtj1boAYPs7x+3Y3I/gr4d/@vger.kernel.org
X-Gm-Message-State: AOJu0YxtG9IUnugoe1DehAjpxOXTx6/ZnwGjeuyA2b3DFcqMYVYjmFII
	5YmLOcFV6HbyvDzQHqfTU3TzI0zxW9q1kPPFQqXod4KHS9oPdH4uEgOtqk/YcIZYODRFN/eV2bc
	vnEQp09KjiQ==
X-Received: from dlbsi14.prod.google.com ([2002:a05:7022:b88e:b0:136:23d8:d537])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:439a:b0:139:ceca:20c5
 with SMTP id a92af1059eb24-139d0c68c7cmr1441537c88.19.1782278142068; Tue, 23
 Jun 2026 22:15:42 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:18 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-2-irogers@google.com>
Subject: [PATCH v2 01/16] perf script: Fix metric_evlist leak in script_find_metrics
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
index 47afd8cdc2b7..6b69e982ba62 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2275,8 +2275,8 @@ static int script_find_metrics(const struct pmu_metric *pm,
 	}
 	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
 		 pm->metric_name);
-	evlist__put(metric_evlist);
 out:
+	evlist__put(metric_evlist);
 	return 0;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

