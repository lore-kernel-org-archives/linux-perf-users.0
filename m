Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F00130ACF
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104243; cv=none; b=Z4nTal+Sd/MeWJ9Sg+k+iVGEmJY1iNOe/S9gUtE5Zr+vO2saj4DMXAPHRF+LYPUu0Ij1GLkO2LWpl0XNQtiUm0R8JxKJZbDkPz3vm3HZhVmC/kEX6QK6CXjREiNV7SGWHVNJUkNp2s5D5FGL78DR7DS6CqvsYrOVbtd2grW6Akw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104243; c=relaxed/simple;
	bh=GrGGaI96hLQeFLK9l61R0YyUjHIsjanXspc3Z3zFwKg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=I2jGYF95AHroqallUt9bJzwNnLC2GEeYdHIIWn+kT5IF9UMwfx7IiFusJPURvXm/mnh/eWSLAopw/lwU3opPCz8yBTGrJR0zt7uqqwCC1FK8Be/FMTgEgEV+YbAsTdv+WwHIcKGm03LRiliLP65EtgEtZQZ3Z4ADgyVStxhLOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+C/aKHU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+C/aKHU"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60802b0afd2so4783787b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 09:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708104241; x=1708709041; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Sl1b2bCt2ETIANL315ip+LCb468TguLwgWryRSpCdA=;
        b=b+C/aKHU42+tAw1dpVxjDPflc9At6XxPCj8S6g17Aw+l+fk3EARVsF9PSNr2UrildO
         R9smrNRUAXoFNBf0RrzUzwTG4Juj3yaseCu7xsnSjU9YFy7HzHpgtuONhgRQBqrRHyw0
         K3cLSvpdry9TAMG4GjxMH9iwwY5tshF+Gt4OtqhYrxz5vhGmlOHBNbtuEAni9oZICp6/
         fbpAqcEZ+DAiLgQBaukPQ3+jWm9Eh1iXmcKU5aoFoOEYrj+zH6P0ABAbyVL3eY7ioztI
         IqtPI9QzdtdEd/nKOzigrr0FmiXaehfzJEQboewGeTGYniXc8BJtRaOMprLMh7qbATCU
         CVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708104241; x=1708709041;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Sl1b2bCt2ETIANL315ip+LCb468TguLwgWryRSpCdA=;
        b=TOXj16Hz5WWqzixQrAcoJYCFJrrvuw+TJbrRvfMbRNKnG5LhE6Lt44i0LM6aiMBjoK
         QOymqwykQ2AFqukGCqvSRpCu+tpMappT3myFEKS4en+yEDTnJhFZRw9vSK3MYBKY6ySJ
         Ytgp/lf8JQUU0pvdno4OoR/RR9mmUQ/rzJu0rYZ8DV7XyrgTJj/9yoXYLQWd2TdjF2FI
         itICVrnzCV6NhYPu2br8NVTQqwSvcuixOR8mTIk7ozZ0WMHZKtNx0Ic/ChXeyW9LVMJN
         qKj0gwvOdJKSiwHHNwjC9xynICFDtbXBGncO669L5VpaDjgzezzrmbCCIe/p9wYHDJ9U
         qtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzymW8uNukPlUif9azMvxREy3hhfGorEVFvPQYyqaNZMngFqR2FkqgKPw5RGbSvWdAP9ip1hPn6B4r+IGMr5/aX3TyqezOPA7ES4gE/XmiAA==
X-Gm-Message-State: AOJu0YzxxH1x2zCLnyqLJPeNmm2haBN5Txe3cPOccphF05mpeD3qQs5j
	e1hu4x7B6yrRgEqo/XmOV0a+phX1c4Jde1XcqsfloVKXN/ohTy0r8HJ/45USH4IYo4qIWU1WhSp
	yi/c4Ww==
X-Google-Smtp-Source: AGHT+IFqWeRYKSVcwa0vhgyD6jQU0oUmzZBrtVi6OdlKkHk9O5GXukUJnGWRIfC3D8Gq6rWn1TtS28ALGLoc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fe4:7382:151a:2e90])
 (user=irogers job=sendgmr) by 2002:a81:4316:0:b0:607:f42f:70e1 with SMTP id
 q22-20020a814316000000b00607f42f70e1mr529438ywa.4.1708104241244; Fri, 16 Feb
 2024 09:24:01 -0800 (PST)
Date: Fri, 16 Feb 2024 09:23:57 -0800
Message-Id: <20240216172357.65037-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v1] perf trace: Disable syscall augmentation with record
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Syscall augmentation is causing samples not to be written to the
perf.data file with "perf trace record". Disabling augmentation is
sub-optimal, but it beats having a totally broken perf trace record.

Closes: https://lore.kernel.org/lkml/CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 109b8e64fe69..192721261098 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4864,6 +4864,11 @@ int cmd_trace(int argc, const char **argv)
 	if (!trace.trace_syscalls)
 		goto skip_augmentation;
 
+	if ((argc >= 1) && (strcmp(argv[0], "record") == 0)) {
+		pr_debug("Syscall augmentation fails with record, disabling augmentation");
+		goto skip_augmentation;
+	}
+
 	trace.skel = augmented_raw_syscalls_bpf__open();
 	if (!trace.skel) {
 		pr_debug("Failed to open augmented syscalls BPF skeleton");
-- 
2.44.0.rc0.258.g7320e95886-goog

