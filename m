Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C83F8EB3
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015499; cv=none; b=i4VM+Svqj4yrglSgsCHS2ncXuSlcY4UVlMYXFjCJcFJHtHfrtQTWQKxZN/g3LJLgc3EYbdA9P36Og8aFcMqAWUcA3n6KcZMT+6yTa3xZjokjUgcex5t5KwwDNhs1AQw3lwX4xfkYx/Yrr+d87gqD2+wOCSfnT0QUaluXXSCzDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015499; c=relaxed/simple;
	bh=JQDAylSrWLAHes5gxsm3uG5xwu2zN9a3IzjF5B5oWaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlElniB3EjvELQGGsdUZA+AkovyHQUhThumhNLCu3XZKUQmw1fXcOZjP8P1fcSc+qUv/v6aYiz3j6Bz/Rnqca7otCbPAG+8GANzLaoHtknv79H1Ig1wDEb5NY1DQBLzHoOFBV1Q8cWe96IhJYNX8Z9G+bnXWXsfLJYeskC5CU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aznoaGQW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aznoaGQW"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so46392315e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015496; x=1781620296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tCZA64ZljHdNthuUJI8G+lKrRp8mWLWbXdPVNi3pLg=;
        b=aznoaGQW4Cn8IoXnyNL9FK9/L8Wr10nMzvLXRtmkMWku79n8a3y46U0jKYydLSDwAd
         fOLHT57qFTO4OjImF/7hzDVg+UJL5hI5kgiaLeTcK2n8uzu5af0MEMDFvSAqyuz/mHAu
         QngP5okINBGTcN7Hy9zec0cAVMcRnB/4ddzHeJViq/9suQ8DSvLgM60EAaBeGkkcVKc9
         7PC5POdRRYUziJRxqxz+nMAstMCxOCrwi4wv+JXP01TBClNt66XvYMsjqHrgMLlCJoBv
         f2TtXayxu4ZhfaxMK0B1zAb8seXGVvLT4DKXWhTnn4b0eceYKeb5W8vnfhhCWVgAiZ+G
         8HGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015496; x=1781620296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4tCZA64ZljHdNthuUJI8G+lKrRp8mWLWbXdPVNi3pLg=;
        b=LfzEdLIgJBX0fpemFVZHCaaxejSWoOqjawrY1G1H0sGZv/AT9L6vMgU84Y0BWMTSJV
         nXktEQZxqgshL4KUeMU7VuHLAw0vlVTvf6Oc3hvCcrkkLUf0LD6CqHtcXos13zBwQCk1
         rew+TEX/dV1cYQQdcyQZuZ4g7qVubc5YfhJrW9/hvhs+TQP43FPbiqBgXZPkQtBhSqJe
         vAI2leRxS59MZyekX3Fm7vY+V9lQDystlQAUaFBcDzty0iWQLjHvzzv3f5g8kP5LG8sU
         ICWpYTunmG7Jaz4a+I+bYx0xJFlOUh/VzpJxpiNxbfsUK1hBs0JIpvytRGkH8DGPzlOR
         naSw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZmJDeuM4YC/NhIee7gc6mi8+drMWQtY7JbEBdirZg66B+Oya0BynfzHCRyh73yQQLAdfHXD+IjZs/prklbvMe@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXg/defsckCTx2otBbnzR9fSUOaukLWQ4ubmEDv5bzHEY7vUj
	GHUrNFPASD8KlCstiFlhMO+ct7TjfaHbA0KtZi+FKkBVTcvWQex9ti1BDhYOvuNcnkE=
X-Gm-Gg: Acq92OEacMF21HdLdhsRgk+m1it/hTE5GcFji0z9rwjbSciFhdrd5/WhmbsRA2wEBth
	CoC1IAwARETaOCNpguPFo0cM0f5nclaQfJDrRpanFOwYl0+LA7rNFVeBfE8PDXfboFBxXtViKHo
	SLDV3dXLEQQF/ncBX0g4CAEpCWIUTXEFRIxhgGpwFJd+V//1LgXc9aTxNkbjzMIM0XTq/SyTJQ/
	Bo7oiJmp0u6Rrk3hPP6ke+GKXjOrEkMkv/v5iABEN535QtKckWZevDkdlM8SWAUNEUBvjbHoprM
	5kip1+8KvohZgbd5vJTCLglst/ZnNzFF7fMnlDMTSu1sWK5QOSGMQug3VmWJMiGbNS8UF8HuvGP
	CNjasIjCVik+QqxRZDWiM/1RJMe/GdlzThAXgrD/g9IgYVKPl647ExAtoDmKg/J90MKG6XpwDKZ
	y3rktZYrN59DpGSdzlHXr0qrojMJ7j2kYP0UK/t1tT+q0=
X-Received: by 2002:a05:600d:8444:20b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-490c6c20071mr173501595e9.3.1781015496173;
        Tue, 09 Jun 2026 07:31:36 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:06 +0100
Subject: [PATCH v4 13/19] perf test cs-etm: Reduce snapshot size
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-13-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The default buffer size for root is 4MB which is very slow to decode. We
only need a few KB to verify that the dd process is hit so reduce the
size to 128KB.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 8ed2c934c87d..da2f599393e2 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -156,7 +156,7 @@ arm_cs_etm_system_wide_test() {
 
 arm_cs_etm_snapshot_test() {
 	echo "Recording trace with snapshot mode"
-	perf record -o ${perfdata} -e cs_etm// -S \
+	perf record -o ${perfdata} -e cs_etm// -S -m,128K \
 		-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
 	PERFPID=$!
 

-- 
2.34.1

