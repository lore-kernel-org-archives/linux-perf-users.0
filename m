Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637367;
	b=kiEI9O9gH6lI+yq5v4Dwv3N1EWz1LCMp/AU7jN03YghNzVrf1cAhoDdekE53rGeHUaoU
	 kotdvJxzwAJdXYEBlxa28Jqqbc6wFSg24bnnvhYsiIq8eBnngqUcFmnSXR0DhBVdvl/QI
	 PuSzUcjzgGovtaX450Lhr9V0nk6RaX+uWIqkjgRwFoBNeoKqqox6mgfFqTZIyR544HS4g
	 Z6KirTDoW990+FcfhwCGdD2IhrzX6BdKS5FPDUWUjpws9QGmZYGzIrDJoSpf0uSOkNhQ+
	 IsSAX7a8g09Jqp2qk+q90koY6AJL2uBoiEW6W19I1QFq1mtU/Y4g2zhipYYwrrfKSxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=y7r/tZyNOIYSpuH87ucbpXiJxUIn8Iiqk7+xaK64n88=;
	b=mPEWAm3u5cTywyc3cgJvMJY40VUzERZm2/GJDwfY4QR91O1DzTyw1G97Dia29L/s80bJ
	 FLoYL3W5UznBycw64t2P3BCzgRqrMlgrhR6JFjyuoLvk/RwDSPl3byhlv5I14LyQNMwCh
	 KHnrmLZn+B4qUkNsviwFk7hjsvHbenVKDanlfnbqLeWTQjGxAgKeRNIUDszaFjtpVZGPO
	 LjDlI6Vgp/cILkS7tItJ3SxHybyDUSfBcVv0YWTdivQIZOJH05NDfdk/aaEA6Kbsf5SAN
	 MCwS5L6QDgH6nypHksoptKMd+RTuVYt3PBZ+yBIPEwrFQrdueGh6m5cl/gHG1IaULVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gew42mTT;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD582606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD582606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gew42mTT
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-181516de561so158899c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 19:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637366; x=1793242166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y7r/tZyNOIYSpuH87ucbpXiJxUIn8Iiqk7+xaK64n88=;
        b=gew42mTT/uWdbt5sT++QCy25RXYRYwbIO1qzrHWdk7SiUTH/rUGck5uGUt5TwJX/Xo
         h/jTfYj1lqGNOFdqlCx0nGFRK4chzqR4sSzUmqLMokJFwgtx1tLNyoWClCWWdSPjMYxp
         JVtFVXWlEv4/jWN2LSU2AYTNqSjjcTVxa81JKoG541pIDAM1zohS/S2xGpojZg+MX89I
         faQCVYenmGA8zybaecAQ7zlIvXmVd9QzU2fAebZPITgKqrG75emP8ZuFrUnMH4s3Dr0D
         GhkiXVE1dh7o06jjuOz2zbYDu3Lx5we9MeGm9Q8r3TqbngLqJA2Sm3/oG/HyZZJ3UdQ0
         Symg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637366; x=1793242166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7r/tZyNOIYSpuH87ucbpXiJxUIn8Iiqk7+xaK64n88=;
        b=g9cOaGVHe2BckkmjBdRtDxBehpQOwEV//OJ5KyJjwsIGDq9vf6zScwtm7603n2LrYU
         FHLwajDUk7qx2on04IrXvjbyJ0NwOslCRTrjivmbOaSjg/8EPFAI4s6esCmWFFSHzgap
         4tAITr0/ixsIr2jUa0sy4xHc0FR5SNXYdQO3stYZJNgvWYuqxgGXQA3tPU+0LxcF7r4L
         TUW6gifnbPGdNuwDg4PyzldOsUIO/46bfFBwTUQJywAOlk0/0kYOXvVmXDLuV0jr4UUw
         EzkjWuRWEKkE+b0bWy3Fht4mnk0QuH/NXQRtWiYVpoz37PD0ryAHqggvC+NY5K6lZm5z
         Nzvw==
X-Gm-Message-State: AFq9FYIqDegGK6p7pjy6xlFWgoIepMb7Ol1byMVtduJm3kdiheYjMQn9
	5B5fzZUVqHCkYyPE3xDDmZeRM+vZvZCM+B3QRzBQhOuoPWoKfDzWDuuKG5lO0g==
X-Gm-Gg: AYBFou2+JvXvGHvj6Nw53TU+370B51f18s+n5DSC7gW06S/dwnfX5GUq0jhBTHKjsoI
	Z+0MtCXMU6zMwyGPP9oA31U1i9elev9LH3/NSQAhohugaIG/f5MMYdIZcINKFsZTsAN0UOU+/s+
	CcvFpsPNZzVSs0sKTh0X4X1lBtmN1NUiCQeKszlMm5E7H41wV48azabHSegkN+bhXF24LrG6idK
	didB3btgQrb+TGdyfUaRkygguinJ4NYHPJQtt9DzlPBCexLmDGLAdu3+r6O7Xiy2ToVuA6g10SY
	DuhA3ocJvfdj/R2dKJjcGu7eVYLBXO32Rp0WF07vv8B2ZvBJ+Shb5h5RRBitu0ewhMHZQLg0o0P
	8x6L9P++WF/7UdvdXMibICIAmWbgedGJDZLJZkAyztCe8k+28BuUe/fSBiNmBAKAJfzhWwMuNeR
	UvUSX9xjcKOqo/hGsvgDptYt51LJra71QMxOji8SOx6mEgsR5WovjOcRAcEc76BPFxFR8cdL8Ox
	SKatEUwcP4DFpzM7pejBH4eSxnDPvG0rAzSE/PXvD0dM5I=
X-Received: by 2002:a05:701b:2092:20b0:152:dd1b:4fa7 with SMTP id a92af1059eb24-192f03c9ecemr1528753c88.19.1792637365797;
        Wed, 21 Oct 2026 19:49:25 -0700 (PDT)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903ca044d4sm11114101c88.17.2026.10.21.19.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:49:25 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] perf stat: Start tool events when enable_on_exec is used
Date: Thu, 22 Oct 2026 02:49:19 +0000
Message-ID: <20261022024919.263876-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

duration_time is a tool PMU event emulated in perf, so the kernel never
sees it and enable_on_exec cannot start it.  perf stat enables the events
itself only when enable_on_exec is not used; with two or more events
target__enable_on_exec() is true, so the tool event is never started and
reads as zero:

  # perf stat -e duration_time -- sleep 0.1
          103813345      duration_time
  # perf stat -e task-clock,duration_time -- sleep 0.1
                    0      duration_time

The zero value also reaches the default CPUs_utilized metric, which
divides by duration_time, so a plain `perf stat` prints "nan CPUs".

Start the tool events explicitly when enable_on_exec is used.  The second
command above then reports 103991394 and the default output prints
"0.0 CPUs" rather than "nan CPUs".

Verified on an arm64 box (Ampere Altra, Neoverse-N1), including the -r,
-I and group forms of the command; x86 was not tested.

Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/disable")
Assisted-by: LLM
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/builtin-stat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c50cf230f16e..2062623682fb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -510,6 +510,15 @@ static int enable_counters(void)
 	if (!target__enable_on_exec(&target)) {
 		if (!all_counters_use_bpf)
 			evlist__enable(evsel_list);
+	} else {
+		/*
+		 * Tool events are emulated in perf, so enable_on_exec above
+		 * does not start them.
+		 */
+		evlist__for_each_entry(evsel_list, evsel) {
+			if (evsel__is_tool(evsel))
+				evsel__enable(evsel);
+		}
 	}
 	return 0;
 }

base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.53.0

