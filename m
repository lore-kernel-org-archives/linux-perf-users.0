Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF816A382;
	Wed, 31 Jul 2024 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455403; cv=none; b=gp0xbQAmRog9RxJVKUlJ7Luh68ob0AZyw/ZJCg5O0pIsdeA2KcOtjq2Q7muoBZZ2LPocg2FiIf8jHK73/gwHuh6KKjQqQHY/HWwS42KNon7XI1pTn8qR8Ufgh/14yExTh4o2U6DReApYka/T65kkQL3Tu4MDqFVMvwaGjlDtOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455403; c=relaxed/simple;
	bh=bdH63NbzPfhPDwbj77eNjSjSZXTh5s6ihXFbPtox0W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARmFRhGsCKhxDApJODlvPAl2PpO32GO7JM2V5bA0BJxC01seSkwW0PG6phlAt1jzRgU+HEGDZWXZTuRCJmO4BO6tJ6j48GtHTKugaZ4Y1YyS2QQKDgQsS+T2Gwm7LNv5/XzGXk5y6iGKcE5teQRVEjqq1f1TD9O4sXLm9CA+SRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4wQFqAl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4wQFqAl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fec34f94abso46523645ad.2;
        Wed, 31 Jul 2024 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722455401; x=1723060201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju0jY73M15/Km/Rk23hX69VlYqjLUT0lo/npmehqa64=;
        b=I4wQFqAlA7/Q5/Rq1PgIl9Lgcl5lnxBDo6VJS0kRa0Tr9pEPKEOeBHrDPKN9EHi3k0
         b+b+/0JR7l6smvS/5G2/YYy2O82IeOTSgGq6koYFCqpeId0EpHL6OBcxjz5Nb4w3PBHW
         UDUmCBDxyV2N5ah4qTI8/9OzwlyJd0/e5m4f2qA7ZPl8+XUSy3W+HuizJ/IrKjUZGp/t
         +EkRzEuOKCbvu+CwV3UNv8v3ENYubNyGcGlxwv3Kgzj995UvEv0zTnmXHS88SyUuCE8L
         VLV1l32QKNld2EWu5PwsmdUmWVH5AV31B0UB6nOhzl1+barK7gTNRMKRWc/Eo0k03qdg
         VVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455401; x=1723060201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju0jY73M15/Km/Rk23hX69VlYqjLUT0lo/npmehqa64=;
        b=YQC7fSemdQHaM2TF3/ZQgVkkKkX6ci+a318qy//dvoH080LBygVBLc3lawajup9MBD
         VXebxktT08O2jZIvuDra/XHYM/K5I3cRXG1ZXb6B35Y7CbPqEa6s7wqHOGFoocOWX+GD
         bHp9BGODgdyQedbFjfHjEhPSlggvTFHGvkBoL2S87GhPoadB4Rmt+1Y3+apKb59unSnY
         rdNKxEJQrwylpm++LQ5JjDwj8b28B1ze3tY0ZLN3KD0pchjWUqUZCVhHQFsQCVQvhK+M
         IEU592CNmufSc1kZNThUChG9sw5PuQ47AQFtJpxNkhzTh4C5VDnKC3uHPuqXHbmyJBP7
         8Q8g==
X-Forwarded-Encrypted: i=1; AJvYcCX6eBSU6J1OGnJmDcQFdoT7KVVp2/jKB+4zav/dFyD3m/QxsNZFNKbYreriugFYUjliJ9cQbPa+4LOqeHCULwW6XBT2zpNY0GAamMW32qqVX1fVqveZTmoXjA9x0cj4z9XEeFaPeRDkeDc3lKYmDw==
X-Gm-Message-State: AOJu0YxKa/0U9isyBW20fcfjhOzEgWfeptRcrZf7rujmr+22Aq1mrq18
	Pd+bQcXeYxGFxygF1/y6sX+DraGipTcz9t6rsomTkwafosFzcNCNrny3zAKJ
