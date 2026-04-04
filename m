Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A818377575
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775281253; cv=none; b=K+YIRhoLqT/X2UztKVvl3OhYbes7P4ZAnQSl3Fo/qy7mJwC7p65NmUrvm2Xg3wfvw3gEa2BoCVHnVE+kWam9S7icSAFt5HBZvWO+yCVQg0yHrQUsYuw4kHUz9asWqvVu173ne+ejujbOhGHFRxHhbLDt7Gl8El74ITlkB4quCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775281253; c=relaxed/simple;
	bh=JeSLyEyVbGrzHWl/OHpa8voq5Wa/zBgvBxLzEbB0v1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tVMupZLVibdw8B2rtZbN5hdfLZjDXfctdy7r8k72mRg7itSds8Rv0SfVPSSKk1IHWHd4CnsEuvdmA03mxRMAkXvHaBPoTeoygdTBXye4CToD7CKNqIrTCxoDHZHH8tHPSEKVJt4zmrz5mzm85ThxyQ0Uq6rS8ZKihQjw65bF5Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjAHrycn; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjAHrycn"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so3049526eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 22:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775281250; x=1775886050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gq5oV2Uwm1Ltd6b9FECKA8ZBvmmiMQwyALIUU23nRA=;
        b=JjAHrycn4fc6ja+N0DsbhrcZ/aXewZeClhEaFXRD0+YHy0uXngW4fEbRppTZ3XE0EO
         2wPKp15PF1UyzyBQ/MEbcRoF4m3UGhWZD4b1xz1AEqR4v0O5XVTnxZs0Vosiwn5m4Jsq
         gRj1S36jInBwSsQEOanAr2jt4s6s1KNyn+IbAhuOpABzYiC3MuZWTqvRfR6yFoXYsx2H
         yTjYmYXxuSC1Sj4uE1hjwJnxA9Vd4f8dBcR3updsMwj+f4Y3v26WlybKlagGFaI9Jor7
         R/+rwhA7WKGkZDk3PdXwnRiqJJNU95KIEdjCy/GIGi9Kqd2LzGcaZz8RSo0H7c4pSBH8
         Ehdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775281250; x=1775886050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gq5oV2Uwm1Ltd6b9FECKA8ZBvmmiMQwyALIUU23nRA=;
        b=LFPqRZmoaINWENC9LuA8i7gy1vtuF9la60kPXJBjlKl+R6Vp1yiDJ8oXQgyi/+Dg/i
         0n+zZ9xDqK3hy0XIFAwt1d1AUiNW+mI7ySs6FeHxyx+cu+v4C45cLzCg4++byvBpTVnJ
         OKVJoBkKQvSFG/4LhJMSrs+RQWbhLK0z5u6uTYoZLOIBY6OXMWlUWqhsu1VDLCH2CcdS
         L9tb9zX67DZ6SkbbSGViFV/cNXhgRfzm/CAhvPRzm9nMUtDsbGnR6c6djfAV+qNC6Sca
         RUVL2tYa8OB9wJWubZyqEqiFnBq0WXL8KnNYjHauE/Q8hH9ZlopLDKeZy8Pl5JCOkoxd
         rGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrn5Q+TYJxDP49bsGgUB/DM0aI1a3jYEwL9j0UF89+ssM2tLuhyiNJlcbUHbBBUatuCD/zwMCCeiTr8O7GD5og@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BalsIxMq/gPZ08/i9pfT1gzC+yDBLPBv3YhvBSMHvExYOgCA
	YOevPbxEHWPJgfoBjL58yVgOWc9qCccYNQ6nQRHQhU5UY4us7e+IG2W4GCg6D4nOPmNuMvotj/F
	t/XFOGqAeVw==
X-Received: from dlbuy23.prod.google.com ([2002:a05:7022:1e17:b0:12c:5db:d6d1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fe08:b0:128:d577:dc21
 with SMTP id a92af1059eb24-12bfb700f3dmr2718425c88.13.1775281250318; Fri, 03
 Apr 2026 22:40:50 -0700 (PDT)
Date: Fri,  3 Apr 2026 22:40:26 -0700
In-Reply-To: <20260404054032.1538095-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305221927.3237145-1-irogers@google.com> <20260404054032.1538095-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404054032.1538095-3-irogers@google.com>
Subject: [PATCH v3 2/8] perf build loongarch: Remove reference to missing file
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: irogers@google.com, 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	howardchu95@gmail.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"

The file was removed in commit e62fae9d9e85 ("perf unwind-libdw: Fix a
cross-arch unwinding bug") but the Build file not updated.

Fixes: e62fae9d9e85 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/loongarch/util/Build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 3ad73d0289f3..8d91e78d31c9 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,4 +1,3 @@
 perf-util-y += header.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
-perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
-- 
2.53.0.1213.gd9a14994de-goog

