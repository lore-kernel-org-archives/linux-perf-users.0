Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3E215F49
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531889; cv=none; b=KKKhbUawoFKk+sxUOygcD4zcdlU/BO66+MUTsRMkwbw/ApKVWLnTM41+pwyynzsjqeuOsPPs7Qm07hexcEBt+w7yXSngfz/mOzZL11OXdoqwDrlId4x1sTAe7o/Tb26RFssFZHZejuFgftjC3XelGSVpMtgKfNZlx89UN3+g3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531889; c=relaxed/simple;
	bh=bs+hau3BfGPgjfML6AAaTQNI5hHZ1yXB3kHmZBCp/iY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DgQhnRVg8vLrdmysN3KtNKyIUsLABUh4tg4i7o8DcQkm2VuM2pu8foFswROzzjs06rl4aIs6NmJVFRO+XJcuxekUYvHsZbG1D4udUrxvdrw9vu/kuZbeRlbw9TzJHUf6ltUN1iCVzUBOD8BeLtK3SZ8dgY+6QKUNT4dcI8pXdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBpfMxEw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBpfMxEw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22647ff3cf5so95122715ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531887; x=1744136687; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lwp5jWQnZd0R1nLl4eHrnW+r9QoCXnSEZWGom8Yr2/Q=;
        b=sBpfMxEwfd1NRT+Y+pAIN3UbmexwO1YefWWSh6dzfKVBdfH5ho7RwVChIKFABnWzpV
         f0kA0ctbdxzXjbbYXrKxo2YH7+f0TbTars33RzFp9CuhFPHP58ZH3SMrPRbouO6WL4yt
         /C7zqzT0PoLLZ1DHYDhpeoM7UTK3R4OIoaP3leNYewwzTeq1xGkPB5AOHJo8KBt6ESZo
         7bMm9COb95W3S3ocqLz/7ajttBHVcLL/+YiCKWB8nugLX8vtTs2eB7k4YD0kHjB54/lB
         V5nIPTDkJCy2XTo8uOfJkNaw23sTIkITp2yGq6DyCYs+k2RK01b0opXJUtCp2qCHirDI
         cxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531887; x=1744136687;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lwp5jWQnZd0R1nLl4eHrnW+r9QoCXnSEZWGom8Yr2/Q=;
        b=H7rlpMcL8YAA8e2EiKqwDqcT294CiX4euU+LrewbVOz0vzl/1Vk3opizNBVmF1u0/e
         3izZx00Gtf+vVtW/oxcUWQQ1uln4A5WwuQKP+5ciAQVnEPR42Gag09vRYKhTffMUJvge
         NHxpLph5F8QPMRaOIz7og7nPqr7AdD9XvETD2OStPdbmn9iciByJyyN4pxCB6Tnghv9N
         JM1gK2v4HML9yHUuwuHqLjKxHpsWn33XyroCufDe+0H0Nz+iMcN7wYm1uEVpa5MoqLaE
         Q2Vkt5RzK3qtxn4emh4ULTcR2PmNKzQdGo7MhXjRDPvNyPQQsSHNcAYr9xIzBU7XpGDP
         jRBw==
X-Forwarded-Encrypted: i=1; AJvYcCUBvMIZ5USO6nxW1cakGSrQ0dEe3yS0lw4VlRsqmTdO+ierbB1qbJs2GS+iQw8vDaY6ZW4mCqzLXKqzK+i84piD@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMPX7HBDtN1Lop8TnitjX42DjlR0iIcJkwh7cxA6svnnedvWC
	eId6Rkm1aTOEkb4D/mvj5/gHgr9GFbej5DW4ozyyBvciAoG241OXa5NvwUSYI8o0gu1QkwqxdVs
	E75xm0Q==
X-Google-Smtp-Source: AGHT+IFzLtYxGxyTxV1rkwdh9UBSEEBVvK00y1AbRI2exTnDGJCaOS8iSdXoMves7V2W+aK2MyJ5/OHSrlvi
X-Received: from plbbh9.prod.google.com ([2002:a17:902:a989:b0:223:49f0:9077])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54f:b0:224:584:6f07
 with SMTP id d9443c01a7336-2292f9e63damr210311785ad.37.1743531886714; Tue, 01
 Apr 2025 11:24:46 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:03 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-6-irogers@google.com>
Subject: [PATCH v1 05/48] tools lib: Silence -Wshorten-64-to-32 warnings
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
index 2178862bb114..87bd15e3968e 100644
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
2.49.0.504.g3bcea36a83-goog

