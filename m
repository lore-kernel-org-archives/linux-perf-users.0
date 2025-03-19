Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065041AF0B4
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384428; cv=none; b=Nu70bodcksJmmg3qOtWgZReth32H9INd66POvCO9U9qJ8HBf7xPfqWqYWIhiCZkw8kBhnQF5S2Z6RdjxvneNdKUeMXRrWV9MVv1CKsVlMsFaI3NqMEBZg82Z4Ca4Fj4HV2ZzuFHwlZ/azb8TxDXYhZ99h/WH0PkkrYheEG88cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384428; c=relaxed/simple;
	bh=Z7OKUwlor6Y9CPPSkGccOzDohs/lbs3P6mrHMhcYAUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vEf17/G/GM7b7hh39s8ZdRafmSkHnmhaPZFO/uE2nouEeb322Os+ra52EDOQXkhGl9L34jJo1u7k/en52aD+AzWQWBSxpo027FmKjOSHQiILSimXMHhH+0LMMPd4Ee4zsoOtE9KP1ijprt6/WUtYchNdXGbPX6jjll1AY6mndOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WT8nvTEn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WT8nvTEn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso31423855e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742384425; x=1742989225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEGmhoMrp6tKSJUS9RACSKaL0Pf/gr6G5NruMelMYn4=;
        b=WT8nvTEnMDF9DrH2snseexcEhWibpZJoIDjVVpVTUG6SkYotLedk41by5WfmF/Q5b3
         immeZAi6epe0b0FJVxEZ7oIwvs6ekaSYFk8oqqfDxVQ2SFEQTUKvlLm4YfVPHaBQMh10
         rR/Bf81mnQjlB46Po0oqmD+hkBPF68XpNaZo16zPMtVlZvpwlkoevsPnRsUH5T2VKgAR
         0v1+ToM4+Zo58iTFULN97AWoLD9P2f3KsN+bc6bI139HHw/Pc4ttsxK/YoeMlIEUnJ2W
         WlLs/iwpAtdNgMbq+bW3xZZSPbkOJW6R4p6BxEHIjBsIF5Lssm0qK0uptQaCNbJGOy1K
         /MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384425; x=1742989225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEGmhoMrp6tKSJUS9RACSKaL0Pf/gr6G5NruMelMYn4=;
        b=AmCLbn8zLnQDcp6RRcephUUJktr8LWp6nMoQicFDuA/mhVrCfhdc1zuChuN7OP6HA6
         +SFZEBnRzhUg9DRHKPF08h5VZsNyRUOQbMGATqYZwMqceAj5HjkSZHHIUtyzfeXFmgei
         9Xkbom8GtDQATHzVQHIn0wQ5uGARI10oN1RpliA9AmvXfBnqfxRcuI5HkM0+3Rb7Ql7Y
         zl/9ceDGLBIvIKpbxWpKAmBFRhKrSDmYahSixAxyEvx3GI0Uw849AP/owElxnxOLBjtW
         BItLG1E1s2135o+p4B4urBB5IUTirQbTHrbLz1/toFhFik4vAu67/+DPq1rgUA2DnQRw
         MXlg==
X-Gm-Message-State: AOJu0Yzmv3GQKSJ2A0n2ACHIcwweTff2uWSfIhomzGs9pHM+eLNJDowm
	weiVs/RtmH2l/ZPIIVdToLUKlnDon/iWsBX5y8+wDZp7fK8U1qy/W0qbr9xxmvGEWyavB4ys0Ym
	Y
X-Gm-Gg: ASbGncs0mgozjFQtpFH+cMquHIcADxO6NR/2ZwtE3zJwHgyWz/omWlz8vtrsN89igQT
	bo8F0Aiu0ELe/sHB012kbqhWWYmyIpXf2UiOK6J4WUqB10QeNb+5yB5f8sCSGpRa6mwzTkU4SLy
	j5PFJG0sIKMdENvs/4FcgcF1R0SWmBk91fWVnk0770XywDk/3JjYo/XCu/xNHqT4fo7TSt0GdXe
	TFCwaTHKppNTd2Z3xemmsJ+qSmPQtoiOIxCb/pftXd/5gBjsr4PE5ZdK2zrIcEJ2mtK/tOqqPfM
	LSgh3wAS1Fo/8hNgPMxSSUvz1Bijeco/IIJjy6TUXe+AGZ4=
X-Google-Smtp-Source: AGHT+IHErJqbLloSDBbOuIMsGZc52pXdp8yVfNacWZgluboER0gYnZa1nw5E4AGXF/1lLUTa3d8FAw==
X-Received: by 2002:a05:600c:358c:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-43d437c1a31mr21789045e9.14.1742384425235;
        Wed, 19 Mar 2025 04:40:25 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f58aa0sm16163745e9.21.2025.03.19.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:40:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libperf: Don't remove -g when EXTRA_CFLAGS are used
Date: Wed, 19 Mar 2025 11:40:09 +0000
Message-Id: <20250319114009.417865-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using EXTRA_CFLAGS, for example "EXTRA_CFLAGS=-DREFCNT_CHECKING=1",
this construct stops setting -g which you'd expect would not be affected
by adding extra flags. Additionally, EXTRA_CFLAGS should be the last
thing to be appended so that it can be used to undo any defaults. And no
condition is required, just += appends to any existing CFLAGS and also
appends or doesn't append EXTRA_CFLAGS if they are or aren't set.

It's not clear why DEBUG=1 is required for -g in Perf when in libperf
it's always on, but I don't think we need to change that behavior now
because someone may be depending on it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/perf/Makefile | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 3a9b2140aa04..478fe57bf8ce 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -54,13 +54,6 @@ endif
 
 TEST_ARGS := $(if $(V),-v)
 
-# Set compile option CFLAGS
-ifdef EXTRA_CFLAGS
-  CFLAGS := $(EXTRA_CFLAGS)
-else
-  CFLAGS := -g -Wall
-endif
-
 INCLUDES = \
 -I$(srctree)/tools/lib/perf/include \
 -I$(srctree)/tools/lib/ \
@@ -70,11 +63,12 @@ INCLUDES = \
 -I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
-override CFLAGS += $(EXTRA_WARNINGS)
-override CFLAGS += -Werror -Wall
+override CFLAGS += -g -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
+override CFLAGS += $(EXTRA_WARNINGS)
+override CFLAGS += $(EXTRA_CFLAGS)
 
 all:
 
-- 
2.34.1

