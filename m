Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B70289E38
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035508; cv=none; b=mMTn/g4i4b5Keq4zl54g6fmn4s+ZqHjYCwtzRmQsBbYKSzwGT4CE/xMAugo7YcQa6XQvVbpF21u2xP3+f8QvFdc0hGWgUAgHSXhnVKqSRUOMLJ7u1byYxzzQWpDwiZtHvq9fBIjgKsdXHmYRSOBcxMubrvlAIP6cFFfMwRr8Tks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035508; c=relaxed/simple;
	bh=9pgIBm6NSisapiSqj5zQA3vSFMAeMe8aGHH3thkw0jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KtOfvDPrDIjqpddQsibHhLn8Xt9iOVB8DS+UarcBjvSRuAqPTMShJsWHjSkmWRCPK3F5A2a0Gm+QKj3BMCbWmz/YXZ3pPESyUYaAAqipA+RkI33zd7d4BbzjrzVyyv8kfVCT1Hq80R9VR+BvigEQAXsK0IrHz6eDO0T2gh6hzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K95jcYJA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K95jcYJA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032ea03448so164633a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035506; x=1746640306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSGmrz0VgpdryeMuc4wJHeXUaiQJDc7wpL8BqB7GbRs=;
        b=K95jcYJAYIFzp8lxGp5BEximBuTlGH93voZdAienR2SFJ5rLYhoVZvHRd75F93yy/a
         XLgRY1/WpJ1mxo06gG5X6g2W+NlOClZqFkX/NckyGeK6ZjPzMzHKSr7OYL1DkCnrpWIF
         HzzfoRNfjiwvQZT47+9SgZKn37GVhZa59eekhs8A3161tJAs6N9duEag1LBGNG9NpNyA
         T0MBy1KQ30ymsM9GuL5zNTy6Ig55mu55YZp8NihznJAEtZAhGlSnBbutz/BgsEpGFENf
         4UehY7SrnH5Q7Jm5/nyrob7pJiIJd4QPycdaB3KamogtYIWPHmUWaizWV0W5/AM1B6lw
         Fa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035506; x=1746640306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSGmrz0VgpdryeMuc4wJHeXUaiQJDc7wpL8BqB7GbRs=;
        b=b4swsGSEl9K6sLbQXvWpBvjNvT/bod2IIpjCuXPXF9dLIjA4Mao7sbPq1oQp9bhmN+
         HeglUtdtLec1WSeVyBqkKOJaZ7bQTvm6mHZOexXViH9ilo0p/VHPO45UfXsLu0CNQ0KU
         Zh+nKeaW8Eupq5vN36qE210K+yB8oprT8SH0X7lFb56gT2BytBq9iL5jDUU14GB2chU9
         nNLvXyutZw7HGFrW6P6OLo9RQEb/3BhI7JY2c0P8MQQAc4HjR+2QtrWWUsqXH38NyjKi
         PPeDfp9hCN9WY5ar7Hv/M5VZnksz3p7iUeexPX9b4lyXYRcv2rzMMN8tccKAxVJcF8pM
         zVGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0PyRD4yxR3UkRdJEhrLx6QK3f2e3+gQ+rEHwX3BYNS6f2QEcJmunEbZb9KsMY5LOLwHLcaKCsPLeH3hgDxWog@vger.kernel.org
X-Gm-Message-State: AOJu0YxWFVQgFUQ81p0QLKvCdcMI2avMX/x3Y2BMDi0JPvYAyslskEkJ
	FDXB5r/drAq/3QTm+awj9y+2C4a4Y93XjyEjEKU2c9yDeqNaDseaTt+SmTsBm/d3M3vJf2+Q1Hs
	k2kRWTA==
X-Google-Smtp-Source: AGHT+IHkONYHJZfK+RtGOYuqOR3Tmv1Fc5hyNA9X/JV4Uor3w7tc3iAjbnOBIe0SDP0OTR36qQM2EwN7Mdm0
X-Received: from pjbpt8.prod.google.com ([2002:a17:90b:3d08:b0:308:670e:aa2c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1804:b0:301:1d03:93cf
 with SMTP id 98e67ed59e1d1-30a3447ef20mr4890430a91.30.1746035505522; Wed, 30
 Apr 2025 10:51:45 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:12 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-25-irogers@google.com>
Subject: [PATCH v2 24/47] perf help: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
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
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
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
2.49.0.906.g1f30a19c02-goog

