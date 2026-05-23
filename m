Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F23A1E834B;
	Sat, 23 May 2026 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779551899; cv=none; b=VqJ/qh0dGW0bGEyMAvDIcFGkVn7aDFG63mP1GQWkFOwYvXRxSZurhcsCKQNrTaozCbZd9VWLqieS51FV6KkESvM0yM4olKZDl2P2penBFRAzHHKyO1HVhFQpEd2mtKfBlhwORf7wthyEo5g5nclDVGtvaHNMhoTARor3ZzPWXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779551899; c=relaxed/simple;
	bh=OXWoPKkV4POw0OAT4Vw22r1PjCtF/HvPJLEYD/FLl0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZ2iIAHIMu0mHcA1bzMCo4ADoQWZG6ke8jmFCOSd3m0BRyGJmJdYk+essjE2nKW/qLjTi8xm8cR9+llwrKk+ZxromTEJw707KHWlYJsB+3mcdb1iOXqCaa3Ee83YoN5tlLYvP2IaW+Ueaw7uuiv7SeTJOHZBy7yLZ09Ufr4JVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=oq3PCjYu; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="oq3PCjYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1779551874; x=1780156674; i=len.bao@gmx.us;
	bh=+yuh/CSH4qezvWkSqxJjZJPK1San6Q8kVt4wbB95drc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oq3PCjYudCrMrtEF77tSW6Eokh+vHbKP2NGTlKRTVBX41pwYo4wsvDyuDQmnUfLm
	 /EUORwu+ovT0YNkHghR66YU884DYzrwFCRaDo8F1rgpt9VMgjUadD0l7GDFxvkm6o
	 uHMnl+XLU9kQdiwkEYFlBXj1FrdM6qEe8KFW9VxnZGVsAS424/EcwnuYHEYpYiH7o
	 m+h1w3xLTV2XkkUFG0724EGLm/oej4lyIpDnWjQx8hfS7Cb1bgX2FC3babAz2zIN5
	 P85D7Uk1JUAZgib5euVRr7jVQ3H2B/h17Y3BAUlvNxaigOlouInV0gOJ76hqlNmBp
	 e0xlibbxFMbz7ExyUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3lYB-1wR5iU00Op-007LWp; Sat, 23
 May 2026 17:57:53 +0200
From: Len Bao <len.bao@gmx.us>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Len Bao <len.bao@gmx.us>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/amd/core: Mark perf_nmi_window as __ro_after_init
Date: Sat, 23 May 2026 15:57:26 +0000
Message-ID: <20260523155728.52909-1-len.bao@gmx.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XYt/Zc7eiAe3kHdCttlXQLVvEtSTOI5bKhRXRykaXN1X9on2SdR
 ODOhJq2V0r9yuhI8ybEYdEKZcrUX2cqfGqaEgtF2naQ1A6hjX59jh2R1nujA+zw/OgKQpzA
 Jiv8nM2JoCEEGtONXeLR2SSgX3pkZH8TPUOiRpI+2/vWIEcCTNPEmR3CiqR1q0Y7uq18a1T
 2ideKhX7wh/RrdapnWQNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cjAlICFPokw=;fWVzp1hnVKcx2CCsnfAgvp2/+Ie
 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

The 'perf_nmi_window' variable is initialized only during the init phase
in the 'amd_core_pmu_init' function and never changed. So, mark it as
__ro_after_init.

Signed-off-by: Len Bao <len.bao@gmx.us>
=2D--
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 0c92ed5f4..23546f965 100644
=2D-- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -16,7 +16,7 @@
 #include "../perf_event.h"
=20
 static DEFINE_PER_CPU(unsigned long, perf_nmi_tstamp);
-static unsigned long perf_nmi_window;
+static unsigned long perf_nmi_window __ro_after_init;
=20
 /* AMD Event 0xFFF: Merge.  Used with Large Increment per Cycle events */
 #define AMD_MERGE_EVENT ((0xFULL << 32) | 0xFFULL)
=2D-=20
2.43.0

