Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419C347BDC
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959789; cv=none; b=X2WqHimjHNHeiRCz9caEsop4GjsTFomY+Y/bNt1e/9/U6RN1Lv3f1DBP3wNldPNWT5IfmF8v40SPVp44mt/ytO3nnTLMV2bsmX4fzICz3KsNiu6hbrmBGqxvQyUDlXLW7VukXXZypGIEn7niBClJDQJzfoy/PzAPpKTKTTichDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959789; c=relaxed/simple;
	bh=qdOKHQj7wmupR1ZjbY1aHF+SLa5Ed3VQA6amaf71kdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OP/55x1Wo5ejCpP9sNx+cLOa4W+4an0thor0uIWzNwBLENhvk1jmz0JN0qsNcPv4Owry9ZkucztRbuQwaS1DEJ8WRCGItor/xmeCPRVmWdgwLUX2E0n+ydSfKj+ShzKhXTym+s8w+gJd/HkVogrWeAxnpmPFEeHL9QRl7G3ZLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4TDNCiW; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4TDNCiW"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c4cfe08c9dso7168657eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959788; x=1776564588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYsnNurdZMY8EgEdiAJpUu0s2JlYxkBVPJknhM/SHHI=;
        b=E4TDNCiWQSCVtnZc7Ebgyu2JlhQlMlXYosW1l93zMJv2YlRhxBDx+B2+EWTr8CML46
         C+DOdTPA+lOtbI8QuAX4G2C9AfSra+pZ56eZFYGqFcTirX+cd+j0/kVI+cwTq5ug7YKY
         arH9cWiF+33mv8IUMXHcOJyAYDAhMx/8spu7lRCA8/oY6VdqzbUOUnmq6OKTW3O+zy9/
         q5ag7XR8I751hfAbB+trAFhYqbyvsErPiZTcP83E9pC6iumvxHICJjKTWLb0wWWSEBo5
         dNBlcbgc6g33aOq+E994lRR50f5/z6Y4A7++OepcCOUB7KcYz4Wk8U8hGZPolLj/gj2Q
         G5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959788; x=1776564588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYsnNurdZMY8EgEdiAJpUu0s2JlYxkBVPJknhM/SHHI=;
        b=YDHh/his1vmOIVjUNqqY2RX9UUYctWZwjee/MCREbxLyS0sskoOGpd8CFG2HrKaNMW
         Uwwoneop7xyONE1hqMtL9jV6KdMqOVA8p3TOu7bWxhCdz/lpr+sUSSx4AKW+innK8lP7
         vId5wZrilGlmajS58LrWp+1YMoMc4ppr9Wjkqca0S/gQj+7vOR7ZPe0MGX7ApN322Yoz
         yfOVuHsz3c0ggtGqJPly/9hdqU9GecPCfWC5oL1rDPy7B0YuE+M+LkNzFC4um0BO6Uyc
         c4ETh/mQVTe+hG2QMaru3lp41hIN0VMzuZ1war/8PwzgOdipWPqcjEPa9QkEQE536Lgr
         /bgA==
X-Forwarded-Encrypted: i=1; AFNElJ/T0PTno+bhDCkigCMOymAm7hULtYLINBdpW3Kjf0/zhbZIuOdNyz4ZCT3Irxot9wnE5C2pD/X6ria7bkNlTYLb@vger.kernel.org
X-Gm-Message-State: AOJu0YxVE7/xndv/JMvhJpPbjRroBWnOXuF1z+Ry4QKRSgV7yrDZaKJH
	yHdb2IRD34UwT6I/jXbqitcjBh77+hP0Vtkh0ibSJvSD3Nm1yQLWALb7RAkYkrWwLimlvffO1ZY
	P3M9xrxE7WQ==
X-Received: from dycmz22.prod.google.com ([2002:a05:7300:ea16:b0:2cb:735c:182c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4586:b0:2c5:220c:5673
 with SMTP id 5a478bee46e88-2d586380bf9mr4469940eec.5.1775959787531; Sat, 11
 Apr 2026 19:09:47 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:30 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-28-irogers@google.com>
Subject: [PATCH v10 27/29] perf evsel: Add bounds checking to trace point raw
 data accessors
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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
index bb48568b8101..c3a20f13d669 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3709,6 +3709,11 @@ void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
 		return NULL;
 
 	offset = field->offset;
+	if ((u32)(offset + field->size) > sample->raw_size) {
+		pr_warning("Invalid trace point field offset %d for field of length %d in sample raw data of size %u\n",
+			   offset, field->size, sample->raw_size);
+		return NULL;
+	}
 
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
@@ -3726,6 +3731,12 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
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

