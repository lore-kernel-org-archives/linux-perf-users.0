Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516562236E3
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531932; cv=none; b=QgncIHpXShOQD038rN7CrQAShMZ30aWX3AaFtg65novqgxfOvw3eQ49LNvlWetcyZG1APFCgNkte8vRWrkskt9M2/5qrjS8WUAvh8mwfOJ7x9fthbe/ypJVldk2ebohgfuFOiMUbHn0W1KL6TWE7Zz9KdlN6IwUuzp3AC00hA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531932; c=relaxed/simple;
	bh=sWUkx042vT7q8/Tf+yhfO6vzKLFI6jKaDXPP/t59N9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Xf4kkgaGEU2hLBIbva/tHgIeJo+6ZubqVWBf3yzLTs5zeNaa+wJBPgn9RkNPsi1vaibKied7WWS8JbKHjyFkdB0t7UwDNNCZedIQbUvUhxO5tieT56EsctdH7bolCbmIAK647K5otW/A2NMq8fbAY+gszEzyLbsafz1MjIbTLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MroGomDx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MroGomDx"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so9974713a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531931; x=1744136731; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjYwyfzWpXgW9pBn6lh1KuK7zJm8s0w53QTMpIqZFFg=;
        b=MroGomDxcLFSu01m/QjLk/slMk07bWJlZwaYJzNavqUPXsvqQnax1DT/rQbTR+Rxf8
         11HeYPSrpDJTGTf42B7Bs+PBgts6ylSzQtAA+V6EfxdUwN3n4RYBG6ugO3FAVLuKxj6N
         uccluZDFyJK44+JVCdd8nOwUX+GBz6T/RjF0IPnwFQ623QbhzyL17HZ8irzgT5kKv5Nk
         9eUwfE+ETdv05k5bLR1lrUR01HQ98Zed7H1ZzA2tkUcThZXThK0r6aO/nN4Iq8j1zgqt
         cy3iRbJ9GjFHvjOJlzeqIbRpeL86C5GCm6J04Caz+iofzKwxPfs5N3zrVrK8qsLcDsCE
         KO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531931; x=1744136731;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjYwyfzWpXgW9pBn6lh1KuK7zJm8s0w53QTMpIqZFFg=;
        b=smQ16QDAYBpuFpo673JBpphuxx1RETUVovsedxSOl1oOst8ydpqGDWdt01CDwuTUK3
         bnOS/mBSD6hKb0uq1MbwHFlP1ELXhxbJ0x/iyoQjJCZDpgg8YaDwXgzQ8mw1p+puTnBD
         mnMPHfQw0UMxyOIywTo8+dUMhrlKYW2CMqaatsnSi1l9jmNI2pqnnmW5fgtIB1bSbe+e
         Y6g5Wg2DRMY4NlOJ/Vpp3VC70xMfkB4CYfcyObjVmnExmlFzmAYy9qDc0OUEprqyyaPh
         +vEYSETAn2ve/oVum0nnIuPUVuFORxMuEgzFxU8bD1vgEbhVnnDBzp5bw711y/B/WZ17
         Y2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWG/ro/Eaj4wijjZkwBcCL7/IBATHP/67pIZQ8RFGqcyfr7qDlDp0o8CNbweFTCFi/w7X4JK3sc/kUMzjJCskQ/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3xslUebPxJrzYyHUnP8/RikH1zqTeoBC7xrgQUlmrVOSAk8Be
	4dP6lOoy8PTPMMVJ74gIaq5a9HQk/ZkPdqeNTUkqi34mG/qXIiiy+LaFfiBkXq0Am70RX1trgg1
	dRY/lXA==
