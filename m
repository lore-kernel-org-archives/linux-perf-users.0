Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAB226D04
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531962; cv=none; b=cGvOa/Wu6UQpKIBB9o5DCEZCljz3CZH+Rq3pgEsByU+V7pAjqNGX8Rg7RdZy8rolVCeJ16MrIy8pb/Cpu8OQNpwVXGOXS4E7rNZtDT1TqG2T/b9hceCKMpV5VOKMroy738TtQGx4//e+YdTUMlCm0F42VsUE5bTDl48al9j0y5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531962; c=relaxed/simple;
	bh=ISIPur5EdG5VT16W+y596XtyvQru1DN+JSFfJcpaQKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Hy3EknpKvnyPXRbhRy2hkWYJlsLyMmsG2wryEkiDGF93VM8F6NNJWfCq92a4FQzf1cnmq5d62/wyKV0gmrJuq3pfUd9g825piZcNy1FZdXiSICXskt58EFnf4d2qTQTlMcARxtsDBTyoOO54nDJFuqDCbZakF1fRnYPDXFNv6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3RU7P2h; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3RU7P2h"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240a96112fso186793435ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531960; x=1744136760; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8D2NdkIniQBtVAV1aGO9PS+E4EWZci4xwBtgznKQxc=;
        b=Y3RU7P2hKmjWgLpMOqNwHUEK2LOTBMYayHx9qgSbYAgu+61U2g8MSNpmO4QSnBROxf
         wfJYytweIU4W14tN5qZ21/Xk1SulGadoyqP3RoRC99sHjuhqaTUUzbjdHWK5O/umGosG
         GhKqmARW/AMP2KmvhgYrYpn7sC4WaYnbURS6TF90klmiFbvF+0f+XyyDAy6B3ql/WO8M
         Vz2YihCJbxhFiagQTuBM10UBktTJn42S5moq3UNqbQM2upMltwUHkEJ7r7glIh1V02GU
         u1ydB5lAy9wlfTfOv1ZtpSqkGn7qglxx4Q+rXnREnUh4orhMESouk3wlvQFfBrUUbCE2
         f0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531960; x=1744136760;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8D2NdkIniQBtVAV1aGO9PS+E4EWZci4xwBtgznKQxc=;
        b=VNz2+2TsKKhnoqqY2Urqv/MY0uyzsBdoFXtYoUHdCBWNZ8SKrz0Z2XnKCcjMjPUhGy
         G7z3zfrN53M294YP0OlLGFgBgYjEQPgFlZfcDBcCwDvOhA5gZBzbO28/ZZ5KhjlhyNp/
         IjV6+4JawPEulcfI78IOyvLpd6gf1BO8hRcda11c7KK0cRDBCbHBL4B+UwpKwBDOQ1Po
         JBFM1U/LVf/uVnWnQSdrgzOluk8UDWQmmOqUHWJb83dPp/VHgnbi51bsIEH1JFTd8PS4
         +/ozEcU7SMQ2AHfKOc5eAOzwAYmnuUziVuZ+wgBDy4IsbFDXx4awbaG4mkAHfNNHkMB6
         kSFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTTiaAlLbIyv/kWMtJDifPFSM0+eylYU9Y9ir1d6YvHxTrbXvrnEGLFVHPTTNZ0h1IyQATRPEKW8U+Q2o8LinS@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5AVxN/vVl26VKF9Pjj9IFiGcnHwR2dM7pf9VraCLNJXvEEay
	7OS0ObX7Q9FQarJMkfIfAVO/QttF290QNuEuB2FDx2hWAQUc7/pwA5yYwWWu8ovZktHigMOK7q1
	qPI5b7g==
X-Google-Smtp-Source: AGHT+IHOfHQYMPSlb929fAQLYUOR8MaSQ47qaoqjl5CBh3biX9RHBcWbfOEBlIWhvTFZDEluJlrFNHckgCuo
X-Received: from plrb1.prod.google.com ([2002:a17:902:a9c1:b0:220:c59b:c80d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e541:b0:221:7b4a:475a
 with SMTP id d9443c01a7336-2292fa0af62mr156962715ad.52.1743531959784; Tue, 01
 Apr 2025 11:25:59 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:39 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-42-irogers@google.com>
Subject: [PATCH v1 41/48] perf kvm: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 67fd2b006b0b..a81874b7f2d3 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -928,7 +928,7 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 			return NULL;
 		}
 
-		vcpu_record->vcpu_id = evsel__intval(evsel, sample, vcpu_id_str);
+		vcpu_record->vcpu_id = (int)evsel__intval(evsel, sample, vcpu_id_str);
 		thread__set_priv(thread, vcpu_record);
 	}
 
@@ -1337,7 +1337,7 @@ static int perf_kvm__handle_timerfd(struct perf_kvm_stat *kvm)
 	uint64_t c;
 	int rc;
 
-	rc = read(kvm->timerfd, &c, sizeof(uint64_t));
+	rc = (int)read(kvm->timerfd, &c, sizeof(uint64_t));
 	if (rc < 0) {
 		if (errno == EAGAIN)
 			return 0;
@@ -1558,7 +1558,7 @@ static int read_events(struct perf_kvm_stat *kvm)
 	kvm->session = perf_session__new(&file, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
-		return PTR_ERR(kvm->session);
+		return (int)PTR_ERR(kvm->session);
 	}
 
 	symbol__init(&kvm->session->header.env);
@@ -1924,7 +1924,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	 */
 	kvm->session = perf_session__new(&data, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
-		err = PTR_ERR(kvm->session);
+		err = (int)PTR_ERR(kvm->session);
 		goto out;
 	}
 	kvm->session->evlist = kvm->evlist;
-- 
2.49.0.504.g3bcea36a83-goog

