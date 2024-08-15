Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B33BBF5;
	Thu, 15 Aug 2024 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685826; cv=none; b=WXiTxvynC17P1/9h3eWh+TeYaMN3rDHnk+ucCXYeOEnC20aPjgFebdTLSYV30XHiFbR+sWly5HiaTUKHxzXbbqgVc0PofIzZDHQetYcOEN+ODi8E465QNqqXP1H9Jgu4nM60RYgGao7TQ0XZ0tL604VMqqGvO4bGR5UlfuTSxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685826; c=relaxed/simple;
	bh=joBJOIKuoTw1RwAeQ8EIoJ4+kmDQJfN5l9AudFa8yWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auCfBCCq+rPL8XJypqVX9tpj61HD1n+QDoLY88aFyXCqkoWjwU0TsAxObugxpg5jdJo15YTtVfoh5BtEhdbVp7Lu4CBNcS5pvaJE1l6oyNFs3p8fEe+p8N0HCtrWzobdF0fU/UpbVw6ZsS0ptbKnodA16Ccw5NcPf1pZNkSK4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8JTTtrf; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8JTTtrf"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso360057fac.2;
        Wed, 14 Aug 2024 18:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685824; x=1724290624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+fqLnPSfwN0MZE2ewKoNtD6/c0sQaornbzo3Qw5EMY=;
        b=T8JTTtrfvi0r/0VKovSvACKskQ7KvNir822COwKnZA9zvVwIT3tHetACftnesWl4YT
         w+8vrJYmoQw/a3HCRMjOPxRaS96fL3nbmYuBW8Ij5bmrOaONpGHAqkLMMKbGrNWEjd6A
         wpJeMOzDGEDApY/BxeZOvlQ87ZMxpmZ/BsoZ7guqsVXrM3aIjA/nxWT9q6ojWS+9FT1g
         d7lAmRwILc937JcZ4ctkuqbgmK6dF+nhej8t6KeAOQcxl5K6Feka4UDX7i/vk59Z4xND
         NufMLTp4TgYSAbtVTlRABH3yEc28m1vpPiVXHoPKrJx/jDuLZR5gZnSRuixvrabbX+5l
         Z2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685824; x=1724290624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+fqLnPSfwN0MZE2ewKoNtD6/c0sQaornbzo3Qw5EMY=;
        b=nPDB+HJZEWDKUOOPH6/iGVGZl1DKB3OWuUxFHYrL4bsBxLNQ0pCY9TX59db2ww+LNK
         EK5/kncHqFIIkpcy8qbi9qptrgsVYAripjZ1/vg/qwOA7A+kXZpGSH5pM5+IkrcOQtWB
         cFRmJfRFsC5j06okg7SyzDUR6sbxQg8qI6HSOI6D7vFDStZBBOMT1TAoEwAKscmYfhe3
         N8qCREeeVCkfwqTU/v80Jrl31tJ+KniDPY/WJrrhikpw5hJwxv0me3TvEwVqGs68VaS2
         BTES+iKFahv5oVi8tfUxwROMWKBLed+f1HV1ByfeBqhMJkIhGfPT6U6fJ8lCCrLN9GjG
         fCYA==
X-Forwarded-Encrypted: i=1; AJvYcCVsfydILYe7z0bgYWw67N2W28r1OGafyMInr88CM3fVO+nLOXLSP5QAb12smsmOrEjbsgzAbyEvucbYY8aWv/T7GB4eipAdl+rXWZIdaIWNnnF4HKtOkpRqk0xpnRv0nLjaPiqhCee66YGz7k5cLA==
X-Gm-Message-State: AOJu0YxDkzmUiseVgAzefuT1BVaAb9293tcGLe9S0PPKZJqyefCTFH1T
	24YzIbiJQvUx390P+oaYOh2j3yDfhVze8c8W4ipMjNwdza07tXyMZz6QazxBe3g=
