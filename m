Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD432249E5;
	Thu,  9 Jan 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436221; cv=none; b=OraDa/sOE9ydAZd/iIn3jVofvKQyzQTEuehxt1j+khrDxrec7vz4415tYNUwTC4xpZZopNcci7N0NuFPrtlaxNXWKD+AC7D78Pe0s0S/Fslt3aMZ2XIf1W79jF0rcg0Nogn6EcSL4ecAYT6zwaaKuwVwKVFkdzk+yshwtOU+Iak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436221; c=relaxed/simple;
	bh=vpuNwYa0uuQFNz/rkt2RVOStAFsgDgafU3vwSUzRnWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+XK/LTws8olDQ7kSf3e9oLoCm0gUrrwKNdqHE5d/btnIM/kln79g92bDmWVE+lhC6CMtW/fuRz7gcBzqyWW5LHZWpCl8BWH8nHUWNQwJe03vwf7f0JainS2BdbslAaatKOrjkLzqIwzMiD4PgKvIGYZsYdoRqUf8ha3J773NLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jcix.top; spf=pass smtp.mailfrom=jcix.top; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jcix.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jcix.top
X-QQ-mid: bizesmtp89t1736436202tj9nyvoe
Received: from jserver0.. ( [111.193.138.203])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 09 Jan 2025 23:23:20 +0800 (CST)
X-QQ-SSF: 00000000000000000000000000000000
From: Jiachen Zhang <me@jcix.top>
To: linux-kernel@vger.kernel.org
Cc: Jiachen Zhang <me@jcix.top>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v2] perf: Fix a wrong help message
Date: Thu,  9 Jan 2025 23:22:19 +0800
Message-Id: <20250109152220.1869581-1-me@jcix.top>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:jcix.top:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MY/4gqRZUG70xdR6ZG2zY+2lzIq2MW78rXojSD9zsOkDDrZ9Uyw7+/vF
	3/1NAgyFyRQcbM5wKAHzd3W0MqUpltgaNNOObM6XBHOohB427vkzuOi63rvQBD25VciR5t9
	ep9HKqjp/+RgD8XxRv/Qw+UD2RrlNQ3sOGM6cVm6fleEwEByG5Cu/sAP2z2d5sf7Z2A9FwT
	VLa3szjZmPsFkNo72EoSmwJbE+0sPLMJ5GWkEHimz304GeiJqGvT1CVdEszshKKG0IP39GC
	YK/sYMkKi8hagF5Pu4RQnGi8xa17zSfRKARApEExxk6LJR4fzEjBvd8Rmgaa4rA5LY4xiz6
	FyGzWd03y7z29Mf+qRKpZmN10yA7awQFK0HcuWYNnbcsevtWJYSR3euG6KPdhhsm4443l3q
	g4E85xR6JcmbIMJTcfDW8mzP1O/lC8QbufB3KVuz4V5NDa/hT6AACUy4RGPu3FgFIu12aOU
	SD34LwGuOyjdvGMpsuZWWj5JEcus9H6TFZdzvbocFWQOy07IrvqlQsdVdYv6WM9u5tfgBov
	um3eiVO0ZlzmELGuTUSz/GLNOO1Nsu29ba70SCIV6DNKzPrm04zYTqWY/gOKlZsfqpDi2H7
	Bvy5XxmQfQiXVWMJ+qsdy7uwnXuY2OUeEROOdBcd6COVhnoCZfWJCCzLT3WeDuPMvxdmNAM
	qKWLsnbOMsUQjYsvxLZ49cAE4aV2+/oswmty8YraJL/bcug+8VDlIMfbyCqi01QXbxo+Z3V
	GEHDIOSNK2OMbilIkzmfrV1w6TnhU1ymCzzQ0YCu5YQimqDAz+esUWaoUiLXzAsRYFH5aOT
	P0Ty1IMOj3aPxLOuZhs1ICmmz/xCEhectKkufUOFnhtxSPiwt0E+Xi7KcZfA91G9vLAuMZf
	1v6hG0qjY80MlkabZ+Ujixqp13KUfY37Lo2eecz4klIoh8E85AY+70UdSs5kEC5I6Mk82Aq
	9r+AW8dEBEzT/UL8HkAllFiaMI5Fff63GmAQSAhfWadWsNlLkh/SaOgppg846j9DBQg1vOb
	qjBsnrYbmUMstbFfzRZ2vhpyxiTc8=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-SPAM: true
X-QQ-RECHKSPAM: 3

The wrong help message may mislead users. This commit fixes it.

Fixes: 328ccdace885 ("perf report: Add --no-demangle option")
Signed-off-by: Jiachen Zhang <me@jcix.top>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 048c91960ba9..a5672749f781 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1422,7 +1422,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_STRING(0, "addr2line", &addr2line_path, "path",
 		   "addr2line binary to use for line numbers"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
-		    "Disable symbol demangling"),
+		    "Symbol demangling. Enabled by default, use --no-demangle to disable."),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
 	OPT_BOOLEAN(0, "mem-mode", &report.mem_mode, "mem access profile"),
-- 
2.34.1

