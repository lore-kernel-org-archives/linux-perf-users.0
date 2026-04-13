Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD042C21F2
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053525; cv=none; b=MIGForB+0YD9AOPNzmEVdEiZgLQbb3QZgl0AhB32Hxi3y/2OGaAd+sZSvillVtb1QFxJdKtEPc9GGOsTSQjedaTKYeaiWxdprZix3nUHzeNcs8lmawh/+8z9TVKES+8Ne7fS8Mq8EelzQOcWax23lb62Tw8Tn0OOXLj1Lem4B1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053525; c=relaxed/simple;
	bh=n2JtyMg3dnFRI+CN9oMKk3aLsRiKCNqRLI02Htuc8WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VCeDI/VzWFhEJ5fOS40oDtY/3h2BUEizv/If4GcyH0vJHGxFqUJg9qy9Rud6ZHbKzqPyT19ZDYoOoIRE0o7AnO+L7o/m+iU5rzwYbJLjr2VeDKxP+H8DJSj2c6BWb7Ks9e0hcO3w0Tddtb2/5kYyQediKzQuAeukiMbMwgcoCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1egiANn; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1egiANn"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so14277894eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053519; x=1776658319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=v1egiANnu5TjJtRUAQ2b7gbtVrQ3VdA4LJkDugUyUxekXeXo0z3KUtWWh8ME6SYG4K
         JEh9w6FzHtCfDGeAxKdsg6howt/chOPNZbP4mvmqXBAecA8zFBLWPfbZAYZksO5PpMMc
         JsjFGiix7vOfYytYoTt1GgXHjYhcm2B4fBBhFbeHl/YPLnnqthEP2xV2PRZISCz1pc+U
         IArLsIWWRtVLqKN+sBB4/cQlxIghNgu4O0AqnhUzhuW9G0WZ2n9OtI7y1vnzzWaeaZtY
         kqT9ggKBI5ePKzBDFW6lI0hCx+hjuR552NHti/rZBQVhrGz9meAxjYOyVfCyNbUOaouq
         fygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053519; x=1776658319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=r7ebSbyzHSIaL5pST01naC2ZcapMYBPh+y92hfraH2RioQms5fZwVeBn8evkkyF9PT
         +ieH5JCCr2HRLXgCPskimO8JKJgvPCBM7qxfP1sFQg/ivFDuDcZswHaV4rlVYDsPBCws
         DD4vjhnBqy4LEO6KDas38ksmHfhH5qVGXHnE+jkCLqGXXaNDZBrIqe1eQDb+ETkEyyJp
         V8aegRriS7C/+mNdPa+zHjUxNEGTqzneMQUjgv8UUkcWf2v3Pxoxgm/0rI7dbpRA1bAL
         iITldNCMCL9HUPlorbj8q2zIdGddaVVPahN71g5PdaMTPW1cjkYcZwA342T0H69axoWx
         oWVg==
X-Forwarded-Encrypted: i=1; AFNElJ9nlBw+AjwLKyMraaluCWnhB/uQmalWUiDXO3JE+z4sZTlMcIMOPN9TUCwSPAxqH6im3qIhDJSz7aE5e6c3oFiW@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQyiuefRTXOTafStZ/kT8uZ+Wx+dglnfvVwKe7m3NjuC/4ZAd
	SvLuvq6DPKoGY7l8ChsxJvr4+W9WAxNAbztzGMO8nVciK3nbhyOkmfwKNbdVmWXL+psYEllpRlF
	RAtkq1ehIUg==
X-Received: from dycnl10.prod.google.com ([2002:a05:7300:d10a:b0:2d9:6d60:48e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e614:b0:2be:142f:d499
 with SMTP id 5a478bee46e88-2d589463d7bmr6511387eec.16.1776053518582; Sun, 12
 Apr 2026 21:11:58 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:11 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-2-irogers@google.com>
Subject: [PATCH v12 01/33] perf sample: Fix documentation typo
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

