Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658583537C4
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749185; cv=none; b=uv/ueXTJcj/zb7ezBforopB+9V7xG5ltm9Lwyjp57W+V7lBJOGLJKzLxt9I00zcaV+eJf6uxkYlTOMb81f+2qQVijo43IObCAHgI9YQdQDVB/geem2YozVYnPqdoHbFwvVW9RFnI70Z1EdoRbNBB+d1luEkPqDWAxkDR5B/Jjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749185; c=relaxed/simple;
	bh=VmqlhdFQu366zPLEzAbt56XCnrXcl+tJEHsljQ6/V14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=euRCb9jcD0EXsgRLCcIl30Wl5ia0JM1Y78+6SjP29v+BhkO+azttQcdnyxRm7yOmcMzqu+64bo0JsW9B2CyukKCZMvSOW2VO5zrgA/5qxnjnDm5823cq8iPbgPbciD18njbead/RSIznh/CdUPwrPC0o7jJ+NmsDv0rKX+8Y6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9ppRzoY; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9ppRzoY"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2be191ce356so4879601eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 14:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772749183; x=1773353983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=539R4WcAWVflmqEMddxOg3bYov+MI6a6nT4NY7eQniQ=;
        b=B9ppRzoY/b50FIBo9pKgKxo9KL8wYv+EenOemLz1UdCb5q/dCZtxoqK0kaGyqZBU7L
         WV4KO+2zw8gM+J3XxtJFaOmQNeSUAzR1jevd5tN9U9gRc6buekvtem3bNU75ESW4EOmq
         +g8Ukud7DVEfeRp5IcXgfu7kDZ7XiVWvjBNRcwKSrXbIdfiI+4lndB44XUdN77NaHUZY
         yVZxNTGs/9h+xJ6XoGd2QlPW3Vbbb53b8cfWowcy3VjF2ioDDbTtMEzTm5FDuWLv5wYR
         pC4kL4i434aZH03ht/oYVlnVTbistr2puhUmpnsgsg88GJA/EUIv2K9CCFchr0+gI8hb
         WnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749183; x=1773353983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=539R4WcAWVflmqEMddxOg3bYov+MI6a6nT4NY7eQniQ=;
        b=QmRSnIDJD3qGQrCFY2nHpv8bBeQqd4cRDVX3j7Zd2ak//UwIWIvPvSzppOL5io4ZID
         s84RfYHpFwmFfAgYauP+kt1YxDj0LZtI3bpCuns8umcfLxAOIeoot9Mtr3nst8otw+IO
         f2C16xY6R9PsIg2b0bqaM9Zue31/R+H0qMNJ0S19jDPH0D2loGcVJcgo74EvKP4ebd0I
         VMSC1F+GMDtHCo1/Ha9X+3Q6Nybjb8dAnNwvNyMOCNL6oLID6eIw1lemi80UV7jaoySp
         CEoTxzM1zhXlcswdH2nki/vCYOAg2CCaTx0wZ8BTH5/6PDlimQWOIBfWiZTjh75VGWsw
         AY0w==
X-Forwarded-Encrypted: i=1; AJvYcCWWybd02O6jAyHvaN6v/9kNVZpLBVFnKcgXREW1WpVFyjPFRwOB6oYz4Gc5yvs8pgEENxPz4qaOevt2746YmS3U@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqm0aBPLvtZG+RTjybBqQlrafRCe/dbDo3y8N4dxwdhA8SD4r
	5lqjnSH1OcPUXgml2/X73TVhzmDAQT/PfgiVZoSLoiygTlz+0yq8lJEly2hFcn4zPKbPn1TsDvX
	KC1w4JkE5fw==
X-Received: from dlbvv18.prod.google.com ([2002:a05:7022:5f12:b0:127:fa:7498])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:518:b0:127:5c54:a124
 with SMTP id a92af1059eb24-128c2e8efdbmr5966c88.31.1772749183172; Thu, 05 Mar
 2026 14:19:43 -0800 (PST)
Date: Thu,  5 Mar 2026 14:19:21 -0800
In-Reply-To: <20260305221927.3237145-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWVU3ktkGAnZQrjQJf+Z5AtQo73BVUhj-nr3H95GdcEJQ@mail.gmail.com>
 <20260305221927.3237145-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305221927.3237145-3-irogers@google.com>
Subject: [PATCH v2 2/8] perf build loongarch: Remove reference to missing file
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
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

Fixes: commit e62fae9d9e85 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
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
2.53.0.473.g4a7958ca14-goog

