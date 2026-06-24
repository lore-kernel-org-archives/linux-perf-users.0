Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F331A572
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278169; cv=none; b=UgBTQP1kVH5aVZt2FDcKprofO2CE695JhdX+kiuQkk/01dIgqVn6vngMxMj6eMdmAa44+U/RsZxtINxyk8C+UlFybAsjKujmcv3mtR4ySQf/sIU8ors/KAp+P/yBeeR2UJvaVRttLq2YAE9yflHsNc0JuceTGI6GeyEKZEG73/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278169; c=relaxed/simple;
	bh=cL/dfi6CoH3v3+AFk/Jb+xFw+2XYxAViCqupwMQLJ/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4CtjUQss6BQIBGkkJHgr9xurcTXuwW57kLQSNlhAqe9w4c14r7+oiRz/x83zpU4ANyx+Gb6gkGt4K4DOn6PsBCDWHy04OMwTvPFScpeZGo6RcZ/PEY3C7pK2ej1C87+My9EaR4Z0DzJPUQVOodJp6ajYfgtlAJ1Djzm4oLBShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmYrDrG9; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmYrDrG9"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-139b62317d0so2508950c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278167; x=1782882967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukKLKgKMn5XXD3rBChspB6wx1KlIrbqmyT4Q8AlDVdU=;
        b=AmYrDrG9R+r+Dz4vom0Z3JSpM3+/s3CeSOVB4RWkRsHOf4BpcUoKx502AeVRcJVpAa
         UOLfLnyhukymuBolY6kmOGhKFx/+gpTz9gMDwFbHktU2tUimDmj3GHKiU2Be5pZIUoXR
         veMk08edyZ4bZSVdOGIB2ad+q/aVfnVhvN1YoQCfTQQGUWKRK92vCVwEU4dE/sZiYUk1
         M686RSNjOBS7u2olE3Rm2Sxj1Pwb1yFJHXlssPyD4sPFjeuxP4BI3d6S7241YFV/8VEX
         EOg+E0Yd6tPX+0zKpb1rEfXdi/bCEbTrpsl/JU7MPWNO0S3OD27g8Ca0h3ET5urjG4Dd
         gVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278167; x=1782882967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukKLKgKMn5XXD3rBChspB6wx1KlIrbqmyT4Q8AlDVdU=;
        b=cSvF+YMYY1sc/RjPdgqElgHCixS7gLsCXRRktmqipafn6KozugnZXMbqRsForMs/Jw
         Tw4DNxwe0JRUzXYOtOBsYTx9uTZLwPN+dOD59uLoThx0dz+LqyEfmXbW6f2X8O70K//l
         bE67DlxVpTsPz92cn0+oCoUTB1veJ8ZVl8hdulHv9uU6fyxBPtQ6EMtHHsANJKDrgTZS
         aY6MaK7zZoVMlVwsaiPFfRoh34BhZvKAoKN4SaRjkt4O15Yqh34tewWiNsTXee1a24Bk
         GTbjSTxFTvAFWbSZtC4ZWKr0f4+/s+776sig2HLaaVGsPnHe5e6FsLWUkqfccIy03LCX
         46PQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EKaVqkPsFPg2J7o3PdcZU1zP4Riq0+Za/pEBzvV7qnRPerp69/vnn5klU9siTrDx+GDLsP0xd1VzrUFCZ40R0@vger.kernel.org
X-Gm-Message-State: AOJu0YzXnjyiqHOLjpl9/5ii+CTInSTBAd93buY3nXLVvCRRZJw4Hm5J
	9mYggHFx3Rto47D2wtqlydLz7QNF4AJfXh4Km7kddoLAudtQ9OqxCj7oDfPOTx2LP8e2hxP+/Db
	UUDTRj5Zavg==
X-Received: from dldyr20-n2.prod.google.com ([2002:a05:701b:4514:20b0:138:23f0:1ce5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:222a:b0:138:33cc:d88b
 with SMTP id a92af1059eb24-139d0c81d73mr1708018c88.20.1782278167027; Tue, 23
 Jun 2026 22:16:07 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:29 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-13-irogers@google.com>
Subject: [PATCH v2 11/16] perf python: Zero initialize perf_data in pyrf_data__init
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace path clearing with memset so the entire struct is zeroed,
preventing uninitialized fields from causing errors later.

Fixes: 4cd0142f7dec ("perf python: Add wrapper for perf_data file abstraction")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 657b054f5e51..71be130b38c5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3,6 +3,7 @@
 #include <Python.h>
 
 #include <inttypes.h>
+#include <string.h>
 
 #include <linux/err.h>
 #include <poll.h>
@@ -3621,7 +3622,7 @@ static int pyrf_data__init(struct pyrf_data *pdata, PyObject *args, PyObject *kw
 	if (pdata->data.open)
 		perf_data__close(&pdata->data);
 	free((char *)pdata->data.path);
-	pdata->data.path = NULL;
+	memset(&pdata->data, 0, sizeof(pdata->data));
 
 	if (fd != -1) {
 		struct stat st;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

