Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7227933A
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035474; cv=none; b=uMx/vG525c7Ba6Wz5uNcy1e/jYYpM3NphAkc9FIgTadDaB9WZh1UGDfqh/DU3H0z2coo3Msrn2wy1aIDfetp9BAE/ehWXneiLATiL6N42tj6e9OBoEQjsTuDqV6MTBXcQ8Glu1RX/VOFfv9cA1jK7Pz/J8xBrMowhokBKfz+kaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035474; c=relaxed/simple;
	bh=VzQZhE0elrXS34SExt1i/beojdWdOOg7H1NOF7AFJ24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUSNL14hcN2yeoFH+Rj/nQDc44jP9sUQwGH8aLS3dnwzH8AbO31jG9vFbR/MppLtZiPelK837hKFtbF7wOD0NNemCCic1gKBnJ8OW3djPMjCqpLY2l5dXpsP5XzxKwrKi9Y2J90898pC6/M2RRrkNQEWqJXTOxRXlCj6DqPfpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbnhcYvy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbnhcYvy"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7375e2642b4so105974b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035472; x=1746640272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l37BKjYgmTS4La7ggY9yiyQcQdvs2tGcaNKDcUTY85o=;
        b=wbnhcYvybqveJNUmiD+aLeNBzXFUfyX1w5VHEHZO9DdAE73EC9akdfamYEKxwk/8sP
         JGEbZy+l90qJC8fGNwIFNNKcZpsGo4gS5LUkKjz3F+wRsutQCxEZO82tiGilTNKEZUCa
         xAN/qy/pXtaKn5GWQwyk3RVNSoAeeauPfVuBy+YoCOmSYFclPeKD3o3h3BI59O9IeMPn
         4kw9N/+kGoqywfBlrmj62ADmX+b/J/MefwYift41at5Lg3Px8TBP4Dkuy2EjXrVj0lUH
         4mq/M6gy0cqpmMuBlstkLCvB6cqhpj9RKDruZgcRFEeJsdljvwzeHuX9OQqB+/lbv5PG
         PUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035472; x=1746640272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l37BKjYgmTS4La7ggY9yiyQcQdvs2tGcaNKDcUTY85o=;
        b=mIfla5iJp3n6xQaGhIpC2nyrY1zn30cdEDU7pss9EWe1C2Pi/kK9HjdXbI68Zaloiq
         iJTi8u42aPASoBW7PhHyULkajmgczWjHIEmMA3ibCGU1E6puPW4/gYFEYUOr13YERQ5z
         3Z+ywVdvbmtqMW6shpTMKJacAwUq+O3Aht8tVCvxmXG+2dqPcscA9YE6kxYNnUSjyRyx
         lxU5MKl7smor3hdZWgwk4kdowDshbjYIj1IoUWz8eUHmZpyya+jCBaxVa+W01IHSqcuG
         DVhgd2FWI+cnDcWyd08XMug3WGo8kJ4tsmNA/jr6ELUErK2RYMNDoaHbngJiZXw+r0uc
         DFNw==
X-Forwarded-Encrypted: i=1; AJvYcCV5aAbtP/q/kGLriH0UTm0cMXcyNzMsPhM5571u3lIjRpoYM8R7zKLGTlOG7eLGvxiIKugPAt3Ly3NQkb7MvKAI@vger.kernel.org
X-Gm-Message-State: AOJu0YzQM5I+xl5aJVQpQaenDRc+GqYbXn488HLrrVpxlodOIQC+ynuv
	PTKiwozSHstWYOHplwMZQJ9BYOvP4pHb7gwFJgdzHRYMg+p2MPbPyN0zvS10jbJeaBBkIO95X6n
	J97A3kA==
