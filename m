Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB025A355
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200339; cv=none; b=KVgsWIK3wTMnB5xIINbn89QRmDo7S6m/7sYtO+KMgRmtIKCZ228DKCycNWIT+F0zNefdLuxEdF+yFsfsfSS39DpPflC4e4Qg+f1X3utJH5zjcbmR6Fz3nwV3lIOxfvkp1hir0TJK9Ej0X8dcQsxzR+NFd9j4U1zGpUMe4amQnHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200339; c=relaxed/simple;
	bh=jb47W2mefivkhEZpeuyQPhjnJkRHRCJ2NscvV1apXQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+RYEI9f1VmiU4X75JvzNnGs7oir6QOUt9wakj8D43/hms/Ed9BwaBSBiShFoLS+JOd3Bj/Dc6PJTib6Y+n3Tzq5DckMm4YH8ygISj9VBzpRkk+kAFfUebs84XppSIG0mCsAy66oABUZ8Og4l4Fe5VN7f2LK7Z7Tg+u2WY37lSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3vWiMgM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3vWiMgM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2897522a1dfso17720295ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200337; x=1759805137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFRia/GHfKKxxNt0IUc2kN+EVm0fmr2Lz8hq8oGCXGU=;
        b=K3vWiMgMKtLTuKpqcWv34nrk88DQfOtkH/XpAg5Sxk0gw6iENOjF/zjJ6oOBnaIl4Y
         eM4nPaLnOw6Nr8aTYlHFq7s0F0fWz6AeqLcDT2+SVNrurs2aUA81kZL6xJVBkMp5tWsS
         h8kNgIyZllzdkGgbTMd7wlbZYlfSwH5aFnWrOo9zUpMFYk1oeENkPlKDiGbBX4sOE5rj
         V1MQlB+TSnc1NYhTzYSYu+W3jocbehr7/UF9ueW6Ds4UcO6KZTGIOROz+y31FUpQHtbA
         etYWOQ6m80S2vtvT6199cLxwnVz5HTi2atQrANsbmtmvK/XeJgplHY75s4UuxmTj7jdd
         wHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200337; x=1759805137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFRia/GHfKKxxNt0IUc2kN+EVm0fmr2Lz8hq8oGCXGU=;
        b=i0jllKp3Lzyhik5EpSj4tTObJn8XvppGn0sL+HDJjXV1rg5kXGQLUOqgBHEXVRie28
         ujw3JefT2YdR80pLVs/OTqxnpOuqurd6uECJKz5xFN5IrUmmWR5bimav7N4f5bCV0mOx
         XiYiCQUrrnlnWtYA/bYG8JCcLu7vi6yI1qJzgS7FC4cnPFQv7kN+orYS4gHerZAl1DCN
         nMBRgzEQpyLFsoLSCPNyye+bsPLyl6xwp9xtexjD+4rggVxTMpyGWrH79slCM6BjOr4d
         v6sndzXRa/2hoSN3VKwgUFIIul863xxXMbxSvCwJ3ldpVDBu0e9IYrUybzgX3F9NdaQF
         c41A==
X-Forwarded-Encrypted: i=1; AJvYcCUHF830e68NFZcFK/oT+8rT2x2SUEDLfSFYrka8xo8rIBQASGJD7UJkh5y8f8cG8U1y+i+bt3jtMbryReNZM2SG@vger.kernel.org
X-Gm-Message-State: AOJu0YztBmisSvCJ0G4uAHNMaXMMZmaDUj4UQ+9URiDIS6b/xphpMhAr
	DyNtM4CSdSEUhYsPIcnnzoOEz1sx4qvm848B4RLQhDU6qUjfRYhjeJmb
