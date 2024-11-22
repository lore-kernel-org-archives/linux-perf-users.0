Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414BE159583;
	Fri, 22 Nov 2024 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250329; cv=none; b=SvTRMTPVXml/DnlSOXRCkj9K853Vkmfhk0V0mYRdwcqbQ+7PSvYftSXiof4NjZUWPru2JOaE93iIDQS9xM1IOpsJwKiucimICthEusCrcyBKgEero+oPgxjNFuumUSwfwXOyMhrPIDWMdk4D7xQhDp3tWZQgCRorDkgZT4LhhuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250329; c=relaxed/simple;
	bh=k1MvbZqv805gektgE0goJNI/HxV1JhVVKX8JGAJXSvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ8eQ42b9RRsoAHtRaVfqmehI3zt6aagEANGOh5UgmHVMST3ggaWP2W/UnrFpM+6UJk+wNjMprXyxW+0lYqySq4I0Y4BGEesXSYpihL446bNN9LnLvJU4x3YY81S7Ty14AB6h8p681B4+LXErPXsWf7WVvFb6xdHYER1YcyOC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZccF4ux; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZccF4ux"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21260209c68so21053205ad.0;
        Thu, 21 Nov 2024 20:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250327; x=1732855127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpYScqwzO6WE7u35hrRfQ2TMuWp9RDhpSIjI9CQVyMs=;
        b=cZccF4uxEsg84+toFFuJ0zTbFvLRO+/GAWt9+rFQ2wLEretW0hmyvFEGs9XI3QRwbN
         A+5yx225fvu+6uXZL5xergCGwtFMVTue1Pp+QPu2w8tzA1Ud3J2m4NaipBDc8tt1mKum
         HEUeaTUOUAmGqOw8cuocGWIbuWRhosszn7YTCEAI22qUpvEzrOU94mP9WqziAgjoP2cv
         FX+j0ngpXJldsDAyAhINETGfzUEkJ3vSot3+n45Z+MKN/EfJ7u4iScxdA0j7+97zjTV1
         okWmKCmE5+sixpYW0brbnr4oAEcDFl4fKIIH7/geT7AITKTmUUIDQIi3qp8hMxgEGcyL
         Eqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250327; x=1732855127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpYScqwzO6WE7u35hrRfQ2TMuWp9RDhpSIjI9CQVyMs=;
        b=aPYHdQZBy5VhqDcI7MEMtsh/U17/exAskjynv5vuzKabdkYgCOinKG04S1ulZwDg27
         59p0Lc+zy4SfSmnuiNW2QvUDYgmTWZ2MhR8sNJUrTRzFAvqdUaYU4gKstxqUo3/uionI
         jIywd71NmB2CKKOSM2OktukvG75uoQUyq+DBhPLFy8rx1C4RsXuWt61ae0ylEnwuXVnq
         pnEaNFYunR8WEaXwKbN/8S6JR+deKyNs2EYNDhf8aD7rRFZu5TQu4TVdzQWXVPzPLCQS
         gI7aB32Wnr8HoDMcoQ0TUplj8+dRz+iVi/xmdUEkrIoJh+JZVHIZ2E2g+YYRvvHy0aVd
         wd1A==
X-Forwarded-Encrypted: i=1; AJvYcCXMZxDDh2ZeyyHbO+lDUyBTM7VdgLYL0AZM9meIuHtwFP/PKx4ve70BUokk1HHVIAvl+4Vni2UaOgCI0o5Qiiun4g==@vger.kernel.org, AJvYcCXgCSpo1NauqcxbJWZ98AWwyCcawc5bI6MESWXU+qNeaV0AxXbECfYyEdSiexWZyOzbvWoyqzqZdO+lawA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz378BTkLClTS+pzZ56mSD7NSyk3ifabxnymQLMlasgHkP3T2Rg
	DqWqrljNmF+qbJqUmHR35QyTZcHNU/lsmlMsrpSpw/B4zcIHgEms
X-Gm-Gg: ASbGncslY0YybrNQbdE/Zaij+TYazQfhfVnTJA+P/4s9io86LtX3yC/LfImtode27Xa
	wQ237lIEaHCjktlWbOubhCr7tjMUUAPrGNzrArhHMv9IPHD4tb+HLHkb8HjwoDZXNY9Cw8+C59n
	jolf7uQfuyMymDBIfFooaq9zdjxHg6kGxvs0UVke1xQLC2pSshEs3rKDG+WBW0s/FpJ7TW1QEo3
	e86MLjxDWL0AMBgdgeEOArQ3Zoi9UCUip0sQS7ypGHAhtvoZ4FYnIpPwWDf84358DwwFmERVaAt
	9uHi5Lpz05g=
X-Google-Smtp-Source: AGHT+IHEsYXCnGUS+xbgwdVIS4PlPTbRyWdTOZh+GSk7YqOWmmy6VECf4G/ZC3wuyIrzkBW6O8LjbQ==
X-Received: by 2002:a17:903:187:b0:212:f7d:9284 with SMTP id d9443c01a7336-2129fe2842emr19204955ad.8.1732250327486;
        Thu, 21 Nov 2024 20:38:47 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:47 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 02/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Thu, 21 Nov 2024 20:38:32 -0800
Message-ID: <20241122043840.217453-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122043840.217453-1-howardchu95@gmail.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose evsel__is_offcpu_event() so it can be used in
off_cpu_config(), evsel__parse_sample(), and perf script.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-3-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 +-
 tools/perf/util/evsel.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f745723d486b..8d0308f62484 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1194,7 +1194,7 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
-static bool evsel__is_offcpu_event(struct evsel *evsel)
+bool evsel__is_offcpu_event(struct evsel *evsel)
 {
 	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 04934a7af174..7f68004507d8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -554,4 +554,6 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
+bool evsel__is_offcpu_event(struct evsel *evsel);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.43.0

