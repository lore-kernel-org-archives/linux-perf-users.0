Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154979;
	b=Rn3YJ2rsn/WgM7U3Ni1csoA5RRAxm4RqY/n5fksQ/sXL4buflXuUQilJupylZJ0POyR1
	 QYW4wAH75eoqTm86QriQh3gYrl77gLwHA5RKj2+FEqujGzozoDmRRIHkPGdZM4lj60q+D
	 Z15AwoGC8Mcqo58SkuzrW2N0j8KqJMxXswYsCwLmBIKTCHXNse5nBy9YcwoXUHwnfg4Sg
	 KC79eJulKOTv6zcYEN292yoGrKTnqBZnTaLhwLqRjnJYsMNTudPPXOIwLbxNdBV67akzM
	 /67woM0evwAOR7EbdAWJDNSvYl3SmbWNPOby0P5X9ibQycULt3VvJowwRMtYp/3M7Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pazKh6DOiqyGRyM8W6LynGdwm0L0tbIyWQaJbyYaTnU=;
	b=VwO6WmtTSx8gTarF/Aj4OuXcd0cj+RZId4r70+lI7U7V7XcQ5sKBkiefsef3/YXlWlv3
	 hH4ueMEaNpCbl5mJlVS1vg0UCi6phow9oF6RzcVuIhD4rxTmd8pZs+DrMRN7SJMqVnaFZ
	 Vod/D38ReKEOXsiepC/PrHNRNTfBxCD7Ioa1svV7ESVbP0oflLEnbc/v3afrFao8LcCso
	 gnjrWsTyNLRlJC7xvD+nVWv+0CK+Cr05HbAl3QBgoBqunNMsUtYPs2UtqAYhIjv15IvHn
	 8Rg+JE7cIUMLic8u58AExFlD8cXirNFZQzvWORXWtxdRnD80t75L+Hf8/CS18/cFiQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T6iJuHPR;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B421606A524
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 06:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B421606A524
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T6iJuHPR
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38587f3de36so572476eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 22:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795154976; x=1795759776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pazKh6DOiqyGRyM8W6LynGdwm0L0tbIyWQaJbyYaTnU=;
        b=T6iJuHPR/Sng6NdMz5T8pKivDBJYsFFYVpBjArLgNAckPgMMnHKhx40t2YMTRhEYtx
         5rVoDcRcWwvo0B8fDLqdGO6nQgM2DAdXnHsWbSUVv6Hi+r0KJqoCdiAv8uujCBqr1x6f
         dX2E9ErPPMxyKkpu4R4FLnrDK3ZFd1sQxHw70gsxT74MrwkDOgalG8+eK7qWKElhaFV4
         Gst1n0+toVruNTU9zNlJmY6VprlDqC64zEOy/69EeSk51M/N5cc7rl9WygeOVqUJUpUl
         r/NcRf2nZVDOmK2iMi3erHREloz+1oLgTOn4KU75TxLxsXB27eR3xpJawbhbyGE7H2bu
         3LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795154976; x=1795759776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pazKh6DOiqyGRyM8W6LynGdwm0L0tbIyWQaJbyYaTnU=;
        b=t8hyHY3QnwPaCzt/aWZ3TXbeXe/GTO8iW8uIT3Dddv7eUNdrz544vM36MLQKbTvmDL
         ub4an0IJL+NAB6Dm2CWuGLg8YnRCYJs4o6Fa8ivKOwXgTQCBnwbUrJeQWLGM/7ZgvCgM
         +NVxPB/v8fPNZcCk9CEBlzMzuw2fm74a7rvgiNV0Axuy38CwcOt0zfVi22fHDaJYuesP
         bR6W4nPZ5P9g8fEuJBvMUHK31fEnHl3uAM7cCZy67MwgrFX0sEJi6StCDSwTDuuGxLof
         1Q3fc06jEa0P47stUBgAx+CQY0SVeDc4vg46Fk+EQQT82+eQnPngz32Y3dGHAESyY0qe
         c2yQ==
X-Gm-Message-State: APuU4Z/4Z39dAg19Z88oa0mwjL+V2EIXMtlXHGffqyyfgPSZDhT6nit9
	VTFP/vKDy84OT7QQNgI31m3PEF9XtoMkQ4WXnxmnbuKCVSTuuCT4l/4SM6riWvOE
