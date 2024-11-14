Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603819E7FA;
	Thu, 14 Nov 2024 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619173; cv=none; b=NLRCv7Y+Nbnd8s0R1EhnViYyEvczAi8dKIbH/RUIzTK9KOt/jsQ52Vi3w+NSgG5iCyudLvPYEcGkDq01e9DXuEO5jl6XLq7RCo9UJPhFbJmL3t52PBOutikFz/PxTeS1fvkY+elFyECCc+/BzHM4aH9wm9HAUuMSslykk6blFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619173; c=relaxed/simple;
	bh=kHLqa/Cx6RVfy8mdFeRqSbn6D5NW9Lp53z8PaU35d8A=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cB7TOyAk1PaqDPFU4s5AWFrHEMgBmydyEkSTzSikscnuEU4XeD6bxA6ahd7EUvUAzmdlpbWlQD+YbupvjFQVA3WNHp5sJSiWyCWVYnwEpKKdbDRtYGhvmsZ7EVBW1oYdPGsQkQEoXn/CqIr/DKHsDMBHWTj0GiN7xEjzlCSju3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0X1Rmv3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0X1Rmv3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7240d93fffdso60950b3a.2;
        Thu, 14 Nov 2024 13:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731619171; x=1732223971; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TO5ZQGzBbv1u/y921AyibJwoL8Fnkl/A45hiTfl+ZEU=;
        b=a0X1Rmv3GQ5AHx0W0hybfbB4SBG28o7DH9KkVTKT5tx5uFahfBGVo2/JMh3Q43Ubff
         SOP3KJ/CWq7FdnBQy/JdLjmREnz1ZD/oEiyk1hN0AJKO4U8K2+K2ypJ6V5TmMIR1W8iX
         Zo/h0xFDvC4xRQiRWVNf8uZmOpUQ5QBfkyXonmryuj0zaPUBigJDCSfn5SWa4hILShc0
         +6UZFNBuO0bx153Xnq3ErsPw4c+ipmXUfshGILYujjgsRCYsjDbFjAITbGwkJg2xYIGs
         b13tlJVQqX51YXt3u3T7cKE0FGiEDY0AR/L6J2vTJuXRkPgQeIHyDeqonBEs6GsxwP0G
         +w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619171; x=1732223971;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TO5ZQGzBbv1u/y921AyibJwoL8Fnkl/A45hiTfl+ZEU=;
        b=QZKMFL48Rv7K+FvdEXYSG1zxDuFIFIXfmIFFW240REWB0KDSAgEGXzOEBHhG+Nqqt9
         gyWXGOS6i0CiU/3ElQMoUa1GMhJQxy1SAqrm2qs+IXu3d6LHND5JK/D+He5v+pvN77tY
         GM5eP4TajAj1i7IMBy+71qjm9iPJU3aBUND0FcpWX/oGmu3JSyd2IjYfcKWVQ0o2QFk6
         nw3KRYSv1robI/Us3IL/vVSpHWnPOiv2Dj/k7qS9ylNlIsOMk6nNm4YlMKXiVxEqB9/l
         x8JZuZJB1R1pvmMvk5m+DxZXq4KDYNW6b53kqKm8Do4qfCZ0EAVnmzHUJc8j+dZBBLJ/
         n76A==
X-Forwarded-Encrypted: i=1; AJvYcCUB/taxRb6t/IwVnu5dlQNRhHO9aqVVM91S+Q/UAH7CmvWTcbsKgXum7u2WohIAq5iBlx52ccrOFUvENcJlii/GiA==@vger.kernel.org, AJvYcCXa/WDidW3ztgFjmbjD9dEk3w79bMXrOs0nsS6VXu0mvye7cMb76cN0loQ8+5n7V0R15RE/OEPiOr/OP2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YybvGC06ZorpCdSSfSRsK/O3bbNWFJmij5onKcNY82CtXxLg6Pv
	pcbnrr6/3M9LJy3o6bvHbGkX/epkxl36lQ8E2G6UDWo3r2Qw+TOg
X-Google-Smtp-Source: AGHT+IEvbqDE5Yxi5kCm1JMoV9uvOJQS8YTA5qVJAMNHTm2nGv5LjhMdvvm9k+7wPKpRXfIYlm/U9g==
X-Received: by 2002:a17:90b:5282:b0:2da:7536:2b8c with SMTP id 98e67ed59e1d1-2ea1559d064mr372974a91.36.1731619171439;
        Thu, 14 Nov 2024 13:19:31 -0800 (PST)
Received: from localhost ([187.19.172.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024b82aasm1745322a91.33.2024.11.14.13.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:19:30 -0800 (PST)
From: arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 14 Nov 2024 18:19:27 -0300
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tests shell trace_exit_race: Show what went wrong
 in verbose mode
Message-ID: <ZzZpX5O053UsHmsV@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is in the tmp.perf-tools-next  branch at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

I'll later add another patch adding the --no-comm to the 'perf trace'
command line and will adjust the regexp.

- Arnaldo

---

If it fails we need to check what was the reason, what were the lines
that didn't match the expected format, so:

  root@number:~# perf test -v "trace exit race"
  --- start ---
  test child forked, pid 2028724
  Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$':
       0.000 :2028750/2028750 syscalls:sys_enter_exit_group()
  ---- end(-1) ----
  110: perf trace exit race                                            : FAILED!
  root@number:~#

In this case we're not resolving the process COMM for some reason and
fallback to printing just the pid/tid, this will be fixed in a followup
patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Peterson <benjamin@engflow.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace_exit_race.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index 3cf2d71a5c3b9278..ce05d4e6e7133cd1 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -11,11 +11,17 @@
 
 skip_if_no_perf_trace || exit 2
 
+if [ "$1" = "-v" ]; then
+	verbose="1"
+fi
+
+regexp=" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$"
+
 trace_shutdown_race() {
 	for _ in $(seq 10); do
 		perf trace -e syscalls:sys_enter_exit_group true 2>>$file
 	done
-	[ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' $file)" = "10" ]
+	[ "$(grep -c -E '$regexp' $file)" = "10" ]
 }
 
 
@@ -27,5 +33,11 @@ export PERF_CONFIG=/dev/null
 
 trace_shutdown_race
 err=$?
+
+if [ $err != 0 ] && [ "${verbose}" = "1" ]; then
+	echo "Lines not matching the expected regexp: '$regexp':"
+	grep -v -E "$regexp" $file
+fi
+
 rm -f ${file}
 exit $err
-- 
2.47.0

