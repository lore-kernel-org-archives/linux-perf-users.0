Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC71382F1C
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621655; cv=none; b=Dc3FHgiRAvKN7Rkd+qiP+eDzn2UfaFo8jHCPAg7RXFq7CzuQ1xGz+rDzerv3etIwoTpJUhQCpaxpfsuKhJ52f/4IEZU3XdqYa3DeGYJQT0onRjiY+oAVqWTuUPjF1TdWhmGAVThQihrmaQMK+SCvUlv+wanNX94JtgJI52n3jnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621655; c=relaxed/simple;
	bh=UZ55NGTcp97BQR+TmJuMr0u/pEczhXj6Is+NLhu2rm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YOXPm0OBT0MIztFPC/6tMgD+kaDGSSplluC6aLu/uEwBiQaxL8ESgdgZIGqzR0HCdSUayUxrmjL1vG8ToEzH9r2VTAYR83iTCUvbs5L6YjjXq9GpkuATFN8Oz6NUnK/ZFouwMAmKM4ZnrFFluSn9Ud+UnL1CxuxCI2nqjRGeaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QEtyMSlF; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEtyMSlF"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso869548a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621653; x=1790226453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jy7sHSnm0H1+CuaVoqaaQjFfYmAbppjdfLuWkEu0T4E=;
        b=QEtyMSlF2evnGYozbZSjjFuTb+AQvh1jbKQOu6B5wEfmszPfSTd3aT59GT0DaR305z
         0H8ezI7CxRkRuMVSdJsiZ/mHwHSiHpAcZby6Ath0FYpD/UhQ47/nQ9kSZJKkxlc6aXhf
         kdiATvaKZxyGO6sQLhtwbMyQpHrnjI/oc6U/32ur1KScw2OGUyR12I4/Jofi5sD0c/Nc
         K9bcssyULp+cLnQ20F2W1G5yIV/Iavny8aDVN8RmnBvuxhq6Jh3ycw/5nQfBkV8ExpHh
         8KVpLghU9Mj+1WZvpEEJtcW6bmRx8cIUcSb8/nrtxNdsvzZtk5haq/9IpXqccD+lb1HW
         xOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621653; x=1790226453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jy7sHSnm0H1+CuaVoqaaQjFfYmAbppjdfLuWkEu0T4E=;
        b=YMQO4ocmXzb+L3rlK6kYyJbIYL0mg0WP6YhiOLchnrwgLOV0Oqk3T4I0ICIKwUgwb9
         Q2ejneM2keoSkTb0s1tAIldmC0wBtamK+s9uWjJC/VfUVVoUt7hmZZI35HS71gQwIY3+
         sJwuKSDbPd07cOKnIlAdhV7dU4JmfVfMZ7r0A8yTemQrj0aKob7MYincrHaxa9Wn7VOf
         U+eNEl9fm2vo2DdFLwFsoD9CYw8WdW+yQDXAWCuPMJg75vT59BGFV9on2DXt/bOeAGea
         LNbm3J+qRS026VDuRsJU0xTJWKJeg5inJaWVjfwtUPZ+Rg1UjmKYFrF3odArKN4QQwr+
         1+yg==
X-Forwarded-Encrypted: i=1; AKwUvBwRQrIBqmJ/aPE319yMKrs+XJ9tdeJM6Um5KMJM78WBxmx6a0v1owJwk/wVoKByeF/IGkq/GFxhGhW3Kg7IhQVw@vger.kernel.org
X-Gm-Message-State: AFuF++k81W1ajjRfgrzWYS0NPEv3lmNW1zAn2S7yvVtYgKBrpiZMZe8d
	kRblGLZ6jHT9wpARK+UpNMfCcysOJNIVLJBQ58XdAE6hw06sF0oKsy1yTa2h1D+pwpi03Ol6WYG
	gHkxJv2Izew==
X-Received: from dyjo21.prod.google.com ([2002:a05:7300:3395:b0:335:175:7bd3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:517:b0:3c3:bbe6:95c7
 with SMTP id adf61e73a8af0-3dd5f735107mr13275931637.17.1789621653255; Wed, 16
 Sep 2026 22:07:33 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:07:03 -0700
In-Reply-To: <20260917050708.704702-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050708.704702-5-irogers@google.com>
Subject: [PATCH v4 4/9] perf Documentation: Add tip for hybrid event merging
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
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
2.55.0.1082.g2b9226bbc0-goog

