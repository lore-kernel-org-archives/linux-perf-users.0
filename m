Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C041BBBEB
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627345; cv=none; b=fIabT9HZPczl9sORHU+G3Rwr205EjTvWhEvurJzo/nm+nak8TfmYFMyrA6tsI77VE8zz+ZcuVD7sD/p9ZRQU3exPGTEpFhuUrzwU3x48sDgvfoIYvoYH078fkgGl7RkSuxi2ud5TmZODvy9ESfisoub6ZjHrFkuYQZ0B21vOAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627345; c=relaxed/simple;
	bh=77DvPjJOE8YVhFqcYZtmq3ZxesWV6FJBeLhZKcobVC4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mhdkBpAnr68qkchaxWY6BH+e3O6B3EKgPiW7DnjBr00miqsvXVnW9H+4+nxFEhnZXcmB/uCgg4YAQVvQy+iUvOa6QmW3BueF+DOqGRwGhUdmO48gLNiSWFl/8aKm6b0whXmm/QgRWCzAvDh82JNfgFMHEs0xrejzWxts2VhIAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/fXrX0s; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/fXrX0s"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a109984a5so6251035276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 12:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736627342; x=1737232142; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfH9HlAuyd8abaGrxIbCm5bj2ItUHUt8cUtdtmcwTgA=;
        b=A/fXrX0s1V247x3n7zFrqvIMOLK9e3BTudDSgX1/wXNgnkx8ERxhh6KHGGmxgkFWUv
         eiwyZMS6ng/v+0x4kctWledfmHTWTG2Dq06QUvx3QlIOuQqRer5tOm0mgyzOJe7YS5oL
         PShpvuCN7hj7KQylWVJwJgnSit6BbEkjwONkqpkEPsonR0DZGYeVC5tsmztkXGfcMyND
         qwGPsl2LtafSVWLMwKoTuIiPMdWDBPnWR2YpbL1MRQvb9iWu4Aamkse3yOzeq9hDzgB3
         zCu+3UxwG5cocNXFmJKzLpSe3/ZdDGm3ma6FAuyL0W4i3gGx7q5CDRJ22Ymf8P/HvTDi
         LwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627342; x=1737232142;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfH9HlAuyd8abaGrxIbCm5bj2ItUHUt8cUtdtmcwTgA=;
        b=Mhqa82ZV9o2rgcd4N71UKw1ESNADHnxtgdGOYAYLGWzs6caurqhIAHmQkSs6qUEhgy
         jCItjqW2BVS8fYEMVLyNjXwT8c4jPc3RDVq7s8FxBKtbN5aa5MjnYM0yYupYnjQtmM8d
         bfXbtVQGfVP0RSxZLEhIvPHCGzzcGmBYbf8egeQKXUtnmnhTFkkH3lu/nuXmaTlWXPqZ
         9zM4hnwtsi+yBGHuQcXnuM365S5u79E/8E7PJDClxbgkT8fxb7aiy7GkO9qWFCLkb+ai
         r++U7V4rdah9i4kmHPmRBf8uiiw+zvRURKOyuFNOXWvc0C7ma81cnzTpC8IPyoiggrkw
         DJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXrv6RkWj/YIFjrjXVWdp/TCjfYQ4GP2NzvoDSLYSxiySBunbwTzBj9xhE3Lpzs/pohOVUINOaRMKdop9CVQ+ro@vger.kernel.org
X-Gm-Message-State: AOJu0YxfCUZ/lTkbgViVu0e1KjTORkUFA9olENPzZ7pO5v9psR8hPE/r
	Y+gasPg249oEGdfvtf885zi8nMwltdb3tq+oyIUrnlF3c07LQ8XQ6gcBgQZ3tZGF9j+AUucIZPV
	wg2v08g==
X-Google-Smtp-Source: AGHT+IGGuOdObjFn0thPIp2EHNAubbx/JgnBV3STYGMKDse7ZcL1k4gPj0ecmDE5bRIO8GwGFCWbIhH7Tk/M
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a05:690c:b89:b0:62c:ea0b:a447 with SMTP id
 00721157ae682-6f5312263dbmr400597b3.2.1736627342348; Sat, 11 Jan 2025
 12:29:02 -0800 (PST)
Date: Sat, 11 Jan 2025 12:28:51 -0800
In-Reply-To: <20250111202851.1075338-1-irogers@google.com>
Message-Id: <20250111202851.1075338-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111202851.1075338-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 3/3] perf build: Remove unused defines
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	James Clark <james.clark@linaro.org>, "Steinar H. Gunderson" <sesse@google.com>, 
	Changbin Du <changbin.du@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

DISASM_FOUR_ARGS_SIGNATURE and DISASM_INIT_STYLED were used with
libbfd support. Remove now that libbfd support is removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3b827eba53c0..4fdd85f96a83 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -320,9 +320,6 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
-FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
-
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
@@ -349,7 +346,7 @@ endif
 
 ifeq ($(FEATURES_DUMP),)
 # We will display at the end of this Makefile.config, using $(call feature_display_entries)
-# As we may retry some feature detection here, see the disassembler-four-args case, for instance
+# As we may retry some feature detection here.
   FEATURE_DISPLAY_DEFERRED := 1
 include $(srctree)/tools/build/Makefile.feature
 else
@@ -988,14 +985,6 @@ ifdef HAVE_KVM_STAT_SUPPORT
     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
 endif
 
-ifeq ($(feature-disassembler-four-args), 1)
-    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
-endif
-
-ifeq ($(feature-disassembler-init-styled), 1)
-    CFLAGS += -DDISASM_INIT_STYLED
-endif
-
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
@@ -1287,6 +1276,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about disassembler-four-args, for instance.
+# tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
-- 
2.47.1.613.gc27f4b7a9f-goog

