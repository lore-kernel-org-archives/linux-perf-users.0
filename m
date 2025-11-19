Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C031337BB8;
	Wed, 19 Nov 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543746; cv=none; b=UjJXlMilTNrkAXUBNMZwXm9LkWzE8w12CvhWloFk+7EdCmJYDVb0QuPJ27vO0xBb1d+eo0hr+/GEgfsigMuy2e2jaOT92PniUqPrjgeU1Ipaw8sey8+9aPQhEmlFcUqCzUQgEGL6mGGcL0P9m/nMbjD+JSIYzKznRq2gmoBnXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543746; c=relaxed/simple;
	bh=nG37ntvozLOkcB2eKVXoKcL71eayOwHRsi5OoPffWHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXgledulZYtDTAKLveTj2HPLRVBTlaQaNBm8len7WXns5By1NMShrShqsIh70xvqBG4CsXuExvoE8ueYEEG8m2ordaxts9RE78iS2EVoETGKo1bCzOv5lGRnCWxvBDf1XSb0XLVeXQApcd+81uKJh8kdyAovezaI3mEy66Hk3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuM/ipQt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuM/ipQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03849C116D0;
	Wed, 19 Nov 2025 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763543745;
	bh=nG37ntvozLOkcB2eKVXoKcL71eayOwHRsi5OoPffWHk=;
	h=From:To:Cc:Subject:Date:From;
	b=VuM/ipQtxYb1S+lz4zumkp1ApKTUrK/G/iEHW43kY57I1aW3/72XxOF/7GoN86BOn
	 vs/XNN3eZO13OHfc2Gqikp6dSUEZF4OAmxjCsrL5ihbq0bFJM8M3FBuEt4Hk/+q8B7
	 gfZf288aZiRUZt4Dqx6AGEqehrK15IFmkxF6mRognrCjdN41MzwSsXFE9oOv+LKdAO
	 87jJoKtgsBt16c8SMXAxmwsKqsaOS3QI2SMhOEzc41FbOEvT4jfcXaYS5h0R51ubz8
	 FbZOHb+R3pOd9WZpJ2KJSWb/yk8oA7vy1Q2v/92p+F83QqutVVZcgYEBWq3xT6ERpd
	 n9++f8Z0BYQsw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: remove dead check
Date: Wed, 19 Nov 2025 10:15:38 +0100
Message-ID: <20251119091538.825307-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmu cannot be NULL as is taken as a pointer to an array. Remove the
superfluous NULL check.

Found by Coverity: CID#1497507.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-perf-users@vger.kernel.org
---
 arch/x86/events/intel/uncore.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d6c945cc5d07..e228e564b15e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1325,8 +1325,6 @@ static void uncore_pci_sub_driver_init(void)
 				continue;
 
 			pmu = &type->pmus[UNCORE_PCI_DEV_IDX(ids->driver_data)];
-			if (!pmu)
-				continue;
 
 			if (uncore_pci_get_dev_die_info(pci_sub_dev, &die))
 				continue;
-- 
2.51.1

