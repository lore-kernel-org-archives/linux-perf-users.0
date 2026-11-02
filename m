Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621746;
	b=1aohsUuwRoZm6lEsSUvFvNJEeOKHp5UXDGHbsVQK7umrVzJGm/sVvLKQabq+r69/eSOH
	 ZMbaXPjWuon1BVcpseJh9oqoB8pAb6U7lr8DhNnvsGB3qy7lUTkg8IIUh4dQEbbOrh6g0
	 DZFBPHIkbvH0RbsvyFE7PU3JFQsmHqdybZwpTWuMMx/OH86jBJruvv13R0s8VP+kHID00
	 xTGmFAtXDSx/r8diWIaboYy86hjHbfRgzMRmB48QUarvkboXVHkfROnCaxpq1JKrDMxnZ
	 kJbS3m/4prykqtc+lfEDTNo2Z86WqtZTz1dIrYNgr+PSMBLM4bujAYBa4d+ZZQAceWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Bh4U2E91rsCqLr+0sIHaCoOn6O50hMaPJ9gqvidFbD0=;
	b=NoTDdQaJ0tox7vZ/wEUy8RcCY9oCOX72rWhHU30ygRE4gAN7gJmttdpf0gjoURMk8+g5
	 rplJtQ6W1J/PJY7dHSJVvrqZYFagMI+7NTK6ouF2gXtLvRYqrJpKWuO9D/+EFgYnuxG9z
	 XyD8zbz98Q1rKveHoCmoYttQ2pOO22nw3a5h0IRoJu7ZZcSRDwUyVTmy+0+8mklbAVWCe
	 xfG7VAv/PU6COGvz3ayejoW4NilW4aY4mWLwjAjipK0KmPexiOvRd9ejabK8zRMFqooQ3
	 TXxzaXADLRB08twlCvh+AjuQQgK2ZwuOd635LZf9kfU90BbEV9y1ZqVbfMOqADetc8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aqwZ2akk;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE4606A336
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22CE4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aqwZ2akk
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1701980f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621743; x=1794226543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bh4U2E91rsCqLr+0sIHaCoOn6O50hMaPJ9gqvidFbD0=;
        b=aqwZ2akkPQhQeixCVlzcQM2YG7Jv1gccwfo2vmMP903VPzwpVbetjX2tQDjmvheEY4
         28kcotK1k3rVSsN+cIev7PHUfWM2gqKlcWZrwMUuzsWNGUwxxLGxLPUj5yZLdINA2oXk
         8NRXOkPhPQyiJwBxKEMbH+8MuJKD/ZyRXLi3BK/Kz1Ee/Xi8i4+RHwojS1tAXZFnVU3V
         Nmp57UN5qtLRXKDRa6yUtNlRI8/ruM9tJIv8b87PvoBZOshK1Bqwg8WfWJkilSLn2NyR
         VdRDENxCSqPhsXYnDOwfECKmn1bg739upo10f8zZa+Ho4pkztl1UyYi3RTaNa6r2fMF1
         C62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621743; x=1794226543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bh4U2E91rsCqLr+0sIHaCoOn6O50hMaPJ9gqvidFbD0=;
        b=PZ7H5AlStQHj5pFwEAFSAHu6qNLUyL6W5C1sIMvZ1S0IvCvLcPuPebmkgjV45Ocw2A
         llaSILFw+gGJF/mlAciFwJW+iClwAbCOSrL9BF/2coewggCuJnXRJgOViHjTt8to8vkH
         Zx+LGUVL7JnVRWlpUPUFqKW+OObPeV14BG3ZQNp1YJf3S3OcTGA4txlBKAF9ZyPrrUQ6
         QeRCm6RTGiSXcJgr+yybGqcPkDx67piq9OmvXBYR9qs/EUneykEPxYvFRILaw4yW65lY
         INM/TVQ5tLCLq9yC39n9zP2YOusKyZoHlx9bvWGC4VvztCcNB0pdVVPNY+GfqQwo7GtT
         vd7w==
