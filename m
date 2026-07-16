Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69438836A
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176392; cv=none; b=PvH8TbcPnwXK7zvrFMPdql26b+PcaftsI3aXhdDCY+Gh9UU9p9EB9IUBQY+m/SE6/VxLeG79Y6B85YtiPSKFK4KruuFhk1tN50F2VQVDh8wN1F3fGERJpQUBp8495bd6V7n9etxZil2SsOuIKsSJlWaE1wzV7dnz0KSE6updTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176392; c=relaxed/simple;
	bh=We+b1fByLnDgUIDAqu/HeccWcKu5G27hVgENOtZCCXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D9WHk505GpIU3FGWK0E0PUIvSG6wFoak1Eh3OC6hmpX55urtM/Oel3zSKdneGyDdGQi+Psp82urvKus4gG1wx6NYrCaq2AlX/dn1/LqlKz9IFMaCRoidrkbFOA6qNiERitWxBp6JNquPBGWLp29s801vtdZmJsl21AvaKI0/+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vw58IPcF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vw58IPcF"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88ab059052so266642a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176388; x=1784781188; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFt2EFIQw9Bgq4BFm5b6OTBYmlNpBKOowjzMhZ8MjQA=;
        b=vw58IPcFO05lUyDf5zpQmV7q2E9qOoq/SibYUO4H/mfGJHcdC7SYyTCNDNxbIJ98Wb
         OfGfEkzsdkMccAe81EIJ6O1NkWqxV3Ttv6OmA/Q/S6V6N33EZkA8jRqQhW7jjCDyzX3R
         ciPq+E2szeDBDZfb3m2npr2EMq/sjd5Jk6ISAzitPWFr2/ni45gYOZkx0iUwS3M4DEGn
         779F276TkY9kAfEl4kA+Q4YeDpi8l/oOPEotHYGgontsUs/XE0JK4DuMT9EJTmCl5j/V
         5UZRFcM1CrCrJj71lpAqgNFrACrWK4jWA1Dwk1BeKHTZSjuWVTF7PYEAPcTFHJ8Y2ilM
         InDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176388; x=1784781188;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFt2EFIQw9Bgq4BFm5b6OTBYmlNpBKOowjzMhZ8MjQA=;
        b=czhzMAzb6UbhF40e2GFtxqvaeMubCEtZAnb68AbuUvHkLa0mb1zZuMODjex9VCXX8j
         cLAROm2/KOJxQ0Ic+PwhXrJnWrNyYaCjnukdN/kPPdCOBGuFDVBZ+CDJWFdjEca/6xri
         0fe3P467L1TTHl4LWHWSNH9tLKxzDPDTEfAMfskikp13h2lRdLx8chznXHM1g2FSCtAx
         sg06IkczUaUkrLuzQ107WXXmJKYsEan3F9dBCR64PpnDbUesnr+W1HHhL28JkL0WoWKF
         AJ6a5IAev/HwfamUPu0V+skNokps2snq7mTzVKpGhFTPcQdYUnFFSj6NpzOM4NRQvYa9
         8bsA==
X-Forwarded-Encrypted: i=1; AHgh+RqDTXGKHt989Agnt4GhGHWtsm4IuVbIyQVoxlQ0XOi+SWTCW3OApaKZHmND7CewFYux9xAvHereV/espwTZuw/Z@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaz6YOkcXEgKf5MuDTCHzVdRZNUa5pYMjryR+++U3RrMfinB52
	jUpG/4rLOynR5rBt6ko1ZEkJVGuDok4nk8VBEo0QgXJi9FWqDx/zC98/brebP1sailJ5lXMnF7C
	fcb1f2TV56w==
X-Received: from dlnn34.prod.google.com ([2002:a05:7022:61a2:b0:138:106:9053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728a:b0:3bf:8230:1b71
 with SMTP id adf61e73a8af0-3c38db35551mr1181870637.25.1784176388119; Wed, 15
 Jul 2026 21:33:08 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:15 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-7-irogers@google.com>
Subject: [PATCH v3 06/14] perf stat: Extend STD output linter to test
 metric-only checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run the
metric-only check under the --new print flag:

  - check_metric_only

This guarantees that standard console metric-only outputs produced by
the decoupled printing callbacks are formally validated by the test
linter.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 0d38a1283967..69720b19b908 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -134,6 +134,7 @@ then
 	check_per_cache_instance "STD (New API)" "$perf_cmd"
 	check_per_cluster "STD (New API)" "$perf_cmd"
 fi
+check_metric_only "STD (New API)" "$perf_cmd"
 
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

