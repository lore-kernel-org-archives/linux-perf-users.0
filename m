Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E813E898
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Aug 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909155; cv=none; b=gtdRPhggtbBIrW8BP67u3AcA4xX1IiN1JwTjsGi9mxMN1LuiA+k69Xe23tKcVW+ZSiKCj1HzCisBM2xidKrX6RwPHq7XMvntExziVYBY+wNcDoP6IugxmUZ0a+wAX81ZKtAokALpp1kJVmZWmVlW1xw7hbx/cVKA3v5DLd7Em/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909155; c=relaxed/simple;
	bh=4XYuTBlR6hYwFS1ueXSOzYaxTcNFVQsqr4/c3vmzres=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fDk+mOZE1kMMfyRu0O0XDhdvDL11hsUJq2Tk0JIrZOnDEb1PupUJKRs8Pt5SJkvmNkLceVPc+Agv0ss/B3hBU0JMk7IYtJxQKvXMTer/e2zHqYA81UiadC8al+2BvERilbvk4f/dkjJ8yT5XGk1znipB508b+Qr6Obur9Ll4RAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYfV1iqs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYfV1iqs"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458027f67so58164795ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909153; x=1756513953; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ijg4Ede0urfZx4RJgifti/T7L7s4uVTkA9wvhJHnqsE=;
        b=YYfV1iqs5pb0OBg0tBJiYzaV4wm3vm9zrC73Lq274G2giRvpMbXLcptuXKZXu9VdNj
         6udt/JC2LhZQgQIGqlQh4s73gXRQf4O+eIKsCHUietmCvVI3pmsH/8K5s0ebOfibFg3s
         pPIHikj9h4lyt+0l87fgN7r6hq+zcelrzFE0q2+eP0AY0lTgWgXISjQgbDUR8BLr5LU8
         g0fc/bLcmqIT4QwonTwRFA3r0RrZeHo4+MqLEID/gV+S4VwSrxhT+iGLqj+TOVrFBNX0
         H/cQtApBnxdBFSHA5ult30m43KtzsFygZEs/WSv44LRlsSkYVpVjKpLqjjjAodbkNAoC
         G6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909153; x=1756513953;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijg4Ede0urfZx4RJgifti/T7L7s4uVTkA9wvhJHnqsE=;
        b=P8X/kDe8IDvnnn9ZVY6B6Hw29LrVTPfw4So9WNAhpweFGPmWgPrKftHeu8xinU9xvx
         6aTijJ5EuWqhdF/a4dH1sLCsootGIltObOXmXx2tzIodR7UPlMZ5qgsk/Us+eKNysHbS
         QLOy7s4SJALgrv/t7UN5Ctkio/HT+Bw14UloOFOt++au8aXr09IchtuVA2mDyoT6p7Fd
         VU3nozTDcda27LFnXluJI/8p/UoMMAfIUeQzOZB5X3mzBP/CGUv0wmQqvayhQ1M02UQ7
         KOuOgZWLUsPrIs+2Ey+be4g4gutJPoXqAdfu+MzZ82TuiiaWM0Je/VWiA4pmRhzMTCRB
         j+6w==
X-Forwarded-Encrypted: i=1; AJvYcCVNlZ3+5ozBObydTAWtZch6zOpbo0zTJdWAcshpkYEX9dpY32Y8ebtdi/Nh7O+MHDzaHKZgRnU0koSizuA94BPD@vger.kernel.org
X-Gm-Message-State: AOJu0YxafjNJTnCOZjpSDikNSovVh90X47qfAZ1n9uw1V5huwHpM/FO7
	lay1XQV1k3QzayOZK2/bLW+W9w/iBzYugJwqeIHTJf5Kjssl2ww4X8/dZk+JlmNeu8H/FStc47h
	fjUwOn5DViw==
X-Google-Smtp-Source: AGHT+IGMYeCxsgrlwx1si54aEYiTjcsFA8gfzIiUxjxIYcOIKjCABHao1VnvVTFQKEPtCEduDnI1c7IR/WiK
X-Received: from plcr17.prod.google.com ([2002:a17:903:151:b0:240:285a:2adc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54d:b0:246:571:4b21
 with SMTP id d9443c01a7336-2462ef49e52mr64510395ad.58.1755909152887; Fri, 22
 Aug 2025 17:32:32 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:31:58 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-3-irogers@google.com>
Subject: [PATCH v5 02/19] perf map: Constify objdump offset/address conversion APIs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make the map argument const as the conversion act won't modify the map
and this allows other callers to use a const struct map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c | 19 +++++++++++++++----
 tools/perf/util/map.h |  6 +++---
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b46c68c24d1c..41cdddc987ee 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -513,6 +513,8 @@ void srccode_state_free(struct srccode_state *state)
 	state->line = 0;
 }
 
+static const struct kmap *__map__const_kmap(const struct map *map);
+
 /**
  * map__rip_2objdump - convert symbol start address to objdump address.
  * @map: memory map
@@ -524,9 +526,9 @@ void srccode_state_free(struct srccode_state *state)
  *
  * Return: Address suitable for passing to "objdump --start-address="
  */
-u64 map__rip_2objdump(struct map *map, u64 rip)
+u64 map__rip_2objdump(const struct map *map, u64 rip)
 {
-	struct kmap *kmap = __map__kmap(map);
+	const struct kmap *kmap = __map__const_kmap(map);
 	const struct dso *dso = map__dso(map);
 
 	/*
@@ -569,7 +571,7 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
  *
  * Return: Memory address.
  */
-u64 map__objdump_2mem(struct map *map, u64 ip)
+u64 map__objdump_2mem(const struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
@@ -586,7 +588,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 }
 
 /* convert objdump address to relative address.  (To be removed) */
-u64 map__objdump_2rip(struct map *map, u64 ip)
+u64 map__objdump_2rip(const struct map *map, u64 ip)
 {
 	const struct dso *dso = map__dso(map);
 
@@ -618,6 +620,15 @@ struct kmap *__map__kmap(struct map *map)
 	return (struct kmap *)(&RC_CHK_ACCESS(map)[1]);
 }
 
+static const struct kmap *__map__const_kmap(const struct map *map)
+{
+	const struct dso *dso = map__dso(map);
+
+	if (!dso || !dso__kernel(dso))
+		return NULL;
+	return (struct kmap *)(&RC_CHK_ACCESS(map)[1]);
+}
+
 struct kmap *map__kmap(struct map *map)
 {
 	struct kmap *kmap = __map__kmap(map);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 9cadf533a561..979b3e11b9bc 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -133,13 +133,13 @@ static inline u64 map__unmap_ip(const struct map *map, u64 ip_or_rip)
 }
 
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
-u64 map__rip_2objdump(struct map *map, u64 rip);
+u64 map__rip_2objdump(const struct map *map, u64 rip);
 
 /* objdump address -> memory address */
-u64 map__objdump_2mem(struct map *map, u64 ip);
+u64 map__objdump_2mem(const struct map *map, u64 ip);
 
 /* objdump address -> rip */
-u64 map__objdump_2rip(struct map *map, u64 ip);
+u64 map__objdump_2rip(const struct map *map, u64 ip);
 
 struct symbol;
 struct thread;
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

