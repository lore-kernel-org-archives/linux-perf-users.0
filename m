Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E12270EA2;
	Thu, 27 Feb 2025 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693304; cv=none; b=b7oxNuS/ghpQ9yaPEKN+xG3X3vqhrdSVP/fKB6HkX01NbSLIXD7ChlBVviiIO2mMKnjMuw5z6mchG9MiC5wdT5KaWz1b5R3WbGfVeVXBP5NtT9EgEp0yaB/ZYkd0UJFTavzhBWb7WXMhYApzOqYgc5Wo07ouvy/ZF+XYFJVGSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693304; c=relaxed/simple;
	bh=7k30N3O+zuwsgu9x2OZGN4QteAPXFvYEC1PSZpbqwew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cDl4bvoCGtVmufGcenp+6/X9bFstDjqeZsjFFR6O1mE8wY9vfFQ9fjT5KJXYp+KZr5LL6ZE9xl3AXWRd4a3aNUk3RDSmEbmOz3FWuE30EXv+9+nR6k13MgmUb9yH4SjJcGxBlfFwkd1iaFXK1ttx78MCDqkerGInMVXDqbv3mvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqy4c2tP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqy4c2tP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38410C4CEDD;
	Thu, 27 Feb 2025 21:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693304;
	bh=7k30N3O+zuwsgu9x2OZGN4QteAPXFvYEC1PSZpbqwew=;
	h=From:To:Cc:Subject:Date:From;
	b=uqy4c2tPqS3HwPtFMyBF1BzBjnCLOVpdBjqtiHceorIoK0S54dGZy+Am6Eqo8xN7k
	 Ahv4Cr67zJeDekqGWU1twtKvfwYtWQ0bXMvuqpxfD/E3N8qSrBE3sJ64t3YG/XC8sF
	 emOtRwDP7wQTlFGOdmQdVkjaz9jpXrpuhTCPMPCV+qP/zSDUy2xS3zq76NrtCzyXvv
	 iRaHPhdiq1OXTpLROmv+0Mr3kjXF4u1WidGHNPCOJdbZS90lqAbEj+8BFqgCoB77w5
	 R7Sw1UHVLirQK6gCL7EHr9nVxo3Z4rN4pQwtG6eopjEPMNnTcgwRArfDhv3VIQ4PKq
	 tslNnTKDAZyhA==
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
Subject: [PATCH 0/6] Fixups for kernel maps insertion
Date: Thu, 27 Feb 2025 18:54:49 -0300
Message-ID: <20250227215455.30514-1-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Namhyung,

	Here are the patches from the recent session on fixing the build
when DEBUG=1 is used, please take a look.

	I think that since there are no reported problems and ended up
being a sizeable series, we better apply it to perf-tools-next,

Best Regards,

- Arnaldo

Arnaldo Carvalho de Melo (3):
  perf maps: Introduce map__set_kmap() for kernel maps
  perf maps: Set the kmaps for newly created/added kernel maps
  perf maps: Add missing map__set_kmap() when replacing a kernel map

Namhyung Kim (3):
  perf machine: Fixup kernel maps ends after adding extra maps
  perf maps: Fixup maps_by_name when modifying maps_by_address
  perf machine: Fix insertion of PERF_RECORD_KSYMBOL related kernel maps

 tools/perf/util/machine.c |  6 ++--
 tools/perf/util/maps.c    | 58 +++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 12 deletions(-)

-- 
2.47.0

