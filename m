Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB55221553
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531911; cv=none; b=RCOQ0sSMe8q/UMHK9kCTBeB6NV5nD2umKWLGw2PVmaI9kHkv/a5AftK/bSGzD5umI4SCaR7NpIAiq6EQCZcXsRlXiUp8/x0EV8IeLVOkFv8D/8BX2+eK/Ki0WPXGPHWiAlxyPpRAfK9EwSKyOz6RL13a6IOCZfAjASSNpSq467E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531911; c=relaxed/simple;
	bh=Kfkzo+5W/SAVTQiKbqJy3w6KmtcdHFUtBwo6443WHE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rtm8o1lMtHSVtojZs5Jd4lySCSn+0KjCLDbXmyd+CCU/7WXMl+M24QkmB4q15SKEfjiGwO1HikuiCe6G0nnjUnCxRCvrXkOfXlHcXI68gY2sDjJLehBLr5tmNg9HmSVOVAjblIg9dAEjZEyugNPIoApGotTFzmtmkW4Cpyi87KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=je75Qr+I; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="je75Qr+I"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225ab228a37so103527435ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531909; x=1744136709; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6gZ31IgopMBgDwwNg+Kodxz7McFENtAdZR1UxE8I14=;
        b=je75Qr+IVZpl0XIF0wdhzQIJHdVypl3g5/GcA29K8DcTlZN0tTGc7YbXTyTQ/Tz5r6
         RCz7y/0EY5jac5+3wgCspJtd1pZThaDCrKZn1DS09yfgR2lCBsMb2KcFrUCy/qksPfND
         1NRD6h070uBgjrHk+Z0rqDPsSSEoi3FR4oX9NLFQLJgbw1SBHkh7ZZlp7hNbuDMlRTpw
         bmFL0yP8WCEMUthaLkTYeAvdLrqeU2XVf2qPoXDmrOdrDqX3k9kVDB2FTeTBSRsmqb6m
         kf9ysc8NXNI96w9ir29Kdh4FBv8zdZnDDwRmhYNJxbRoZ+N+j1dtuJFDbvzg+I1R+P4W
         iklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531909; x=1744136709;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6gZ31IgopMBgDwwNg+Kodxz7McFENtAdZR1UxE8I14=;
        b=vZUhsOX8CWcWWLBWH2FHX0RMxsY+VZ6YV2XlLr5rTgYwZ6TJc10pzFePYs63WIQI/x
         xjCArWoAltxyeZO0sKj3OLWHFolbReokGvrNi/5He16Y995ifDD4QKFey8PwwppgDEJQ
         je1hGEFU0r262wLpQu2GI870iKTFXGd8mCzrqq90RJTkuu4fvW4o1lmbizhOSHX51N3a
         SW/wMLOnmadjxXWuS1W8YwkbW6rk0inGwm7aR9dJUB/auTzb4N1w4TdqyQXDA8V7qtDX
         wiNaYGEAguQnp+qAHma3AC8fewe560ryTppLBu0kvoqSm0JcnvGUJLspHxbvj458Ltzq
         nqRw==
X-Forwarded-Encrypted: i=1; AJvYcCWk+N+rJyg/pPvvyTKAa60gTrtcS42w0E/L8XBs8StBRKnUHI9MO6VAM4cd9WTBXHEvkJX0nJuwnZJQJmV1FUDT@vger.kernel.org
X-Gm-Message-State: AOJu0YzUT3PeBdgdBakZQ0KJ6DW5rNKU8WwV4vB+P3Nhh1ArKU+f5GMz
	DndHfcqDohe1363ca1ukme6WTopHiJgTwinwYCPOls/6/D2BCFT0DfwXFw6amnD96GUmbHEvz6I
	k8R/FoA==
X-Google-Smtp-Source: AGHT+IGb9PqtJPk4RJc5mRZLPE5cwOmQxaQKgQS86YxmUT+3hYz9TaBQkDfzuiovvaXbeulfAkLi/U3sT6eX
X-Received: from pfbln13.prod.google.com ([2002:a05:6a00:3ccd:b0:736:b315:f15e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1410:b0:736:8c0f:774f
 with SMTP id d2e1a72fcca58-7398047c30emr19166828b3a.22.1743531909266; Tue, 01
 Apr 2025 11:25:09 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:14 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-17-irogers@google.com>
Subject: [PATCH v1 16/48] perf annotate powerpc: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/arch/powerpc/annotate/instructions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index ca567cfdcbdb..598dc10a1751 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -18,7 +18,7 @@ static struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, con
 
 	ops = &jump_ops;
 
-	i = strlen(name) - 1;
+	i = (int)strlen(name) - 1;
 	if (i < 0)
 		return NULL;
 
-- 
2.49.0.504.g3bcea36a83-goog

