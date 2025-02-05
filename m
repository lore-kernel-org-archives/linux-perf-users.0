Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583C1FE46C
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776775; cv=none; b=EVSBUqkfprs3cSZiTLQyPsjmMuZ2fW/ikOjtrMHI54xRAwrNXQkGdJ3MXChhBmhRd7bWANuPZMjsL3yON9TcxjGQftC4041S8QoFnXQwxmXLh3wYDLIOpYDZHE4Ok2w4IRfj6e9onwYdaeUdhVn+qNzfcDbsIYf2w6wvZoOyBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776775; c=relaxed/simple;
	bh=p0n+qzChREa2o0RG2z7oDzGMLoQcgCqnAs5+ptKAhVQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=B+A2CuJ5tf/ybYGB/LwEo6QuWJAQ3WmoJV8hUabbSyE1vSeP8KqLKmhbWLfSXNjDcF7Uq7GWV7x6BXSi8VFZkbs5PoqG5nbn1XHOCTznnQ8PK/swygLHJw3aQDbaGh+686gB020UBIMUHS6OgKRFrbxhfc+X5EBkumMpbHZ0Eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IACvL2h7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IACvL2h7"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a0f608b88so7279276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738776766; x=1739381566; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUZmNolBEaviVSKZZK1ViIFwwPFKcpO/wt4qxQVM8RM=;
        b=IACvL2h7G2NcyhUU5Cv45n04rp1S1XQtrMXAya2f/+oOT97MyCIDIwcCnpr8Wuah+7
         j8YiMv4XLpcmBQhcYEikhIRvYy5FBrHNX8BqRvY1x9dKIf1wh+VvXYL7DftOlXW0yPsD
         k9ZdMao5BbcVpBU0xRHDt8gE17rU4GLyhuG20tevLOJzwfq26E2uN6VUB1uunq8C44pv
         Wpo0lnpkt9MZap7Nr0GghlGZaVbrVFFoNGwmnOl8hxWzKg1HVBnX0oFE606ncnw4jJdz
         +bmjop/2bCje+nZyl9M+SZbXitNoPcowQmjXaWfHaIBT1Zjvi+xVJlZXMjG719RGBejG
         XO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738776766; x=1739381566;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUZmNolBEaviVSKZZK1ViIFwwPFKcpO/wt4qxQVM8RM=;
        b=IpQBafONIZZByXQPFB29WUTtDP9A+Jd+i/ybXSj2nq9SlkRZTDXmrO4AA+b0AYaz0K
         HMmx28AezU19LtP6ZMwjiE5xmunEekPkENDu58DCyhEpMOzIQgB+5rbbUfWTr7+sSnqD
         3X0GmUB5pf22IVVIZFLJcnOP0qNLEEYSFwxwG4vUjCgOBIWyhC67BYq7E2ZuBbR/RUSP
         uCDC38UqR26DxzYalCuN0NAViZbG16P8+xWQKwve5k58thRhG2GJr3gJjidT4xBoaslU
         wDflF7rnbx4Zu+AaAFzBe7wMv5lYRw5vOq7Vm3uHVGGGoyHGS7stScz14mcExPAkvdRT
         2G3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHBIO82XDZqQ0U8W3jf/IR1lpunx6AXfjRpU+/EfMAgcQexSMSKzAK10fkAc2iY2Y7kyVpqYFRU4TrefZ8sSoa@vger.kernel.org
X-Gm-Message-State: AOJu0YyBtgH1gNugUSmPhrCbrtNu4Tvemy53Tz7MBER/ylDlcR3rET7o
	dX3BI+EqhbjJfK3o6mirSOE8/yEpucr3b+bp+B4gLJYpzSpysgbhXYM3HCLPSPzQpddJznakf2O
	btQCRhA==
X-Google-Smtp-Source: AGHT+IETmVS3OKCIRc/tAeLiLcI6opvzjYhB/+oHytBbQ+3j3+DW98rdaTb3cfkKnxKrxDT4iVvXJDrhOyR5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:34a2:aced:a7fd:972a])
 (user=irogers job=sendgmr) by 2002:a25:810e:0:b0:e5a:f4dc:c2cb with SMTP id
 3f1490d57ef6-e5b25be83fbmr22769276.4.1738776766228; Wed, 05 Feb 2025 09:32:46
 -0800 (PST)
Date: Wed,  5 Feb 2025 09:31:40 -0800
In-Reply-To: <20250205173140.238294-1-irogers@google.com>
Message-Id: <20250205173140.238294-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205173140.238294-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v5 24/24] perf test stat_all_metrics: Ensure missing events
 fail test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Issue reported by Thomas Falcon and diagnosed by Kan Liang here:
https://lore.kernel.org/lkml/d44036481022c27d83ce0faf8c7f77042baedb34.camel@intel.com/
Metrics with missing events can be erroneously skipped if they contain
FP, AMX or PMM events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 73e9347e88a9..ee817c66da06 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -20,7 +20,13 @@ for m in $(perf list --raw-dump metrics); do
   result_err=$?
   if [[ $result_err -gt 0 ]]
   then
-    if [[ "$result" =~ \
+    if [[ "$result" =~ "Cannot resolve IDs for" ]]
+    then
+      echo "Metric contains missing events"
+      echo $result
+      err=1 # Fail
+      continue
+    elif [[ "$result" =~ \
           "Access to performance monitoring and observability operations is limited" ]]
     then
       echo "Permission failure"
-- 
2.48.1.362.g079036d154-goog

