Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70B62809
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832769; cv=none; b=THLE89/HP+lr/sMx3B0cH3GyTar75fgaKQLo1XOCQNibeTdLTqQG9TWfwcpmX3WZGNrmbvlDNpQ7yzZLfP3V+ex7J+iIg9pfM9IUkjP85RrVXdqWmuBLA3og3LB2wg/3xcUPz8mm9lYKOvl7PKkgQ+opyGgHVjBSHutn5lYoSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832769; c=relaxed/simple;
	bh=K41LEd5qH/cATpPD8eHKSd94+tZhXjpUOWaoghGYl7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIkN2mlaFBzYm9F6zTQht51Ri32oje7w9qifbEboYYcTJhSdWT6QkfkwYb5/DijcWar4QKGLcca2ZLmhiXMFmBv+LF0X6T9lLrJvNcN7ctZO1ylLX6X6oZWdUPAGi9tuDz4GLFdMnp26aBw5Y9XjVwqHwplOfiaIlJsBh0Cifbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S4FtgDc6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S4FtgDc6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30AAD2F27;
	Tue, 30 Jun 2026 08:19:23 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A9483F66F;
	Tue, 30 Jun 2026 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782832767; bh=K41LEd5qH/cATpPD8eHKSd94+tZhXjpUOWaoghGYl7o=;
	h=From:To:Cc:Subject:Date:From;
	b=S4FtgDc6QOE1fCJmvgeSY5h1LWdCE99eO2nMaf5bs2zdhHP+jJ98euTEenvy4/K0b
	 jzti2LnyTWFa/2TZWNoem5w2QA59WfUWR8jN7UNDFp/QlUtr/tvJp5DVYfz6EJa94M
	 fuEkI/EbIj9VsoOocPRu7iM2Xj4RhFC4zsdj8i5o=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH 0/5] perf/arm-cmn: Support CMN S3 r2
Date: Tue, 30 Jun 2026 16:19:15 +0100
Message-ID: <cover.1782830759.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another year, another CMN - although arguably this was last year's
CMN, and is still the same in name as the year before that, but in
implementation the newer releases have significantly updated the HN-S
PMU features, pushing the previous filtering abstraction beyond its
breaking point. As before I've tried to break the refactoring and
functional changes up into reasonably logical chunks so there's some
vague hope of anyone being able to review it...

Cheers,
Robin.


Robin Murphy (5):
  perf/arm-cmn: Rename filter variables for clarity
  perf/arm-cmn: Refactor event filter programming
  perf/arm-cmn: Refactor event filter data
  perf/arm-cmn: Add new filters
  perf/arm-cmn: Support CMN S3 r2

 drivers/perf/arm-cmn.c | 490 +++++++++++++++++++++++++++++------------
 1 file changed, 347 insertions(+), 143 deletions(-)

-- 
2.54.0.dirty

