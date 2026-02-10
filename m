Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B332D7FF
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703453; cv=none; b=nrwiz2h11d9uLyid20gWG8Cfbyyzxvbg8O5cxDX0Nied+VAHOySKhH2V4qN/4DoZkrSTBEfNr7Loken16P8bgccX3vophqVdQjJBbJazf+JkQ0VrOW+Looo0qA8GPFk/jjyhqspf26kpbBNQUsfvTRGknkE0rG1cyM/JdtcWzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703453; c=relaxed/simple;
	bh=s5HhmH++c0S6/4eaW7RJwAr9NrI5mDPAqNzC53KKvuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r2xBfftDKDgOHzEOPLdGjNUo+MeVvM8lZlc+tBJE956c+e+GDG36JssaZ8i7YrIrXYf59DvnZ7DlUKsZGxpK7QWgPOd17S74jMv5d44l62YuoR7iEhJ1EYhjDqlLwy8j+dZNOnV3oTEtjgXWqOaLeQY4CiRa5qB9JnQ2qul3bRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gFBxoVym; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFBxoVym"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124a2d3d1b7so3524029c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 22:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770703452; x=1771308252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=grVQSNoKkwDwm/7kB0bTBCG79LQ7uooFEeHk2Xib8y8=;
        b=gFBxoVymYUFP6MTggINmDFqhr7Dxmb0Cyc89UUK0jKZN4u6WBZ5T+UBlGxJRlzLgQ5
         Q037GTUaiecvSekhF1KRU4F7kaOIrNWr1zsX1CiBVuF6MwVTTrJ5706Y5zhhn6chcj2M
         PpXWqYnrmOB6UxPQtmswpAh9YtuQpjsWt0UqMO5luuwsfUWQ8BM1NMTwqzNXPLK+9CJT
         7XF//sNuZ35hSNuD1QANDTBBr25PWUlgnSefO6Qv84InZlNyA71kmVCsOUhFe8coZ+Q3
         yH4wdXETK1TE6SgfuNC+o6g/Wzja4+UlkMTMivkOER2Qve20VwX/8nBM+fdGETk33rKI
         hgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703452; x=1771308252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grVQSNoKkwDwm/7kB0bTBCG79LQ7uooFEeHk2Xib8y8=;
        b=Xg9RwZqz+nxqzD+pUj9Re0G4SK0GRIyrY0nn1B2OuzNaWIJrzYOVasnEaZ0FkSzRAy
         icza/mgRDbsse5XgHEIUFva6rqD3UeBDHAbJW0RFeKjiaQ3dSAJGG58wI6q6E/IZ+tNd
         FRTLydTlQ5eAQSayM0JxSm2qxmnkZcbgMS4AuQyjtBOVM3ga0/e/JnCYAv4ltGRk9D0S
         m20gyNhbEOvTjj9zkB96DEaJV5oluz105yQ8oLWXBcszvZqWYnAeRAc9nx25zffdL30F
         DrGdbwkFx2JYnB8t/+zUvy9GcvrcgXBXOYt8S6f2A4C2hnfWajFqT76+Kbz3j9ZC8gXo
         P2qw==
X-Forwarded-Encrypted: i=1; AJvYcCVTklkzVfR668ykkvGYurlDhDN1M41cb9vZuKq0uTDUfKx6badhccYIhoRo9Npm1CaJyumxAtDMQfdWM1qNPys8@vger.kernel.org
X-Gm-Message-State: AOJu0YxQb0sV7ROdfTZkvMXPR0O0o4Ndw0vZpccPjcixvYcANSqomX9F
	8/D98JKw4uiuu4u+5uCVV8IqmWw+tpfbcceJiv0rt5HK7bWAacTzrHn6FVNMr3XE2kGTthQGL5/
	xBzIhCL1siA==
X-Received: from dlnn14.prod.google.com ([2002:a05:7022:618e:b0:123:291f:3e5b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:418a:b0:11b:d6f2:a6d6
 with SMTP id a92af1059eb24-1270400c96cmr6603757c88.34.1770703451966; Mon, 09
 Feb 2026 22:04:11 -0800 (PST)
Date: Mon,  9 Feb 2026 22:03:57 -0800
In-Reply-To: <20260210060359.2233425-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYqHTfCoW1bGmJF4@google.com> <20260210060359.2233425-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210060359.2233425-5-irogers@google.com>
Subject: [PATCH v9 4/6] perf evlist: Missing TPEBS close in evlist__close
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	peterz@infradead.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	yang.lee@linux.alibaba.com
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

