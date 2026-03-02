Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC4346AC1
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Mar 2026 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495124; cv=none; b=jfWJom92ujT0USiMwDKMdYa27Jp30zQuRYzbLn+Z1m5wTj1UgRAU4CnYl82grXcLsACseJvc55mOMOQTiUwUtnN7xeeWosxbI/gb13SDQJzxbzpgN0lZwMHUOT7cAwthbbYZOA8cQfKeGdHcuW3wY3vwXn1uRmDz4hWF7n9KenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495124; c=relaxed/simple;
	bh=Ryw42QOZYCD6ImijtfIf1UyVQ5xoh3C3sfE6+2YHB54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVaXA6tc0GYjOv3N3n2PrqO5z69MsF4tXvtt+sf7+8YfhLJgszCHksbxJKvgxwh18XGI0mdY6rWSltJ44NSc2n2aIkN8MkAR08SYv2iIS7+QRgexa9VKYAVNoqhgYwAZaIRD6abBbjEj35jY2Sg/rDSKKAev+cMV5ov/zmSlQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=280KPrP6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="280KPrP6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso5570511eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Mar 2026 15:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772495121; x=1773099921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XApOxNLqALRPqrd9a4JI8RQyzwyIkRhsoF996QzzUnM=;
        b=280KPrP6ejRpeiFpgpBtUxPUA28o6DT5hi1LtZTjxihTMCYvgvG1lpF8rQ/9ZwY1CU
         QtBwaie/5a7f3tttT6BrpRN36J3OBKbtA1fW/RHHMx6l1fWetFh2CulPtcNtTFrO0Nss
         +MMHLCUuXi7cBxmktOZkKjPmdNmYyfP97hkFvGZtyCsSTO+uiOIB4bKlbWUXpxF0BVsV
         e84OxNJ8bdN+CVNp2xD80FxplvUJBozX1ppNqb+04OkZzJ3EIU6zNQR8MK/nmD8MIdoP
         FpVYqIvYNF/ywsnRbgxyx/+gIqYIaROg5vq4FJxlLjRbCcYldyvIatggWiq3fcdpc2fn
         +hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772495121; x=1773099921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XApOxNLqALRPqrd9a4JI8RQyzwyIkRhsoF996QzzUnM=;
        b=rVtmWLRCmG2NG5uuKAKay3NDL8bVWAkwTR8KUpyHS5iSlbg7IRAhGmriYJuPAJjz2b
         2APsyiifiIiL3v1WtybKzHNYunSXIAmtsmyK6ZV6/rDb2QIge3X7Qw/QqIdWF/hU8qfd
         emyWSSWYytMqdckjupZrQNffGb+o9HcFFTNdxroH1tHEf/O2/DSoKsKeyziYkztp3vrR
         wOsFZe3RlBwlgXmN44IzQmeHQ0j3ktuGpSa4eOM+rH0G76GrL7UZktXVasfWhsqMTuY7
         +aS+RL7h5PwxH0DPGM8f4QFhATsFKb1O/gQjSca2h7qFFm8cW2lrn/6xQ0EUns1M31yN
         mUcw==
X-Forwarded-Encrypted: i=1; AJvYcCXPzTuVjoDtj0nMiEKRS1LohdSbZmjBCWJOrK42S4TkKRRcUH5fvSBdDvUo7+jpImkbDqjouKPnHZHqe0vvIX87@vger.kernel.org
X-Gm-Message-State: AOJu0YyGK2rgDlbQlJjw1mnvV32cc7AHW5h0rv8R27BVYd8p2XETSEtt
	9naZQ9ApYeo3yRllnpqMrifjAn9Spkps/M9dyS2NBh0iUff4P/Ilgp12+jEKvXfB+OIzMEKmXTk
	UosgyhyicLA==
X-Received: from dybhr7.prod.google.com ([2002:a05:7300:e2c7:b0:2be:1a3c:a2e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4181:b0:2be:1365:b6db
 with SMTP id 5a478bee46e88-2be1365dd7fmr1835551eec.17.1772495120836; Mon, 02
 Mar 2026 15:45:20 -0800 (PST)
Date: Mon,  2 Mar 2026 15:45:15 -0800
In-Reply-To: <CAH0uvohLdUS6ODLZSKUA4FvjwGeqi3=9H-fJ94ybkzZPuGJ3Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAH0uvohLdUS6ODLZSKUA4FvjwGeqi3=9H-fJ94ybkzZPuGJ3Kg@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302234515.565623-1-irogers@google.com>
Subject: [PATCH v1] perf trace: Avoid an ERR_PTR in syscall_stats
From: Ian Rogers <irogers@google.com>
To: howardchu95@gmail.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, wangguangju@hygon.cn
Content-Type: text/plain; charset="UTF-8"

hashmap__new may return an ERR_PTR and previously this would be
assigned to syscall_stats meaning all use of syscall_stats needs to
test for NULL (uninitialized) or an ERR_PTR. Given the only reason
hashmap__new can fail is ENOMEM, just use NULL to indicate the
allocation failure and avoid the code having to test for NULL and
IS_ERR.

Fixes: 96f202eab813 (perf trace: Fix IS_ERR() vs NULL check bug)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 295b272c6c29..7ff85fa90d98 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1565,7 +1565,9 @@ static bool syscall_id_equal(long key1, long key2, void *ctx __maybe_unused)
 
 static struct hashmap *alloc_syscall_stats(void)
 {
-	return hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
+	struct hashmap *result = hashmap__new(syscall_id_hash, syscall_id_equal, NULL);
+
+	return IS_ERR(result) ? NULL : result;
 }
 
 static void delete_syscall_stats(struct hashmap *syscall_stats)
@@ -1573,7 +1575,7 @@ static void delete_syscall_stats(struct hashmap *syscall_stats)
 	struct hashmap_entry *pos;
 	size_t bkt;
 
-	if (IS_ERR(syscall_stats))
+	if (!syscall_stats)
 		return;
 
 	hashmap__for_each_entry(syscall_stats, pos, bkt)
@@ -1589,7 +1591,7 @@ static struct thread_trace *thread_trace__new(struct trace *trace)
 		ttrace->files.max = -1;
 		if (trace->summary) {
 			ttrace->syscall_stats = alloc_syscall_stats();
-			if (IS_ERR(ttrace->syscall_stats))
+			if (!ttrace->syscall_stats)
 				zfree(&ttrace);
 		}
 	}
@@ -4464,7 +4466,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	if (trace->summary_mode == SUMMARY__BY_TOTAL && !trace->summary_bpf) {
 		trace->syscall_stats = alloc_syscall_stats();
-		if (IS_ERR(trace->syscall_stats))
+		if (!trace->syscall_stats)
 			goto out_delete_evlist;
 	}
 
@@ -4771,7 +4773,7 @@ static int trace__replay(struct trace *trace)
 
 	if (trace->summary_mode == SUMMARY__BY_TOTAL) {
 		trace->syscall_stats = alloc_syscall_stats();
-		if (IS_ERR(trace->syscall_stats))
+		if (!trace->syscall_stats)
 			goto out;
 	}
 
-- 
2.53.0.473.g4a7958ca14-goog

