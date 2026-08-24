Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAED3E835E
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553488; cv=none; b=RLzsMoi+shr0PY1scgwWJEsmoGpOx3Sz/4SOYUeC1gX97lS2Sl4l427NQjlOqQQc5p47sXkUnIxQB7cHbdCji3AxcRgxXQ2O01lUADwLMZkS1YxYJXxdM6vAsWXQiU6D5sNpP1qIJdgcKrYDLU8ah+ZGM9YS/sJOrSeph+Aloo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553488; c=relaxed/simple;
	bh=lcUU8j++xheEU+b3uJFeGeryES1A9CBHLRNqN5xMFJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YCazNs7FFBrTNmh5hi70DG77BcwXDIfm4hcM6lqjUoXP5RYoim5MgzPznGD8Onva8cOZvbtsD2IoBinSmx0OIsPY7uxJJyCa8iB4UwtPbJOOgyWMCbrqBnGfDE0DpTfXZTQSsplXK13ig0CYnKMrgC224YAaTGDZD0E2ZjSg8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkA2fSBi; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkA2fSBi"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8487eb67173so5417979b3a.2
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787553485; x=1788158285; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUIALRKhjOq8AGTZpbN8uosaNamJqgU3akqKxe4flaQ=;
        b=JkA2fSBiyu93nA1g24K5nGK7PSxjjztZMnJ0SIRIdf+GUrl5GlvMaGvNhuVOw8dbUM
         8dCZTaFDiBNMOhQMKvHa1DT8JVFbptKSihdLiHGrqjjavQI64qrmpwdLsEHPtxe0CNuY
         NdgPCHAQqt/XkyWb8Rp2aSCOq3awhFPvNy/wF2wAFMypVg/bZaweWs6ZlSyZx2CcVWyC
         PJARlm9vxcY2OQd8q18LnkltrBeMc2xFXVseKjN1JXa7a9AObVhWItFa3xhJzmUwzvUN
         qlBDh1mPHbew7HgyVRf5xeKM0FBk959QGwJ1YB5G3TaHsPi0nu6WYlaROtej6WftZoG1
         yrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787553485; x=1788158285;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sUIALRKhjOq8AGTZpbN8uosaNamJqgU3akqKxe4flaQ=;
        b=hmEMnPXqcl5rikT2D03UFZlKTKIWbsVkDV+N82N435veCC2AP5IRHrvv1yGaXwZCW1
         zyBq5mqAjg6QSX09uDCTCBdDL2CB4V5lcxbxa5H6PDilYSWG84qtW96zvaNW09biKesM
         +tzYblPmDhkkf1IrRb2eCthbFrQpkxnhOZml1zYdDG8tKWRb7CdwALF+7jotUilvhweB
         Tk3y8zi9xmkxjPeCGzn5esZBbqBpcF5ECLLqU/ulZeuX+9X4DZpWVw3MipEFU1weM5fT
         mLOKUzyLwLb0hm3SwPWoh1ugfDkbwReNhY8qC4coWwpulid12sFArfW3QEMMr9vhXf8j
         d4bQ==
X-Forwarded-Encrypted: i=1; AHgh+RpND9OgTd06S6RLv27wOPaDQkiAAIMHc0/hPzlai8bnuL7lxGHYX84X2yjkVCCQnHejIPgyjip8ga4oT+mlLXoQ@vger.kernel.org
X-Gm-Message-State: AFuF++lXp6j/HHKLFHbCX7DZURd9YsC/3KCURwf1/NRpKN8WQUDQ4V/T
	WDxJ8LgT/zFBZ+WicPfvNnDnybY45noKl9YoyDdhTHAZHzwDOMXT4kWvMQcMqA8h60/ONXucWH6
	fgAZjWVlvXg==
X-Received: from pfbjc42.prod.google.com ([2002:a05:6a00:6caa:b0:849:636f:386f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c81:b0:84f:dfa8:57c5
 with SMTP id d2e1a72fcca58-851fa02cbf2mr31244299b3a.13.1787553485300; Sun, 23
 Aug 2026 23:38:05 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:37:42 -0700
In-Reply-To: <20260824063744.1533837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <20260824063744.1533837-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824063744.1533837-6-irogers@google.com>
Subject: [PATCH v1 5/7] perf Documentation: Add tip for hybrid event merging
From: Ian Rogers <irogers@google.com>
To: andi@firstfloor.org
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Ian Rogers <irogers@google.com>
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
2.55.0.766.g2966f0265a-goog

