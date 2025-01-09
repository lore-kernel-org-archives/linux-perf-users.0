Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B321C9EC;
	Thu,  9 Jan 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436500; cv=none; b=b783IdHgX0LAVjD64gsgUyPs6zuADJfH6zY3R0l/zBWP+8jF2QJbl2TgTs/3hOYeoLnKFDD24IisiSGcm5MCTDGwMxQoI6CJZzulvdBFlHQSATM8Cb83xOWW2rvsKkP8InXWe8k4qynhdLCdw9pEn7SuOkMJgfC/nwz6eQLp8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436500; c=relaxed/simple;
	bh=Oyve9vNVHdXqO2ufAB+PwmFMHORZnv9xH0nH6eR45Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOnkvz7rce2xvBDoUVV4vAzbIWU1AG8K/3Kq/EqBp8GHu0GFT/4QmJh+nX0wz8ha/TwOfEX9avYK7HpZNsuTkBc+93YA8RZEKk2Jab8nvp5b5EKu7UpYw6/FtnnNP+966ViCda+w4ldfF2r74DqmX9XzsaG0aDiZwf7V1+s8VE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiuQLj1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiuQLj1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8230FC4CED2;
	Thu,  9 Jan 2025 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736436498;
	bh=Oyve9vNVHdXqO2ufAB+PwmFMHORZnv9xH0nH6eR45Zc=;
	h=From:To:Cc:Subject:Date:From;
	b=AiuQLj1ACdwTsy0PuVq5KILeQ1VQ+JMlt84rNIbAuWivDpvKrkWHEg2OsmPJ975o6
	 klXSsHgt3GDf0XPWLOfgw3yZ+UNxqLRPRNnPTWGGC00AvtZLp0XCqfM2t4vpENE/Q+
	 UStJXfkX/v9eXBv8oRU8QwqBG3E3/Tpr7vP6dQx8WGVFURmOobM8b5N5eMEXqKuAp+
	 ObrtDhAlzvBYpQ+agTD4bK0bQClfr27waea0U5TmAesElSXssa78cMLV5oaMNrLzNm
	 TdMrIQ6e/bNZXChdNqeA+S1kQn1R+nve/b6pvggtqceO3teHpe/jUKwexYn0IQ3Fq8
	 AfKlo5N7tu+jg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add perf list for drivers/perf/
Date: Thu,  9 Jan 2025 09:28:10 -0600
Message-ID: <20250109152811.3402943-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drivers/perf/ contains drivers for the perf subsystem, so it makes sense
that the perf list, linux-perf-users@vger.kernel.org, should be
included for perf drivers.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..dc4150780127 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1920,6 +1920,7 @@ ARM PMU PROFILING AND DEBUGGING
 M:	Will Deacon <will@kernel.org>
 M:	Mark Rutland <mark.rutland@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-perf-users@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/pmu.yaml
 F:	Documentation/devicetree/bindings/perf/
-- 
2.45.2

