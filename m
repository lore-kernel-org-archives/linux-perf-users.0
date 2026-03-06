Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2218FDBD
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824582; cv=none; b=J+at/XuYzr+iErFCJY72lEovPyaBQu9SoVHQWpuu8kFFxjZSa4r8FEjsAAUqQPGvjuZZNraE3h9bTMsF2+v9Bz4OHVGbwSlmeTlct9THX8YqHlHmoLJ9XRHWZfSjqn/DtlW48bwAk0szrJ7NpV6qGL6cqoXWDVr7ST1krVcOjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824582; c=relaxed/simple;
	bh=3uU/NE7taY42zc62TQ9rqQyB5v/WCHfDWLawYrPm138=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=cBDmZaisIMK+l6rBBrgBPBfZf0xv2NnJG76lPTfNOUSMDg7zLN03TbfOBNVSHmrNg7CUt1jzpx4OFkntnlyDiFjMA5OKZoVQGfqactGQ/cECGP09SawPVECSpHnszt07pzyLpFGRS4rqXWsi3X4MobY7tXMtIHznDFoxxKMde/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I12/gtcg; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I12/gtcg"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2be1bc0905bso4479767eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 11:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772824580; x=1773429380; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hS2+EY8mpBMGN+AfRUEYRE+hys/X5QdaM4sVXdpDJOk=;
        b=I12/gtcgoE6rH234YtSHh/qg2x945pkOLS4kNMqLsGzT7d5tP2syT0JKJQ5DZu7ghi
         XMhRFTE9lddZc7JAJYqFQ62CvkzggQXRSrlDrw+Xt6CooSKRb18FN13CYKR9vu8OCfGG
         5cOO6A+gNZSKbEVMxNAJ6+eeLY9Wswa3DgEQWNRWnuf+l52h+6Rz/qgZkzq3BjYtc2+V
         ygys7IifmwjIOFr3hMEOUmFoSjFR6FGUWfIH/GICfTe6eEFbUof/EbnCj0MY697twwFa
         35ntHhU3gUnTAhrFG1w7FaeKNEQYIWPMq/M9dTCB4IsRIp3Or8Qj9Qpxyj6Vd/CCMKfh
         vJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772824580; x=1773429380;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hS2+EY8mpBMGN+AfRUEYRE+hys/X5QdaM4sVXdpDJOk=;
        b=C6v78a7JV6pvodvuTl6nVS+dGLOilgG3DFCW93E0LYFSNzHajxsO7Ff2S3UYB7p7Op
         ZZk7hPGb3sjDsynGRVUxhd6myScudUqDgkpSuzJxVexFhvIq5UNItuQ323QC1cZw6PUX
         9EUE75l3Xixzne7QBofcdkPNdRtCqhKhpblq6d+YBxQg544NZ1SZjsIav1GUiAOfwPvx
         Bhm68bSe2Ds2Yom7jhrDA1eJwtCKxNkN3TLthQF46sFFs74fTOprdGqBvEvtnAThX4jQ
         GWDbaEbDuqxqgHQtCrqfVhEXvzPGqNehAoTBdMkcjZzKvDnU84uUrZYLrcq4/fvOlx37
         AKZg==
X-Forwarded-Encrypted: i=1; AJvYcCUKCTda78kVqbAENpJnRVGs7tb6bvewWZ8rxS83E3OtlvrCEoPh9RgX3sYMrk6sovwsGCTlaaE5B/jgQs8LP3OV@vger.kernel.org
X-Gm-Message-State: AOJu0YzEn1PXzDWPKf8fhXA2yixWTlnzRaFRRVao9+OhGex3nGq9wC74
	nOKmYn6Vl/ySDULtT9Sa4NklTscPfaEaanV61iEs+8eCtE51Xp8Yn95mg0C9IGmzISCIbY/xGtd
	8axiWmKQFMw==
X-Received: from dlbuu10.prod.google.com ([2002:a05:7022:7e8a:b0:128:bf0d:e143])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e28:b0:11b:9d52:9102
 with SMTP id a92af1059eb24-128c2d9b28cmr1524918c88.6.1772824579974; Fri, 06
 Mar 2026 11:16:19 -0800 (PST)
Date: Fri,  6 Mar 2026 11:16:14 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306191614.2064618-1-irogers@google.com>
Subject: [PATCH v1] perf disasm: Fix potential use-after-free on fileloc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The fileloc is a copy of a pointer to a string but in places like
symbol_disassemble__llvm this string appears to be freed setting up
potential use-after-frees:

llvm.c:
```
		dl = disasm_line__new(args);
		if (dl == NULL)
			goto err;

		annotation_line__add(&dl->al, &notes->src->source);

		free(args->fileloc);
```
disasm.c:
```
static void annotation_line__init(struct annotation_line *al,
				  struct annotate_args *args,
				  int nr)
{
	al->offset = args->offset;
	al->line = strdup(args->line);
	al->line_nr = args->line_nr;
	al->fileloc = args->fileloc;
	al->data_nr = nr;
}

struct disasm_line *disasm_line__new(struct annotate_args *args)
{
	struct disasm_line *dl = NULL;
	struct annotation *notes = symbol__annotation(args->ms->sym);
	int nr = notes->src->nr_events;

	dl = zalloc(disasm_line_size(nr));
	if (!dl)
		return NULL;

	annotation_line__init(&dl->al, args, nr);
```

Fix this by making the fileloc a copy of the underlying string in its
init/exit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index ddcc488f2e5f..b83bc14f82e1 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -908,13 +908,14 @@ static void annotation_line__init(struct annotation_line *al,
 	al->offset = args->offset;
 	al->line = strdup(args->line);
 	al->line_nr = args->line_nr;
-	al->fileloc = args->fileloc;
+	al->fileloc = args->fileloc ? strdup(args->fileloc) : NULL;
 	al->data_nr = nr;
 }
 
 static void annotation_line__exit(struct annotation_line *al)
 {
 	zfree_srcline(&al->path);
+	zfree(&al->fileloc);
 	zfree(&al->line);
 	zfree(&al->cycles);
 	zfree(&al->br_cntr);
-- 
2.53.0.473.g4a7958ca14-goog

