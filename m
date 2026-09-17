Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4D539790
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663189; cv=none; b=n5Y2cLAsu+2b3q9Qtjih+gVgtAzh5XiCm9rQXc5gVbeNho3cADlxpSeq2Pn1gR5EzZ8hCN1/EaYmQvdhAfuSzZ9rhbdqnyXRA6OqVTtGeGl9uMedXWRrcGDkxEDSZQMPQsjp1P/Cw5Q0/Pv1oSZ3kUhzT7kjt/iJVp8TL3vmqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663189; c=relaxed/simple;
	bh=P+avWqg0YJ5z30ktLMdV7Tr+I207Djb9tMMIgwKH6dY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ralR93wPTwSL7VhI+xav4K9lgVF8P49MtTOyoM0YP4BHC2aPbA8kJ1Mz6rVGdD30Q9cgkkK55iFCxx5AxNfX8grWx69nuXXpv4aNpL7XfoFGPVXFnFE0r9uW98al3xT5lvQhoKKtILuzZWm2ftXtqa64rKh04Aa2qIWdme2mgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1Y6EHL4; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1Y6EHL4"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso907337a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789663186; x=1790267986; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxRrlx2WvAT37qZTLQX7yxCGnnR8nCXcvNsM0kQ33yc=;
        b=S1Y6EHL4SoldnJnRwCfPpzEWAdufX54VH6bPFfnp7TB4Hs6iyw3mdtANcsdFHsNChI
         holKKEs6uBcQEcW3CdNXemzYme+8tdAH3kwEfLhMDAVWm8g015doSvzCDJ2dYHYRC1U1
         ecr4DVmbJaAYJdTyoz+MxyrIXjQodPkch1209XmJfnnu6Ntm6cigvIPIfyqX88SMBujG
         nKYZf8fbt7eirb+nYOAkr/A69wsR23NQDDWzN4vEQ4Qj8VWArmoXMj3JCFFj4UkmpGI5
         +MYAhFlGq8bT+mFjrEPyCiaL+Xp9e0RIGu8/Rirpa1TM2xk2xqFJ4YIxTsy0H7B7WZ8X
         Tcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663186; x=1790267986;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SxRrlx2WvAT37qZTLQX7yxCGnnR8nCXcvNsM0kQ33yc=;
        b=XQ0c2MH12emT7KmitiPf7VP4SPfuOvAFPWHHHZiWstUaxPWNkw6SowsaFqsiKae8R0
         45A7Z93dyhXwzYcAcf29wLk1JiCoXuN6Qz5vbMlvP38di/mCewo9sxMh2PBGEJmdTGZi
         HrffwCQ4p3mJ5LKEzRIXFB9ih8ptz4eou0umGZs9IrAb06u1fdREket+yRi8/3cReiLb
         MCZ9zEZMpHXkwj2y64n+85bI2NUcIXId053gcml9xCcys5Zv9ndIS/jYo2ijwcPqc+6x
         QZMmS+bn3kDTCD4PVFGLl1nb8+qMcE9CjwyJMYvsBYjLb7On4MnzS84W2xNcPu6omwmX
         F2kA==
X-Forwarded-Encrypted: i=1; AKwUvBwiWbATg/TxGEpB1dV2lZ2iNiVDJJCuWeIuEZ8F9fN9vZuRxLwWxZGBLvIPxC+7b1wZMQjXP0pGtOLsvgQ9TjWR@vger.kernel.org
X-Gm-Message-State: AFuF++l90tQsSPEGx6CjbcLowazkksJf0cOiNAr73k17kyd2mLRTr3Ab
	1PLe7YrJwjnEfZywHY54XkaaKNODNCRy2o7Z2j3gu069Itkx2dcC8iZrau1lPXycCDyJbAZkYuG
	mwd8xLHornA==
X-Received: from dlbsn1.prod.google.com ([2002:a05:7022:b901:b0:143:88a3:3a89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f97:b0:3dd:85a8:cad3
 with SMTP id adf61e73a8af0-3dd85a8d0a2mr1574846637.42.1789663186419; Thu, 17
 Sep 2026 09:39:46 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:38:59 -0700
In-Reply-To: <cover.1789662556.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <ad0c14591fba9273f8078a88d1231c0683fd1349.1789662556.git.irogers@google.com>
Subject: [PATCH v2 11/14] perf test trace_summary: Improve error diagnostics
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When pattern matching fails in test_perf_trace(), print the command
that failed along with the actual match count, the matching lines
found, and the first 15 lines of output to aid debugging.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_summary.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index b80dea77cec6..f975176247b5 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -28,10 +28,14 @@ test_perf_trace() {
 
     count=$(grep -E -c -m 3 "${search}" ${OUTPUT})
     if [ "${count}" != "3" ]; then
-	echo "Error: cannot find enough pattern ${search} in the output"
-	cat ${OUTPUT}
-	rm -f ${OUTPUT}
-	exit 1
+        echo "Error: cannot find enough pattern ${search} (count=${count}) in output of:"
+        echo "Error:   perf trace ${args} -- ${workload}"
+        echo "Error: matched lines:"
+        grep -E "${search}" ${OUTPUT} || echo "none"
+        echo "Error: first 15 lines of output:"
+        head -n 15 ${OUTPUT}
+        rm -f ${OUTPUT}
+        exit 1
     fi
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

