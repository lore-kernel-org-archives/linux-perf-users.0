Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140380C13;
	Tue, 24 Sep 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168900; cv=none; b=BnisL3nHYes+QFAHABFz8i3Lwduf6kC/xWatH4QwFH0bVBNvyY4ODWYmwkGXRP7Lhq1XprXzgwM8KOYKPI6LIe27nEL8v+UTPaKfbcSSM9OahN076pfjChFfQWbawsR5lFMV7ekQKHZ4TIt9JRUm5vhZ1E+90CMojwuEHyl186w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168900; c=relaxed/simple;
	bh=b3ifNtCiYW5//8iWkr/38z7yeNE8yDDPeoFvn7XD1bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UweaCEQlJw1M5ct4eX9ZyRh9Jm/H0wM36T00MlYloxBqAQhvPxqNWACO7j3tf/3zoddkBlY7TyMK7LWV326nZXD1mNOwiwgauAHdHSoOQeENkwcu678vW62F3emKOyZw9hUvBX3/1DuqW1lvnehSrYP9GgZP/g36aIZKeb/7jRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2oVUGdC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2oVUGdC"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d24f98215so708800466b.1;
        Tue, 24 Sep 2024 02:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727168897; x=1727773697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+Eln/8BTIQlpH7HVK7SHuQ+hNoExFv0R1JgGjQKVcM=;
        b=Y2oVUGdCPwk8esKOXubAxGR5VVn+rMkHk3QPwNmR5K26LlrEzqUWQsTbW6U0Dpptqx
         CZjkIMRus6cUtDcagKnKFABchfu1/E9gOq+LivZTcgjLjtE34AUcPvl/V/yl2WJVV91n
         DEvkT8Uo9QHU0oAUXhZJm6zQoSxS8r6zRKKSVw4Ebl/4dBqrh0gG+hIlJPxkM/I85MBz
         JDttNMdpRKNGTiLB9rVRZ0YBiu8kpqPIozAT1Ofm7/R5b4k+aUf56vKSUNRg4teXA5r3
         mYjKjhD1ux7J9gCYMI+ocWEL9zBLetWKTViBn9UBjDfguo/fyS0oURQABmkwu0DMS6M6
         g4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168897; x=1727773697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+Eln/8BTIQlpH7HVK7SHuQ+hNoExFv0R1JgGjQKVcM=;
        b=XOIXhPpgq0fnROjtCfDFs2e4q5rpHKFfxyNrBHxaq6gqd3lHycwOsPA0ld1dtKzyr2
         lOtH0CU+x8oOcYSnLnYGNmrByqqWqlayAfR3DxtHBLtppcAjYSN/RJRwJH0A3N9AOOcX
         uR7RadPtGz/HsXKFx/9cBclpM+AKJ2ul4JTDT2AAtS1LChCoplqXgjxxxFi68mpuoFEC
         nRJg2TJk4Otq/dLVFM2kOoaw0f06mZv6oXVmlAE74WApeOFsU2BvKaTURQjQcNVP7n5J
         VhgFoEuxrrnTvH7lhqri6xk8rTspYAJq+IFRprBjEqAn17gDCnpqLhbvkK/ftTOwPJsF
         rMYg==
X-Forwarded-Encrypted: i=1; AJvYcCUFSG3GbEo02RExvJsD9c1LH9fg4JuwV1z1OYOFBMO0scp1+dSllK+NjeyEbIwysUNIrBIjd2PtlANtGI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTpDY34VPUk//kXu+/JLrI6QHMoHqUwWxzi94rTf2Qp2+g8bM
	eUvnt3jvhAcxITR9pKlTybfrGnE9alsdDSp6oD2lKOl4pitwnUt2o39C69Nq
X-Google-Smtp-Source: AGHT+IFqUBQOchvS0kxszZ1PO9FDqCY/icF3y9f4Iiu32fEva1IUlApaVBHDZQr1KKVFlab/Nmq7HQ==
X-Received: by 2002:a17:907:2d92:b0:a8b:5dcf:493e with SMTP id a640c23a62f3a-a90d5109c22mr1595551166b.58.1727168896327;
        Tue, 24 Sep 2024 02:08:16 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930caf87sm59240866b.123.2024.09.24.02.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:08:15 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH] perf/hw_breakpoint: Use ERR_PTR_PCPU(), IS_ERR_PCPU() and PTR_ERR_PCPU() macros
Date: Tue, 24 Sep 2024 11:07:13 +0200
Message-ID: <20240924090813.1353586-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ERR_PTR_PCPU() when returning error pointer in the percpu
address space. Use IS_ERR_PCPU() and PTR_ERR_PCPU() when returning
the error pointer from the percpu address space. These macros add
intermediate cast to unsigned long when switching named address spaces.

The patch will avoid future build errors due to pointer address space
mismatch with enabled strict percpu address space checks.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>
---
 kernel/events/hw_breakpoint.c           | 4 ++--
 samples/hw_breakpoint/data_breakpoint.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6c2cb4e4f48d..bc4a61029b6d 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -849,7 +849,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 
 	cpu_events = alloc_percpu(typeof(*cpu_events));
 	if (!cpu_events)
-		return (void __percpu __force *)ERR_PTR(-ENOMEM);
+		return ERR_PTR_PCPU(-ENOMEM);
 
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
@@ -868,7 +868,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 		return cpu_events;
 
 	unregister_wide_hw_breakpoint(cpu_events);
-	return (void __percpu __force *)ERR_PTR(err);
+	return ERR_PTR_PCPU(err);
 }
 EXPORT_SYMBOL_GPL(register_wide_hw_breakpoint);
 
diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index a2c831e89ce0..fbb03b66dcbd 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -52,8 +52,8 @@ static int __init hw_break_module_init(void)
 	attr.bp_type = HW_BREAKPOINT_W;
 
 	sample_hbp = register_wide_hw_breakpoint(&attr, sample_hbp_handler, NULL);
-	if (IS_ERR((void __force *)sample_hbp)) {
-		ret = PTR_ERR((void __force *)sample_hbp);
+	if (IS_ERR_PCPU(sample_hbp)) {
+		ret = PTR_ERR_PCPU(sample_hbp);
 		goto fail;
 	}
 
-- 
2.46.1

