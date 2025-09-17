Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98E301485
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139103; cv=none; b=pG73W8ApYp5pz2Qkir7vurQx347m6EVn8Yc4X4SFkKjEBGkLzVI0aOzGl2iDZETPIoFkhlHnBez5xrLfZy89SdV+pDA60DAIgLTtOl6YRKwhBOiOb8SSkF2Z2DyWH1lur0KKvZxTg9+a7nEKVDtpADbafGeS+LXh235ttatcshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139103; c=relaxed/simple;
	bh=0lWzt9RO+8jsRK3poX0e6qyYY2f7EOwhvwqUc9lYhdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=avDgspfT9sg767QOpph+1KC6VzwjLXhHC9p4LmgT5deSazS10z3O3cpEbney3Kme+bt4dyk4+iQFVLjvn9YMNfJMJu+tPhwCAgYTZb4ysbQfdK8SOgtct10epclRWh565F0pRECwheJ2Op4ee8SLywMXrP85fWAytaFTAUceLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgUMSkOW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EgUMSkOW"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-71e7181cddeso2770737b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139101; x=1758743901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9DHlI9Ihi3mnPuz7nsW2r0i9Vkc+j3chUUZTsmP0Lc=;
        b=EgUMSkOW4m0qQ4FP9uhV7svX09AA2YpwpyxdptZ3cGPie6aQAyryGp/8VXZzLQ7SNO
         yEVABSmKLl0Lm4306zpUAcNB/PM4qE77BG0LBK4DawJuYfLDu77qWB2iXCdtskN02+c6
         26nk7G3jzjSWRNBmvnstBE19rnnrNViB7s9xmCXPtESKpVLqVTkr3ncv+hzEjxWn88Ny
         b5Tq8jdCRHAi3TQpfbiB3AzMYsKLA/hkAAlyaBTu2lT6ExOuDdLHR0rJxJAAMXSWjY7X
         C1lD9Hi2cnHWUYT3kt0ZtCR0jM3AJO4rmt4OJYZJjKVuFryf8KJLOKsCMTQmzeM1Phxi
         hCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139101; x=1758743901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9DHlI9Ihi3mnPuz7nsW2r0i9Vkc+j3chUUZTsmP0Lc=;
        b=NEL1LFVnvNygx4aiExpSRNz0deVowf3e7ZxEFVC1UKKH2mGdcjjhNcEY7DQ7hBOBCg
         ygpxahmGA8doeGtC+4a5LendjBlAixg7+cuQKGvUJpakOc55Hx+RalJvSxxgq0LUiJ1L
         yoDxV2am8ZN8woubXHNoA1WC1xFLRhtuNN+enhrxGEAr8sheqszsV5xKG0jf1+YTuFbo
         zVGojlgPUdHStbV5moTvg84j8LHwTn/hpzZUAemv1STOyv0OjX+vE4zLcLH5Klfw8BHV
         cyA6YW+SfDKqphfeMTSzhSrHmE2hvguF/LYdzQaNVq98trbcdvQGm59VOZCKeSDbQ5Iy
         cwGg==
X-Forwarded-Encrypted: i=1; AJvYcCWAhpauh2MWEEY+vE/8vs7kGHhX4KyJx+DqTEh0nmBbsECbIGeiwk5pAlOhkiLoylPtlxCRPvi/kgXgO/ATWtwP@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7HJuGF9V4IEj8m1MpNZHj+JF3l/3kz0PNzJx1YFiKhVOh664
	wyAL/CcZOtV+/RxHL+aCd7zf6JA3i6jfxpRCkmxvGl0ZpMtydkyDXmMS6mVKoqlOAn7JqbVEp9Y
	niCml8j5ZRw==
X-Google-Smtp-Source: AGHT+IEwbYCWP2bNi/CnkWrXxccCC22yUDESZA7PFDkENPsFEF4nWCL7Y9MLRk9ACZV2PmfW8TTOgQwRgw6k
X-Received: from ywbbg13.prod.google.com ([2002:a05:690c:30d:b0:722:83d1:81db])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:d0b:b0:734:81fb:8ba0
 with SMTP id 00721157ae682-7389129df2fmr29782737b3.19.1758139101185; Wed, 17
 Sep 2025 12:58:21 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:07 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-10-zecheng@google.com>
Subject: [PATCH v3 09/10] perf annotate: Improve type comparison from
 different scopes
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

When comparing types from different scopes, first compare their type
offsets. A larger offset means the field belongs to an outer
(enclosing) struct. This helps resolve cases where a pointer is found
in an inner scope, but a struct containing that pointer exists in an
outer scope. Previously, is_better_type would prefer the pointer type,
but the struct type is actually more complete and should be chosen.

Prefer types from outer scopes when is_better_type cannot determine
a better type. This sometimes helps pick a more complete type.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate-data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 7e4c045d0f4d..51765bd36c47 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1622,7 +1622,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 				pr_debug_dtp("type_offset=%#x\n", type_offset);
 			}
 
-			if (!found || is_better_type(type_die, &mem_die)) {
+			if (!found || dloc->type_offset < type_offset ||
+				(dloc->type_offset == type_offset &&
+				 !is_better_type(&mem_die, type_die))) {
 				*type_die = mem_die;
 				dloc->type_offset = type_offset;
 				found = true;
-- 
2.51.0.384.g4c02a37b29-goog

