Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6F3EC687
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541583; cv=none; b=YEmaQjbsFLdDTBqQGcltaDKiZXE3SaZrdV/05QnnPJK8Y0hZdcXKQzBkCgCegWnZHCpAlpkbKSh35kj7ieqyOzHLtVgi0VE16U0oXv+/8L/F2GGOzU1m81woEfI+mN/vDljKUvKlWuQj0OZ8435FRbeYkCd2ZOUK/9ZinKMO4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541583; c=relaxed/simple;
	bh=nVrDjAaLjz/G0gXgjT4ygxlgmvIatuz8zfzY1CnsCg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kY34nsboUFPiOPnJ1MOti64AdADdSGHzFHr4G2wrktUDbORw4oY7HYlX4y3jI4QN7IM62EhYJ5zVxjFJ+jjD2HYITXF9Jaq+7R8GJwW5PbC41vUx5N0roPlchxJOPwDuora/pQSOvvKd0+N+cGUwCIIDB0ncCE3PRzV1LVkMcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WqHqDMxe; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WqHqDMxe"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd8920c132so15364585ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789541582; x=1790146382; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gyb7wILWN2ttrIjNBf5YgT+03fCZnF3+pV/Z9u6pTzc=;
        b=WqHqDMxeHBxz1VsQFUCp1QSKeMRIB3ul4ZKaX5+l5/gzWJTlcuG/W9AkDyKOKShN/t
         JAXlJV6kx9XjtEeR5dGh+FkaOMgLtN9sRgUB1ibkLXrzk/96l3HnvVvODvml5dUrPTLs
         RoR2b4VIyLDZdffsAvHZ7MIb3GZspgNKgjdEvnfFDaVXGbXZc0TlX3KoJQNH9vhwNzIT
         2fSwBdl7WUDMJqk/e95lMqZ4WFdr7F2cjxBdmc1qhZPQ1EBRYd/Z2GNK0YIom+oa6tLC
         XADtGePm+Zm7v+rdXuQR/A9ItisJ9mgqxMRmvMCgcOJz7m1SWU7xbqvoIIY9efmkyZTx
         AkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541582; x=1790146382;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gyb7wILWN2ttrIjNBf5YgT+03fCZnF3+pV/Z9u6pTzc=;
        b=I/UyuP4c8uWS1Qoq7bvsI8CBOXgSWgNMTPWm5kcfxasnRcam1Y5bBRYzT4QXBMR0p0
         owXnBYqHtz6/FcKZ0+w8nhIBEMC8ogdHQe2H8rnOUESYErr6hI/HwxXnhI/aLYf4lqQX
         U9ELTl1W/ogIeAR7ie4BZUIGvgUgxrbyDCcE80CKm+rUYEeyoWyNNHlB76VvbWVDC0DC
         M8cXz8arwIfGEjG7RHGvl3kKOFbHGuMK1V5uHE28BeUt088XitU8iHZ1G31sgd16F6B9
         CUrynrb5JODJzM0DJ/RxCV5SmRqNQinK5PFX2kM7sz6Y0fE9WOrrnIkV2Jv3+1AnLQ2a
         EbcA==
X-Gm-Message-State: AFuF++k9v4HpWkRMRE7is6tmIeOtaOD5NUdW0P/1AFU5AukXQzfpdmO1
	cbuCx3Lt7MZNvhmUYCyKth46U9OUptuyUcpLgw2k2sHIFvIDrDPKm/rb72LEzlGV3SeATKep7XN
	rVbjahUVPIg==
X-Received: from dybtt4.prod.google.com ([2002:a05:7300:f404:b0:339:7bd3:e896])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1990:b0:2d9:b60d:7755
 with SMTP id d9443c01a7336-2dd8dbf0507mr30934165ad.1.1789541581583; Tue, 15
 Sep 2026 23:53:01 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:52:43 -0700
In-Reply-To: <20260916065248.3153556-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916065248.3153556-5-irogers@google.com>
Subject: [PATCH v2 4/9] perf Documentation: Add tip for hybrid event merging
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add informative text outlining the IPC imbalances associated with
merging cross-hybrid core events like cycles.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Documentation/tips.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index ebf12a8c5db5..1c7b309fe6e8 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -66,3 +66,4 @@ For latency profiling, try: perf record/report --latency
 For parallelism histogram, try: perf report --hierarchy --sort latency,parallelism,comm,symbol
 To analyze particular parallelism levels, try: perf report --latency --parallelism=32-64
 To see how parallelism changes over time, try: perf report -F time,latency,parallelism --time-quantum=1s
+When merging events like cycles, different core frequencies and instructions per cycle mean the counts may not fairly reflect time spent in a function.
-- 
2.55.0.1032.g73a4cd73de-goog

