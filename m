Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394625A2A5
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475303; cv=none; b=uAFHQykpBcq1xk4lFeg4t8QEsu98vt7DBM+pj3100NMA9FJQSjOZlFM8yLYnfQIMZizPz3DqO/7kHSAubG0xHbkAleqxpSQJCPA8whM6AHv4gEy7cx2A4XUe5tyQwzVldx4xXc3gecPtlWm2ZqRHhQeIduEo76wo/KwXnQM7i6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475303; c=relaxed/simple;
	bh=y7ZMmXMl4AeF7iTeFou5MQEhQkYueVSw9Jduxng0eNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PN7LFcoLOoSqOzCC4NmIJsTzT0LmK1+reStWECxNXeulzB6glgd6zqRVkiVFMEwB3KPktP6nkhzgty8uDf0UQujR0ZpGPc9F6Savfxd/MsiW4xTM8eBcbefONbZhS0VIHcw2bI8FKIgPvxC0hlMZSopBpxF4tD9r7TnqgOKXuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAPUzRxI; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAPUzRxI"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4ab684d3b55so46219881cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753475301; x=1754080101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSnOCIynF2EPoUgwxpXJNlBKEOIAjcwZq8VcJJ4NIKo=;
        b=wAPUzRxIdzE2StFBz8MQFaxMr/vU3Hg6RL0xyCp4bkTyBtggfpsx9wyGJDnEiCR+Aa
         FnWgeyMVcU8FN3ePNub3og6Bm52yeEpgTSD2QQ9G2HoStyWcDzHc3cIRVIE3dqhPRXQt
         DtnMqN2gdcOwWA2GzLuzT1naquz3d9g46h3ONzXrECh88hDZVrw5+qn9oeMIQF3X3MGz
         V7PXNAQfVcZWHpj4a38J8GC/Cwq88eQyOpCJ1bVZEVO/0Vg1gzv+O+hCjliceWiqkPPm
         K6HEJWv6F/7R1oYtXyhB7hciTfk6zK4dkj3fKneVTkJ6auY2Gc/vopC26ke62MZ+D+jU
         d3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475301; x=1754080101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSnOCIynF2EPoUgwxpXJNlBKEOIAjcwZq8VcJJ4NIKo=;
        b=q3VIyfSo2hH6DUpECLWPvj+Z277vMh8d11mAWslUrIEhZKyXwAPRZ8oSDtoApyzyFq
         25CzBs6g/8On0qjUsKIda8QkzWqRS0OrGuC7MFUWNfRco24TtqVB5AR9xS/+qZoQPHr6
         imQ8+fnqPTIS2/9wRthZz70bHTGKqFXy5kA85pnv9TGVbOGE0NVLpOfG+uPQpcPSdwgO
         KHBWq1Rimw61K+Dxl70kJFuJjCp+IsUMwAWhmMgq+KpXX00dp6zYtoZrW8usQ6EE+n+L
         k+gWtrCVYUHyzyWx5+fWEN8+gDEe5bx4bjfQ+vRmUwIoMBMFjA2J6/0miEi5Y1oINcCK
         8QaA==
X-Forwarded-Encrypted: i=1; AJvYcCWsix8HvEPDra7qZVWhP7YOVVC+Cb1d0i3H5WrZVXwusc0tURkq4ohhL0yhxZEdvhlgakfa9AtJ9qvdPbV1R6Qg@vger.kernel.org
X-Gm-Message-State: AOJu0YzYAkIfwn/EjfsE+Lo2RA4vy34NxxGhRxLvjINguFlYZQWOGusR
	RdtJ1Qj+JTNrOUT7vcO5y2nCc08ylgGg+fu5lTVnZmG7C2mE4zAxJoagtdaU5TD7Q9eF2oMWdyM
	iTvhJwJB45w==
X-Google-Smtp-Source: AGHT+IEtaubTt49Ik8s9cRgE+B+Ay3+2JHiCaKE3hc7DgJYA6W0TCehhgfWQ7j17dc3k3QPYrwA+8oaWNbSX
X-Received: from qtbcp4.prod.google.com ([2002:a05:622a:4204:b0:4ab:6375:3dda])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:5448:b0:4ab:63b8:3320
 with SMTP id d75a77b69052e-4ae87225337mr79667211cf.23.1753475300882; Fri, 25
 Jul 2025 13:28:20 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:28:04 +0000
In-Reply-To: <20250725202809.1230085-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725202809.1230085-2-zecheng@google.com>
Subject: [PATCH v1 1/6] perf dwarf-aux: Use signed comparison in match_var_offset
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

match_var_offset compares address offsets to determine if an access
falls within a variable's bounds. The offsets involved for those
relative to base registers from DW_OP_breg can be negative.

The current implementation uses unsigned types (u64) for these offsets,
which rejects almost all negative values.

This commit changes the local variables within match_var_offset to
signed types (s64) before performing comparisons. This ensures correct
behavior when addr_offset_ or addr_type_ are negative.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 559c953ca172..bf906dff9ef0 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1388,10 +1388,12 @@ struct find_var_data {
 #define DWARF_OP_DIRECT_REGS  32
 
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
-			     u64 addr_offset, u64 addr_type, bool is_pointer)
+			     u64 addr_offset_, u64 addr_type_, bool is_pointer)
 {
 	Dwarf_Die type_die;
 	Dwarf_Word size;
+	s64 addr_offset = (s64)addr_offset_;
+	s64 addr_type = (s64)addr_type_;
 
 	if (addr_offset == addr_type) {
 		/* Update offset relative to the start of the variable */
@@ -1414,7 +1416,7 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	if (dwarf_aggregate_size(&type_die, &size) < 0)
 		return false;
 
-	if (addr_offset >= addr_type + size)
+	if (addr_offset_ - addr_type_ >= size)
 		return false;
 
 	/* Update offset relative to the start of the variable */
-- 
2.50.1.470.g6ba607880d-goog

