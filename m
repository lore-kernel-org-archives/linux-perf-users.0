Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772236A36A
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481860; cv=none; b=LRbPuQpfM+iLdZpV422TUMm8qKy0YvZKQDfPJHNVoAo5H63t85utQG4hLgbhGX9gBaxh+tny5QuOqbQl191XMiI+GsgNPBhBFxM/g6jWrfMU7FJVNyzQhVwFQtmDTETQrveBMfeluU2YXAnXetiTvNo1QrGKKWEftqSJrXqQtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481860; c=relaxed/simple;
	bh=6RkEL4S8aCNR1yq1ytIaKt2GAbArNadH93U51mYQEOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pzG5iW4qPoyg0sJSh1H8DGya3UCId4q953WUwy8DMThVmAVRYvKEugXsbiy4daICslbUfaAahsq1Y4SYb6/Ph9ITY6YoVl79uJeksLcB6369B3bRmSaaMBuEjB7I8TlRsQ629NI+DCr639WQ+rr2OJEI/gB0mNwUX7C8ZHdnEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fKL6dXBe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKL6dXBe"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b3637b90so14802005e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481854; x=1781086654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRJuOllU43noyyBid/foFoLzbBafPMlwyDVK+1tfH00=;
        b=fKL6dXBeb0QOPV84Xr4/c/qzcTEMV7MGGE2wWkZM/PeIHTfqOI0k+TG/00cach6DTK
         pvIU2YNTePCbNe/iFCRiQw7oNOnvjgqB0uBpYWt1AOpxaPRs+db/Meg/att3FFiL7Dhn
         LUsHHXzC70N00HbLVDnsoxpb5TDgPR2lFMmA0QTzBvau4+Aq8P3R+IBHLPUkXTWWEIsE
         2SdWvecbPySa77O94Tky0qtDeLs7XMLRIAzEh3AyVBkq8myilM3kbuBXqjT9g7fotAg3
         LTEmDMGVfRe3EFLl2QmblgwakKHhPR7kC8b7cBe4saYKKv3Yj83aiW1lfRloNl8p/wUI
         C9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481854; x=1781086654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mRJuOllU43noyyBid/foFoLzbBafPMlwyDVK+1tfH00=;
        b=Yxo04jDWoXtDozPhmFzg4W4lwJRs6bIE98FD2G2JlRZUYvm02Sylx9x1ZG/zzuXGwC
         gls17fa0UW+d7hkPIeuNHPKMRaAXDIspUQXefBNzP8euh8ecie2uLfG7W+7bi7R+a3LK
         SoMK3VvU58ixyDG3HhJyaJ/DYkUDl865o4kBFP6L4YUGXv5w3mU2n2tprdn6BqILbfr9
         eJjiIHcWHRCqFzJZG528W2LSsNvrCpptm5f0FaaqcfyMvsi3NH95s1fe/5vndFrNZapk
         q05XLVj9otSU4EZbg1NnkktNAvYUtH+bdhPXC7jKLdQOpmxvC5fRq2WenMDS586DrISt
         /ZuA==
X-Forwarded-Encrypted: i=1; AFNElJ9Cp+OeVRq7JxJWqS8oPR3SmW2brlA805+Rh0kO8eMLsGskjuWh+Jq6gKp3Zf3NPSv3hWgoAchVDzMXwmQJEpHM@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZLghsWijxJInlOBk7hOfCLe5+qk8Bw8dC+zuUf+T22pb6kEg
	GzDT52jGQhM6B4rVMbkRB9DIe+08VbaEFvPKLuJSMJq7wvGbSNQxPWoYTTCQgChjv8k=
