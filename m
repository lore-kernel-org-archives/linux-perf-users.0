Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE231D9A48
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391507; cv=none; b=eewNIBP8VnxyN5EETdMUQ1x1DbjM9CQtN+UM+yhYTd6OMK5SifoVfQpEn0JCN369cAs9AcaWQNyTtk+RX0/rvQp8MIL05FPd+vt+2CY//jxazuPcQo8kZduHmClm5FJRPLgPjgUHXFU579VUuR2tlNiwSN5QWXwDZfxAzdSE/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391507; c=relaxed/simple;
	bh=y25ckykzTrgcp7uKXoDRtlAxki4h7V8dDeTjlO9sRvk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DUDD4zY7bBHarjsWSaxqKfbH0cCn81lJEw3YDFkrpb3FfRzOnSCUsVntmkNRKCxA30rHBIpEpzcHqsio5nNkgp2aixgl3XVvXCyhqwfp6p1zwRED0/tf/EPWBg+MX+5JG+HOtrqnTcu4PJwmyVi8SkTfOkUOvb+6iHMjmygwdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjE5j+bh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjE5j+bh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2ad1a3eb8so19303987b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 15:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734391505; x=1734996305; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooI5WebwC8lPxkLbqkwqH/UlX24ggq89B5YXrkW+MD0=;
        b=gjE5j+bhhX75FnGuaLyOS0p8wuX6KmZNGdxoXPKHbeIiEj9BVev447StEq8JK7Wcyg
         FRkBej2VGOxaGV8IWY+gv79BdPN/4Jr2+/FMxtt4jp3zRcscfItTHqKT87XyebbQOnnU
         fL8RFPPXmfm3EX5jAdLcCbp/Nf3wZCZgF7jTCWRXIL3VdKI7xjpY2Y0rSmsld+gV/CQZ
         DHaoqUzTWIFVJHAYkKo1U9vfRi3blTbSx1UslG90zFi+qXoggKqnd0dFLxuVBKiCHMDZ
         7zKmGOW4T5moUgRIgMJd3Rhb8+57uzfygLAiK3/1RaDflKzzI2oguVweVf8jcEUDdvJ+
         ELIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391505; x=1734996305;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooI5WebwC8lPxkLbqkwqH/UlX24ggq89B5YXrkW+MD0=;
        b=EXEgV+Uk9sAS9mkmg7xjiPJJSkBqcEdCGHbUZf/VEDJKn+zg8ThQ5acrvk4DMfC+8f
         Ib2lJISqubhNwk2Z4FvNZn29Vv4Eu4Om4nIGg/4fnKL7c69KGTbHBVomZJFWOD3pYr/8
         Qd99V+DuitiIZ0Ii/h8yQkzuPpQViBrk7zwn2a5m8gW6iPjB/cB0IhUxmYeLa3UUjHm0
         CL9kkAL4PNW461wV5tT+u3ZuwI775HiCEyQZlHpQekqyrYYzZrOR8jGWZe9BZldz/gQ8
         IsdOLkR6i/gbf4n/Tkxb9R310f1kBCKulc0GyTYggMdxF42Ck9lXGMo9BawmV4JNlH9k
         0mew==
X-Forwarded-Encrypted: i=1; AJvYcCX74HN96IS7S2v9A0AEOgU6jTsWEhSRf0IYiT6z1RSgpDmdPbGTq6DIm4jTHckjgf+Sw5DayqMvtJ6aWkQ4BRWo@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHMl7Sjstv8wZvuWuy0Gf5oV8trVR2YsqIm8qRldZbOYw5jhE
	81gkMGoBaYLEaanRSOCSXzAF6v/QVKlj9y3XrOX1ggzaljJpGN+ltvPvv/C6Nf7EEdZ1oe4hOE5
	uT3dYKg==
X-Google-Smtp-Source: AGHT+IFYn2r/9Sas9w9uC13l4oG5QEIJCFu52l0PBZLiUpYc1HqO/HPIx485CzZcSTm37QL8Dmp10afmR/6F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b850:b916:18b9:17a7])
 (user=irogers job=sendgmr) by 2002:a25:d60a:0:b0:e4c:35c4:cf05 with SMTP id
 3f1490d57ef6-e4c35c4d551mr3389276.5.1734391505378; Mon, 16 Dec 2024 15:25:05
 -0800 (PST)
Date: Mon, 16 Dec 2024 15:24:55 -0800
In-Reply-To: <20241216232459.427642-1-irogers@google.com>
Message-Id: <20241216232459.427642-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 1/5] perf cpumap: If the die_id is missing use socket/physical_package_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

An error value for a missing die_id may be written into things like
the cpu_topology_map. As the topology needs to be fully written out,
including the die_id, to allow perf.data file features to be aligned
we can't allow error values to be written out. Instead base the
missing die_id value off of the socket/physical_package_id assuming
they correlate 1:1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 27094211edd8..d362272f8466 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -283,7 +283,8 @@ int cpu__get_die_id(struct perf_cpu cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu.cpu, "die_id", &value);
 
-	return ret ?: value;
+        /* If die_id is missing fallback on using the socket/physical_package_id. */
+	return ret || value < 0 ? cpu__get_socket_id(cpu) : value;
 }
 
 struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
-- 
2.47.1.613.gc27f4b7a9f-goog