X-Gm-Gg: ASbGncvy4sS59tVBoga/AvHX78ecJUhkkfgD1wwNGYrwVQKIJGUfa3vEW4kTLOVy0RI
	SmqwOKbTtVjNvi8wGNPRmT/VKlWkjWhg21kQaPVlmswr7Enn5FwUcUIETiovFkxJxfHj4UXTmsY
	ARrhS/iizI0zoiy5aIHohXnPwCuawmkLsbIWw5otASFFEGadXdfvtZOE2cSa6ZgSL4pTU8WoKh3
	dMfSqVOVgmayXkNzLp97o3BmPUgGW7FHvizOCtk4m9ZgmRP45BPgkShQq3LCiP8x/o+EMUdRo2i
	/bBfhZMtT32TOzqHwpBgbDw+ePf2HhI5FcUDoHr80sCObLJqF40Ol8MTTm2hsLrn31ey4JdKPn3
	ERbCghClNo8Qo5I4Oe0gx5aqH/4fzLJGRZiCc2QooI0KpJ4I97AF42Jiv38qmhCOhzzKRZtaTwJ
	YS
X-Google-Smtp-Source: AGHT+IHKpBUnWq+gpU5Sy4KTGKE+VZZI2OvvUEv1k1IBPSw7fn6QhmyAtdZNGDjD1lnTAGMCtuFmNA==
X-Received: by 2002:a17:903:2442:b0:250:999f:31c6 with SMTP id d9443c01a7336-27ed4a3165amr204393375ad.32.1759200336891;
        Mon, 29 Sep 2025 19:45:36 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55bf378sm12519152a12.50.2025.09.29.19.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:36 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v6 15/23] mm/ksw: manage probe and HWBP lifecycle via procfs
Date: Tue, 30 Sep 2025 10:43:36 +0800
Message-ID: <20250930024402.1043776-16-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow dynamic enabling/disabling of KStackWatch through user input of proc.
With this patch, the entire system becomes functional.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 60 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 898ebb2966fe..57628bace365 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -14,6 +14,43 @@ static struct ksw_config *ksw_config;
 static struct dentry *dbgfs_config;
 static struct dentry *dbgfs_dir;
 
+static bool watching_active;
+
+static int ksw_start_watching(void)
+{
+	int ret;
+
+	/*
+	 * Watch init will preallocate the HWBP,
+	 * so it must happen before stack init
+	 */
+	ret = ksw_watch_init();
+	if (ret) {
+		pr_err("ksw_watch_init ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = ksw_stack_init();
+	if (ret) {
+		pr_err("ksw_stack_init ret: %d\n", ret);
+		ksw_watch_exit();
+		return ret;
+	}
+	watching_active = true;
+
+	pr_info("start watching: %s\n", ksw_config->user_input);
+	return 0;
+}
+
+static void ksw_stop_watching(void)
+{
+	ksw_stack_exit();
+	ksw_watch_exit();
+	watching_active = false;
+
+	pr_info("stop watching: %s\n", ksw_config->user_input);
+}
+
 struct param_map {
 	const char *name;       /* long name */
 	const char *short_name; /* short name (2 letters) */
@@ -117,8 +154,18 @@ static int ksw_parse_config(char *buf, struct ksw_config *config)
 static ssize_t ksw_dbgfs_read(struct file *file, char __user *buf, size_t count,
 			      loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, ksw_config->user_input,
-		ksw_config->user_input ? strlen(ksw_config->user_input) : 0);
+	const char *out;
+	size_t len;
+
+	if (watching_active && ksw_config->user_input) {
+		out = ksw_config->user_input;
+		len = strlen(out);
+	} else {
+		out = "not watching\n";
+		len = strlen(out);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, out, len);
 }
 
 static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
@@ -133,6 +180,9 @@ static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
 	if (copy_from_user(input, buffer, count))
 		return -EFAULT;
 
+	if (watching_active)
+		ksw_stop_watching();
+
 	input[count] = '\0';
 	strim(input);
 
@@ -147,6 +197,12 @@ static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
 		return ret;
 	}
 
+	ret = ksw_start_watching();
+	if (ret) {
+		pr_err("Failed to start watching with %d\n", ret);
+		return ret;
+	}
+
 	return count;
 }
 
-- 
2.43.0

