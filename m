Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13280400E11
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462268; cv=none; b=ICYFd+g/cT/mk7LMfaZ0HUjTSohLsBE1XgWeIucDshkoQtOXEpMgMMkunrhiRNJjhg42wM7d5XLB07IKX0dF+WIxW7b2PQpTg4ZOHsWANwbzd2bLEpDtLYCWx882QNTFELKqyYf7aULL/cCXVAsJAE4tfRuHG6ssi7xMABicDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462268; c=relaxed/simple;
	bh=CcziqDEFRnESq6aJPL8h/5XKaif1MSl+G2p58OltOUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIwCPN8xgIdfb0Mur+yNEuqfihxx+VznDdHVaB3COj48JdmmEy5ZrXqE7OuuICiaNjcZD5f+sVqUJMJ2+49WHsODUs626WHI4vgGrV5gGuap4nZLxqcLXs2YVIiPofXCPsx/A2i7pLKbZmxtpAh/4QqROVBb6tuqot9FzW9TVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PWm9Gb3Q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWm9Gb3Q"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so7438315e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462264; x=1787067064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bA5/MBZwzPPdo+x/NUW/gcy1HnQst/utc/ghTFwGrIo=;
        b=PWm9Gb3QQzS+BGBfwnkf6erDZ5mo3mqTeBGS5LyhkS+mZm16fHlJh2Q/pswI0q/cXE
         KID8TXaluDarrMJfWt6Cnl8zxIw66Z3kzyWvz5+YuouhjnM8rKXR6VXkP/BpC4OWa2zv
         dcjK/5GVm1N/uSgw11hlOaZAax4btt76erwPq/L40N8xmymfjjeBBXA5j3uMFLiqokpa
         C8aD8JPRH2ulxqAbHkheyDJbH0CJvnP17U8wMAzPIwcVKWAeGW9y9SPC1RveIil3e5PB
         NYB4ezf7Vsms82VcVb4/gibaPbW2CFRWRkGPyUZknstdwsJ+59+FCB9DiJ4mLa4iNrix
         Safw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462264; x=1787067064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bA5/MBZwzPPdo+x/NUW/gcy1HnQst/utc/ghTFwGrIo=;
        b=YF0cYOS3k0/ukNf0eSOiwEsKptd7B+zlXL0ZCx2VjNh5S6MyAULoHfkE6gjTp7/deS
         AatVXo4QpJ/+b11pZmtRWYjvezk8Qs4kuuT0GRuLOPKfT2P9AuR4c4/U4A6ZixzeNAAW
         NkXp3mtiNUJAZY6lZpreWLYOL3euLOol7faYbJ/ZFZ2uoWWHi1q820cj043/0XUNYNIO
         AnGqVzP3H6Tyx6pmVyuqYGL8VCrSYtkYGLc3tbBUJvgMPfTmaRg4p//sWQ2Fu02UicRd
         i6LRLYOUOoH9gzoGHVhH1GaAk/Yj7p/kHsYkJDtHmDnV1MKVkDVhkjaK5mFpPsS6+9V+
         GyEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrweAs/F2MSh+5EjUL3x/PiF49AJiexid0sHb0Tk1bDgdK2XPAjwGR+XbP7L8eZfRhKLHfmIxvvutWbKs2HB7np@vger.kernel.org
X-Gm-Message-State: AOJu0Yxennz+WyLO6gK3FWiO2UpH5gBPKJFL0Yzq7Lmsg6sGZH0zF/9g
	N/Yv8/STz1Mc7yjai+z39xDDzjt0muEm3GDZzuuTEe6L3+4IHOgmYWReji/G/3vSG4Y=
X-Gm-Gg: AR+sD110Cq+9auovAJvNo+qQ8YUkvWIIq2ZGxEJdxTzcQmUTzP/varneEaw1t1tqC5m
	4AcTsZEQq+AriyIjD4c0To37OauC/QnOf3omLW7Eq9fU6fwemuXh3fiZ/+zvLNS62ViMpkGq0X/
	Qt9BHK//YhuHR+5TdlXndT/t/MdH92SzhXvV11Speaf7Sd2iL85oXhiNnL2UZEC7tYnIwy5K1Te
	HX5OHnykqmdeaR7vB+mDZndstlKAGou63W/JoQDyeuIVTRY3ydRJQSoDQzmFeqDxA/iMXa98nCt
	FM/cCXs/FafzHPTwogjNNa69ybc2H3jKeEqvtq1KRVhnclHuzeXDsM3pJv4YZOiQA4nG8o3hRfy
	r0pfdHrQ8Q0a/QYLDCt3jhhVtAur94WvV0h6CjkGT0lfAuBvJ42Fuog3KhZRdnrTYWoCybbZK22
	mcTjPGm8z7iN9WYwv0KMNHP184F55aJfPI/VKHKxORN4wYrfbhVofkvNgcZXtWHhYX
X-Received: by 2002:a05:600c:310e:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-4997a6e5226mr11138885e9.1.1786462264095;
        Tue, 11 Aug 2026 08:31:04 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:31:03 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:13 +0100
Subject: [PATCH 10/14] perf cs-etm: Don't print missing buffers in snapshot
 mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-10-90565318f5f8@linaro.org>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
In-Reply-To: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The driver produces lots of AUX records for trace data that was never
captured in snapshot mode. Downgrade this to a pr_debug3 message as it's
only an error in normal mode.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5bafee31cf4b..a80f34530917 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3317,6 +3317,9 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	struct perf_sample sample;
 	int ret;
 	struct auxtrace_index_entry *ent;
+	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
 	struct auxtrace_index *auxtrace_index;
 	struct evsel *evsel;
 	size_t i;
@@ -3370,8 +3373,10 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	 * don't exit with an error because it will still be possible to decode other aux records.
 	 */
 	if (!found) {
-		pr_err("CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
-		       " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
+		int level = etm->snapshot_mode ? 3 : 0;
+
+		pr_debugN(level, "CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
+			  " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
 	}
 	ret = 0;
 out:

-- 
2.43.0

