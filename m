Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23482B663;
	Thu, 15 Aug 2024 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685803; cv=none; b=HqoT0H2Sdz00CTVEqRxDuoLGD4g6pkx+yG73KilAULa3v5WyHWL45m6hbAvHYzaRBKhe0lJXKoyqH0HqytBsTYDEwEzhSv+9oRyi1zTcwKJ1OjWbC5F6Mk3HSsciv4DEcRRvTc23RRHoQeVq1isfYv0fAXNLg553ZolBb/PFNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685803; c=relaxed/simple;
	bh=/zEv8M9GajqLNiVXDbDbUzFLJxXKfIlEjtf7j8fihFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1wbnSgZLubyyHAu9iy2EYxB3hW0UcEh+PbFb2CTc8BbnIdFhMsrmDEKX5pzV7jA8pFoWadwgaPYTL0P9AkS4Mg5pID+5dG2iYeLRh2QItMJcnMFPLpnDST4y2r+nZ2NXLFIJ58M3MaiBs6QXChYMKGbOi5XzlSKyY9sfCOAwis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6oP6Aah; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6oP6Aah"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-26fd5a65057so415491fac.0;
        Wed, 14 Aug 2024 18:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685801; x=1724290601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhAQIULCNKZIk1tNzCvuYy9BXBZ3c18NDxYNH/x924A=;
        b=Y6oP6AahXY6Jst/aPocxvO9fmD6qfsH8KIGpoITN1RzyDCHrAAxz9txbwCSi7Yyzzo
         fnnvCB5YJu1fb4e5DUhFMWc56PnmCJayxfBNWGNIOXtZJQzITbyC9s0OkwyoMhZNZHea
         u6OW8pgU7f1GNmZ7izk5RzOEYmlb5g7gxlj6r+vd4HVmAIyP9c8bg5n6NwxHdVrgtMjs
         XT3Lqd0g+/7BauoPZ8RFDqqYZm87dy4M7KavLOHDY9pt/MlZNeJmM0PHHrpTSpgTXNkX
         yf/HHw/+zRQN17OSJRRfUy3qLj6t95QmLKe/we3UoFDoWtGJfLz9xJiGfNYYZp3c8Ofs
         Q8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685801; x=1724290601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhAQIULCNKZIk1tNzCvuYy9BXBZ3c18NDxYNH/x924A=;
        b=baDHuueLF36y1CGEgQnQPmv1fq518DXlHcLS9RbRD38HPhK9cmQMN4f4vic2cR7XM6
         Wi5gd0dBWpZyHYvQ1BDXZ87foo+lm9291q8tlAR2QZJAT6qJT1XPq2DroQjATI+/IBe0
         aTq9zc3IocbdkCX91iJTZmYNtRH2AmAZwkEgnNshSlV/NwDrCdgQ2nS+Wou8JuJS40l9
         W0gdvHEBPDT86/aX3WQFhl91fpH1AvW1H2PtpCbGu157nSZRY8FD5wCG3XGrMyA0Vvkw
         H1EJICR1Radflugvb9DNyxaEE0OCPjVyKWmbDt5p0Q/9HXxu+KJOqYeoA/HnN2Wlzp63
         vF7g==
X-Forwarded-Encrypted: i=1; AJvYcCXRBHe+oQt8d5BnEM5S8LgovsdkRxS2SdzVE8wlZmuuig0rzEChoLIh77+7DLorwFHdtPdKBhxL2hlMYFjG5KahcA==@vger.kernel.org, AJvYcCXYnsAarSJCiI1xsTZIErVxn0+NY0AIQ3ubrdXWUGzhBp3V4LiN/qbypHJxS6W1J+01aVcZWwOWLWvXxgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24AQ/U/I1/Wem+b2gXZW5J5E/93W6EEZCusISLC9/cJzWunf9
	WjpUf99He0gAxCB4be7DJPDc8YBi3I+kuf9qXGMzphZRA+eoYXcg
X-Google-Smtp-Source: AGHT+IGXgoLIiAXccpht+n/Mwm7s3WcADg4LTBbUE+zLZ70P4sh6n80+FmF9XI42AMZ58p2SW4a9VQ==
X-Received: by 2002:a05:6870:9691:b0:261:72a:1336 with SMTP id 586e51a60fabf-26fe5c45c67mr4816123fac.50.1723685801064;
        Wed, 14 Aug 2024 18:36:41 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:36:40 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] perf trace: Fix perf trace -p <PID>
Date: Thu, 15 Aug 2024 09:36:17 +0800
Message-ID: <20240815013626.935097-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815013626.935097-1-howardchu95@gmail.com>
References: <20240815013626.935097-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf trace -p <PID> work on a syscall that is unaugmented, but doesn't
work on a syscall that's augmented (when it calls perf_event_output() in
BPF).

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

bpf_perf_event_output() will fail when you specify a pid in perf trace (EOPNOTSUPP).

When using perf trace -p 114, before perf_event_open(), we'll have PID
= 114, and CPU = -1.

This is bad for bpf-output event, because the ring buffer won't accept
output from BPF's perf_event_output(), making it fail. I'm still trying
to find out why.

If we open bpf-output for every cpu, instead of setting it to -1, like
this:
PID = <PID>, CPU = 0
PID = <PID>, CPU = 1
PID = <PID>, CPU = 2
PID = <PID>, CPU = 3
...

Everything works.

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

save, compile
```
gcc open.c
```

perf trace
```
perf trace -e open <path-to-the-executable>
```

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evlist.c | 14 +++++++++++++-
 tools/perf/util/evlist.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c0379fa1ccfe..f14b7e6ff1dc 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1067,7 +1067,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!threads)
 		return -1;
 
-	if (target__uses_dummy_map(target))
+	if (target__uses_dummy_map(target) && !evlist__has_bpf_output(evlist))
 		cpus = perf_cpu_map__new_any_cpu();
 	else
 		cpus = perf_cpu_map__new(target->cpu_list);
@@ -2627,3 +2627,15 @@ void evlist__uniquify_name(struct evlist *evlist)
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
index b46f1a320783..bcc1c6984bb5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -447,5 +447,6 @@ int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
 void evlist__uniquify_name(struct evlist *evlist);
+bool evlist__has_bpf_output(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_H */
-- 
2.45.2

