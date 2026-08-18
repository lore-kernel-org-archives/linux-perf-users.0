Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA02BE035
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063057; cv=none; b=WHOi22BH28WaXuU4WOdK3pmL19GqsLFmIF+8p8FnT9SftSxWyffmx2Fs+Zkt4UBvsLsjj+pny5MNERbUbjPQlT9mtqfc//2+PTS17osoxjqtxjGDoNsRAz/i75MBsaSwNdVBVbuwvKZSBqN6gVxglrr+lJvZwBd/JUWan+VsQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063057; c=relaxed/simple;
	bh=8vkbPx/2ctNczktKT8kgB2ds+3xpNF+OBhL9I+v3MvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSllN0LDB+RDbOOHPtVIn/HZPSs2cA/wkBCtIaYHKMZ+gGfbsJit8r8UCZfIU7FFuP0ouxhpmCtUtInUGX7gDv7hmLtg/BNaChodTYfbju5fXVDN8RXPwkozCuI45P4pgNjTWm3B+tlmaYVnjb8WSTLleZg+kKKG4t+k2cjCe/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSpnv679; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSpnv679"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf52d15d88so43746885ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063055; x=1787667855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIDmQhUNxpJzWPOu3DQLomb650ora/q49sxwgVJQpfE=;
        b=YSpnv679yaKboQQq7IMAjVyeNKY2wm/J9KEHaF7OcgkTPck6kOzwU6AerTW3kazYnY
         iWDWDeQyUY7wMMAVC7ph6S0GbmE89H7PZA8ouIJfZb8V8ZDyCQ39tEmbpfdlnvZ0WzIi
         y1mEQ8vDaXGPh8d3UpjO511qK+ajI100WERgq6e4757AL1NYkNmBy99rSrCRTdyXBuaB
         6tV/nQdviipSlWU3lXxA7oDPYTpmlxoeVC8sJXGY7P7xQfhO7GgiJJbnwbyN3cpYzOEh
         aN9tjC6fNb69DrHcCUyqUTsAPQGI6xEpOdb2Pt0n4FmCTvBlIZGrA29drWbPIT9tlHkU
         2slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063055; x=1787667855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIDmQhUNxpJzWPOu3DQLomb650ora/q49sxwgVJQpfE=;
        b=Ogp1SbFb/zJbe1ZVofCObtVyMAW4V6ykqvMmBsh3QegXNCpGGcDoiSAIagHD/oZyrc
         Dh3xnZNsSOu87ySiI6iT+Vhwm7hX9XSAt4NsGAodmu5Y8I4X94f2ijXjyDBIZhXI73V5
         Kfnfob2UaM+geUhNiREk3VtLNdv9WS2mE7sj/wu6trSTu95lDe4QaX4JjdxBDwHD7pXG
         LOAreVJqcbCv2kQM6G2TDHDfii7TqP0NrbnL0I/QSZRkitm+Oz74EoctKNGKKqhYz6aZ
         6a8wQfYAB6CKXDgYFcogP3HjwyZo9tn7Xmmo0N8xQh2mMD0n+uy/1qeQyH4CbhCHzDYT
         yFSg==
X-Gm-Message-State: AOJu0Yxpkb34KGAxJOeIIGSjACLpIbXH045UyTwPeeE/g60pfYUIhATU
	FDYXXHst7mynqS34+e8YynzLAmWsjCm4PNl1sdLVCNaLATMNNBvTdFDuOxKf4ljwJw==
X-Gm-Gg: AR+sD10mK5/LKvroqlqJMxME7Mny+v/JuVyKIiEoptSG7IZMhmxm2wW8qwO/CD1H7n3
	A58HT6YCU2pAultIY/Ab8w4mjTESz7tzeo5lX7hNg5T3+DqLFyx70bzbhjf3+R4KVZ0RStvibEM
	lEgMeaAkfVnzUeQ9Q7gAV/pw8Pc7gIX3zO/lSnXCPwCO+7viS/QKdIP5cX0DoIZcmQJNGDzLqj8
	TRPbT5xE6Iz4Gu4+xKAWjHq5Q2IGG9sySpO5y1G2/Re4hh1TAvUwJPImeETyD97uFHDHjx/Vn8c
	OrQ4ifPFltw7XhHqut3wxsfeDvsYPWs4ounWSbtn9ejeX1Z1dUXiIQTbMs+/e6MqSA+ce5MM9sP
	GeetuUIpy/dYk7Omk285nR7SJkKTtaZMbPwyRWGJyTDAp/HkqVR867mJ2Lb0zaCqD1KKhTbh/Jm
	Od2VHlWT1YxQNu4QmmzNydIhX5TqGqWENDKpwwYg47QR1tflf3iPNnd9grYH71cGcCMZaMZcHy1
	J7DBH6qw7Rws+PK5TUo3PV4JzuLxvKEufur5SdDn5zN06f4j5Wf5V1iG8JqIJjtvNxn
X-Received: by 2002:a17:90b:5450:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-3933b8470a1mr36662732a91.7.1787063055192;
        Tue, 18 Aug 2026 07:24:15 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b68adefsm6210864a91.3.2026.08.18.07.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:24:14 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] perf unwind: handle allocation failure in libdw__get_entries()
Date: Tue, 18 Aug 2026 14:24:00 +0000
Message-ID: <20260818142400.729633-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of zalloc() before dereferencing the allocated
dwfl_ui_ti structure.

Return -ENOMEM when the allocation fails to avoid a NULL pointer
dereference.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 tools/perf/util/unwind-libdw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 7f35042be567..ff36552ca175 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -379,6 +379,9 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
 		dwfl = dwfl_ui_ti->dwfl;
 	} else {
 		dwfl_ui_ti = zalloc(sizeof(*dwfl_ui_ti));
+		if (!dwfl_ui_ti)
+			return -ENOMEM;
+
 		dwfl = dwfl_begin(&offline_callbacks);
 		if (!dwfl)
 			goto out;
-- 
2.53.0

