Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA52FF672;
	Mon,  8 Jun 2026 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882363; cv=none; b=gSvg2K7JcwXwc3M0KSRhe8odLQHpLq7y5MCH3RmVAhYDAnZEAdUKNycVs8DWKW1OCNAbMZNSk+g2PoIVqnPIP5e38WGzuhFYWT9Q25Da839oQHGY3F9bQrZEklThEpgT11mufbH6l+J4Y+KNXciUF8hEZd0G+p5qxQ1fLZd9wK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882363; c=relaxed/simple;
	bh=pztbD3iX3pd/KugXnN4XjAccZtUYB6eLIx5zr1pj1X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aptjqoiZ1Ps/i5PqzHWcp4Hh9JpeVujv4uSXtlu46g3gW8ou1AhJUMGZrdwgWV83b+zJRM4vgAP55xOa5aTBLOajdgs4/1C0r6epFhrJ1U6S6gdGg3iWhpz3aUOO9Ik5C8cPxYcjOTnEHW1krR/Bp0QplysPlnHAVgw6b54cgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PanchjKr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PanchjKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562CF1F00893;
	Mon,  8 Jun 2026 01:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882362;
	bh=vJrjz18WP9YOQVzzuYUbzW7bbrjWzAs6Y8JS41ckrzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PanchjKrWbxEKsw3/+lBei8PMyInExfAPwQ0cLNJjXu68pB4k7+koAKTEYCOLMGOw
	 8+KYJTcaYkT5EyVoPkN9FwofmhmEA5uEj4Ucq0qzLuZVoar9IGLYCmivT9ey9XFAmn
	 yn9IA2KjbezSBAmeQmJwPWL79/NSLd5sl5CaLWBvdRJpCyNOC8KZY+b5FuLIzGr+VR
	 jMa6T5STjKpO/ct2A/rN4WpMQNnUWOCk81TjrGA2Bx69QSUFRBXTNwSHFuQJpMcD2y
	 KSRF3vDHTM3N1F6Ke7IbPvFKBRb01jDAz/m7szD2WiME9Cy+CO+j4F5QJiohNBunKw
	 sBAyeIlT9+CTw==
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
Subject: [PATCH 11/11] perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()
Date: Sun,  7 Jun 2026 22:30:55 -0300
Message-ID: <20260608013057.1942953-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
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

Fixes: fccaaf6fbbc59910 ("perf build-id: Change sprintf functions to snprintf")
Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/build-id.c  |  2 +-
 tools/perf/util/hwmon_pmu.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 8c0a9ae932aa5798..a3b92108f96263c6 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -94,7 +94,7 @@ int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size
 	}
 
 	for (size_t i = 0; i < build_id->size && offs < bf_size; ++i)
-		offs += snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
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

