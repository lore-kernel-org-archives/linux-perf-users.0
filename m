Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56785C77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbjEYHMp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbjEYHMR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:12:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A8E73
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb3528ce5so540902276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998730; x=1687590730;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUCIph9jK5qjiaVbzBCW9jd0y4OBlbaAbGAhyKWQXwI=;
        b=Ud1pJbb8PouEaxMx39Qsb0pgXQhuacyg9dE15yBm5r7rhKMfmT/wtYE2bXvB9haeyo
         BUBUKC8ETaG4qAGi43orR7MBCDD3xmJ0ggNCx/vfVb0gwfAPQnuhooRT2CMQb9SDBlej
         aeuAnMX/JNhCmbxg7K4mABEvgSx55qB0QBWlNojB1OzD6HniNhvVSXqsOrZTo2JeLiQ2
         AqnarGa9CWEnF2Ot0/Ipz5Slnp3JLrSRn6xuYI+mxDu6NEXLWJOn+9Ql5p4km3xx2FO7
         eeZs0v7UgYnrvrpw64ig+vyli3RyuBx44SDd8pzAjOE244wfPz1Sld6TGQMAJGA8zoNr
         W88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998730; x=1687590730;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUCIph9jK5qjiaVbzBCW9jd0y4OBlbaAbGAhyKWQXwI=;
        b=cyXM7fD7QUJ7DmPRq9+GAmVt3jCi+0k+pS45YMe6dnRpUMaqlUP3CA3odaAJc2n2RJ
         OeIHKX0l6xQVIOvXjNL6kirMgAm31iZUtEnjnDgmBhL0ZV/l63vnJ8YtDxp+87R6QVp7
         5C6KQbBOj39ByiDr3galTzfnBG4D1z+KRdI/vQlQ32dBjvUcQaV7Ilo/cTqKeiCUjMZf
         liMTKwaEJjU7uqPWBRw2aQ6W9ns9dGEQ831wZ+clYaTrTXOXz40H6hl9o6fwaUQMu2sg
         dytF8dBxrW6FlvK6Q4Eum00vb84G6OljdyEgzqJDoKvi8TjHEnsQvldKIzXQqNp1/7Ij
         tqGQ==
X-Gm-Message-State: AC+VfDzIhBO72eaJbkRyo1S2CFLK4YTTgZSJ5IIhmj41xF9cM4s7UN4i
        4xtD9V+YcHTCTS6ur+6OEs+bWoenqL10
X-Google-Smtp-Source: ACHHUZ68HRyMlyMUL7VBgU/YBf0IxbbVeqtg8y5j3FkwNP9nVcYZcks0CIY+Vf/g6P81tElQnzKI+NlxoEYW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a05:6902:118e:b0:ba7:5bec:7772 with SMTP
 id m14-20020a056902118e00b00ba75bec7772mr1217518ybu.5.1684998729741; Thu, 25
 May 2023 00:12:09 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:22 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-6-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 05/16] perf trace beauty: Make MSR arrays const
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
2.40.1.698.g37aff9b760-goog

