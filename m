Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7A328B67
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627770; cv=none; b=lOp0oUf7v6Ivu4jxTyzRal1IOx2pTGoghvXtpZBiYXw0xCzmvv0439wl4n6I+pLHHQffQP7a5ji4px1wI4tyOUQa5ytOW9dgHFN1ChUbinkQq3lloSaySTFxCRXYhgG+MRYLWUjlUNR8fXZ3iNYK6jEdeYgmJ8Keav6be9Zz4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627770; c=relaxed/simple;
	bh=jfaOMIZp5WWV/XUuIQcu/j8yYwwDPuLLQ0zeJYIZN0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WH03gxzykRF44HA1yrQDSp00/9sIZwts+OxKKFwRlvJW4xwStc8RcAsfFWXBs9aqZKZV1mNoDardQOQM+XKU8+ectm9NXJzETGrRtwQuBlPdfawX5KF++5hHilBqo7BwtM8i6p/8ZFw4F38j8Mr/g5XK92fBLuEwW07asXJ+i/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbtQeZAD; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbtQeZAD"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11b94abc09dso5088509c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627768; x=1769232568; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QanJEL0okHblW7w6/vRkxVN/qYTBTTJdOuW3T6wN39U=;
        b=XbtQeZADhCi34N0wzrefecAMIgbsb8S6mmfSHX/UVUbE+MIakB5VpylKyXzE/yx4Kp
         F4WKv9bjIqgGnjq1iIB8D5U2pkL4yRIxYbgHU6/EBIPWxcLDKqnmBjANwVNgV83QKP4E
         1Ym2j0QP2nrgDaVy6xhW7VIQ1E6PxGBQv8ypYOWIKyXuwNerZxQ49hZ92Vn0w3dqxORS
         PDH5R9Otflr2FmK99GcxDtik9UL154/+Gsx3dE6B8TseMwksCNKcmEwNtrt7dzpxKsaW
         zqHapetdZpEznHQMWyA/OdFxK+YvOyO8p+4J8FM9H5y4Q+xP3rT5gSYnt6Z8s2wc8tGJ
         YHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627768; x=1769232568;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QanJEL0okHblW7w6/vRkxVN/qYTBTTJdOuW3T6wN39U=;
        b=xKo8fNsmwMQ7e4ehQe7tSs533d929DEwPmr7UIHxBuaoqrfmcDlyqpio3PXn9P/xVY
         zmoosE8JcxZNE8r2WVcGQsjAZurU+oHFnJRuDaNDhX5I9ZLFnOT/SPtOTa95wwZRYatB
         oCLjjvxDfet88hZu2+qFO8MWQiaP5a9M0skupZPUKC9z4fQeUwItLwGxVjFefxB9glFG
         Hp1sEvnEiRYfpGegldQrPbnGNhSYB21Jq8nT3Gq9a9viveMyUNZRigyk2yQZzys0f/9h
         XojJ3aUvYxmgdVIjMPDCyzoJ+EBf4Yxt6imjFCWN9j+qoLoMSMzsLzHscHF1Qec1Q+Qu
         fyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl4XQBDyHHQHZUASpeAwQOWLRc1vXOJ26mvBj+aDsdAgMI4Xm/zE4Z1nTRVKMT7eqFnRpT7bqkmJwEn73YEBf0@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFKo7XRwoqFvQLx5zflrrUCLS/ZqJlqdbAxz64KswnbLkX9Ek
	heVBXpIpsgo7InZZznM2sV02om+BLdWp9phFomyrWYANSPe55WZKO7zreT3R/vgNm0h23kP+IkX
	XqlxWLYxm2g==
X-Received: from dlbcq13.prod.google.com ([2002:a05:7022:248d:b0:11d:cf4c:62ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2487:b0:119:e56c:18a8
 with SMTP id a92af1059eb24-1244a7257e1mr4331178c88.16.1768627767987; Fri, 16
 Jan 2026 21:29:27 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:31 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-6-irogers@google.com>
Subject: [PATCH v1 05/23] perf libdw_addr2line: Fixes to srcline memory allocation
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

Some irregular stack traces are causing double frees and memory
leaks. Make the code robust by proactively freeing and being more
careful with the memory management of the leaf_srcline.

Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/libdw.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index e4bfd52bd172..b96c4e0d728f 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -42,16 +42,24 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 		call_srcline = srcline_from_fileline(call_fname, die_get_call_lineno(die));
 
 	list_for_each_entry(ilist, &args->node->val, list) {
+		if (args->leaf_srcline == ilist->srcline)
+			args->leaf_srcline_used = false;
+		else if (ilist->srcline != srcline__unknown)
+			free(ilist->srcline);
 		ilist->srcline =  call_srcline;
 		call_srcline = NULL;
 		break;
 	}
-	if (call_srcline && call_fname)
+	if (call_srcline && call_srcline != srcline__unknown)
 		free(call_srcline);
 
 	/* Add this symbol to the chain as the leaf. */
-	inline_list__append_tail(inline_sym, args->leaf_srcline, args->node);
-	args->leaf_srcline_used = true;
+	if (!args->leaf_srcline_used) {
+		inline_list__append_tail(inline_sym, args->leaf_srcline, args->node);
+		args->leaf_srcline_used = true;
+	} else {
+		inline_list__append_tail(inline_sym, strdup(args->leaf_srcline), args->node);
+	}
 	return 0;
 }
 
-- 
2.52.0.457.g6b5491de43-goog

