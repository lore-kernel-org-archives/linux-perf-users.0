Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638634CFCB
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833890; cv=none; b=o0tzzauE6k5S73Rif2BGLveuvfFIQlWNQEs9CHSyUCz/HvvKBYIZNbrT4/eJFkhW2ahJ9UaoQBWNsra31wgvzexPEAbMRWI2QLPwUI0mYn2e25oodrMyLFdtT19MY1id+E/xdGz4LJKP5dz0UPE0fExnm0JPD3wBNYwu8dqGUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833890; c=relaxed/simple;
	bh=QjO8gSjusfZ0mPendJr0+QHEFToVhbHiU4PqR4DkANY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jWPDvYYqsY21+PjfO6jTmKMOZhNfTliTNCeoG0k5xcjcpwPVwheWkbm2XkRmAJ0aATmGGwvyshf6Ei4H0hcpejnw1iFsFlgp18jQ7HoRCn7fyPlTUN81+cgSIg++u6DX+be6FXmjwk9l77JLoPT8Vp1UmRd9cXZmkQGz6a4qOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMcx3RBm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMcx3RBm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297f3710070so70937715ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833888; x=1763438688; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=pMcx3RBmxGyfJ/3RiYYYLiJT8SzYYWyA7VRce7MTus/vfpdebkBR8w5vTOWeFdkEEL
         XeZsfEZpTauXhVBuCxNr7pwMo//fDgjHZ7zAJJfmx6gGrkYDb7BeAH3Il8YxwRLwSild
         3F4odrOywosmQlNH3IENXyx3wYen/ir8DfnNZE1/bNXAmL6+aCkulBRBRylwyaw57YEB
         Zc+SJdezoNsDwtEa6s/rvbMhiViDntVLg1arY57jhJkLgNArvImSnhmIMpJf13VhMqlt
         CHzg9sbx5ggk/s22/XVXMQyjkXL9pgoEeClh8D9hAIzMPWuZCu3T1JyAlo4U2D3eCv7N
         t3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833888; x=1763438688;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=eVeJ+5wclHJGPlV5jhLAnf2hBgedHvL2b282Mz0+QSMD3MiX5rcpP9wIjAPY5i2IEA
         PLgkhLAUJS6+hXMJjqICxGcIMi2aVBDu4VgsHQ0KqKd/bNJsYj82CGZ8qCl8B/c9bJ5s
         Q42Ii84URshXiCgXG/Ns3K81Iu5fcdAB4JAZdyQ8KxZW5kCGhrlM62APXxjY+SUkJ/vP
         VaPV/KpNa6jTCXRPyZuVnXcZp3j44sK7IBpnMMm7ieaoOHSlmj6mpMDTmjaizUdyFjaV
         mmxHZigOF4el3WJ+colpCCBJ8/pttdyzLQjcRNogZKDQ3fVnBXmOsVip9dTEYuKD28up
         2yKA==
X-Forwarded-Encrypted: i=1; AJvYcCVHYVDwjPwJ3tlQqsKszwlECCc9BhnfsiFdlt0jfIRWUG6VtzLeB6YQvQ/znvc+AG19mMQt28hJIbqBX04tY8Y3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1E9KRfJEV5o3S16GnJdjqTCOmzgjdMyCDTPsXBOdXGPTB82i+
	/qiq+Ruwp0aQNKJdssgZR3R14ggpVdITnc6eFxQ3Y1PKON78kBmLPP8nqW/lvnOpxwHmdZmCptt
	Ffu89a9++oA==
X-Google-Smtp-Source: AGHT+IHnQHwE7ZVnLqbv4sMxN6fuUu9/VHBggmkrVxMIdeFVE3Yq6GszmnnFYMuvX5r+GV9wJ+cLh3U9USGv
X-Received: from dycoh8.prod.google.com ([2002:a05:7301:da08:b0:2a4:6ae0:3502])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e947:b0:295:543a:f7e3
 with SMTP id d9443c01a7336-297e564cc94mr135808275ad.27.1762833888290; Mon, 10
 Nov 2025 20:04:48 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:11 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-13-irogers@google.com>
Subject: [PATCH v3 12/18] perf test stat: Ignore failures in Default[234] metricgroups
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

