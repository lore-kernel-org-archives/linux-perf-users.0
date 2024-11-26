Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128DC1DFE23;
	Tue, 26 Nov 2024 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660385; cv=none; b=Jh3kY4FyzRmlTfx52/7xCiCCT9n61qVRGJadBRqcef0sps2AdL9lWGCsTn2vdNba2eQPMROBENLZaAPrK2Gkt/VG1vASm8uc3hdaNqWzIK6mxnC9w9bgfPqbSXrJwdRwdma2x3ovNIG8wTtR6w+XXF5VcHz5fcIvSJnLq55ZYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660385; c=relaxed/simple;
	bh=6xh0bVck0B8lgk6GVIh6/cpRZPxwDwkzpZZ20BQCKxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+CJWhI9ZWQP1YIa+9lF8Jar9+duAwrkmth6avME5KW/J3bJ+d86eJrGKFwtdoH1FLHyN3rNWDsqhhCPHM17AOSKCfNMERnoPhzcPf9Hbf0uizSukbHmnWkwYsCbt4boggO/LEuWNS+DkhU7lEze35t2q7QBKo8cwAZlYuLNRdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTTRFPNW; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTTRFPNW"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71d554dedc6so1103619a34.1;
        Tue, 26 Nov 2024 14:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732660383; x=1733265183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NADZafaFYONt5GwVPkj5cWf8xMDXWYD7ZnFNifYBYQ=;
        b=iTTRFPNWE3F3wznte6+i7hxXJ1WqSjvyLMbqU1gPU891M66LTgNT/O2+WELGRXQdju
         GGqYkCgtsjxKmBx62PIkhKS8TkaEh3HRDDJ+ysM2A+IH4cT9+bQvuEUuKx4Pt4Jw9VGM
         6elHVpoBHN/+yxLAuImlTLY0Y2FmqqGSHPwDYqu0K9eig2rbJHwA6l5C9STiT/o3u2BG
         YHFcXIhVl2veKymA26tlvWjjMtFTKqRfaeMz/woILVNG5RyRgLJUiPSNw1cV+XPGFZqn
         J+uj8WyBsqSfGLujpgcYNZA9qPakyNMqnsDQkkEbsB+UllfZo11P9WerZFP1Zn9rmVjP
         fzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660383; x=1733265183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NADZafaFYONt5GwVPkj5cWf8xMDXWYD7ZnFNifYBYQ=;
        b=vjghaZEE7Jsv3HpHkqQ+vd/SZpodSRGVXaHZ6rWu2l07fcotC+6zezpV/FEBZyLfEp
         mJGxGW+KZm8m8mgUAkKHBnvH/Pj8hxVbz5wPGQa2V2qgT202pCbJz3JwoYVC+I7q0bUQ
         6WAr111lzRE0t+qsr/O2ewNXEFahu1dCfQiijpq6laUOwLIrrP+shf0lk3SEW70uOW40
         cx3hTIyHFLRx1YNf97TQaUySyLx4nVa64Snk/GbnV3I6aZTDq2Gk3Ix54DgbSUBVjdWU
         MR8zDdNRAsJ+FpXloTMvqm7dV2MLDJE/xjw8F6X7Hj7CWqYd46abg/1ECCvu4NM7zOBe
         YLRg==
X-Forwarded-Encrypted: i=1; AJvYcCU1QCSUIojc8I00nvrex+FJUve2j+UNddBCgcKX2/b7JEuO1JEIoJHGg4hetdsjh50DlcqVub5gavNrbqM=@vger.kernel.org, AJvYcCUxlpVtzaPh9Jc/q1ZB0m0GhbC/GJNH5qowDCAo5xcqU6VTTcn1LIb4k0prsR69JtBUGLm3DKhBBmBw57un7Wo4bg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6+IY8vqeK5uhOj6vo2SNWk8EgxU0A50PfKPfjfhdwE1KF2Qd
	cpYnUfwxbuYkc4qhF63zYLMIAxbmXGU7Mj9p3qTQZQs/osah+Eh1
X-Gm-Gg: ASbGnctNh1ivC1Wx83TYdUmCdP65tDEm3VFSROdHuenoGd8wtAE/JNZaeVaCKbnDMms
	5s4SXAifEMXo+Hdh/c839eEo9bSYhav8SJvKvU0r/FJXDAQd+SW+Qsq19UNMG7aCTO9nm4KELsk
	JKGUnoDHk87ihhQIagDWERPlUKjxX1cKeBO/e1I2DP5vB+2f2BNr02cZeSLWeESE7vvzv8bVrx1
	ohr0w3NEgS6fMcGSUAxgFOjdwoZyR6OtlNUBsq5S7pDZ4pGhOM4j9+3O1EAFk73m8lN4N216/Yn
	uiFfiz3tnXo=
X-Google-Smtp-Source: AGHT+IEm8a1LbvGwjEdMMLZ8qP8avrelxg15TIDsyjTwHGNf27UTHmw6DFPXEQTwArnkRdO3JdX4xA==
X-Received: by 2002:a05:6830:f89:b0:71d:5f22:aff5 with SMTP id 46e09a7af769-71d65c933b2mr810429a34.10.1732660383099;
        Tue, 26 Nov 2024 14:33:03 -0800 (PST)
Received: from mbp.. (157-131-33-111.fiber.dynamic.sonic.net. [157.131.33.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc406de3sm7948861a12.81.2024.11.26.14.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:33:02 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 2/2] perf docs: Add documentation for --force-btf option
Date: Tue, 26 Nov 2024 14:32:57 -0800
Message-ID: <20241126223257.22465-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241126223257.22465-1-howardchu95@gmail.com>
References: <20241126223257.22465-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --force-btf option is intended for debugging purposes and is
currently undocumented. Add documentation for it.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/Documentation/perf-trace.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 6e0cc50bbc13..fb3d2af33844 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -241,6 +241,11 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	printing using the existing 'perf trace' syscall arg beautifiers to map integer
 	arguments to strings (pid to comm, syscall id to syscall name, etc).
 
+--force-btf::
+	Use btf_dump to pretty print syscall argument data, instead of using hand-crafted pretty
+	printers. This option is intended for testing BTF integration in perf trace. btf_dump-based
+	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
+	better pretty-print integer flags and struct pointers.
 
 PAGEFAULTS
 ----------
-- 
2.43.0

