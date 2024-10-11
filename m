Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90531E882D;
	Fri, 11 Oct 2024 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612849; cv=none; b=dH0us+HqYYSgkKQrV8z7lOdEwBwl0AWMVaQcQd8N94Ajsut07E//r+3qqlZfgTaX7KO28ionzBqIIn3FdCygKvHmQI0SLsLqLp718eFf7HPSTbcyGpoaCaQllc0V55IeSOwadK7NuA3Cu7vMUVDGa84u/dxDMiJenoGTqsHHUK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612849; c=relaxed/simple;
	bh=Gu6tKGIytnUPXQxdMpfj7VMXXPOIhmxPgGYPcUDC24I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T011DeRVcnChlIlZKopgMWHi2D52C+6UIG+AdfN8jVqcf7kvSG6ah6oeaNLupBBBrSmjfSH53iQztPg6JuehDVDRZ2EUr1uXgakkKBV3NB9MRZIg1Pgdr18r58HxZ1IDZVjANzVPWDcypLiGuSwscYsfujcU0prC/h7tbMu49zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdWyVl/Z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdWyVl/Z"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so1366961a91.0;
        Thu, 10 Oct 2024 19:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728612847; x=1729217647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GC7INRZB8Wa+yZPiQbxMDDI5/n3tRCudKMmqzeYnqPg=;
        b=QdWyVl/ZWwBsotcpNFQlI9m+tn92XVdMiyHS7UXYvGndnY/Z7FUphnDOaLMWzgWaqV
         4IqqsB9Y+hnWbEYXy29hkVLKaDybzKPaSmoeapJutqS3iAzR+lsBXxws94qvawowY/wf
         Bjdpf3WLYKqRbpX8tr2Fo6XDi0BZKbpRaKh44g8DS7PfxmscjUHedL2qJKqroDQUi9/r
         rxFWlmLFRVJcN8ZjdDEZNybefOUx+1RS0vqwmB35gWYqcBNvNNZURfljy9Y5Na9kkfQo
         a/dEcjunJlq9G0FU0PT5Dbyata/Oo4c7PwlVEkm+/s2rMUwYsko/yDzllTBMe0d22RmP
         m5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612847; x=1729217647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GC7INRZB8Wa+yZPiQbxMDDI5/n3tRCudKMmqzeYnqPg=;
        b=tWlL6DvM0lPcmmrDjQi8mjw/+oCrUEsYi0WrUyP5LyRKlw335iJ9De86ReXmBeKiK3
         UiE/ZVWiURBVqHVb5hRTdwBFGO91V1rXnlf1Q8lTkV5UEYx13EjGUJznG7oVQT/uJ4VY
         TM7jRmVC7PSnmszojqaz1LcTs24wIejLASeIleFYu54BV8PRPKteylRQANEh2qaL1u4d
         PIFuNR2SvbduYeoigaVtIGSegLOW33bUwB7ZXsMxgs16qaL/NFjzKg8H9T9GAoxQ9bFI
         mXX2eQUKTXK9n1F5ndtKi8SbCubVe7gNs4L3YSJfYS5FrmzyVpK4AoJA8KR0LLkQjr3v
         gksA==
X-Forwarded-Encrypted: i=1; AJvYcCV4+UaiUEIIXTVU1/ZPP2LzHedZ+1gNIZTtDAFwGofLIkZdwFZMklOlUQRqD/+PsM53vUnlSBncjZDCij0QhSIQbA==@vger.kernel.org, AJvYcCX0+RQ7CKio5i6Pv30gdiXRdrvaXxunHJrQfP2rgg1VU5cHcPCTtBbtH44jFQNL8kp9VAMxSevP3t7e93E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsN4/L5PiQ8RdeM1ddOl6qRaSgs6oIIWAsmYQszCXbA4oQPtyF
	SfUKWvzjzLqELWyqS5GO3aUf0yZ+tFeIXeTclhLOrPfia3vAuE1P
X-Google-Smtp-Source: AGHT+IE2QN11I7aRcr75zu9FkTXaen1Dcy4ElHgdVJZDgd5KaND3QAfJyzj97i4yG0uXqYsMWsSc3A==
X-Received: by 2002:a17:90a:c7cf:b0:2e2:a661:596a with SMTP id 98e67ed59e1d1-2e2f0ad039fmr1664628a91.13.1728612846972;
        Thu, 10 Oct 2024 19:14:06 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a56f71b5sm4393024a91.20.2024.10.10.19.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 19:14:06 -0700 (PDT)
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
	james.clark@linaro.org,
	alan.maguire@oracle.com,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature in clang 12
Date: Thu, 10 Oct 2024 19:14:00 -0700
Message-ID: <20241011021403.4089793-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Resolved a clang-16 build error pointed out by Namhyung Kim
  <namhyung@kernel.org>

The new augmentation feature in perf trace, along with the protocol
change (from payload to payload->value), breaks the clang 12 build.

perf trace actually builds for any clang version newer than clang 16.
However, as pointed out by Namhyung Kim <namhyung@kernel.org> and Ian
Rogers <irogers@google.com>, clang 16, which was released in 2023, is
still too new for most users. Additionally, as James Clark
<james.clark@linaro.org> noted, some commonly used distributions do not
yet support clang 16. Therefore, breaking BPF features between clang 12
and clang 15 is not a good approach.

This patch series rewrites the BPF program in a way that allows it to
pass the BPF verifier, even when the BPF bytecode is generated by older
versions of clang.

However, I have only tested it till clang 14, as older versions are not
supported by my distribution.

Howard Chu (2):
  perf build: Change the clang check back to 12.0.1
  perf trace: Rewrite BPF code to pass the verifier

 tools/perf/Makefile.config                    |   4 +-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 122 ++++++++++--------
 2 files changed, 69 insertions(+), 57 deletions(-)

-- 
2.43.0

