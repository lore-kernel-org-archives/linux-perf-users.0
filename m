Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F93806C8
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053582; cv=none; b=tOI7xJG4uTdRFyV+zJhGia34DZbSM+lL3cMVfU7X9bOhRdI57K6YZsw7vTzqI0yjKSj/UHl/w4zIuQflF+XoP/aEM7s5e6o34CEyibDvFYslZT0h7af8em1QRtCrD75ChwIYojaw4N/qu/NV7BsGTM83u7ZMlygQMn162hJvMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053582; c=relaxed/simple;
	bh=EIb6tJcKoSqkpkMiIWHT8GXSEcQ8tARRtV2V9HnrXoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTQtl5E0MIf6mFeOoRDo3gw4Q4PNKgAEXvtaT+YRczVglebZelnmUl30OKwZrNxd1GDpj2ps61Ox/bbx83Viiv19k1rMtdYWxSMIuZCbCZFQJJFh55SQgda2H/w75qVH0nuFgHx5BcqgHT1/1PjQuDkbg+lgMi3zuHoeJHPhv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TzHxaXvj; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TzHxaXvj"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20d5d7f4so13590895c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053577; x=1776658377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0NBhXTshGbMXUhORX+eVN1pO2rFpCDmkzuCKC25Nuc=;
        b=TzHxaXvjGLb14R9HOTPaprWoItAlRBG2mG+9SiUsxkJJ02jH2CAPLrD7kEcYP4sW37
         3nagCRTqQXjUhBtnsD/IVNvqUa/5Y1QtLal6KuI/msHtg8p81ibowRKvy6k1hsaJMqYB
         Ucpycmx5lxo3RS7+G4P5pzNITLrtBi2CMXcYPuc1WFZkBzb5hs3DNUKb5NUuqv5w1DZG
         mJrzk1qicRf+rPcDRTSAbwJPMkXOjtD5neetiuHY3BMZF0Avh+6rtNuvyARbyqH3ISE5
         dQDaAcbJq04eYMPqfqmIkAIYRIcN2oz15+ohhW5qQl5R7yeB1uGIgDBYaF/cMlEyguKl
         jtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053577; x=1776658377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0NBhXTshGbMXUhORX+eVN1pO2rFpCDmkzuCKC25Nuc=;
        b=WObgFluVw4UxgG4DCK0B3+ik87F/2uvB/eABs/vordnYIen9hvlUMf2qTqnsu7Jd0q
         fEKJGts1Ylsyrgzfl6ZvaodncryYH+atyPu8hA5Ao5umiHMWEBa6PD20V6FEyKtOc0Vb
         W/IyyO/fv5fZLMx7tLRT8jnFQZKhEVqfbQsCtlv+hAHjrksd2TIVuvdxqB7lFQbzR3X1
         7xL6tsNWEmGOAVjQPNeugDU10cCAcVYwTKA/OifAJI5sLBGclyY1FheOi7OPlR4O6tV9
         szS2eAwXC0m/AWxqQ3RbiJCyezrdRnCxtEGZKGmXV+ePUi0Jx/X2cxYvoZAZ3YoOExYT
         5hzg==
X-Forwarded-Encrypted: i=1; AJvYcCVNVDG2EMEVbX9OzKUkVnO6ZHjNuCyhuShh9QQms2+vEC0NZng77VmLp5yl5U0fMnJ/ECgzDeRylR2iXflx9LAN@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNBu29Pam10ctwwQ/XDhRUdN3r2lS5axxsSvbVrhBZMFlJ8Q+
	yoFixMTTVpJoxqaWP0Me7l4bMH7A3Mqo5D6jTQDDCAlyK3U7nSlJr707dAlo/HQeECEjJrEsLLj
	fVznoPl88yg==
X-Received: from dlbsn14.prod.google.com ([2002:a05:7022:b90e:b0:128:d185:c6ff])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f9d:b0:119:e56b:c75c
 with SMTP id a92af1059eb24-12c34f069edmr6642277c88.33.1776053576289; Sun, 12
 Apr 2026 21:12:56 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:36 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-27-irogers@google.com>
Subject: [PATCH v12 26/33] perf kmem: Fix memory leaks on error path and when skipping
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

Add missing frees and thread__put as necessary. An issue detected by
Sashiko code review.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 68a39f56204d..daf2272c7337 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -783,17 +783,21 @@ static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
 
 			new = realloc(gfps, (nr_gfps + 1) * sizeof(*gfps));
 			if (new == NULL)
-				return -ENOMEM;
+				goto err_out;
 
 			gfps = new;
-			new += nr_gfps++;
+			new += nr_gfps;
 
 			new->flags = gfp_flags;
 			new->human_readable = strdup(str + 10);
+			if (!new->human_readable)
+				goto err_out;
 			new->compact_str = compact_gfp_flags(str + 10);
-			if (!new->human_readable || !new->compact_str)
-				return -ENOMEM;
-
+			if (!new->compact_str) {
+				free(new->human_readable);
+				goto err_out;
+			}
+			nr_gfps++;
 			qsort(gfps, nr_gfps, sizeof(*gfps), gfpcmp);
 		}
 
@@ -802,6 +806,9 @@ static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
 
 	trace_seq_destroy(&seq);
 	return 0;
+err_out:
+	trace_seq_destroy(&seq);
+	return -ENOMEM;
 }
 
 static int evsel__process_page_alloc_event(struct perf_sample *sample)
@@ -971,6 +978,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	}
 
 	if (perf_kmem__skip_sample(sample)) {
+		thread__put(thread);
 		return 0;
 	}
 
-- 
2.53.0.1213.gd9a14994de-goog

