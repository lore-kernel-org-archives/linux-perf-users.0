Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC31CEEB2;
	Thu, 31 Jul 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955916; cv=none; b=XxaQRWD4ejRF/5wFXrLFbk8BR+OJuVz8ld7FSR1BrveP0h/FLo8ivxhijuUMjfolsdVxvnQ/Z2ac5TNOjoyrSs21KOcCQTeaeKlOiAju9F/wCZ+b2bLq9DtWoRSUa5KKPT4CbC5KWo+aUApYNo622+I6sKIpXBZBvC/HLWdpTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955916; c=relaxed/simple;
	bh=lmRS72UJUUKpO815Qg4RXtM84sy3hDuYsXqSE3qhZXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtflZfaju/TPpyq8pGF09zCieXIIXtKHTtnDsN5msRJo2kEEF0Xlmqb1M8X8ShXzbjak9b2cQD8EcvZ3Xj0vAu1JA0Ooj+g6Qdc/9bceWvGuZyswhb0dUWLTXhewfW7hs2iY1daR7/mqk2hNoRHYV2YibtwMmHW/mO7+Pc0Yulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jed83p5c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jed83p5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731C9C4CEEF;
	Thu, 31 Jul 2025 09:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753955916;
	bh=lmRS72UJUUKpO815Qg4RXtM84sy3hDuYsXqSE3qhZXE=;
	h=From:To:Cc:Subject:Date:From;
	b=jed83p5cs9gCcaDy+JX4yh5RaGw7PXLXgD19Tn5tPdbvEbf2tCp3WlJkzVuvCB5RV
	 /I+IHiblEPyK6tPfvn1C3rDT7ot3hlGd7uOrk8LaxoBcCYWZ1l657XxzcoQVMYCbga
	 eQYXvmQzJy+vabFkqES/55Cfkav1fwsXNumhrT1vryDCmoyt5BlkoQqEhm0dNxnAaD
	 k+EoLQBQQsB/il1/aDXIidq5QVSFYQUCtIIAKTJf98IAlT8sqDMndnIm9IFBQe9VCD
	 EjwiQkM5SYLUiwlbKN54dCWPRtNMGMN/V8xBHc/na692DK8fxCvyZTbYsa35S3+Vvd
	 rKCmadXXVbU4g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Date: Thu, 31 Jul 2025 11:58:30 +0200
Message-ID: <20250731095830.2466139-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
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
---
Cc: x86@kernel.org
Cc: linux-perf-users@vger.kernel.org
---
 arch/x86/events/intel/uncore.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a762f7f5b161..9c08d86ea53a 100644
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
2.50.1

