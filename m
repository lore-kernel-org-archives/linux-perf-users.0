Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03C3FB04F
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034930; cv=none; b=L+hv1Rhkts0unDNKiaEg8WWl/V61KxLlIa+PpeBm2xU4aIrOnvzuyVSrbkT4nS0STlG4SXVzbp+zCqGoWxsw9uwmzNoFrCyz6tURgvI21Ep5HyUtQnldSfVnynVmLh5p/UVXSu19yFthAoYxC49Qhq5dwymHl5//PDBLPB1H8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034930; c=relaxed/simple;
	bh=Px3kvXNISBtpkk8Yg/YzO2B/LDlP1VbH2wUqa3xN3DY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vmjq9qAEnWT/jHpLBOH2KLrEao1xM/X5PrmNUx0IGRK4eFloMHjmti3KauDPhITz76kM+MihCFKHIcURywd3uv1Kia6ycNCkci881ZP+mDlmutET4GLWNyNj2HKwj+MjYbwS9ZQu9E1hjAlXo+/1KVXiZiNRmH9v3DbOZXLCr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebL6CZeR; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebL6CZeR"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1276e71652fso951678c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034925; x=1774639725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJxIIiDIQ59GOTFf+kVAJjN1YJAohx4635ngGk36Q3M=;
        b=ebL6CZeRXnnlLZByegFDWO55c4kfFkQCgAhB6dO0KV55yStWZZznPhyS9uVT4v/jU4
         O5i1ZXoBjx8rVwVnbfovUTUwrtLCHRTFpnrt139BNOPu1AWtt7WqyRtu9gA7Dwz8CgpP
         t4AXoXtfB6hc+Vfrnjg5Aq3be49jf99chsRAE4KtrlhTXmoyYeejdvbIRdySazTyzThK
         0DvHWNtMiy09Dx0XFNHnqzTku01S3NTuLd2jhIL+QAzB0IpAHDyvUB26ZoYx/pKo5/1q
         pK+rxNA5swAKImxQY2FHwEFVJ+ikwI675jySgcG1fHaaXfl23iBTdzZ9QHV+ZlkusbPR
         po2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034925; x=1774639725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJxIIiDIQ59GOTFf+kVAJjN1YJAohx4635ngGk36Q3M=;
        b=Co9852OiscErgtnA9VBQg4bJih1Q+l1wJC4FrfnrjW0zkleDk7VOwz07dzcfSzCTK3
         KnNAGOwG36iDFy71Y2yN0QZEny7e9IIFxSIv+PIKYkjLEsDYSxICIwSBGYXWlK/j7wKY
         rL2lb3aYiu217Fe3VM2lPGn9mnVCTUy0fk2kY+sPluM8dhw0uem48LtkgdJTBPWmjGBa
         t2ny4ZxrueeML80pmKvRyURUNDJd7UeB9wzCZ4z8qsmUZcsMX2edCzaPFc35jePor9yk
         ok4DcpdyaNpOyXZVmLavOPUuROwe5Z87piYxTYifbICet6KSM7zi92ytmofKP+jiokBX
         CC+w==
X-Forwarded-Encrypted: i=1; AJvYcCUueMulpkh3mCC8Kg/+gTwmSPPzGD6vp7V2acmjtmmXEn3OfEVMts1BNwzpzu42ZhKogoBzsumMY3ZYgt6XtPgU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9DvRTqIuP+za18LiyS9EH4mPSDa+SW/bdckpELmYteaCZQAi
	TdJGAdw7OoU5glaOIAiT/GmlvvN49oVlKeIcgIjv/a4uQfCxZvaVy4lICJLQzab/SJrhvZEeikG
	dtyoGrH8ImQ==
X-Received: from dyb19.prod.google.com ([2002:a05:693c:6313:b0:2be:7cd3:c97c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b82:b0:12a:6ab7:3f7c
 with SMTP id a92af1059eb24-12a7264eb86mr1946806c88.5.1774034925159; Fri, 20
 Mar 2026 12:28:45 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:17 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-16-irogers@google.com>
Subject: [PATCH v4 15/25] perf annotate: Don't pass evsel to add_sample
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

