Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074226A0C7
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959721; cv=none; b=k8NYan6SDb4hcHgdMEDVL6w5wG53eK+MfH8qhduGL7umLd5QDwf7gFKY74c7q7HW/W/yEEn7E7rgBJkuF0LKTBjNMF8vOZSxADlUY0uv2i4xZGAn0XERcpPXBXFem483T1nWZVe66SZtDqDUb9VU0VqsO9iB8nabcIDs2U2i/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959721; c=relaxed/simple;
	bh=n2JtyMg3dnFRI+CN9oMKk3aLsRiKCNqRLI02Htuc8WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mOfbaXLSUf5fLkNhu0Xjy6Db8XLWs5pwGpi+UKgn3BYHp6uqC8alzVUya/VUrapUy6NlD6mBNwWrL5RSB4z0soPzzEixDtKweMqJvCd4xcMb75z9xRWlBIuxo/Y3clxX4sKKsRFSJVouM1uqNDf27A6Inb88r3vgeE3jz2zKabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibFaEGvP; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibFaEGvP"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d51aed14bcso8421821eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959719; x=1776564519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=ibFaEGvPeeig4POqOmQFUPw/WVAmvEVRhKZ8/UOJuXdc+ULMuWJu0c4EapZc0NpcNI
         LKaElyr5H0vGZb6Uvd4BjPq2KD0sfRRAKCTuqTLJJYH1Uolho/JFGdCFWaYJAjpnfO9F
         z5iP6t+wU54FT1+fr03AsOxDIREceYf39fjAwr6OQe5CelR/9QGorB3/edHiVFyX5B5L
         9XBML+CW7F3/rDfK35YN6IOS08DoqqVBiD8lKv3gsUepYBPF0KuhQOdv14XrARhfvh26
         2SoHJ0xMqazt64Lslm0pFUAynFugIIwfvmWkFAhW25380/Qj5uq3W8GWQ8F/4yxZ3yQf
         toCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959719; x=1776564519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=NcVoBQInDZbqqrqeI4dmr61OIqxXrEz5cGn2pPz19WyAM4y+hijKaHqj3h1d+on065
         YHhmKRU7q8V6D6TQGTsOjNnZcGjdpKrd0S6n3qboJ7bQCTTpGvUPOSa4K9ZCOyPe4gnd
         eWDNTosD9kiQFJaimrYpUowFf2rNMEGcVgqBV2MokGJkqvf+XfRxEi6dkbzUVvxHaOIA
         9jQiLWBoLuDNaBo0DB0bCpAaG2I/ARu70LmwTFgSkL4yjINfzKSzTw1i8Mu23cOpZIGg
         j63xmdIYYq2rsIuZyNEph7cEFHDcTzg+9sSC1FABxMllCaX2KT90kGZ0rJ297gC9fmDe
         B1Zw==
X-Forwarded-Encrypted: i=1; AFNElJ9pVLImydJtJIc7iOZQbAoiMha3D2XzAJx1UlEvpm7vd3mk8KwFRt4G+K0aF+CipM1Xroi5bByTCJbW38sH7W6z@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSwNRJmhWRC6ilhA0AhHHunrYYSFs9hqtLEdGo7wh9Xzi6I0x
	vsaUD7otR5xqeL86oSJUNQ6uy5qJa2Ag+BRi8p3QMrwMN4i1n9wfFz0O9Bnm9k6fnfVjji6gwp7
	myTVli4RquA==
X-Received: from dyhb15.prod.google.com ([2002:a05:7300:148f:b0:2d1:4dd2:72fc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3106:b0:2c8:717:7eb8
 with SMTP id 5a478bee46e88-2d58965f4b0mr5052700eec.15.1775959718650; Sat, 11
 Apr 2026 19:08:38 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:04 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-2-irogers@google.com>
Subject: [PATCH v10 01/29] perf sample: Fix documentation typo
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

s/PEF/PERF/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sample.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index ca0c407c4423..e556c9b656ea 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -126,7 +126,7 @@ struct perf_sample {
 	u64 time;
 	/** @addr: The sample event PERF_SAMPLE_ADDR value. */
 	u64 addr;
-	/** @id: The sample event PERF_SAMPLE_ID or PEF_SAMPLE_IDENTIFIER value. */
+	/** @id: The sample event PERF_SAMPLE_ID or PERF_SAMPLE_IDENTIFIER value. */
 	u64 id;
 	/** @stream_id: The sample event PERF_SAMPLE_STREAM_ID value. */
 	u64 stream_id;
-- 
2.53.0.1213.gd9a14994de-goog

