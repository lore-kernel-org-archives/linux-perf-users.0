Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29522332A
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531931; cv=none; b=oii7KjYNTEJuiJQPCsVnqfmUn2PFksGboB1/SModTfzVLuvsOq1NF0de3ShP+2SA0Nm8P2OHCV6oNEz5qfMvAiHeZdRLBcLRwWWWlbQPsn0Ssk2MgTN6ucIA/OMOxM8TgTYy0Vk5KRj1G7kMC9gk4mE4yx49IH00xTHoeikbY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531931; c=relaxed/simple;
	bh=TQeWDd/yYWGLnY1+2vrH/bkxiRy1g+kcbMr3spHf3Ik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VL9xaoTL/mEhuICpKJx8vhZFU9Zqd2/x/7wsf5+hfe6hEUN4hh9sfynxUFwC7KYOEXFepYDpHMe+1U0l9nMopPnmibr6sgSq8vbzPklAamZWaEdduMgJqBRZO11AHyLJ/yoLyG9TmgZFhxEBToAWkxXnLtw3ZLE8m4NAe1WFpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjRh0XX7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjRh0XX7"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-229668c8659so5258875ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531929; x=1744136729; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SpygHYpX3V6G/Y3lvn2849/ZYwPsF/CjG3vk8gdf8c=;
        b=tjRh0XX7J6eqS8zUzNYKOI8cruIrm+facOdIIPneshXkW3MSKgsEvdACUoVfMZP8ml
         PI5KfO24Udn3wiusTCluCh6oJ+fzudR9KQnrO1Z0lANFdQH0C58FIPfL7LKxCba+DEV/
         tqPAusq9y3TxC29EX8wqoSQ7d3vBhFzctl2D0qqVxrJ8V5hTxpSyuN6PIQ5uVcU3/S/4
         N/2dByzMNfHpVFp4kpB0XhY1rPWcuIiqF/3nlxgQpipQVwG3iSJKSbwjFAxcXZYsz/Xl
         fXukrmdzNeJt5fT8lFgCDmts4rE5RbcVVpa3OqMX3FNpZ2pkJBjn3NXuRLpf7IeLEAQ6
         HZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531929; x=1744136729;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SpygHYpX3V6G/Y3lvn2849/ZYwPsF/CjG3vk8gdf8c=;
        b=I5byldtFv2po6PJXFEOF0NMoMU7xKAMiqK3qOJQjugBlrb7PqgjrTQgzNqs8unnqE6
         J5XT+EnbVY+h9AYz8NMap5YvgWkn8EwS6EgqWiEmwTvneoo5w1qVOnb874HtjbUpAIaT
         VP5XqoS+r7bVoiCskBnMyzN8YQP1uJydjoYK3IIjq7R0ue4x9Df9sI40Po7ITnQhDzTr
         lgrZCygohIQYP9ZqnNgU/u78x5fT2MUs/OQwR+oBR6w6oGwvfitjg6ytDnyMTlJPiwQF
         rHXPTu5w5oX63qm/Kv5JKJ+3Gx++evy1zc3O1khcCRpNKagjqTTxw1xLXFqTKF0kgNG4
         iPeA==
X-Forwarded-Encrypted: i=1; AJvYcCX69dGHGCv+KhwBy8vCtYnxGBxZbD6eTvkn/vkJ1KwQjZ2DJQYdMeX+U7Cqn6aRN71r9mNhjr5o1aU4qH0TV+I9@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeOiuRZknqSw0RxOxCwUdEoiWi2BjYPtE5juDhASm8YwK2EvM
	RkrsPQuCGY4pUWyTxgxwHleaiN4GzQVbm/Z1Tu13gQfe8BLYlbLMV53bBorGnI/tnxNfrgSjecJ
	4eVKN7Q==
X-Google-Smtp-Source: AGHT+IHidRh8ZohN9BAfCZsioNhjrSQYSS/qtPWBESRb2scl+HVatDzDtqJLadMCQ/s9lEK/qcgJBOyqMu08
X-Received: from plps15.prod.google.com ([2002:a17:902:988f:b0:223:fab5:e761])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cd:b0:224:2207:5130
 with SMTP id d9443c01a7336-2292fa00e0cmr186146635ad.45.1743531928693; Tue, 01
 Apr 2025 11:25:28 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:24 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-27-irogers@google.com>
Subject: [PATCH v1 26/48] perf hisi-ptt: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/hisi-ptt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index e4cc4785f744..978f5781c990 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -59,7 +59,7 @@ static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
 		      len);
 
 	while (len > 0) {
-		pkt_len = hisi_ptt_pkt_desc(buf, pos, type);
+		pkt_len = hisi_ptt_pkt_desc(buf, (int)pos, type);
 		if (!pkt_len)
 			color_fprintf(stdout, color, " Bad packet!\n");
 
@@ -91,10 +91,10 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
 	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
 					    auxtrace);
 	int fd = perf_data__fd(session->data);
-	int size = event->auxtrace.size;
+	u64 size = event->auxtrace.size;
 	void *data = malloc(size);
 	off_t data_offset;
-	int err;
+	ssize_t err;
 
 	if (!data)
 		return -errno;
@@ -174,7 +174,7 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 	ptt->session = session;
 	ptt->machine = &session->machines.host; /* No kvm support */
 	ptt->auxtrace_type = auxtrace_info->type;
-	ptt->pmu_type = auxtrace_info->priv[0];
+	ptt->pmu_type = (unsigned int)auxtrace_info->priv[0];
 
 	ptt->auxtrace.process_event = hisi_ptt_process_event;
 	ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
-- 
2.49.0.504.g3bcea36a83-goog