X-Google-Smtp-Source: AGHT+IG0Nx6iuVN9IO/WFNOGEpeY0kTmF6qrtcLD66QMpds7EU22JI8fRxeth+VIFrMQRnUWVdfeCA==
X-Received: by 2002:a05:6870:b4a3:b0:261:537:8d8 with SMTP id 586e51a60fabf-26fe5c2f2edmr5349026fac.49.1723685823963;
        Wed, 14 Aug 2024 18:37:03 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:37:03 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] perf trace: Pretty print buffer data
Date: Thu, 15 Aug 2024 09:36:23 +0800
Message-ID: <20240815013626.935097-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815013626.935097-1-howardchu95@gmail.com>
References: <20240815013626.935097-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define TRACE_AUG_MAX_BUF in trace_augment.h data, which is the maximum
buffer size we can augment. BPF will include this header too.

Print buffer in a way that's different than just printing a string, we
print all the control characters in \digits (such as \0 for null, and
\10 for newline, LF).

For character that has a bigger value than 127, we print the digits
instead of the character itself as well.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c      | 48 +++++++++++++++++++++++++++++++++
 tools/perf/util/trace_augment.h |  6 +++++
 2 files changed, 54 insertions(+)
 create mode 100644 tools/perf/util/trace_augment.h

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e7421128f589..593b0b8724d0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -65,6 +65,7 @@
 #include "syscalltbl.h"
 #include "rb_resort.h"
 #include "../perf.h"
+#include "trace_augment.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -852,6 +853,10 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 
 #define SCA_FILENAME syscall_arg__scnprintf_filename
 
+static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg);
+
+#define SCA_BUF syscall_arg__scnprintf_buf
+
 static size_t syscall_arg__scnprintf_pipe_flags(char *bf, size_t size,
 						struct syscall_arg *arg)
 {
@@ -1760,6 +1765,47 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 	return 0;
 }
 
+#define MAX_CONTROL_CHAR 31
+#define MAX_ASCII 127
+
+static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
+{
+	char result[TRACE_AUG_MAX_BUF * 4], tens[4];
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	unsigned char *orig;
+	int i = 0, n, consumed, digits;
+
+	if (augmented_arg == NULL)
+		return 0;
+
+	orig = (unsigned char *)augmented_arg->value;
+	n = augmented_arg->size;
+
+	memset(result, 0, sizeof(result));
+
+	for (int j = 0; j < n && i < (int)sizeof(result) - 1; ++j) {
+		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
+		if (orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII) {
+			result[i++] = '\\';
+
+			/* convert to digits */
+			digits = scnprintf(tens, sizeof(result) - i, "%d", (int)orig[j]);
+			if (digits + i <= (int)sizeof(result) - 1) {
+				strncpy(result + i, tens, digits);
+				i += digits;
+			}
+		} else  {
+			result[i++] = orig[j];
+		}
+	}
+
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
+	arg->augmented.size -= consumed;
+
+	return scnprintf(bf, size, "\"%s\"", result);
+}
+
 static bool trace__filter_duration(struct trace *trace, double t)
 {
 	return t < (trace->duration_filter * NSEC_PER_MSEC);
@@ -1977,6 +2023,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 		     strstr(field->name, "type") ||
 		     strstr(field->name, "description")))
 			arg->scnprintf = SCA_FILENAME;
+		else if (strstr(field->type, "char *") && strstr(field->name, "buf"))
+			arg->scnprintf = SCA_BUF;
 		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
 			arg->scnprintf = SCA_PTR;
 		else if (strcmp(field->type, "pid_t") == 0)
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
new file mode 100644
index 000000000000..57a3e5045937
--- /dev/null
+++ b/tools/perf/util/trace_augment.h
@@ -0,0 +1,6 @@
+#ifndef TRACE_AUGMENT_H
+#define TRACE_AUGMENT_H
+
+#define TRACE_AUG_MAX_BUF 32 /* for buffer augmentation in perf trace */
+
+#endif
-- 
2.45.2

