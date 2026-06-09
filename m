Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2421631328C
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982301; cv=none; b=tA3mpdg0m+BeB49WJfdhKXbmYWcKtqh4p0QrstvqACyX+ZEkNKsmJ4UVMzV5G54uBiG/AIS+tBxfq6PLwtVcxqeOhfJYq9AQAhAY3qu7atPliwvXyeKkv3x8e6PE1N5ooBC5yIXhZUeR0M7Tptb3LLtYeqxx9b0mKRCe+++BHmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982301; c=relaxed/simple;
	bh=CPAJiqP85MtVfxcVBaEaPWgup7ptDFM4XkRTGGxiA4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HQ71+UExBqLmsGOZMjd36Q0Wt7H/DHgU5w4Fy7PXPYECFCWCF1aQI2Sl+dztT54OfbIVus0xK56kxavOe9E7khyMbHbRmrBGIXoEbH1QxdhKMl15bUz2ilKpIYED/ewqqAgHVcsi+hbOQtf7mhrpavXED6e6mnsEXznTPjefmeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3ytXVdX; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3ytXVdX"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304b8d0ee63so7199449eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780982297; x=1781587097; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nQ6SihkTIAHNVuQde+l6sb21AGloI7WP9qqXJPRNAs=;
        b=b3ytXVdXwCZlXmw4mWz+V6Z7xY1sC0pcEhqXxcv0iWfV9uC5RHca5Teg/cEqdpt4gW
         KbXaVkxA6hQFYAU8qXTc0VIFHJYne4A8FxDg6eZlhPnFsZMeaiwyH/yMdgovo1f+4I8i
         C+t+L6H7ivPM0q5TDYdjXyOVHiEXVnUcctEtQEO21u/NBHkBy/i+j3PfldRHbrSpfxP4
         GQGjV2/2ujqmJXmtRaEbJ3s2lRfqxpFaTBL9uDrpw3tQo5l9r4KB+KnMqT6WIxZ8Qm/t
         LVZ8n8KmiA3lc0AOlo3knnV5xbgCT1uWaIuB+VK+5ShlsAa62AU1DOOfACATS6SrJDVE
         IG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982297; x=1781587097;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nQ6SihkTIAHNVuQde+l6sb21AGloI7WP9qqXJPRNAs=;
        b=htc2Gib0ENjdQ13LM1Bbjs59FRkq1+2Fz3yBGxForI0Yr1rgUZkT5c7zdb97awyK5v
         ZTeG0L2xb4Poj/jOEtfouP018h9m8+9bae/aWKLDVSGTSlHZwRTp+kkR2DTrOTWw6mD8
         DveJcEiMoy0o5/XuehHpINHhDezyIoCYo+AniCj4lK+bzzbhQnb2JLI6wdVd1JW/4mrS
         TkA3wveCfZRTvnToX1rOXkHWgKiscFnySD0zRs9oX2XHgItYRUZtSVb+V3a3McPNHBwI
         +ccnzEci/wNfJ8PINGuwETg5OQSVwMSqflolC+ZffCuvLSjs+6g+q8lX964UZKzWYJg6
         7MOA==
X-Forwarded-Encrypted: i=1; AFNElJ/9uD6DIlE0/z/a66gGWBQfG51Eq5CDZLVPm+gOA7G1oCzAxyVUQ7ZsowDaMvpVUeSjY0uLYkmvTWFhTYkPwdk0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83ZzQEGfOGCzWW8DHOmOJuuP6rsk+5wk/sruqSNWdA29aEB1x
	cH+PAHrtkp3gboclWFYNkeR8kV54JNpvGY98turxFIa0iG7GGNdJ7+dxdT3QypVNxVYnGhyeU2s
	Iqgsq1RJt3Q==
X-Received: from dycmg19.prod.google.com ([2002:a05:693c:2513:b0:303:93ec:5fc5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2288:b0:304:df8b:71ee
 with SMTP id 5a478bee46e88-3077af31664mr10178479eec.7.1780982296904; Mon, 08
 Jun 2026 22:18:16 -0700 (PDT)
Date: Mon,  8 Jun 2026 22:17:56 -0700
In-Reply-To: <20260609051759.405027-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609051759.405027-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609051759.405027-5-irogers@google.com>
Subject: [PATCH v1 4/7] perf annotate: Add --disassembler command-line option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Blake Jones <blakejones@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Michael Jeanson <mjeanson@efficios.com>, Leo Yan <leo.yan@arm.com>, 
	Tianyou Li <tianyou.li@intel.com>, Zecheng Li <zecheng@google.com>, 
	Rong Bao <rong.bao@csmantle.top>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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
2.54.0.1064.gd145956f57-goog

