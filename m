Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652FB2F2F;
	Fri, 13 Dec 2024 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057052; cv=none; b=AtYytxELfBw1oyOCXaW6+zPeqy+V9e23lakEljl6tdBcI/T8UofEIvZXG6IJQIHstz/DAp0ExED7vGi/u2ptmJOWIvYQ0bqLo7/Yxd+1THyWd1W62uAF3hPp0QENeqke+EH8+dCpQPI06fHyyoekyc3A4wTcggdSve2EmCFfhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057052; c=relaxed/simple;
	bh=YKTGhqYp6i9MXwCbA6wH2EP5CWlRh/MB6E3F5G9Dx9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWn/dEFeHfZ/0uWhgRiOvF42mUHbv/IPrF1JmCGdCWaiq/VCCPNYWxHdsNtftc7F3UArOOdQPHzjgEQ1K393/GpurvDbyxD5YN1nFTNZtGlRefrk/nlmXZHVQs6yw6arr8VXOdb4gbQ3kSY3axiZWr3Dbu/7ebfDTbIpOjT0H7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSahi4Rs; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSahi4Rs"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728f1525565so1505454b3a.1;
        Thu, 12 Dec 2024 18:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734057051; x=1734661851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GutaxVsglEexou/JOATq/TSxZhBiaRhJ64XMDJCI9GA=;
        b=fSahi4RsI7e0gjkF6AIu17gs9Lhl5CDoxRw5D/qmTlBZ2REW3YkLFyuYIPZQiFLOt5
         V2I0KtoUnThn4ebFj3N0hJF2bm+9K8ECu4DrqN/8NVv+sY9Cf2+wB8UBHSaxZaDlKbXC
         J1laojeTsqic7QHIDZsqqrsT+8+e9kG40weQz612ZVqlNMBYreU/r9YcTolFq1L5S5IC
         4s/ucqpTAqRLYlajL9eHCZ2cWP25q4aZ36eokR2KdUfVwjNx6WZnyL9ikJuoKTbl+q43
         5ijSfxhp2/TGJZIYe0wPBf7rdfyvti+4Ajs+OLwtt6x/lUsBy3GHU4qVyPEH8cdu4LwC
         dWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734057051; x=1734661851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GutaxVsglEexou/JOATq/TSxZhBiaRhJ64XMDJCI9GA=;
        b=pkq1WFChcAF9onELM7SUHEzpqfPxUCtB1NAEwwVPte6yJqXyvSc5ZJpZvgJBUwYNlc
         t7UnsBaMyEXyKTWr41Yiz523HQsqxjXuoPFKTwzi/8la5f5u7iFq/FGL8U1jvNivbA5X
         BqcUG6Z8aRVrlbZ02ee8MX+drXb0bQcIiUoONvJf2VWiDKviLHmaVZkxjgjfVR4Kyh43
         rLQgb3Q5yrNTVXSQbHMVnvLAfS1hms0oCdxeVdF5wRdxhMj52q61M9cEQygs1zaL7Ad2
         HwSJl7z+RVO92CSrkrgfSaOI22hcSYjUw4+hmBhwprxr38IOdtBq5/7ENQhYHflZ4Pcp
         Hy4A==
X-Forwarded-Encrypted: i=1; AJvYcCWfynUdr6nqp6J0HVq/dmfViGLvVQxHYT72cTMqQixapuhRXjr6aGiAQwGpPs1prsRl1Ezj3QduH9dWEFSc81X70Q==@vger.kernel.org, AJvYcCXYxQQKu+YtjUMa2WwIeL/Xpux1kmgMtLz6ixvnN+iMQGlM7E5+Nu+zcpD9vjjxau5U9Yc6a1x9PyHc0XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPszVJ2XW/4GYNsN3u4SQDa4bN4qBBRm+gEfaZDUmqfTW0t8eL
	A/+LwNo8/DP15Op/OXU+Yh2t4MZoRQYaiqZnH8FsMVOP9pi6JfAc
