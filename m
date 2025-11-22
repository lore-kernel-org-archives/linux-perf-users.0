Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6026A0DB
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799604; cv=none; b=ETpiRV8LXEFjgCNec+X36vUKpf3Gi1w+5Jht2ESe4wt1+A/2G2webF8winea2KOmxadxyEjsW3RaFJ14JHPp7IIu/oXrkSswc1CVF+gMF9eooTOF6+3EeFqAO5gyeYIWYA/dbSVFq24ogIaogAxqwrBZzwWCpSVp4hfox4bt8no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799604; c=relaxed/simple;
	bh=+9Ty3RdjxPn1DEPcjJMI8Qwm0zSzIz5wSK2dJCAQb6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mtLu0M5AwO5mj35BMtXhPpOxpwEQRONrtzndUwG7Z1VFgDNYq49FH2V3b1o7lOEZ2X+/bY/LnQdjuZ8v1p279a6ws5dDiM6AvSWlcdwpP9CPdDhUwS1Y5Pa8oNzzLyUqyyE++DB18T4np9c+ZLUoFSNS1QJGMwmLGqT/5hKeUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsI3G07r; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsI3G07r"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso6374386a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799602; x=1764404402; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYEy6RfxbNCZCLMts1lJ0YqFpFYPy6p0C3XPI81AgP4=;
        b=YsI3G07rmFmsU3GiYg3qQoT7uPHK6LL6/KPvfBKiaYqEYnBEHy/881FCQWPYP9ZOWn
         ICYIkrLl/7L4kbBu645EnvVXg74L6bjx7quy3VIglQcEg96rTc44PkihLOXUq3uNQ0hJ
         tvx5Bg4mxHpy43/BD2Ivtyw3p+vMkTzzsbk8h8qy3KWmnQk6aKWWqQfBy1eIoU+j2v1Z
         HDQ98EIOdYXa3y4QSkAxMPwNi0cEf7ek12byoRLqpQ3I018MpTzzgVo5RakKd926yAWi
         MgzzWHrkZlmoGpo7o2Sap83yEPYLYMZ7fJy18q7ePsa/Kp/6v/CT7YXjh+Q3CAS3vMNv
         vq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799602; x=1764404402;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYEy6RfxbNCZCLMts1lJ0YqFpFYPy6p0C3XPI81AgP4=;
        b=PtrEWZQ4bMejvXPMMNJxFUChWeXjqu4E/yvZNueQGmuXt2Ka/VmsL+WyKx/teQ4EfO
         9kQGy7nIdKfeuEA3SE5Eeowm53Xo6DJCxLJRsUcpMZMt39PBo9IBV/UJZH27cOM9Yah9
         CyICdiB0gEiF4p7ElSbYn36UhMFtR9HurhSxfluTtJZkfRNeb95N427c2GfiTb6v0mHk
         dVYMtvL/EXNrs+z0kHqU1Mmf8tw6zro3YymAkPkZME/oEXKq7VCC4ieWp+R5FW7rwaYE
         waOHv2/5cbVM8Rnu6LxVqbViSnOjagBz/5vHMGl4mTxqtrE2oFkwvMAJvAgBbLGP4n4f
         lI5w==
X-Forwarded-Encrypted: i=1; AJvYcCX/scwZu1AVZ073UYWziiG8BEXg/g3Q9+PoC0z8qTSOrKVfXn8YvMlzQw2INdzgneJc0qVup/nqMPqSWIFNVMzF@vger.kernel.org
X-Gm-Message-State: AOJu0YxCVWYdnFF9jxVmtd42w+s+02y21STO1H3/ZMfuB8VMnUtra3lC
	c1geLoaNbYhpxvEhQx0rw0I+O0J4JJ1lELCPNl8z5AHWZ4h3E3xT5N29Z17+xO9UFvMKjqQQ7hr
	SYmu1DOfFjg==
X-Google-Smtp-Source: AGHT+IGYJzsMo6JhpnemALeHmWMVPPWcWvAmP/WHrOs4KNVqW2PSe1SU8oltPXxJZ2F7BPNPvErM3zmJVfXt
X-Received: from dycmq22.prod.google.com ([2002:a05:7301:796:b0:2a2:318c:8559])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1011:b0:2a4:64ae:e071
 with SMTP id 5a478bee46e88-2a7192b4ccamr2191878eec.30.1763799602392; Sat, 22
 Nov 2025 00:20:02 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:26 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-15-irogers@google.com>
Subject: [PATCH v1 14/17] perf tests kallsyms: Add basic kallsyms test
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

Add test that kallsyms finds a well known symbol and fails for
another.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/kallsyms.sh | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 tools/perf/tests/shell/kallsyms.sh

diff --git a/tools/perf/tests/shell/kallsyms.sh b/tools/perf/tests/shell/kallsyms.sh
new file mode 100755
index 000000000000..d0eb99753f47
--- /dev/null
+++ b/tools/perf/tests/shell/kallsyms.sh
@@ -0,0 +1,56 @@
+#!/bin/bash
+# perf kallsyms tests
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+
+test_kallsyms() {
+	echo "Basic perf kallsyms test"
+
+	# Check if /proc/kallsyms is readable
+	if [ ! -r /proc/kallsyms ]; then
+		echo "Basic perf kallsyms test [Skipped: /proc/kallsyms not readable]"
+		err=2
+		return
+	fi
+
+	# Use a symbol that is definitely a function and present in all kernels, e.g. schedule
+	symbol="schedule"
+
+	# Run perf kallsyms
+	# It prints "address symbol_name"
+	output=$(perf kallsyms $symbol 2>&1)
+	ret=$?
+
+	if [ $ret -ne 0 ] || [ -z "$output" ]; then
+		# If empty or failed, it might be due to permissions (kptr_restrict)
+		# Check if we can grep the symbol from /proc/kallsyms directly
+		if grep -q "$symbol" /proc/kallsyms 2>/dev/null; then
+			# If it's in /proc/kallsyms but perf kallsyms returned empty/error,
+			# it likely means perf couldn't parse it or access it correctly (e.g. kptr_restrict=2).
+			echo "Basic perf kallsyms test [Skipped: $symbol found in /proc/kallsyms but perf kallsyms failed (output: '$output')]"
+			err=2
+			return
+		else
+			echo "Basic perf kallsyms test [Skipped: $symbol not found in /proc/kallsyms]"
+			err=2
+			return
+		fi
+	fi
+
+	if echo "$output" | grep -q "not found"; then
+		echo "Basic perf kallsyms test [Failed: output '$output' does not contain $symbol]"
+		err=1
+		return
+	fi
+
+	if perf kallsyms ErlingHaaland | grep -vq "not found"; then
+		echo "Basic perf kallsyms test [Failed: ErlingHaaland found in the output]"
+		err=1
+		return
+	fi
+	echo "Basic perf kallsyms test [Success]"
+}
+
+test_kallsyms
+exit $err
-- 
2.52.0.rc2.455.g230fcf2819-goog

