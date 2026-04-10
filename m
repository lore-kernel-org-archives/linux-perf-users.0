Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7621ADB7;
	Fri, 10 Apr 2026 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858961; cv=none; b=jWbe4bnNJ//P1vbDBNQSnMd6t6ikTTNkmiPHaxRaxWc6XjK1t5lhhVbUVtsffvUvufsTo+Oo8ksmtEMG5FbQ+ej6Y0jT5Pl0qP8Wxo1w/+IpIdy2xfGMKwkjWxm0q25yKFgkCt/3dPvp1v6sv3O9mwwEC7eDXf88kegR7Lohdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858961; c=relaxed/simple;
	bh=lIJO53dz/dU74xR+TJ0mkJip/iMvG3Hy7+2H1fVOxzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeBmUJk1PvDdzqUtIgMjZTDJXL0UBqktiWW3Z1zrXqiutcblH3IjoHN9NJypbrBGdphdvdUavkpnkNHg0EH2j5p60SPQVVnNkL5hp12AAiM3MnKYWMDrXqln1I0UIwi8MSd4PX7rS+QN8GWlowP3wawh6FRiCHCVGmH1Dhxd53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVf8CLci; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVf8CLci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E49C2BC87;
	Fri, 10 Apr 2026 22:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858961;
	bh=lIJO53dz/dU74xR+TJ0mkJip/iMvG3Hy7+2H1fVOxzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVf8CLciAUd+wd7XnXOrWsk+kOj1R51UnVFifVfeoOtZHdnHpdqT5hJgfbA2QTTQT
	 +Pz4H/bpuNQkQFw4vjMQA4AqIYydSpOdFRvWxnNI+hSdoQ0gPxIIVOd5sqqmAvUdKb
	 8IxYEke/blAJw3X2SZQcRhwkMRkSyHQy1YcFzuyn7VKzQpeiOJ66SUXmblVYUPnDQ8
	 J/WMam+0UTkh321GXRb4AfYicKemJj7jPr2WIU9KSNvlzFbO9V0dSTKL5x3gQWBz6q
	 Uf3PqvwzoqTriKwESbgzgnWc9KQlE1sdIrfQ/cTguOgaGT0/x1DOpaRjp/6tsYt8sY
	 MgaCzKL31QDAA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/13] perf header: Validate nr_domains when reading HEADER_CPU_DOMAIN_INFO
Date: Fri, 10 Apr 2026 19:08:53 -0300
Message-ID: <20260410220905.200051-2-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>
References: <20260410220905.200051-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Further validate the HEADER_CPU_DOMAIN_INFO fields, this time checking
the nr_domains field.

Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c6efddb70aee2904..a2796b72adc4d908 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3731,6 +3731,12 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 		if (do_read_u32(ff, &nr_domains))
 			return -1;
 
+		if (nr_domains > max_sched_domains) {
+			pr_err("Invalid HEADER_CPU_DOMAIN_INFO: nr_domains %u > max_sched_domains (%u)\n",
+			       nr_domains, max_sched_domains);
+			return -1;
+		}
+
 		cd_map[cpu]->nr_domains = nr_domains;
 
 		cd_map[cpu]->domains = calloc(max_sched_domains, sizeof(*d_info));
-- 
2.53.0

