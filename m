Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7D36B928;
	Sun, 26 Jul 2026 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109234; cv=none; b=cO6IonJRMoOCsFtkZvX5ILpUBPz4mG2EpuW/rLbk3GmN92xwLmZr8Cj+CY39Uc5QPboqBcVpcgSepJRMe78AtSpIG/M2AeaP7+FQY904M8u++oaZPBlYOOSU1W3otHDVmIslPbSYWiV0KnRmfM6zy0NDCFudKGqX2AkC9VkxZp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109234; c=relaxed/simple;
	bh=tZzOQqJxl2tV5iyrQnB+qnz6ftAodGw5yARHPRfU4/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5fRECSeY2VWSey10kTH6Bsy/2DvGwrlIOi9c1/Lgh5FMdKbb+BQ1D2zShJVRD1P/q9lKyTWfRR3vCRE8QdWj7gHW5mkE6MNS6tiTV3yv6fNhUDSrTUU93vDfcY7H9qbFzC8oBNwfEV+lO0AtL7FRWgeOLz3ujGeDBntf8UiK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJO6AV2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJO6AV2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB55F1F000E9;
	Sun, 26 Jul 2026 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109232;
	bh=oVQKyMrefl4o5FGNCftdk5qJmDknnlDADXsp2KD20R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CJO6AV2T3Xkggocdaxh3tbSKrwn5ECMKG2H9uvWQzTWICP+ucIREckkqBzY+j9PrU
	 TiyGr9oMUxpVt5rIEA36Eu8l9kdax4gDd43Caw5aBRUeqjtDW2YzNKHknmxTV8sMqd
	 xL5T/qqGAcvh6cuW2zCHxvudkUJYTARC550bqORl1QiYl1IlRykIwPxO4KLaomYIH4
	 JkhIW/BLkNLHLn0AEadPxz7TIkzO0sTj2yc6C6/o/YyuPEU9vplwRmmMXgNCGz7rn6
	 UJK01NcevwPGmcyLSXtYfOGj1TAcJk+z5CaJy7Qj3v8XBQxEzCsVaIVmKiKQJ6UWvH
	 MJyTdWmCWk0ug==
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
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: [PATCH 4/8] perf machine: Check snprintf truncation in machines__findnew()
Date: Sun, 26 Jul 2026 20:40:10 -0300
Message-ID: <20260726234014.63111-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726234014.63111-1-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The guestmount path is built with snprintf() into a PATH_MAX buffer
without checking the return value.  If symbol_conf.guestmount is long
enough to cause truncation, the truncated path could match a different
directory, causing the wrong guest to be associated with the pid.

Check for truncation and bail out early.

Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Zhang, Yanmin <yanmin_zhang@linux.intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index baf855e596c267cd..05724277c2a9753c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -333,7 +333,12 @@ struct machine *machines__findnew(struct machines *machines, pid_t pid)
 	if ((pid != HOST_KERNEL_ID) &&
 	    (pid != DEFAULT_GUEST_KERNEL_ID) &&
 	    (symbol_conf.guestmount)) {
-		snprintf(path, sizeof(path), "%s/%d", symbol_conf.guestmount, pid);
+		if (snprintf(path, sizeof(path), "%s/%d",
+			     symbol_conf.guestmount, pid) >= (int)sizeof(path)) {
+			pr_err("Guest path too long for pid %d\n", pid);
+			machine = NULL;
+			goto out;
+		}
 		if (access(path, R_OK)) {
 			static struct strlist *seen;
 
-- 
2.55.0

