Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69B22259A
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531929; cv=none; b=D77eWlcBuPMXUcH5QS2DQ9gc313z3ZN+OrJKdBTidrXGC1oooVZH/CaJLNyt2lCUMIPmJd9BWE6EVt1tB8XkeM8NUv/ZYR0dOaQtFKrh2f+M9HFCa0tNlUJdlv9najlqak9a82+UPTIFuhQb745yjk2wpBemjDV7JYOSBxKy2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531929; c=relaxed/simple;
	bh=sjYPBHk2RL4AjpW6aV3agLcV+PsNHpxvrXhMbpH8T90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r6C0sbOm23Hriby/2dOSNAswBldfiAPEyheRQla1byvLwL1MailnQDYmT/KayoM/mIEA0uMJaw46cLQxl083Q2eFpioIzp4ibWihLFZr/eua2q6fTSnApgxWQBWy5Kf7BfAYhMd+oIp87WBXScSAsHwrIAaw+zald5WmoBhky00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSpcaSGg; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSpcaSGg"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c2bb3bed7cso1730655fac.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531927; x=1744136727; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWBe4FBRBVRgr9j7LcjV776a5KxBaguCaqx3R+ckSTU=;
        b=aSpcaSGg4mVG7/gMgAojep5acOePLSnRNjSqF7NE/s9wSYgt5bBhuzZG947md4r3kB
         g2ti/aCo6CqR1mlJpEBGqE0NcriL8mj5cXsxbhqqf7G8Ti1VCYeXU5bR1L74bOX1b8iK
         +3jv2l9eVGpR7xNCsONDqxlBof9mw5KSJPcB2hKbW/2438w8ViPqp3bpTVmcC0V1OuKu
         djz8U3JoZLlVcWGHIVsCi9XL2Z3cW62pOS4hjJhS8g2NXgBi+fiCb0w91QHlH4ZHIbYk
         2D7hbpLFGezuaMqUzvt+gKsS8ZlhpoVHuHxpfUhzzynvCYT6Jyyh9kg3Go9WCIhxG0ay
         NpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531927; x=1744136727;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWBe4FBRBVRgr9j7LcjV776a5KxBaguCaqx3R+ckSTU=;
        b=bZNf2V2tw557q0JUfeq/hJ2M1YsmNXraNtvn2RXata085vdZtLt65iH+7suotTp4yH
         tsvNhYOqDNmismYdH26OPQfjHwZ9Jbhz1TbrndzkDhOZWIfKPoxLM+ZYVsAhYGYm6pvL
         4jYkfadkb1KYMcOTSKl7TG2pSqNLVzSU0vPDvOmwEbO134plCyojqN2wTwOIo0c5//yq
         ia7J9HaqGN/o5P0+kANFesl8qUpJ4+8rS2BRKtbDR4tybz8gwOSTeiH6BaH4gVTz8sp2
         kQDJeO1tjk2JXyogasTmyUdmARh4FrJNISk4AZyRKsoCri5wZ5zK0kUJdKx69CwS/SgP
         kvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaEg7CByGsaGKIuddePQiiSHeb+1ssJlXeFOzzZsEq/sT3QPhrahT5uZ0l0V6et+Gird08AWG2KVnUF6BO4haK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3tdeu/QeZZs+sJy8wLgOmCK2IU76Qi2w4nNZw1gVVod0VqrU
	5GxlZYkPapgrJYQXw7+t0OxbiQWMPvymT8XVMp2AIZxDKr8nUwyZ4W9P1JzDbCSO0931toutJ3k
	PAOLyNw==
X-Google-Smtp-Source: AGHT+IEJ2D69UYPiouVutAbkRbHVsxjAhnNCDOYzCLqniaLRZ6J5FNujGK2lT5LaK02WEQghfdvYk/R5HGWC
X-Received: from oablk13.prod.google.com ([2002:a05:6870:3e0d:b0:29d:f69c:1743])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:293:b0:29e:40f8:ad9b
 with SMTP id 586e51a60fabf-2cbcf513e8dmr8987528fac.14.1743531926639; Tue, 01
 Apr 2025 11:25:26 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:23 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-26-irogers@google.com>
