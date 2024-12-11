Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1C1F37D9;
	Wed, 11 Dec 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955946; cv=none; b=qqmlrMCL0Nl/vgupW+5r0SRiXdRcWRdSYP0FWTVrKksCBeMpPdSyUjzhHd7hKx1FM/+1hQNqQ4r85zaK/4FCKAwQLN1KVZSMn22KK2t61NaHWUQ5IdCgzTIVRZ2oA3xRht6CprTSJbgoz6htfnAdp9If7S+SIqJ/L76m79YAwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955946; c=relaxed/simple;
	bh=jPBZDIKyif/LhOPbutvjTXCG2gTELlQErVsQ7/V8AdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQBS1xgPBaUJYX1NKA7fRSBoX0+xdKsIqfqIajkbCQZai3+Qd2HQkYAuLnCe/mCPDz7LdcK1hY1QKRnIHeBEDbLmHGm7crFCh9JPBRN2LJXxhDKFNtX4ErQMtDr77sEv81UP+yeYKWDMKYrHrWLnpc4jcnVmqVDkfN6amRDkgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnxKlSII; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnxKlSII"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso209149a91.1;
        Wed, 11 Dec 2024 14:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955944; x=1734560744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=KnxKlSII58YTltPQAGUoTDV5zdIH3RzS5GGKsrNRZ5VyEM6T324xuE5XnX8z5YV+fz
         kmkJJ4ZIdxj9XuC8SabxAzx8U7kYhUoiIh/4N6ikwcztbn1y7lFj9IK1TTSKc9oHTEXW
         jwtiGxaSB8UZb6OALTuu3SKYAv+iCwnbkJyKd+20QJYkPd2t4Rhqz28+elQ/wVXaydsH
         WYM6AeXPfHOOf8wj3/Eb2MyKBehoomdbRqbGgRDCU9pxilYKwr7DL3lYVaFQvZwd9aYU
         rgSIQnTljKvwbzfrdkpVj2xmZnTiAo7hCYJJfjlsJyNwwQtHZvo1W/Hpqyrn8UyaHUTE
         g+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955944; x=1734560744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=hV4hUp+2jxm/qXXwVXNC7OTOvuGDxrjBAAHEuzoHznz2zM0OPbfzDn1vA1oF+8o+iR
         1QyJx/1NU/WQ3ncXMtcLVSPyTybysN62wP1zmD6sJL23M01Ba42mRZcLuaKdqKDParxC
         mgjU8bClDRgm3R5AfIxftolSxvdwrYor269ktteUMz2uhTsjsFSd4OWTRkvcH3SoAPq1
         olhd5ORIQd3JlnxoEuraFIEXfcBS69ST1TkcQpUgtFWPRumqTbPrxZFPBFp7lZwZGLOP
         eeC3oNNQ7UuRKGT439TZwLu3i/3sYZgJZcdLQ9O1BRJGNyOf8mXYBC0QzxHo+V9s2PJU
         zMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmS2GMLpJh5Kr8Ouujx1BCA9cnqHr0rEw7AgYaUvjolI3rzCEQgf4gL9gqON4tLo02jylBzCoxtysyOq0=@vger.kernel.org, AJvYcCXP+4FJQmdwDLFwggTMX/AkeC86Y7hWRkRWAik5A8H3rwVeIhAVkeauwYE7w0MxKVcfDRkfgoZZB2loGk93K5yogg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZEk8zTrTBwZYrVeA4FTnHKKUaWn93ZOefb0GkK3rCaMRUm+L1
	US06/eH/ehN2NmruS3Sc0lVzJblNMqza6JO3jx0Ng56ICcrpKLUP
X-Gm-Gg: ASbGncsk/njgPAY250hM6OOx3T+4+4MWVQnFQNCCeCsrbwMQDvzksYRptXNJzcfZ1Pp
	YDUX9S/K87L1JFGkLu4Whn8urw0Q2PJ+UYUCeqj3Xf93X4CP4yEgWCTf7XgnpciHO4Si0DffleI
	I0Zz5KEslnX4kIL3fLZ98aOtOUdSC6CgePIMwOeMDwWwCyEJn0l/CawngotpozYsLJgSQ2EJvY2
	ZhTL4R02/sm4zGz9tNq0c3PkzWb9DMkrrclLn3e5b0BDxnkZ4mBuCLfxWbyeXNeueuh65ZA7DVQ
	U3ux6H0/KQ==
X-Google-Smtp-Source: AGHT+IF/SLTikBFyJhLZptjNJmimPwR1LUGFL5kS+037Eg0Fc7lpGmn8NoxxgLF9Raz7qbLzp8F2cQ==
X-Received: by 2002:a17:90b:3883:b0:2ef:7be8:e987 with SMTP id 98e67ed59e1d1-2f13ac5477fmr1392064a91.12.1733955944101;
        Wed, 11 Dec 2024 14:25:44 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:43 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v11 07/10] perf script: Display off-cpu samples correctly
Date: Wed, 11 Dec 2024 14:25:25 -0800
Message-ID: <20241211222528.945590-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211222528.945590-1-howardchu95@gmail.com>
References: <20241211222528.945590-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

No PERF_SAMPLE_CALLCHAIN in sample_type, but I need perf script to
display a callchain, have to specify manually.

Also, prefer displaying a callchain:

 gvfs-afc-volume    2267 [001] 3829232.955656: 1001115340 offcpu-time:
            77f05292603f __pselect+0xbf (/usr/lib/x86_64-linux-gnu/libc.so.6)
            77f052a1801c [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-2.0.so.6.0.0)
            77f052a18d45 [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-2.0.so.6.0.0)
            77f05289ca94 start_thread+0x384 (/usr/lib/x86_64-linux-gnu/libc.so.6)
            77f052929c3c clone3+0x2c (/usr/lib/x86_64-linux-gnu/libc.so.6)

to a raw binary BPF output:

BPF output: 0000: dd 08 00 00 db 08 00 00  <DD>...<DB>...
	  0008: cc ce ab 3b 00 00 00 00  <CC>Ϋ;....
	  0010: 06 00 00 00 00 00 00 00  ........
	  0018: 00 fe ff ff ff ff ff ff  .<FE><FF><FF><FF><FF><FF><FF>
	  0020: 3f 60 92 52 f0 77 00 00  ?`.R<F0>w..
	  0028: 1c 80 a1 52 f0 77 00 00  ..<A1>R<F0>w..
	  0030: 45 8d a1 52 f0 77 00 00  E.<A1>R<F0>w..
	  0038: 94 ca 89 52 f0 77 00 00  .<CA>.R<F0>w..
	  0040: 3c 9c 92 52 f0 77 00 00  <..R<F0>w..
	  0048: 00 00 00 00 00 00 00 00  ........
	  0050: 00 00 00 00              ....

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
Link: https://lore.kernel.org/r/20241108204137.2444151-9-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index aad607b8918f..87b2cedc1cbc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -662,7 +662,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel__has_callchain(evsel)) {
+			if (evsel__has_callchain(evsel) || evsel__is_offcpu_event(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -2358,7 +2358,7 @@ static void process_event(struct perf_script *script,
 	else if (PRINT_FIELD(BRSTACKOFF))
 		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
 
-	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
+	if (evsel__is_bpf_output(evsel) && !evsel__is_offcpu_event(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
 	perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
 
-- 
2.43.0

