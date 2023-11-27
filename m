Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COmBgx4L"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D512C
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:32 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cb92becbf6so71001307b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122972; x=1701727772; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujtQ3QhQpwDoNxv/mBiBRV+6eibZuimyXiHKFflebSQ=;
        b=COmBgx4L1//l84yqThO705JA0rnfhKDL7zGmyRiscQFiJ8m1D2SSwPk4sAaUUMvmTg
         80yYZQ8UEmRQjs7qeURMKM5phtmMkOF8smhRPOaKSdtwjrmHXNuvWNyg1A/JcrpQUkHz
         BZZydtTZ+jmUEHm2/dNE3v2ovnfCD972cm2w+yQrrTM45qO1DlKSF5R8K/vUn7g094r0
         5ZrgHetW1dEjIHlPjT9TxpKQPx65u1ebrAUpzsszB0gxzVdP2nA3Lva4sRZyd1stXWv9
         UajzHr0cAB1lMbHqK63cs6NeCyjOJbryjQ35cioSjPuwu6tc1BBTzXOOC1H4051lteww
         mapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122972; x=1701727772;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujtQ3QhQpwDoNxv/mBiBRV+6eibZuimyXiHKFflebSQ=;
        b=MXnEkXfu3sZvmO2neYgGa/MsgjC7cD7XeG3Nx85zKHA5l56nR/087e87Bn6LQX/ttg
         aRRTKgDUvphNav4ihH1aiExkzQ2mPRSHJj2vhuSHkhEJNPcXw+U3aN+aFtJK05uQVhl5
         4lyQkQwW1djrmnQV2Ok5Tt6AXM/c01OKUBBYMP1GH3jN1nY9RuQA7pPMEV85fJ7Ld6TN
         NTfGC+wI6H50M7DhPiI3sA1jmxVr5xwRbv+BcyKaQDU7klWuO69/wmcHLbwlfUBP28zm
         mtaRRDLdTnIeoZaZDkJstme3q54sAJ7Nv3ttaqRLevrTWbjyuUrrys10oOEehr/yzVpp
         4GYQ==
X-Gm-Message-State: AOJu0YxK5AeEfQkuebXgv0EWzYJd9h/setSgSyaSGuw6eTXKRy0BEaWQ
	yfBDThwRX0yEPBIChLDP7q3BbHCllFL+
X-Google-Smtp-Source: AGHT+IE15NVm0P2tzub/k7bVxns1jsuHZLV+W+ubNfzDivu1+mCTMHwctkrWJwb3d1cSHMdlaehOprszJXNj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:3105:b0:5cc:4276:1c6b with SMTP
 id fb5-20020a05690c310500b005cc42761c6bmr362765ywb.4.1701122972182; Mon, 27
 Nov 2023 14:09:32 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:17 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 05/50] tools api fs: Avoid reading whole file for a 1 byte bool
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

sysfs__read_bool used the first byte from a fully read file into a
string. It then looked at the first byte's value. Avoid doing this and
just read the first byte.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 004f2af5504b..337fde770e45 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -447,15 +447,22 @@ int sysfs__read_str(const char *entry, char **buf, size_t *sizep)
 
 int sysfs__read_bool(const char *entry, bool *value)
 {
-	char *buf;
-	size_t size;
-	int ret;
+	struct io io;
+	char bf[16];
+	int ret = 0;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+
+	if (!sysfs)
+		return -1;
 
-	ret = sysfs__read_str(entry, &buf, &size);
-	if (ret < 0)
-		return ret;
+	snprintf(path, sizeof(path), "%s/%s", sysfs, entry);
+	io.fd = open(path, O_RDONLY);
+	if (io.fd < 0)
+		return -errno;
 
-	switch (buf[0]) {
+	io__init(&io, io.fd, bf, sizeof(bf));
+	switch (io__get_char(&io)) {
 	case '1':
 	case 'y':
 	case 'Y':
@@ -469,8 +476,7 @@ int sysfs__read_bool(const char *entry, bool *value)
 	default:
 		ret = -1;
 	}
-
-	free(buf);
+	close(io.fd);
 
 	return ret;
 }
-- 
2.43.0.rc1.413.gea7ed67945-goog

