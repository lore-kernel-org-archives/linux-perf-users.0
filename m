Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7534846A
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303965; cv=none; b=o2IjOp1qJQWw5YdVxsVtxuug7Kg/BGTeYqoQoh3ohgIFQzo4EABD2bsHru+c6kw1Oey36qewdnbnYgn1P18RDvFXOqwIQeWvtJgP2zKxubkRovJTwR9Kz7lB8Fx7IQpzoGic8O5n4/8SeJ+64jOXPBcf2V+g7Y9UXB45F24C2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303965; c=relaxed/simple;
	bh=VlZFm0Yk8ISb0pxSrxuZ//RNGTFJjRFRiiCBUZTANyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z0i+S2NYa1tVM4/eFobDMYfSw4rEXLT+8cGuO2tZ7kODTlFqrrrleFUfGUQ8TAeapAhrp3RmL+fwRDr0R/gLQQ+WsEgoACGWzBr/ZBMTL0LU9ee2II1tl8J5zAgNzMR68DoHqTfCnk70CHlLGYGx42kF0iWHlJ5rdT6BuXN/Jas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uj86S5z7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uj86S5z7"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc977e6aedso48320355ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303963; x=1779908763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHexrsT95m3I5JIhveCRqz5npNXc+/YhQgy7cTcTZJk=;
        b=Uj86S5z7WviiKZEUVYjSDvU5JjqVyjDgheHKNn6G5kr8Fc5FQReKqwFPXpnaFyvaZ8
         sX71Je7ZtoyC0/iS+jc1f6MaNKtViXm5iYqk0+kn0LUyUYVMGjlq2fix9ZdR2wwnWVQs
         QISOZj4Ad5+ek6Y/DNBSie+ldyimjxsu63Tl/ey6/j6OFMWS6u4lif329cbiGP9xRzxd
         KnsnEPcW7m36RHZjbiOnjVsFr2y9vnRXxuPchGQlNjWFe6NNrra1i01DYqFbpQb+nUrt
         85/OELugVvwKlkqn5gVDXYP7kFSdD8YdVxfxm6GnmZbws0mBMYKHn74i0RjE2heQeAig
         55Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303963; x=1779908763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHexrsT95m3I5JIhveCRqz5npNXc+/YhQgy7cTcTZJk=;
        b=qNHuDUIG4X3Rn2+Hf2QQLm/toBNTt1437tcGREP9Dp0N4KuGkFXFqcqQnAiZZtIDrW
         /RolXoCiMBM8Ln5xih288oH3Th5dnIaILlCeGScINECE5T6wnFj0F3fItAn8NrkjZYRC
         IQOCsEjJ6dsBxcq+RFNFNSdTfCVGLj5K/xJ2QQfq9Tb/tngTOl6Cr7bC6blEHbcDtIei
         C4eWPo3IK0oxN7dY1kIs4dT4c+Vyq6z5bxcR4pthQ+3g+Z7LModY4i0ILLqcHW7ht3iI
         ogsLwwVrhYS6WNgPIYnAgMRQ7vzWu3pLdhzybh6dntVhU/fs7YnObNz0npacNpvGMI7C
         kuQA==
X-Forwarded-Encrypted: i=1; AFNElJ/P4YHsNTOJBBwA4UduIpvJWosFMf0dSGCLKmp+Z8CCt8ddmr9HFp4Wv4ulisERR2f9NM8vXGhlXPrurYCDEiGo@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLd9mm+zGpOZCY840ylYAWuJjIuYZrnxOmLLE6qFjopl9XceE
	0XAUlXtPWG9SwI8u1P4PTnaq5NJvsBJ2izzVfbxi2D4aI/xdeoGpMZ4UuN6guounvdSNveSXX4H
	nv+jdBkJsTw==
X-Received: from plom12.prod.google.com ([2002:a17:903:3c0c:b0:2b9:eeb8:3e6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0b:b0:2bd:ab38:d6ae
 with SMTP id d9443c01a7336-2bdab38d79emr202901525ad.6.1779303962519; Wed, 20
 May 2026 12:06:02 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:16 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-11-irogers@google.com>
Subject: [PATCH v14 10/32] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 11c7eff92b95..973d97af8501 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -789,9 +789,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 				    struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 
-	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
 		u32 count = event->lost_samples.lost;
-- 
2.54.0.746.g67dd491aae-goog

