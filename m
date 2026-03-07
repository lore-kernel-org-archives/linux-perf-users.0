Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70300262FC0
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Mar 2026 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842947; cv=none; b=l28B6pAaXDcfOlzbE8eLJPiE7/ev7Sks0us+Z5HvMDQEM63ctpppYfwbaZz30DYt9/56Jx8jLJt64C+f2qjRYjGE/QuBSDI2WCmstBddPYPudBs9xP/VFVemrNRiNdiIyLolNC6bTpmFK2sFNWphZyWogb/nIgrCNrMrghsdC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842947; c=relaxed/simple;
	bh=eWQYFbwgl94p3jmuxbH9YgoYlnKa580ycuvfZ+uUojg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=HNBDYss7gzBHhD+VJL+rwy06hqhb27pnOoZZXuyx7qFKF9K1s0NjShA0VNDFDQj3gKf9yDtzoHqnwGGY17zgksGS3N0uoPA0npmEExBX0B5Y3X0+dZRGhbgatNkcm/fscMRPBdWCA2qwED6r0GvsbzmxWAY4OkNQVxrtRL6FGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYJbGhrd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYJbGhrd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2be232ef3d3so8686852eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 16:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772842945; x=1773447745; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LPf3Axghl6gfwZpPkxBU3xu5lg7lW1gM/wsxQ2W2Ez8=;
        b=SYJbGhrdAseccUxbS/yWdTKl3Oo2azlYNsfNN7Lt0UaA+vuf71sJ9Oc6w3wuJiFoVf
         tvKbQ/+2cZB12kH1UJOpMtaSYw4GXe/KfybGQZ34V/WEN0mqK2GM/XctGHzA3s9RCqkZ
         C48qPi3w3WEeYtc0URvoCrrS0nmFj2OOSRuJ47fSSRma9OaW+s19ItlOcZ5O1pC9t+IH
         BzyosmxPIckgrjXvrZNqH4ZJHM6ZYBIXABqUF+/3BxPilzMd/KSeo8RaqB29hUfaLr6t
         l2YurSJ5pZg0LHY80xYcOcx7gc8ux4wijTsK8i4CFUX2+xCB/6s9MOEFDafQnlTV1z5s
         JrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772842945; x=1773447745;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPf3Axghl6gfwZpPkxBU3xu5lg7lW1gM/wsxQ2W2Ez8=;
        b=Veuo8BDuWpG+C30glWT1ThDy1/M82CQAfH7LGCHdrLDrfsIp2MaxzqPa3yW8vPoKBZ
         MqagkRf5uCsidc7goA7no3VSrm+cO7OOyVlujLW27Ak8cTz5UALJMStLnTv06GpMkXoc
         sURmtOusTMSoK0ZgDuCIuCDvDTn5ba297AI0VDUSsX+yNNFOtxt3pLfCue+WLf77nCbs
         7NqWgqP0YyrfacV5vA+23EISc6HA+o76U9BPH0WdiWPMrhPu53AJyYgEnnJmaLx0+Kpq
         4G0ACrno7LRTyljpa2kN/cs5HJdxF3WHv1n1ZSxJOKHEbzJ6nMlzgo6SBBiiJqCyjRvl
         RgwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmff0qTGlaXW+rQ9QXpm4+fm6V0oHc06Zb1YVqhJSn9VcuBZ606lsLUALpWSeG9qU7lOe88WIR57g9czhR4e4I@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+PhKt+WthyuZr6oSWnStrEOWdldMpcdX0vOxyNKAphepIFyy
	OxtpTm6KeUkRZOKvOv4t1KkRntf97wCk5RmuEjkqdSCzcEh6JMsJveFYNVIGUio8IxlwXjQR76J
	B9Z98oL3cVQ==
X-Received: from dycoi5.prod.google.com ([2002:a05:7301:da85:b0:2be:3f20:9002])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:818c:b0:2be:22b0:8be7
 with SMTP id 5a478bee46e88-2be4e08b14emr1802520eec.35.1772842945433; Fri, 06
 Mar 2026 16:22:25 -0800 (PST)
Date: Fri,  6 Mar 2026 16:22:22 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260307002222.2463509-1-irogers@google.com>
Subject: [PATCH v2] perf disasm: Fix potential use-after-free on fileloc
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
 tools/perf/util/disasm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index ddcc488f2e5f..3fcb3634a7e0 100644
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
@@ -950,7 +951,7 @@ struct disasm_line *disasm_line__new(struct annotate_args *args)
 
 	annotation_line__init(&dl->al, args, nr);
 	if (dl->al.line == NULL)
-		goto out_delete;
+		goto out_free_line;
 
 	if (args->offset != -1) {
 		if (arch__is_powerpc(args->arch)) {
@@ -965,8 +966,7 @@ struct disasm_line *disasm_line__new(struct annotate_args *args)
 	return dl;
 
 out_free_line:
-	zfree(&dl->al.line);
-out_delete:
+	annotation_line__exit(&dl->al);
 	free(dl);
 	return NULL;
 }
-- 
2.53.0.473.g4a7958ca14-goog