X-Gm-Gg: AZFdTZdhBNJHCARNsCgb9L9nzUJb3ejUusZOAOL9nsX5nGLICZnjLVvt5Uwx3+i+jU+
	W36FlBg0XLvoKeqUAjl6cVw2YvzgpaRcu26uu3eJs7I0gpLJA2S4nyVrM0q8essGsqrbVOq/2Cs
	QgcmWVaWLHxGvIHRJh31ZYqylSrV1MgRCjs7NW25/tfMDbkRU1YmhY62WfU+H3oEqRRlInTfyP/
	Nl6sYPvEtAmujCGSYzNNTUx/QFGJKAkoVdNXP05vVatpFDDj753AQImS19UagjyuVon9phOIcan
	SeAcbs4g+eobHmGmo9esn1JzfXSPwk2WrHu+vqpqtgXZUmM/3zFk+0hWA+8zk0Cddq93ZduhJlp
	J8JL6K8lA2Ne+Yr+74g6ScqpjBDkFWn6IHUGdoNcC3daTOBTtetQAwa2sBFRhFWtneclPKOPurl
	LRYCnkhIj12K7W5E0l1D7OoDA7GT9rhBdmeSZXJfn3x4e0YksOt/Wg4bHqLUZIKhJxgh19MbWDK
	eM2dvHSYUPJk6armdCSQs+5ny+8Mu0hxr3nKwYPT86HigKBsIcOeu3Cpk4BjzaWwUcnYcJUnEuI
	G+ErO64a1/R08uhupMGc
X-Received: by 2002:a05:7300:ce11:b0:381:6b5:56e6 with SMTP id 5a478bee46e88-3856f65aed4mr1730052eec.16.1795154975566;
        Thu, 19 Nov 2026 22:09:35 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm4609725eec.21.2026.11.19.22.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:09:35 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v11 0/2] perf jevents: Fail the build on a key the tables may not carry
Date: Fri, 20 Nov 2026 06:09:29 +0000
Message-ID: <20261120060931.711483-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113032927.634183-1-takano32@gmail.com>
References: <20261113032927.634183-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v11.  The shape is James's: the check is not an option any more, so a
typo in a key stops the build instead of being dropped without a word.

--check is gone.  Every event and metric table goes through
JsonEvent.__init__, so the keys of each object are compared there with
_valid_keys.  No new option, no second walk over the directory, and no way
to run the generator without the check.  (metricgroups.json is a plain
dictionary of group names and is not checked.)  The test is
jevents_bad_key.sh and checks the failing case only.

1/2 is the prerequisite James asked for: the tree carries 19 objects with a
key the tables may not carry, so 2/2 cannot land on an unfixed tree.  It is
the two fixes posted on their own, squashed.  The AMD one went into
perf-tools-next on 11 November and the arm64 v2 has Ilkka's Acked-by, so if
both are in your tree, 2/2 is all that is left; if the AMD one is in but
the arm64 one is not, 1/2 will need -3 or its AMD hunks dropped.

Measured: on 1/2 + 2/2, the generator run over all architectures, over
x86 alone and over arm64 alone exits 0.  Putting BriefDescript6ion back
into one AMD table makes the x86 run exit 1 with "jevents.py: <path>:
unknown key(s): ['BriefDescript6ion']"; the arm64 run does not read the
x86 tables and still exits 0.

TAKANO Mitsuhiro (2):
  perf vendor events: Fix misspelled keys in the event tables
  perf jevents: Fail the build on a key the tables may not carry

 .../arch/arm64/ampere/ampereonex/mmu.json     | 32 ++++-----
 .../pmu-events/arch/x86/amdzen4/cache.json    |  2 +-
 .../arch/x86/amdzen5/load-store.json          |  2 +-
 .../arch/x86/amdzen6/load-store.json          |  2 +-
 tools/perf/pmu-events/jevents.py              | 70 +++++++++++++++----
 tools/perf/tests/shell/jevents_bad_key.sh     | 43 ++++++++++++
 6 files changed, 117 insertions(+), 34 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_bad_key.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

