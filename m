Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48EE194ADF
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688218; cv=none; b=kqrpcas7CiZS+YKcmOiQLE2PrzbV38rSuQYb+CGYxF9d4B4AxSKlYLQFPoEzzQK0AYyzRSXjraiIwNHDJRbtSSnSUpgMBmf+oB4bj8N4G6e199KyVqTgHu+ofDPHt/mkl4xjSIdP1cXRKmxTRNcNrEUdzZeiegWcx9q3LxmclUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688218; c=relaxed/simple;
	bh=T1qHhvnGqiIEqyobFNbizY9o+4aU9sCmNpP5xbPW6n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0/39uTR4kTqLcm7QgLR3elxms3i1TywKsz15pfPDS9JGAHRdMl2b2WzR4/ie/UKZd9AXm3FTazUDStGEDISXhTI66aaAJznqWX1HGRc/IjE9kRwOlfKidi0N8yYD3aT1atKrj8SQg89ogQ8LeubyyTj/HVD+dIrC4OtHCFXXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: amadio@gentoo.org
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: 
Date: Thu,  6 Jun 2024 17:33:00 +0200
Message-ID: <20240606153625.2255470-1-amadio@gentoo.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Arnaldo,

I adapted my patches to build on Gentoo to apply on perf-tools-next.
This moves libtraceevent and libtracefs to rely on pkg-config, but is
still able to build against non-standard installations with PKG_CONFIG_PATH.
I needed this patch because libtracefs changes the include directory when
using the meson build system. I filed https://github.com/rostedt/libtracefs/issues/3
in the hope that this inconsistency will be addressed in the future.

Best regards,
-Guilherme

