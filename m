Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E228726A
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792652; cv=none; b=GGj02VwqZ8cL5RPx9ZmJxCA/JH6tssrZty+d0KKhgWN23+rIjmxYCfVy2+cxZhzDueA2Vsaj4z5jzaqXJwAYRPZHQz0OGJw6zkDo31XOgzANCmcjIowt6S9o2Ki0oy+xklm8yVguL8YU/QZQWxdqaI8FSOBrbdoMpu6GqUIaENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792652; c=relaxed/simple;
	bh=HNu7Dcd5vvNfh2oB/9//HT00PJ8dhROTfKt08npi0Xo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xb2tpc13KPztmOfK747RTtdStbXOEePslwmAraCSiyBBMa6X7JHm5JfIxJaYqyQPFmLevbQGRmMVmzmjMbCReSDGQ1k3nliDewezEWsOuDhBr/Z1fmQwFn9BQrlfao+Z4A6ZYmf+rU6B/NfdKrKApQktcoWKkcYtEOBNX+fEAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkxQVfEk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkxQVfEk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297f8c26dc7so15259085ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 08:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792646; x=1763397446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvOciuVeFDrZI28wwbDFkVg+RFkidCZi4q1TH1/mApw=;
        b=BkxQVfEkEBOYEpCeUBV842In3TXrZSeDm6WTzj4dnhlJnM/V9G58u2nYPa/Knffz1U
         6Sy/ftr0I4ErZmavti+TsQOhwPBv2DFSW37bpJoP53In1JSYftTGImWiVtiBsQ2ORN47
         MCtLtxT1bidHRtJveRiETAElwfMJt+wiOLmV8za6EJ4sxmeGzyPTx42LXlH/oVmWpdpu
         8Q8ZKqD2Cf5esbgYH3GHQRNwJviYlHsamyt0H/EcrG1ewtc0sTUyHpgeo53KexFSmBxC
         D2AnvxOe9DAEcB0yGOEe4o7YPl0fkn5C0HAJC9CRr+lr/zjPEjRd7v23NsEMoKX3nHrH
         wP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792646; x=1763397446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NvOciuVeFDrZI28wwbDFkVg+RFkidCZi4q1TH1/mApw=;
        b=Cx+ZrRTTHlHXPb5ROUdo8knMstwU844v+qWixbTnxOq9HqcPBkKZFZ4oXuRq1WtvJ/
         GP6o6khqvRKV1ExBLW4Ry86GpxJ9m08by3suwmnuYmy2wb4nGWVJARuW/erFKKmKPa1D
         FyQHrBhZKKqesrh8SswFRSxAZ0W+7ulhmcMck7PVX+Txkc+GSj/DeSxMB+lMgdFsC1OJ
         GoZi1FT7a7MEqWn2sKJmKc28bMmvxqGsNmDK377CAommQOWmcNTs1qdEDpvX2wW/oTRb
         cWC+72XOuOjJpBi2fwAz49q7aHkA+GZIBGbK48VASNB1uQ0OMusTw2UxiGi+zNcjFMPw
         1mjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7wEhjwY1TZav6sH9wht+410WAl1yVk+Qq0CqwgUxiSKTMuC5wYWE9zSQ/D909Ek+WsFsxA2t44XIGx+rnXlUb@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZ876pJ7RKVIIGhRwNd/oMhHKnLxP/Ov4zjVUiFR3rwuYJEel
	DUTXZRQ2RUV1FqtPGhcWweSZUZlnPl4vL4PwqXw+jJk4F83cUufBZq5g
