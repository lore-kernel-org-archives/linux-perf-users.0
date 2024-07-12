Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481DD26D;
	Fri, 12 Jul 2024 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813535; cv=none; b=Mp3qIWEjl4VQIc/ufTUPUYGo0ch617Z8953E124i6spOZJ1YQfAToGn6zEaG6ySEA4qHZJcJ3rDDzlTKFkCbXfsKVwhtS//htC7Iiha2wfB4tOwo53EbsG9Q25a2VJiMMq6Uy58lT8MBL4o6YVTXCY9FB2+N9zquhD056zhIsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813535; c=relaxed/simple;
	bh=Va0bvHiS0n4BSG8LQV9fV/5ZNsn6FUSvuuZU1/VLPtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbP2zfh0x+qaE2Oe5DIWFV4QCxf+0yGTsfBj7+ngGQ4hylmsYPdVCyD0ZerZP6LZqXpQ8JaRLVUTIEboFbUzpKTdlFHuzYqGwbOAZP5HjEcMlJnSozEMG8qHhA9rvODFfOUr2fFbVzy+l9o/sSJVno60lzNe93X+tDaFDGSfkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Guilherme Amadio <amadio@gentoo.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] perf build: libtraceevent, libtracefs feature check with pkg-config
Date: Fri, 12 Jul 2024 21:40:45 +0200
Message-ID: <20240712194511.3973899-1-amadio@gentoo.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAM9d7ciLGP_w9YYOb-2U2ESg8kQx_knQXuB6_2JZVZ2ktL+bzg@mail.gmail.com>
References: <CAM9d7ciLGP_w9YYOb-2U2ESg8kQx_knQXuB6_2JZVZ2ktL+bzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung, Arnaldo,

Here is version 3 of the patchset. I see the change to send output to devnull
has already been applied, so I am submitting the remaining work only.

The difference with previous changes is that in v3 rather than add tests with
pkg-config to check if dependencies are actually installed, we just set the
flags and send any warning to devnull. The change that remains in this patchset
is the fix for the other tools, which were inadvertently broken when the include
for libtracefs changed from #include <tracefs/tracefs.h> to #include <tracefs.h>
since the flags for the feature check are not set in the other tools Makefiles,
it currently only works for perf. I recommend to either take at least patch 2/5
that moves setting the flags to tools/build/Makefile.feature or to revert the two
patches that have been applied. You can easily test the fix with the commands below:

make -B -C tools/verification/rv VF=1
make -B -C tools/tracing/latency VF=1
make -B -C tools/tracing/rtla VF=1

from the root of the repository. Only after the feature check flags are moved to
Makefile.feature that it also fixes the other tools. Apologies for the breakage
there.

Best regards,
-Guilherme

