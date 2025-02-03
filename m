Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D620DD5C;
	Mon,  3 Feb 2025 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610711; cv=none; b=JYTGRJhsgPT1ldnbUk2sbVp6AQRpbgLXaUvpW4fCE92ZzGHNu8S20zheoLGglcCMb4N2vWLKh+c+S7UJ/qDUaPt+xJ/Vt35azL4ap5EmEX5K5yotYs1M3M9YXAxexxzPVFyHErfIvtfCcZZPSdNY1Xxff7aAVB98w1fUPeUzjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610711; c=relaxed/simple;
	bh=0qC34cH+uetK9hFY0GwPJRDWU8GDP3YxGpAkwzbpygY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0tWwuZzuBhFbd0kuD7AWYuFQkb1r8pgRjQ6JhVKqdgkSPA9m8zrs3QyWhkjsfc5LLWX9AWuuxW8I2SWr0qvIAJ5VhNTBstLTSL2u2ArC9EU4Sc9/iJzbURpAut+atnvdI7GMloePKhX6j3JiCTFmwUkg/aYflLuQlEu9c8d29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YOTkN2da; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YOTkN2da"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B02EC4CED2;
	Mon,  3 Feb 2025 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738610710;
	bh=0qC34cH+uetK9hFY0GwPJRDWU8GDP3YxGpAkwzbpygY=;
	h=From:To:Cc:Subject:Date:From;
	b=YOTkN2daJAqDFgIByGpH81Dbhpbtka1+WAYqYeAH+bP27YQjIfgMa2GjDeGTqSMLz
	 Mdp9dlP4dTwzvHR5brDt4XPG4FnVy3SM7ZuRQlA7qNxQ1UloaLLCRyRTVxJBnvwsfL
	 pfHjS/TMiL6sGvBkByXqYWseCEKEAwyjFObvFO2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH] perf/core: move all of the pmu devices into their own location
Date: Mon,  3 Feb 2025 20:25:05 +0100
Message-ID: <2025020304-chip-trench-4e56@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sysfs, for some reason, all pmu devices seem to show up in the "root"
of /sys/devices/ making for a confusing mess as these devices are not
really at the root of the system at all.

Create a fake root devices, "pmu_bus" and place them all under there if
they do not already have a parent device set, cleaning up sysfs to look
more sane.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Note, if you all don't like "pmu_bus" for the name, that's fine, please
let me know and I can rename it to something else, but it should be
something to get these objects out of the root sysfs directory.

 kernel/events/core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e011e9e..786537faed2c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11767,6 +11767,11 @@ static const struct attribute_group *pmu_dev_groups[] = {
 };
 
 static int pmu_bus_running;
+
+static struct device pmu_bus_root = {
+	.init_name	= "pmu_bus",
+};
+
 static struct bus_type pmu_bus = {
 	.name		= "event_source",
 	.dev_groups	= pmu_dev_groups,
@@ -11790,7 +11795,10 @@ static int pmu_dev_alloc(struct pmu *pmu)
 
 	dev_set_drvdata(pmu->dev, pmu);
 	pmu->dev->bus = &pmu_bus;
-	pmu->dev->parent = pmu->parent;
+	if (pmu->parent)
+		pmu->dev->parent = pmu->parent;
+	else
+		pmu->dev->parent = &pmu_bus_root;
 	pmu->dev->release = pmu_dev_release;
 
 	ret = dev_set_name(pmu->dev, "%s", pmu->name);
@@ -14232,9 +14240,17 @@ static int __init perf_event_sysfs_init(void)
 
 	mutex_lock(&pmus_lock);
 
-	ret = bus_register(&pmu_bus);
-	if (ret)
+	ret = device_register(&pmu_bus_root);
+	if (ret) {
+		put_device(&pmu_bus_root);
 		goto unlock;
+	}
+
+	ret = bus_register(&pmu_bus);
+	if (ret) {
+		device_unregister(&pmu_bus_root);
+		goto unlock;
+	}
 
 	list_for_each_entry(pmu, &pmus, entry) {
 		if (pmu->dev)
-- 
2.48.1

