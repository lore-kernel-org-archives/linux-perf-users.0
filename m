Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745760;
	b=W/3CzkvxaSpb+AdBX5vGt5Ha8GscqCmiN6A6TkrAuGFAL68wZ7PJbu3Z/rhTl01BGwEa
	 zt/le5klHbc5FVJ9gC/Zog2HkVCVNaPQ9tG1Q3me/0oAR53jvgTeXT0LsMb09yy9fvNjW
	 uHFyE76tsFDuYAZoWpm2Kx5kr2DgNAbEItUUTKIwKTlyyko/U2/9NmBWGQX4XxwR2j2rr
	 T4Oxige57oIUlPEekZgD2AvPUyH5zGqD2nj8jANXXA0iKKTM8tcVMoGCb1rJKECK7CfXB
	 P21ommK4i36A6mY46icb3edjytrMAZDO7CyBpPYL0PZoaDqBAPwFhXGFZBgV45RW9nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KqL98yyh7+lk5T29/nrd7/mf3OaIOAZcZAMihIvNM78=;
	b=ReZlLAyyIRPrgymvYUZw05XjNsK4ylGLMR6uy5aSY0CGRY0W0tpnysY7xPXJQlHs961A
	 1hh7gOu6ZMV5Ak8LM0LShU2hGgPb9ZT/h4fb0VlTA8qu6+U7MpuTV3uJ42wx3mk3pSuwd
	 3SuZ89855Ruiqtsgzek3oAafsdvbqvpet9A9TpH5csexiuIaKL2OUwfxSgczS3LD/VBzW
	 xeRvrK9YjdXnHp9tZYs0/OjYdhT0vAIM4CoUI4rrlIq3GSAEd4/XC3NL8wnzZ7ebRsYmH
	 LZgHpvqkJvgn7sGODVezYt8vlj6qlBBjN3KL82PWsCfySi5Vg3QzdZzHCdYAWaJPpBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="MBF6Tr5/";
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97432606A31B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 08:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97432606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MBF6Tr5/
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1517bda04a0so740652c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792745759; x=1793350559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KqL98yyh7+lk5T29/nrd7/mf3OaIOAZcZAMihIvNM78=;
        b=MBF6Tr5/nehuQLNowxyoT61cngXLgr+SDYOovbJyVgPLYiX0WcIsGBeGLjemNYGKgw
         KnYUIwVwb4COm784G8KkOZCMK3241ZSM/sTV3xPKvRJrxWyyP3czNkEENF0mKDwLcxcj
         rA/MbGnwo0K7RwdtKUvAH693XBdAIID5AvAUh7bW9rnx3kb1k2fmqDrbWkPihHBlLj7P
         /zytf7Fda6K4NA7c1hANSzM7hrA8lTgrnnZ9YOso+kzvEEPiXoU8AALhieLShb53j033
         xGByghHYWwiKIaSOVg2IEH1ix4Xorp0frBID5QcmTpVkhgDRjY8QM+LZlRceyM93lSOF
         5tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792745759; x=1793350559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KqL98yyh7+lk5T29/nrd7/mf3OaIOAZcZAMihIvNM78=;
        b=2JtMozTX2rXtm7eJ2DmylZtKbKwlXqBk3T9OzBiZydQIM5sKkFQIJ8qDPZQt5BOT3v
         M27hB1IDJjQ7PXCFlGRlJyN4jh+WPJGOWcNH/oG1OOsz0ongd1V/OcqbrQCgx+iHqTu4
         O2E3vfISBkRGwgArYmbWTpf3Ao4xA87ffp2nrtFwQFjcv5VkV6GoqLyxcvUz9nmjwrOe
         EZnRU2U9VRFUOL1qSmFMe0gmA11WUdKZvBjWxsqMQS/VUWvqxChDBWwkXg4ck6wKH99v
         7go8sY3M43RMpBKn2lQTiovaFCqeTh+KPFsk0qLKPz+dTcSKPZ5BPej6P1OJM8cbWJAw
         OmfQ==
