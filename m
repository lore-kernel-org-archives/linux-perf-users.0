Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B35381B1;
	Mon, 27 May 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800796; cv=none; b=irnBaiK0t1vRBZfimDyQGn0O8yk4TIBZx7RKnE7lLFwPQRqjhD340oAUtaypGCpf2wdb176F10n90CaUpZwrmI5V/g5aYZkdFSHj6egi0vGdrdNOJJKS4KQUEhClNJmdvmAFnuhu3FVBRTjQuBe09F4rIyJ4wrLxHcvpdjCZw/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800796; c=relaxed/simple;
	bh=OHIc8Ffq07juFkiENaunSuJKcoUQgeMoq50TSLzTm8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p3X7wNnip+LI6pSvbt6gHHIEKy2MYzLiXsa+KSdl/XroBm5pIwAHfumH2moPVQt3ObvECi4KYzdjQxYkdKr+8waAsrqAalKvxyeqJ1EYwxNbKGfom55Ed0am7GfjVrdv1IEcDMaljH0i9zzFKh0h3rUcmePiEr68obuAoFf/73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOZBZKgn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOZBZKgn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f47f0d8ec9so9978745ad.3;
        Mon, 27 May 2024 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716800795; x=1717405595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5B4XuA7MIFJlATcHdcEeTF7o57u/Xxtg6G9/HDaxU04=;
        b=kOZBZKgnDwOOcq+26uDXcdRvcLkYJeEUP/mg+otbhMFf6T31XA68YJx+0MXrHGFlEx
         o+J1+y317EhkW3+GS/3d4DvF6R1BttdNn/77t/1qfkHontvVf6HRnKnGdnsLPcTct634
         T8JF3yxkFMqn2/h9U9ZiOOy+D4C2B34JYYeto3BSrdrJbeJ8qphA8i58JXO5L9yIBLYP
         IWTP3KQkzmrustlFrZm4QeSuhLmVhyFLCBXZmQqshD0N3jJvg/GkhC5OKJtAMnfYeNwi
         O1MeQ95emWTBwnOWZiRJSNNTXkg2Zk2yv36w7ruLTaF9R85hX8FmwVTnoKv++K1s4M6M
         v5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716800795; x=1717405595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B4XuA7MIFJlATcHdcEeTF7o57u/Xxtg6G9/HDaxU04=;
        b=aRMAE0sQhJrthO7KY+EZKbIQhdjbAY//h8y5oigsJEmZsMcI9VogFPJUidkM25Gtjh
         cEQA+wUIqxvVaJsNJgDwWIyLk+2D3zobBvkfUxInWQBKN0lvfN9tRDiy0xb1KnkLhzbr
         CTUK/dBvhwuoYqrKptQkte3LukJOPT4mx0izIl3+ZrZ2ObUhUHL52DtRCMjB4klgL91r
         Z4KuKGY+BORqWxgizpmlQtKKoO4c80Hug/GxizZmAgHNBu5K8+RU0g7oItwop6Ox3U9y
         gpb3Zu0DNWsdJk64hFyt+xk46DlXgxhgvBRVTinE8gQIqXchycq4kTjvXD8qk3syg7IR
         7A+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWT527mo/6bJCM4znyHYx3SUWI39Z7i7bstc6vJWPH5W0ZZ4ca7djFPySGOu4QL2KlbRJWWvWoqoxCFhhTCoPo96NhycMNvLk9+nf03vuTYpPbplMpjvRes0gmEOqPTSUEVRnh3DOI6c0cqzqzLtQ==
X-Gm-Message-State: AOJu0Yx137YgUjjiMIGdpMuJkbdyDA/QqzHqtmTplUybJ2MeZ/Ecj/Vw
	ME27ZMP66NfLQfHxcIKuhPGwjVpfhNtgd9uowX2eEabPMkLlp1ev
X-Google-Smtp-Source: AGHT+IEscR/I+d4dmaF4RDBfL657EXQrLII3qNOolj0Kf/7OJnxFjWoXDlUd+lx/kaBSCSw2JR/CCg==
X-Received: by 2002:a17:902:f552:b0:1f4:7da1:e611 with SMTP id d9443c01a7336-1f47da1e7bfmr37088745ad.34.1716800794809;
        Mon, 27 May 2024 02:06:34 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7d0e2csm56152315ad.114.2024.05.27.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:06:34 -0700 (PDT)
From: yskelg@gmail.com
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Gautham Shenoy <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	skhan@linuxfoundation.org,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] perf stat: allocation check when calculating cache instance ID
Date: Mon, 27 May 2024 18:03:02 +0900
Message-Id: <20240527090300.17864-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

Adds an allocation check for cpu_map before perf_cpu_map__min() accessing

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/perf/builtin-stat.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 35f79b48e8dc..1f238824abb2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1291,20 +1291,22 @@ static struct option stat_options[] = {
  */
 static int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
 {
-	int id;
+	int id = cpu.cpu;
 	struct perf_cpu_map *cpu_map = perf_cpu_map__new(map);
 
-	/*
-	 * If the map contains no CPU, consider the current CPU to
-	 * be the first online CPU in the cache domain else use the
-	 * first online CPU of the cache domain as the ID.
-	 */
-	id = perf_cpu_map__min(cpu_map).cpu;
-	if (id == -1)
-		id = cpu.cpu;
+	if (cpu_map) {
+		/*
+		 * If the map contains no CPU, consider the current CPU to
+		 * be the first online CPU in the cache domain else use the
+		 * first online CPU of the cache domain as the ID.
+		 */
+		id = perf_cpu_map__min(cpu_map).cpu;
+		if (id == -1)
+			id = cpu.cpu;
 
-	/* Free the perf_cpu_map used to find the cache ID */
-	perf_cpu_map__put(cpu_map);
+		/* Free the perf_cpu_map used to find the cache ID */
+		perf_cpu_map__put(cpu_map);
+	}
 
 	return id;
 }
-- 
2.34.1

