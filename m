Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1A374E2
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMvnKqDB"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEDCD6B
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 11:40:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a528c2c8bso40554276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876804; x=1697481604; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtYWHIWRia4V/bq2E7J5Z+6HzWlGjlCMeDuedPRX49U=;
        b=RMvnKqDB/mjYDkfacXxiTR+Rw/13XcLoTBlVP4B9oNuwIR2cYbmI2ne56PbG0IMdvH
         Qku7WW5VExHXN5VbMd7kEDJgwPFaADs+48N1rgxbrhy4UVxn59V/m+xRl8Q1ACyy+ld6
         g/6hDK5HvTa6kcw4i768EL0ONXdRAhajquXngY60hq9U9wa8ibQ3xj7FEY4o5yvuYBHd
         9JTEHdK0adN4K1QVPrTtbq3GtevCqZW0x7MVJkWdOajuXOE/1CoobjrGFw5vJCjGQfYT
         5v4Ymogh5w9Q3gQ7j4nQw3h5Yh3sqB3H8woDJQBxMQ/GX+reFiy/dw5ys72be3UUiS07
         N3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876804; x=1697481604;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtYWHIWRia4V/bq2E7J5Z+6HzWlGjlCMeDuedPRX49U=;
        b=UGagpaMp+cVktdkzhkvOfCcRJ/fLfNasT9CE/ozhh+9LrEV0W86X8HkYquV2f7mRzw
         KJfAjNcoU+kYvsumjdjL00Kyg/Xk3D6RhVjjninMp7Qh8z/eke7dLxbLT2Jfp81XYQ6K
         gl2vK0MyDq/334op1blq83SspGtoOHOszN2XFHh+fQxOjHw0SaLTZEodpJCp15aPvG9S
         812ZFXAuBFgndD7Q6Er9T7js5fl9oIe8CfLtumhiMrqW5q4+1lNQ3f+FtYBbkY7yqQlk
         C+zs/8vtPaaR1bNoz49fIXxBf+1r7cPwK5FFSHOy+oUFQ2yyDs1f3T5WkJvv1xKiOFZx
         q7cw==
X-Gm-Message-State: AOJu0Yz3zZeqxLJfJJ3h/AcpOLt0cmHNho7jK2396lvETKl5au2GOFvH
	xCTl/1+UyqvQ2mNL6fpPDwCIVYNG7O5z
X-Google-Smtp-Source: AGHT+IHj2trO5X4U/SUmxlgPq73m36ZDVXtEdZOb0YxcbPMhp9sufjSs2X3h92EpXqMkEkqGWjW3ZR1z54If
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:ace5:0:b0:d81:90b6:cedc with SMTP id
 x37-20020a25ace5000000b00d8190b6cedcmr248454ybd.3.1696876804016; Mon, 09 Oct
 2023 11:40:04 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:17 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 15/18] tools api: Avoid potential double free
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

io__getline will free the line on error but it doesn't clear the out
argument. This may lead to the line being freed twice, like in
tools/perf/util/srcline.c as detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index 9fc429d2852d..a77b74c5fb65 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -180,6 +180,7 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
 	return line_len;
 err_out:
 	free(line);
+	*line_out = NULL;
 	return -ENOMEM;
 }
 
-- 
2.42.0.609.gbb76f46606-goog