X-Forwarded-Encrypted: i=1; AKwUvBzLSWRRk6D5pIP2gCkwT8lRoKZrxPhirabNN8HKlWSjnNDMZdeEkWRwcpreB9+DmTGgQa26E9iMb5CWCu9nfL8I@vger.kernel.org
X-Gm-Message-State: AFq9FYLnCRa18iCXOmcQ0l4iTsLiG3sWZxq1m8QPQENoOLJZPUDIAYbJ
	GpTzFZXuxvJuAGlzm7t1nMxeZoC3GGXmzwaZIofKooS8MHHsJXNktdFrPDitpyxHq+k=
X-Gm-Gg: AYBFou36KiF4ZawnEPK3GXoj8zKr2rPSU1JDyM5Momft6s4rLRV1ZiO0o8jbL6nKRjF
	3PTSHfBS6De6OnNzVYHNnkUG3Qo1fYq9F03iI1w2F67yvZJU+5g2wCubEEL9jwWZp+fC04sEu4g
	UVYWt927YwEDVwsKyngOuRsYX891/0uzIZbeEHMIBSnEBSh0OEW+/kFa1J8/KXbNYbbFzc8cc7H
	P2jJYuPsjrwVyI8OA9UoMqZEJFFoQLamH+gpT9vGpz68BZmgjQWZ+/ISyRUH5ijqwMrhll7EogV
	p4fHl/cGUzne3f3JdIEMn7n35Gsz4rr7dzopUTHO4UeXEU/xCWQ5ryaoYtAOx9tA068XN55h43A
	VbiLhPBnt4cF/RgUiKgFJC0wsZhK2QvvHoHLp1JEqnHNCSqhk05+SFFkt9okNVkzVL5lql30O7B
	95sAMIriy77P6d5aFP2bxnOGERppfamHVx3Xe8qfsiE8MH6Bt/A31IUPBiMv/fEJoy/NKv+Nemb
	JQGiYM1TE8jc9Aq6uiwwQs0LoP6UQ9RcunH6GG3giM29QJY1J2+jiHhhg1/8dAQrGLpDsyckadw
	uYVYJa/XuarjvulJP5c1fUgS8inFUtCb
X-Received: by 2002:a05:600c:3b2a:b0:4a2:cbe:bec2 with SMTP id 5b1f17b1804b1-4ac18a8882cmr227973035e9.32.1793621743497;
        Mon, 02 Nov 2026 04:15:43 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:43 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:15 +0000
Subject: [PATCH v3 01/18] perf cs-etm: Fix nVHE per-thread decoding
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-1-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

pid_fmt is unset in per-thread mode because we don't need PIDs, so we
can't use it as a hint to determine which EL the host is running at.
That results in falling though to the next part where EL1 is treated as
guest, which is wrong for nVHE.

Fix it by only returning a guest machine when run from perf kvm where a
guest image would be provided, which matches existing behavior in other
parts of Perf. The exception is when pid_fmt shows that the host is
running at EL2 (VHE). Then EL1 is always a guest, so keep using the guest
machine rather than decoding guest trace with the host kernel maps.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c8a6a6e4c7d3..509ec014b276 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1102,6 +1102,20 @@ static struct machine *cs_etm__get_machine(struct cs_etm_queue *etmq,
 	if (pid_fmt == CS_ETM_PIDFMT_CTXTID)
 		return &etmq->etm->session->machines.host;
 
+	/*
+	 * If guest processing hasn't been enabled, also assume everything is
+	 * the host, unless the host is known to be running at EL2 (VHE).
+	 *
+	 * This matches Perf's guest handling in machines__find_for_cpumode()
+	 * etc where guest machines are only created and used when perf_guest is
+	 * set. This also guards against accidentally using guest machines when
+	 * pid_fmt can't be used as a hint (per-thread mode). With VHE, EL1 is
+	 * always a guest so keep using the guest machine to avoid decoding guest
+	 * trace with the host kernel maps.
+	 */
+	if (!perf_guest && pid_fmt != CS_ETM_PIDFMT_CTXTID2)
+		return &etmq->etm->session->machines.host;
+
 	/*
 	 * Not perfect, but otherwise assume anything in EL1 is the default
 	 * guest, and everything else is the host. Distinguishing between guest

-- 
2.43.0

