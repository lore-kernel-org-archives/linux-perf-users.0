Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33512436B5
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhDVCBX4"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E5E18F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 16:09:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a213b4d0efso21308177b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2023 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547349; x=1697152149; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2XqQMJ0GkpZoKYBOeb+AHUkFWOwFAfTNDekNOfqFv8=;
        b=dhDVCBX40y5B0cotpbQmfRlDiY983Jxw+B+ksE2VxDNGQrDNqQHwCSamlheGdTV0i4
         t0s+PAmnL/e+aU4zdEJLoS0St61Qc8CCAojtb7DPsl5Uk+AqtWsO26z8S1nPinspNIF2
         p4LqZDQcb5Cw7aEQnMnKgI/PODEyW1zxCZjVP355JrJF2W/aFOnTczx1uuK8jjtDTb/J
         u6BQF/8SA+GNQ0e8o+dTAk43PYDL2iBV84Llj1Dxd8vwxqWMmjWjA8jJrRbv3A6QK+3z
         b5uKJFJ4x9cHMYOyH//EsRPdrJ3WiYcBV/NeNOAC+9q5nAs1GNc8feFXgCMUOL3ICuqz
         cGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547349; x=1697152149;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2XqQMJ0GkpZoKYBOeb+AHUkFWOwFAfTNDekNOfqFv8=;
        b=J2kUwaDdJwhP2gfwkD4JKIlg09uIHTkFr6P7STN/oinDWoJAn87yLVUwcH3Wu/NqXH
         D0/Cy4PfvZ8ipDhahKn3NZg4uCkoKtljpWTx3t15rqpUlO0P/DUq+VYR96aFwTMMjfW2
         FZwdNE5pUWnavmj4QUYLLot88J18XisbdOq5Xn+3Zp/Q1BDQJtY1NZ5z2MXwyTvo4POr
         TBZQ5PrusycJAFo8LW8TQ4kRJX4XB5OizLc3Vwh61twHyxoEQsZQOKQaJcMun3bYxsc8
         g6UTSMLs2pla30eyPGyfUW5CYYCafYlTwQo8kLbqrnTtBv4LVX6f7aTDO0msWeShdyer
         jxcw==
X-Gm-Message-State: AOJu0YxKP8HMmnfX8DF0nuutVWKwNOugWpeTsdFQSHf8W5aqxmdaaZ5h
	DSBVBrnRsrUT3bUotYiHVaJYJerGablL
X-Google-Smtp-Source: AGHT+IGfGlEcR5cafu/s4l0RQy8FE4MK3zRFkQ6Zp8BoRNaDEtxn5kvn9B3Xn4doaEJk2RCpa1Y7G/TCwC7Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:a9c4:0:b0:59b:eace:d467 with SMTP id
 g187-20020a81a9c4000000b0059beaced467mr116956ywh.3.1696547348754; Thu, 05 Oct
 2023 16:09:08 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:38 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 05/18] perf bench uprobe: Fix potential use of memory after free
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
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Found by clang-tidy:
```
bench/uprobe.c:98:3: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
                bench_uprobe_bpf__destroy(skel);
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/uprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 914c0817fe8a..5c71fdc419dd 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -89,6 +89,7 @@ static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
 	return err;
 cleanup:
 	bench_uprobe_bpf__destroy(skel);
+	skel = NULL;
 	return err;
 }
 
-- 
2.42.0.609.gbb76f46606-goog

