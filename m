Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD5292B2E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043415; cv=none; b=Gn+oIFUclJaf+XMpwpBjFB7/8i4fKPPxFGPjsD2ReQio7o8fVCkV4LBDuIlR/kjTQFiq+qZOHOfRPE+msonOTZTGwpKhKHbDhNP5/Kz8gViseivNYoUfg00Omj3nz4AxUAaDaIfimGaLE+xTtwQvr/b7CrXXiqOPN4SKDmpS3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043415; c=relaxed/simple;
	bh=TORHr2hwj56t1K+9uUsjLQo6KHkuVY+QoSlV3b0luUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G1pI7JAb+F0lMlbxA5m+a0t6HKFJpMSCuuEIJVxnT6EH8xNd0wlEdo0mtNOYvpndx1oa3jOeUu3ITVKaWrIJvVrvYHu6Z5KjSIeBMdfW71HByBsfDU1XxYb1lhKJ3DZxg0C+a+OceWLMBZKxHe/Q7NvPSp+iLyffWYYkas9HdCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TAAxnVc4; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TAAxnVc4"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5539472eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043413; x=1776648213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=TAAxnVc4OZkPaYoxtwsq8pjbRkohZPjaUf+DqnioPZm0/PxgBD+1fY51boY//4Y5l3
         ljiqVGR07f+oW7srt+tKz4JzYQCX0FmN5Iw4ilK9sLsocHZJto0uyvvcbkH6xbJybBok
         e78kMNCDi/89sBuutnNivPY7CSgOXuKfDeccThlEoW22gmbsARh46clTJ1QfCxasjkII
         8s9h9WqJ8VNGmZsZreJ5cWeNxtA4VArw5Ac08ES8WAAkUIG302T1TTQDSmor+HrREeEz
         cdjY03JMzydwJTJdaXqQSNv3LPzAZx3c7FrsN80tHmNwIpQeQOCwTe440aKSi5+QTShF
         BGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043413; x=1776648213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=XEvqaGuPOjiuNqR+GK26lF9/WjtE1BBUAEkaxUwzIU74q+1DuM9316k5Tp+TGTf8PC
         4t/tEqEWL39gEDEzrcBpTAYnf2PE0Q31upaHiDOI8/cuvc0yxgw/3ivyu2kiAs0VnDWG
         MqH83Qc1nr4q8Q4EEDFuFja8qGfOerR+CDapqfa1BjTnddqq889jKwhcIlxASwxN5nX+
         gqgK3Y8guEKdUGCdU18eX4bz5Aj+sQ3JUnZUXyrTlrVhIrnC3Lz9D8AUJ+Mj81+Ol0Uh
         2iR7gSdwZ5kXZQpPZln+deGoA0+6Ye1Nggu41mWAsARb3vl9Yqdn48rbm7ytaZPliUUU
         EhQg==
X-Forwarded-Encrypted: i=1; AFNElJ9hw5dPG/JoMiINCBy5TMrxqneT6cu7KOikBLq7W9biySUezvpUWgGjOa3xHItB6gSvYwSJIl/CuTudr7GCL8DN@vger.kernel.org
X-Gm-Message-State: AOJu0YxicZJXT4yL4EBOD/TZI7bO6HiXauHHviUo24mHzmzX1JKzWgxf
	ZnDHlYz9zUvp0Z8vp37GrMUXB+X3wk2XeiewAkA0jm8OSWCPBVk9Ez2P49pjTbrkS2SicTr0nrd
	U0j3iNW0Mng==
X-Received: from dycsd9.prod.google.com ([2002:a05:693c:3109:b0:2ca:f172:3f06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6788:b0:2c4:acef:292a
 with SMTP id 5a478bee46e88-2d587d82e73mr6443685eec.12.1776043413071; Sun, 12
 Apr 2026 18:23:33 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:22 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-29-irogers@google.com>
Subject: [PATCH v11 28/33] perf kmem: Add bounds checks to tracepoint read values
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

Avoid out-of-bound memory accesses by bound checking order and
migrate_type when coming from page_alloc_event and page_free_event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index daf2272c7337..33585e353efe 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct perf_sample *sample)
 		.migrate_type = migrate_type,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
+	if (migrate_type >= MAX_MIGRATE_TYPES) {
+		pr_debug("Out-of-bounds migratetype %u\n", migrate_type);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
@@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct perf_sample *sample)
 		.order = order,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
-- 
2.53.0.1213.gd9a14994de-goog

