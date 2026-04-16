Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735F349B02
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372515; cv=none; b=t0by7bXyZGyDWiWm4alae7iS721BNs0q/YyEp+hO8rDvo6qM0ncATxIjXgZW0MDp6TydXJRlCdZJ5edNTD+1SB3WO+r72+/jPhZ+UGlm9SK5aSPq1LQ/Y3CHA5lRYfrotUNYaZtgSsj+qqyIqhrCNIltXkGWLC5T8K4fhSMaHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372515; c=relaxed/simple;
	bh=gC1e89DcdJuNFWigfaSaY3MfQiaB022L2RxBjK0J4V8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M9uoa32aiJbv2WcM6gbEmAu1TMcMnEaYA/pGZlcYm/0EsxzuglpzrhtydIE5/2iQsbfHkLA1aacsbSd0i9kuV7fqgdeb3s+wXI1crkRVoMEFjhsiktgTcjmloYUW1TdJ4I5mKa5GKtfO8DJn2BFJw6N4KQUNZkTp8/snvWiGHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhd6VfZn; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhd6VfZn"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so10905017eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776372512; x=1776977312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cRU+fJAYd/Ongu6hlAuERb26GvGNy31FbgwyiN6kgf4=;
        b=rhd6VfZnQ5F6BeFiORQSKxlFmFtKBRaTjIKbK7abq0QD2qmcoyl4NIkNobHkGq5bkw
         FvrO1WVOjxSNAtpc/tE7QKqpJPCtScRmNsPwzyO26+g6Nn6iSDlhEK/4UELwF4FxV09Z
         EHXDEfc/M4pkgEx/hxwuUjaUAB8vIqQ8SGzOxVp0JPNWUIEgBI1jydFVNAuV0RqNwIj0
         GEn7vOED54/NDaQqjLw+b4LvHnJS99DjCDgQvdr4hCvL76dZbBBRwhC8tdO6EKQSJFpl
         X+7dX5YlRbHtb88PMFpSuRz0gktCdq65uLuIHMu7lbyyMwTKZkUoP98eOJ97pGE/gR1x
         zxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776372512; x=1776977312;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRU+fJAYd/Ongu6hlAuERb26GvGNy31FbgwyiN6kgf4=;
        b=QPQVUJsCRMdNoBpl7mSVhfexKBQXvCKQDmWueIzHiNCV0f02T/jbtiCPxaTIzKTJVj
         s6toMsI7BkGy4Ws4gTTOAo6d9arVXUHB3WyfuwZfeOQ2veNPnEag6a2yPJ/OLhmIywg0
         Dy7SSde096MdfID8fq+OY/zl2LweTJFg8Tur1/rrSBGEYKu87AoYlYpILql7KZmA9KJn
         xtrXJOzPNnRbLr2EzPlwZXtz+LPAmPUZIQrKRT25yWduCt9ht1AS6UjhW9jsO1EpLmxM
         JTnpKPj1Vp8iRpvDGaa9tNyS6/00JL5yJcHnnt2De9hu6V8ihUte2Ugm/UzDp7skFnMI
         IEEg==
X-Forwarded-Encrypted: i=1; AFNElJ+LNrEf5U5vHIZzLn1H9jTynPqG2jbVdRbHvEdjG42zeyr/yQTxift6bIl2Qt04SLUY2bKBNELM3kA1mikxfvrA@vger.kernel.org
X-Gm-Message-State: AOJu0YzIAFyTwcYs1PKjyoU7kr4prpSUs1kAPQ39y288m9svr86Qq1WS
	3YgO9xYY453+xl2nvLCwosSFkkWsJXvgpzHZ0GiEloi0H8BI0zhPsrATlOu13xf14/E8o0QpvXU
	zjOdKvA==
X-Received: from dlbpu1.prod.google.com ([2002:a05:7022:e881:b0:12c:4955:b382])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4389:b0:128:c77a:6c8e
 with SMTP id a92af1059eb24-12c7285f074mr366497c88.28.1776372512280; Thu, 16
 Apr 2026 13:48:32 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:48:04 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260416204828.1303734-1-ctshao@google.com>
Subject: [PATCH] perf stat: Merge CPU maps when merging uncore aliases
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sockets with event zero counts are hidden in `perf stat --per-socket`
because alias merging aggregates counts but not CPU maps. This causes
the display logic to incorrectly skip sockets not present in the leader
instance's map.

For example, with AMD_UMC:
  $ cat /sys/bus/event_source/devices/amd_umc*/cpumask
  0
  ...
  128
  ...

  $ perf stat -e amd_umc/config=0xff/ --per-socket -a -- sleep 1

   Performance counter stats for 'system wide':

  S0       12                  0      amd_umc/config=0xff/

         1.000777829 seconds time elapsed

Merge CPU maps in `evsel__merge_aggr_counters` to ensure the aggregated
event correctly reflects all underlying PMU instances.

After fix:
  $ perf stat -e amd_umc/config=0xff/ --per-socket -a -- sleep 1

   Performance counter stats for 'system wide':

  S0       12                  0      amd_umc/config=0xff/
  S1       12                  0      amd_umc/config=0xff/

         1.000666681 seconds time elapsed

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/stat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 14d169e22e8f..d696d217f98d 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -535,6 +535,12 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
 		aggr_counts_a->run += aggr_counts_b->run;
 	}
 
+	/*
+	 * Merge the CPU maps so that the display logic (e.g. should_skip_zero_counter)
+	 * knows this merged event covers all CPUs from both aliases.
+	 */
+	perf_cpu_map__merge(&evsel->core.cpus, alias->core.cpus);
+
 	return 0;
 }
 
-- 
2.54.0.rc1.555.g9c883467ad-goog

