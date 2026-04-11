Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F93CD8CC
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935100; cv=none; b=LlWJJMjEas5d/PPQEYP20bFUTIR9ZTu602SCK3X+RzJnAxw4gw81Zft9TaMBbuQeeqHvuLgz5/Lb2CGBngIwAM3Ed57s1tHSdnCmeYNKnbXtvWgYN5WycnFsFn0TttLHRjTpuBgXaMdn+jr+adVX+9zZ0Vidhacnn/7xqttBZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935100; c=relaxed/simple;
	bh=bF2MTsPG8O5qt3z4+q+wqvjiW9g2BEL8MEkV3/7cMyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YcfTQ/9NKm3KDUJzJixCuQ5F3zuoC90IU2KTyncfjM0Hq5EWk4MMaIV0rOTq9+XpY/xx3geJpM8fXkQ3ox6IkiyUI0XGHRA8ugpOXdLxVBKtZyPM3EezJHFHS4gxgTdYOjOWdzvvG3LS7EnCV+XmUfYeQm8zW3efe5LOTaz29Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WMn+yuLP; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMn+yuLP"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1275c6fc58aso3912622c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935098; x=1776539898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNvTyU3Q21vQ5oShsgnoSzW70om6RQ7VClowwcBZ1hE=;
        b=WMn+yuLP03CcpqgP8SOi/3210F2pnUY6ZYBb58six1gVOYFVuGHDeEj+rI3NeZ9sG6
         /5/vwocpP6jB/EHwd512M2afutDNd2NXULvpQEUwRq64yjkNY9lpw5qdLzRJLQz+uKLH
         F2iy+0cWvhrWfAK3HPg+A+7+MweHNLJrxjpsegA3VkTtnD0p/kV4PHYkl3Q4iEpYnzvm
         OE2bWnJ1MkDEbpvHlTcfg3z82xjRAGCAQk7Sg4F65RUkDX4oyBlUUGeOzLuFJZGPSHtI
         6iwmsLNFTRJf4AduOAGeEgprROLTEmRqCs6OX128IlN2jSppUYJ1xMVbwnMw9yGEjthY
         P+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935098; x=1776539898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNvTyU3Q21vQ5oShsgnoSzW70om6RQ7VClowwcBZ1hE=;
        b=Q2MGLA5nT2HdayGEsJPyD7C4iN8BYRIslcAgRfXp29y3QKZa8bBxUyuwSwkWU7F2hh
         /pBGcDBGf+IG2nrDZtLrTI6qB+Eo/hN2D7QAdiXHluhSHd8NO4D3E5CzafGW2CoT7viQ
         Vs5gSNZL3yNuazKy8RKCHFgZKEYPYFT7G6VSfogGl+u6QQA6iF+yHepRxNLTlz5ExQJS
         MhImUajt5od+chduaJ6E+wTKrSUipsKYZhU2ehrmX69O9onHIOVr+D2TdbHy9b14JTTs
         3do4+E29REMOyr3Icq51cP13N/q01JKt1CPKLFpBCyKQ5tmuUz5UMrwfZdB+la0N4Kh1
         +GCA==
X-Forwarded-Encrypted: i=1; AJvYcCU4idQhVLN5SciI3yUetJBuuxjgiMh99UyXlM1AYSyAtew3vTFp7XAZcuaNxCZMRdiAJniF+b4IgdM0aWNCWv6D@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgz4GQBss0pJJTwnu6bAvrIsDEGsKJBrMqY/f9DHgAMLloKh+f
	7AMPJ1BmkCaVSkwrijyOq+xW+sFERsoC5RZHMMNaadmsZgFJNzpwoM9WLot6xlMIN9Ek4I1vr+Q
	/38VQyKQ3jQ==
X-Received: from dlbou15.prod.google.com ([2002:a05:7022:110f:b0:128:e0dc:644a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd01:b0:127:3b1e:7e0e
 with SMTP id a92af1059eb24-12c34edeef6mr4817662c88.20.1775935097046; Sat, 11
 Apr 2026 12:18:17 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:17:08 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-28-irogers@google.com>
Subject: [PATCH v9 27/29] perf evsel: Add bounds checking to trace point raw
 data accessors
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

Avoid a tracepoint field accidentally reading out of bounds by
checking the size of read fits.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3c10b840778e..1e0bb4cb995d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3727,6 +3727,11 @@ void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
 		return NULL;
 
 	offset = field->offset;
+	if ((u32)(offset + field->size) > sample->raw_size) {
+		pr_warning("Invalid trace point field offset %d for field of length %d in sample raw data of size %u\n",
+			   offset, field->size, sample->raw_size);
+		return NULL;
+	}
 
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
@@ -3744,6 +3749,12 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 	u64 value;
 	void *ptr = sample->raw_data + field->offset;
 
+	if ((u32)(field->offset + field->size) > sample->raw_size) {
+		pr_warning("Invalid trace point field offset %d for field of length %d in sample raw data of size %u\n",
+			   field->offset, field->size, sample->raw_size);
+		return 0;
+	}
+
 	switch (field->size) {
 	case 1:
 		return *(u8 *)ptr;
-- 
2.53.0.1213.gd9a14994de-goog

