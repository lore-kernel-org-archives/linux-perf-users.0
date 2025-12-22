Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27C3451C8;
	Mon, 22 Dec 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444243; cv=none; b=pAjN3LsizLtOrC4FPBDmXZv8C908F8o4AAVfpW/q8Qw1uZnlTCYo0SjH+r7ngrMhEebLbC0B6FwgqCytrggaEWwhP+FpO0nxdcLndEY5KmXjrmXULjpdlkdF3vK/QCx1lpCNPCV3HQJQnsVbFel3AW6FlK+XsAej4LlEH5oQK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444243; c=relaxed/simple;
	bh=iGYFb6IBoflfqDoZcq97Sl/imErxh/s7ix/63yX+HQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNL3stOeE4z+5Pgy+kRenyntIh73+7QbY4cqfOUdCLC9wOOKXB/OWFzpsl9v213IKpLqiKRNgdBVa3tfzBXFl4vYaU/GH/UWAI881wZZXvJBTNzCnyPHnszaNoppLyTdag9F0BnrxjExT6bvyfwdSKuvPO77JGArgi2mbEQ1Vjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0TYwQd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0TYwQd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DF0C16AAE;
	Mon, 22 Dec 2025 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766444243;
	bh=iGYFb6IBoflfqDoZcq97Sl/imErxh/s7ix/63yX+HQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0TYwQd0RgxT4LlaiCQD6Q916vvSkayvKih/mBx7/mx+JujAUegtW89+dA0ETB5N8
	 uJOoV92bxAfZXOhO6LkNHeu149BxRkI/P1Q5qnBR6KiFNRXJPtiErUvSag7hau81iv
	 ioW7oVFyEotJSq/iiTIuyNV4XqeNvHMVL8gxL2e/4cJMDDD+yqGAoTiCEYlaQEqsBM
	 w/W+FZF6tQWgQmtQp+aBP7H9lOLTTHsl8QjCmkupuXXZoU8p8KcUVw/tbmc6AxFoMs
	 6KqVQ0QvbEDCdBwcTkGbmufr/WIN9xzmZUAW7lSy8a5GcICbtjJqd9phb2EXsK4cV+
	 KWCo9OD+zBLOA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 06/11] tools headers: Sync UAPI sound/asound.h with kernel sources
Date: Mon, 22 Dec 2025 14:57:11 -0800
Message-ID: <20251222225716.3565649-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <20251222225716.3565649-1-namhyung@kernel.org>
References: <20251222225716.3565649-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  9a97857db0c5655b ("ALSA: uapi: Fix typo in asound.h comment")

This should address these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h

Please see tools/include/README.kernel-copies.

Cc: linux-sound@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/sound/asound.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/uapi/sound/asound.h b/tools/perf/trace/beauty/include/uapi/sound/asound.h
index 5a049eeaeccea59f..d3ce75ba938a8497 100644
--- a/tools/perf/trace/beauty/include/uapi/sound/asound.h
+++ b/tools/perf/trace/beauty/include/uapi/sound/asound.h
@@ -60,7 +60,7 @@ struct snd_cea_861_aud_if {
 	unsigned char db2_sf_ss; /* sample frequency and size */
 	unsigned char db3; /* not used, all zeros */
 	unsigned char db4_ca; /* channel allocation code */
-	unsigned char db5_dminh_lsv; /* downmix inhibit & level-shit values */
+	unsigned char db5_dminh_lsv; /* downmix inhibit & level-shift values */
 };
 
 /****************************************************************************
-- 
2.52.0.351.gbe84eed79e-goog

