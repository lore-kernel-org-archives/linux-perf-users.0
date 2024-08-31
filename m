Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6716DEB5
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087882; cv=none; b=d8BT6TyDU64UbCqPHqWloq4w+pKrrzfnbVNzFjMWG5+oCrki/n0FBJ0qakro5+PUv5ncS7SzZ1+gXtObpeOMZDa+t9TwMQj3CXCUgoMZklz6kp7IGOI8WOiTBla91zRk6HZ77B3C6WjYw4ZDFwaVQlu3BPg31Q9dnjKKBq0m9aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087882; c=relaxed/simple;
	bh=Zzp47YpjJrlq/7aNuFnEG/sx74AzSK2oA4jiAlYD1m4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VolgSsTr29KupfMoGRD/zG1cjphz0maLU++ZdLhhFcPZinuQ+vRRsp7FlFuZF7UpHPjzxbibH6YlEc3V4k+K6XOeYemCtJTjqhhBg5hoi0TffGzBONah+xi5s5/8mJkrBPe0McvNk+bad25IbLhbsg4Pru6cxTzlMv884cMwB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXeqqu1/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXeqqu1/"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4daca4a4bso12685037b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087880; x=1725692680; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5+jy8suatSYU8agZ+1zFUqOrIedBbY+ji9A0DmCUwg=;
        b=YXeqqu1/T7EB5q0Xc87ElZRffeI9/OqXF2z6+sv10twgx0LlS2FzfyLNqAb7runij4
         LU/YsVB9jIQMI/tG5y8ZR/OjQWwJaue32N12goBcQxD82fTCF8hrv5a/3u4oGfnSIqoU
         yS6Yp4B/hKjft/JeJbQiAdetOLqgTqJ6IVz+/i1VOexTsqs4KCm/iXv3w7HXWKJVAzqo
         E4K/yNQy559qDdX6BkXYGBZyy/5lJSFR9FI4NU6vdWYpxyRFgoUWzvu1nQvrO/B5RspJ
         /KSM9ehFLRqMx2z8vD+rONSrlz6hUc0nGkFBcIsjtCJ3k4cK0WlKcrEeq7vj+PXaL4Kf
         WD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087880; x=1725692680;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5+jy8suatSYU8agZ+1zFUqOrIedBbY+ji9A0DmCUwg=;
        b=Rhy+0yW4oMq93AgItTdPKEkDB36WQmjYunHNzAFbuaByRPpxQNkJMg8FtjabkPVQDF
         jWeVKAHfqikZBb76qOJI5FekxoOSg+lqYoZkFtfg+Hzos1I2JZB6YAWJMqhERRgkBeAl
         BV/QUSNi3JV0J6P7fg+XKV53Va9mhJu5g6ufOcZG1WuZ7y/FcKHjjd3GA6enRrC06elh
         1IFBZ1qhXS5sc1Z5AhiZ0U3u3SnnlsDsUz/TmRnnFDVDHy6neb6tdfIio88cz8gVb9/f
         S6BH/XUJpF4ZBeFeK41DeejvwfUM2RmpgmYnw57F5/7oAQYoVPoVmkiMwxplnJ2y8qdQ
         ZYzg==
X-Forwarded-Encrypted: i=1; AJvYcCWsuGVceft1NPvHd3lDLKLa9W17wqnxYTwhq2ZXepuvJDTvN86EEsclE5e58j/ZJOZDTinM0QG9tnC60FQ414Sr@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfqRj/P7ZxmQ4fH0YqeBdfzoYLluEpnmRD3aFIvLi8F5lNygs
	P2TqX42vobDI1rUr3+dw4PRUZE1hsw4IhgKWp0Fb9x1Byd54VfO5jaxMp6CCQbHbsa1dVWB71Ru
	QajB1BQ==
X-Google-Smtp-Source: AGHT+IG1XD+JUjlCpgglYclPZZLQJ4BWz+jqR+qm5DgB0ka+M75PUfqNm5Cwbhc6EFTAGgHWlo8uxtzePXRt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a05:6902:281:b0:e11:757f:30af with SMTP id
 3f1490d57ef6-e1a5c85d46amr83900276.3.1725087879809; Sat, 31 Aug 2024 00:04:39
 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:15 -0700
In-Reply-To: <20240831070415.506194-1-irogers@google.com>
Message-Id: <20240831070415.506194-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 6/6] perf test: Make watchpoint data 32-bits on i386
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

i386 only supports watchpoints up to size 4, 8 bytes causes extra
counts and test failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/wp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index cc8719609b19..6c178985e37f 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -20,7 +20,12 @@ do {                                            \
 	TEST_ASSERT_VAL(text, count == val);    \
 } while (0)
 
+#ifdef __i386__
+/* Only breakpoint length less-than 8 has hardware support on i386. */
+volatile u32 data1;
+#else
 volatile u64 data1;
+#endif
 volatile u8 data2[3];
 
 #ifndef __s390x__
-- 
2.46.0.469.g59c65b2a67-goog

