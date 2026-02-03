Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8959737BE84
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159110; cv=none; b=aocuJZ73yjuXLj8QZNm2VVJR264XsgssMTpw3OpH8xC/b0BAiPueyzBIUTDToSAW9Fot6KtV4fujTblfEXP2wVucozrXfReJoTk2Ul4cH9EvGnfpDUuWT4j6nb5AmBtuuSe+prl/ElS5dJnywCAl9A8T4Gsl0xdD3YrTI56zfwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159110; c=relaxed/simple;
	bh=s5HhmH++c0S6/4eaW7RJwAr9NrI5mDPAqNzC53KKvuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QmugAFcqugK4M/dVc7vBjt+mmv9bsArbnsM+AEjbPmyuxrFu7jTfJMUq8Ejl23RKhQa3VuQxdsiIKT5LL4vhBtbEqIbLm1aWNDkqlxolu1Ku6smrgdPkmG7G7Is24AxslchjR5zCw69Gxg1HB/MIv6grKaQKWPeT+Qz6FaDaXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8k92nB0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8k92nB0"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-81f5381d17dso4927298b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 14:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770159109; x=1770763909; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grVQSNoKkwDwm/7kB0bTBCG79LQ7uooFEeHk2Xib8y8=;
        b=w8k92nB0s0+se+Jp7/IveA9ik0+TxcfwI0nCBamCWUQXiSwP+OqC3zDSGo+rhus/Y7
         yqf2QrgY2xa2jIxTxb6IOgZxwxJdC4gpZlLt46LpWmY5KnYeRoK/7TXH4f8jsWrxuCNc
         6JSAREjrOkmp9JnxBcxS0TD1nQIPRRFSxE8ksHHqSUevy0bK5RCJlCg4Jv6al9LI9KEC
         7uAVtFhfbuWGfd3xtEXX9Q1eegZxxX7COnTSS6afCpzD6skuZGrkEAR36k2bB/BjqkOC
         p/0GFtIpMjNV0JTzjgNJbmTHgqrvxQh0SXpSFhLCwwa4LFu2Oq4Gow88UIb+mOimcTnM
         2gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770159109; x=1770763909;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grVQSNoKkwDwm/7kB0bTBCG79LQ7uooFEeHk2Xib8y8=;
        b=bw+wusbKfDWyCKsjMkkBpfRmKa7H9XdqedFSqIB+7bRf5ee1Yp5VfdL7r+8EOT5QGE
         ye5q9BdCbDs8qmLfqig9ipYQWTs7hT/btbjOItVIgtQUjMYLFzVogu/726Pt8DhSGtk5
         eckyfBBfVWIa1WzI85GX55ochlfSKmDd50zfwyYnskoNwVrmyJtGH/VoJd22y3uGdm20
         uJNMnKztxjs1wYYS/EsN+M/HQXb0Y9HF5xf/UjPvibpCqZu+up/dlaNCOdEAczjsjtXA
         9j+GIZHYuVs3iFsM1FNL19uXnPJ6ioRdN3or+pjrGh7avEnS/2kW3m7Vtn2wHeb0Nlmq
         mL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKQRC1xecgRbGxwuNMyun9Pu58u0DFj/o2Fwy+g670zRQivWv01Pajlsyp6cWxrvf+hVczM9rTabBQV9JjyPBy@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+IvsT8xztnHNYXZMvn5zzjcsyeT5nTrtYx23Peg3iVMPZjEd
	pJZDE64KPN1irBf1UD6ViXO4ojhXELNpoOlcRGs3jdT/8aNj92oaQaid8d3z9xLPZF1ERL071tb
	UINeDr6kUQg==
X-Received: from pfhu26.prod.google.com ([2002:a62:ed1a:0:b0:77f:1f29:5399])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:138e:b0:823:1c83:e4cb
 with SMTP id d2e1a72fcca58-8241c694308mr956635b3a.62.1770159108788; Tue, 03
 Feb 2026 14:51:48 -0800 (PST)
Date: Tue,  3 Feb 2026 14:51:27 -0800
In-Reply-To: <20260203225129.4077140-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203225129.4077140-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203225129.4077140-5-irogers@google.com>
Subject: [PATCH v7 4/6] perf evlist: Missing TPEBS close in evlist__close
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Andres Freund <andres@anarazel.de>
Content-Type: text/plain; charset="UTF-8"

The libperf evsel close won't close TPEBS events properly. Add a test
to do this. The libperf close routine is used in evlist__close for
affinity reasons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3b0d837e3046..3abc2215e790 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1356,6 +1356,8 @@ void evlist__close(struct evlist *evlist)
 		return;
 
 	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		if (evlist_cpu_itr.cpu_map_idx == 0 && evsel__is_retire_lat(evlist_cpu_itr.evsel))
+			evsel__tpebs_close(evlist_cpu_itr.evsel);
 		perf_evsel__close_cpu(&evlist_cpu_itr.evsel->core,
 				      evlist_cpu_itr.cpu_map_idx);
 	}
-- 
2.53.0.rc2.204.g2597b5adb4-goog

