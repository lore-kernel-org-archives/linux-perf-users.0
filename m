Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58316D9C1
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643200; cv=none; b=g4lvn7J38yBU6lrm8zJ5t0UJ2krQ2Gm8KuKRjTPfCeOhWchJU/W4TlNAgk9TCg5ZzaAZpgFEuGGLXA6WOVAV326kFLqQGA4vynBBYVWA0kDAKRxCArEdS5TPrNeZM7Ksz6HnXQ8qV1UC+ix/yCDnTdVRlDxop5K/oQxvIfasP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643200; c=relaxed/simple;
	bh=NJv4Ip/0MGeUDqPRCBtTePKyAhBC1HwlgSVGeLozqqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHqUMKjmywGtgUcTmZcrQkhC+n5d7Nkr7nS9fXoQoWxxrQ/rvMjbhyFGlZzJsWVZy5W+Hrxo/OtsOP1rkFuUoEnDGQIv1Iz1U5S8ylyZztpk0pMawzQp4Tp4P20ANTsnGJYaOTi/IbsMedYLSYyP8L/s80F0bKpy8SBJ7ocGpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=crRQF7Ct; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crRQF7Ct"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so28663435e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643197; x=1722247997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CvKA9Oo8oUAGLDUMUBH2byBqwwnuDLfYbLv1IHZER0=;
        b=crRQF7CtbV82vfsxE3bSUfs20cH3fmGVf295mQ1iNhPA426ELPz18fSpu1HgUNpMTx
         4hZGUjHf+UAaGpMJDnmtGxSRuCDDkygyn8EeuTuPC8N94qkS2I6fHbp0HQ3IgclpOoEQ
         RotcYcaYTvqcwsnPZCrWLWk1gxSa+OGSo/lKreDqZmRS64kKaaxIPvN5a+Jb2MCVPRyW
         LtKPfTBlWI9UZk1ALE8FXKMpooT9y+qSQJSclB7MH+KH3LPO8pPKKwoCVxb8mlu+Bj+S
         idmqzf3D5Me4l1MNzwwruTZPSgzVN1QGNXpgH4deNeWoIm+fZN3RCyGmiUd+rqO6/y1V
         Dhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643197; x=1722247997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CvKA9Oo8oUAGLDUMUBH2byBqwwnuDLfYbLv1IHZER0=;
        b=o14b/24rA/k6ihHjy/iOcyck6lQm3UtU9mfQMeIBGtGyj+ASAi+nCdr0YqXdSbapRV
         csoiJx4MuR0+FkJUPgT3VHPWVVfSJlnnFKxJWhBLI0gkB6B47KAFu8mrEXuSfjEYZaUl
         bvidNju98HCDbGbBtlAKhA1lUldJP2n0PA55uHnSzMr1ZRouTh9J6kEY2n4K8ir+Lg8q
         2L/TrtUPyteHSNk/+cLq2VzNBF2SQYIcVZN1P5fTZrcuNRSDJa4vzEhMSBQ1Rauo1ZvG
         vJKVxgA0rB3xtjMow5oRDLmuEz28lh/CKYyYquB7fm8W18VrZ/jmQffvPOysTZEXLy/B
         IXqA==
X-Forwarded-Encrypted: i=1; AJvYcCV+3N4M5XEJvrg2rMo/R81F6e6Q/rdFgsG33ReTpgyFvIVcRtr7mlY5y+Ljv5LloQx7YKYHC38yuUBDnprPbobkjLu9rmhMdCgsdpgcaY8mnA==
X-Gm-Message-State: AOJu0YzuqjamXBrKLWGaprpzNemt0R5K10+kBUNITkDOYcW0kF1uvxcJ
	iEEis/q3MagRkHteEnC0MTAznfoS+X7uaB6wpXBihyoo9bLZm4m4B7HyI8IjgHaAx7airwTQrNo
	/PW4=
X-Google-Smtp-Source: AGHT+IF7qS/l5dBLpir4Vw8LPazyz0x8s3+xWgLLeI6+jb9MqA3mHfayIPDgC0IjLcyLxDckxJt5aw==
X-Received: by 2002:a05:600c:35d4:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-427dc569cb0mr43200815e9.26.1721643197578;
        Mon, 22 Jul 2024 03:13:17 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 10/17] coresight: Clarify comments around the PID of the sink owner
Date: Mon, 22 Jul 2024 11:11:52 +0100
Message-Id: <20240722101202.26915-11-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

"Process being monitored" and "pid of the process to monitor" imply that
this would be the same PID if there were two sessions targeting the same
process. But this is actually the PID of the process that did the Perf
event open call, rather than the target of the session. So update the
comments to make this clearer.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
 drivers/hwtracing/coresight/coresight-tmc.h     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e75428fa1592..8962fc27d04f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -36,7 +36,8 @@ struct etr_buf_hw {
  * etr_perf_buffer - Perf buffer used for ETR
  * @drvdata		- The ETR drvdaga this buffer has been allocated for.
  * @etr_buf		- Actual buffer used by the ETR
- * @pid			- The PID this etr_perf_buffer belongs to.
+ * @pid			- The PID of the session owner that etr_perf_buffer
+ *			  belongs to.
  * @snaphost		- Perf session mode
  * @nr_pages		- Number of pages in the ring buffer.
  * @pages		- Array of Pages in the ring buffer.
@@ -1662,7 +1663,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		goto unlock_out;
 	}
 
-	/* Get a handle on the pid of the process to monitor */
+	/* Get a handle on the pid of the session owner */
 	pid = etr_perf->pid;
 
 	/* Do not proceed if this device is associated with another session */
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index c77763b49de0..2671926be62a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -171,8 +171,9 @@ struct etr_buf {
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
  * @spinlock:	only one at a time pls.
- * @pid:	Process ID of the process being monitored by the session
- *		that is using this component.
+ * @pid:	Process ID of the process that owns the session that is using
+ *		this component. For example this would be the pid of the Perf
+ *		process.
  * @buf:	Snapshot of the trace data for ETF/ETB.
  * @etr_buf:	details of buffer used in TMC-ETR
  * @len:	size of the available trace for ETF/ETB.
-- 
2.34.1

