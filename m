Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987853590CD
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470965; cv=none; b=mZojlqYXxG4VGBgUxpbV+0KjwsSpZjZJ3QaJVCRGe2V+/eSYkAMrmth0WbmWFD/mZXuwFyirWzS47TPYgc2lwiX6WD1c/vcwyQlE/IKqFf9hlsIPRM0PbR/PdFzth+oj9kjxLFM9KyOI9QlQlniDgjTVNQU3fQoTWYjaZVZWoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470965; c=relaxed/simple;
	bh=QjO8gSjusfZ0mPendJr0+QHEFToVhbHiU4PqR4DkANY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rMninbO0Xwm7b1xlM4covB1aY1TUjJ27m8aEVDdE3W/d/IWFf4eopxCPEfN4L3PRYP08Ftqgysf3quhPSw2IwYvt80MQpRCAU+6rv25tyGjYar2rQHIFROAITWotaOiFlygKSYuyGqclFSCp6dNphpEA9p5WSNwqiweXT+xNj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpObOfek; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpObOfek"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so148442a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470962; x=1763075762; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=cpObOfekKgmF/Wr/e2BhDr9Id0SkoWP0yK6vGkdkeuDCC/ijjHbwqvS2hYh9+7xUTD
         iiJ7UKLi01kq3f1V+/DE/pSr26ENrWyC8uOOOHaLT4CTDuQfAOJOj1eDFfcmPKBZBxFo
         5U5GwGwsgkg+qkExfgwd06dWsNvY9hWSuvUC5uCTJvlt3TYNknO2nXNSj5vS2uJAp40Z
         5HWmMGJO06VF6jwJndR9yFhKlXbtc9jvf9DycJCOVv+vLy8hlZnTN2aPvpGbOErzkuGY
         hmOS8E63mFUt9KJ3pyKshJOMUeZuEiGNkweOHX/B4rAbt5PmwEMM3GNiSUsPLYRnD/6s
         tkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470962; x=1763075762;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=aiB6C8YtqFdBWi2wrWwWTVmfZJOYzCvZA7sLeSZHXqot0AtkSe/QV74/sUW4PxLtrU
         StKQtnqWOEUK3g6SzUVyzZKz9cgAlzT9NGRbe/PYSFqPg2RpbA0HoRBQZS44CkbOAdww
         TNdFvATjyD/CQwwj7YPkljcy4LoPKB+6oqgGJ80LdJyjjQqeTvh5g+6DDDNXIbZdZ0a1
         Gg81gHnL/8KDAlB+7km17mVbc1iO8OPeDHTHo9/RLWwJvJt6aGDAmHpFmK2olZVSfLUj
         y3jNmqIkdLuDmO7Jtmf/wNDwqJJ446actkGb+n37u/OA1ADfzFLtWrds17iiYHpXAXR0
         2g+w==
X-Forwarded-Encrypted: i=1; AJvYcCVOG2s2a4QlEORt3+G+9Vk6ORNlDKDmym+SxNrmB8PQ1U3SjmDQNWwcwl3n0ei3wH4Dfc2E0gy6+sXU/ii2h2G6@vger.kernel.org
X-Gm-Message-State: AOJu0YzysQhkPemeJ1/jnsR6Hg1XPqmnl3nSa1JytGSmhKjLmmgeYICT
	Fqu4QG1Ke+/52bVwB+KTjTlATD9EwPMQMp9xK6AZbafU7RS4kMerhSyNl2tQ53v7PEnHeo4f+Pq
	o+RNleuNM8w==
X-Google-Smtp-Source: AGHT+IHGozQui+AGGQhIfFXH2HFvKRA7CZtWpQ/Mv2fL+bTBN/Rcs9YJrd0UGOU3Fx1UbKXIr+g8XrJOLICv
X-Received: from dlbrs16.prod.google.com ([2002:a05:7022:f690:b0:119:49ca:6b95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a85:b0:295:ac70:10c4
 with SMTP id d9443c01a7336-297c04575a6mr15133595ad.47.1762470961751; Thu, 06
 Nov 2025 15:16:01 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:02 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-13-irogers@google.com>
Subject: [PATCH v2 12/18] perf test stat: Ignore failures in Default[234] metricgroups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The Default[234] metric groups may contain unsupported legacy
events. Allow those metric groups to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index c6d61a4ac3e7..1400880ec01f 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -37,6 +37,9 @@ do
       then
         err=2 # Skip
       fi
+    elif [[ "$m" == @(Default2|Default3|Default4) ]]
+    then
+      echo "Ignoring failures in $m that may contain unsupported legacy events"
     else
       echo "Metric group $m failed"
       echo $result
-- 
2.51.2.1041.gc1ab5b90ca-goog

