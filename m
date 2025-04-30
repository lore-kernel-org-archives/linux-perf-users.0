Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F5299508
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035544; cv=none; b=LWi7sIhLyyRr1PX9OYiiw4h1n9++zj96uqKJiXFwf1XB+5qeG/1yTr3GwIYXI/XuRJ3u9iIZ6ZLfOuxhGfEBmGXbQ8MGfT4e67dUdpetyWG8eaBEKs8vvwW6ZWNZ6HBHekqLURIrWzXbhjNYqoxvpGukI0APqUkLs3BUeBqB4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035544; c=relaxed/simple;
	bh=8xk6c6XVrGf8DBibt8WgV9cuw6KjrbvUvvlMxNIw7J4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IS4cUQzHgJolAWOO74imqzzoiN6i33vx6TtVSPooqNSYwfRYVYx+T/Vk4h5m8qVZyLiyuxcihZlWDYV25qzgiZUuny8njN24k8kksQdJPfT5YL7xtKTgxCdrwCohhEQzxXRGV89pcvExKh6Caw1IhHREo8i5s2nK5qOrwAzGGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gCs+cw/S; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCs+cw/S"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so89704a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035542; x=1746640342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfYoNaqxvhQ9eTV8t6yeDJ1HU1t4q/f6AZhR7HYRkks=;
        b=gCs+cw/S/LjBdV1VhN+YxtTZ2vqZwADnyvHqjhBDC6+hqSjth0/EIZbPnoAPbtFZga
         pKGiuw4/z2BgVllcFbJbsrmE++PjNkITswoS9qUEZz39KDxHWrpEcmlOxk4nJgdlILKa
         J2Jp0TpX3ukN7gmznXHnP7EGyVfaKBBYnOc/9+sPRmaESBtJtMRn1CmnaRF7mQsR9zVb
         jBS65zK3m2K8DUjVLlgwACLk3DkaOfTlcfKWLiW775ekTq9+sDqkqlCVD+oPTWzHX9vM
         q1n7Q8mobt7XfCLbjUEm4FYHfmElP90O4/0DD0nt6TRMibC+kfzKYWMKCwoxx7NVmPG8
         g7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035542; x=1746640342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfYoNaqxvhQ9eTV8t6yeDJ1HU1t4q/f6AZhR7HYRkks=;
        b=GUdKQguT1lVrtRP29PxNghVsdqiB3pT3CQpncB7X20TTbWX49XFF9Er2uZQU1CkD6L
         djXSPG1a2HdLpY34ErDCtjg5Hj9hzwcU7u9tai7P9YNObXUavcaPnym8gpPD8TmD4jmp
         1HxhCaAzu97heTIGc0cgYub/c22LPPomC1pbjbUsAtBjFpDbs+KDFAr6bhCuiwggr0zL
         7BbRzpF9JvWpdrBmfHfezRoAulED54GxVEoEhp6+z7VDU5Mo8OkgeqXDA0isukVYucmQ
         eYZAD7d1P7WuEFAMkE6DmXXJGacMsp1znB8wdBwqnBakmHkBOiqj3Frry836tLVXLWOL
         ELKA==
X-Forwarded-Encrypted: i=1; AJvYcCWzo7bns1JUOjG8MbPzK6qUI4ocs5jX+N9U8meGFVVeYty/4Nr35Hfq6HeZHsEz6saIWliFdssOMMC/yHtHB4hr@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuKYGJsw0uYgJnnT8Q30sQiA2pKp2+1k9Z7jpqfg8kawNMlSn
	ZIdbxnbTwlzoOTGIFx1coGXj4IV+98CPV4eggckUvp6pfbSojeJlJyPMkGSLUQwSYEKJQLZdKt9
	j0UYezQ==
X-Google-Smtp-Source: AGHT+IGE6ShT5AKZEjfO76Ud9wq255vjvupnoQSaA/IRCz6DrEQ38RNaMX6Vlst1q29yf69v7lZZ4wLh25wT
X-Received: from pjbpl2.prod.google.com ([2002:a17:90b:2682:b0:2fc:d77:541])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cce:b0:2ee:df70:1ff3
 with SMTP id 98e67ed59e1d1-30a342f5554mr6408540a91.0.1746035542002; Wed, 30
 Apr 2025 10:52:22 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:30 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-43-irogers@google.com>
Subject: [PATCH v2 42/47] perf daemon: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-daemon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index f0568431fbd5..640ba8191083 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -514,7 +514,8 @@ static int daemon_session__control(struct daemon_session *session,
 	struct pollfd pollfd = { .events = POLLIN, };
 	char control_path[PATH_MAX];
 	char ack_path[PATH_MAX];
-	int control, ack = -1, len;
+	int control, ack = -1;
+	size_t len;
 	char buf[20];
 	int ret = -1;
 	ssize_t err;
@@ -543,7 +544,7 @@ static int daemon_session__control(struct daemon_session *session,
 	len = strlen(msg);
 
 	err = writen(control, msg, len);
-	if (err != len) {
+	if (err != (ssize_t)len) {
 		pr_err("failed: write to control pipe: %d (%s)\n",
 		       errno, control_path);
 		goto out;
-- 
2.49.0.906.g1f30a19c02-goog

