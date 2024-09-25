Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903B186289
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273775; cv=none; b=u4Z0QKYWMlvyZ9mABMTncrkjRJBvJRjSZ671utTqWYdt1NtjTh3NjmWJ/QgfbkJj8W0p3QIGdn/gntmjvJOJn+q4WdPsizSpypdYT0Vv21oBTEy+LOEAlrFOp7S1gYxiEkpPVOb4BL0sjB46NIj9P0wy8Y46bQu5pqvwGKzs09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273775; c=relaxed/simple;
	bh=uEkMebtlJ3oS+pP2FKl25/DE83+yiPQjb4Lo5sy18SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRjW+EF8QU1axA7IRlSU8oCQ4JHoy1VXZA2yL3x2Ms8gbd/2hFkbyL4W5Gn86dVVob9up3pXwQPSnUwxVIlNLlJ3fTQuKQeB15srbBl8iAyR/pL4DRrEZihWaofU2pgrRiCcu2n1IqucfJtGZXh1ncMO5fSIhBZivxJbg7EFSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GT+MiHYR; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GT+MiHYR"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-535dc4ec181so6805795e87.3
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727273772; x=1727878572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C2IaRNsHC56vkJV7d2z1hySpqTijtSB8YUkIrjThBQ=;
        b=GT+MiHYRB8wmvV4ff5HPiwArmoKL+2vzruAJHOcF0jx+VpMbxKa2IJj5BeWAwPC/UX
         iiPF1jknSGSa0gCJxIRpq7OBebGC6hwGo9AtPtVG+e4sEwwf7uFSAvCIKlvH05R1eafJ
         dPfIeycXDrrGLXoYtv0umSj2wAVyyg+oFGrw9XtKOkfCQsIBQ3wbgiku06m1q+c8fzth
         IiIts4z0gNMOMtWI3yYCtatb3Qxt7nx4LUxdF/kdk3c3VRqCzMJ7F/RLTY15sqIGBjZS
         +0wSgqV6kQq6/qRZTqDf0q2dcLTXgINwX07yU/qDw33SLQ0FKL3bq65hwArcHu95lF+a
         ZK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273772; x=1727878572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C2IaRNsHC56vkJV7d2z1hySpqTijtSB8YUkIrjThBQ=;
        b=NwnfAXV3sJY4kf+kFRTG3/DWJbRBVxFTCNsQQk3zlNswUImKSViV//Ft6dnLZ472L2
         ApS3UHKNVUKIBhSSNvxouFGO0hfvQ7vD46AxxiEpJcPq7D1VU2UfGdlQTbOSUbfTGzm/
         GmThy56IrmjrSSM12dMfaYh03TwGTpa2JbJc3sHvWVG7ky0BZh2e0Wu7V19EQU8b+/nm
         sRKPh9wOPdpLbrB3e3aRkxoeRxsfIkzJ3pkk8UXQmRpvKr8baIqBekChSk3KzNWLPNGg
         vp+YmX647G35D0cdItpSLZl5gv9Ta8pY6ez3EYKmLe6cYWpvYKLBmft8TR2o7rYVScjI
         rdog==
X-Forwarded-Encrypted: i=1; AJvYcCWlq1AuobaMQp7jpuxzMW0fOmIafMc+tDZ8BWFZ12vvyhWQ2P6SrCVbUR8la+QKJ2AJpUldP2iY35/DOUqF7h72@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/Hcl4lRVbxkIdSuCpIhQzGOKhNEPP8+WrSFiEGs9oFI4rlgM
	GoT3t5vBOwQX4EahUzeH8MShSOT4068LmFPUTZr3C/rqZ9YPuma7nS9PlCvPHew=
X-Google-Smtp-Source: AGHT+IH/AokU8nE5Yj8ombOw44PhKPwV1SxEafUhKBgeHTn5hoNRs+iZV0lhr7F3HawGiH9D28Flpw==
X-Received: by 2002:a05:6512:1395:b0:52e:9b15:1c60 with SMTP id 2adb3069b0e04-5387755cacdmr2000950e87.48.1727273771713;
        Wed, 25 Sep 2024 07:16:11 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4968f4sm1888005a12.27.2024.09.25.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:16:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 6/7] perf test: Make stat test work on DT devices
Date: Wed, 25 Sep 2024 15:13:44 +0100
Message-Id: <20240925141357.1033087-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925141357.1033087-1-james.clark@linaro.org>
References: <20240925141357.1033087-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PMUs aren't listed in /sys/devices/ on DT devices, so change the search
directory to /sys/bus/event_source/devices which works everywhere. Also
add armv8_cortex_* as a known PMU type to search for to make the test
run on more devices.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/stat.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 3f1e67795490..525d0c44fdc6 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -117,16 +117,18 @@ test_cputype() {
 
   # Find a known PMU for cputype.
   pmu=""
-  for i in cpu cpu_atom armv8_pmuv3_0
+  devs="/sys/bus/event_source/devices"
+  for i in $devs/cpu $devs/cpu_atom $devs/armv8_pmuv3_0 $devs/armv8_cortex_*
   do
-    if test -d "/sys/devices/$i"
+    i_base=$(basename "$i")
+    if test -d "$i"
     then
-      pmu="$i"
+      pmu="$i_base"
       break
     fi
-    if perf stat -e "$i/instructions/" true > /dev/null 2>&1
+    if perf stat -e "$i_base/instructions/" true > /dev/null 2>&1
     then
-      pmu="$i"
+      pmu="$i_base"
       break
     fi
   done
-- 
2.34.1