X-Google-Smtp-Source: AGHT+IEhkBU03JFJxZaZHJ3QPl/LFRcRXHgfBy5CcgazJaWzCjMkfX2AXQNHrPAAKAmwy/2QTqQCF6e/woC0
X-Received: from pfbfa19.prod.google.com ([2002:a05:6a00:2d13:b0:737:30c9:fe46])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:78e:b0:1f3:26e5:55bc
 with SMTP id adf61e73a8af0-20a89afb7c7mr5297458637.42.1746035471854; Wed, 30
 Apr 2025 10:51:11 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:55 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-8-irogers@google.com>
Subject: [PATCH v2 07/47] tools lib: Silence -Wshorten-64-to-32 warnings
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
 tools/lib/api/fs/fs.c | 4 ++--
 tools/lib/bitmap.c    | 2 +-
 tools/lib/string.c    | 6 +++---
 tools/lib/vsprintf.c  | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index edec23406dbc..2c4677901de9 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -349,7 +349,7 @@ int filename__read_str(const char *filename, char **buf, size_t *sizep)
 {
 	struct io io;
 	char bf[128];
-	int err;
+	ssize_t err;
 
 	io.fd = open(filename, O_RDONLY);
 	if (io.fd < 0)
@@ -363,7 +363,7 @@ int filename__read_str(const char *filename, char **buf, size_t *sizep)
 	} else
 		err = 0;
 	close(io.fd);
-	return err;
+	return (int)err;
 }
 
 int filename__write_int(const char *filename, int value)
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 51255c69754d..7491bf174e92 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -32,7 +32,7 @@ size_t bitmap_scnprintf(unsigned long *bitmap, unsigned int nbits,
 			char *buf, size_t size)
 {
 	/* current bit is 'cur', most recently seen range is [rbot, rtop] */
-	unsigned int cur, rbot, rtop;
+	size_t cur, rbot, rtop;
 	bool first = true;
 	size_t ret = 0;
 
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 3126d2cff716..638e75b63538 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -182,7 +182,7 @@ char *strreplace(char *s, char old, char new)
 	return s;
 }
 
-static void *check_bytes8(const u8 *start, u8 value, unsigned int bytes)
+static void *check_bytes8(const u8 *start, u8 value, size_t bytes)
 {
 	while (bytes) {
 		if (*start != value)
@@ -206,7 +206,7 @@ void *memchr_inv(const void *start, int c, size_t bytes)
 {
 	u8 value = c;
 	u64 value64;
-	unsigned int words, prefix;
+	size_t words, prefix;
 
 	if (bytes <= 16)
 		return check_bytes8(start, value, bytes);
@@ -216,7 +216,7 @@ void *memchr_inv(const void *start, int c, size_t bytes)
 	value64 |= value64 << 16;
 	value64 |= value64 << 32;
 
-	prefix = (unsigned long)start % 8;
+	prefix = (size_t)start % 8;
 	if (prefix) {
 		u8 *r;
 
diff --git a/tools/lib/vsprintf.c b/tools/lib/vsprintf.c
index 8780b4cdab21..62028a5eea7e 100644
--- a/tools/lib/vsprintf.c
+++ b/tools/lib/vsprintf.c
@@ -8,7 +8,7 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
        int i = vsnprintf(buf, size, fmt, args);
        ssize_t ssize = size;
 
-       return (i >= ssize) ? (ssize - 1) : i;
+       return (i >= ssize) ? (int)(ssize - 1) : i;
 }
 
 int scnprintf(char * buf, size_t size, const char * fmt, ...)
@@ -21,7 +21,7 @@ int scnprintf(char * buf, size_t size, const char * fmt, ...)
        i = vsnprintf(buf, size, fmt, args);
        va_end(args);
 
-       return (i >= ssize) ? (ssize - 1) : i;
+       return (i >= ssize) ? (int)(ssize - 1) : i;
 }
 
 int scnprintf_pad(char * buf, size_t size, const char * fmt, ...)
@@ -40,5 +40,5 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...)
 		buf[i] = 0x0;
 	}
 
-	return (i >= ssize) ? (ssize - 1) : i;
+	return (i >= ssize) ? (int)(ssize - 1) : i;
 }
-- 
2.49.0.906.g1f30a19c02-goog

