Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EEA268FF9
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035546; cv=none; b=qI/Cu0BV9UsAaP5RIfA3ijUYv0QXlOnopB2T6MtHcND2UcHLTPXrGRI179/tqwuUkMA7jCSVC0BmAvTPpzz4+bGP/w2K5fEzHruuN86/I8CC1Q29DQ5ZtPhY8JnKA0/E4hQUAAG00xQtV03XI5KFOU1F9SkqfkjD+0Q6x0ZOcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035546; c=relaxed/simple;
	bh=SChJhTbUNPg1ND5dFZYx1lf5bG8QjJRd5Qz/8x8RQGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZZWfGLsazbIUic4N6ck1T9PG6fy7+yppS/XxHB3vNATPEHNmT+j7JdmGFIOFYZmXCBEYaRVFntBfB/e22zz947WU0TV+H2d3s0C85Ga0GfyYilpBVUUsA+dqsfaFVy24OJ/6zZB88qCkeiYJsDJlEBv6mIZ/pHI+KgYbS+k6Qkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kjb3b9VW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kjb3b9VW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30828f9af10so203053a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035544; x=1746640344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PttgRlYacSl4neWRZmL9Egf25cjRBgUThY4Fgt+xSRQ=;
        b=Kjb3b9VWr32N0jTCYH2KPQd9IJmDSW46RFCOVMYDh2NzHnFsdHY4xGEWP8z4/2+8En
         8i53eiJlehcdEgFIKidamWCkFjFIZ/QvBXUlyfWhZmgRuEAMzYqCd7ZoM9Y5E3BRhvkg
         fG0VTMM8jiLzVWhCtnafGajeNEq5ys6DMc09ypL+UeRX9LQe2obDJXaVwySHPHDwvO5P
         Ii+4hnb91wrUwMENNc1Qn6vetgnksM2ME+/OEJ8bwQf9qanxdh+u8JNx1Uog3UGF/6t8
         bxYA5dHP7ozvI7r/bQtLX7NB1abBB6lmfecnuVdVKH+qAMFEMPFgHWJl79a0Of/fo31E
         wvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035544; x=1746640344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PttgRlYacSl4neWRZmL9Egf25cjRBgUThY4Fgt+xSRQ=;
        b=pY7U47GIHdqT55UctJtmEJilSRpqFLnWbkh92SVGh3jVsdCS9nPAhttVrrdpvBkIj8
         cGGC1ucwA2JsY7AI56yyhJJEA8P/CwJEAhXGoW6FBTG6UO7qpzcSpvqUT+5DQ8oncbce
         eali5lD1wsx3vknHQEQg+OnbwYnBRksmh1pTQ+j0vgvgwgHsx7U2TyYb1kyIskiQH3c7
         Cpt0UqY+9f35poPLrFlmrVps2nWlUa+NWhf9Jhu/tK5we944UwIpVxdezK6VShQTR/Tf
         zlKzPwk5Dn4rwUpk7Nk6OpwepKxqDCpt6rv0Xpzpx2LpkcwLfcQmittLUFyvV1z8jQQ0
         SZag==
X-Forwarded-Encrypted: i=1; AJvYcCVuaSlXxO4f9UsVVH4Cu/C/8WLmz8sP9xgUULeH8o0ZlhJH2szROMe89vjs517x0Y2+4bc90Gp6LEL4o2kcxBO7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6P967F4fJAJPbt47Tm9pkE2wSW3+LuQBLTtgCI6QJL1DkGVLZ
	buSmoPHsT5QxmFJxPYSTfvQoZBt39TYlhJkJn0ZnhYx4sZySpDbdHKPN2fR1qvK2dbpsMCQL/pT
	V+cN73Q==
X-Google-Smtp-Source: AGHT+IH609WX54b/JbVgl93PVIkC18sTffKfTUp//AJVPoOBnLr2z7CYeICMxOSMi9XQ3JkGUed341rCFivT
X-Received: from pjm4.prod.google.com ([2002:a17:90b:2fc4:b0:305:2d68:2be6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4984:b0:2ff:58b8:5c46
 with SMTP id 98e67ed59e1d1-30a344025abmr5485273a91.8.1746035543977; Wed, 30
 Apr 2025 10:52:23 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:31 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-44-irogers@google.com>
Subject: [PATCH v2 43/47] perf zlib: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 78d2297c1b67..d30597701fd1 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -44,7 +44,7 @@ int gzip_decompress_to_file(const char *input, int output_fd)
 		goto out_unmap;
 
 	zs.next_in = ptr;
-	zs.avail_in = stbuf.st_size;
+	zs.avail_in = (uInt)stbuf.st_size;
 
 	do {
 		zs.next_out = buf;
-- 
2.49.0.906.g1f30a19c02-goog

