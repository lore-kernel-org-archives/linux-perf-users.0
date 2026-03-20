Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DF364927
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046574; cv=none; b=XNWpOo5mjRom4XAj2K4v8n6eX+OeCB2YetaarJAc4GZWPnqtgswkPkVL3gaNuKFxL6ukmfsNFNB5ZIDM2B/V403vf2rB/a/v8WQC4z7msZ0ak6C3RGhV2u67D/52bN7Sdij/YPHnW21ExWzekKcgYKYIV4fRKXeuszXDA0iIggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046574; c=relaxed/simple;
	bh=caFaveRlFlQD4hAfeu+vlhnCBOLYaA5vwm7Q1PdcyUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OY82te4bBrHR9YZUrCn/TgDRQjG54DKsQ+gllqMhGSls6ZM+LWGVwJbAGaWsuRPTHNMkfZyTmKVepD3WPm+nW0evAfDj/gIJ9coTKUh5DyDmmZlrGrPq2cwT3D/UgFJMq2/BzhiCN7dQqwXBvXtcV0OHjOWFiI6AB94VaaqX+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whixLs/Z; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whixLs/Z"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so1007799eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774046572; x=1774651372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OH6vUQoCEUyRPcoyCAN2rhCO7Ouo2QVMCa+fQ0uLeM8=;
        b=whixLs/ZfV+AaCMH+vn3XI5O8XMlwreR1+ip+q9CErcLvca552IniFn1ysgbkyUgIT
         a3n63/74WAHk/flvK3RBbiORFtAoFl2AuZDm8UBXNNjFJL3WZ06K11e+CGe9HJNDFHZy
         C4S5/Ce/HyPwfWusdNjr5AX7hlNWwJpayO4FqDWa4pyexegovfqxpGhe5CoA287hyfml
         NN2c8e19tDfuhcVibG4pLcvfNyDVWxmtk92vx18igJQ1xht+xjYgnpKTOPtzZOL2fp5A
         T2MQg1h8DgvGhUtDLjLRy7BM9SSwYcgx9wxaRLTRt5dk+7MitZGhzm/6wkKSUm+zEd4H
         fKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774046572; x=1774651372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OH6vUQoCEUyRPcoyCAN2rhCO7Ouo2QVMCa+fQ0uLeM8=;
        b=n1jw+qzqDMUhh6PutdjGKuMiRt/cbTTIxEICTkx5lI5DUW+F+QQUICTbqgJDwekNuO
         0FKnkQ5IHSQBJAqwQBVvC3422J8BKwJU2qDyQ2eT7R/FWmUVv9QXH7d5hTeH8GU7zukT
         nsXqJyuRzKGjw/YMwGBQwyoF+8oubgMofumg4bUHdiHslwYNz7uXa9iYv2TDJayVXOzE
         JnSt9yC2iIk2QNqgNelUN2SLMV8Vq6DGOoZsxnUH2G/5rjonjqXwnlrYZF04GN2bMCbc
         DG0W4JcXlnJPJSkT4pocesMg/iqWGYEKnZ/g9Ipee7VDD1nrrB5E8NzJvrBDugf08OXC
         87Mw==
X-Forwarded-Encrypted: i=1; AJvYcCV4cOFJ4/viHKGrWKchErmC484eyEpPq7WnE1NNUnC3YmXNkeGvjvpLuCifqZzlN6NC6lsImFRRg2AlxD0cl3nm@vger.kernel.org
X-Gm-Message-State: AOJu0YxOczXAcJU5ClzPQpj9/3ECbMgvLBPibJJS82KEnKShDOFioY0a
	UfnUUIps5HnPP1IcSu7tyWi9D1FhMQ54Va1RRiTyF6nTVFNRic9Iqes5Uh9ElfIsMe1mB2K4uD+
	UKboSyOTH3w==
X-Received: from dled19-n2.prod.google.com ([2002:a05:701b:42d3:20b0:128:deec:2d48])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:260b:b0:128:bae0:e044
 with SMTP id a92af1059eb24-12a726f5b62mr2011729c88.30.1774046571978; Fri, 20
 Mar 2026 15:42:51 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:42:48 -0700
In-Reply-To: <abR-4crLwfNW2R7N@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <abR-4crLwfNW2R7N@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320224248.536449-1-irogers@google.com>
Subject: [PATCH v2] perf build: Revert "enable -fno-strict-aliasing"
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ebiggers@google.com, irogers@google.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 55a18d2f3ff7 ("perf build: enable
-fno-strict-aliasing"). With (get|put)_unaligned_* using memcpy
-fno-strict-aliasing is no longer necessary as memcpys are assumed to
possibly alias.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a8dc72cfe48e..1d3dcefd8c95 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -19,10 +19,6 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
-# This is required because the kernel is built with this and some of the code
-# borrowed from kernel headers depends on it, e.g. put_unaligned_*().
-CFLAGS += -fno-strict-aliasing
-
 # Set target flag and options when using clang as compiler.
 ifeq ($(CC_NO_CLANG), 0)
   CLANG_TARGET_FLAGS_arm	:= arm-linux-gnueabi
-- 
2.53.0.959.g497ff81fa9-goog

