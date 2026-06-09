Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868EA2ED843;
	Tue,  9 Jun 2026 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967172; cv=none; b=W8MY0NF+c01L3tZWo1K5aLKIELxk1XIzXDBIEkp8U2i/PDjOlSJeEZ1cJ5g7NTlnHpbi9GvR2yCe5WSg0FTfu7xCPD5zjfnSIiJPeCMZARrKzkm0YMTCaPhHdrRQiLxbaJirkJTx06pzvpxCnGx7S10oJG4T0LeQKnXTZp9JqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967172; c=relaxed/simple;
	bh=yMJgGkJuSucgKFl5u5MUCYwBn0Er/QIaxK/j2pVCblM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipvLJ/R9ey/laywLnpQS50cd7Ai3652+7b761VEd7jUBTt3G0AC+gn633bagUanPsSwb7biRpAIOb0Tw9gt/NxhQZvnQHTgurv8JLpsCh54JH4h5ByDiMVao3dKEWys5MEAVWB6B+HFOgPK0wm8ATrUdTxmF9O7iiWOxbWlefk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOuPjUr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOuPjUr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A4F1F00899;
	Tue,  9 Jun 2026 01:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967171;
	bh=NaCFlPXNH2AMn8oHaARaPF1CjHZLGkHFysLw6i86WtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nOuPjUr1siQ2lOquwIGNAVG/H7X7p3JA4cE5BA8W8x3+/Pd0JJn4lvex5bsQmYB0g
	 qrl1UOdWg2twPVSVAW91E2MGANTCE2oc1D58WzGfAA3S/4mxJMa02RXVsdDLqg7BL8
	 Qf96FTyNcLxPf1YFsZeMhga8riXURtGIIrEyLlcjayEfb9G79AQi18y6DEyMXpoZlY
	 1wDIBR0TIEH8fkizSHuMPeyQWsoUiesEPy+2RJfnF+4ZibBR5ycIWVQE0bWmnTkHGk
	 eqbrG9jeM9PSA6iE7a3J5NIGdRFS8X5xZMCEmUcx8i81HDG+LDArIDPN8JNk+7puUr
	 8u2toQrAMyXhw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 10/11] perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()
Date: Mon,  8 Jun 2026 22:05:24 -0300
Message-ID: <20260609010526.1998472-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

build_id__snprintf() and hwmon_pmu__read_events() accumulate formatted
output via snprintf(), which returns the would-have-been-written count
on truncation.  In build_id__snprintf(), this inflates the return
value beyond the buffer size.  In hwmon_pmu__read_events(), len
overshoots out_buf_len and the next 'out_buf_len - len' underflows.

Switch both to scnprintf() which returns actual bytes written.

In build_id__snprintf(), also tighten the loop guard from
'offs < bf_size' to 'offs + 1 < bf_size': since scnprintf() returns
at most size-1, offs never reaches bf_size, and the original condition
would spin doing zero-byte writes once the buffer fills.

Fixes: fccaaf6fbbc59910 ("perf build-id: Change sprintf functions to snprintf")
Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/build-id.c  |  4 ++--
 tools/perf/util/hwmon_pmu.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 8c0a9ae932aa5798..82af3dca7e2fbb5b 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -93,8 +93,8 @@ int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size
 		return 0;
 	}
 
-	for (size_t i = 0; i < build_id->size && offs < bf_size; ++i)
-		offs += snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
+	for (size_t i = 0; i < build_id->size && offs + 1 < bf_size; ++i)
+		offs += scnprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
 
 	return offs;
 }
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index fb3ffa8d32ad2a93..dbf6a71af47f9a42 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -442,12 +442,12 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
 
 				buf[read_len] = '\0';
 				val = strtoll(buf, /*endptr=*/NULL, 10);
-				len += snprintf(out_buf + len, out_buf_len - len, "%s%s%s=%g%s",
-						len == 0 ? " " : ", ",
-						hwmon_item_strs[bit],
-						is_alarm ? "_alarm" : "",
-						(double)val / 1000.0,
-						hwmon_units[key.type]);
+				len += scnprintf(out_buf + len, out_buf_len - len, "%s%s%s=%g%s",
+						 len == 0 ? " " : ", ",
+						 hwmon_item_strs[bit],
+						 is_alarm ? "_alarm" : "",
+						 (double)val / 1000.0,
+						 hwmon_units[key.type]);
 			}
 			close(fd);
 		}
-- 
2.54.0

