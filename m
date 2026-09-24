Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7B419303
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269500; cv=none; b=XQ47j9OOsSzTLQhg9P6pyS+INqpO7FwQB5LkxhPziNy7EbKQS3SNxanNlY+2B7dAN8kp6upTopVydlOIfLQ/1muCfyGZfi1S0A8TOXmI9Xy/hV42kykj5p67HbxMZnwV843yJi5g75sToJzeN/6eJv+nZuU1kI65werNlfj3k7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269500; c=relaxed/simple;
	bh=R2PQewC67Nn1pInDYGIqgz6Apae9K6+NcvBSU0jDvas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tro6x0baiHa5H+yKyfEVFCb8OjmnX4aZD8Ou5ZeXUGNQb3djCUWVtn2sS28Ijmeg7VTFAwAuQN0yvm7XC22MfAo4xGBPlzkP5nc2R5FZoawiHwVr+4+rXEaAmq6c/zy7Hu6i9gxAa0zh0B0SpnSP/D/lApsVKihsGfdHE1/wTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqUAAZpw; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqUAAZpw"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-32850005b6bso3056101eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269498; x=1790874298; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihmdLIAt286E6JAM4/tetDqKb55HYHxbGw2OdyaQPKg=;
        b=bqUAAZpw4Btt1TmJkwdnYY3T57NkXd+88yge5imO9cS+t53A/qm5A3ArrKZt91o3SY
         z5+vhnTL6Srb8eWvXiKUgjYRJEWc7KUXwlkFK7AV18cpYx9m497DVPepJ38iQMGQulob
         cZBylDgGLrad2jBKj/6okMriMRuLrGGHIuysBr+eIiXPEmsJJzXfCuFKqwFqUrGQx73f
         2dNuk+Cir9J7y/cIW7oQucIB0KHxeU6vvq/j8JUs3973Ov7T0pOB/u6rvpylAVGjsaAj
         Ryk0IYbzGxHTQQMp6O2V48F56x+XsIFdwjRTbiyqOqgHhwNeZMBvifeYwq8dEZqqqyIX
         pCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269498; x=1790874298;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ihmdLIAt286E6JAM4/tetDqKb55HYHxbGw2OdyaQPKg=;
        b=IBzcFQk1aQ9QsPpE14RnIXT/0rZ0Vxzm5DRNM/N6aMk6WbKvuWLXGM4HF42psjWYVy
         fU313PhPY2MAN2gwzO2ldusUXerBqQ43lZBSCZmF7F1J9u6iQdb6Amwswe7tU6OLU3zo
         rn98zd7+Eysv0HLVudpjflmHD/ldXKm2SGlzuFDM0r1tJ8Jhu4AhgCMMfh+bJ3ghnyok
         QTduZFM5qg8zOxRn5RqXfwpwGpNV6GNE5FjAxgEBzBvxqIJtlq8tv/PWIoo39aKhpvD4
         uIiJsW7q0LhKE8K5+cckn1qHhwHHcbfE5WwKTRj//v/hpkLivyPB9DGw+0zUS2FVy1Bp
         aufQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqFEo+4MdOVf1gELW/aZENwDHUUEhSODAG7vChAsQpl+wtIYc10LpoMvx18UNCSU/0pWq2SAMZTxsvge8Q/QTa@vger.kernel.org
X-Gm-Message-State: AFuF++mUhKTSPoVcuBhhfIPQVfPkwS0f4nSE/G1RWGVRq7ZQT3rSx4Kw
	CjTb5axf+Jsa9Y/3s+xuzV5tOARbjowZX4GMYqMXgjnc+UuN5/9sIAT2c6Z2EX/36CiCA1PPdT7
	fQ8a6wBREOg==
X-Received: from dyvo5-n1.prod.google.com ([2002:a05:693c:41c5:10b0:33e:6278:a7ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4286:10b0:143:2968:564d
 with SMTP id a92af1059eb24-14503fde4dcmr2586802c88.27.1790269497169; Thu, 24
 Sep 2026 10:04:57 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:45 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-26-irogers@google.com>
Subject: [PATCH v2 25/26] perf vendor events intel: Fix skylakex umask encoding.
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Fix UMaskExt that was wrongly encoded when the UMask was 0.

Fixes: 748d5cf71948 ("perf vendor events intel: Fix uncore topics for skylakex")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/skylakex/uncore-interconnect.json   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
index eef801c68bd2..08311bdb2b20 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
@@ -13462,6 +13462,7 @@
         "EventName": "UNC_UPI_TxL_HDR_MATCH.DATA_HDR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x800",
         "Unit": "UPI"
     },
     {
@@ -13472,6 +13473,7 @@
         "EventName": "UNC_UPI_TxL_HDR_MATCH.DUAL_SLOT_HDR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x2000",
         "Unit": "UPI"
     },
     {
@@ -13482,6 +13484,7 @@
         "EventName": "UNC_UPI_TxL_HDR_MATCH.LOC",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x200",
         "Unit": "UPI"
     },
     {
@@ -13514,6 +13517,7 @@
         "EventName": "UNC_UPI_TxL_HDR_MATCH.NON_DATA_HDR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1000",
         "Unit": "UPI"
     },
     {
@@ -13524,6 +13528,7 @@
         "EventName": "UNC_UPI_TxL_HDR_MATCH.REM",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x400",
         "Unit": "UPI"
     },
     {
@@ -13567,6 +13572,7 @@
         "EventName": "UNC_UPI_TxL_HDR_MATCH.SGL_SLOT_HDR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x4000",
         "Unit": "UPI"
     },
     {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

