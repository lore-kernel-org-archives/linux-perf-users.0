Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506E4693
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Sep 2023 05:36:32 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2611982
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:36:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d848694462aso4381995276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 22:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447371; x=1696052171; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=No/3+lDiHVKRYv0Xt55G/Z9T7NmlV4cHNPo/aHaSm7Q=;
        b=HI+b8NbgJPYE4NlauO7YWMKfK8pTBRkcjiQG+bHJZJPDGQol0H1Rq1H1qAHxi+L28b
         Zuytsh1Nw/nT14G2fIbmJUI8hVGrKhQZME/CVW4fYI4++Qn5QEJQ4YzWJQT8NEyOCBG+
         iwfcKNnLTKm8cVKY2yiYEjbqVyjaKjQzZJl3EoepWiSBS7p1TuZL5L25fXsy0QT8L7Pz
         q3kr3zQoWjN8rmIMK+uTGwC5EI1fdzY0+30Gfwl0sk92XYesG1k1zUhPPzxm49ysSg14
         uHpiiPOrkn1UbB8QrHWxNwLGpSS65zSlVe9abOKGFmL9dXP0NfbWt4zQ9WKFXugQ2Mgh
         KmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447371; x=1696052171;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=No/3+lDiHVKRYv0Xt55G/Z9T7NmlV4cHNPo/aHaSm7Q=;
        b=NGOy1swq2tjprd9yaJC75R2eJXUaiFtCCheHAlvixaemP08LIfdkIurgOOMabXiBeY
         Tb9iC0LBOxdqi7J4EVvNHdk1cHZnauFdq8cHpqEvmvUrMCm9Msa8q/+/3KFHOh6/jxZB
         yoXfJ9tALVfwKDm2x/ZdldDcOtZVJ+BtnYq5njy7u4c8Ti84NEFAjlTljcIpN0Sxvofz
         PB9z4weOgcDX51Ud+/Ab5TCpcOMTpqQTmsGrKyJI9iXlTcp1fM9KRImka2+T7Vh7RZfk
         gbJmU7e8JZM5jSmhQw5ezaqZi69mehJ7pZBWVUhvv5y5WLajCw4XodQtMapjBrDR9yzL
         uMiQ==
X-Gm-Message-State: AOJu0Yy2FvOITxZhABWn8vehebhy4PmkGJpbFwjulL3ogYopCNY3g0lB
	MzxchRTvtWlXcLlZ4yfgCxk1Ga5t1Q+1
X-Google-Smtp-Source: AGHT+IGTM7Q8b3Ag4UtuwSpXj45aoEr35j9RQvQn4a5/8c4Gp7fonCA3U33uv8sbDogl59ChOBz4GGje4Wqw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a25:8d12:0:b0:d85:3ef:a9d3 with SMTP id
 n18-20020a258d12000000b00d8503efa9d3mr13253ybl.0.1695447370739; Fri, 22 Sep
 2023 22:36:10 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:12 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 15/18] tools api: Avoid potential double free
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
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
2.42.0.515.g380fc7ccd1-goog

