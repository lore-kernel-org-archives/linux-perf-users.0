Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CD384220
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633178; cv=none; b=s16tZM2nxcD34VS5i9rPeNb+NNmX1yOomEN6H/f9WHa/MZH8eGJZNEKNMD4v5V8Iie3fwWFcTaILU3rmBRU0IywzoCz4Xdbef3ekox3Bnfbpy1WN3UB9DaY9VHLMVVmQWcEVmNNCFkMRgqrLywITbNVPBty/bJ0eM1lko4TNrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633178; c=relaxed/simple;
	bh=z5Gm8UpkhzGnJ27VVWc0CU9w0UcHCjs20RTv0h8BR7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M8i2y7KFFzNR9+Ht7Wo1ma9obccYUPNk5ek67EOJw5O5Uc/lNTVZEmlXTDRJn0VMXvlbs9MFsrgl2WGwURTR1eXwlXSaByKzqYG1DRIAV3f5VTwhO6cDlr+y+F1Ii9xod5vunnn0fqPWUc2iSefCwk7P9xYEmq6F6qxqHx2gsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPKRGJBE; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPKRGJBE"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12bf9974587so28428281c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633176; x=1776237976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOsKDU8RUwSKF1sH7naQYX2bK1YRBMlsuXwoyHBl/l4=;
        b=cPKRGJBElqhXdY5RSPzS1a/KwrVG2WnveZOn+5IWfcEZldmYY2Lv9+NjbRGmiBKlt1
         hLGuRva/MZ4W53SSJX3zT2pORPcbp83FQc5McrLqLizIa369qwufWqH4rAQ5SWUMWXXI
         WjOwCbSfPWTwIGFp//M0xrKv/MKve8SzrBlbCxuwBaqgqUQYNVl3CiFNRQFWRup04dUM
         VQYMIn/GP7b1TIDBPGTR1AzcN/+M35hr0yoz4leVixCMW49vKzfKAJnmIJ9unjKBhddz
         GTY26PacH82oS8ur0a3gqhFeXtqRMy8auU5orlSNXneDYesTthR0dA2zgJ1BCzi+BafW
         Zkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633176; x=1776237976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOsKDU8RUwSKF1sH7naQYX2bK1YRBMlsuXwoyHBl/l4=;
        b=T9nLK7rLqtr6r33gu1xaIxw+oG14gQNh/YhQweGu5AYTXQUBZghDhC8KqERja+811E
         HuWolaiRtMXJna3VYSjnYQAkcYe8EOv0jfvWZsFMnq9uH+cBZfHcflK2dgvV704rduXD
         iRBvCx2W+9bleBO1DNfqB/0lmml1yb3RFEAKnXpYhe+NifZVAI1j1YW65vXhLC23VQOU
         vybOmKyxHMzYthi3EwF/dSNfhOxP2od7gHvmO8q1UpwC2vHiq8cFWOmZnY/La3RsFfif
         eAnOPVVDHhqh3YqFuRu2otHBgih+XvKCtzMwrjWtDG8pnujHHut7BOhtGm8k1zkREsQz
         TlBg==
X-Forwarded-Encrypted: i=1; AJvYcCWyhDeqsqNRQa6TWpSMTjUZwC7LVs4UKK01qtwSjGPh8U4Xbfw27zFhFxsYcGBvKZHmP2WNAL6quWXWiS4UkUGE@vger.kernel.org
X-Gm-Message-State: AOJu0YxttCx/dxmHoqfsbHeE4Mdsfk5DWuD6Q2dHIiBN8j0fszdrHN/g
	vytif16ieAdgtnqPcE0yeGwlJOthRnPmdFwM0g9q45AI/+O+HkG/zP2eGWD7as5Edmx4roo2y07
	jgsEuGfFDzQ==
X-Received: from dlbep7.prod.google.com ([2002:a05:7022:1087:b0:12b:f959:6e78])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:221c:b0:128:d438:cad
 with SMTP id a92af1059eb24-12bfb74c7ecmr11678459c88.18.1775633175497; Wed, 08
 Apr 2026 00:26:15 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:25:42 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-5-irogers@google.com>
Subject: [PATCH v7 04/23] perf kwork: Duplicate IRQ name in irq_work_init
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The IRQ name was set to a pointer within an event, making the lifetime
memory management most likely a bug. In other instances the name for
kwork_work is allocated, such as in evsel__softirq_name. Match that
pattern by strdup-ing the name from the sample.

Make the return type of perf_sample__strval a "const char *" rather
than a "char *" as mutating the contents of an event through the
sample isn't expected.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c | 2 +-
 tools/perf/util/evsel.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index f600037ee460..dceb9b79aa6a 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1018,7 +1018,7 @@ static void irq_work_init(struct perf_kwork *kwork,
 		work->name = NULL;
 	} else {
 		work->id = perf_sample__intval(sample, "irq");
-		work->name = perf_sample__strval(sample, "name");
+		work->name = strdup(perf_sample__strval(sample, "name") ?: "<unknown>");
 	}
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 927e5b4756cc..cf495829dbb0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -376,7 +376,7 @@ u64 perf_sample__intval(struct perf_sample *sample, const char *name);
 u64 perf_sample__intval_common(struct perf_sample *sample, const char *name);
 char perf_sample__taskstate(struct perf_sample *sample, const char *name);
 
-static inline char *perf_sample__strval(struct perf_sample *sample, const char *name)
+static inline const char *perf_sample__strval(struct perf_sample *sample, const char *name)
 {
 	return perf_sample__rawptr(sample, name);
 }
-- 
2.53.0.1213.gd9a14994de-goog

