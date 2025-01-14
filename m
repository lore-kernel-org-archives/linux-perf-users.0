Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F820AF78;
	Tue, 14 Jan 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889778; cv=none; b=kz4LdihFyUehGgoIHm7Se+o2foG8di1di8co39a4RfM4ki+5d/6SErc8ZtH5tQDSJhM7ImxqbGQAWvrqFnGZxZ4an4qi/aPAUl3UohhWwx12J91bHTKuSIYpqjmfnwvEr2DsK/AeHXnfpycfoO1p2969PX/Qv/3++mOXkQ7aBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889778; c=relaxed/simple;
	bh=61jHI45N/+UZU/azmB+G3qQIdOfBU8HAvam8BCjntbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shnDf6BpNTSsoh03VqEGIZ1Ot7qIO/3Xg26K9muZr3AKz+SS6dOx3gH6eCjBnplbdSn4l/NdyD60NH7r+/GXZXGrE534R269Y/djnr3B00kyLV8H6MTab/N3qop2zI6pAskRy9ES/Xyj2oNnUqen3EAGXSe//IQPvos5hhUJ4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXxYL5kr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXxYL5kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBE6C4CEDD;
	Tue, 14 Jan 2025 21:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736889778;
	bh=61jHI45N/+UZU/azmB+G3qQIdOfBU8HAvam8BCjntbM=;
	h=From:To:Cc:Subject:Date:From;
	b=GXxYL5krNI48K6rvNOtyqwTu7KF9EiMVGuH+sHRCiECO1x48mi0QSkLbFTPOlHNsj
	 mvRde73K0Yo12U6Q7I569xWd1YZ0Z3kwvV7iodovhqPmInUh0aLC/+uKEiFkNuSIa1
	 gVWx80WzoHGxhAnUM+lCXHdYMowlHmOADFWKI2WGYagMhYQ5dpQA7GsExVbnh6GnDf
	 hLSPW6+jPZ5dVqmz5ITIcetecoVYjKpReApNwdmdB7aJeD5C5uZ/g8Z4B66osCltbE
	 ZyOJ4Gp+eZ7nubwaBT/3F2QT4Gfi7lcFs/8nIHT6nNwHnHpIJLd9lQ1C4g3nm7TSyy
	 8oXngOjBN1Uqw==
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
Subject: [PATCH 0/4] perf trace: Add --system-summary option
Date: Tue, 14 Jan 2025 13:22:52 -0800
Message-ID: <20250114212256.160730-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
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

So I've added --system-summary option like below:

    $ sudo ./perf trace -as --system-summary sleep 1
    
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

This patchset is on top of (but not necessarily depends on) my system
call sampling patch.

  https://lore.kernel.org/r/20241219183400.350308-1-namhyung@kernel.org

Thanks,
Namhyung


Namhyung Kim (4):
  perf trace: Allocate syscall stats only if summary is on
  perf trace: Convert syscall_stats to hashmap
  perf tools: Get rid of now-unused rb_resort.h
  perf trace: Add --system-summary option

 tools/perf/Documentation/perf-trace.txt |   3 +
 tools/perf/builtin-trace.c              | 222 +++++++++++++++++++-----
 tools/perf/util/rb_resort.h             | 146 ----------------
 3 files changed, 178 insertions(+), 193 deletions(-)
 delete mode 100644 tools/perf/util/rb_resort.h

-- 
2.48.0.rc2.279.g1de40edade-goog

