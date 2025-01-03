Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345F1FBEB9;
	Fri,  3 Jan 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922843; cv=none; b=tkObp90LMDZcknmOuI7K6Py44E8oayk7bPA6vHP61bU+6NSCQhd8zQTiB4Ah8wBA9SA8AVYh4LTYNy/1dEzORUtF5bCZrjLqXLeJM42wcVc4Hp9OoY1yQPd3UiTmZBC1NzdXxzcY35xHhGBg3XgQqppchJkI9a5akUuRbvTr/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922843; c=relaxed/simple;
	bh=zZ6v9tyYD2Ld7Lqki/hIdqnNh93BdhDNFVSHyMviMN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p8GwDwqLPGE6p9rbg5s7cnhZ/ONXQdYVbjd7XOxK7JqsKhGAONKcIsz1MpZq4cOXgJYc5APPOtmi9cJgHA7mGpAq6z5M3/M9af5kp45OCShbkeMdiSueGSvcFuqiyGNcn42RRmfGzR3WWHq2S5t+rmoVyXSKsHcWoluzo79zR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZngq0XY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZngq0XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301A4C4CECE;
	Fri,  3 Jan 2025 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735922842;
	bh=zZ6v9tyYD2Ld7Lqki/hIdqnNh93BdhDNFVSHyMviMN0=;
	h=Date:From:To:Cc:Subject:From;
	b=CZngq0XYxVGtUGC+juMwl5j/JhhKj/obyxLjmhvsLiZPenOZEfQiIcCywyO72J/5F
	 XZZDsjJvnCvoszl3dYVbwo1vdP9vao1VFvhTt5qY7DpCpFUDt7xeI9a0t320OVc1bu
	 zfoSWh94nKnBDsyaET+IlSi4XaazCmlXiKtzLfdx3Ed3HOegd5ZbyTMKFyORhnXzyN
	 82zmjM3EfLMqfk3gYX/hfDrl6+oc3JBZtttPbvuBLmpwc23WJg1A2ORCsaTIke6Sdm
	 /qHc+CYBNa3DMcw63N+kn1AGUHvRor6YgV9DnLAmKyB+RCDJPJ3TWyPCwqU/iLy9q1
	 wSiBHxGZxpwmw==
Date: Fri, 3 Jan 2025 13:47:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 perf-tools-next] perf top: Don't complain about lack of
 vmlinux when not resolving some kernel samples
Message-ID: <Z3gUl1guIXi4bU0a@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Recently we got a case where a kernel sample wasn't being resolved due
to a bug that was not setting the end address on kernel functions
implemented in assembly (see Link: tag), and then those were not being
found by machine__resolve() -> map__find_symbol().

So we ended up with:

  # perf top --stdio
  PerfTop: 0 irqs/s  kernel: 0%  exact: 0% lost: 0/0 drop: 0/0 [cycles/P]
  -----------------------------------------------------------------------

  Warning:
  A vmlinux file was not found.
  Kernel samples will not be resolved.
  ^Z
  [1]+  Stopped                 perf top --stdio
  #

But then resolving all other kernel symbols.

So just fixup the logic to only print that warning when there are no
symbols in the kernel map.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/Z3buKhcCsZi3_aGb@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 724a7938632126bf..ca3e8eca6610e851 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -809,7 +809,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 		 * invalid --vmlinux ;-)
 		 */
 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
-		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
+		    __map__is_kernel(al.map) && !map__has_symbols(al.map)) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
 
-- 
2.47.0

