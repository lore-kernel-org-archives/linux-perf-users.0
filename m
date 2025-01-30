Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1D8BEC;
	Thu, 30 Jan 2025 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738206327; cv=none; b=AO/k+yus2P2YzMIE4N/zXd1jDvXwuMiDAoXjyyNPYFYJQxKrBY4xCSWduHLwD+e2Jg7BpGAGcuzJWu56szkR8h+VhYfne3LP4wG8GUjP1vD+UmFNn+SYEAGz3eR6wWEVZTXUZjuSI25wujYJpdjpA4kUv/2furkAmvHQf67Q0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738206327; c=relaxed/simple;
	bh=ncr38Mw95epPDAj1M2Fo7DYw4ha8nWMWZikJd2uPCig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KecCJOc95w8vg0k6E5u3uPRPH/uLaN4Eng9pWVuzih/B+SYV91kHE+Tilp2zMQ8vpY9sBtMXrZ2y97h4Goi03YECWtI4KFKh8Apy8oqplrPnTe9Qcj6opV3vG9zqGnih3FaNktkoSWhkhMMKOFG67Dvr6RUFJRLZvsluLScys4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5cYTlDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5cYTlDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B79C4CED1;
	Thu, 30 Jan 2025 03:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738206326;
	bh=ncr38Mw95epPDAj1M2Fo7DYw4ha8nWMWZikJd2uPCig=;
	h=From:To:Cc:Subject:Date:From;
	b=A5cYTlDnryUSFaO2Xo2oE6ehhP6n6zEcu9bzkhi+mGR079huwXqnvqwx+ahSYt1Mr
	 zK/WkjSE6gHNS55mOvYtX1ltPeaova6YkuqReGy/8vihKqe9AIKSZqSApI2GLjzUfS
	 B+mLJ3ugRX0anTaxLi/ZVUEOXU2z8cZcFJalOKEolbjONCBrOl278DU/jGEEykH2DY
	 CQydbQWoQZIvRRli+Il9HIvuL5nAKkEiax0hi546ToUcQymNZnVEebPgAGDSGlRMDG
	 3IqQJaeduXFnPlXR6DBnczXGbGr+WUp3eQnkNiwZvpUIJTq83IPEpDyBQ4Gy+F/nkg
	 vmjJdfRJL3Miw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 0/4] perf trace: Add --summary-mode option
Date: Wed, 29 Jan 2025 19:05:21 -0800
Message-ID: <20250130030525.1482498-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I've realized that perf trace shows system call summary at the end for
each thread.  But sometimes users want to see the global whole system
summary or statistics instead.

So I've added --summary-mode option like below:

    $ sudo ./perf trace -as --summary-mode=total sleep 1

     Summary of events:

     total, 21580 events

       syscall            calls  errors  total       min       avg       max       stddev
                                         (msec)    (msec)    (msec)    (msec)        (%)
       --------------- --------  ------ -------- --------- --------- ---------     ------
       epoll_wait          1305      0 14716.712     0.000    11.277   551.529      8.87%
       futex               1256     89 13331.197     0.000    10.614   733.722     15.49%
       poll                 669      0  6806.618     0.000    10.174   459.316     11.77%
       ppoll                220      0  3968.797     0.000    18.040   516.775     25.35%
       clock_nanosleep        1      0  1000.027  1000.027  1000.027  1000.027      0.00%
       epoll_pwait           21      0   592.783     0.000    28.228   522.293     88.29%
       nanosleep             16      0    60.515     0.000     3.782    10.123     33.33%
       ioctl                510      0     4.284     0.001     0.008     0.182      8.84%
       recvmsg             1434    775     3.497     0.001     0.002     0.174      6.37%
       write               1393      0     2.854     0.001     0.002     0.017      1.79%
       read                1063    100     2.236     0.000     0.002     0.083      5.11%
       ...

Also it changes internal data structure to hash table to track
statistics of syscalls.  And removes the rb_resort code.

v2 changes)
* Rebase to current perf-tools-next
* Fix some style issues  (Howard)
* Rename to --summary-mode  (Howard)

Thanks,
Namhyung


Namhyung Kim (4):
  perf trace: Allocate syscall stats only if summary is on
  perf trace: Convert syscall_stats to hashmap
  perf tools: Get rid of now-unused rb_resort.h
  perf trace: Add --summary-mode option

 tools/perf/Documentation/perf-trace.txt |   4 +
 tools/perf/builtin-trace.c              | 252 +++++++++++++++++++-----
 tools/perf/util/rb_resort.h             | 146 --------------
 3 files changed, 208 insertions(+), 194 deletions(-)
 delete mode 100644 tools/perf/util/rb_resort.h

-- 
2.48.1.262.g85cc9f2d1e-goog