X-Gm-Gg: Acq92OGY+ALkFJUnbW1AEbyYcdmaBTIYrTGG3PCi3Yhtv6QjOW3aVT9LsgaW8FXXrkR
	ZgAel3CRjPlQixY8ks+UCIm8jVk82z3HXmTqL+AsnmOdDJJa4/9L7IgrkU9CTvYgvp4fy4KYmqW
	0S91ycX5zvOBTjBlgJt3FBlddmJy6SLqVllffPgHcM8Bf2/0anpMdBZuCN05EozEp0KLwmYJdfe
	s4GcskcN3Hzs81UKTyuVpkip5/SFbEYM4g5X25GX1eG1/k/8u92iFnWUwwEFm8iG2MUrqzy7tQe
	NinHL1pxMiWBsKUtvSBBDPd2BzrYR26+BoYk0ltxGKKUxZv9DA2/3sYq4j+J3tEldRXYLTj+Ee6
	gRwUYlMMO1R9pf5Ac7EYhBsM3qIMaU37I7yJBlO68MdhXBfN8dYt9Xj6lkzbBipJhC1O4YJL2lJ
	q4Ur8pc+fhgRDQSCjJcBDT5q7Ns9R7CzE2E8weExcqydU=
X-Received: by 2002:a05:600c:1392:b0:490:a964:14f8 with SMTP id 5b1f17b1804b1-490b5e94f3cmr42451065e9.8.1780481853968;
        Wed, 03 Jun 2026 03:17:33 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:33 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:15 +0100
Subject: [PATCH v3 11/19] perf test cs-etm: Remove duplicate branch tests
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-11-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
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

We already test branch output in perf script mode, but then retest it in
Perf report mode. This is more of a test of Perf itself than Coresight
because Perf uses the same samples to generate both outputs. Also we're
already testing instruction output in Perf report mode.

Remove this test for a speedup. On the systemwide test also remove the
Perf report test because systemwide mode records a lot more data so
running multiple tests on it has a big runtime impact.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index bbf89e944e7b..39553702c1f3 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -52,17 +52,6 @@ perf_script_branch_samples() {
 		grep -E " +$1 +[0-9]+ .* +branches:(.*:)? +" > /dev/null 2>&1
 }
 
-perf_report_branch_samples() {
-	echo "Looking at perf.data file for reporting branch samples:"
-
-	# Below is an example of the branch samples reporting:
-	#   73.04%    73.04%  touch    libc-2.27.so      [.] _dl_addr
-	#    7.71%     7.71%  touch    libc-2.27.so      [.] getenv
-	#    2.59%     2.59%  touch    ld-2.27.so        [.] strcmp
-	perf report --stdio -i ${perfdata} 2>&1 | \
-		grep -E " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
-}
-
 perf_report_instruction_samples() {
 	echo "Looking at perf.data file for instruction samples:"
 
@@ -123,7 +112,6 @@ arm_cs_iterate_devices() {
 
 			record_touch_file $device_name $2 &&
 			perf_script_branch_samples touch &&
-			perf_report_branch_samples touch &&
 			perf_report_instruction_samples touch
 
 			err=$?
@@ -154,9 +142,7 @@ arm_cs_etm_system_wide_test() {
 
 	# System-wide mode should include perf samples so test for that
 	# instead of ls
-	perf_script_branch_samples perf &&
-	perf_report_branch_samples perf &&
-	perf_report_instruction_samples perf
+	perf_script_branch_samples perf
 
 	err=$?
 	arm_cs_report "CoreSight system wide testing" $err
@@ -179,7 +165,6 @@ arm_cs_etm_snapshot_test() {
 	wait $PERFPID
 
 	perf_script_branch_samples dd &&
-	perf_report_branch_samples dd &&
 	perf_report_instruction_samples dd
 
 	err=$?
@@ -191,7 +176,6 @@ arm_cs_etm_basic_test() {
 	perf record -o ${perfdata} "$@" -m,8M -- ls > /dev/null 2>&1
 
 	perf_script_branch_samples ls &&
-	perf_report_branch_samples ls &&
 	perf_report_instruction_samples ls
 
 	err=$?

-- 
2.34.1

