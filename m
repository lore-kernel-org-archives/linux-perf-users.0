Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87A37266E
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994154; cv=none; b=FsvNnWksRnvvGXl+YMIlYVxo8WG+2Ld7njN+UzaIuTSPKNRzUK2UPiMRyadYFWFL+hLCUr8bTtN+0jPFKEAVQAkeHZmErW/+SDoysiDFGyXCnWCnlC967Z8HUZul5G4SkS1dx/SQzxymFSyIZi72LH5lLA5P363pAodOuFQVFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994154; c=relaxed/simple;
	bh=Px3kvXNISBtpkk8Yg/YzO2B/LDlP1VbH2wUqa3xN3DY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jfKlrVXs/yl3OlzLh5Sap+nDHSHXPrjXoPAJGR9hisBP4C4XAuw/W1sEnWbrCdPnmW/V/WDNFYMI+sokDzJrC4fDIm4lf7xEW89jUGUIIyOV7f7XAshY0Lg3q3FQLqiZgFwB+pRp0iRZYMKm+GzVRfAUS0xQ1+ZR6O0kiktcG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tKth5BIG; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKth5BIG"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so1853269eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994153; x=1774598953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJxIIiDIQ59GOTFf+kVAJjN1YJAohx4635ngGk36Q3M=;
        b=tKth5BIGfREKx2kanpJCbwpsEQOn6xjflJJXO2ATMDvMwjokDb3JnaQF2NVvJiig/d
         QfUEPI9+eN6O5Mc4Rnzgzd/pxCzzKhwdKy+HiRvq0Tq061mHXnBogsS7CJNYPeqqvJ5k
         J20f8/u0pbdKMzSNhS3dxYBGidWXzcxyQby78C5f5bIuWE0XqIKmP9f3H09PBQ9TZCu3
         Xh3kbQtv94qtDf2mM+ALyF5X44EsLSTQC9uhzmGx/XlfXv3+wuTGwWyt0YGRQlLfp+dd
         zV+aaAOz4f/bvRLCFpE2W3/VB7ghfNkPPaNbp4oWq7iZvrYwsNyehb89NEttZKQpDkqQ
         fo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994153; x=1774598953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJxIIiDIQ59GOTFf+kVAJjN1YJAohx4635ngGk36Q3M=;
        b=Kup3WflAQp6TGUPBJ4UX9Kv2cz3rnW7AMKzCOvzTk7TeexPODVUSeGwdnuxogiqKpf
         CLKiVe3mpkSheJ4hfXRsVckds4tCaiVBtLX56xXc5jDSlqsY26hUHMcDsMTCv/5pOYqf
         xFkjaA0PXYHnwFZczyC3Fu7aC9wJ5txZotZP6krgHe36iVri+P89Bl8RZXZRXCX/xDKu
         z6xuiltcmCuptI1Jzftn9x9a5TictXdhFdkatZauXaL2CPLDp3cyGldN803THAV/W56e
         FmQCxATKJu9NHchAFSt7TYENn6N4YSU6OFgdyC324tuoXLdkyl1OB5liGgxZ8DUTuAxX
         3aBw==
X-Forwarded-Encrypted: i=1; AJvYcCXnoPVxO7GY4BLj1WSRz7T9kMbo0yJ7+T6V5s83REZ/azkfFiHq3yBiMweRAsPSPNbGkDc7I2GyNLiJfqT5WuK7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0m0t+vpVI+H3uFI1nz52JCwXUf1fOPW1vImCEIBxHIz+t+idB
	MRsZ+edORyRtng6fZUnCSNgA9dla+xVFzHs5nvAWbgEGdYt5V/VBed1CdYqEh4H1qmUhlsPJ0tB
	lriY4EtPWVA==
X-Received: from dlbuu9.prod.google.com ([2002:a05:7022:7e89:b0:12a:76aa:31cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:619b:b0:128:d7a7:5271
 with SMTP id a92af1059eb24-12a726b7188mr977991c88.28.1773994152504; Fri, 20
 Mar 2026 01:09:12 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:24 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-16-irogers@google.com>
Subject: [PATCH v3 15/25] perf annotate: Don't pass evsel to add_sample
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

The sample contains the evsel so read it rather than pass it. Update
call site.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 041f5dc92ea8..894e57aa50cd 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -233,11 +233,11 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
-			     struct addr_location *al, struct perf_annotate *ann,
-			     struct machine *machine)
+static int add_sample(struct perf_sample *sample,
+		      struct addr_location *al, struct perf_annotate *ann,
+		      struct machine *machine)
 {
-	struct hists *hists = evsel__hists(evsel);
+	struct hists *hists = evsel__hists(sample->evsel);
 	struct hist_entry *he;
 	int ret;
 
@@ -299,7 +299,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
+	    add_sample(sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.53.0.959.g497ff81fa9-goog

