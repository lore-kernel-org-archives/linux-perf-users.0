Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D33D97E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cj997Knq"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEFE1712
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9bc6447193so5552211276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186271; x=1698791071; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9Urizhv5WS8Bux3imXxMiLlOJqV8I9Pz4v3kegUcno=;
        b=cj997KnqBuk1bJmOrE1IaIjCfFJfdq7f3X0TDebG3W1tvzl1CfqDsoRbsWSkZbq3EV
         VILP3F1wqjbRACu+v39fc+dbw/umoBJed3H+6Z3KbqpiOSeTXGXKJaOdgrvzEg3CMPwO
         FCknZrWklnt84Q14XXGuetp0yDNwIWUVTdVjyYNqz4FTPhU+8kI0nFochpdvBzosdypS
         y63K/24yBnFMwIP4AmRbjjFMHDZjfPAU1k+jVBjJ25N6bh8kZaocYa2I5BH03L9AiuGR
         fhbWg0PujwL3cGy4Ad9NGkHZeRYuD4mkPZvDjXGs1Ad8Lrh4IBf++4iHjGZKu36Qk9aX
         skMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186271; x=1698791071;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Urizhv5WS8Bux3imXxMiLlOJqV8I9Pz4v3kegUcno=;
        b=HPMQtVMBAyDikf60JZYy+p7xNUpjpeMlQ+4Ux2fdq/lOZe3as+xYv4YhjkTvJyHJid
         dwt1tw37c26WHkJGaj/ed294zCV4xhx8druddTSn2Gne5BqBYcl3lOex2zSCgaoLVlh5
         EWo7eQDW+I6ZqLyB65zJyN27ewgQaAxtCPpS1Tk9eEmpjRcKkh7/0U/qawCRhxmoU6C2
         Xh8i06+ZUB4A1e2TKDX3MvgHFKL83nB9GMkVC2aYQba1FAjLuTmnI9An/9DkvHgWF0l7
         PfNZ9i0okGdYQsw9tDfFddzkNgym2oiWmHy/onZx9LIF68cRM9aTkxpP7xNdpYFHOhS0
         VFUg==
X-Gm-Message-State: AOJu0Yz2ljGIi5VkKPKhXIe68JtfHHIcwI6OrMT3G1ZTB5AjQct7IkMC
	5MJ03cg4vhrW8aBJCgKf2uo+Pdj7pvmg
X-Google-Smtp-Source: AGHT+IHu39k4c6xkVV7pusgwib5ieSXUcE1SF5wxto++MOEMTeu8moZwxB1soQKzEQ9cZdZ4i+7cZYrcj7Fe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:4f4c:961b with SMTP
 id v3-20020a056902108300b00d9a4f4c961bmr353592ybu.1.1698186270729; Tue, 24
 Oct 2023 15:24:30 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:11 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 08/50] perf callchain: Make display use of branch_type_stat const
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Display code doesn't modify the branch_type_stat so switch uses to
const. This is done to aid refactoring struct callchain_list where
current the branch_type_stat is embedded even if not used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/branch.c    | 4 ++--
 tools/perf/util/branch.h    | 4 ++--
 tools/perf/util/callchain.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 378f16a24751..ab760e267d41 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -109,7 +109,7 @@ const char *get_branch_type(struct branch_entry *e)
 	return branch_type_name(e->flags.type);
 }
 
-void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
+void branch_type_stat_display(FILE *fp, const struct branch_type_stat *st)
 {
 	u64 total = 0;
 	int i;
@@ -171,7 +171,7 @@ static int count_str_scnprintf(int idx, const char *str, char *bf, int size)
 	return scnprintf(bf, size, "%s%s", (idx) ? " " : " (", str);
 }
 
-int branch_type_str(struct branch_type_stat *st, char *bf, int size)
+int branch_type_str(const struct branch_type_stat *st, char *bf, int size)
 {
 	int i, j = 0, printed = 0;
 	u64 total = 0;
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index e41bfffe2217..87704d713ff6 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -86,8 +86,8 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
 const char *branch_type_name(int type);
 const char *branch_new_type_name(int new_type);
 const char *get_branch_type(struct branch_entry *e);
-void branch_type_stat_display(FILE *fp, struct branch_type_stat *st);
-int branch_type_str(struct branch_type_stat *st, char *bf, int bfsize);
+void branch_type_stat_display(FILE *fp, const struct branch_type_stat *st);
+int branch_type_str(const struct branch_type_stat *st, char *bf, int bfsize);
 
 const char *branch_spec_desc(int spec);
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 18d545c0629e..cde4860e6f28 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1339,7 +1339,7 @@ static int count_float_printf(int idx, const char *str, float value,
 static int branch_to_str(char *bf, int bfsize,
 			 u64 branch_count, u64 predicted_count,
 			 u64 abort_count,
-			 struct branch_type_stat *brtype_stat)
+			 const struct branch_type_stat *brtype_stat)
 {
 	int printed, i = 0;
 
@@ -1403,7 +1403,7 @@ static int counts_str_build(char *bf, int bfsize,
 			     u64 abort_count, u64 cycles_count,
 			     u64 iter_count, u64 iter_cycles,
 			     u64 from_count,
-			     struct branch_type_stat *brtype_stat)
+			     const struct branch_type_stat *brtype_stat)
 {
 	int printed;
 
@@ -1430,7 +1430,7 @@ static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 				   u64 abort_count, u64 cycles_count,
 				   u64 iter_count, u64 iter_cycles,
 				   u64 from_count,
-				   struct branch_type_stat *brtype_stat)
+				   const struct branch_type_stat *brtype_stat)
 {
 	char str[256];
 
-- 
2.42.0.758.gaed0368e0e-goog

