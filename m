Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246663CB;
	Wed, 26 Mar 2025 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019089; cv=none; b=A+rPTVdike5jof2lMdVwoGA2u733LFeU/CY4b4N4t1w0nU+YQSko0Tp93+qPqivSZGuOdmng0lpWx+SZRzPxrQS8NhOsxoCGG16zN6MthVUqAd8y2jGbnQBUA0q7WxFbYo6fvIKnm+3apUIvhATZ/TlhwMoczXlwGkByHT8DsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019089; c=relaxed/simple;
	bh=cnnF8YwXc3kNePxw2hcgk6nQOCjxSdYljW7QRm3pbdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spy6ZMBb/0aFJvRcXrr/BlVaEQvQmqArzRLi1lv7DQo87fDX68s8rvx6jSocjL890caFIJlmi9N9daBe1E2qMWdOgk65atcTPsKrmEjc+6N8eENp/mNS6SjBfhfRAR96bDmADWXVOnP9/r34MTzYchVt0aeedbPxZoqS6NZSTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2ouwNU9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2ouwNU9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227b828de00so5324315ad.1;
        Wed, 26 Mar 2025 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019087; x=1743623887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94/hsm05gbOZ1gOP8w/7nLNNkppkAVjxG6Q+5hmNpNU=;
        b=H2ouwNU9UG7nAVTftMxG7aF/qeH7TlCNqbevQX4JRhVFBykX7+dY/K2DKHXaXaLPC2
         BjN6i0yU3V6XkfMVqv/j+2/FxUNwt3mJpRbPE8rgxk7BntQywZObcfrwHlnNjRJAptVy
         oEfrMZbz8uAUi5ub7FiPj5ZWG723Lg2Ai1EX9DqHDIyXiGm9kqD5Mq3Q+cCQ1H3i/qVs
         Qz+4oqXmtQkdbL+JTLDXiIucrWsQONJuUMSk3TTTMFAE1Nzg8VFMprYqCYcw1fuY+A1W
         8/2yP7HXEBi4AEo0eRXv/CWY0qMfXb/hRHq8m8OCd5faE+8LFgJzak0ADzi2ho7gihvA
         bLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019087; x=1743623887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94/hsm05gbOZ1gOP8w/7nLNNkppkAVjxG6Q+5hmNpNU=;
        b=RAEcgsvI8jDqO6P06zXisHPLIRzJUXHTflhHkTkvhH3em+hug1MNb0RqWneaG8pUxk
         7cgfpqUlL/9xaaKkIrs7/kCIYqupRRLlZSqXBXHuBijaKFKDSPAMOlhKmUgvrcTWWBDZ
         +UpfXiDXhWr8YZYTGgJBHswn+yG0c8Y8TEpWJ5K1jbx37OTzwsgq3VRFo4pTEZUSjz+1
         lzPIjCEyhIhsDD0Mj1vdegLnJhOHXbX0eRuWfczYegY9zJExEjhHoQq2+O0LoIoOW5bP
         dyL3IPB+NcqLy1QXldBH/bunYrx97hLEpjundfr2aSltmPcsCWx+oryOe3VxqSXV/S8z
         UXcg==
X-Forwarded-Encrypted: i=1; AJvYcCUGd7n4+dVNaAHyDeBxZYhVQj220rhEWyi9/OUChHXu/P2BB+/2xMKT4OphCEvSJ41d8a+YP5iHvAlzlvo=@vger.kernel.org, AJvYcCXbAhGHUt6sJn4YUOW1+DnaPlSdrX+ovfSvoY9CCP4Xtr2V6g62NCpiD72d45EPWurzlSKKCUsDpf/OKKr/SDHUOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwikDkJE7rMJ8ZssH5I83t6S+MEEOa7Ycqte8BHTHnXPRpddh+Y
	eqild7qq3Sa18uoWQ4MeeoOK4Z/PdW4HIPAoT2Y2PYEfBmSchF0d
X-Gm-Gg: ASbGnctHzdtimimSjwNsoNoD9LwjcIOjHU3gRf84n2qNWTYkEaUPKJkL1HZNsMJ9JQ3
	/Lco3xi8L9jSlHyzcTKpA0n9/WalJGSKBr9k+f8eXecKNKQ/OfxLW7L975f8nq2QFwqtBBKI6ho
	2l/Msv5e6Z2AZaxYUuDK2z92m7cKvqrYYY3y6UGFFUSX4ET8/eAx5EKthLDgv4a9Yl63FGmIhUv
	xCt37vMPIrrQhuE8g00ynxnN/cGdtDcTlcbZikIK/aFvI5jBjRYQbHnGCeVMzCxM92FO11CMxqM
	h+9nPAep2H+UjOOoDHXqkMygIwA0AcxNLeWwbS1c5g0RgYaKzXe4E2ZxWXYhD+BoKArfwLTkaWh
	AXf2D
X-Google-Smtp-Source: AGHT+IHjxGXQCgm4QMy/i4oVktdD2BaG4w7WoG4F+QMs6cropxlWU96uEB7KuJWxHA1v+vHPzW28qQ==
X-Received: by 2002:a05:6a00:1914:b0:736:d6da:8f9e with SMTP id d2e1a72fcca58-73960cd5ba4mr1346549b3a.0.1743019086876;
        Wed, 26 Mar 2025 12:58:06 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d7d4sm12649972b3a.86.2025.03.26.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 12:58:06 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf trace: Change __augmented_syscalls__'s value to int
Date: Wed, 26 Mar 2025 12:58:01 -0700
Message-ID: <20250326195801.1837855-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to match the type of file descriptors, as suggested by Ian
Rogers in this discussion:
https://lore.kernel.org/linux-perf-users/CAP-5=fU+9EQKT2fOuBQ5ds6s4Bh6rWrvco1ow6B-CQ92XuO1kQ@mail.gmail.com/

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index e4352881e3fa..18a3086489ea 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -31,7 +31,7 @@
 struct __augmented_syscalls__ {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__type(key, int);
-	__type(value, __u32);
+	__type(value, int);
 	__uint(max_entries, MAX_CPUS);
 } __augmented_syscalls__ SEC(".maps");
 
-- 
2.45.2

