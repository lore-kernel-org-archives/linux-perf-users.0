Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CE23D6
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQHUhy3v"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA15BC
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 00:18:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405524e6768so18449365e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697181496; x=1697786296; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbVF/4xx0+0vu2fMTNsv16S5m/ukxWZpS5bYJMmX8qM=;
        b=fQHUhy3vDUanMdrmzzXVux/ic01wJ2iX9b/aUS3feozz+Q62J5P3f78MZYWrPV4e93
         h4VM4iAZmmMqZomxPyD71xCjsghzDsANXlwyFgaX0V2JiN8FhMqgWMnYuB9ROf7uKEz2
         9HNGVpZ9XxVDpTmWbJWc5CAOHWUeUGT3/p/WwpjZf3UIgww3spTtLpg7k0Pimswrfuxb
         YHGMYxQ7z3wM1Py/nCj0Hy6J+9Caq5JN43KL9QNzYWaLgwCs6PtcoZmy3NS/7xG/wWn8
         C+o4KWGz7Xvc9/a5hRlJwiD5vZ3hPVuZwRBBLr1Pr4B/+GtRKZsCLmJS6P1Lxuhpfp0J
         5MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697181496; x=1697786296;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbVF/4xx0+0vu2fMTNsv16S5m/ukxWZpS5bYJMmX8qM=;
        b=FnK2kajAkyWhSMa6K7TxWvsHnpM9p7I8YABGmy1KKLgQcIwJuCbkAHq3LpJD00YoKH
         OnTulpAOqU8yA1AmE2LJ1VHNMky3mwTZK3v7lvapBc2Kgj2HJRK9IlXTiaW2nzS4PsRj
         Rd1T8gYLbEK0HF1rw0gyWyVfTtc6ZcBBT+dT+0K51U01Gjn7X8aBUltLGXUkxen/tPtm
         yrfKUtdGqrOpM/LoemxIL6w8cMpkBqOXNzuLv1Gibn/7HKNMbDSeo/21yPPbxdOVMWZ8
         nBVewYoElu+nAfxRxj0lRccMmV9PfV32AyTgJjqmYLIh1e33sSycOmstP0dciS8GRP5v
         bbzA==
X-Gm-Message-State: AOJu0YwvAmN4skFoqxkGKmmHRHDEsJPpEw3ln59ev8weaWoclYvSAs+0
	TiXq9ubxxrIPaLUj7yuYuHJJ2Q==
X-Google-Smtp-Source: AGHT+IHPY0n8rs7CXdxLey7IC8iyznm9iVum45QuAoDN95dpOABZsLi4neDzIKvm+jTtIApmyuc7Og==
X-Received: by 2002:adf:e542:0:b0:31a:d4e1:ea30 with SMTP id z2-20020adfe542000000b0031ad4e1ea30mr22635389wrm.17.1697181495839;
        Fri, 13 Oct 2023 00:18:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h12-20020adff18c000000b003232380ffd7sm20203133wro.102.2023.10.13.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:18:15 -0700 (PDT)
Date: Fri, 13 Oct 2023 10:18:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Message-ID: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some of the error paths in this function return don't initialize the
error code.  Return -ENODEV.

Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/x86/events/amd/uncore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 9b444ce24108..a389828f378c 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1009,7 +1009,8 @@ static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
 static int __init amd_uncore_init(void)
 {
 	struct amd_uncore *uncore;
-	int ret, i;
+	int ret = -ENODEV;
+	int i;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
-- 
2.39.2

