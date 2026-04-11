Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42473BED77
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935068; cv=none; b=RDtmt1XVIAMtutwtWA71my5kgKc4rNJH1N5fYu/wBcS/ON5ltSBYsi9Pdii/XMhwQQyO4N/CgsWm2u8Dcy44XdT3WgBvxzBzWRbTntSblVOa7F8stFz6N3qZ2WUADFBgAKcOjv1tTVlQPxpqOzdOT9788tMsrBAPZz32rx/wfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935068; c=relaxed/simple;
	bh=s03PR3NdhraoAct+z3ztP2wak5yT9JPVUBwMWmour+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eMlWk5AOQWDBr31KKaYRUnrBKVZRGDtHdHLStfvsLmQ/biQlPgvmbMAfOBvxaG2teoTVr1g9JywFeTJ77uJXLJg7HCnzjldQwhqdH3G46khMR8BU/O/DMCFLk7lQU/AVJQFeN1u2rV5oodrLd+s81m0ublugqJiV68+ACUiQSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTBXcKUR; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTBXcKUR"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c20a91932so3711630c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935066; x=1776539866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=jTBXcKURHa0gK/Vqw/5028Dl+CzK+aqjcUE3/uInMAAkX7gtZcnG/hoiYHdCeW9JwV
         XRPA69fGaqDkt7qUIoJ0wj8lElu6NwTpvC1/6oKJbxtOR5FjiySpAYUvsmiSIMXChKPb
         JPY9TgnyDjJEGQ0W2SsTfuKxvcNjfhSBYToYAZi84B0YnkxKj0NmZWnptuKYmzSsBkg5
         FwGo+Ov/3Vrpj+eO2p1CnU+Ip3l66Lnr26v+lNW77wUkAXHuWtjdUIzHmPxOpf3X2Pfo
         vWSmdR0wrk5oLVMcqp3qewkIrH+rqVlEHUUm1uBTIW2ZS5Bd3/n5yiNJO0bftHjjxxzv
         USKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935066; x=1776539866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=ZlZna+X3vVF68888sIg892F9P/3jcH/tie5l6PXe1kHEG/KbS/ezs19ZLaScgPWlaH
         dCrebqm/5yMzXLj7RBgXNK4VvQEaiUCh9UtL37OneuOt0JqvmTiukVv7KM/h62EobTlI
         rBjvi8oWqbRkgOk3+jXjW/QCRfnNdEuewwCssmOVcIrB69U+mM+FxFge5Imm+sTo08pr
         M+x3xNY+iCkz8M+Lwc602RDEl+4B7w77QTNx/ult5zLsebUTbbuMP9NP4074rUIqZDSq
         SuXCqvlHhsMeZv2+tVn/8Jp0ZJGivksBRXW2J7Svh0/SG4xLG2954W4qQQ7aTB4r215G
         x3aw==
X-Forwarded-Encrypted: i=1; AJvYcCWQCCIiNpMkz5nOlbRGoLeiFD8v1YXUmBQJ14mQYSYfQWSZlpNJsRIUI4jXkIOdgy7x09/qsHzHVuOw8jNT9qcr@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSoj6+MSTnIm9KfjyQawPuNHa89ZPgdbts35DoSsDnZMi+kQe
	bps94Vc3fyrvv99AvHu3UedpnFxPR+4yddK5N0I6IQoqCHnVH9eGRNBNUR4UuGGUv/eqE+ol7g1
	0iXJ9EsB0eg==
X-Received: from dlec10-n2.prod.google.com ([2002:a05:701b:428a:20b0:12c:1f60:7d84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4387:b0:123:348d:8576
 with SMTP id a92af1059eb24-12c34e394f4mr4040413c88.6.1775935065791; Sat, 11
 Apr 2026 12:17:45 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:16:54 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-14-irogers@google.com>
Subject: [PATCH v9 13/29] perf annotate: Don't pass evsel to add_sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel so read it rather than pass it. Update
call site.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6f8be9ead43b..719b36d4eed5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -232,11 +232,11 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
-			     struct addr_location *al, struct perf_annotate *ann,
-			     struct machine *machine)
+static int add_sample(struct perf_sample *sample,
+		      struct addr_location *al, struct perf_annotate *ann,
+		      struct machine *machine)
 {
-	struct hists *hists = evsel__hists(evsel);
+	struct hists *hists = evsel__hists(sample->evsel);
 	struct hist_entry *he;
 	int ret;
 
@@ -298,7 +298,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
+	    add_sample(sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.53.0.1213.gd9a14994de-goog