X-Gm-Gg: ASbGncuARp2ecXw7L1FuBqWiiQs+9SheAebRsCH7xiymu4oZNZPxfCT+6RXYdLn4dSB
	bFia6usb7dAnzKhrhXANwN4Fx/H3oVSasJQuHrWhbWmjcDCxfMATWdQowH+gNFQA0PkvG4KZ2He
	YHasMEkfX1Qo36ROyiwOdNXX6WSJJpe9/YF/H0OQVpXoJKtP+7oNHwSW5hTaATTOur3E3Yu+QSo
	J+39NaJAadz5j866ZnHWD9QjoF4ud+aoePF1mBcnPWsu6RkSChwW5Cv5E8wX1v4DVt6dYeH9HyO
	2hnUIu1O/+Ab
X-Google-Smtp-Source: AGHT+IHZj5IIlzAEkJQVvQlv5odyzAPZVw1yjJr9f0G8qMEJ88urew3F95r89Y1HQLaCoVm/C2VNZg==
X-Received: by 2002:a05:6a20:d48f:b0:1db:ff76:99d7 with SMTP id adf61e73a8af0-1e1dfde8ff6mr1463495637.35.1734057050605;
        Thu, 12 Dec 2024 18:30:50 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e7efb381sm8521995b3a.117.2024.12.12.18.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 18:30:50 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1] perf trace: Fix BPF loading failure (-E2BIG)
Date: Thu, 12 Dec 2024 18:30:47 -0800
Message-ID: <20241213023047.541218-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Namhyung Kim and acknowledged by Qiao Zhao (link:
https://lore.kernel.org/linux-perf-users/20241206001436.1947528-1-namhyung@kernel.org/),
on certain machines, perf trace failed to load the BPF program into the
kernel. The verifier runs perf trace's BPF program for up to 1 million
instructions, returning an E2BIG error, whereas the perf trace BPF
program should be much less complex than that. This patch aims to fix
the issue described above.

The E2BIG problem from clang-15 to clang-16 is cause by this line:
 } else if (size < 0 && size >= -6) { /* buffer */

Specifically this check: size < 0. seems like clang generates a cool
optimization to this sign check that breaks things.

Making 'size' s64, and use
 } else if ((int)size < 0 && size >= -6) { /* buffer */

Solves the problem. This is some Hogwarts magic.

And the unbounded access of clang-12 and clang-14 (clang-13 works this
time) is fixed by making variable 'aug_size' s64.

As for this:
-if (aug_size > TRACE_AUG_MAX_BUF)
-	aug_size = TRACE_AUG_MAX_BUF;
+aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];

This makes the BPF skel generated by clang-18 work. Yes, new clangs
introduce problems too.

Sorry, I only know that it works, but I don't know how it works. I'm not
an expert in the BPF verifier. I really hope this is not a kernel
version issue, as that would make the test case (kernel_nr) *
(clang_nr), a true horror story. I will test it on more kernel versions
in the future.

Fixes: 395d38419f18: ("perf trace augmented_raw_syscalls: Add more check s to pass the verifier")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 4a62ed593e84..e4352881e3fa 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -431,9 +431,9 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
 	bool augmented, do_output = false;
-	int zero = 0, size, aug_size, index,
-	    value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
 	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
+	s64 aug_size, size;
 	unsigned int nr, *beauty_map;
 	struct beauty_payload_enter *payload;
 	void *arg, *payload_offset;
@@ -484,14 +484,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 		} else if (size > 0 && size <= value_size) { /* struct */
 			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
 				augmented = true;
-		} else if (size < 0 && size >= -6) { /* buffer */
+		} else if ((int)size < 0 && size >= -6) { /* buffer */
 			index = -(size + 1);
 			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
 			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
-			aug_size = args->args[index];
-
-			if (aug_size > TRACE_AUG_MAX_BUF)
-				aug_size = TRACE_AUG_MAX_BUF;
+			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
 
 			if (aug_size > 0) {
 				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
-- 
2.43.0

