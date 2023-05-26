Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219E1C7EE23
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 18:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbjEZSef (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbjEZSe0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 14:34:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC31E1A7
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 11:34:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5653213f5c0so21388457b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126062; x=1687718062;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckGeA02WLHJLNJCbS//eOlt+uaDLHYtNJ6XZaQ87+eE=;
        b=HdWqwyuKOVJVYrotCjPhszbemVJLi+mulQLG1Rr3MyUcSxnCXsyivwS1vkdp2dk4XD
         cuJD+Vabjl4NY8GJbCjtdr2RyJKXZw8zCHUzjwDKWxgQnAYt1/HTsYA3MCs5v0CynoQQ
         kaVyGCIB+y8tITQL4uCcxP1C9j3zaWZPqrOYALRHl8S/y9pv7xChGPwttEyO7bHDtLJc
         bN0UtC5pNviOqvyYioK7oa7InzYbxLxs2VprHRkU8MuxXMybDqMJIXThzpulMcGRtma3
         d8A6CymEbkJa6AeLBHBC7w1tlwQSAyo5cRI9CWONULj+XyRWl0iG1rYNuZnNFfkm8nVU
         3lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126062; x=1687718062;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckGeA02WLHJLNJCbS//eOlt+uaDLHYtNJ6XZaQ87+eE=;
        b=clvviALLpaH7JCLvSXjhro214cAa2yCB67K+jHHJoTbiVC8mc9iZz/oiBPXxrAQBCq
         u7U68DwHjCcsvVhhCvXyB514JhOWRSUb2kbOPq8Wfa+6I48YkkFkmWtR+bqWQ7SaNW2j
         hpHZVwZ1Ey0yv8bOi5ybtbCTKv3SXBynuaKyD0cTbJM6Y+NLfFdomqQudmHhkDKNL1rA
         DiAJ4jTdzVdD7cqITmF9L724qgox/8t6axZqVqLN4/0nZpW1/tawGaRU8bniFoCMG9aS
         NvLaUsMEL27BrgSrukQzQN9Hj0/iXdv5gf6ZvA+tYxplPvl6LnhyxJfMJ4A9YHK7nPoM
         3clw==
X-Gm-Message-State: AC+VfDwwpxpDhqBPcB/RH0UiVWGQpEM2Ahkw5wefe5A2cJCVwhQSTrLQ
        /RR5cj69978DTbyjMmvDbGrkbrI8JIZH
X-Google-Smtp-Source: ACHHUZ7yN2+swTi3T9v5RlylUFEatgWcWb8N2nwtoaWCzGgKIStPV1yVDi3jmOaNuUF/vZIT5CjO8R5HyO+v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:4309:0:b0:561:987e:d22 with SMTP id
 q9-20020a814309000000b00561987e0d22mr1565637ywa.1.1685126062157; Fri, 26 May
 2023 11:34:22 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:50 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-6-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 05/16] perf trace beauty: Make MSR arrays const
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Allows the movement of 46,072 bytes from .data to .data.rel.ro.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/trace/beauty/beauty.h               | 2 +-
 tools/perf/trace/beauty/tracepoints/x86_msr.sh | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 4c59edddd6a8..3d12bf0f6d07 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -11,7 +11,7 @@ struct strarray {
 	u64	    offset;
 	int	    nr_entries;
 	const char *prefix;
-	const char **entries;
+	const char * const *entries;
 };
 
 #define DEFINE_STRARRAY(array, _prefix) struct strarray strarray__##array = { \
diff --git a/tools/perf/trace/beauty/tracepoints/x86_msr.sh b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
index 0078689963e0..fa3c4418e856 100755
--- a/tools/perf/trace/beauty/tracepoints/x86_msr.sh
+++ b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
@@ -13,7 +13,7 @@ x86_msr_index=${arch_x86_header_dir}/msr-index.h
 # Just the ones starting with 0x00000 so as to have a simple
 # array.
 
-printf "static const char *x86_MSRs[] = {\n"
+printf "static const char * const x86_MSRs[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x00000[[:xdigit:]]+)[[:space:]]*.*'
 grep -E $regex ${x86_msr_index} | grep -E -v 'MSR_(ATOM|P[46]|IA32_(TSC_DEADLINE|UCODE_REV)|IDT_FCR4)' | \
 	sed -r "s/$regex/\2 \1/g" | sort -n | \
@@ -24,7 +24,7 @@ printf "};\n\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0000[[:xdigit:]]+)[[:space:]]*.*'
 printf "#define x86_64_specific_MSRs_offset "
 grep -E $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
-printf "static const char *x86_64_specific_MSRs[] = {\n"
+printf "static const char * const x86_64_specific_MSRs[] = {\n"
 grep -E $regex ${x86_msr_index} | \
 	sed -r "s/$regex/\2 \1/g" | grep -E -vw 'K6_WHCR' | sort -n | \
 	xargs printf "\t[%s - x86_64_specific_MSRs_offset] = \"%s\",\n"
@@ -33,7 +33,7 @@ printf "};\n\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0xc0010[[:xdigit:]]+)[[:space:]]*.*'
 printf "#define x86_AMD_V_KVM_MSRs_offset "
 grep -E $regex ${x86_msr_index} | sed -r "s/$regex/\2/g" | sort -n | head -1
-printf "static const char *x86_AMD_V_KVM_MSRs[] = {\n"
+printf "static const char * const x86_AMD_V_KVM_MSRs[] = {\n"
 grep -E $regex ${x86_msr_index} | \
 	sed -r "s/$regex/\2 \1/g" | sort -n | \
 	xargs printf "\t[%s - x86_AMD_V_KVM_MSRs_offset] = \"%s\",\n"
-- 
2.41.0.rc0.172.g3f132b7071-goog

