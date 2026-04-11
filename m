Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0057332621
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890708; cv=none; b=gvx7iqyFxc+6z7NZV74IwYa0juOyIl2+zAH12uUTotqwHsVeO5lEq3KeNRBaDpQDMMMqgL909AhR4IaYjIVxV9MQd73edh7G6TmcArNFj6itgzzOiP4EjKLzaySmM+xG1nwgdbLbhZUAhtA2//pp/15ult9Q5ROHtPGPb2tCoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890708; c=relaxed/simple;
	bh=bF2MTsPG8O5qt3z4+q+wqvjiW9g2BEL8MEkV3/7cMyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pk5qx/LxzUsPWKCRvQWBsH4HcoNQt7LI6Hcd3jgho+rBT7hzZMGMCuEcrFvJzY1pUYGN6cUuMGg+Wd4l/36T0izoMc1PfTu7O8us++W/6AuPNvCEWEGYdOmrayl3TVfbkT2nBbGvCuywJeNUlyxIZST1uDFV0E9Qg3c84Ydlai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjunfNJz; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjunfNJz"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c283a1212so5931322c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890707; x=1776495507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNvTyU3Q21vQ5oShsgnoSzW70om6RQ7VClowwcBZ1hE=;
        b=BjunfNJz8j+4yA6Q/pi319XgEE1hz9mF6Mg04e+eVWqSQpBTgwE1IfCiRXfcEU3yiM
         6eTR20N7+ktC4wYvOBxGsCCZSXpxgw2ThyvnvR043uJr0vz2zU3BELBCenfNa5XtS1w+
         B01Fb5K450LamHmK7b777QYX+kVBwIMTrOmDreTWxH+vhevYCK3y2JbbIfARCH46mw5y
         vAkaEDLSUbl0uicVkUvDgKScXid/PrvhkiP71CldkxjDMXPoLPc9hbqfr86zY83jVXBw
         aB3WE3s3EmNDFWhGbmfNfXAY0PbOs/qXRbesNk92M1mkM3FL0Mil8wFZG3nuw30KUNQ7
         V4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890707; x=1776495507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNvTyU3Q21vQ5oShsgnoSzW70om6RQ7VClowwcBZ1hE=;
        b=gx+0PkJqfnsEUry094zn9ffi2GrvhaOlz+CuOKOq5Tg5vAElsGx4++5ksTEJvZGNdP
         eYzmEu9nuUfoT81lSiRv3U2z5BAWCzEbcLQzI9n2p3RCoWDMtJJFMj3wUmpxAUdMwGsn
         gyNt1NzwsieMiAndjb4JrMFJLeEhn3CST60f/p/qi0ajSrXLTcBDXBszYFTliDA7Xh72
         jtJkA6MBL910IRlNuwn9tZEqd+Az6wL/Fn0PS6E6p+fjWcd6iqWof2kFKOU6Fk/qO4yt
         zvWGuIi2gBAU83T0MsfYUYvgGvJTpVi5Q2IXc4DiEp35W8nAx5MfOcTUluTI6mtj+02W
         a9yA==
X-Forwarded-Encrypted: i=1; AJvYcCU8nH+v6v98P6IgTPZnXyMxHCYV9Gqc/WydiP9hbo/vPPpMeTWLrkhQQiA3CCXn0VgIC8GR0l4FZj/VIRaB8KYq@vger.kernel.org
X-Gm-Message-State: AOJu0YxELEIsy725rwWFfpIoXprRzzWoW569c6u9++Dio35XSmZbhNCU
	SI6sAIFZwuNYvQLYl3+7xe0IHhMx3CZChf9QTx3C3BD61HYXQ0k0WVpI+muwri/t4aB7eYh/PTv
	QwxSFIsrkKw==
X-Received: from dly10-n2.prod.google.com ([2002:a05:701b:204a:20b0:12c:175e:29f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2581:b0:12b:ec96:c936
 with SMTP id a92af1059eb24-12c34eab249mr3775851c88.14.1775890706832; Fri, 10
 Apr 2026 23:58:26 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:16 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-28-irogers@google.com>
Subject: [PATCH v8 27/29] perf evsel: Add bounds checking to trace point raw
 data accessors
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

Avoid a tracepoint field accidentally reading out of bounds by
checking the size of read fits.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3c10b840778e..1e0bb4cb995d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3727,6 +3727,11 @@ void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
 		return NULL;
 
 	offset = field->offset;
+	if ((u32)(offset + field->size) > sample->raw_size) {
+		pr_warning("Invalid trace point field offset %d for field of length %d in sample raw data of size %u\n",
+			   offset, field->size, sample->raw_size);
+		return NULL;
+	}
 
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
@@ -3744,6 +3749,12 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 	u64 value;
 	void *ptr = sample->raw_data + field->offset;
 
+	if ((u32)(field->offset + field->size) > sample->raw_size) {
+		pr_warning("Invalid trace point field offset %d for field of length %d in sample raw data of size %u\n",
+			   field->offset, field->size, sample->raw_size);
+		return 0;
+	}
+
 	switch (field->size) {
 	case 1:
 		return *(u8 *)ptr;
-- 
2.53.0.1213.gd9a14994de-goog

