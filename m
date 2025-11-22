Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097528643C
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799579; cv=none; b=I2Qb5Yqr6BTNeE0lvK1YPa5wTJx1uEmI78wQRFWRBoPUfLKyZMSCttEC4QyI6z5D7EX1nTFqPgiMqYZJWAKonfownaRVZFCT1PzthhjkA8GAlYLti5q+vYcbkBAIYQeMwO1lB80htWD1qBhMXYnxGLH3uu7QcwwlG+j9qbbdKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799579; c=relaxed/simple;
	bh=66zSOIq74hxYCETHRFMWlx/lP7j6PkMIhGgMOekkt40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PNNXvjP9juKnxrJ/GS366DRGy+uvjGCEWRdVcqfQm24CBVqEeHNbVcKibuFm00KBvXFxHEEKGVCaS8zVNsHJa0Jze1PrparQt9UhUDyDAa4a4gu7vTu/uUtlgY63E/ViXoLCH/hc7ca65oydhGenLEgcfNm3ObHysxUixnFih4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yF4I6ed9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yF4I6ed9"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso2820583a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799577; x=1764404377; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGjBuL6hpWHuvMAblul9npGpWy029ZKQRp7hNfKA50A=;
        b=yF4I6ed9JfX/3KBNkhFdR6jPc818rmrGQulpu4Ox29URE6GRDKjL5xRdqLqxIxrG3v
         L3cvtVzMkmzsxPMoyvpOaMU28yAMmDzFtf+Ll+m5SyFSQd/oNbMR2MXxLU6ObQxh47ie
         3LS/8Dqw/iVRpM84g5r6uqhrj0r82rg5A6WsY9Q7e//lJdVkjc3gNQC7NGIXo2NWBbTd
         r73TMKdnYK6XbcjTZsyLEIRMDSjVvYCastG/VGwUfe1B5kBWgzt8/0tuOQL+I/uCBcVJ
         rZr3+hYz2Us8BRFWQLYyUF9cy2NU7c8Y4dhfRPCoIVuJG0RIzKmI5/Huge13oQMW3re5
         Afvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799577; x=1764404377;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGjBuL6hpWHuvMAblul9npGpWy029ZKQRp7hNfKA50A=;
        b=sOX0it8RAqBLr8RN24+k47yEmlkSLpkE8N9mZ6EalzflmEOPBDadtlMOvS++9bdrF+
         DFK5ehDEOFxjz+MSb2/WoYdIJUPyuY1fTFlr9H/GSi0M2ZHW+W8XJ5LX5NV/a4nk5WvM
         SocaB85iGMwvTYpkHW0fiPs1yShTj0Kqc/6CiI2piqFgb+L7sc3KLV7MxF9Gyq4fW9Z/
         A6sIEsjwt3Pik65791DoOpc8lGlxIDh+YIYrbAgaLiAzIk8+i/kcTZLEc7NiLYK3AKj6
         yUNjwDwrJuEhVFvTSoZu2d8i5Lw1lIPILIqEhvf8Hq25XbRpf7AutR6Se0de93v7UZvO
         7GBA==
X-Forwarded-Encrypted: i=1; AJvYcCVxMowxWnNQiUe1TKGLUaEznQt3hgJjCInBeZVJOl5HWyNMWakTVb0y3mkzNaY/nhik8vuJTK5hfw2+seowlCfe@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkeR4eglk5BqlqSGlnDOTMm5w4K4FIGBzMmjGyNPu1XtXiI9u
	8JE8YO3PVTPDDnMaSwdYFD15YKeeDRpyhaESqLId7xS8OiEfGE7F1RgyFGQL9rI+tNByx46Fx3F
	oLPsDc8oAqg==
X-Google-Smtp-Source: AGHT+IFk8hIvCd98IgS3hAB8UgO1KPRZquX8qEJmEtwOJnrLusPChQDQA1oynuDhD//Rh1OjHAscFPAszRhJ
X-Received: from dybma12.prod.google.com ([2002:a05:7301:168c:b0:2a2:53a5:570f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f148:b0:2a4:3593:ddf5
 with SMTP id 5a478bee46e88-2a71a0015ebmr1591424eec.34.1763799577130; Sat, 22
 Nov 2025 00:19:37 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:13 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-2-irogers@google.com>
Subject: [PATCH v1 01/17] perf kvm: Fix debug assertion
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There are 2 slots left for kvm_add_default_arch_event, fix the
assertion so that debug builds don't fail the assert and to agree with
the comment.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index f0f285763f19..c61369d54dd9 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2014,7 +2014,7 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	for (j = 1; j < argc; j++, i++)
 		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
 
-	BUG_ON(i != rec_argc);
+	BUG_ON(i + 2 != rec_argc);
 
 	ret = kvm_add_default_arch_event(&i, rec_argv);
 	if (ret)
-- 
2.52.0.rc2.455.g230fcf2819-goog

