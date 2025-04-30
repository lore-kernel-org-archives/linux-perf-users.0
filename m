Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94A27817E
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035470; cv=none; b=eyYS1Jk5HbPL3wJJEYgvGB4OdmoBWa6omCS1jDv9dU9YxdfUMXVckuq91hkGIVtG/V0L3Ben777KBRxqX/TKheB/L6vM0W8WxvA1m1lPERoXoYkI4KkuhzIIiNDL9KIPGYlLyyucRqP/GmoGyqpppgwYmoZo5AUCrT7tQj0Lm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035470; c=relaxed/simple;
	bh=7tLf8ZlpDGA58/SmNmZNJE4X51OXHkvdbXoRMSCnQ20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ATis4UnBm2Q3LtJWKhLUgG8heZGnY+onD6f6YcwMbbOPG1Hwqpvep23rLCwlJ1FdGWmYctaMj3C/QPH5AknKnaSvgykk4YstbIYXaSn5LN09iNViXn2BlcrI5rX7vPt1cpaov7j0JXjQnfJVxwOOrsKNFyzkab+QrpzTLC7OKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpWZ1ADK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpWZ1ADK"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3011bee1751so129494a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035468; x=1746640268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3P3h5pAB5HUVcxM6Pr4S0kZF2+GkLiV5d80YFIKGnY=;
        b=KpWZ1ADKSCxgNkbaK8HkZcn7YsWQnt4SqwmJfignWWSWcX/TPRIYGUmEuDabpkcws4
         F3EyGk2u/iV9dyDnE3SceiBUU74zs2jt4WnGKFvb7JQ5ZwbshOfTnbXz8dkMHctnB8t9
         iWNWNnhsXa3X/QiDhz4C4u3spdEXxNH3IraRC3XU42P782LPLp2q0QP7jVPirUqNy1vf
         sYmYp+oMU8cfeWXxdX4LeYAojNjXyf5qVbnSOYAiyES+H8+dVfZoxiEJsIF1EaHskDsG
         767QirhmjWOmbV87k6iQ8EAVzWDCFJsRiBilXTj8qvsZ6vf80Ul8runlK+Z7qM9drZ+S
         xccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035468; x=1746640268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3P3h5pAB5HUVcxM6Pr4S0kZF2+GkLiV5d80YFIKGnY=;
        b=ihx+mZBO/zT99iGfrMYKii7jIWBAxd9VYjAWsOQljRVcLj/1zJEzdwB4Q0YdNepOnh
         FUnlPSAg58lcaERL2RQJmbNwBPwO5TJ6PehuEj32r2b7rZ8s97W2IZ+JMmG4pv3AIHK2
         pnt4mffClxhW8QLpnxw6T6TS24jXWqYrqw+RoL1n5VG2ERg5L8crJ0RfLhnlO2cRuCtP
         cfPIw08nyxisqcQ3u2VTdXdsLwdk6eQf7ShcFagoMIDYLMWxsBd20uToewG3/ZGeIPm3
         D/LV3vpijKOVLhI/kvPpOHm8vgncCifF4c49kCW+Is5vAHc5maJHwAppERbzEduwkrsP
         HEJg==
X-Forwarded-Encrypted: i=1; AJvYcCVlzdsUjLAuL1WwOCydSLguc47FWXB65jwNfz1dppnrpNk4aUgwbw6hwo6iW946+d1HqFggwYlFk/jFIN8lnKoX@vger.kernel.org
X-Gm-Message-State: AOJu0YxHyoPP+0ux90zkfbBfIYuW0Qt3lWIinTSGumAcZa4WU2vvWdmu
	nmDh0Jvw56Q2v+qMCNOOMZqcNn6Rdc/Fs1Q/Gz2K8m1xc5OF1IvtCEpwxSxdrjt8ZTpK+CC13VB
	RCCv/4A==
X-Google-Smtp-Source: AGHT+IEo4BpVSTP736KrWVvKElXNGdJEvRja+RffiZep9xfmBDE9bpWvo/gjF9Sok1i5GqMVUn1zEL5vbAu7
X-Received: from pjbee6.prod.google.com ([2002:a17:90a:fc46:b0:2ff:852c:ceb8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c888:b0:301:1d9f:4ba2
 with SMTP id 98e67ed59e1d1-30a34450bdcmr5395853a91.28.1746035468058; Wed, 30
 Apr 2025 10:51:08 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:53 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-6-irogers@google.com>
Subject: [PATCH v2 05/47] arm64: cputype: Silence -Wshorten-64-to-32 warnings
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
 tools/arch/arm64/include/asm/cputype.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 488f8e751349..d7289b9d2758 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -227,7 +227,7 @@
 
 #include <asm/sysreg.h>
 
-#define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
+#define read_cpuid(reg)			((u32)read_sysreg_s(SYS_ ## reg))
 
 /*
  * Represent a range of MIDR values for a given CPU model and a
-- 
2.49.0.906.g1f30a19c02-goog

