Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1438B14C
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053594; cv=none; b=hNbwyLMdQiH+hQwmVoOB7PRQUF2nEmr8YCbulrTHORHEzbJ9Zrurh3X1qVSCF6S/T8IhHVxhMAaTSL/JGTg6XphbnYRmCXeCPjqXuI1XQgCaigA7wCYMLK+gsOfBbdGxWrfv3Vs3t+2XfrPEI8jnZHfAuoi0gHuy1c0HIxuTT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053594; c=relaxed/simple;
	bh=g0usVRnl0CHfK4phYJ4kQUrCj6VQTusJyKz8Yi4JyAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wudqnt9yma60Xx3EhV/wDmrIL4a1ccI0IuVnOCzBtRAFfio8L3lHLYoj/es5nYLmTrAlxkS0pGZuSwaxoi0nykw6pHFh5s2gHfpWN+rSu/nSfmxU3+s5rmsR+05fqWjpYd4zMRWd7v3FLYVjWrySNxu8iK6urOLTjfshuumBrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4MhPjB9; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4MhPjB9"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127876be621so3269331c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053590; x=1776658390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hE8gZ0WlkEK0uxYEyWq3yJ8WEjn3eIh7WyTWOKO+NBk=;
        b=u4MhPjB9rHh7OJwUOgeDz9qi2eNmlLup3Q/H4ud7z5aOomrHLhn9gHo+N62zFOD5Oo
         BtT1P0FljcucpRcyzhBhPgHOeuN//RoALTalZ1XDwKbrPuzsrs2L0eqGuRC5Dm6SKwQo
         Pr8eOMR1QqqUfkLuVvBsQDu5uR4FXt4o7m+YCMnizp30Z8UAegclYofVeMx1hkYs0Mo0
         gqlLAvXb79LqUQtdCTvpREh0VR2/X0QpxN3bFcjtve0UKswY0k6yeMI5V7PfF0ce8iQc
         2FuyVAJ8YdPyV1NwLJBzYODtCtp2ZFpBsNIf27yvAbKD+Cita/nm3FG7at+ifcECh2Am
         AcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053590; x=1776658390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hE8gZ0WlkEK0uxYEyWq3yJ8WEjn3eIh7WyTWOKO+NBk=;
        b=KLYKZMnwGsww7R33sLviVanILAOO+BfiDtRVvVrjcyUexVGgOCaAJgP8R+ZCdlfy2E
         GPxiFdnnCem1+CwHclSio+IuQGLkuQT/FdmadgiFNhe3noU8ItzR1wYYcNqy/+ew6CRk
         hMYo1Ik7PVGWcMfZD6zvDgTh0dO9+fR4NHiyiX8cumN9PSjXvaqOdtyIsHsjodnl3xDA
         Lxe72hqOwqI+2T85IK+DaYQwKL7fPV3S03ZHZ+x4mSXKdhJKpcPoeoDZ3p2UtYNnmr2V
         7Hmicro/4kCWdTsrefg1DYkjhOKmUqoL0D+6Vd+oDOJbBLAJpm8QrW0yA9d8JgyQ3NDo
         v3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVgDP+L0SKTnlJ3zl0an0qdCc+Xjm9SczTqnCWQZWdnLpev+O1YANp3vWoJrrMZ3U4GEwFb1as81IZyWNX+FNV0@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQSZ6D3V/eUwD2BlfR2+Kc3vL9sS6HWoLMTG+yZR2SLnNgN92
	nUPEi6ruJcjel9AU+eGJ68ffdTh9dP4/mzHLxfuW9taAzBHS9JWaz25Li1OUKZsRadyhwKkU8JG
	xFCKOlajVBQ==
X-Received: from dleb14-n1.prod.google.com ([2002:a05:701b:424e:10b0:12c:195e:1f93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6290:b0:119:e569:f875
 with SMTP id a92af1059eb24-12c353007e6mr5251798c88.18.1776053589669; Sun, 12
 Apr 2026 21:13:09 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:41 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-32-irogers@google.com>
Subject: [PATCH v12 31/33] perf evsel: Add bounds checking to trace point raw
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
2.53.0.1213.gd9a14994de-goog

