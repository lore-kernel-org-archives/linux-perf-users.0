Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663653A7
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727138251; cv=none; b=Lys6eHzUMAdrGbZcOlK+DKbW+HZdQd3M4tZUn42BusCGvFm8QB5C9saM4YJ6FSYo3MLkEM9IPBiGhWeBbRHsWtOpwfwWmBgsY1bWZ+/RMbjpBb8M/mISnVd8ZmhTlJzlyQdyWtf6nmEq7mHT9rB/3vTq/n1gGt2viT1ejvkPWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727138251; c=relaxed/simple;
	bh=4azRAuwmB0rPiG2Eq8WyPuVU2nFDci92qBLH5jRtUi0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uISpJi9lAIq71JYFnsrEBY6eYUBqDDKLC2ne55n3dJ4mSG1Z3r1lCG66Lkt9pMEotJ5gOGiMJwJaD9b7HyP9/s2lsLNh/DttB6WBhIapnBeP/TTUOpGK2Oh0MxPXpPW9frwGZcdY5SWr9T4UPKlnbKdAW+atXh0B8RBeTFWLgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zih4yzE+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zih4yzE+"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20937a68bso9059987b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Sep 2024 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727138249; x=1727743049; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tysacR2PzZ+y/dOuNBaM8ZYnLrC6mEbjzCE4C8dIypk=;
        b=Zih4yzE+0ySPuQ8eJqYL0eXbpAIx8msxbgqr7FDcV0FGSO03XLI0zdvU63wC0YGQOS
         1n0+9Ks1j85vdVVXw7JXqnIiUwU8+NGj80B4azKYaEH5ThWj92z/cxgnZOtUkgcK8QWG
         fwTc1B1PAFK6+oG7i+YRtztaHnaZXbfg9k0DWIsl6HyYvtOa7f6sXyffc4hSCGo2COPC
         UrDfo17DZVcth0rAsgscRUrBFhDd6agYFuTLzWYQDKEIFryb3EnwWV/Zb89S2uaCrRXo
         yR24wihU7HdCx9rPUen8AYrIq6eUCQXbAMYJXnWibXTE1XO1p+wgvAXjKG+J0IgK72sT
         y/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727138249; x=1727743049;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tysacR2PzZ+y/dOuNBaM8ZYnLrC6mEbjzCE4C8dIypk=;
        b=tROUXPtdqrjiyF+qnLVW8MKZWRJewuJpANt1J+/Hd5wTSdBLIcGpevlHBXVN0KZXH2
         Yo/fhGDtsFfdCv4OM8qVH5ScCJdQLCyoZt3g/wds6e4X8pSxMvFIh4byW0UPgmXHZY+L
         92R9XjI9zOwC6AxvOx6ytdah2yvBZ+r/49qAnP25gXRao99u17WUWXYpnUYM9K1yKjsV
         p+OYGilkIFrSSpVxtvq8FKX+Woe8YzxW0iJbdfiP0AskghGBC425+ULfrpk4XsBKyIj9
         s4WlRGTYHO8E5pNAtsg1sGNRPtVR7PfDTcaft3y8MyI1X1NZDD0eFERVi6WIhwkh2dMo
         gWVw==
X-Forwarded-Encrypted: i=1; AJvYcCVGgz5aGxTRO2aaS8SVng69ySS991b8p+NCvPxnNYHMzkO5d2vbATzwcZZEp1DxCfzVU/Qsy9x63dpn26Zn/9Dg@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSa4Q3hoWzgbjTdug+j3WwC2uGj/yZD261UxBndZsFxKP5FSy
	o+sK2ep7BxKuWn8uJfduRwupy/hjHNu4/RbU77zxaBm6rr275nKvgCWjiaxjGz3ISeuO4f3i+2f
	VfGADQA==
X-Google-Smtp-Source: AGHT+IE3TSKvX/vlq7xOs1KZRaFw7wQq9Ko2snhuTZLWa8LaLPIThJ5oQQFe9KsKufF98qDvPQ3tLeCFfrUl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a25:8045:0:b0:e20:2b5b:c6e6 with SMTP id
 3f1490d57ef6-e2250cc2238mr27165276.9.1727138248505; Mon, 23 Sep 2024 17:37:28
 -0700 (PDT)
Date: Mon, 23 Sep 2024 17:37:18 -0700
In-Reply-To: <20240924003720.617258-1-irogers@google.com>
Message-Id: <20240924003720.617258-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924003720.617258-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 1/3] perf disasm: Fix capstone memory leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"

The insn argument passed to cs_disasm needs freeing. To support
accurately having count, add an additional free_count variable.

Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in powerpc")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index f05ba7739c1e..2c8063660f2e 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1627,12 +1627,12 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	u64 start = map__rip_2objdump(map, sym->start);
 	u64 len;
 	u64 offset;
-	int i, count;
+	int i, count, free_count;
 	bool is_64bit = false;
 	bool needs_cs_close = false;
 	u8 *buf = NULL;
 	csh handle;
-	cs_insn *insn;
+	cs_insn *insn = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
 
@@ -1664,7 +1664,7 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 
 	needs_cs_close = true;
 
-	count = cs_disasm(handle, buf, len, start, len, &insn);
+	free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
 
@@ -1702,8 +1702,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	}
 
 out:
-	if (needs_cs_close)
+	if (needs_cs_close) {
 		cs_close(&handle);
+		if (free_count > 0)
+			cs_free(insn, free_count);
+	}
 	free(buf);
 	return count < 0 ? count : 0;
 
-- 
2.46.0.792.g87dc391469-goog

