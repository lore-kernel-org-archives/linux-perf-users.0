Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2033FB1B
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221206; cv=none; b=HIX4Cpe7jPfaVW4FGfVMjEIaqPnj+XfjG5AfIZZcDZ2AaPBkFAzxTcWwO7Ipt//QIrKmvxkQUSzmHjcK8o9/w+jyHyeEbbgAWFOEFNvNeZ9Db6xhjqDZ/Bh/vwL1eZTxWpOiMqwm86BGtrHJnGVxzPRHidZrdBa5oDPC+JwU4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221206; c=relaxed/simple;
	bh=F5awBpvx4zkj2tGsz/UsWtd72v6Zy6HzR2Mdb/TPfYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lEgu8mUc/UIFHwx9LcuqwS6CRF3r6IvdbZzhbprBd3K4vU6sNgmWROS3Tz+P0qBQgj0VcLcxbM5XJmmRWuz6gc5wfkWxpEXZF5SYu9DwKxWR3Q+1xAG7q4jgnJKURzvoTTNYspno9Wc+kPgBPtZEevVwK2+lq7V3XP8veGwQ6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=I7KyD8jo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="I7KyD8jo"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so17714243a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 19:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736221202; x=1736826002; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyx3pVShaJ90YkHTQsNhst9gWh0VtzJXnEx45QrL264=;
        b=I7KyD8joF1vHrtoKhFSWMuh/wvyCkSapZmyPdCZXho0ggxYXUPUXtWbGe/SLVz+sRZ
         R6pHZSkYUOxYwaN2/xafzDsaaVjM5iI4q6bP/jB27olMaHBO+/NLe0iqR+8qyO1wmVAA
         StJc1XO3crVUDX8EFcAxx69GNWLps4LgdNT/Gq9PX6aYPayj4q6U8swvhWe+IRhfxZP0
         FOzFtBT7BlCBITp1574IzsMsM44vpvrpQytlomxrg5HfRvVM49hjwVU3j1AIPqA6iyfl
         zgLXN+YH/b8sks6NuxbDCHqD9dxKYjMoOwRtUnROIU6wyVdlxP/nHwEYP48YLC6l1492
         ZswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736221202; x=1736826002;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fyx3pVShaJ90YkHTQsNhst9gWh0VtzJXnEx45QrL264=;
        b=ZN86c3VmGxXOnnHziHO79I7E2kZgHA+qY2dP3j1Z+6AhahQs2oVDPzj9H55Hd1Yhmp
         e9bDoSJ62isaCsjJnaUVyQ/6cr7j8i4A7/s4dy4zW+ijkgSdtA5MhOvsLeb6Q4e381NR
         D53AxxsfVUL3hNJ7pQo24dl9EmTCMjpHNQr6KFBUc7VL8ToBakC3//S6FjhXFY7up4U7
         SM3Wm9gEXsrW0wjpb/k3JdSokk1rKweo7jWiQEhwtQCQN52Ut40XsDzsPiPqGl55F4Wa
         qN4Y7iBcym5itsB6sEQD6uOVAaRE05JBpcgHhbH0Qk6DZsKIW/YQyCW44kjdGBa4Aqoj
         CnjQ==
X-Gm-Message-State: AOJu0Yxydsa5Kmucqzo6S6pEfZV9FHa7cMQqnGHXQLaUEx+Er/Qty32V
	3nUXQqHqWKIpFmupvdJIIWo24iVkAy0kYVH+NZJJawi1wLEoNZosSCV1ZetIlc4=
X-Gm-Gg: ASbGncvaGi7JxnfWYz+o6VWHqcpNtXWSPxqeZFR8X+8uFKXpbSrDiM+ce0xTcXQJ9gT
	VECIWgYIdEdqMrTa3Ir2zrypsqfwRhMfB2zAUcGK4+LsdGXc5LBkidVST53hGpWnvZ/xtsdbYkG
	L+DrRDW4GGGDTH1HEYp4Tl0bSBioz/tQW0rzmfGK6GLYkf1C48ELnrFhWcam3iNAnyts2Hpxtzd
	TZDbqD4PpQ+eDn/Ntamkg29WZbsIYuLtLrkH7VuzUmfIcX2qwfZLAW3DPQ1qX+HrCODyapW
X-Google-Smtp-Source: AGHT+IEC9MIQhcggYvCJDm6x9tT/F9gut3g32c9EQWDuw0bmJLjO/nHjnLibjivKrWKmQV+OimKr7Q==
X-Received: by 2002:a17:90b:2dc3:b0:2ee:8e75:4ae1 with SMTP id 98e67ed59e1d1-2f452e48804mr78586502a91.21.1736221201959;
        Mon, 06 Jan 2025 19:40:01 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478ac95csm34638466a91.49.2025.01.06.19.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 19:40:01 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 Jan 2025 19:39:47 -0800