X-Gm-Gg: ASbGncvYBtbS8o4dFgohJYkLTbiq7CiGev7qBYTjsK3HYXc4MJJ4u6+aaIptviUP7Sy
	sXPn9DRE0VfuRKAWyx0oaPbEWuJAyZsp63X+rFdf2cBDnwq2pBI7waGCVOPjs+KSBVqCq57NFii
	ddoh8nvSGrEmuejVtcxYxrxqqt7w2dvfhdUVXICuc93jGBU9Oamgn0ZBoqNNRGDEeuK2YKkotPv
	M4jTYZl2/cYpJdkid43h17ypS0+PUbUYRok6I0oPezZ7H/cwT9mSAB44CGyZN3GOP4GT+43ypq/
	AjfDy3PjpZSLzNg7NZVW2QyDWSEXHDKk/AWtCOf+L72wJmno1+PrBt8vLtQqNVtvviA7/gkamoC
	XU8MMGmnfMW6Dhl6Xd/R7n0YaIetsM2HiKU4Usv3Gd8+eFQLkDQ/fMq4PfqXBngl73qY6RuUunr
	pvcIFejdsq4b8=
X-Google-Smtp-Source: AGHT+IHgMULgC+DBrIvta4Gt30Ay5gyo7asjfOY4+q2Dbpcc5OVehm1NQ3FiY7ELdv1UD5aLJGKDyg==
X-Received: by 2002:a17:902:da4b:b0:27e:f018:d2fb with SMTP id d9443c01a7336-297e540dbf8mr108586355ad.6.1762792645676;
        Mon, 10 Nov 2025 08:37:25 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5ce87sm150078775ad.29.2025.11.10.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:25 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 10/27] mm/ksw: support CPU hotplug
Date: Tue, 11 Nov 2025 00:36:05 +0800
Message-ID: <20251110163634.3686676-11-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register CPU online/offline callbacks via cpuhp_setup_state_nocalls()
so stack watches are installed/removed dynamically as CPUs come online
or go offline.

When a new CPU comes online, register a hardware breakpoint for the holder,
avoiding races with watch_on()/watch_off() that may run on another CPU. The
watch address will be updated the next time watch_on() is called.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/watch.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index f922b4164be5..99184f63d7e3 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -85,6 +85,48 @@ static void ksw_watch_on_local_cpu(void *info)
 	WARN(ret, "fail to reinstall HWBP on CPU%d ret %d", cpu, ret);
 }
 
+static int ksw_watch_cpu_online(unsigned int cpu)
+{
+	struct perf_event_attr attr;
+	struct ksw_watchpoint *wp;
+	call_single_data_t *csd;
+	struct perf_event *bp;
+
+	mutex_lock(&all_wp_mutex);
+	list_for_each_entry(wp, &all_wp_list, list) {
+		attr = wp->attr;
+		attr.bp_addr = (u64)&holder;
+		bp = perf_event_create_kernel_counter(&attr, cpu, NULL,
+						      ksw_watch_handler, wp);
+		if (IS_ERR(bp)) {
+			pr_warn("%s failed to create watch on CPU %d: %ld\n",
+				__func__, cpu, PTR_ERR(bp));
+			continue;
+		}
+
+		per_cpu(*wp->event, cpu) = bp;
+		csd = per_cpu_ptr(wp->csd, cpu);
+		INIT_CSD(csd, ksw_watch_on_local_cpu, wp);
+	}
+	mutex_unlock(&all_wp_mutex);
+	return 0;
+}
+
+static int ksw_watch_cpu_offline(unsigned int cpu)
+{
+	struct ksw_watchpoint *wp;
+	struct perf_event *bp;
+
+	mutex_lock(&all_wp_mutex);
+	list_for_each_entry(wp, &all_wp_list, list) {
+		bp = per_cpu(*wp->event, cpu);
+		if (bp)
+			unregister_hw_breakpoint(bp);
+	}
+	mutex_unlock(&all_wp_mutex);
+	return 0;
+}
+
 static void ksw_watch_update(struct ksw_watchpoint *wp, ulong addr, u16 len)
 {
 	call_single_data_t *csd;
@@ -206,6 +248,16 @@ int ksw_watch_init(void)
 	if (ret <= 0)
 		return -EBUSY;
 
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"kstackwatch:online",
+					ksw_watch_cpu_online,
+					ksw_watch_cpu_offline);
+	if (ret < 0) {
+		ksw_watch_free();
+		pr_err("Failed to register CPU hotplug notifier\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

