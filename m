Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E752DE6ED;
	Fri, 28 Nov 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764366667; cv=pass; b=NoTRtbT98b53cSv0wCunCSyPpKpGrvDoXR7u/054mj6OLG2shexqiNozAqUNoUDRtb9NZ/Ckn87wBJ7y/1PdoLLedGk2ipz0DVnyPmsCAN6++04EcbmSg6QOYGi3wCY3+7pIFBSh/ti1A60a4k4KhxOg2qJDon530bjO6YFHveE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764366667; c=relaxed/simple;
	bh=qQRcI+wRDXx4ymislfCsU3+S0Zn4T/BN7+ByA3iTmno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEIgMHAXNt5xF3xv92YCwYJ6j3FyZ1B9iV732m4M9qkv/zrWqBqjq/qDOXzx9PGDL+ACs7axipqTwpREax+E+m7WwjWMfz4gZoShV/n6Kt7U2F4TvHmuHxtaTlxLwy/xjBu+vzyVsjj8b6rCRz49MX5M/KgFBq/rSAV59zrfRXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b=CSS+Ms54; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b="CSS+Ms54"
ARC-Seal: i=1; a=rsa-sha256; t=1764366643; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NGEPCWp1CS4uje4FGqpds3MtkUS7WvcG+JqcL3J4h1Q9XN4lOrnvRIhhjiCgRippCamE0VSX/V7nduSjjcHl+mQq9TAcux1bvVM0e/kCZk2k297wiNgLTyWeoFmxdxuuWY1Lma7i/vC9GB1jTUdm8phWMKV7i6bGnmxOmiTC0Do=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764366643; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tZy1a+SEkdBwNrFXaw+TkeD7bd1JN+PUBzV8Cwb5V4U=; 
	b=Gi3KVVKPYiOwgkbLFMDevD6+EOg2CQWmj+IFlhCH/5FlyyIRBBYlliGSGskG1hvrDOTWuzxhY5y/D5AttuJZEcJp8yKI4PJUH8sfsFb2IaMoiDYEuzFAPBngzk7Zp6BrILHGa8HcX1CHVGrRSC6KG5WRcgznOgIyBqwfUJja2no=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=derek.foreman@collabora.com;
	dmarc=pass header.from=<derek.foreman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764366643;
	s=zohomail; d=collabora.com; i=derek.foreman@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tZy1a+SEkdBwNrFXaw+TkeD7bd1JN+PUBzV8Cwb5V4U=;
	b=CSS+Ms541Aaohrq0OYl4wRKv7xfxrOPlhj317QTeERmrTn1ZkQAW5FD+5EysisDc
	4vKvcE7120rrtyloTgX8t+mEYcFj/DhNHIGMTudSrIsUvCoFE8g08jtrJU5gLvoL6vZ
	yfJvlR/l6cHVkd6d/GqkP9wIsQMBnobLmucoQ+LY=
Received: by mx.zohomail.com with SMTPS id 1764366640439294.1305740386;
	Fri, 28 Nov 2025 13:50:40 -0800 (PST)
From: Derek Foreman <derek.foreman@collabora.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: kernel@collabora.com,
	Derek Foreman <derek.foreman@collabora.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] perf data: Fix coding style
Date: Fri, 28 Nov 2025 15:50:18 -0600
Message-ID: <20251128215020.184466-2-derek.foreman@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128215020.184466-1-derek.foreman@collabora.com>
References: <20251128215020.184466-1-derek.foreman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Adjust some oddly indented fprintf() calls.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---
 tools/perf/util/data-convert-bt.c   | 6 ++----
 tools/perf/util/data-convert-json.c | 9 ++++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 0bcbc0e309e0..a22e9049ff30 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1693,12 +1693,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	else
 		pr_err("Error during conversion.\n");
 
-	fprintf(stderr,
-		"[ perf data convert: Converted '%s' into CTF data '%s' ]\n",
+	fprintf(stderr,	"[ perf data convert: Converted '%s' into CTF data '%s' ]\n",
 		data.path, path);
 
-	fprintf(stderr,
-		"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples",
+	fprintf(stderr,	"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples",
 		(double) c.events_size / 1024.0 / 1024.0,
 		c.events_count);
 
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 787039967916..eefa3a94c813 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -427,13 +427,12 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	output_json_format(c.out, false, 0, "}");
 	fputc('\n', c.out);
 
-	fprintf(stderr,
-			"[ perf data convert: Converted '%s' into JSON data '%s' ]\n",
-			data.path, output_name);
+	fprintf(stderr,	"[ perf data convert: Converted '%s' into JSON data '%s' ]\n",
+		data.path, output_name);
 
 	fprintf(stderr,
-			"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples) ]\n",
-			(ftell(c.out)) / 1024.0 / 1024.0, c.events_count);
+		"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples) ]\n",
+		(ftell(c.out)) / 1024.0 / 1024.0, c.events_count);
 
 	if (c.skipped) {
 		fprintf(stderr,	"[ perf data convert: Skipped %" PRIu64 " samples ]\n",
-- 
2.47.3

