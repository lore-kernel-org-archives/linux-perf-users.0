Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38FE3A6EF9
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625092; cv=none; b=fFz69yk6/tXlQPeo1LrqyOY8d/AnGrSOtBlp+pWiOGlpWDKcHTYPmba5qTzmQPdX0RU0ZYs5itotrkH0U6O8nvVKCOQwA5xxUGnO+YQN+Z7Tmi3+CPna0LItIWyCSQgaxNtf5z34D3tICTiWM2qcFijAh0o2SlGcqePCWhyODTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625092; c=relaxed/simple;
	bh=M6w4IqHTWbh6ZWT8b2Wif9IKz3DGxk4oNHPP+qBQPKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qTgM1LdjekA48KzqP5kfdPHSF7P+4RYiivm3CSmybwv4edm7TpJr192ztOMwA/6hd0f3Ng1mk7E+ni5TP36LS9SjRO7IX7uTkTQh79rIeKvS2y9w8MTUx5yD5js96JTZwUA6kx03wjQZ4zr1+wtR8ASrWwRGAxEeSPlRUQDw+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQxu/kmk; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQxu/kmk"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132d5ad9c32so15811388c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625090; x=1779229890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sfMuXq8kBDleR66Hb5678poSzirSVE9i4Y9M0nEsiO8=;
        b=sQxu/kmkgMLRMWzEQSfE5N6nWFPqIZMa7weIRHxTN6rZ/W/Dq8ovv3LG7RuJmRwv+Z
         2LcgpAmKGNHr8pNv5qgdYOGbb1mEpI3m157pODDvKRA/VPIlaiP5V0mQNqVt+0jia6VE
         YECUhgwsaeol3NmUgWn0AVVYspvDiMM7QarlpwHtJG3FwhBMIz0zyByQ/0iustrxT0eB
         Lroz/HIZUxIJ2G7labOVrNbHAh2wKvFbgubEf2tCmBDfnVRwJoP2cDUDqf7JeXZNrsB6
         8reXd+LypAEHg4pbTytmiXTFN9AVyqHEwkuyYE7fHx2K/l82SVW5hu9b2NDDvUJ4moz1
         HZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625090; x=1779229890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfMuXq8kBDleR66Hb5678poSzirSVE9i4Y9M0nEsiO8=;
        b=fd+cS1x5CJ9hMBFxHrOtAZK/pGnTCeDJhq9X7wJLRIiHdAo2f2AXavvQiYREpqayN1
         5lInAfKGtGUQzprtZTA0qWQeqgINS49iEi+1FgO77Dr6Yg8B9dcm3Lb7WN2n270pG0Pr
         NvjafHK1bqFxLE1oQOjgd7F5qmoChyTIlMREl5GRmFiQ2dpMcn14x4n/bK9NtLd8UR7/
         6LMSJiro1aO6p0Otcq+N2umRna2kq4VzhdjNSDtiOxbT58Qs6Qai5odzzeEfx46KuC7x
         cXzbCUo4gfCbzQNHR8RZTnKsxpKfjeuctLADVfnblf6p2vKL1KAf9MqHfI+8td+jx2lb
         Ar0w==
X-Forwarded-Encrypted: i=1; AFNElJ9LC15VcKAySs2GXA52u0NPeq8nBFHkoVL73j4BMBODRFE+zTOVm0/ffehpNtnSrgsSvnenNWSfd/ZVGEIecFj/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3z4Z9fOAeSjWM0hrsWqAuLvg52+VX+ilEUc1HtyecRZaoRUD
	+uIdKyBNd2qXlWvPnQ6WO0+uHuWjkGlUx5jBo5fBu7eZQojh/ErGfmFVjnu4+GI8f3XTtqYYi9v
	KyjNBcULZ/w==
X-Received: from dlbeb4.prod.google.com ([2002:a05:7022:d44:b0:12a:c4ed:5eeb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:30b:b0:12d:de3e:86a9
 with SMTP id a92af1059eb24-13436bb3cc1mr521231c88.39.1778625089707; Tue, 12
 May 2026 15:31:29 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:59 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-31-irogers@google.com>
Subject: [PATCH v13 30/32] perf evsel: Add bounds checking to trace point raw
 data accessors
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Avoid a tracepoint field accidentally reading out of bounds by
checking the size of read fits. This was prompted by Sashiko review
feedback about the potential. Properly compute the size for dynamic
fields using the high 16-bits.

Fix handling of dynamic tracepoint fields when endianness varies by
byte swapping the data.

Signed-off-by: Ian Rogers <irogers@google.com>
---
I suspect the int field handling should also incorporate these
changes, but I've stopped with just rawptr's (which also includes
strings) as those are the only current fields that support dynamic and
relative.
---
 tools/perf/util/evsel.c | 54 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bb48568b8101..713a250c7374 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3700,22 +3700,63 @@ struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *na
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
+
+		if (sample->evsel->needs_swap)
+			dynamic_data = bswap_32(dynamic_data);
+
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
@@ -3726,6 +3767,9 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 	u64 value;
 	void *ptr = sample->raw_data + field->offset;
 
+	if (out_of_bounds(field, field->offset, field->size, sample->raw_size))
+		return 0;
+
 	switch (field->size) {
 	case 1:
 		return *(u8 *)ptr;
-- 
2.54.0.563.g4f69b47b94-goog

