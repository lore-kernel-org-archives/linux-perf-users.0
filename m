Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251B405E6
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ti0BxZOq"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD51FDD
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a9012ab0adso61331557b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186291; x=1698791091; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKH/5K4bvubvIr9pw7ZYc/Z4ET3hwQ4HW4s3RX+AQbw=;
        b=ti0BxZOqkKM1O8RMMAUyNmmZ2o8mbX3dMm8Vjr/jsi/SElnTLRGvvf7tm75ekFnwiP
         aTja6tBcUnRlTYdAa/U5yaTaroVUtJWEYClh9UtPf3AR59z5jFFreWEiQzusSQnVGRY3
         S3OLHaoUGOB4ZHSNhCYtNRDALBRJ6eGzSS4AWWWDf0TvXoUOCWwbmgX7ZsTzq0+S74/B
         Ahn6YidRiKy/TTgwUS9p/Cnai3YnI5tyiTz7S6UBux/y8JM1d2ch5KkkZPaseNvy7xx0
         ZeX0cs0pJ6lhq1L9FybhTefYg7fLVyVZG5gYtjm/N/lm4c306xGJDGGw6kvBGfSvO6uU
         Edbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186291; x=1698791091;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKH/5K4bvubvIr9pw7ZYc/Z4ET3hwQ4HW4s3RX+AQbw=;
        b=bEOUEZ5s9o4gYS6//ZYOSEbhLi4BtvocNxpd/G20hZn+xPCdcZhpKhQurpu0SpBsIA
         LAL7rOhiWxYAFYYe2rHm7ecF7icO4Jy0yVTDKvONlZar76NLj/zSReMqZHWUWR7/h6qG
         wkWexgl+KMxQhONuNIbG2O91fg33AJtFIXmNZhhMj4cafdj5oA7pcSTj27eOajsdefUv
         cGJLxK36ajUG1qiIEnP/QYRxZmTbS/51/6AY1MJv4N5YR47nWTzJNSdqEazCuFdsTy1r
         b9RPnHP0522+z1m9+Xiki3PAz2DKGTVF9wZOh0bbsP98/u+C6RlcWQ2egYUDf9YoQMoa
         oPUA==
X-Gm-Message-State: AOJu0YzFoJze6oLW3VXD4ODQ7xAdn/c9kqlieH3rzANFI3UdecVa6HGP
	gynUE41xDvMwD30aY5JEuwi9TuKtKTCh
X-Google-Smtp-Source: AGHT+IEA4x6jExeY58G0RliZSteprXCMSpH7tFe0ZHu9NiKL3F8kX6ZLzfPBEolCHwOezoixk0P4f6/+giGa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:eb92:0:b0:59b:ca80:919a with SMTP id
 u140-20020a0deb92000000b0059bca80919amr270216ywe.0.1698186291218; Tue, 24 Oct
 2023 15:24:51 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:20 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 17/50] tools api fs: Avoid reading whole file for a 1 byte bool
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sysfs__read_bool used the first byte from a fully read file into a
string. It then looked at the first byte's value. Avoid doing this and
just read the first byte.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 496812b5f1d2..4c35a689d1fc 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -447,15 +447,16 @@ int sysfs__read_str(const char *entry, char **buf, size_t *sizep)
 
 int sysfs__read_bool(const char *entry, bool *value)
 {
-	char *buf;
-	size_t size;
-	int ret;
+	struct io io;
+	char bf[16];
+	int ret = 0;
 
-	ret = sysfs__read_str(entry, &buf, &size);
-	if (ret < 0)
-		return ret;
+	io.fd = open(entry, O_RDONLY);
+	if (io.fd < 0)
+		return -errno;
 
-	switch (buf[0]) {
+	io__init(&io, io.fd, bf, sizeof(bf));
+	switch (io__get_char(&io)) {
 	case '1':
 	case 'y':
 	case 'Y':
@@ -469,8 +470,7 @@ int sysfs__read_bool(const char *entry, bool *value)
 	default:
 		ret = -1;
 	}
-
-	free(buf);
+	close(io.fd);
 
 	return ret;
 }
-- 
2.42.0.758.gaed0368e0e-goog