X-Google-Smtp-Source: AGHT+IGL2RonNC+XV0tUvbHyKz34yGWDKWvZek7dMBekMq3bKLCmWqFE8rqM+1d7g1YLgts88A69RQ==
X-Received: by 2002:a17:902:dad0:b0:1f9:c3e4:4c0f with SMTP id d9443c01a7336-1ff4cea279emr4888815ad.34.1722455401268;
        Wed, 31 Jul 2024 12:50:01 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7837e40sm124708615ad.0.2024.07.31.12.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:50:01 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] perf trace: Fix perf trace -p <PID>
Date: Thu,  1 Aug 2024 03:49:39 +0800
Message-ID: <20240731194939.4760-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731194939.4760-1-howardchu95@gmail.com>
References: <20240731194939.4760-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf trace -p <PID> doesn't work on a syscall that's augmented(when it
calls perf_event_output() in BPF). However, it does work when the
syscall is unaugmented.

Let's take open() as an example. open() is augmented in perf trace.

Before:
```
perf $ perf trace -e open -p 3792392
         ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)
         ? (         ):  ... [continued]: open())                                             = -1 ENOENT (No such file or directory)
```

We can see there's no output.

After:
```
perf $ perf trace -e open -p 3792392
     0.000 ( 0.123 ms): a.out/3792392 open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)
  1000.398 ( 0.116 ms): a.out/3792392 open(filename: "DINGZHEN", flags: WRONLY)                             = -1 ENOENT (No such file or directory)
```

Reason:

bpf_perf_event_output() will fail when you specify a pid in perf trace.

When using perf trace -p 114, before perf_event_open(), we'll have PID
= 114, and CPU = -1.

This is bad for bpf-output event, because it doesn't accept output from
BPF's perf_event_output(), making it fail.

What is ideal is to make the PID = -1, everytime we need to open a
bpf-output event. But PID = -1, and CPU = -1 is illegal.

So we have to open bpf-output for every cpu, that is:
PID = -1, CPU = 0
PID = -1, CPU = 1
PID = -1, CPU = 2
PID = -1, CPU = 3
...

This patch does just that.

You can test it with this script:
```
 #include <unistd.h>
 #include <sys/syscall.h>

int main()
{
	int i1 = 1, i2 = 2, i3 = 3, i4 = 4;
	char s1[] = "DINGZHEN", s2[] = "XUEBAO";

	while (1) {
		syscall(SYS_open, s1, i1, i2);
		sleep(1);
	}

	return 0;
}
```

save, compile, run, get the pid
```
gcc open.c

./a.out

 # in a different window
ps aux | grep a.out
```

perf trace
```
perf trace -p <PID-You-just-got> -e open
```

!!Note that perf trace <Workload> is a little broken after this pid
fix, so you can't do 'perf trace -e open ./a.out', please get pid by
hand.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evlist.c | 14 +++++++++++++-
 tools/perf/util/evlist.h |  1 +
 tools/perf/util/evsel.c  |  3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3a719edafc7a..d32f4f399ddd 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1063,7 +1063,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!threads)
 		return -1;
 
-	if (target__uses_dummy_map(target))
+	if (target__uses_dummy_map(target) && !evlist__has_bpf_output(evlist))
 		cpus = perf_cpu_map__new_any_cpu();
 	else
 		cpus = perf_cpu_map__new(target->cpu_list);
@@ -2556,3 +2556,15 @@ void evlist__uniquify_name(struct evlist *evlist)
 		}
 	}
 }
+
+bool evlist__has_bpf_output(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_bpf_output(evsel))
+			return true;
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index cb91dc9117a2..09a6114daf8b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -443,5 +443,6 @@ int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
 void evlist__uniquify_name(struct evlist *evlist);
+bool evlist__has_bpf_output(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc603193c477..0531efdf54e2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2282,6 +2282,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			test_attr__ready();
 
+			if (evsel__is_bpf_output(evsel))
+				pid = -1;
+
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
-- 
2.45.2