Subject: [PATCH v3] libperf: Add perf_evsel__id() function
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-perf_evsel_get_id-v3-1-44eca9194f1e@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAAKifGcC/23N0QqCMBTG8VeRXbfYjnNlV71HhOg80wPlZJNRi
 O/eFCIIL/8fnN+ZWUBPGNglm5nHSIHckCI/ZMz09dAhpzY1AwFKnAH4iN5WGAM+qg6nilpuTyi
 llUUhVMPS3ejR0mszb/fUPYXJ+ff2Isp1/Wr5jhYll1xYW4NQRkmtrp6iCzSYo3FPtoIRfkgpy
 j0EEtKAxhoFWC30H7IsywfcDlMz+gAAAA==
X-Change-ID: 20240822-perf_evsel_get_id-f7e11f15504b
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3816; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=F5awBpvx4zkj2tGsz/UsWtd72v6Zy6HzR2Mdb/TPfYg=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rNIhYZZnFPi0vpEVU21tKCf9LutB/vurn/8u7MqdZFW
 3vfmwl0lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMJHeUEaGTdwnV3L6nP0au36p
 id7BruxLzwyCfSfeNQ7giq4NEfrWzMhwrt1v9bFt8xdMkPYK53zGVBp5T7YhwW6rb1HLjolmDRa
 cAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Introduce perf_evsel__id() to collect the id of an evsel. This allows
applications to determine the allocated id of an evsel for each fd. The
"ids" argument is expected to be an array the size of the number of open
fd's for the evsel.  This will allow applications to link the id
returned by PERF_SAMPLE_ID to the event being sampled.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Replace id argument with array of pointers. IDs is indexed by
  [cpu][thread].
- Add error handling
- Use uint64_t instead of __u64 for consistency
- Link to v2: https://lore.kernel.org/r/20240909-perf_evsel_get_id-v2-1-b26eae02f606@rivosinc.com

Changes in v2:
- Replaced id argument with array of ids for perf_evsel__id() to support
  the id for each fd.
- Link to v1: https://lore.kernel.org/r/20240823-perf_evsel_get_id-v1-1-0ffa204c4164@rivosinc.com
---
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 23 +++++++++++++++++++++++
 tools/lib/perf/include/perf/evsel.h      |  1 +
 3 files changed, 26 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 59aabdd3cabff19c9a4835d9d20a74c6087d9a06..0133547394c296ee3ab7467ebe5c9a48707bad1d 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -93,6 +93,8 @@ SYNOPSIS
   void perf_evlist__enable(struct perf_evlist *evlist);
   void perf_evlist__disable(struct perf_evlist *evlist);
 
+  void perf_evsel__id(struct perf_evsel *evsel, u64 *ids[]);
+
   #define perf_evlist__for_each_evsel(evlist, pos)
 
   void perf_evlist__set_maps(struct perf_evlist *evlist,
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c475319e2e410d31d072d81afb9e6277b16ef1f1..7c84ecaa6c87977edc9c70e960e985ffc975fcbf 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -486,6 +486,29 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	return err;
 }
 
+static int perf_evsel__get_id(struct perf_evsel *evsel, int cpu_map_idx, int thread, u64 *id)
+{
+	return perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ID, id, cpu_map_idx, thread);
+}
+
+int perf_evsel__id(struct perf_evsel *evsel, u64 *ids[])
+{
+	struct perf_thread_map *threads = perf_evsel__threads(evsel);
+	struct perf_cpu_map *cpus = perf_evsel__cpus(evsel);
+	int x, y, err;
+
+	for (x = 0; x < perf_cpu_map__nr(cpus); x++) {
+		for (y = 0; y < perf_thread_map__nr(threads); y++) {
+			err = perf_evsel__get_id(evsel, x, y, &ids[x][y]);
+
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 {
 	int err = 0, i;
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 6f92204075c244bc623b26dc2c97fa4c835a4228..2bb9d6406e405b4ee29b8b13d64dd40b78edb501 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -41,6 +41,7 @@ LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx
 LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+LIBPERF_API int perf_evsel__id(struct perf_evsel *evsel, uint64_t *ids[]);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);

---
base-commit: ed60738a9b7ede4a4ae797d90be7fde3e10a36c7
change-id: 20240822-perf_evsel_get_id-f7e11f15504b
-- 
- Charlie

