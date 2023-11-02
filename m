Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432F20B0C
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3W7iaMIP"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31F9D55
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so17604307b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947892; x=1699552692; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQDO1z3HzTf9lqy8F57xj4IdkjAIJI4YmDCo/V9kva4=;
        b=3W7iaMIPuvUaKeYlP7mwPjF5hMihBjGyYmyG1XgN3UjeXdomAPaJrjxpmVOT7zxgbH
         pS6rRuE9sSNlNINxQAuX0ruABGrUmfu/+bu1q1gAeUkC2qR21K/aJaShq8EiNw3Lvxge
         xz/2jgbcH82CBXg5hJ9RQgoNmqScZe7p5CKg5iYWYkbNSknWKMqPMSpIqaaXdqAnks1H
         hAq8BTt/7C/DSkcuMktOmrosvbZA0CjDbj57dDoUBHXdV/SKl+PlI1K0SneetrBRCq0k
         a6VyRuBBZyl5o6ZoydVZ6zPjAuuvzq+JlttilJ0Nt1BGtPxIZdzdZgUVhdC7a2cd2k2h
         UJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947892; x=1699552692;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQDO1z3HzTf9lqy8F57xj4IdkjAIJI4YmDCo/V9kva4=;
        b=CgqWBYWGaRNrW2ixiIdJrWjOt57B1s9UedhtXP/T91ICYETKj38rrEG48Pdnmxm8Fv
         8/2OBxR741XCqLwgIBYRJBD9keIuikrNDhfEESmEZT6kokjnZMG2rErc7BxQl6gzkiyU
         SWR3krvanqJL4/4bj6cYFEs/u4okhfpESkHCXTJnfMonq3/pu3sq+g2qj3Y21r0f1VRP
         /cZ/oZJ+v/f3mxkF6/hGr7qREBiPGqrxV4ixVqKXwuLlVT7Ioyoll1l4LWmd1dBlXMnU
         9Ua3iHkQVgQXWNQkA/8A+M+YciK4oWkjk4Y1S3oRM0CJyP82qIehdlILWAYyrY1v34r0
         rbdQ==
X-Gm-Message-State: AOJu0YxQwpFzKvcXjHeZK0cOUGWzkPCV+vtmK/dBstByu6kgN1JimnBa
	m0XBd4Dt0gxByHM8HURzU3qqUfPQnCI0
X-Google-Smtp-Source: AGHT+IGytIo9MZ59PK1OLFp7dn9lFWthEonyvFlsVlhUziFSusNeT7JmbqtkwXtkA5ufohMiFWyK8MJ6L7uX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:a14c:0:b0:59b:f138:c845 with SMTP id
 y73-20020a81a14c000000b0059bf138c845mr8439ywg.2.1698947891880; Thu, 02 Nov
 2023 10:58:11 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:56:49 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 07/53] tools api fs: Avoid reading whole file for a 1 byte bool
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.42.0.869.gea05f2083d-goog

