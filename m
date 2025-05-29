Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E8D299
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493610; cv=none; b=W1MF9f17NVGHmmOhzX2EGimDE34n0Nb4KMX6UD2Eq9IpCgFjeeiQtRUZ1dS9CmxMv+e8ubbPvJ8j92SAH8b4pHrc/31OVZWxhuG4uFa/xR0Hzlz0zF0mUGhfM2zMhhq8fNp+48FG/IJY2FIOHHWVllLcPvu/ZmttEf2QY7FTDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493610; c=relaxed/simple;
	bh=9wPoSZifE1t3wUFjmwqAikT26nrZz1wb8X2FZPryshk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FldOi9PseExblPcFXdXG5on8dnJgrVQ/aTD/ZXr/8W00/XaQaQRFf6wGd6CyiP9LDLAg69uEBkiOw6QVAlAEBYTehAFVjfvxBU6QsmLK0XxP+wqJILdoQMxdyvZmIGwiluZqL6SSBxYUx4gsp8A0GS4GnWQOlHygjcyCo8rc3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GcgC0BeX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcgC0BeX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2342ebb8a83so4228375ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493608; x=1749098408; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=722dErY8zW9Hiat6E75/pw12Xy7SEFMoHYruy8Cf3d0=;
        b=GcgC0BeXzYems79xGgg3lT+6uQMkagif5+rMagHOOcz4QTWaRwtZSYRr2MK2BQU20+
         EfxN+46vM5ZWjBlzqKTLsk0D4GDDspUyvJJcLYl5Fu3p9DmgHVprtq8oZIfpKMsqFzE9
         kUGh+vDTXb3gDx2QnoJp5SkW1G/KtvwTYzeSDCgGpAEYJej9SndxUxFDBCu4WP9yY/Lq
         dXMbsDYzLC3sahuGrvre50sTQyRo38X/Rz3FkiqtqTMcnja54Z0G/FL3fTMGzv1n+4zz
         KpnrGT+kHTup84G1hq1lT4t+H/i/4kSymB4pdbLTwSBxLmcwVhedsMLetW2PyPx7/s1t
         3gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493608; x=1749098408;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=722dErY8zW9Hiat6E75/pw12Xy7SEFMoHYruy8Cf3d0=;
        b=D3JPyOK38FT5QG/82MxeLDnqWxT/faJYOyi4JZIq17bbwr2rxBxjKjPSQTUnSCDNMp
         8B9fXBdHzDRLxVtVcsFgecK2sbFJkvH+FkcRDqayh+9DqAcaoB9WiVbHkMAoBy4h3pgy
         CvwvtdELJ2z7ICuqyUrV/ZEIli9hCA9f/r9NsSAWN+A3NTBHz2RQ3UEZVNmLmZW9RW+1
         IuiA6D7zpHikbzVLWxBixlR7nTJwR13XCIkzb6M5pl5X3duacq7Tk1thIlcMJEdXE5sb
         5zHt/ppf7XZFEy7ySmsDHra6tVuntOA9ouXjKENjeod30BO74LyPa+IJJpRMc76AO8oB
         GrQg==
X-Forwarded-Encrypted: i=1; AJvYcCUc9rexrq/Vw5hm/P6D3vv5cdolbhIpkASlFLFi8pWssYde6MkufSgQg949qjYkRdUkgO479ldY6QNDaUfqaPF7@vger.kernel.org
X-Gm-Message-State: AOJu0YypXE86fbRxuRNYp+dmAbJ1XHziSLCh0qxQxoJ0kuGHepHxL9Z7
	5cPL4JnQXGoL2Au3wsuW2BOdChXUpX3FPTPXI90Umtt4YhjBddM4jvairUiK9O9jHj+S4Lwmu6m
	hYbJ8tX3swA==
X-Google-Smtp-Source: AGHT+IH7dpEuGoQg21MoVuoQ48ifpe0WcOWCZSF02Gb8i4e8aMbd0il+r7EkdIyA9k85aoSprRbowJvEHNyz
X-Received: from ploy13.prod.google.com ([2002:a17:903:1b2d:b0:22e:5728:685d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea05:b0:234:e3b7:5d0f
 with SMTP id d9443c01a7336-234e3b75fabmr56521685ad.0.1748493607900; Wed, 28
 May 2025 21:40:07 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:37 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-2-irogers@google.com>
Subject: [PATCH v4 01/24] perf callchain: Always populate the addr_location
 map when adding IP
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Dropping symbols also meant the callchain maps wasn't populated, but
the callchain map is needed to find the DSO. Plumb the symbols option
better, falling back to thread__find_map rather than
thread__find_symbol when symbols are disabled.

Fixes: 02b2705017d2 ("perf callchain: Allow symbols to be optional when resolving a callchain")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 6 ++++--
 tools/perf/util/thread.c  | 8 ++++++--
 tools/perf/util/thread.h  | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2531b373f2cf..b048165b10c1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1976,7 +1976,7 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, ip, &al);
+	thread__find_cpumode_addr_location(thread, ip, /*symbols=*/true, &al);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -2078,7 +2078,7 @@ static int add_callchain_ip(struct thread *thread,
 	al.sym = NULL;
 	al.srcline = NULL;
 	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, ip, &al);
+		thread__find_cpumode_addr_location(thread, ip, symbols, &al);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
@@ -2106,6 +2106,8 @@ static int add_callchain_ip(struct thread *thread,
 		}
 		if (symbols)
 			thread__find_symbol(thread, *cpumode, ip, &al);
+		else
+			thread__find_map(thread, *cpumode, ip, &al);
 	}
 
 	if (al.sym != NULL) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index c202b98b36c2..f7df15c28bc3 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -419,7 +419,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bo
 }
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al)
+					bool symbols, struct addr_location *al)
 {
 	size_t i;
 	const u8 cpumodes[] = {
@@ -430,7 +430,11 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
-		thread__find_symbol(thread, cpumodes[i], addr, al);
+		if (symbols)
+			thread__find_symbol(thread, cpumodes[i], addr, al);
+		else
+			thread__find_map(thread, cpumodes[i], addr, al);
+
 		if (al->map)
 			break;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 56e08c8ae005..310eaea344bb 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -126,7 +126,7 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 				      u64 addr, struct addr_location *al);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al);
+					bool symbols, struct addr_location *al);
 
 int thread__memcpy(struct thread *thread, struct machine *machine,
 		   void *buf, u64 ip, int len, bool *is64bit);
-- 
2.49.0.1204.g71687c7c1d-goog

