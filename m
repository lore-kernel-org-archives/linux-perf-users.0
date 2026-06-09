Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E194C8FEA
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029282; cv=none; b=tud9383nwnuciHx3sLSb88ju7vyeVeMJU4arV8kyGcyc4Ouiu40IMWUYI8owYzFUVaLSVD5CxQ+0NmLGFhv+j19ghFgWkvCxCvHM0IknoacEwLjzY0fMZJMy6ZQcxaxK9m/nxaCYYg7+/rMJ8VMl8YuArdjZ6ENcYO4QKWM0bVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029282; c=relaxed/simple;
	bh=aLZRncmr18YxwwguInWkfInwLV9m26EAfQTh0GJh5nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XuWBVqsDE/JcmwqocJa+q6lVFHUwrRrmS6wDkbiL6NyfDuqr2VVb2G3x51v/ITukSTRwaNYmzFClQJPwR9pC0oPMtx6FfscPDC50DTPw71/I2GKeSdWa4ehM0+S9IozY/QlzSBBqS1vKLvg/qFy72iLMr+leZhELYhUdg8lHd1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jjm25Coi; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jjm25Coi"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1370417c0bfso5224729c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029281; x=1781634081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwDN93lZCM2zufO4Mz1V1Pa6J/4Bys/WrOBYdP1FWiI=;
        b=Jjm25CoiM6FF0+UoEn7x28ptEJJXhPrzGTY/S0uD5aUMK7nXCkjVv3kOzUrOPP91eV
         59FP9+VcPIY5Hn19taYjhuq1mhqvwk1VRCckbNHVawmibnEvImizN0J328Obg5jzzeHF
         AfGkru4bcpAI+MigJ1QFro/+Kt2l8EsOlQuaPOjbEcCBcb63Ak6UGp4AMfvW8MWMWn+7
         7FWLwvXMB7Ot+ImktKDlrkswZ+mF9xTvrPWOv/J0GaXE8NQclgMO6vp9Wv676s0ud01o
         yVexFuEyG+v783msWqa4W0r17S3l/3fZlXMIekJuJnhQGy6fZTz2/dyjN9d+Kr+VJ475
         ViFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029281; x=1781634081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwDN93lZCM2zufO4Mz1V1Pa6J/4Bys/WrOBYdP1FWiI=;
        b=KHAt52opMgvIAM4qZWp+xXAF/2HIXzVzgAwuh8QGPVryPlGfMwf0JtKO/d1KBzXuAS
         ZopfMSqsUOTGcfYlu5FcaK1xunuC6YCRbQfRYqsLLAdW+EvE+lCq7TYhLSomYDxmJurT
         jd4Pd3N08Dcb5xuxmr7w7fIqlLnMyu8cYVmYDAoR/v19ATZqcDwpVbe+bULRY1vNMkU0
         5nVCIJ76GMeCk6PMRpFfQsrWn+blp62/tWVYpe0Xfw/Q2b9UAD9S44kgkOEYpjhrMO48
         rgisOAhTdtQkSKz9r0w+yUbF4P/+kR/E8SkPBtCGXVeqPaEs69xcSrc6xnfC/WDQ2IGX
         O9gQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3ItBNEkfyHTH9SUoO99kEZWJQwaDfa+vqI7VAjNyqsXkd6yQDYf6+FJgdwTmcNYa3V/peSKD4iFtuy7N/RQ/M@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEWOjc/coCacUAI6JGJu5e+/ZfU+0Zlenc6BwAXnoHWezBhVP
	mbZBZatYpb9sW2dVOjg4Axdc/1Vy6XOfQFiCKCcNpRGiC9/IRFpABnma3wBYDNiFy/72GytIVRb
	dPPPTFf9Qig==
X-Received: from dleb5-n1.prod.google.com ([2002:a05:701b:4245:10b0:138:3274:8cd4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b96:b0:137:e9b3:1ac5
 with SMTP id a92af1059eb24-13807d94e4dmr10268367c88.18.1781029280418; Tue, 09
 Jun 2026 11:21:20 -0700 (PDT)
Date: Tue,  9 Jun 2026 11:21:05 -0700
In-Reply-To: <20260609182108.975586-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com> <20260609182108.975586-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609182108.975586-5-irogers@google.com>
Subject: [PATCH v3 4/7] perf annotate: Add --disassembler command-line option
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, blakejones@google.com, bpf@vger.kernel.org, 
	costa.shul@redhat.com, dsterba@suse.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark@klomp.org, mingo@redhat.com, 
	mjeanson@efficios.com, nathan@kernel.org, peterz@infradead.org, 
	rong.bao@csmantle.top, serhei@serhei.io, terrelln@fb.com, tglozar@redhat.com, 
	tianyou.li@intel.com, yuzhuo@google.com, zecheng@google.com
Content-Type: text/plain; charset="UTF-8"

Add the --disassembler command-line option to perf annotate. This
allows users to explicitly request or override the disassembler
preferences (e.g. --disassembler libasm) directly on the command
line.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8a0eb30eac24..57a88adfb130 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -699,6 +699,7 @@ int cmd_annotate(int argc, const char **argv)
 		.set = 0,
 	};
 	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
+	const char *disassemblers_str = NULL;
 	struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -782,6 +783,8 @@ int cmd_annotate(int argc, const char **argv)
 		    "Do not display empty (or dummy) events in the output"),
 	OPT_BOOLEAN(0, "code-with-type", &annotate_opts.code_with_type,
 		    "Show data type info in code annotation (memory instructions only)"),
+	OPT_STRING(0, "disassembler", &disassemblers_str, "names",
+		   "comma separated list of disassemblers to use"),
 	OPT_END()
 	};
 	int ret;
@@ -825,6 +828,13 @@ int cmd_annotate(int argc, const char **argv)
 			return -ENOMEM;
 	}
 
+	if (disassemblers_str) {
+		memset(annotate_opts.disassemblers, 0, sizeof(annotate_opts.disassemblers));
+		ret = annotation_options__add_disassemblers_str(&annotate_opts, disassemblers_str);
+		if (ret)
+			return -EINVAL;
+	}
+
 	if (annotate_check_args() < 0)
 		return -EINVAL;
 
-- 
2.54.0.1099.g489fc7bff1-goog

