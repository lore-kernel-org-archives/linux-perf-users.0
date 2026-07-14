Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFF494A17
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061658; cv=none; b=Qmam3ejbfr8ok9Ds/mRpiqQB+bJ5t0rod6xh1SYlQckvcqgFxm+VyNj0TCYYPbK5GqSh3mYiTMHfGbFzEHrGPq9xipmzwbqfRPy0ZsNOzPNss0I0KTajnwe+QxjG6M19Aof8cCn15RdHRf7IA31BDQy5J6+T+M5f6cdfPw5HgGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061658; c=relaxed/simple;
	bh=Z+Afg1RKJjBzUiNIaHhfIrneCpz04dwYL3WfF5D55iI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FcA1jjCI1mBVWVpU1YXNxwyiK5XUPAsmv9Hh3GHwwny2SkKuXYj52qjlvAZ6DxHxkRIHg5IAdR3N+D0bj8wLTIfxZM4cuiTqYSPe2CBfHVl/feUJYSrK1KzRIKrEk9nAjPOxbxER8tBcop8ZytzQ3ERxR+J4CK7psUhHbcIJmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ca0EOzAK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ca0EOzAK"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so11685552a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784061656; x=1784666456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bYwhQprVjAjnonA7n1cULNjTidBncILNPEqi9F+I8Fg=;
        b=Ca0EOzAKAtYOtMC8S1AzrW/KbyeM05VeWwMJISifcnqZpdjx8EUQ3+oqc441BvGzlV
         sEXtULZK5zcMjLuE98cBvKcZekE2H98s8kukOeTxhojQLaqqSNYvqaUkevj4ibZERFau
         WEogvvGnqlbalH4XwxtGN8kkphzbw3mHIey0EzZRghCF1CZhR/SfBcLz4mSM5vRfEH5s
         rsSoD15uouSomWuZq9ot5Go5DVmgUFyqpFmLYHpS7LW7B4oNhEJaiM4YVt8zDAPJnGpk
         cVNX29fTHwMwmTUVxvKdupd/GcFwzGpntUCo0vPUPy+pdM+2FFGEyKHK+avQ/r6L9zqD
         YlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061656; x=1784666456;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYwhQprVjAjnonA7n1cULNjTidBncILNPEqi9F+I8Fg=;
        b=VxP6C095XQwOyVs1f9hsCBqDKSC7wscGs7uQQK7Av4wWEj1PS0KH1LtFi6C8K7G5xW
         Tbwb/m5UOmMlrzD+ZJbGN8IRpqw32mLwak+CglNdZzCoZomxP2uHpxrjIGsyAv71u4pQ
         BrC5UcKwY4MyoYrxkSzO2aZNVHTX7oq/MhcTg41K2yk34ZKnggwLOpF9QiCWQuFdcr+n
         rWAYzd6dNkLofLC79J45g/g3ikE5GDy6LN2dXa8ERj9mSlvBrWPGERYEn11XJA2OkDFC
         D2nJwIleRfr++y+VuNNWRpdkXx/4TofX/xU6JFXG0NTNJcY4XjudEKWGTRi6+/hUggfE
         zz1g==
X-Forwarded-Encrypted: i=1; AHgh+Rq+udOOncYB0N6NK5HjAk/GsejufPFVnrodriMFzIXOyNPg+zybYxNxfusdupKrdUoxSnxABAuiCXO5ShwnT0em@vger.kernel.org
X-Gm-Message-State: AOJu0YzMuBuwgJpNs6UGKmZaxbtD8PKm+mMR1u58iV3s/3UIbz/aSk0Z
	OrpCXpoYp4HJRPTQOQxZdyS/1EtpkUpx2BmcB02Vfxu6YEIQxTat4zoVb7QEhY7XDN9qhwNMahx
	3mKY0jA==
X-Received: from pgt36.prod.google.com ([2002:a63:1364:0:b0:c8f:d0d0:d863])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:330b:b0:3bf:6c08:fba4
 with SMTP id adf61e73a8af0-3c357637bc4mr4783765637.56.1784061655586; Tue, 14
 Jul 2026 13:40:55 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:41 -0700
In-Reply-To: <20260714204044.1952031-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714204044.1952031-11-ctshao@google.com>
Subject: [PATCH v2 10/12] perf vendor events intel: Update pantherlake events
 from 1.06 to 1.07
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/ce70546e9ccca4181d142057171c5bd820c=
8756d

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv               | 2 +-
 tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 7bbb8b237b35..3fffca669710 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-BD,v1.26,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.22,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-GenuineIntel-6-(CC|D5),v1.06,pantherlake,core
+GenuineIntel-6-(CC|D5|E5),v1.07,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.39,sapphirerapids,core
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/pipeline.json
index 5d5303c02954..74209da5bc27 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
@@ -1334,7 +1334,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent. Available PDIST counters: 0,1",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX) Available PDIST counters: 0,1",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
--=20
2.55.0.141.g00534a21ce-goog

