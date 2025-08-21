Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8562E1757
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794318; cv=none; b=T12jygBfh3M6UvXraA7fBhLEqloHr/uBHrcPgqjB/RQ01Xl+NCR7bFnS9O3yhMW3HqWAHMdaI7y+00RY/5nNI5J8qQugZvinsP7gtDacvrDBeU3TK7ESAK1cYfKuAgjKUapmCvBWzo8aP1NPI6frSo4/8duzx4Vs/YyaNIihonM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794318; c=relaxed/simple;
	bh=NTnQ9k5u7R42OUwbz6h2J8KHt5rVMSa96bg96BbPHI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qdst/Us9P0RIG+aKY0ARR+NwS51npZxjgFRFUVu+1xxeUskAvXzOWMhRgYhSZsMxrxhRaqaG8L/Y2nsWsjklWbu4ZFy5Fts9xG5vyBrwGLuZIvV/q27ZKN25EJqMHMSbjiKfAeiTyHFZ+yU4zqi9WLkyy+RJkPY/uv3Cp3exlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mmf703Z9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mmf703Z9"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47173a00e8so910571a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794316; x=1756399116; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCudO0lfsSIQDEPb/Z/odYNnD8Vvb98DSCImnP79+vg=;
        b=Mmf703Z9tiWAt8POjfmeVU2aeqvya8mb5rML1vBKQtoTyk4DJeoGONgorCcfWzztKZ
         p2pge+KSqNx4esEH6zMedLU8xj8/hAM2Utv/asf3jGrs/A2fgjWHJZ/Maht3F3XWRH9W
         5bEMCWC6pCAGGHqG3KYKmuVHLKoj4yZv1de0dumuSuAaOA9+HBjZ5HwLxpqsH/vI1XAb
         CsHxqGH+4n4DV7mlOGJIYCYscagF84riFScDQ2BSMXT1xtMqU+iCO2tUft1w9wGEvUJ4
         mYBLcpxaj++jgWPjtaTwg+icnXfsxFpDmmx1YI6yS8jf1fg0lvAS2qaB7u3x3IRM5Yqy
         F/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794316; x=1756399116;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCudO0lfsSIQDEPb/Z/odYNnD8Vvb98DSCImnP79+vg=;
        b=a2wtwyapY9+gWTvM9flGLcchnt4wJd2N8VEy30tbvsVWc5QJIlSwEIiUv+ZeqkXFfc
         ZgERve57a1XDLG8j8SFw/3GHM+vhdiVtuaLq2ihGDkf7XaemjNHaH3VCdcbNH3yZgsBh
         mZeCJL4f3nq55LUdq6GqooWrcj37Hek9JFZr7mxXY7oqulR4GhBc8QRVBYqrq0GMX2Nn
         t/eut2HXs8jrmA4VbEZSi0J3/PWbVZTPmY7T9Z6SvcYgdbL05p2fJME+isjdVnEuJ3xt
         mpxvCVYlUHvfRzJOrEE8ku+EqVAGGKbszg0KL2WTDMGeHPEcwDBlq1mZczdok7zuVz+E
         4ceg==
X-Forwarded-Encrypted: i=1; AJvYcCU2eemC4UXvhsEv99HAvQRYQExZoXV9O4wB4hOiDRBQ5ee0EXu9ahPJL1usC6CEYKoNYPNTwp0TJiwDgl8UUwfW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc51ibXC3+MYqq1cul4czMuWUV+FD8pnUJLD0gGy6KP9D/YEmw
	ybBh9hpDZM42N53n932gtx49mV/t7J1D1tjUcFBJ4LBLUv/p76pgWvB6r8MvddIbAXXrjLKDhT8
	23BAn08MrFQ==
X-Google-Smtp-Source: AGHT+IEeCnJ7b7Yhroqp8lnq2iRmwlgzQFOIRcCjMoaZ7MBplMnR6IPn6gc3uaSySrJy+SPVwdt4sO/70rsg
X-Received: from pgbfm17.prod.google.com ([2002:a05:6a02:4991:b0:b47:68a7:75e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9b:b0:232:e6ab:8de8
 with SMTP id adf61e73a8af0-24330890004mr4446962637.18.1755794316246; Thu, 21
 Aug 2025 09:38:36 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:18 -0700
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821163820.1132977-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-5-irogers@google.com>
Subject: [PATCH v2 4/5] perf test shell lock_contention: Extra debug diagnostics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Blake Jones <blakejones@google.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In test_record_concurrent, as stderr is sent to /dev/null, error
messages are hidden. Change this to gather the error messages and dump
them on failure.

Some minor sh->bash changes to add some more diagnostics in
trap_cleanup.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lock_contention.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index d33d9e4392b0..7248a74ca2a3 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -7,14 +7,17 @@ set -e
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 result=$(mktemp /tmp/__perf_test.result.XXXXX)
+errout=$(mktemp /tmp/__perf_test.errout.XXXXX)
 
 cleanup() {
 	rm -f ${perfdata}
 	rm -f ${result}
+	rm -f ${errout}
 	trap - EXIT TERM INT
 }
 
 trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
 	cleanup
 	exit ${err}
 }
@@ -75,10 +78,12 @@ test_bpf()
 test_record_concurrent()
 {
 	echo "Testing perf lock record and perf lock contention at the same time"
-	perf lock record -o- -- perf bench sched messaging -p 2> /dev/null | \
+	perf lock record -o- -- perf bench sched messaging -p 2> ${errout} | \
 	perf lock contention -i- -E 1 -q 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] Recorded result count is not 1:" "$(cat "${result}" | wc -l)"
+		cat ${errout}
+		cat ${result}
 		err=1
 		exit
 	fi
-- 
2.51.0.rc1.193.gad69d77794-goog

