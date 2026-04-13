Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8BF2C21F1
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043422; cv=none; b=j/YCcX4IfCtVov2yaIYP9kvy6s+ybnyUAkePiNkCXciGqrVpw3jThH/G8i/1S0FJIh+b6iOwXmZPPBSTDAED3TIMcffjRqezvJHLgeRLoxnZESFU4z9Xys4WrFAiPbkYa588U/f1sFHtEMvTScK5VNomIG9mqRfPGem3QHwQl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043422; c=relaxed/simple;
	bh=lurA7V4e8q7j0hn+dXLUJ3lZ8gP/eRhJrX/92iBe+gM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D1Lbc2Qz3M9DKEBmPackr549YcQpdwm/OlazNQxv+ErKeR7QJptctQ0zDjYXN4uOP11Ta5gVWy2LCDqcplYiQPIViMmOcZwsU/PVSP4o/+y+C93DANdt1sUggCv71Cgfkru2mvgydwLor2IJ+9ezT2jyIOQayfP0a2yPU+Nrtrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDkjwRft; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDkjwRft"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20a91932so7453647c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043421; x=1776648221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QL5jBdw8qQX/M0tPrJ6CIQUkV0jfcuV2ZvO0gSC/Q1M=;
        b=FDkjwRftCD5W+pAsweKhyWR6L54+qJ9EjZRlDO367eNbhZ86/JuadMo9jom064/WFa
         3Cp5qc9TuwWnzO/1GC6e45V3jqgvkFBMb5UPrYKedZBpc1f/equ8d0bwg/NTeogwAWBW
         vgFMsvz64YizOuoXOh5kE2e1vsXe+8alAPc9mpK6rWhwzY+FXQIXYERYyxiQ8hwDtqh1
         DvSlvUiGuF9OUwBQc3UyaU5gABVQBUJ1A1tf/f/ypkfDxMunjLuJJMF0hmL/TEPtAUFY
         N9MhZ1wF/WdkEwhjl8l1ForZfyUX2CVI+0yWjhkp3R2j/EKww91z2/iWiv82xl/VDijr
         oHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043421; x=1776648221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QL5jBdw8qQX/M0tPrJ6CIQUkV0jfcuV2ZvO0gSC/Q1M=;
        b=f4ClgJUwdGCDPMRtz6E/UMIpZjwrPLH4AYhjg9/YdqtHf0RSZ1/qGc5tItw0VSxcBy
         HBuqLvmD0G0+Sm2VRQCFd2XLvJiMGfeLDFl+2eDN+sK3Swju7qD2vSga6nA3gZKjEOtN
         N58YR/UJ0i/8XyGeyLsOzBepA0tKlDyO9JriLbXMMVRZkfTK8CH5SZuxMnrK8Eor7JGU
         zG0AIaMq6epLPjEGAX2zIZopjMU8O0G+i5euUvvaGYhjD1ImsE9dysBUvgjEgKren/M1
         Jwpy18sFEu7fdjyro539yAe41MoY0niOnf29dBFVWo+FTTC6U7qX+2qkCSNVV2SXosco
         /cug==
X-Forwarded-Encrypted: i=1; AJvYcCXliFM1rpk3oNVtxQ3TfGxyD2PSpxx08Zlx9xltwdclyBU5cXx+/CKaU60ugKZMKK4UGgK3gAlOtQJZf/ARGRRR@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFVFpYd0Lav8tZkdshfNfEdc/QBR86uGbJc8OrJGx6ovMJDV4
	k/XkKUzwc381XgKLu02K1Xg4eSVPYvweIl/9achfxW3NWlslzoQPAqgX0d8ooKGVJYOKb5GioXb
	LFFkb+iw48g==
X-Received: from dlcip13.prod.google.com ([2002:a05:7023:c08d:b0:12c:3dd4:fcf5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:327:b0:128:ccaf:85d5
 with SMTP id a92af1059eb24-12c34e75ef6mr6781933c88.15.1776043420340; Sun, 12
 Apr 2026 18:23:40 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:25 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-32-irogers@google.com>
Subject: [PATCH v11 31/33] perf evsel: Add bounds checking to trace point raw
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
checking the size of read fits. This was prompted by Sashiko review
feedback about the potential. Properly compute the size for dynamic
fields using the high 16-bits.

Signed-off-by: Ian Rogers <irogers@google.com>
---
I suspect the int field handling should also incorporate these
changes, but I've stopped with just rawptr's (which also includes
strings) as those are the only current fields that support dynamic and
relative.
---
 tools/perf/util/evsel.c | 50 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bb48568b8101..a23bd28579b5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3700,22 +3700,59 @@ struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *na
 	return tp_format ? tep_find_common_field(tp_format, name) : NULL;
 }
 
+static bool out_of_bounds(const struct tep_format_field *field, int offset, int size, u32 raw_size)
+{
+	if (offset < 0) {
+		pr_warning("Negative trace point field offset %d in %s\n",
+			   offset, field->name);
+		return true;
+	}
+	if (size < 0) {
+		pr_warning("Negative trace point field size %d in %s\n",
+			   size, field->name);
+		return true;
+	}
+	if ((u32)offset + (u32)size > raw_size) {
+		pr_warning("Out of bound tracepoint field (%s) offset %d size %d in %u\n",
+			   field->name, offset, size, raw_size);
+		return true;
+	}
+	return false;
+}
+
 void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
 {
 	struct tep_format_field *field = evsel__field(sample->evsel, name);
-	int offset;
+	int offset, size;
 
 	if (!field)
 		return NULL;
 
 	offset = field->offset;
-
+	size = field->size;
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
-		offset = *(int *)(sample->raw_data + field->offset);
-		offset &= 0xffff;
-		if (tep_field_is_relative(field->flags))
+		int dynamic_data;
+
+		if (out_of_bounds(field, offset, 4, sample->raw_size))
+			return NULL;
+
+		dynamic_data = *(int *)(sample->raw_data + field->offset);
+		offset = dynamic_data & 0xffff;
+		size = (dynamic_data >> 16) & 0xffff;
+
+		if (tep_field_is_relative(field->flags)) {
+			/*
+			 * Newer kernel feature: Relative offsets (__rel_loc).
+			 * If the relative flag is set, the parsed offset is not
+			 * absolute from the start of the record. Instead, it is
+			 * relative to the *end* of the dynamic field descriptor
+			 * itself.
+			 */
 			offset += field->offset + field->size;
+		}
 	}
+	if (out_of_bounds(field, offset, size, sample->raw_size))
+		return NULL;
 
 	return sample->raw_data + offset;
 }
@@ -3726,6 +3763,9 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 	u64 value;
 	void *ptr = sample->raw_data + field->offset;
 
+	if (out_of_bounds(field, field->offset, field->size, sample->raw_size))
+		return 0;
+
 	switch (field->size) {
 	case 1:
 		return *(u8 *)ptr;
-- 
2.53.0.1213.gd9a14994de-goog

