Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD9129A75;
	Thu,  9 May 2024 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293507; cv=none; b=DNa+Z6P9WzOcZXRQ4jxJqOD/fOQLqRtdlA4kXkg7SR+Ybx27y1VqekjSPKkeiHnJQSsewc9B1d2ToWcvzVdDNM3CZi+gEhfiBO9BrWPHzYVUjjosXYCYaXYJpgXN4QbeZlwxbFqN++VdNRQvt+F8ibH1LUj5ONOO5y65QA4xF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293507; c=relaxed/simple;
	bh=kr/ZNHJe3spo1D73S8skNdfLjRrNUc3DVoBssZVUO0A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y14UM/1KMU7T+Xt2Z4OqQvGQRJLWF8R/szz9XCbJe1J9zVb79Vi1LJAa1gumLIB/HW66aWmme2oQeADgM69ViCnb6KZhVOasHOSUeTgT7APV9dhuVO+WXQaVa155Wkf8qUpcGuefEjRq+jflYy2oJRUuOWyGPr20lax6QD7Alzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sAo0OW22; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sAo0OW22"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C29AB14C2DB;
	Fri, 10 May 2024 00:24:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715293502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DWHEKSwlaTW2I1c9ZQNwSBEzyucWLndKRYjge2yxE14=;
	b=sAo0OW22vx6bx0E/WcND8x8g0nH9lX5Z48gKk34Gbk3dE80xW6h0pN1IpMWUA6OGIYBSCG
	OfhkL40EXRN+YffyMbxag3WGCmQgUC+invDYzQvJRA24l9XTfxrOEnVfjMnHJ4FoZbmye7
	i/3cXka8D6b6VSHSAl1M4wB1tMabCwfM7s7sMiQwvXJYK8Ggn4y9X5Y4lU+GMfI6JmWYgU
	HxuyUljTr7kcgrVjyDHkTqtPRIiH3OB+8POTIebTUcNrvSddSZDPYN4qv1EAGZYlYzPDZt
	qQywzvpjWL9yKPqPC7KWtxtf6SdXN2P+kI9Iw5O5DMLwLIAdeCIG+htjMkvW+g==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 18db1a50;
	Thu, 9 May 2024 22:24:55 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v4 0/3] perf probe: Allow names to start with digits
Date: Fri, 10 May 2024 07:24:29 +0900
Message-Id: <20240510-perf_digit-v4-0-db1553f3233b@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5NPWYC/23Nyw6CMBAF0F8xXVstfVDqyv8wxvQxQKOhpiWoI
 fy7xY1i2MzkJvfMjChB9JDQYTOiCINPPnQ58O0G2VZ3DWDvckaUUE44kfgOsb443/geS8q5MAK
 cKSnKwOgE2ETd2XYmc3M/D9yHcEu4g2c/11qf+hBfn5dDkddp9fpQYIKFBMukLRlT/GiDg0cEe
 92F2KBzPjXQLxdELDjNvAQLjMjaae3WOPvlasFZ5oqw0tSyUpXT/3yapjfzxMOXPQEAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=3040;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=kr/ZNHJe3spo1D73S8skNdfLjRrNUc3DVoBssZVUO0A=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmPU02lfGzMfwl2j9V/WvrwVcTMP2flg2RXt4bE
 epnYiRq2PaJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZj1NNgAKCRCrTpvsapjm
 cLYUEACbSNy4VjSDW8iZCoqCo0LdIgm9jz9I4phR11eIRzNJzXI7gnSuaQ1/Ww42VdTU5BET8JX
 b8snkXw20EKYCXJyaH2hZUU0UtBTT3Pbx0yOp619Ldz6og7uFPuBvamoGsHdqJq0LaKsyEFXvrW
 LoGvknUx/68bF0DyXNJ+Mb1ty+Wan0KxMQUDfVVak2BvqVthykVVWgyCNvtB2ipqkM+xHx/dOgB
 TFUV3AYyCNwaawixBCVOaMbxCIOnESiUD7YffvRtyBfLz1WkwBZ0lHLdNMJUfxJJpYW3vVFI7AT
 P3KvT5jeuyoPqI3/aJdlwyDk8rEKh7sQfhYpwmvPJPhlakByEyOKSrWHg26Z45wjljmJFL8/s5x
 /w1nm1KiS80QJ1yPjQQZAuSsJUjAxercvAyu3J/A0e4iqir4zjIs1Q4YoQHosJqGOX+c8OCWBkJ
 /vl3wS7C59uHInEiu70oK6xqpY+MxzU7va/RPIMqfb2ULXbrWDLukye8KxWiB798qgZSyJB0pLU
 KRzK0vcep+XHT743za7D1zCDCEYj4MzkPem6l3l/F73y4q1qJ7RijD5Qt/lmZPTBipPaiDVO8Oz
 yQuWfAK9GwMbplE4ugGbkOScWluSJbnybbRkj39DrEEMJOVYNqVQ+M5Bm7hyz6gliqdUdHfZ/Bf
 Bhp1/2jZ1ynYDAQ==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

