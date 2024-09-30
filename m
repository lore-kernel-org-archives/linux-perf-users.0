Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AFC1A2562;
	Mon, 30 Sep 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727705; cv=none; b=RKc4nrK3ihtJA1ZKqPEIwERA5fVy+LiCEdBRVIcS8GM+A6nJwHKLhekLIxpIbr/Sl9JCAS56KtIXcoWspfSLW4JV66ImIYzy8N0e24/MwiuIkTJBl3AwdLixkNcNGqMaPRkx8iTLRc1/rLricBPBA03YQlwh7bhigNvsGw8+6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727705; c=relaxed/simple;
	bh=pM8Xt8CTr7zzNt1vkDbQMLfPbOGvXf8TyJyr4dxXCbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkfqRDjbwFRA+FU1dltLAXkz/mxv6NuX4u+Xr7K36vkU5MWiiTlKo+CFfMsy7DRYrNqstyMRb8mmDuX3yi6JBRWv1w7fUscYBveGabxxAAR8Kh1sYZdmlNEQdMqbndhIWCc7kk+KivjWPaRc0hdxUvWiVlJTdVqOFFglz+Ej8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcmoD5Yl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcmoD5Yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E54C4CECD;
	Mon, 30 Sep 2024 20:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727727705;
	bh=pM8Xt8CTr7zzNt1vkDbQMLfPbOGvXf8TyJyr4dxXCbg=;
	h=From:To:Cc:Subject:Date:From;
	b=JcmoD5YldW37n4sfvY5d8wPh2MAnWJBYYArEbSE4gwRvh9Ktm3qfhXnNIAZYBKxIr
	 l0BW1NetMC8XZTYpO3HE/bpdqWos8BjqINMQ7MpExXVgQnQ3yzki+cAVht9pu9av1L
	 7IRCGTUL8ef+KKj5pX9NCpKa0A+wBWXqvV5gyvPWLsVaN4aMN2g0+jW0Y4yth4c0IQ
	 QO2ejCKCAprO9U/u7MVjMYCXthohfvX4o6E2WAvVd35S8XHhT7XvS0PwLL3ye/4k0L
	 /9CIj4GBOS227WhOnC1EJRcVimnucw0vRqrXNiazqC19V2xAsPFLF+KkTblMstOIsY
	 DUT3CgWtRtU0A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] check_headers.sh with hunk exceptions (lib/list_sort.c tools/ copy)
Date: Mon, 30 Sep 2024 17:21:34 -0300
Message-ID: <20240930202136.16904-1-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	Please take a look, as per tools/include/uapi/README we carry
copies of kernel files for various reasons and check when it drifts, in
this case we need another way to accept diffs while checking, its all
spelled out in the individual patches, please ack.

- Arnaldo

Arnaldo Carvalho de Melo (2):
  tools check_headers.sh: Add check variant that excludes some hunks
  perf tools: Cope with differences for lib/list_sort.c copy from the kernel

 .../check-header_ignore_hunks/lib/list_sort.c | 31 +++++++++++++++++++
 tools/perf/check-headers.sh                   | 29 ++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/check-header_ignore_hunks/lib/list_sort.c

-- 
2.46.0

