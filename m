Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CDF25A326
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Jun 2025 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749276803; cv=none; b=UkJ1Wwt2UJD5h3sVT1Gbpo1dPe/KucJXFV5DiXZVCiKQ70odm6iI02VY4ccJZ4nTXb00GpZq1/EL90Dbdlp1MDMAJsOVb9RKSTbGm0webEnjfTs1DLa1gamyFjctIMzWYEOxzpYnWQ0zl41gnj7yHf2ZhRRMdCXEFm2uSxzZXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749276803; c=relaxed/simple;
	bh=NxEw6+f6G5uFWkL+H2aWHdkGBgTgAD/5Iiu7vO2lJZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MlqXJshhh3mDisLMz6m0DdQS/j7W8TEfog6R8VE2pOsxSJ7RgN+mMdnC63cDEGMhJDwKfP0Mfdx/jnUyV+VBA1fwpjAhVib3nS/1Q5t0H2iy3uzjEbFQn8DsztdYjPN/QPSiyDhocd9t2zxeHFDGUcuud3K6ywUZN9Vm2lVqtf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5IEezbr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5IEezbr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747fa83d81dso2375488b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jun 2025 23:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749276801; x=1749881601; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0HIosMaj3PV5olqJjY+MHC2f5HBe0N917JAphCPE10=;
        b=Q5IEezbrAwORKEcHjDyd7V3CIrU9KCNMWOSaF0PRS6crsutjgUkWdcrlNXn9uvwwmq
         iELVI5xR21cpgn8wogWV63AVsQ+LbmlYJvhxzYAyHGZTRgJ+MN6OYbwm7xw/4I06p9er
         xunV6O+Wi2EIG3tk3fPwo45WPCvklIRzNx7KnrbJkX3tj82WW7Rt6ObfQDqjIMkLcUPD
         ugV7elz1x+lWQa6tZYXRWEs5zpKcfiNMq11UEPo24abmaRuj2jMj3c04CZnPWQlqUmo1
         kZPcCtvBOBoghpUWIlSnxyEYcTvkwx9Ik9F2GSo6Z+DNLBdCcUaHYJxwjjQm57+nLJpa
         DR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749276801; x=1749881601;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0HIosMaj3PV5olqJjY+MHC2f5HBe0N917JAphCPE10=;
        b=JoVcDRkekMgjd6ygy+aYBmTOtSQT3JbAsc1Ls2dDA/a/W1uXAFR/dJ2yAMruGHkCNi
         SJ9n3H8sQ2rKGyvgf14mz6yajqNTPIuryVexpP4XXpOFN1mw8kxkdkfXiyuu1lsMb/vq
         P8nbwW8KEmfxXGM3n3+899pkcevvRZMbwkmrrxXFAcs6GPMUliqG7NwozxYNkzLh4xsc
         oJbjckSUJfEq1YRRj04GGj5P7hhZj9Y+t7hcEzjiHptNRx3ULOoKGgSdtnnItljjSrxd
         onydt+R8fplbb6pJXi2/t5RoQ1j0ed+Gs66RHbia0Vt30cqkNtB1FAsRY1MdzhDaLaLX
         InSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0eGqqrT+eQxJO94os8YEuje00tVrHoEJvo+6nwDpUanR/d6vx2djA5W0GscNR5R7z4MRPgN63z8N3qpMGz9Zy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9wg33Slt5JdmuAVwgU51ZtgC5rUl8s5xYWzib8a8PugJGE5zC
	dGq2mp1kj2Vmh1Lx4Ogoieso1mOZgxdcJWhHu+2YYNvWiIzRbavHPPx7Ang0PPUBcCc+c5T29pm
	+ZeTB6y7CeA==
X-Google-Smtp-Source: AGHT+IHOS57SYtqmyar91S6b0MesD/UsSr8ImYsRFlvuYMV+h+3rM+zsbSohczJjZmyefODVD9k+Gk1Srxil
X-Received: from pgct28.prod.google.com ([2002:a05:6a02:529c:b0:b2f:9d37:5753])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8b:b0:1f5:a3e8:64dd
 with SMTP id adf61e73a8af0-21ee13bd873mr8707034637.0.1749276800899; Fri, 06
 Jun 2025 23:13:20 -0700 (PDT)
Date: Fri,  6 Jun 2025 23:12:37 -0700
In-Reply-To: <20250607061238.161756-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250607061238.161756-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250607061238.161756-4-irogers@google.com>
Subject: [PATCH v1 3/4] perf header: Display message if BPF/BTF info is empty
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The perf.data file may contain a bpf_prog_info or bpf_btf feature. If
the contents of these are empty then nothing is displayed. Rather than
display nothing and not account for the file space, display an empty
message.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7798435ab5d3..69e4f6aae293 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1814,6 +1814,9 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 	root = &env->bpf_progs.infos;
 	next = rb_first(root);
 
+	if (!next)
+		printf("# bpf_prog_info empty\n");
+
 	while (next) {
 		struct bpf_prog_info_node *node;
 
@@ -1838,6 +1841,9 @@ static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
 	root = &env->bpf_progs.btfs;
 	next = rb_first(root);
 
+	if (!next)
+		printf("# btf info empty\n");
+
 	while (next) {
 		struct btf_node *node;
 
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