This is a rebase of the patch orginally sent almost two years ago here:
https://lkml.kernel.org/r/20220612061508.1449636-1-asmadeus@codewreck.org

At the time I was asked to add tests, and Jiri whipped up something to
make the test pass even for probes that don't exist on most systems but
that ended up never being formatted or sent... I asked what happened of
it and got asked to send it myself, but obviously also totally forget
about it myself until I needed it again now.

I've taken the diff from that thread, adapted it a little bit to the
current master branch and checked things still fall in place -- I didn't
see any obvious problem.

Thanks!

To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: Liang, Kan <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Changes in v4:
- add missing ifdef LIBTRACEEVENT for new test case
Note build-test still failed on my setup due to some bpf/cgroup problem,
which is more likely a setup problem but means I couldn't verify build
all the way:
util/bpf_skel/bperf_cgroup.bpf.c:71:10: error: incomplete definition of type 'struct cgroup'
- Link to v3: https://lore.kernel.org/r/20240509-perf_digit-v3-0-9036bf7898da@codewreck.org

Changes in v3:
- fix evsel__newtp_idx typo in commit 1's message
- rebase onto perf-tools-next
- add trailers
- Link to v2: https://lore.kernel.org/r/20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org

Changes in v2:
- update Jiri's email in commit tags
- (not a change, but after being brain-dead and Ian helpful
reply I'm confirming patch 3/3 works as expected)
- Link to v1: https://lore.kernel.org/r/20240407-perf_digit-v1-0-57ec37c63394@codewreck.org

---
Dominique Martinet (3):
      perf parse-events: pass parse_state to add_tracepoint
      perf parse-events: Add new 'fake_tp' parameter for tests
      perf parse: Allow names to start with digits

 tools/perf/tests/parse-events.c | 13 +++++++++++--
 tools/perf/tests/pmu-events.c   |  2 +-
 tools/perf/util/evlist.c        |  3 ++-
 tools/perf/util/evsel.c         | 20 +++++++++++++-------
 tools/perf/util/evsel.h         |  4 ++--
 tools/perf/util/metricgroup.c   |  3 ++-
 tools/perf/util/parse-events.c  | 38 +++++++++++++++++++++++---------------
 tools/perf/util/parse-events.h  |  9 ++++++---
 tools/perf/util/parse-events.l  |  4 ++--
 tools/perf/util/parse-events.y  |  2 +-
 10 files changed, 63 insertions(+), 35 deletions(-)
---
base-commit: 187c219b57eaf3e1b7a3cab2c6a8b7909bdbf4a9
change-id: 20240407-perf_digit-72445b5edb62

Best regards,
-- 
Dominique Martinet | Asmadeus

