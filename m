Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216312C9C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3MwS5Sq"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3C1B0
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 11:39:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3942461aso757250276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876773; x=1697481573; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=husYgJZI8HkXIeEAlVmrxb2HP2ESjHLdcuso9o2l4OQ=;
        b=q3MwS5SqifOzUElLTHKWkRfZVws4YDTwoeM6IgNevANP0y+8+EOzK57e63WLiODxJX
         1on8wng9ck5yUo113CPYVkTKH/vhDJ379EuFMBNkjoY0YkSFQES/4+t75/mTtQSYKgup
         fmS7T4Y2mgfC3jhkaoVNsapb1CXkI48j6qiIeMCcQ9FmAmyG3EiBk+U9rh8u9ilgf+Xn
         4g8GXp0lmJJvv92MH7iNbyntf/eMtK64JTgXeu1yprg8Eg3uRJwOAo0f5uBCH2UUylry
         pgwiCXEbuKYjwsN3qvchhjRWYz2TbUwrIKVqyHfUdcwMGVr9K7u+RmLzg1+0vHmu9qD1
         ZM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876773; x=1697481573;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=husYgJZI8HkXIeEAlVmrxb2HP2ESjHLdcuso9o2l4OQ=;
        b=pGlmiBKh3m1etT4N/5oIjUYxQlVJnAlkNwC8vo16s2t6GDnmp5SGbB0VOqnWfW2gq3
         CFnmOyNMJNiaGHUUyt5Yvi0BOFSvRoVFRqP4XdVp38gVCViybrsDvPMla498Ls1+wLfI
         L438qjFHB3WUlHnGXBUy6/T03dqRZ5SsVMzkpBnELtyQMX5pH3/XFZwD6J/QJv4BefiS
         BQFfsFS4P/uys1kq0T14QUn5kn9Jit/mBrARQsu3+SanQYkJXlnVD5Sh9RDF6VbZoqmu
         TE5wJTLwLL8PegkyU4oRAfsv9LYVL0zBPVlHBZmaYl2fQNN7RHFsU8R54Ee26RwZYoI6
         KVwQ==
X-Gm-Message-State: AOJu0YyYTchIHlMBkTbXtuEYU9YSlPsGiUoGbTDHb4kBdsrqvORkwCU8
	8C0LhF8RoQ5dKj6tbKCF1KePdzfppmbK
X-Google-Smtp-Source: AGHT+IHhtsuWVOhbFVDqVr7kwVoc3IhqYcfVk/+Ozn3UkaCuNcjQLVk5uFUA97D/yQhm0NP4FMqRmqlmjGkp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a05:6902:212:b0:d89:b072:d06f with SMTP id
 j18-20020a056902021200b00d89b072d06fmr251520ybs.7.1696876773275; Mon, 09 Oct
 2023 11:39:33 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:04 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 03/18] run-clang-tools: Add pass through checks and and
 header-filter arguments
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a -checks argument to allow the checks passed to the clang-tool to
be set on the command line.

Add a pass through -header-filter option.

Don't run analysis on non-C or CPP files.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/clang-tools/run-clang-tools.py | 32 ++++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index 3266708a8658..f31ffd09e1ea 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -33,6 +33,11 @@ def parse_arguments():
     path_help = "Path to the compilation database to parse"
     parser.add_argument("path", type=str, help=path_help)
 
+    checks_help = "Checks to pass to the analysis"
+    parser.add_argument("-checks", type=str, default=None, help=checks_help)
+    header_filter_help = "Pass the -header-filter value to the tool"
+    parser.add_argument("-header-filter", type=str, default=None, help=header_filter_help)
+
     return parser.parse_args()
 
 
@@ -45,14 +50,27 @@ def init(l, a):
 
 def run_analysis(entry):
     # Disable all checks, then re-enable the ones we want
-    checks = []
-    checks.append("-checks=-*")
-    if args.type == "clang-tidy":
-        checks.append("linuxkernel-*")
+    global args
+    checks = None
+    if args.checks:
+        checks = args.checks.split(',')
     else:
-        checks.append("clang-analyzer-*")
-        checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
-    p = subprocess.run(["clang-tidy", "-p", args.path, ",".join(checks), entry["file"]],
+        checks = ["-*"]
+        if args.type == "clang-tidy":
+            checks.append("linuxkernel-*")
+        else:
+            checks.append("clang-analyzer-*")
+            checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
+    file = entry["file"]
+    if not file.endswith(".c") and not file.endswith(".cpp"):
+        with lock:
+            print(f"Skipping non-C file: '{file}'", file=sys.stderr)
+        return
+    pargs = ["clang-tidy", "-p", args.path, "-checks=" + ",".join(checks)]
+    if args.header_filter:
+        pargs.append("-header-filter=" + args.header_filter)
+    pargs.append(file)
+    p = subprocess.run(pargs,
                        stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT,
                        cwd=entry["directory"])
-- 
2.42.0.609.gbb76f46606-goog