X-Google-Smtp-Source: AGHT+IG4Kf2Zybdapo7zsLm0EDlW1RPSa/moYNMFk0l2bCivrxDDEmzqMRibCQWMjdxRJDlbVEv7HYK4KZth
X-Received: from pjbhl3.prod.google.com ([2002:a17:90b:1343:b0:2f4:4222:ebba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384d:b0:2ff:7b28:a519
 with SMTP id 98e67ed59e1d1-30532158ee8mr19553046a91.30.1743531930453; Tue, 01
 Apr 2025 11:25:30 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:25 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-28-irogers@google.com>
Subject: [PATCH v1 27/48] perf probe: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/probe-event.c |  9 +++++----
 tools/perf/util/probe-file.c  | 12 +++++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 307ad6242a4e..a733dc59c3ca 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1336,7 +1336,7 @@ static int parse_line_num(char **ptr, int *val, const char *what)
 	const char *start = *ptr;
 
 	errno = 0;
-	*val = strtol(*ptr, ptr, 0);
+	*val = (int)strtol(*ptr, ptr, 0);
 	if (errno || *ptr == start) {
 		semantic_error("'%s' is not a valid number.\n", what);
 		return -EINVAL;
@@ -1620,7 +1620,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 		}
 		switch (c) {
 		case ':':	/* Line number */
-			pp->line = strtoul(arg, &tmp, 0);
+			pp->line = (int)strtoul(arg, &tmp, 0);
 			if (*tmp != '\0') {
 				semantic_error("There is non-digit char"
 					       " in line number.\n");
@@ -2066,7 +2066,7 @@ static char *synthesize_perf_probe_point(struct perf_probe_point *pp)
 {
 	struct strbuf buf;
 	char *tmp, *ret = NULL;
-	int len, err = 0;
+	int err = 0;
 
 	if (strbuf_init(&buf, 64) < 0)
 		return NULL;
@@ -2084,8 +2084,9 @@ static char *synthesize_perf_probe_point(struct perf_probe_point *pp)
 			goto out;
 	}
 	if (pp->file) {
+		size_t len = strlen(tmp);
+
 		tmp = pp->file;
-		len = strlen(tmp);
 		if (len > 30) {
 			tmp = strchr(pp->file + len - 30, '/');
 			tmp = tmp ? tmp + 1 : pp->file + len - 30;
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index ec8ac242fedb..2d84002710f3 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -167,7 +167,7 @@ int probe_file__open_both(int *kfd, int *ufd, int flag)
 /* Get raw string list of current kprobe_events  or uprobe_events */
 struct strlist *probe_file__get_rawlist(int fd)
 {
-	int ret, idx, fddup;
+	int ret, fddup;
 	FILE *fp;
 	char buf[MAX_CMDLEN];
 	char *p;
@@ -189,6 +189,8 @@ struct strlist *probe_file__get_rawlist(int fd)
 		goto out_close_fddup;
 
 	while (!feof(fp)) {
+		size_t idx;
+
 		p = fgets(buf, MAX_CMDLEN, fp);
 		if (!p)
 			break;
@@ -307,7 +309,7 @@ static int __del_trace_probe_event(int fd, struct str_node *ent)
 	*p = '/';
 
 	pr_debug("Writing event: %s\n", buf);
-	ret = write(fd, buf, strlen(buf));
+	ret = (int)write(fd, buf, strlen(buf));
 	if (ret < 0) {
 		ret = -errno;
 		goto error;
@@ -962,7 +964,7 @@ static int probe_cache_entry__write(struct probe_cache_entry *entry, int fd)
 	iov[0].iov_base = (void *)prefix; iov[0].iov_len = 1;
 	iov[1].iov_base = entry->spev; iov[1].iov_len = strlen(entry->spev);
 	iov[2].iov_base = (void *)"\n"; iov[2].iov_len = 1;
-	ret = writev(fd, iov, 3);
+	ret = (int)writev(fd, iov, 3);
 	if (ret < (int)iov[1].iov_len + 2)
 		goto rollback;
 
@@ -970,7 +972,7 @@ static int probe_cache_entry__write(struct probe_cache_entry *entry, int fd)
 		iov[0].iov_base = (void *)snode->s;
 		iov[0].iov_len = strlen(snode->s);
 		iov[1].iov_base = (void *)"\n"; iov[1].iov_len = 1;
-		ret = writev(fd, iov, 2);
+		ret = (int)writev(fd, iov, 2);
 		if (ret < (int)iov[0].iov_len + 1)
 			goto rollback;
 	}
@@ -992,7 +994,7 @@ int probe_cache__commit(struct probe_cache *pcache)
 	int ret = 0;
 
 	/* TBD: if we do not update existing entries, skip it */
-	ret = lseek(pcache->fd, 0, SEEK_SET);
+	ret = (int)lseek(pcache->fd, 0, SEEK_SET);
 	if (ret < 0)
 		goto out;
 
-- 
2.49.0.504.g3bcea36a83-goog

