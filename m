Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858D02FD661
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799608; cv=none; b=u5OPvXzqIgQN/vuWtEi2DqsNDDK8aXiqXTmSWFcPtLfAb5g/KY8q4DJTq5Pvfc7+WUXXAHyEAheouJVP0Fj1a0LRpIBwBRioPz/QKo9907olteClsMxyfYOrRO7k6yNZd3wdEWLFm/BAIHCuC5ci/D/t280iy4563RoPejrw5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799608; c=relaxed/simple;
	bh=cVbo9KyKjAiks4mZRtglLay3uOkQ31MIH0rTAfdDkxU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eqfHTelSXhZKSl5c6Rx5V+g0Jqc849EDI32XsEuaWnkC97hYrmAlwIUbrdsd5/lEcO6sumg46IszdWdpocHu/H76sRE+1x6XWjNvAWxprgY6kYrRybnRhOzxU8M/Lp0IoA5a36/gY7Vvb4ZuIY31FiwGwPefEx1Qv5N5Q4Sy2bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDcwQ7K1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDcwQ7K1"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so4045381a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799606; x=1764404406; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5vcUZ36q7LIP5k988zWeeeMo0DAr72XmNMPXeiuOFk=;
        b=nDcwQ7K1EjzwrCoIPsER93yq7sG+vw8gu6NqIJmcseRTYyV/PGpapZG0uG0xOD6ZwW
         jlmt76Ic6y0lUeXmT8NYIf8TPXs6n2SB9MvOOR8FZ4/Yw09FhKRankk5ZwHONWjAq6Uo
         u6EhR4vDDrEjMIiwzeqK+BZnjyjw3QNwSH+U9Futm517ZAR3hskvc7sjq/iqA8dUHa0Q
         tsjupbjHv9R1AWUI71FS4B5tX7bhL/a9hJVWNNJ/BPs4GxZzI0WfHvKwPlNkaBL5i9Ru
         T2tHHoGjt6bH7NAcMeRYv+k2Ml1JYV4fT1Xc3dMF5hA5+/2hMELtFXOTExh2r6AZ2nVp
         nlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799606; x=1764404406;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5vcUZ36q7LIP5k988zWeeeMo0DAr72XmNMPXeiuOFk=;
        b=W2MxwotcADjBJn8Y1urHwgBsNqH7h8kykF6HUWwy6VrqRqs27wEgjucnmfibqfNOd2
         UzpT8rS8cK3ewAa66nAArgZ3P3R8/hETeXrXVAVA07neaOGgxmNv3xPSgy19dmNFj/sj
         QqG760SyF+lnS9/zGHBD+j1h4oTcAK0rkP6iw9pGHjHdd6sk9DAgmj19oxTeZDwusgi/
         Yf37m+JGzTVFyT65lZ+oFHZpkFtQkOHLjWobKBR7C1DgYwQDvagB4BhT+q/RMbsB3JAB
         GmMWB7nk3zrLAo4/JDBcDWVQNpQMGw6obh+u43cKAPxNXTMZJaN4XKFV6TTqh1Hoe8gR
         knRw==
X-Forwarded-Encrypted: i=1; AJvYcCUsE9Pt8JVI1+DK4DWKuzGM0ZA2jJhX4eIX9FF825unGepJlle2mE0ETpfCn+pr1PDviJ/V67juIbNplh84cX59@vger.kernel.org
X-Gm-Message-State: AOJu0YyERxakhFm0lKJv0pc8ud2jSjKvwL59YHd3r/qraF9naoTP/rb9
	zSHe3Uv3LKPVbhp4Agtu2DoVjT4acOMmDZfGFjxWMkAjKd350R0m2I9Uby8XrbqyneUJVyso62h
	Qw3suugZVUA==
X-Google-Smtp-Source: AGHT+IHp2n+PMLI6OfHsMt+oT7Bf6B1GSkHq8pvIHAETmUrFKTEcUmTA0f7lg7TVaCVrRV2nsTnRe5nKpQtt
X-Received: from dlbdd12.prod.google.com ([2002:a05:7022:a8c:b0:119:49ca:6b9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:388e:b0:11b:9386:8267
 with SMTP id a92af1059eb24-11c9d86fc93mr2488596c88.44.1763799605924; Sat, 22
 Nov 2025 00:20:05 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:28 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-17-irogers@google.com>
Subject: [PATCH v1 16/17] perf tests evlist: Add basic evlist test
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

Add test that evlist reports expected events from perf record.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/evlist.sh | 79 ++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 tools/perf/tests/shell/evlist.sh

diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/evlist.sh
new file mode 100755
index 000000000000..140f099e75c1
--- /dev/null
+++ b/tools/perf/tests/shell/evlist.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+# perf evlist tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+	rm -f "${perfdata}"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_evlist_simple() {
+	echo "Simple evlist test"
+	if ! perf record -e cycles -o "${perfdata}" true 2> /dev/null
+	then
+		echo "Simple evlist [Failed record]"
+		err=1
+		return
+	fi
+	if ! perf evlist -i "${perfdata}" | grep -q "cycles"
+	then
+		echo "Simple evlist [Failed to list event]"
+		err=1
+		return
+	fi
+	echo "Simple evlist test [Success]"
+}
+
+test_evlist_group() {
+	echo "Group evlist test"
+	if ! perf record -e "{cycles,instructions}" -o "${perfdata}" true 2> /dev/null
+	then
+		echo "Group evlist [Skipped event group recording failed]"
+		return
+	fi
+
+	if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*instructions.*}"
+	then
+		echo "Group evlist [Failed to list event group]"
+		err=1
+		return
+	fi
+	echo "Group evlist test [Success]"
+}
+
+test_evlist_verbose() {
+	echo "Event configuration evlist test"
+	if ! perf record -e cycles -o "${perfdata}" true 2> /dev/null
+	then
+		echo "Event configuration evlist [Failed record]"
+		err=1
+		return
+	fi
+
+	if ! perf evlist -i "${perfdata}" -v | grep -q "config:"
+	then
+		echo "Event configuration evlist [Failed to list verbose info]"
+		err=1
+		return
+	fi
+	echo "Event configuration evlist test [Success]"
+}
+
+test_evlist_simple
+test_evlist_group
+test_evlist_verbose
+
+cleanup
+exit $err
-- 
2.52.0.rc2.455.g230fcf2819-goog