X-Gm-Message-State: AFq9FYJI/wsuQahzUpVZ6v6wWcVowmDiQDogaBpCXYoiwtRAkWJ0I9UN
	56GafcNwFxPN5gV8FFvQyz9J0CjDY7c/Q4UFo5hd/BaM31eEHVGWMMgO3LAhjw==
X-Gm-Gg: AYBFou2HkQbTVtrZIJcBI/VrDrskEpIVkofz4NJWL/7k31zwqwny3HxmxWdPUNwErD9
	ZbOx+9qtgIPpnRcgRvU6tNIw0VKrnuxBF1w82ANEM/KlHGtT37oy4daFR4+x8cBDE1MWmSN54kL
	BwMBZO5EsSeQqXx17fRIjgeMUsnC5YDkyJX9PDf24DD2K+uMFSiNP9If3KHql+OZr7xhh6gD1ae
	43XwwQuR+7cohprRI0tgObrNdztZFbBRa7rGom/UBuLL+9+wKkOzBB/gwfJjAzdDVNk7KL1/cx/
	LiamABMHMsJak+cy5hJeqr/XFsrUf6vcbHvX7hpc9PeIN425HeoTxgJ+C/m2OQ+YXR6fk/FUC+B
	gkLXhVe2vFJlHHu5QU/zZVu4IgsnzmgHR0vlSblMZFSU+0Va6rkAutNkLKS/EgS+PVkud42L1za
	DVC8UkbYPb3GIu5CJseSpgKZDS4OPp0K6MVAvQYb+wTjOwQNu0ZSq7JkFcfGKqdcYfhOAUeWeF0
	VWMQxtKnGPJ0IYtkDNUTDinegt3D1ab7JEdSrfW358PxZI=
X-Received: by 2002:a05:7022:62a7:b0:191:a5b2:ef4a with SMTP id a92af1059eb24-195c6567c22mr3563761c88.28.1792745758367;
        Fri, 23 Oct 2026 01:55:58 -0700 (PDT)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195ec82eabfsm9697111c88.19.2026.10.23.01.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:55:57 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2] perf stat: Start tool events when enable_on_exec is used
Date: Fri, 23 Oct 2026 08:55:54 +0000
Message-ID: <20261023085554.1694434-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022024919.263876-1-takano32@gmail.com>
References: <20261022024919.263876-1-takano32@gmail.com>
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

When perf stat runs a workload, target__enable_on_exec() is true and the
tool events are left to the kernel to start on exec.  Tool events are
however emulated in perf (duration_time, user_time, system_time,
num_cpus) and have nothing in the kernel to start them, so they stay
disabled and are read as zero.

For duration_time this makes CPUs_utilized divide by zero, and plain
"perf stat" prints "nan CPUs":

  $ perf stat -e task-clock,duration_time -- sleep 0.1
               0      duration_time

Start the tool events explicitly in that case.  They are started through
evsel__tool_pmu_enable() rather than evsel__enable(), because the latter
also enables the members of a mixed PMU group, whose fds are not
available in this process, and dereferences a NULL fd:

  $ perf stat -e '{user_time,cycles}' -- sleep 0.1
  Segmentation fault

The kernel starts the kernel-side members of such a group on exec, so
only the tool event itself is enabled here.

Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/disable")
Assisted-by: LLM

---
v1 -> v2: Do not call evsel__enable(), which also enables the members of a
mixed PMU group and dereferences a NULL fd; call evsel__tool_pmu_enable()
instead.  Reported by Sashiko review.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/builtin-stat.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c50cf230f16e..ca4483f34add 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -510,6 +510,18 @@ static int enable_counters(void)
 	if (!target__enable_on_exec(&target)) {
 		if (!all_counters_use_bpf)
 			evlist__enable(evsel_list);
+	} else {
+		/*
+		 * Tool events are emulated in perf, so enable_on_exec above
+		 * does not start them.  Do not go through evsel__enable(),
+		 * which would also enable the members of a mixed PMU group
+		 * the kernel already handles.
+		 */
+		evlist__for_each_entry(evsel_list, evsel) {
+			if (evsel__is_tool(evsel) &&
+			    !evsel__tool_pmu_enable(evsel))
+				evsel->disabled = false;
+		}
 	}
 	return 0;
 }

base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.53.0

