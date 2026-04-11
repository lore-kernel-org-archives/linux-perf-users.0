Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B412EA468
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890646; cv=none; b=EFiJJZI/GxunKw01271jInGXmW6S3LFV3rYLWAKMZUDLAwH6AwgUQUuuCGKKBDXfPmidiQq7PmPG6hHgfWgCUol7w1XYokKIcN9Ys8K9BPbrA5j4wXkqGOVT72xRzkF17dBbOiKg42b+yfwPrRI776gisv/h4G0XEtfZ00eIkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890646; c=relaxed/simple;
	bh=n2JtyMg3dnFRI+CN9oMKk3aLsRiKCNqRLI02Htuc8WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HS2DH/k4pc7g0Szzf9HqkDLilQYE7x8ndQcR1W4N0LkNcj+3iBbJxGhPi1xidIJM0CILlHEcpRE1V1keuEvPmXgxnV3LZObg0ubBkSg/F6Hw99q3FK23KX8xSIm4Ujoob+Pf5rvl4yfjlN8j90X13lxoLWOvORQfv+sXog6Ihfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uAC483c1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAC483c1"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso5959327a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890645; x=1776495445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=uAC483c18aCHyYNdJ0n+xQSas+PjD6q4+p90VxBAB59VwKguV0XapxcJ4GDBHsQawI
         kwpAxza0OW2SQJ7dF2nTBm2oLRkN0Eqt1WGBCzFPHCy8Rayk78Z12a/9JLOpS3ESik36
         CAf3RBpwD5YC8Vh4IcaxznxxUeqTR8l9jYhbJH+qSFpXldqAMBfKfio/L4TNMm8NeYkB
         Kx+Q7yLnuD4H+FCJnfg+sf84vDGIaur99/xrOWZsSCQNFlY4q+Auc+rwMFo5dtn66y+T
         lgq44lphIG+ebwAD6FYNlYtONSWAVkEPnBYzAp67QkbsrjIPWoMyZ2AmidDHEius8rwb
         5dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890645; x=1776495445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=SiVGmRUig4xjjC+wzuvgQZK0FeuAhC8IwkM2HNlKWXv7W2b8rTkVRGBvlX1WbJh/Zs
         AFlg3R9JYAoQvX3pX3gs1TFuElruLk6B495TTcYR7wVqaNMnjmJvhn2dLfE+1JA9f3cU
         TKpH+wJ2c5/WOra4nXo3ELqLvcwW4D4ehwWTQcAq/CgCJZlQLfNjwXgwzlIsV4GwtAEf
         iSo5846O9cItedPb7qselLk9pqQ28jPNGlsl7q5bWxQgQt0LiwtHfuNhGeUxTnelwQGO
         0CxuR7FNMm71z4yzYa4xRdd6avq6ZZenV4z/TnwVfK/MG5txn9I21kEEhCny6uUBqUlo
         LWPw==
X-Forwarded-Encrypted: i=1; AJvYcCWBpHz95U9QoH6rhzBWCVcvb9GtQz3H7iyILZ1symARWiApN1kQyM6q7IJyAAake77emMs4Up4VbcNh0BtyDaz+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9VmdgJX6kOHGJgwwwnrlVcrkw+Psnjv5DW5paagTwKKwdP5bz
	lOcdnjOKNyoHZSp9wO5JuzjCVd81vzfTwTbF9olZuXrP2931MWSAlGKzno6zzU54aJ/rTDhuNZd
	KjX525vHOKA==
X-Received: from pjbsc18.prod.google.com ([2002:a17:90b:5112:b0:35d:ab01:e224])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b46:b0:35d:943e:3c2c
 with SMTP id 98e67ed59e1d1-35e427a4ea4mr6612084a91.5.1775890644745; Fri, 10
 Apr 2026 23:57:24 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:56:50 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-2-irogers@google.com>
Subject: [PATCH v8 01/29] perf sample: Fix documentation typo
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

s/PEF/PERF/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sample.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index ca0c407c4423..e556c9b656ea 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -126,7 +126,7 @@ struct perf_sample {
 	u64 time;
 	/** @addr: The sample event PERF_SAMPLE_ADDR value. */
 	u64 addr;
-	/** @id: The sample event PERF_SAMPLE_ID or PEF_SAMPLE_IDENTIFIER value. */
+	/** @id: The sample event PERF_SAMPLE_ID or PERF_SAMPLE_IDENTIFIER value. */
 	u64 id;
 	/** @stream_id: The sample event PERF_SAMPLE_STREAM_ID value. */
 	u64 stream_id;
-- 
2.53.0.1213.gd9a14994de-goog

