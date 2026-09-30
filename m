Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13C4DDB27;
	Wed, 30 Sep 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773934; cv=none; b=NPfGj1GIS38oQzpjoVCzmGaTSKYBK8vhnDY8Gb+tlRYdKOjGsi7vL9Jit8vzryQzvZ5cPGoC+iy1OExVdBaxOzPLqMw7y2Iai0W4YX6RbRAzk+cT3OIq56dL5pHbbAL2AIpXo9bMn46w/WPydk4Ym2mGUXgeDg1JHQFIoCCU99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773934; c=relaxed/simple;
	bh=cYj/IwgZOGpvuHZ3PhyEo2b3WW5jo1U+Y/ZN3oRMbQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdn8OZfGJ2Ix1hJZX0uL1NojG2dXXbyj9EmiHVQFLIrW1o1Mjnd/2HeVSCJz2WMOKqPIwp4PcpZ/Yiy2XZKFwmvJYJIBDIMo94FFt//IbxhxxumUXe7VsCNop+ZH2DYrexC3IpRmqkiPlhF3gqg6OqAMpwMhf2YlEziI+tVIq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=q5NjspRi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q5NjspRi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC42C169E;
	Wed, 30 Sep 2026 06:11:50 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1B933F86F;
	Wed, 30 Sep 2026 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790773914; bh=cYj/IwgZOGpvuHZ3PhyEo2b3WW5jo1U+Y/ZN3oRMbQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q5NjspRiBGJEkU84saywkQXV87ayOGmpuwc9tZxANz3tXNxutYKLwxbBORxmWjFrC
	 10ZTGrari/GMGNDtjM1J8NyUB2H9oJFO1U2xikOgl14L29ly7QiiNBwn+SaOd2TVOq
	 x7AmC+IPu/BRAPooAnJTeVGl5zPXHSsp1GkTG0e4=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 30 Sep 2026 14:11:39 +0100
Subject: [PATCH v2 4/4] perf python: Avoid shadowing exception name in
 PostgreSQL exporter
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perf_fix_pylint_errors-v2-4-945cd526576b@arm.com>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790773904; l=1345;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=cYj/IwgZOGpvuHZ3PhyEo2b3WW5jo1U+Y/ZN3oRMbQA=;
 b=kpxLVNL3EO5HLwz1dxjGD8o637iE0kQbCTuLRX1Bs9k3SYvDjCbtV9Pre93cSAXW+CuH88GaU
 TJyByeDwf+zD5VpeC/ijFpzlEqG4hGa8D4g0Zd2jEp9xTeunDiFUGmB
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

During the perf build, pylint reports:

  ************* Module export-to-postgresql
  python/export-to-postgresql.py:319:8: W0621: Redefining name 'e' from outer scope (line 100) (redefined-outer-name)

Rename 'e' to 'db_error' to clear the warning.

Fixes: b1f968c9656a ("perf python: Port export-to-postgresql to perf module")
Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/python/export-to-postgresql.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/export-to-postgresql.py b/tools/perf/python/export-to-postgresql.py
index b6782129354ed3b1bd750af41e7a002c7134bf12..9cac64dee361214de3d1f9907c5e6849327c8ed7 100755
--- a/tools/perf/python/export-to-postgresql.py
+++ b/tools/perf/python/export-to-postgresql.py
@@ -316,9 +316,9 @@ class PostgresExporter:
             # SQL identifiers are double-quoted; escape embedded double quotes by doubling them.
             db_name = self.dbname.replace('"', '""')
             self.do_query(f'CREATE DATABASE "{db_name}"')
-        except Exception as e:
+        except Exception as db_error:
             shutil.rmtree(self.output_dir_name, ignore_errors=True)
-            raise e
+            raise db_error
         self.disconnect()
 
         self.connect(self.dbname)

-- 
2.34.1

