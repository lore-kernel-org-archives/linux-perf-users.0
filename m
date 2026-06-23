Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C053A9871
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192945; cv=none; b=lVeWo2N9FH7jMkZls7EO6Hs17YIkVmruWvQqDg0SCEqdcUs6NUHO7qD3yrDPjqj2nuncemU+k189qV4bT6kZ6CoEzGmVEECkbpQLrsFLizYSGNtFrL9h9rBmotF/BYvLOVOXiP69oi74cmhTukDvLGVdErvPDc7Y8ZE2NREWtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192945; c=relaxed/simple;
	bh=JaYSpidZHqU9Z7YC0Y29SheIBHkDYaE6irN6Em4wMfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OKhZyQzFgherV+pIRKYjL/ECVrBW+bXxQOQTP+7g6JxwOoIotNu2idfl9iwTzDSM10wZz5P7Eb0hP4kJphmE6tUI139fhqBfOTIoxEm5k2/e2m+meeEJ17FDZa7es2xLG5WHQ18vWJCQjdBFG4RrbSsCnmmsOs0QSHcaXBCSheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKrc4ygL; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKrc4ygL"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30c17f62afdso802130eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192943; x=1782797743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mi1roz36foAxC2X++lAcqaNQ+0VJrL0uVZRLqVDLNtg=;
        b=qKrc4ygLCNqGpal3ZxAbztSaxKkH27QtXZanFxP+ZDL1jeL+4YZCkaFxS4H57rbTu9
         iH4xzIr71tYRaLaJ3OvP/7vFBykBOwilHr/HolE57bENHbeSKj8T0S/iLA4LofdYhBvJ
         YXsBoGx0qMslYtKoEp5Dm6FW8gxCWxWdPOSQTV9H00GxMAfD27e2HI4lM90gzo5GR1dB
         PFb7iOMDWOjTHu7lwOj3TMSm9XTxW4M4vCdSXotUiYzwqLprL3DqMxdfEG+zRCdJHuiW
         o318YYBNfNm5T5NxFs/wrKy1ziW9A5Im6MLpXxhujyUBdkGBo+WiHeMWA5aI6q2S4RTZ
         6WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192943; x=1782797743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mi1roz36foAxC2X++lAcqaNQ+0VJrL0uVZRLqVDLNtg=;
        b=gKfuzxBHm+QgNjfy5aE+mckq7HfgE2NI/42Twv1uohu9uVcfObUpN7CcvBAAa5C/03
         k8ECpJT4zBIYQlH7br4EIJ58eE2MxjOl5/rQmHUBoEozb7W2OzluEYIqdqsQrbezVydo
         KWxXT1b4mvTETMKvDiQZ61XWlFtHK+wAQXYGVvrXeAs5yBzpUaT5CXTN8wFaAJ9O5jUk
         qgBwxhKU83QpVxSZvpXR2k2DPBn5iW/wnSv74VDHhoGz83SFOhBieVxbu4x/HoPCNcnl
         UsE/7T/prbOrtS6an56dSfy8VHUejFwXGKDO+KQjWLE3o6nHCPkxgyHlgDjq7cd+J/Rc
         ITDg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+CpDtJ3e+TKMuC2nhl+ZWYvbiJxGAXZTUs5bf3yb8mWwIlmhfTy3+sNAWoiYpeL17fGNUiwlY3x2OkcOByTRX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XdgWLnARl1wHHuDVpDQWTGRvg6ctIpn4Bs/myWv/zIKZoLbQ
	UuQ9VTSd9KYnIyw877hYhO3RykljS4TC/HcVMnp77ot9TM82FvcZ5nQM71ZQib+cOOpStf944iR
	IVE7Wgrcgvg==
X-Received: from dycmb11-n1.prod.google.com ([2002:a05:693c:20cb:10b0:30c:d6c:eb66])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3e0b:b0:30a:e52f:9b99
 with SMTP id 5a478bee46e88-30c553f5be2mr1758755eec.0.1782192942756; Mon, 22
 Jun 2026 22:35:42 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:08 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-7-irogers@google.com>
Subject: [PATCH v1 06/13] perf data: Fix directory file descriptor leak in perf_data__switch
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a file descriptor leak in perf_data__switch() when running in
directory mode. By substituting perf_data__close() for
perf_data_file__close(), any thread-local directory files are properly
closed during file rotation.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 040f9915e99e ("perf data: Add perf_data_file__switch() helper")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 33fd1b82019e..32d4d908ad38 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -472,8 +472,7 @@ int perf_data__switch(struct perf_data *data,
 		pr_warning("Failed to rename %s to %s\n", data->path, *new_filepath);
 
 	if (!at_exit) {
-		perf_data_file__close(&data->file);
-		data->open = false;
+		perf_data__close(data);
 		ret = perf_data__open(data);
 		if (ret < 0)
 			goto out;
-- 
2.55.0.rc0.786.g65d90a0328-goog