Subject: [PATCH v1 25/48] perf help: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-help.c          |  4 ++--
 tools/perf/util/help-unknown-cmd.c | 14 ++++++++------
 tools/perf/util/levenshtein.c      | 18 +++++++++---------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 7be6fb6df595..05151c68191f 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -301,7 +301,7 @@ static struct cmdnames main_cmds, other_cmds;
 
 void list_common_cmds_help(void)
 {
-	unsigned int i, longest = 0;
+	size_t i, longest = 0;
 
 	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
 		if (longest < strlen(common_cmds[i].name))
@@ -310,7 +310,7 @@ void list_common_cmds_help(void)
 
 	puts(" The most commonly used perf commands are:");
 	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %-*s   ", longest, common_cmds[i].name);
+		printf("   %-*s   ", (int)longest, common_cmds[i].name);
 		puts(common_cmds[i].help);
 	}
 }
diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index a0a46e34f8d1..f0a0b8c13a92 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -24,14 +24,15 @@ static int levenshtein_compare(const void *p1, const void *p2)
 {
 	const struct cmdname *const *c1 = p1, *const *c2 = p2;
 	const char *s1 = (*c1)->name, *s2 = (*c2)->name;
-	int l1 = (*c1)->len;
-	int l2 = (*c2)->len;
-	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
+	ssize_t l1 = (*c1)->len;
+	ssize_t l2 = (*c2)->len;
+
+	return l1 != l2 ? (int)(l1 - l2) : (int)strcmp(s1, s2);
 }
 
 static int add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 {
-	unsigned int i, nr = cmds->cnt + old->cnt;
+	size_t nr = cmds->cnt + old->cnt;
 	void *tmp;
 
 	if (nr > cmds->alloc) {
@@ -45,7 +46,7 @@ static int add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 			return -1;
 		cmds->names = tmp;
 	}
-	for (i = 0; i < old->cnt; i++)
+	for (size_t i = 0; i < old->cnt; i++)
 		cmds->names[cmds->cnt++] = old->names[i];
 	zfree(&old->names);
 	old->cnt = 0;
@@ -54,7 +55,8 @@ static int add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 
 const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds)
 {
-	unsigned int i, n = 0, best_similarity = 0;
+	unsigned int i, n = 0;
+	size_t best_similarity = 0;
 	struct cmdnames other_cmds;
 
 	memset(&other_cmds, 0, sizeof(other_cmds));
diff --git a/tools/perf/util/levenshtein.c b/tools/perf/util/levenshtein.c
index 6a6712635aa4..f6912b848c4a 100644
--- a/tools/perf/util/levenshtein.c
+++ b/tools/perf/util/levenshtein.c
@@ -44,19 +44,19 @@
 int levenshtein(const char *string1, const char *string2,
 		int w, int s, int a, int d)
 {
-	int len1 = strlen(string1), len2 = strlen(string2);
+	size_t len1 = strlen(string1), len2 = strlen(string2);
 	int *row0 = malloc(sizeof(int) * (len2 + 1));
 	int *row1 = malloc(sizeof(int) * (len2 + 1));
 	int *row2 = malloc(sizeof(int) * (len2 + 1));
-	int i, j;
+	int ret;
 
-	for (j = 0; j <= len2; j++)
-		row1[j] = j * a;
-	for (i = 0; i < len1; i++) {
+	for (size_t j = 0; j <= len2; j++)
+		row1[j] = (int)j * a;
+	for (size_t i = 0; i < len1; i++) {
 		int *dummy;
 
-		row2[0] = (i + 1) * d;
-		for (j = 0; j < len2; j++) {
+		row2[0] = ((int)i + 1) * d;
+		for (size_t j = 0; j < len2; j++) {
 			/* substitution */
 			row2[j + 1] = row1[j] + s * (string1[i] != string2[j]);
 			/* swap */
@@ -78,10 +78,10 @@ int levenshtein(const char *string1, const char *string2,
 		row2 = dummy;
 	}
 
-	i = row1[len2];
+	ret = row1[len2];
 	free(row0);
 	free(row1);
 	free(row2);
 
-	return i;
+	return ret;
 }
-- 
2.49.0.504.g3bcea36a83-goog

