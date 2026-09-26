Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A43911A8
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449497; cv=none; b=BxzY1DmaUds5peNR7tYAO5GoiMnO4SNcsPPGw4IKmV3qFzx0Ls2U3gyTy4Syc2i6Y/RfqPqCoQnx6eQ0APGtQMQDpdJXGgfXhOjhfGHmg7Z1sWAOB3Otj/tsJzH8KabwCjyslFxIhw705kdj9tSrxI2mk7A8/fIGAoAvmLFvVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449497; c=relaxed/simple;
	bh=V3XiUh5nnx1gn42dOp/mUNnAwFgjdsBCrh/AMawRcCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqx8+fj2kRJlkitWAZ4EmL71T195GzkPGGzbc6cyq89YwRQEKmIpghajsmIrpiJkyS6pivcWyR2soB4jesxLVPUhOaML7OUmEVMaPIgFjgn6YTKJfvOenojPpDnZcALpzblBHDuY7sSTvU76uL78D8bizkhdgV0Ecrof19zpn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6YMJLgZ; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6YMJLgZ"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48877902c99so1670091f8f.2
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790449493; x=1791054293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Z3mExGBP/NAQOTT2WR7fMc/rt+qt2PR/9Q+VQL5svM=;
        b=E6YMJLgZ6MZjiYFv8jvh07mLItu8W45RaqGd8MND/T81sCL/mApODiLRGEgjUGtN8X
         EHLNjgTUgbeA1uPC/jL0EhG/NLFX87RYH5hBiRE2jxyt9AnjAmPD324M3AGWpjT/jmjS
         ygwnpEasLeFVBfD6lzEbZHzSWpVyIBaJP39Em4QYsTCukRxKOwAH/3NyOx8jYPe7AMkK
         TGAwCi9WCRDISKomYFUC6KfVhxgGfvC8ATzvLN53vPEly65BBkR3mKGHRaMlomqZnCkv
         JBvuluHYr4sKPlp561CRyANqXR4sP6zS++OiknBBv+zissFF82alFJaGWzjQHjv8cHd4
         ZW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790449493; x=1791054293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Z3mExGBP/NAQOTT2WR7fMc/rt+qt2PR/9Q+VQL5svM=;
        b=kttli5RVH7R1Jou/kHjol4SDS2VUD715cCCoyYhmZJsDdyavagjCn0OaERj+9EnyUX
         AzteF6T3E13hHjfXc1ZBouqitmGFC4I6/HKi6NYaBYrMnmHMg1qyhrCWTkXFBTZGrf2h
         JhX67rD2S3h2gTxtdoyJrx/dgWdq/gntByVseMaspzt/ET6dx3bItmqh8T5mPQRmFsqx
         CrGjBd8ix07zO+pyYlaJu2FR1u86lgM1ehyW58Z2fDyQytlERlVgilOhp7m0cj4ZPclh
         RdMWxRkr4aGCHrjrSvt/xnbU/VDO5aspGqfpsAs1RjOHMMCej/u3PZFjcvkUkFuXzX5R
         m9ng==
X-Forwarded-Encrypted: i=1; AKwUvBwPIbnGfYwZmo6eWsPsFkpSVMJr+tEsvvSnPWUjIwWtq9ZhpiB+8KeYAncbXYlvpcpKPIOU8750Aq7QFSzj1mpJ@vger.kernel.org
X-Gm-Message-State: AFq9FYLepI9u6o37vLgYgJdf1r4KjHC6bVboDtlvE0+Pf/Z+RVG14XfW
	BdTlhCSM8mkTM5KWWDNdbZ81jCCS0Oa4l8i3J0iAYFt9QiYp4n7ZGRop
X-Gm-Gg: AYBFou13KGs4NJrz6IZlJjO2Pgy3SgKvGxgYP7UuLGgXEItfbcbDVojtXHvG32tFyEq
	KfjFLK8uKPh/xAyz55O8iqwhT8tV4YEcN/b8rTDuXeFPDOFdiD9DNR9PIw6KKPcLDCLukn7r6Rc
	YtUySv5ggG9ICG9w2+fz5NwNjoA07l1C0MPNOi2Usa/QB6Pzl/dq7OTeebYg7ijwn51sP+d+gb3
	zxii7VvdbkXHAqlBkpYL7EyRvkihHD+TuEyzSJlQE0GKI227fvgaTBo3OOkNHq0t/83FF28N1Og
	djZARcz2a27N5VWElgS1T3AxqjGoxEfNFcbG2Nh+KgEu7JjJhJHnQGr8s41O749+jt4c0l01gvD
	VpTzJ3518WrSyA7FU1BUvxPZMQMBNfR0g0rYFlVGHN5FxR183HGV9jhVoCBNhOjzVmQUaIoNFiR
	aAKUI6bY1RE+/VyxKGowUePU9SfOP+nAdXw6IYEoNseO0JrZEl3/3+Z71rAA9k42kBG0RjfNRce
	lMIYtCDXrekZUrUQz/oCsS6iVa27h+0GXcQ1zL8RNFwISeRXIk1PK7IoSTmqvCNQ6FM/lXJPRIN
	6pRQEz5n1wa7E3jpJjYidiWj1hZ/uYpb7Wmjqyioiabp69ilDCQ=
X-Received: by 2002:a05:6000:41c9:b0:487:f31:8037 with SMTP id ffacd0b85a97d-488716c227cmr16665554f8f.14.1790449492843;
        Sat, 26 Sep 2026 12:04:52 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm15216880f8f.9.2026.09.26.12.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:04:52 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/8] perf bench futex: Set the number of hash buckets in futex wake
Date: Sat, 26 Sep 2026 20:04:01 +0100
Message-ID: <20260926190407.1106421-3-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926190407.1106421-1-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'perf bench futex wake -b N' fails unless N happens to be the number of
buckets the kernel is already using:

  $ perf bench futex wake -b 128
  Requested number of hash buckets does not currently used.
  Requested: 128 in usage: 64
  perf: prctl(PR_FUTEX_HASH): No such file or directory

The other futex benchmarks call futex_set_nbuckets_param() to ask the
kernel for the requested size, but 'futex wake' only checks afterwards
which size is in use, so the request never reaches the kernel. The call
now happens before the run summary, as in the other benchmarks.

Fixes: 60035a3981a7 ("tools/perf: Allow to select the number of hash buckets")
Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/bench/futex-wake.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 66d30ca91405..58427bb55c03 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -175,6 +175,8 @@ int bench_futex_wake(int argc, const char **argv)
 	if (!params.fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
+	futex_set_nbuckets_param(&params);
+
 	printf("Run summary [PID %d]: blocking on %d threads (at [%s] futex %p), "
 	       "waking up %d at a time.\n\n",
 	       getpid(), params.nthreads, params.fshared ? "shared":"private",
-- 
2.43.0

